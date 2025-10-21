Return-Path: <linux-kernel+bounces-863572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F15BF831B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 21:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD394248B4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F1834B697;
	Tue, 21 Oct 2025 19:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1Vp6E2C"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26448221DB9
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 19:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761073641; cv=none; b=Iw2pclXifqZrTPZDfLX3H20CGGhp7+SyAP1JEYdVIRqIb5Zwmcqu3/V8qkTQQDa2hcZb2H+3Ixhy7Wl4llrkpOfoR9L1/haOsoTNwIm4MKNN7i/6OMsOx8sT52p5MD5+SumNhFkugxthkdssHZp+6GVOYGSQH6clSvM2UiC65Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761073641; c=relaxed/simple;
	bh=FOAAwsJ9Uj8bAGD7DkfGOjFD264cHJeaIqipN113e60=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e+omJHXl971tZlMosL0tIxQZjr98drp6bzXVUJ/gRjeZ308V80bDv0VFXB0grh33Yc51wbrw9iZLEqYgwbJ7JJH39s6xB5PABt1eo7LL0UrZfE8eoM6ph26D0+1dIKCLv8DYmyrkzwtrMtYw9Q+Zu937ZUc6uDV6rS6kU3cI/hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1Vp6E2C; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2909448641eso2400705ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761073639; x=1761678439; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tmEFJU8Be01bge6hq/DhNSCmREuRRM1yp/lMgJNVP3M=;
        b=N1Vp6E2CkZ4YCHc0tiRUdsN0fR0wsbClBn+nGS1nuMmbdK1B+6XKYBYFjkZSt1TLVx
         oRdihRUouheKA8tn03qYl4t6zMmfS5BpmXoyJk3a0W+4H9cDcoYG5G7ew620fOU6C0yZ
         VHCZtoIhPev3QFpibg1WBU/7J5ZnI55xlZw0u4XzuhNpw9IWyJ8tKl9mpkn83lUGz23m
         bAmM1fpqoiCUlosO/t7Gza+SjIJg6gRANptJbo82MpxZSvqY6PTs/cDE1vw1Bdc3Z3Ao
         rgAvqHkAEVTpHL3ThwzVynzr63JymYH4UiuIYqg+xWwVo/towuPtAp7NFOtWnIYY0G+1
         Hi2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761073639; x=1761678439;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tmEFJU8Be01bge6hq/DhNSCmREuRRM1yp/lMgJNVP3M=;
        b=Z+iTuCfb6Jy+XqFJ4/R2+hhXsBVOSKtOariP3U2tSU/RBGiFro6eMnTKUIryNtM33C
         KUzHqNgKIq4XGeM2XGNLePvXAIq71n3t0i8Oucy6bq7wF78II7PTr30Th++NcOziqFmi
         2D//dqzVaCQbNvecYN/aUVUZIo68UirskyNKLTq0Amt4/aVP1CuaH3Zwf3JMo1QuDUTm
         Gr9Vq8HtyfxMTB8sNOrg8o6JZlpyL649dymvC3esa2LIixfmVBQfZ3KzmbnmTEbh+tGd
         T/wqs7oSLM9UerdETxD2W8QweWmRUmZwqixNz+PrNd+StslJ6Tgl+kwYXey3GPmaoKx1
         tGOg==
X-Gm-Message-State: AOJu0YwWFkYBji1mQzzRwjS4FgaVBpSMNlvmgot/fDs5Rbl46GwcylGf
	3J9nHt95UFMzaNTKZEcm3j6FW4iKbVHa8Oy2gS6rVlD99b0m3IKEZT4p
