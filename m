Return-Path: <linux-kernel+bounces-877451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A33C1E24C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 03:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEF7A18953C3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 02:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B011D86DC;
	Thu, 30 Oct 2025 02:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICYRryuQ"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CB432ABC7
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761791933; cv=none; b=arVUNpD3DoOZuFLF8TkXh7d6MIUta2rLFHQ4vsho8BcMAHwZeLWII9JOJ3eKXqCL7yg1WQn03s78ow/oH8ISbLqyDLTgiq/gfrdBYnHzButGqKmIxLhbERJ9IDieZAREuuJfgscyOFbCKnIV1PWU5U8SevxBuyRNu2Rav8HrpZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761791933; c=relaxed/simple;
	bh=AMq5LFLTBTjPLCaeK6notQ8mgN7CLcxdcRwOBe7Vz8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PvTPDim7vGU4cQJBpkh+SrlnBjz1skUjcpN2OHQsStXiEkxi1R5Icpn3qMr/oQV0nej9qPLzlaXMaMXPb+J3afNGcNpJn1Bp3j6AMmV9L8qVO7Hu1F/e47g52rPJ6UwJNehB7jYDS5RIWcuTmDQR4ryRHvo+xLs10T75xIJPYG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICYRryuQ; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8a1744d9b8fso71405185a.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 19:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761791929; x=1762396729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6nNeYJj47LC/Yn9TG11EugyfogPj0qEsWlsX47jJWc=;
        b=ICYRryuQ3Zoa61UiN7eZjBOI+unPW7wOiyiH7SWBFz55mjPypcIG92V6gpuXnYxRri
         2Nq4S6EyXzuBstu2FAb+7DoAl1H6GJ0tVH5iYOgj0vsLx+YpmfWbIww4Kn132k3B7f7W
         AGjAM1XJNonMyxfwiGQgKo9eXCD7TvIvETpicuiscPH+FIn6JOJ/JrrY6A5JAbMb13sV
         pyjpwzJw06MGfJOr/KJTx0fmSb3X9AkSFmJy2/D4pmHl608MDkx+uX6XD9MsKct7v4NK
         uO8/XIllpVboFMvcIVT8kLbAp3GYXO3JxSERhakJDmx9/b84woF2es1sTkuQhxRCb4LC
         G+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761791929; x=1762396729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V6nNeYJj47LC/Yn9TG11EugyfogPj0qEsWlsX47jJWc=;
        b=srEQGw5EX5KCW70X3UXexc/HgqGsbzAjqDE4MXva2XzP4MjII++zmnAxt/DwsW8UBn
         6II8ACZj0Qn9mRRGx3xR4DVPkFK5Ui07d0WPA0KXwYsw4Hybp42c/OO+VtP2Y0+5xHFj
         JGvhpjvt9I3GXYpyQJfpGVwDQsnqVzzBRGsLjApz/3ap5twOeaeUBUDXFDEGEqJ3Fgm+
         nGnZ23QV5f2V3Znz9+Ylax3vN0KIT0AatQ5rcX2QGGnfiEaK5Ds5FYo8yrVwa2JyfaiI
         QHnUliqRuRlQqBxHxWe3m7zUpth0wYWPbB3j14Ph3yy2omagotVa2NFgF3YkQauMWi5A
         rgjg==
X-Forwarded-Encrypted: i=1; AJvYcCWhsLvgBOpz/aeNCDSLuPsctDLv4OdwZvGOpx2lltiQfwlVBgX9YW5WE+5Iz6PWeSK92aDjUfhAtPNUQMA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd3xfuJ97UM9IyN8ZUp5WUUroeID/QJIDqqwkQNk2ExxWZGB+a
	WsNQD7dlFasBKOx/hMJIqXQLPXAFGD9fUdMxaDjeFTovytk5TPN9ZfTKVNEkeGwU9Cgg2vBtX3p
	+F0v7pKx21CkxoQXeAxkh9WHZKTeYnGM=
X-Gm-Gg: ASbGnctRUrtZOzHT/ELQ2m1Fi3yCvGmxgflZrLyenL+aCcIXoYmK8mDJOtikVMskfX3
	uVGEGTB2JGxwpDoVZsOfIfnTqGcd2bmRxubidZVTkCBmtCis8pJdePaU7cpvf6wWyGUkKU0SQPx
	18bQlUXDUjdUAHAtcK569ZofAd/guxkhYxkmQIK08VX89Ge/cepU9WYJTnJQrPP4yXYVDZ5QvKq
	N/AyZ3uDRCn2DPX5pd6niPpoQ5EsARZsUm8ne4ILwLb/r1nGgkXzmQRZJooRF97wQGqE4EwH7bk
	uU1qR8SlJpzw33qY
X-Google-Smtp-Source: AGHT+IH/NdEqkxVdErKm21bKL2gsa0HivcBd1sC5JLSxUC0NTL1b+8ekEWLzZcLSO5WqylHT28D8+ZBosG8IrfbuoAc=
X-Received: by 2002:a05:620a:6919:b0:8a1:c120:4617 with SMTP id
 af79cd13be357-8a8e4ff156amr776454585a.51.1761791929275; Wed, 29 Oct 2025
 19:38:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030014020.475659-1-ziy@nvidia.com> <20251030014020.475659-2-ziy@nvidia.com>
In-Reply-To: <20251030014020.475659-2-ziy@nvidia.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 30 Oct 2025 10:38:38 +0800
X-Gm-Features: AWmQ_bnlFtMc3CzOHCzWJ0c5wI5RvGU_i4SjVvno9Biz6ZUIiW7knGxWCgCNPkI
Message-ID: <CAGsJ_4yYrk5O29_+YdgufPCJ6h2xbEE7q4EbtFPCS6xqivWFug@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] mm/huge_memory: add split_huge_page_to_order()
To: Zi Yan <ziy@nvidia.com>
Cc: linmiaohe@huawei.com, david@redhat.com, jane.chu@oracle.com, 
	kernel@pankajraghav.com, akpm@linux-foundation.org, mcgrof@kernel.org, 
	nao.horiguchi@gmail.com, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Lance Yang <lance.yang@linux.dev>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Wei Yang <richard.weiyang@gmail.com>, Yang Shi <shy828301@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 9:40=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote:
>
> When caller does not supply a list to split_huge_page_to_list_to_order(),
> use split_huge_page_to_order() instead.
>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

LGTM,

Reviewed-by: Barry Song <baohua@kernel.org>

> ---
>  include/linux/huge_mm.h | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>

