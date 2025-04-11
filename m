Return-Path: <linux-kernel+bounces-599553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B89A85568
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 09:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5565A4454CB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 07:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD1628D844;
	Fri, 11 Apr 2025 07:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="Dhz9SsFM"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB7A2857D1
	for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 07:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744356412; cv=none; b=FTcJSqgiYisrsNss+W2aOQIRkD8MHhK9afjH7LL30xZcXelyhh5jmn7Cr+m7n948HoQwhTheREm45oZX6S8KxXLjzNaCSmt1m5uDZP2aBKiajLEsn6WePk/Ef3d5Y+cEwKlq14RfOmS1bY7osAihEAG05HyTcTCqh7KRfjvgtFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744356412; c=relaxed/simple;
	bh=oHJGD3DokWMMFOM+gMK6+SM9h2XRccCtdD4g4aHqNRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BfJ9DOVJBatFwCqhylWl0aD3N8K2IhdLXtPBc+ji0Kn0A59oAh7+B9MrDOkexUa5vY0fV+jH2edZp0BdrPuTuE+nj0VvXIdRAKDKRMFv8DMbZXP9bps2dPuud9NTucxZVXeqeuiRAizIL9LeXyluIS/0ntQ8pivr8QVN32jM2AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=Dhz9SsFM; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 4304E4685C;
	Fri, 11 Apr 2025 09:26:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1744356410;
	bh=oHJGD3DokWMMFOM+gMK6+SM9h2XRccCtdD4g4aHqNRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dhz9SsFMPKWl5jEsp+m2UYPQM3kNyhFqbKE3vrWSUFMsNQlrSrLZ4mp2uaIPH4mF6
	 8wSoxJNJJoCmYIpkWcf+OkpIqMfVhKNdpEBR3aiJ2tgiel02mjj5D8RWGxvEl4DB/q
	 IDhJZG0qV+LKbRgSWh9PISbRbvQdBoVlZ8VXKsATnqd1mDaLTGDSfIZzd05snhbDOo
	 e7AXrhm0mdRuAE4cmm0zE+psiqEYWTgy29v/UTl3VQo/yk2CTpuUCQC0rgfkNP05Mg
	 d7cK2J8VPIup+M9B1jTn35pRM8o9or9ookpMLlbKnVP/7ZCYPHmdpmNYjsF8mWLsFV
	 46iSyf7xOfe1g==
Date: Fri, 11 Apr 2025 09:26:49 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Yong Wu <yong.wu@mediatek.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rob Herring (Arm)" <robh@kernel.org>, kernel@collabora.com,
	Joerg Roedel <jroedel@suse.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] iommu/mediatek: Fix NULL pointer deference in
 mtk_iommu_device_group
Message-ID: <Z_jEOVDofe1P9f9d@8bytes.org>
References: <20250327-fix-mtk-iommu-error-v1-1-df969158e752@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327-fix-mtk-iommu-error-v1-1-df969158e752@collabora.com>

On Thu, Mar 27, 2025 at 11:46:31AM +0100, Louis-Alexis Eyraud wrote:
>  drivers/iommu/mtk_iommu.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)

Applied, thanks.

