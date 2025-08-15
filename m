Return-Path: <linux-kernel+bounces-770523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFDBB27C15
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F5D2AA4E48
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A1B2ECEB1;
	Fri, 15 Aug 2025 08:56:14 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954412E7F0A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 08:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755248174; cv=none; b=HGAcBLo+p0nA4qkUkjDSICxt4xkRdwkUKWUj3BR2skGpH54mCZc0V4x8IvJemcRE+ZTZ0y63dN+ZiyWslhKaCzKOesoYEKO4CsDKBfhJm5o1Qi6aPtomQjMRKvalW0ku3zyd3J6TKOaUZeQRU8TBUYkOCDnDeDdyddfU01atB3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755248174; c=relaxed/simple;
	bh=DLmNhfCO37ZzrLg19ZL3ob9EFSlTN2bd7uXWyhsn+Pk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l31SgWf5m8PtQ0yCKHva47C+HwxLySsGdDcALbNPWjftbb7TlaQbzF8s0Fwb2XqQAadoVyb8jpsi489slbuArEnK7CvUPRQqMRXAQiF2gfnA5qSpcxj+IS/T7jDPFEclCxF8oTx4WaBn476zHIwWYHs3spOPA4suF8+fHp94pg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c3GB74QCdz6M4qb;
	Fri, 15 Aug 2025 16:54:07 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 21E5B1402A4;
	Fri, 15 Aug 2025 16:56:08 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 15 Aug
 2025 10:56:07 +0200
Date: Fri, 15 Aug 2025 09:56:06 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Yicong Yang <yangyicong@huawei.com>
CC: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>,
	<yangyicong@hisilicon.com>, <wangyushan12@huawei.com>,
	<hejunhao3@h-partners.com>
Subject: Re: [PATCH v6 3/3] MAINTAINERS: Remove myself from HiSilicon PMU
 maintainers
Message-ID: <20250815095606.0000606e@huawei.com>
In-Reply-To: <20250814091622.23269-4-yangyicong@huawei.com>
References: <20250814091622.23269-1-yangyicong@huawei.com>
	<20250814091622.23269-4-yangyicong@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 14 Aug 2025 17:16:22 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> Remove myself as I'm leaving HiSilicon and not suitable for maintaining
> this. Thanks for the journey.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

Thanks Yicong, it's been a pleasure working with you.
Best wishes for whatever you do next.

Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe168477caa4..22999fccfbd7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11059,7 +11059,6 @@ F:	Documentation/devicetree/bindings/net/hisilicon*.txt
>  F:	drivers/net/ethernet/hisilicon/
>  
>  HISILICON PMU DRIVER
> -M:	Yicong Yang <yangyicong@hisilicon.com>
>  M:	Jonathan Cameron <jonathan.cameron@huawei.com>
>  S:	Supported
>  W:	http://www.hisilicon.com


