Return-Path: <linux-kernel+bounces-844484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE21BC209E
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 18:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 022E34EA6D9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 16:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52862E62C5;
	Tue,  7 Oct 2025 16:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUTue0ek"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9503C2E0
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 16:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759853268; cv=none; b=KtAZl0+vJ1Zn+lBD6r6TeYlQwVCT1m3OirvKBymvZazwMW8g5LdyeWnzH87bI8WYFxI8iiezNnpKAYmX+Xzv5PI6d83R1pKjuk35rsL/zmzax5m4+7+wpTluQjx58kDG5m270Ppu9sK4xH8RT2YaggdLGEYbyexLd4GHUjbelV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759853268; c=relaxed/simple;
	bh=n6D0HttFUGaZYPc8LF1Jq4ztKp/Jw8ZhioBsSuc9WYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ANmMayiFYh8fPX3P9PQnjYS57ZwWcModzPGRqeK9hMHqdUNKRhzsGCs718eI5j362lz1vidl9SytR9nxXr8qG2WVm0p1nKiUkc+W2wI//eqr9Xr4VSS47VjRu2GtgV+WcSUFuFVqBIg3rmHv9umtpMdnLIL5sZXAkpXV8vlwc+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUTue0ek; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-267fa729a63so11576545ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 09:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759853266; x=1760458066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6D0HttFUGaZYPc8LF1Jq4ztKp/Jw8ZhioBsSuc9WYo=;
        b=SUTue0ekWLgvDdeN/2wXZwzZmmukvr9SdrKw++nzmBSsvW1ccaMLa7cFFZ6eLeQGzi
         BXcJoEHKxWqZkO9nB5llmmZ0V09IuMuN/CK9nGiYQ4NXyLt4X1yBpIeS0XYtvYCjO9nu
         JO2z52isBmWRMcwTYHxCjaxsERHC/kDmqnaKnac+nplpe2m9Gi98U6hzw/B6Swb+SnX/
         zP0OMRPvrVkeZOa2hPwRw72BsGBtdCv/VXomBK9/mnkQt7VCNIc01s11YRyd7zol6TTa
         YbkmEx1wt1hqmzFyaA3QAlCnpH2EA52JuR/zmzi9SdppRytsywefTqct4Jtq+2F7dx7G
         KcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759853266; x=1760458066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n6D0HttFUGaZYPc8LF1Jq4ztKp/Jw8ZhioBsSuc9WYo=;
        b=YRHHXK/aw0kwnvqyvlZ3kIEAvUjiYE3JjsY+ICIwRc54nddx1m51ZwzkYgKCJbB6MG
         wLlT1zxl29Iekh6m8OS5z/Lj7AtIWFEyXHv1Xf3RZYqF8vyNcdhoY1m8iYfPUChbxoQd
         sFZnLjdW9qumJ3wAHDrpNKxR7JEA/dAtTlNNONF39Prxwiu8hqbryOo6fv+dtY6kM9Y+
         gfnUNm5bXhTR+pl6x2Tk5oMB2zQqjxfSm6fV2mx7J/Dw8E2xUfo30e83NbIRoEA7UR24
         h+4G302vd+YwuT/WNDB5wj1fAYbZGKlO9xmpqmAgBTuTIGjWFGkMlMaY3cOGevv+F7p9
         YMoA==
X-Forwarded-Encrypted: i=1; AJvYcCUOdvaRq9448yVwM3LZRUQ6sRx/lI2//ieYjayyp/FHnkIkjHj5ivPtG+GlsslaWLM+yJfsAdH//Ehbfjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLF5/RXNC1LDKLEKdUWaeff3uZxLo2fMjJ5mlEq/1jRwfrBbGj
	HBzxmnIoqKAA1xacahdkGK1hQHJDsYNEhJw98Aiq26vtoD1fVx0+mCzoOv38lg7Y3bF01KGR2/E
	C5A+4iMdXH9T79kwqgfk7ke7tBRl+PMA=
X-Gm-Gg: ASbGncu+Dr7RdRPqxEa5HJm8XlCfmKM2qfopUKr0/NH+2FHo3kfSIKaFviCiWRBJ4F4
	M7gC+h99RKKVSEK6c16iLjqy8XrBtXWRKlw3lmD8KSkhC891d+FEE9dT2nUIKJn8hxCuEjDHT4b
	vaRlqtAQyq7QR+t9XemeIaR8oLFuH0exeTzYOV/leUE38cxNvO1G0tXkWkVOSfEhF236t6PpxEb
	bbbP1h4g0b+X1ernFztJJo8Z/wAHYTpiNKTQtQpYhcNqBK47PvkO63uellB3a24crwrSfetkWrn
	dnI+OndkGoVsSwIF0aJ/wgqj2w7KDSW87AuOjJFEMZgtjb9dOQ==
X-Google-Smtp-Source: AGHT+IGX4ATOk5qSa8XF/bg1OcR5jFMRICbWFQN+A1pMdW/F3v4buQSOfTjk2+k+HDH6mOFR6gB0rg0At/1zxoq01Dk=
X-Received: by 2002:a17:902:c404:b0:277:c230:bfca with SMTP id
 d9443c01a7336-290273e17bfmr1866875ad.4.1759853266156; Tue, 07 Oct 2025
 09:07:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006-kbuild-hostprogs-werror-fix-v1-1-23cf1ffced5c@kernel.org>
 <CANiq72kZjOwSerDEM517uEVffGYzUhm2Pb+1z=7hboJKuQwBMw@mail.gmail.com>
In-Reply-To: <CANiq72kZjOwSerDEM517uEVffGYzUhm2Pb+1z=7hboJKuQwBMw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 7 Oct 2025 18:07:31 +0200
X-Gm-Features: AS18NWB6sGzobQ6f4uXKXrsdQJYWSp7CxwQc1XjTOn9pRZfgDjPT-w87-63-PdU
Message-ID: <CANiq72kphV5cUwqFT0c=CQdYaeC2EKr=oL703NVyCNRVnbc7=Q@mail.gmail.com>
Subject: Re: [PATCH] scripts/Makefile.extrawarn: Respect CONFIG_WERROR / W=e
 for hostprogs
To: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nicolas.schier@linux.dev>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Askar Safin <safinaskar@gmail.com>, Sam James <sam@gentoo.org>, Miguel Ojeda <ojeda@kernel.org>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 6:00=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Acked-by: Miguel Ojeda <ojeda@kernel.org>

I also tested that for Rust hostprogs it now respects `WERROR` and
`W=3De` as expected:

Tested-by: Miguel Ojeda <ojeda@kernel.org> # Rust

Thanks!

Cheers,
Miguel

