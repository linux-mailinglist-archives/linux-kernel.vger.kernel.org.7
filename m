Return-Path: <linux-kernel+bounces-843642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0858EBBFE63
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 03:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A851934C460
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 01:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B41D1F1302;
	Tue,  7 Oct 2025 01:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLliQOXL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24B91D6DB6;
	Tue,  7 Oct 2025 01:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759799195; cv=none; b=NbdS4tjRld+cRbpEwDbqu2bWE2UFHHqMX2aSLaInJFoowgLCcFnFS5xcPmqM6ercOufFCekN0Wzv5iAgUM/j8xSUWMcwDOa2QTszITixtOLHRyjXOi9Kr54MeEBHsyHjo9cEcl202QWSXTEFzk79z+ttfMxNrzgM1wCzEc9/WgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759799195; c=relaxed/simple;
	bh=udAwqmPlvLpoTKxdXhd/iHxSrAV/aOnuJnJ4qcFUSk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVvd1VGqQdkOzQ0uvo0jl3bATZTITwKc9O7plpXkOyglcN/h3T75el24gphc0gr0mFO9mXRhzVkUzVgX6Qz14HjLIlW73kC9D0bjXe5HX2lUyJdM2LVnY0RXhDZ3LDfa+gYyIq1oNr3OtC6z1DnjeBviYNhP9gOPO1vh4h4mZho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLliQOXL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CBFDC4CEFF;
	Tue,  7 Oct 2025 01:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759799195;
	bh=udAwqmPlvLpoTKxdXhd/iHxSrAV/aOnuJnJ4qcFUSk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZLliQOXLokvUxwlRReyLimgj6aYOZ+mBXOBL9ot10DjLmtjTfbnlqdnooZwLrfr7l
	 LzVT4slr6VR0+VTstaLPLg1z0XmSUX+52YwajRHE2txrNIdA1RcKulpPmNVq+YLzev
	 sM1dffzmruPTzKSNOG++2WAewRwO9kivYHpFaLP+80ZWr2HsJxzYViQhOGfwDjiyvZ
	 UWFXIZ/eDTm/nKOOvDvebQSkMEoWbjKDlLcSRngKIIp8G3I3vLohdWIBibGyN9FcIa
	 oqcW80jRQlh1JFuNGMRMHITlcMcF78pjqSXnIR49GiV4BRYnEqDT+9ln/woHCdUKVZ
	 ly652VN4e28Yg==
Date: Mon, 6 Oct 2025 20:06:34 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Will Deacon <will@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	freedreno@lists.freedesktop.org,
	Konrad Dybcio <konradybcio@kernel.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Conor Dooley <conor+dt@kernel.org>, Sean Paul <sean@poorly.run>,
	Simona Vetter <simona@ffwll.ch>,
	Jordan Crouse <jordan@cosmicpenguin.net>,
	Bjorn Andersson <andersson@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Jonathan Marek <jonathan@marek.ca>, devicetree@vger.kernel.org,
	iommu@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, linux-arm-msm@vger.kernel.org,
	David Airlie <airlied@gmail.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Abhinav Kumar <abhinav.kumar@linux.dev>
Subject: Re: [PATCH 16/17] dt-bindings: arm-smmu: Add Kaanapali GPU SMMU
Message-ID: <175979919379.698258.13712668305314906075.robh@kernel.org>
References: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
 <20250930-kaana-gpu-support-v1-16-73530b0700ed@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930-kaana-gpu-support-v1-16-73530b0700ed@oss.qualcomm.com>


On Tue, 30 Sep 2025 11:18:21 +0530, Akhil P Oommen wrote:
> Update the devicetree bindings to support the gpu smmu present in
> the Kaanapali chipset.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


