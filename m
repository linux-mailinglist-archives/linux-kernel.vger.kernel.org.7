Return-Path: <linux-kernel+bounces-765549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D185BB239D5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 22:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2A0C6210BD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 20:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FFD8F40;
	Tue, 12 Aug 2025 20:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Milj+E8n"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D322F0677;
	Tue, 12 Aug 2025 20:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755029548; cv=none; b=eT2x9xualhCNKsbDVI8vf3619Q5F07F2bsSaDKvLlMpqyl3gRCxwyAIB3W1v4kDRyuaUZo/R6E0A+cppxvaA0iGYY5H+q75X22J2BXGUsRsoyS75ErUPhBH2zYVE1bHH2dhPxVNkCiau2Ub6OL9ktDEGH8VTGtYVF05rQspfHjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755029548; c=relaxed/simple;
	bh=LdMwsRNMhr3RdlfS1sg03g0GGfVON6z2LjlOFlQzz/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rANcK3V19hmdw69oscpmaFQDE704DCjA9mcitIKH6vyyly5GH7zB/mUcLeNaKa45qVHHmtnH0VFID6bdaFwN4RYu/voCa7TS+12rdHXJAvqSMuBNf+rKihmYxDpy5rkmDmrqCkIu+AY3ZaS+kfVUlSozLnigPgqQhA7j8y32BxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Milj+E8n; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2400a0c3cf7so8617795ad.0;
        Tue, 12 Aug 2025 13:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755029546; x=1755634346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdMwsRNMhr3RdlfS1sg03g0GGfVON6z2LjlOFlQzz/w=;
        b=Milj+E8nHCciOlpaDB93QQ19DTfku/+qrq9m+0m325gO/k2zzqU9bMu2Z43FruExxb
         xQo7NOxMc9aFgwqE/F/nShVFLKJ89yP/gRKeZQvDk0B8BAXLhArK0fjXovo3PQr2coEv
         8R0Bd967hG2Bvahp2Vo+qlAsauLmTrnu9qZ998sXFhuh58Rd6zvNh+6mNdd8AQX/MkIS
         wv/U5YOwkyyXfelljdC5d3MITpa4sQ8E9fmxW2WTwbwy4xgMLCQjn8tUES3NcdkfRu+k
         NfVQrL/HWyThj2YWmaaB5onZWKgaSzgcjGjz0CeOKojMzp1iypy1QkrZSDWwOLXInNwW
         FrWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755029546; x=1755634346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdMwsRNMhr3RdlfS1sg03g0GGfVON6z2LjlOFlQzz/w=;
        b=FgK3dcBI8z43l8svrQy+H8dtzik83zcIrVMKH7FnZkNsTYYfekkRjoeNvpRWR2TjNF
         FCAXzvTYA10h+BKOAwT1jttyigw0j07EWvj3oqh/tkWW/b+KVXGO1h6hEMjLNYUkAKUz
         FOrlPHfXuDsRunImgK8z93hZt3xjksg+N+d8gl5mOALbTsxj8ZrmBH4j76O7cWKu7SJ7
         +j0fntlYloHvh8G6SpsMz6kDMbuSPFwY+1e0PG3EplHDQD2xjQgkvQ+lmgamb7pODdJa
         uFB0pEIOJljvGbvLVGROz+mP322BtVTO9xe/dZiargD3NOlSW8LeqdpUQm+PAPq9cbi5
         g2Qw==
X-Forwarded-Encrypted: i=1; AJvYcCULN/ajsu/JnYHHbqK7rqXqbr1W01Af/INEcP5xNHMNNJFuyxulXvhYFveJpVZWz+fXEQPqvx8LGL4AgSlua/s=@vger.kernel.org, AJvYcCUVlrDQOd7Vr+JYTNIo506siprBPiVuwcScuzOMPoue8mMcz3RsUU+pa6kTVkYhmdpzsEeK39A8mLTh86w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjJR67Rx/7scp3g8OtHLW+ml+6fffgFOvG8qxOaqsBi6eUYejX
	bk7+4gsK9zyhUrwe/07qA1Ml8STAFC/esTnaNYM/4DE7lPa9hI4BpaJ72itdSIpZ7/XOHVsDGLg
	2vcgcn0j8vPqiZra4D2QAYxhT9a7Ss6Q=
X-Gm-Gg: ASbGnctcLipf+PQ2XI4H5oPvEWV6z7GWJaboGIXp56lzsQfUZ4rrQRGK75Px1lBdCIe
	lw+t4bMM9U2RmPS1gUaMQ/3XJeq2ojqpWEz0UcTU+wU1HzPfStr+Jz/ZT5olgCazVWj/kIG5ust
	0CHkhDKKRNPnBVPm7uK7H6+PAemS5EBm4rCWzIcD9FsfnQ3o4xldx/9SCLdmUYLz853cZ3xPsAD
	zaepbjzSwfY4Ig1NYk=
X-Google-Smtp-Source: AGHT+IEvmTEfhYgDEcmoTdFN/im+6O1T6OckAAjt4c2JWcP23ebcCH33w4iQbi5CmkutIrqX+H/I09EqUXavPgjNsec=
X-Received: by 2002:a17:902:d2d0:b0:240:25f3:5be9 with SMTP id
 d9443c01a7336-2430d263d94mr3422375ad.10.1755029546192; Tue, 12 Aug 2025
 13:12:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731154919.4132-1-dakr@kernel.org> <20250731154919.4132-2-dakr@kernel.org>
 <CANiq72mWVmso1yMYGYih-NDwjB9E1iVE=_oSpPiSvqTu5mkE0g@mail.gmail.com> <DC0PSDBCPGVO.38EGYXRFQVM8N@kernel.org>
In-Reply-To: <DC0PSDBCPGVO.38EGYXRFQVM8N@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 12 Aug 2025 22:12:13 +0200
X-Gm-Features: Ac12FXx3JqohsxItEiz0vXv8AeDOYSWVWda9zJanptt2JqBNAGTufcd5lRCQvPQ
Message-ID: <CANiq72nfpecn3qQqNJiXGDX_Veg1Q9yQF0BZzCk68Ue_i3qtVg@mail.gmail.com>
Subject: Re: [PATCH 1/4] rust: alloc: replace aligned_size() with Kmalloc::aligned_layout()
To: Danilo Krummrich <dakr@kernel.org>
Cc: lorenzo.stoakes@oracle.com, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	urezki@gmail.com, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 10:00=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> I don't think so, it just lead to pad to the alignment for Vmalloc too.
>
> Technically, this makes no difference, since Vmalloc is always PAGE_SIZE =
aligned
> and the size always a multiple of PAGE_SIZE.

Got it, thanks for the quick reply! Then I guess we could have skipped
the Fixes in this one, but it is not a big deal and as usual it
depends on how one defines "fix".

Cheers,
Miguel

