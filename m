Return-Path: <linux-kernel+bounces-858049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B23CCBE8AE0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FFB81AA4246
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B2E33032A;
	Fri, 17 Oct 2025 12:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFJbO20H"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4B633031E
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 12:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760705943; cv=none; b=dbCpgdUoxRNXFOP0Db86ZMa0Da9dqM3ete423DbG9l4E7K7jQy8qca2AfY2gbjS712sl+jovBJpFB1VrvkU7xbnqNRc9cLcLlOxRyYIa4f/8IqZEEdV8o+pxYO6dlBKv8kVsACSgJI+vaUc8J3i09gGq5DfzHt8Ziii8U2bL/lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760705943; c=relaxed/simple;
	bh=wdaJhDzF6IgB9mm5dFvdvIAv0KyueRmfgU2WdqlbxQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oZhu/uIBfbxkAOD/lEBamg9NecEXTjR+8c930feCf8hTBApSu5uvECK/0sN51hx5ZS7iAhsXfyTwE7XW84gQIcdWYL7y1v2jv9f9wQysE33uNuC7f3vBVGEy8Rx6LwHEMXApBkoNs9w2M86JyOVL6FUA2+A5Biuet40PD/k/8yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFJbO20H; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-290af0e154fso2735455ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 05:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760705942; x=1761310742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+GDXTh9IMAF6qAKXPQhRIMU73VsMP3gkKTvitOd0vY=;
        b=BFJbO20HQ7l6DSTTITwtnAtzI3mOtExQvfwwekOsjrMBxCmQ7YcD0SPQZ5ihBj2hRg
         SzEU3aEcmJ7bGUGhPgW4586JDvQzaf57bzUHtGMzM88aYa5mHzA47qOKwoYnuY42REAH
         JrxIfWT/r+TlpPr3+uM/CijeDcXxVHf/v7k1LFF3OpEPbzhHiicMJbNWa8l2nwv5F8DJ
         ckUKcSYSBfiw4axRRABb8dokP/QjXRzK+ogbuwri/IK+xVBAT7QLHKowepVM2Mrs6LOG
         N8D4AFBrfzPKlvX/APrgeh5DPPfESwQx5HpuUnE3Ii6Cco+I5+jLhLpWMxYHaiy1cWN5
         KdWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760705942; x=1761310742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+GDXTh9IMAF6qAKXPQhRIMU73VsMP3gkKTvitOd0vY=;
        b=TpqwVekX9WOl+XXaydrXrogK0sJ61v6X1deq9DBWWUyE2CG4uy9eEu23qjQ2lTSWW2
         Lx1DmulkWSavI+81UAWRWRY9DBC+sYi/ohMpj1EX39jBN3pfuKDJDmkfl7zemmq6XFKv
         40iTQyArSN3K+xYzXI8kumWJ5dgldunTAnIQCOC/J+dTImHYUG3a9TB+De/0nA+2vqT3
         sKWaVaXMopLcIUYQ70g3EF7l/j+TnAW5RznGfTmFaOSxlhrA6DNsZNjHq3WC7OxcBmmQ
         0v4d4RLGbvHdq1xW1+FCBrl7AIA7Nu8Xs5k4ETjuPF2g4nyJuLNCmWI4u6JrM9TlyB6Z
         NfUA==
X-Forwarded-Encrypted: i=1; AJvYcCXdzdypKhBGGMjBajb/RdR/kuppNAZcUGlS1vshq6x1e/SsHg5GUULTsRFzFQqMFjUvxCqZHa2fDIVw9EU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVCi/048yMWbUv+9z41EWZE7eVFXFnKluo51mxqodz2Mplbpdx
	uEfcoEX2MKu3axKVDDIxkNX/e2pVIN61qawXFkXReyUYVlvxvq+11gZh+Fd+PpVPLf8AqC268qz
	7dY5bOsDSDkNXSsKGQACgxdps5WfbHhg=
X-Gm-Gg: ASbGncvE+bo5eDFh8beq+M1nLbQiROs5tlRFhsLa8kePHVN9P5O+36s8Kh4XvbeKwiH
	3Jh29HRdox/VmaAVxBFplg6m5CL3j7MzJfL+R9kANON7Al2IkW+Aou08ppg+TaB7l/8gdpl9byV
	d5vvoGLDAuw2pXxqcRSsrIZICU7TeE7MQ6us/XmCv+TiQqdFrchCOZdFQp8J4SvxORJwaQy+jh8
	iROwMlLLejo6GwPU8dKdpThE9hhCbZ6uH9lYpP5JADznHxmhVuG1TJk1nT8PyBKnmGK7GgfV3p9
	y47/K6kFj+CCV0+84PXwnocBK7kIZgULEG4Yj7uboxtdY8c37o4jGsgW27fkIXhAjmYnf7lauGq
	Kn0ay4kmkhe97Fg==
X-Google-Smtp-Source: AGHT+IG0yVbVz6PU15YPk58/aiGkrTO/zzRW/ADndnvIRt9TdYJL8oeNwG1bAj3uxBZfIAJqiq89SaYPkqDhXWV/OQ8=
X-Received: by 2002:a17:903:2f87:b0:290:af0d:9381 with SMTP id
 d9443c01a7336-290cba4effcmr23294985ad.7.1760705941669; Fri, 17 Oct 2025
 05:59:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016211740.653599-1-lossin@kernel.org> <CANiq72k8KmpFyKAFZ293GDUWx5=HJtksR02hTU8-H9PX7xsT+g@mail.gmail.com>
 <DDK2SA1D77HM.38KOTOTF8FJXI@kernel.org>
In-Reply-To: <DDK2SA1D77HM.38KOTOTF8FJXI@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 17 Oct 2025 14:58:49 +0200
X-Gm-Features: AS18NWBRgxavDUIsOONY5KxXV3HbEeszryCEDttHSa4OIqY71guXK1X9kJ5nosA
Message-ID: <CANiq72=Qh9sJLKwACr_McnbGdu8JfzqDuv1AgCjSdwKtt-9Gdw@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: pin-init: fix broken rust doc link
To: Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Fiona Behrens <me@kloenk.dev>, 
	Alban Kurti <kurti@invicto.ai>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Guillaume Gomez <guillaume1.gomez@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 11:47=E2=80=AFPM Benno Lossin <lossin@kernel.org> w=
rote:
>
> Thanks a lot for the added context! I will add it when applying. The
> `__pinned_drop!` macro will be gone with the syn patches this cycle, so
> in this case, we don't care what the resolution will be.

In the end, it wasn't intentional, so Guillaume created this PR:

    https://github.com/rust-lang/rust/pull/147809

Thus 1.92 may end up without this change in behavior.

Guillaume and I also discussed the possibility of checking these
things nevertheless (i.e. without needing a second pass) as well as
the related topic of having a runtime solution for toggling
private/hidden items (and thus getting them checked too). We could
perhaps try a custom thing in rust.docs.kernel.org to see how it looks
and if people like it.

Cheers,
Miguel

