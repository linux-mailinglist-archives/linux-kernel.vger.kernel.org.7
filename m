Return-Path: <linux-kernel+bounces-872396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF66EC10A9F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C315A1A24425
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D545328B46;
	Mon, 27 Oct 2025 19:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpNZaHmt"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C8A31CA4E
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 19:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761591995; cv=none; b=c3CiT4VWgdiRpImm3Ra1ZixwbIBZa/AHJeIuYsH/mYKyZRGiHgSmrdsTj1A4EVG8M4niGHWbehd8XoFpXsMxIEwOZpEvMVGn541xvvaV6n0ztrpfZZaQX6euYyGcIdBzR2CBH2vCkjGAkJ9qY8PBnvP1yZncGLOcEkJQdQaWL3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761591995; c=relaxed/simple;
	bh=Ojab5OSl+WBm4Mxevged5V2m1wa5Eh7wWc+uU4tFvHo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UvZzfTmO79qdzIqn+zFglo+kUXKfNqEHLnf996rA9Z3jUZ3XT17GSXv+JJzVQO5VioB2hx3i2Nl5f5dWTjVfHC/+1U8pilPTnAArYmG9ziR9nFN2xiQmTPw9J6z6Cpf/0ZyfpJygG/mLYmfmjqdjHKFesQJxMz0F9KJ0eg9FGV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpNZaHmt; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-28a5b8b12a1so52516165ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761591994; x=1762196794; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H0gDu/cEgextMGhJSkPKVqZRF+SRP309HWbX9UskMTw=;
        b=FpNZaHmt0odBOsrqTv+Trwtyb6bLCm/w8nEropD4Wq4StY/vEzeYELnNe9dhMWBIQ8
         hZQ4t9Cx491q8xoQeGVGteQy+dY0u70s/MBx1io3zMeGnti5HohIjwQCshVTJJaJBboU
         tLVHHzFBJFaPXX0OMBUprr2DRhLQxr4pau22spnX1ejsbp+Yu45f1JAKVdhw3keMYis+
         Q8WtdeSiEN5qg6TJ172XK9hr8+QVuSMVN+FtLO8eYmslAqHiXaCz7imP/HusMJTxh3Cr
         ueNrHeABVtXTenkUx4n3g654xHye+UQOpU7VFWB5syHKc2QjWHZPm32Cz1YvF/SiJkue
         g3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761591994; x=1762196794;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H0gDu/cEgextMGhJSkPKVqZRF+SRP309HWbX9UskMTw=;
        b=ocGok8/9P3jZSQQDOS9z29hbEDi2CY66YTtbmbY+BriF5SnZJkfvjB0t8cx8wkqaYt
         VagVe/SgE/6EcYnbBR/b1Nlghgh3FUWEXzf9UiSxYpRiNNiSZT8NrVnJK7Z4tUK9tJVh
         NatjwLs3H4FTXOUc0/6nNLl2vRna81Sf9O+5/gsaqyBSKzZt6Q1Q9NDNOZEWYjA50Clu
         nnXk2vZQvCNrtpW0dgXWpLRKGWUfF+QzRLFhjp27o4dhHuRXZInnuSgkiD2DGA3QlL2i
         vcRiL20u/07KdXsBSX9ci2z5V04U4/KwcPHB5R7caS3K5XzkR45yRYFe9nX1MBb2BO6l
         MW0w==
X-Gm-Message-State: AOJu0Yw5Qs1twCLm4hDwmyWwmOpWrza+OlFwrPIeg9oLBYw2+n/hZfB7
	1hYyI7gA8jok/NlNpn3z3VuOoi4wh/kfPGJR1Xp3+xf2IDSaSTtQ6jeq
X-Gm-Gg: ASbGncvtbOKIhsYcI9uKEtQ/Pkjy3z+fYWt1Yfdl0utjERTgNWBw5QJFwJy48sp3y4E
	n6tutwDXzEsc18ElMprXMgLXommw4ok5Af2rtLR8+RTUk+9cb4E7REWyn3j+CG+XDfrBe79rQjF
	vSkAR/k5qS58/ARf+T+nrUWyh31gPcL/1ff+FOeVLZ3M6EWLY1p6WqclfeD3zvonghbfEZxqV9+
	q0z6vYnqBMnaRqBW6jJaWnaoi75sqCDZnSn3R8M/LMgC8VI08lktnhqGBorAjMcWMosbP+UL/dy
	KsNd13ryswBai7JlCEv4fMNzbbh2E+yecJ65WK50i8DKUpWgbW65irgqeMBjCKkooAAOp12mr83
	Bk3w+1aafZtN9sr1k5cOMXEQ8aJ0myrP/KDFJVB4krvQmscceqWI1GOtAbjD77BkyzgcEXBUSKC
	4kC4cquRNL
X-Google-Smtp-Source: AGHT+IFWIi8PKVygJ7gwEknuigRMUvmTlJAQjGlxiILEK6ZS4jJsAMvu5S/hQi+KS+QRppuNDN8ALA==
X-Received: by 2002:a17:902:d50c:b0:24c:965a:f97e with SMTP id d9443c01a7336-294cb395b49mr10271245ad.2.1761591993581;
        Mon, 27 Oct 2025 12:06:33 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed81ca93sm9366998a91.19.2025.10.27.12.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 12:06:33 -0700 (PDT)
Message-ID: <6e7ef94cb4e2d7fbc82676b2af1a165cac620aae.camel@gmail.com>
Subject: Re: [RFC PATCH v3 1/3] btf: implement BTF type sorting for
 accelerated lookups
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, Andrii Nakryiko
	 <andrii.nakryiko@gmail.com>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Alan Maguire
	 <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, pengdonglin
	 <pengdonglin@xiaomi.com>
Date: Mon, 27 Oct 2025 12:06:30 -0700
In-Reply-To: <20251027135423.3098490-2-dolinux.peng@gmail.com>
References: <20251027135423.3098490-1-dolinux.peng@gmail.com>
	 <20251027135423.3098490-2-dolinux.peng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-27 at 21:54 +0800, Donglin Peng wrote:

[...]

Question to Andrii, I think.
It looks a bit asymmetrical, that there is btf_check_sorted() in
libbpf, but library does not provide comparison or sorting function.
Wdyt?

> +static void btf_check_sorted(struct btf *btf, int start_id)
> +{
> +	const struct btf_type *t;
> +	int i, n, nr_sorted_types;
> +
> +	n =3D btf__type_cnt(btf);
> +	if (btf->nr_types < BTF_CHECK_SORT_THRESHOLD)
> +		return;
> +
> +	n--;
> +	nr_sorted_types =3D 0;
> +	for (i =3D start_id; i < n; i++) {
> +		int k =3D i + 1;
> +
> +		if (btf_compare_type_kinds_names(&i, &k, btf) > 0)
> +			return;
> +
> +		t =3D btf_type_by_id(btf, k);
> +		if (!str_is_empty(btf__str_by_offset(btf, t->name_off)))
> +			nr_sorted_types++;
> +	}
> +
> +	t =3D btf_type_by_id(btf, start_id);
> +	if (!str_is_empty(btf__str_by_offset(btf, t->name_off)))
> +		nr_sorted_types++;
> +
> +	if (nr_sorted_types < BTF_CHECK_SORT_THRESHOLD)
> +		return;

Nit: Still think that this is not needed.  It trades a couple of CPU
     cycles for this check and a big comment on the top, about why
     it's needed.

> +
> +	btf->nr_sorted_types =3D nr_sorted_types;
> +}

[...]

