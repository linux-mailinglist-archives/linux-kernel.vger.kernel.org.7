Return-Path: <linux-kernel+bounces-754474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD192B194AB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 19:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 881D618920DA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 17:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8A81D7E31;
	Sun,  3 Aug 2025 17:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSDB/Nm/"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB7E639;
	Sun,  3 Aug 2025 17:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754243265; cv=none; b=Go5PiHJmg1iRS8OVxw0wG0D1+dkQLiVyY/G+uaOjPqEd1ZKaRCNbQoa8upzB+jjaDBh1Ua1ZkVtSsuBI0Aif1n91JPRi3m7x9kYGlxQ0iqjssSmD6YdEymQ60ZHOAUOU2NFWCurM5+Dkyr2fuDG24vdv1v5ekKnqMO3DD6IT7hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754243265; c=relaxed/simple;
	bh=INc8jwySb85s9FG8YbSNZOht10yjBA1GrvVOEGBzRnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nfu2iqTMCTe2LuG5OHgJGnlVNlHWGwGMKpf/wOq7nHHXMnPlZb9DWuf32n3FGTDSJGbDwD6EOMJZ4rggPXekPLBfJw8Ugj6jZNGbmRe7mvOD1/5rMaq+N0jih6l00JukRE4WfamOrcqBSQxYN4hvbFp1ZQcbO2s8aa/e/vAjs7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSDB/Nm/; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2420c9e3445so5662795ad.2;
        Sun, 03 Aug 2025 10:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754243263; x=1754848063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INc8jwySb85s9FG8YbSNZOht10yjBA1GrvVOEGBzRnM=;
        b=fSDB/Nm/ccTRcALW1RYJpmI4FRwcVC3Py2HRIAqFUIf5J8vEbb2hKDWfGAcJAeuIat
         fmIuY+REZ0ky2fEjr1YOpC+gzFphV/ucVp+8YNy/nJCOEGzXkP6OJsIqd6bCpo3eq7W8
         ElbSOtiUVlpEKYWCFHB4pwXVEcdZepQeVkXbdWeAdDEdboINR94bC9/27oTxX3iEE6mP
         8caYWeYDfq4CZCL43Wg5TtCmMyY+IyH8KiyVdZ6IwrkfdI1whOLv31rxKfDKT3FV5OcQ
         vNBSdW3BI+tBiSG6Lb/gPru280BGoLr7GNaDiI7z5fpXYRm/CHXNEyNH94W9Y/RikIrD
         5pBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754243263; x=1754848063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=INc8jwySb85s9FG8YbSNZOht10yjBA1GrvVOEGBzRnM=;
        b=QEsBn2ep9WAqxAJbHbYShIt9KAfINQaz8RNJ7Xc2pnkT6esIs2dXdjC7Ql2xZq6yYj
         t7mmk9wpwUzDolHH83564ki1FvMDh7BbjIx3H7hIdCT67qqsLgMeo0Rr2U2A6XbwuSoS
         XvgzDb5o2Pwd07zQA7i77BdbrkXe69v4574szLOR9NWk3hUF0XEPON9dt1Lp+akEXjQC
         nLS3LONJtQJ0Tt/Cgek56FTtjAZmfXVZ7R1G/VZhiBJ3nY4gDCGe0rRdvDqCjIOcQIA4
         uQNr6XFFCAeBkIeHGQP78LcfOn7hyq6jJbmvslWCodofS3YzF9ZLCU11guOQyEXQ36sl
         aWsA==
X-Forwarded-Encrypted: i=1; AJvYcCUrrC49ypXopYME4Phvt4JXgrnfUJUftpYhxR1BrvnMZp5ZtNjqGFGA7bWMkQfsPR+PEOMrxc6ah+NY78ikvSI=@vger.kernel.org, AJvYcCVsNps2oGjIkiGkxV9zm7y6gQ36PH9cNrSBzz0lp1v+kr/cy4+xDWUSXYmJ7DgGXl6u73qE6yrtuExeUDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxwYKZ4rQQmoK17yMUfLaBeDcYz5KMTYCoLlmU3/Ume+YA6yOI
	ttbpftlkdJataOT42/gvYW/zPD+7nfghlYUvFFbCCkgZI3hTs1jV1ELkAaL+K8kqp+WRCMcP+fS
	tzZTCxXD24/1MvrwTfEXbk0lTZmYRQwk=
X-Gm-Gg: ASbGncs6TgnZe7PdYOoPEIQLfjB8ndRKvK9q+/Ikv4hDKVqgNPK4daVSk5okkman/3Q
	6krqzqueBHJrzFd3Ts6SS69NL7wMuH982NDAB8jfxU1Ix0oXIaW2oHj/JpT+UyvN7Eztp4ZHSfz
	PbcR9bSIaxhTGtNkOR4g35G354E4zFAZdS9SObmFWswqvJylmyDNafniLVIxdBI4wubJ8/9t0GH
	4POCQ+V
X-Google-Smtp-Source: AGHT+IGpA6bMml6aI6asSNOMZ0PYb7tB/+AWc8+rMWoKgSlOU/yKw34MED/OEpA0LXsIquK2ze2crfDVWsjIZnmMpQo=
X-Received: by 2002:a17:902:d4cb:b0:240:2bc6:8ac4 with SMTP id
 d9443c01a7336-24246f2d8a6mr43575605ad.1.1754243262965; Sun, 03 Aug 2025
 10:47:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+TpbOLLATyTRtNxVEJ9Dz6=YSZHAyYOrt20TR8AAEfP+qm1Qw@mail.gmail.com>
In-Reply-To: <CA+TpbOLLATyTRtNxVEJ9Dz6=YSZHAyYOrt20TR8AAEfP+qm1Qw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 3 Aug 2025 19:47:31 +0200
X-Gm-Features: Ac12FXxvqk2B4RSfsmnYWEzhJE3taK4KOdhlfPJX-EpyQQwslBWDUI4NnxG3LVI
Message-ID: <CANiq72nuX7_b54yNVC8ksTsxd3baCqGoPFywLBaMsqLdNDYMew@mail.gmail.com>
Subject: Re: [PATCH] rust: kernel: add missing safety comments
To: Jinheng LI <ahengljh@gmail.com>
Cc: ojeda@kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 3, 2025 at 7:10=E2=80=AFPM Jinheng LI <ahengljh@gmail.com> wrot=
e:
>
> Signed-off-by: Jinheng Li <ahengljh@gmail.com>

By the way, one more tag:

Link: https://github.com/Rust-for-Linux/linux/issues/351

Cheers,
Miguel

