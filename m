Return-Path: <linux-kernel+bounces-826148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A65B8DA63
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 13:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07171189E7D2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 11:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14AA2C0F7D;
	Sun, 21 Sep 2025 11:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkywEYcB"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4578D1DFF7
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 11:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758454931; cv=none; b=dNOc2J6tSjphnivPq+a/Pzvx2A9fA4+5b3tsGAjRdTnFp2m0kV9Q+q3xp0Aq/aFm6NNxpx85dG3xiT22deB+k8eClWulQeLpvtp/BqEpLEbmgxDke1HAuCPXNyodL0rIWDWi8y9XEs0K4cWJWqxeIQxxBv9cW//pOsTnbGSdFs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758454931; c=relaxed/simple;
	bh=K916KUx2pRc33+DQRqSv33PWW4YfoGyNBVmdt55/SZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ASpd7Bn6AhTOX3c+LCxR1lWHtFlbXC4JGuKZurDp+A0Aizyv49H+UWg5C9YEsHo2DcJix2G9PHG4lBj1y+iJngvA5+/mh5FrtJZYlMeRm+x1pT/IxgBcFml+MEvqSEs6Ctk96ICJL6IjZQl9RXKXDpRktQ3YREjFEeDG12IuW1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LkywEYcB; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3307e8979f2so983522a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 04:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758454928; x=1759059728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K916KUx2pRc33+DQRqSv33PWW4YfoGyNBVmdt55/SZs=;
        b=LkywEYcBsHsfQC/N4vaM0eMSzlohwsR3BNBO0QEg6EuMgINDeXBK+Gg3HYrwF7nZt6
         k0MTRi2qBUhfZW9380rAqWRi/m+7wqdUuFHU2a2hcnbUOlq1dSiU04qOXnKzKWZFJWCu
         CZeKSg4cD8+amxb7541FOY0NN0KvUeII+oVnJ5OzB+S0531VnAVhVGAw6MGMl5L5bFXu
         K7ikBR4VX1JxIM9V3oBy2F7SGpmIlvMYADRLOcOBtcPUFYD080lbg1SMkdQXZ9VGQTGQ
         s7a5X7sPR4Y50cMIkJfAX/omCsdtdjl1j7qUHTqUrB0BzhZBP+JwG2q6o7wZ2BlUEC6N
         Y5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758454928; x=1759059728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K916KUx2pRc33+DQRqSv33PWW4YfoGyNBVmdt55/SZs=;
        b=UrRpLlDv8pspmraNEb905q7i/L483NRBwohg8VpFg2TmPZZ8F3CnHAbS/mJ3yNhQv/
         TilWSU6mlZ1xNl7OYXkP32KwAz5RIyA8pnBvNf/8dlpM+wFruZyT8bzh7aoV5dO/Q3RC
         nGepD5Ic15V55yWlD+zN8v9RVYO61CPQ+9fwkRYYLbuv0nBDEy2gU4VotO5vndvdl1qR
         6DwAaE/lyQ2d4iYF28p+5mzRxukGVDpYZiu/6HmIRyjs1A7jzBap0vH/hiB7ovLTBKIq
         vjVMQyqf+FCP524CVF+VetHK7GZTd8GDpY8835xJq20Zx3HDy/fl40hYVK24xUqkxGmP
         vT9w==
X-Forwarded-Encrypted: i=1; AJvYcCVNRO4rO4rPB874AVcm63kN0NSuF3LCz4Mqp1c81FEEwUsyzP6vuu69vSJrS0KI2txZTVVUazA0kKqcbdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7vaSEjPla+P+9RQ0U3SOQlD/YrJzBbfN1vo6OiIqSmE3odBwB
	oOju8+8uFH8+SOq1wQ5k1vLrC4Qpcz96z0OzDI55h16mHI29jrh7a0pIgyRMLyuuObQL+XjxwH9
	F7nfI/5eViGUCR/a28Dd3wZ32j3ymfv8=
X-Gm-Gg: ASbGncth8LvAkhnVZDHsDYgk686wO8C0x89RKAwBmY4UcA3I0MSyjGosTU1e73RdGdm
	Iakf5QhgMKP6M9HATNNlkiXgyKeHMJHyPk+EjV/DAAotArCRuPaRMlmIMP1a4WV7IDNf73PqbPN
	fSeaTjYHFEOQpLg0z9HB66RFJRfjQo7I0H2XnlF3QKeSzbCFDbaal1b7Cfgl6NSOIl5S1x/LvjP
	DNU++YBJGV7pG2qvaOlaN3N5MoD538zo2TRct8PaLETuUqVDTdSH+a/qIxzWG3jVcWWtVLRh6xy
	EvA6KmcOpGFKUxqzoy2ssKvk+2fw98RrmGsQ
X-Google-Smtp-Source: AGHT+IFRSGavmihE0jeFmf3/2ErrEQ7lVZdNPzc90R+azLE4QPTS7uO3XKCP8dBGdcZnR+PQiMPrb7CuZa2GRwXI02k=
X-Received: by 2002:a17:902:da81:b0:258:a3a1:9aa5 with SMTP id
 d9443c01a7336-269ba26087cmr64556325ad.0.1758454928589; Sun, 21 Sep 2025
 04:42:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909212039.227221-1-joelagnelf@nvidia.com>
 <20250909212039.227221-6-joelagnelf@nvidia.com> <aMDq2ln1ivFol_Db@yury>
 <bbd6c5f8-8ad2-4dac-a3a4-b08de52f187b@nvidia.com> <aMIqGBoNaJ7rUrYQ@yury>
 <20250916095918.GA1647262@joelbox2> <20250920003916.GA2009525@joelbox2>
In-Reply-To: <20250920003916.GA2009525@joelbox2>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 21 Sep 2025 13:41:55 +0200
X-Gm-Features: AS18NWAEK_G6m5-8BL_C3aor80z6U_cj8cDpyNPkB8wcxKLKwKj_z5k0IO6zsJc
Message-ID: <CANiq72=uycGrGAVH=8KjVQ3e-P_-B0c=_mUBa1__sh44eiQ3=Q@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] rust: Add KUNIT tests for bitfield
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, dakr@kernel.org, acourbot@nvidia.com, 
	Alistair Popple <apopple@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, bjorn3_gh@protonmail.com, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
	joel@joelfernandes.org, Elle Rhumsaa <elle@weathered-steel.dev>, 
	Daniel Almeida <daniel.almeida@collabora.com>, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 2:39=E2=80=AFAM Joel Fernandes <joelagnelf@nvidia.c=
om> wrote:
>
> The C checks use BUILD_BUG_ON, in rust-for-linux we have build_assert but=
 it
> is fragile and depends on the value being a constant.

What do you mean?

`build_assert!` works essentially like `BUILD_BUG_ON`, i.e. after the
optimizer, and does not depend on the value being a constant.

You may be thinking of `static_assert!`, which is the compiler-based one.

Cheers,
Miguel

