Return-Path: <linux-kernel+bounces-599972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAEAA85A55
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 12:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D2BE189C7AF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 10:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4329822127B;
	Fri, 11 Apr 2025 10:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="DWi5QG7e"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA2F204581
	for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 10:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744368087; cv=none; b=aZdVRdtRiHL8nHNdZpXmRs1LDbf2T6w0oqcQqA//zqzqzmn4tyZHYXjG/J0FTEnl30MvV5lUYnZbU2nCiLUEhcRSON6qDsbSz1X0C8KOPnjUudXayQiIcipjOMnNc7mmqA6DGhBcBMB6Pb/MDLvbvKNOKGxGDe65Bw9StxfARnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744368087; c=relaxed/simple;
	bh=70nnKZkKDKtDgnl0C06+b7gMrrVZkXvMJyhTaYQG0kQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfFwJUnmU2T0tqbKvZWwvKIHiq53tKHPJ9+fCgRnk8cVl7epiO78Ujz1QXg3Q2PpLJtUVKEtGnN0v6YgygVyIPf8w4AC4RQKcilow470GTDlc+29T9xudbagDRuI3TM01m5AKA7UQp1eIECjRdzs2rpjXxwHmi75BFeG+CC9+O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=DWi5QG7e; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 8F47F47AD4;
	Fri, 11 Apr 2025 12:41:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1744368084;
	bh=70nnKZkKDKtDgnl0C06+b7gMrrVZkXvMJyhTaYQG0kQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DWi5QG7ej+qLvmgNEz+7skZ+UgpGFhKZo4QUJHJR47RLZtnYRe2KX8rah5lHuGl75
	 eKjc8TR17twq+klB7ik3z6QbgHXqDHIEulq1gMzYDoDFAxJ1hwapmpI70mg0CX3atL
	 /G4Kr4jc79mTq8dqsYJmmaKoQRjKkRnH10zJosJ3groxjVukSgQfd2X/5/ZJLbPdL1
	 6zBP7nBgKfH/+cKfgmYzelDSF98eefKtzWq5vU+oBB0rYyljIw8Dyn1XvPm+e7u3WJ
	 KLiDw4yZGDLhdA5Tqwt4piV5+nXFmvgDYWFTaxHmphu9j30+oMOlr7E43fEfqSFvqP
	 4Ojaodk6vvonQ==
Date: Fri, 11 Apr 2025 12:41:23 +0200
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
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v2] iommu/mediatek: Fix NULL pointer deference in
 mtk_iommu_device_group
Message-ID: <Z_jx07MlkOf8E2zj@8bytes.org>
References: <20250403-fix-mtk-iommu-error-v2-1-fe8b18f8b0a8@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403-fix-mtk-iommu-error-v2-1-fe8b18f8b0a8@collabora.com>

On Thu, Apr 03, 2025 at 12:22:12PM +0200, Louis-Alexis Eyraud wrote:
> ---
> Changes in v2:
> - Fix goto label usage in device registration error case
> - Add review and test trailers
> - Link to v1: https://lore.kernel.org/r/20250327-fix-mtk-iommu-error-v1-1-df969158e752@collabora.com
> ---
>  drivers/iommu/mtk_iommu.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)

Replaced the previously applied patch with this one.

