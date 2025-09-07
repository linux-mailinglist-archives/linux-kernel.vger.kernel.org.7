Return-Path: <linux-kernel+bounces-804862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8982AB48107
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 00:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88949189B3C7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 22:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B65E2253A0;
	Sun,  7 Sep 2025 22:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9DKlGfe"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5877120F08E;
	Sun,  7 Sep 2025 22:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757284130; cv=none; b=Rp4YvMEsYholotQwj9kt7feB/95yX31aAoqv1GMEB1V8q4O1YDVVyTQdpCy+SCRiFbocVVdH0E7rVfu+AUxF61JrKUOs1hxLqIEhVooJjzfY4f547bZipzN8/jB4fCo8YsnrawyYMRhT68SHI8dbN3VM+2UCRf/+ijRZyB85yUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757284130; c=relaxed/simple;
	bh=Jdyp87VeYRanIqFmUw6vy7xC6GuBA2UsO0EJfl07arA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AW8JjboZf5Vu3UgpJoM9NXpkm8DLY7LZKmhrF1+THCoh2LoSD6rEhuT/kvmZsqTIuJNEcpE5Hzg1/0jl+NClpzCr7kGWTVYlARc9O0lundjy85hXqRsd6l5J8kHIYOsCMB+mC+DXcEHqzrRiuQsPZ7Jhj9yqr6+mLB6pVRAruEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9DKlGfe; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24b157ba91bso9253985ad.3;
        Sun, 07 Sep 2025 15:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757284128; x=1757888928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jdyp87VeYRanIqFmUw6vy7xC6GuBA2UsO0EJfl07arA=;
        b=X9DKlGfe6D3yfoYSrESOS2OJcxnHnE7DerGn+pxyurmuaI9FtdcqQzjBXQKdFC7/pt
         +BO41ly7YxVMZmOe1IxUYcN00IEEf0q89yG8ty5bI9yvA2Pfh/EijMSWRgl26bnU83YB
         yUYlXacwcG5sukJHEVHBeobtP0oZc9qQ6PfHGrFwT6QoH3B3IeOge7ax8SxnWtRtVhcq
         2duWmBB4m8SbUtmyKvcIvt1rYp/aQkmjmt5xIQIp1FUDxnYdrv/b2qg5bOiTmQpOO2U/
         UIhz/hc06tHPy69/f3hrf8pvEn3SuPSoHhTY1a2gLgJgtbqg22p6ZPOubbnYLlz7b5DT
         GSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757284128; x=1757888928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jdyp87VeYRanIqFmUw6vy7xC6GuBA2UsO0EJfl07arA=;
        b=Vul6NVF2LtLcx1MrPSh+BjtdUFfmhAwb+b8PEQbFzOkKv9A5JTI8xsbKIdkxBQtjcb
         lDne3/WCjQ2DiMY6gW+fFpOcOJnwR6IJrQxr7oGek8t7wU4gCtE/shsQxRgM/ex5ew9a
         s7Yw/bwsY/FGAq96CwQSfZgSW0/sCw+QYTHS/SMnv8yrnqebtvtCEJknfy/2hE7SFkGc
         nPIfH+yKy9eN/sCXwOh6CSPmKhClnacfdnQ5resvws2ZeKNCtQyQJK3QUJBC09MdUWEM
         2+JQSbdzpRWBqb2gG2FbAGVu+IM9pDNf6DlzuZWs2e6QtsEKBYiae7I7ZeLcaUMtLuZ3
         BjtA==
X-Forwarded-Encrypted: i=1; AJvYcCWomIjEh5ejq+rRSOhc+w88pblNsLRFLX8mD2nxZqmXd0J3wwUE2n3kugvj8A9KFLJkaBwZEu+S0jHs7vU=@vger.kernel.org, AJvYcCX/gb6LtvH9m1BDTiosjeC2JcM67xPDX7Vu6vH73RvROQGZURNBnlj3w+4NB4ODmZkDTf2p1e0dypBG/fnz/DQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4GvHNuCar0C7TUL5wi2LrnvLmwKctnXq/jWW8gVqJu25H+RcH
	/oScdQcMB2TOFbhkAsyF5t/ylMrjJNnu79L8ZiWCVIPwcbrhUQXW/d6ObHgvk2FR1p9Km1Go2rh
	eOwcz4XeGcNyWKYcF4gDOgz+irnKYFC0=
X-Gm-Gg: ASbGncsMWNWU9wsvZNQfkj+AJD0FCidev9ABrreTCaxJSweu5yXeeTSv2rmhC7GmDW2
	EDJ/iAFuMJYtKYMYpbPAQoFR1Aaa5pK6tqEHVLNoj3yO5RqBTiO7prEMwBmEuG9Y8ppuYkjrw5r
	tELdedwW+gLbp6w9LLC9Twx7U1vY6fUEtJXvdAy7zIX7WEKl90WzhIXGiNKmzOsloGeLYEA3FoH
	eQmQEzLNOW/W5et9eYO9cfG/MYwxLURJZThnaq26qaLOkiSpA6nXRCcn/mllyCAf9ehUU6ETpGn
	orkcm2BcTfQWMQko+JX1T/1I3Vfvx1VuzxDH
X-Google-Smtp-Source: AGHT+IHeHzk6udhwz4fney38x7L6dMwuOcobxknukdIVizR5PEcm6WA8GQDH++2EkukwFu5mAoMUqZO+VQS4BnHMC08=
X-Received: by 2002:a17:90b:17d1:b0:32b:4c51:628a with SMTP id
 98e67ed59e1d1-32d43fb18dfmr4583886a91.8.1757284127629; Sun, 07 Sep 2025
 15:28:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DCK76G2JH58W.1QPN6YHTEOABB@kernel.org>
In-Reply-To: <DCK76G2JH58W.1QPN6YHTEOABB@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 8 Sep 2025 00:28:35 +0200
X-Gm-Features: AS18NWCH5CQzhPsEphE142YdtjGl1wIs9cw6MvXKmijurS1ozoICewrpPeXHPU8
Message-ID: <CANiq72kNpLWnzW00iHMQ4Pvk11SuktBYA3=TLGyQ7WnkDy9U2Q@mail.gmail.com>
Subject: Re: [GIT PULL] Rust ALLOC & DMA for v6.18
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 7:38=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> Please pull the following ALLOC & DMA changes.

Merged into `rust-next` -- thanks for the summary and sending it early!

Cheers,
Miguel

