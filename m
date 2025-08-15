Return-Path: <linux-kernel+bounces-770683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBF6B27DD8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 12:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A300EA0021D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9D32F60DB;
	Fri, 15 Aug 2025 10:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="vr83j4M1"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B6E2FAC1F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 10:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755252084; cv=none; b=kSSsp04i4uJywWh/VVOTeoPBKMefC6zegYXSewPigDTiJkRbvwEcRHE1tYvd388v024lUqQxIdkUJb7Y7S2QR3Xnl75herqixqTnDprFGTTl45ZZ4k1KCyCMwkKMHde7ymaZwLReIWGXEtt+1wDvUrJl3bgakvMJ/T+x7cxrL7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755252084; c=relaxed/simple;
	bh=8FsMk8obAbD+bD00DJ3mYVUDhP/6yoGCi9VNK8VjAFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/fVe7gONbyoUBIRee7ALdZXLnSGOzSPMAUTy/uOhubbdfI4o9tIVzjlRUqUpKTUxQYlZi88qoQSQdf6WM3BGj+OLVTEC45RMGcCrVAq915S6k84zVbdYZHPPGG1ApRxenq41ECr6kyzxc4JiK1NOIjecm12oGU94SNyiTGUwio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=vr83j4M1; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p54921b16.dip0.t-ipconnect.de [84.146.27.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 1230051EB3;
	Fri, 15 Aug 2025 12:01:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1755252080;
	bh=8FsMk8obAbD+bD00DJ3mYVUDhP/6yoGCi9VNK8VjAFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vr83j4M161TRumIMrKEvi+KvnRunX7jsFjaLirpQXvcspcrBGkXldm3ThsgnoZ5Qy
	 NCBKCI3ax+d6zc3PWT8F0CHJKLxateKkwvY8hc3Eo4+e15qlLuUPyP/PRniOY8IvuB
	 yAVNHniRaJjENv0Veyh6CzWG3G+RJqGjK8UIcMTtDLiNpJ9q2hKamIlXXNN1YaLuE9
	 QvRpPvOOMcbej3WQqTt36aH1OGxKMjXyHwDFKKQ4NWkdv0VseU59P9tjftFifX41Rn
	 ADnsERYP6xf08gdiO2QOZsZdsSJN3oDEZpdjDWU1BMTZ7Yimbf5NpSVu8EthNUeFxK
	 /LoYnW0ys8Liw==
Date: Fri, 15 Aug 2025 12:01:18 +0200
From: Joerg Roedel <joro@8bytes.org>
To: XianLiang Huang <huangxianliang@lanxincomputing.com>
Cc: tjeznach@rivosinc.com, markus.elfring@web.de, will@kernel.org,
	robin.murphy@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iommu/riscv: prevent NULL deref in iova_to_phys
Message-ID: <aJ8FbvCJEOj2XjT-@8bytes.org>
References: <20250815071244.13982-1-huangxianliang@lanxincomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815071244.13982-1-huangxianliang@lanxincomputing.com>

On Fri, Aug 15, 2025 at 03:12:44PM +0800, XianLiang Huang wrote:
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index 2d0d31ba2886..0eae2f4bdc5e 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -1283,7 +1283,7 @@ static phys_addr_t riscv_iommu_iova_to_phys(struct iommu_domain *iommu_domain,
>  	unsigned long *ptr;
>  
>  	ptr = riscv_iommu_pte_fetch(domain, iova, &pte_size);
> -	if (_io_pte_none(*ptr) || !_io_pte_present(*ptr))
> +	if (!ptr)
>  		return 0;

Zero is usually not an invalid physical address, or is it on RISC-V?

-Joerg

