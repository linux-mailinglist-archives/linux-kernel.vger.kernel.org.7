Return-Path: <linux-kernel+bounces-871577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDE7C0DAEC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5FC3E4F9FD9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990FD30F540;
	Mon, 27 Oct 2025 12:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="FqiODjdG"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E19C30EF84;
	Mon, 27 Oct 2025 12:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569021; cv=none; b=S3BYW1XQmvLv7wW/aw7iwqgzSxjPzEs5UhKfZh8/TUpf+sVdYj3J9WlzlXlf6cf7w1R5Dq/ZzSI8Of0TpRbU9q4WhmCmpUZA4enAUT16sMD9uazvCM9YMeXuRRsQHHo/03KOOOIE3uFCTuWDReDqQ9ydERUQfN44BOdKFE0Xo04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569021; c=relaxed/simple;
	bh=2G56BnpRGoI+NqEwEfPETIyrfVpN7iBlb7p/Lhy7kEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eo85djHhCEldPTWbLoIQo+GQF/kgfAYYk7aAHLnGtenKQzzm2FylZwUebHgoGvX1DNjAb6YOo31FaBc89fCrjIJOim9mV6A1fMzvtGCtTYqbLjnJbIPAWa47xdeS3Bfda3GvbdFP9h7UZkVR2kFxwfJFhekWMI6J4gE/oEd5rq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=FqiODjdG; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p549214ac.dip0.t-ipconnect.de [84.146.20.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id F096A59903;
	Mon, 27 Oct 2025 13:43:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1761569018;
	bh=2G56BnpRGoI+NqEwEfPETIyrfVpN7iBlb7p/Lhy7kEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FqiODjdGsHG3QIPyv6y1hgH1SJBEBvJAVuF70t2w19PW6FTBU5dU93uaxknOuuwLz
	 RU6wFENh+OpdEZVTCQYR1I9XWND1eCvmyb10IMWv+SzYrlSCz3y5kFxn8yxAo13lmu
	 0yRdaolADOmUlLnAD8JSluajl8waz2SU09xjOH/BBYfRyHhyXAos2MGe1hrJRbM6lj
	 Yw0TDAle0xRyf3PQzlAj1ypSSUZL0B3f7ANpqkwqdkiJ5/T3etsTD9dPlAm+kAYzl3
	 FvZgArL5YYo5kIbY+mdvOLVxvqbcD7kqF086FzrfJ8Yk1bEovxZCHqv609Ojk9KjcI
	 a1ZZnCQiPaFiw==
Date: Mon, 27 Oct 2025 13:43:36 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Zhengnan Chen <zhengnan.chen@mediatek.com>
Cc: Yong Wu <yong.wu@mediatek.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, iommu@lists.linux.dev, linux-mediatek@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v4 0/5] MT8189 IOMMU SUPPORT
Message-ID: <b4jjrpqu4pqu6nm3nohye57eauqvlqny7xtesnelhj4kcnwc6w@cohioft65alz>
References: <20251018132625.14428-1-zhengnan.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018132625.14428-1-zhengnan.chen@mediatek.com>

On Sat, Oct 18, 2025 at 09:26:09PM +0800, Zhengnan Chen wrote:
> Zhengnan Chen (5):
>   dt-bindings: mediatek: mt8189: Add bindings for MM & APU & INFRA IOMMU
>   iommu/mediatek: Add a flag DL_WITH_MULTI_LARB
>   iommu/mediatek: mt8189: Add APU IOMMUs support
>   iommu/mediatek: mt8189: Add INFRA IOMMUs support
>   iommu/mediatek: mt8189: Add MM IOMMUs support
> 
>  .../bindings/iommu/mediatek,iommu.yaml        |   8 +
>  drivers/iommu/mtk_iommu.c                     | 132 +++++++-
>  .../memory/mediatek,mt8189-memory-port.h      | 283 ++++++++++++++++++
>  3 files changed, 410 insertions(+), 13 deletions(-)
>  create mode 100644 include/dt-bindings/memory/mediatek,mt8189-memory-port.h

Just realized this newer version, removed v1 and applied this. Sorry for the
confusion.