X-Gm-Gg: ASbGnctujoHmKnsMdeulnEVwXtRXJAQ8wwTT6tQfnq6Vop4fAHds+fn2iUWPs/gpgRn
	1jBzKVi0kAf2HFkFAxHDniTTrKxTJVP8qOzHQkEa8TeTFTLP/mu7ePJhotX1PGyxNNMMjtNzj+d
	uHUld6ve0bQoWoWLffmJmXmgjEiS7FR4rsIaU7FoN/kwh3a1FAdZ7kAzDbH4HGEinBqc+drqmzi
	MUZOr4eOrTOX7/LW2yAYAD16N9PVrcUhkhMzSFxl9uVqB/2nGwYBfSjxsi95R8oXJsJWm7PBL0Y
	7+crOGT7X9dBYG4QlEfwblx7DotvUZIN0pyfW/BoBC/sDY9voM2Ne4NMO2qpZSLUWcOtWnBfCaM
	HB8l5PAqtMIaw4nP5cNz7CHDM3uWussLqygEfReCGAUAQ2qDNqHgQ3fJ7958FNlwb8KBWND3wZj
	jxhWJg8N/wbfFQ0XjIaSe5Rkx7DK3MPa+ql8M=
X-Google-Smtp-Source: AGHT+IE5LQZFO6UFhsWNvu30idBG2vvaKxgsnI32qmbtsRvHFk6H4FUtrwCBgpU/tnj4k/GVfT3eZA==
X-Received: by 2002:a17:903:1103:b0:26a:6d5a:944e with SMTP id d9443c01a7336-292ffc714f1mr8437925ad.24.1761073639315;
        Tue, 21 Oct 2025 12:07:19 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:84fc:875:6946:cc56? ([2620:10d:c090:500::7:6bbb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fde15sm116578435ad.84.2025.10.21.12.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 12:07:19 -0700 (PDT)
Message-ID: <ec7ecc7d47540bba04f6a0b7e0cf74f4ef7a84bb.camel@gmail.com>
Subject: Re: [RFC PATCH v2 4/5] selftests/bpf: add tests for BTF
 deduplication and sorting
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Andrii Nakryiko	
 <andrii.nakryiko@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, Song
 Liu	 <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
Date: Tue, 21 Oct 2025 12:07:17 -0700
In-Reply-To: <20251020093941.548058-5-dolinux.peng@gmail.com>
References: <20251020093941.548058-1-dolinux.peng@gmail.com>
	 <20251020093941.548058-5-dolinux.peng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-20 at 17:39 +0800, Donglin Peng wrote:

[...]

> +{
> +	.descr =3D "dedup_sort: strings deduplication",
> +	.input =3D {
> +		.raw_types =3D {
> +			BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_SIGNED, 0, 32, 4),
> +			BTF_TYPE_INT_ENC(NAME_NTH(2), BTF_INT_SIGNED, 0, 64, 8),
> +			BTF_TYPE_INT_ENC(NAME_NTH(3), BTF_INT_SIGNED, 0, 32, 4),
> +			BTF_TYPE_INT_ENC(NAME_NTH(4), BTF_INT_SIGNED, 0, 64, 8),
> +			BTF_TYPE_INT_ENC(NAME_NTH(5), BTF_INT_SIGNED, 0, 32, 4),
> +			BTF_END_RAW,
> +		},
> +		BTF_STR_SEC("\0int\0long int\0int\0long int\0int"),
> +	},
> +	.expect =3D {
> +		.raw_types =3D {
> +			BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_SIGNED, 0, 32, 4),
> +			BTF_TYPE_INT_ENC(NAME_NTH(2), BTF_INT_SIGNED, 0, 64, 8),
> +			BTF_END_RAW,
> +		},
> +		BTF_STR_SEC("\0int\0long int"),
> +	},
> +	.opts =3D {
> +		.sort_by_kind_name =3D true,
> +	},
> +},

I think that having so many tests for this feature is redundant.
E.g. above strings handling test does not seem necessary,
as btf__dedup_compact_and_sort_types() does not really change anything
with regards to strings handling.
I'd say that a single test including elements with and without names,
and elements of different kind should suffice.

[...]

