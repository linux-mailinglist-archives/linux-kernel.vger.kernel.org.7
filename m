Return-Path: <linux-kernel+bounces-749886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D6EB1544C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 22:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 484133A5CEC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 20:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5091E253B64;
	Tue, 29 Jul 2025 20:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOfjm+aS"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67733220F32;
	Tue, 29 Jul 2025 20:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753820610; cv=none; b=SO/+kBs/I9+E/00EaW1K3NUbcpO6OftEMlRsx3W9ctEQfrgTYMs/KjwO0NZ2I2ML1ccwn9q/b5hDI7X4Wj4PnwEd95IAj+afOtTNSxExh4KjNnClpGBpYy4RFlv8i79r7rLXul/r8cEBbBRnhwIMJiSBLatpn/+toxAuZoNMfXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753820610; c=relaxed/simple;
	bh=oROE60FTv9CzNmU63wnL0fiWj/I7s4rf/vwjAaVuOuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qbyUyeXdGxjV6BPMz41J9jacVomv23TjTlJ78pOW+1j1vbwsM4hWaGx6qOzu2bLAKr+8zx1jxGZ92qpzvY8qezVbQepWaoZu87RfGfIG/KFCnRxT03L6W4EkNoRoovzMf46Mo7DdSYbvcDAUnKVqcUhF+luICgevxmJnAv+Iqb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOfjm+aS; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23ff92d05acso3924885ad.0;
        Tue, 29 Jul 2025 13:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753820608; x=1754425408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oROE60FTv9CzNmU63wnL0fiWj/I7s4rf/vwjAaVuOuA=;
        b=iOfjm+aSeuNyfn/0ZJXQ/rOiqk4NAkIFFyx2FewYOr05CSP9Il1S6KTKW6feUtR1Gx
         8OLCzv15CVlOjFVcMZBSMGbkxSuqO0qGnNm+Wib7nxm7j6FCN0WMHVt2gV9t8noRGaVB
         CPRZnHyP8wDGukUQC8GVgixMV4oe3vj3YSzuL19DtYZKl6pL6aLcgVxL+MvRk+ZjJNjg
         dNO63TpkDTvdW30Kv2F8RDUwXW7Wr1Blv8+9sDij/AcoTkXi2q0lVrfcW+iyrcu67qKp
         fFFbG6s+w3+L8j/LApokewFd55E1QvILN+qs5+kOorShG2kCtNNVyJcUyjYlU1MCukU+
         0rjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753820608; x=1754425408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oROE60FTv9CzNmU63wnL0fiWj/I7s4rf/vwjAaVuOuA=;
        b=nvrHZdv0/7HeLXjj5HUyQWpQv/x5Ve02KJ+uGak7CT2VZKnuyZxY7axYntC8THtlUb
         s6si5/oXXGzJJYr/C9tBw+GVWdO6kBFsfNZ2TExMOOGMyK0uRvrlcIzp9OqzHyO0I4nR
         UWGexS6fXw5sNdOS2x9JAQMvgT1IdN+Id6/267owNEpNHMJGNEeG4IWbGdFGhj+zPhQM
         jIKhafSAwDcQHw3Tan+ZFAOoR0+l6+/pdVnB50QkueXvaGRUIO/gnyEu2S9ZNtTzvECz
         4xivZ0M8JVUlzqna6fEZmQuisMNAwqTBQN4usruLDQ5g+b9Fy2qnzoT9UkUwC7X1WLO+
         ZrKg==
X-Forwarded-Encrypted: i=1; AJvYcCWTgrxQmyUUDXfFv3cHbHDXpIJQxFjbiGzVbdJ523QJyzoy/OuPBnwsuGEFIJ+EvPP3BrN/Vv1YTF2cB6U3Nd8=@vger.kernel.org, AJvYcCXlpv2TzXV/7NI3WJWlRGrxPdDij+55R6w3rCa2NHUEJTjwp/fYQley235JC+rt7kpLmpXj0T76PsJPnio=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy61BTKw0A5yGj1SvO1lfrytx4Y1YrdX+z8ZJTIAssv8/0jCwh7
	mLhUCNJUANasXO5BTgbkhwUiGiaBJcJ+oxENMUZMPyKr6WiI/ir0GlsdNxa7nPEgzF3jym3O8oj
	jhWFPIMOyVd0DTf/yIAmcoe9tvLvwnFA=
X-Gm-Gg: ASbGncvFUtYyuPwJz4tSMC9wdkmqhmjHY6+CUH0IOgFXiTL4kk+kY31RG6gLXVeb6Nl
	L1xHuD3b7A4lkBb0Go1bmtSxWk+RsMrvReUO7pONfgLGQwQHV7+C/GNkWpdbB1yZ6lW6V6o9viF
	S+/tgZpqUaUX7D/fB1vEoMpEEslYBHTgvx3r6olfnydTKEcsEHfC6WULgfPa6ip4787gewSxwaQ
	cShUz5f
X-Google-Smtp-Source: AGHT+IH02al2N3FD8umjHU9Ue4wb8E/QxGcrhRRFHDrzgQhZ7H9tu2I4ulyWOOadbz5Po/Gve9OXcDmvVU+65v4mvvg=
X-Received: by 2002:a17:903:32d0:b0:240:764e:afab with SMTP id
 d9443c01a7336-24096a7d038mr4166925ad.6.1753820608447; Tue, 29 Jul 2025
 13:23:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729195615.34707-1-contact@arnaud-lcm.com>
In-Reply-To: <20250729195615.34707-1-contact@arnaud-lcm.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 29 Jul 2025 22:23:16 +0200
X-Gm-Features: Ac12FXzvHjL5H5O-hYxy30njasjWFGkIqYPWaIgz9uZRZGCFqhPyYhsP63g2j28
Message-ID: <CANiq72=8AYUX5Xv-QE5mrPhDLtY2Zg2C2_ah48tJHCbObAg95Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] checkpatch.pl: Add warning for // comments on private
 Rust items
To: Arnaud Lecomte <contact@arnaud-lcm.com>
Cc: joe@perches.com, apw@canonical.com, dwaipayanray1@gmail.com, 
	lukas.bulwahn@gmail.com, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, dakr@kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 9:56=E2=80=AFPM Arnaud Lecomte <contact@arnaud-lcm.=
com> wrote:
>
> Background

I think you meant to send a cover letter here (i.e. patch zero, rather
than 1) -- you can generate one e.g. with `git format-patch
--cover-letter`.

(No need to resend just for this -- I would wait for some reviews or
comments from maintainers)

Thanks!

Cheers,
Miguel

