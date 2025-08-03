Return-Path: <linux-kernel+bounces-754458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2865B19484
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 18:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75DFE3B4F33
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 16:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA79E1D6DA9;
	Sun,  3 Aug 2025 16:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDcKqE33"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC8B23AD;
	Sun,  3 Aug 2025 16:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754240004; cv=none; b=fb+K/IzJyxr6WH+t6DuHCFVhCOY5fbrvbvZTnu0INZuAFPSmj60jostqIS3hdxCQhT7tw1NfPiK771KuymZSFTJ0jOBXtF/1icoDK8uQPd4iFG7mFCBrVO1VnzILZcWNCWRyu3B3NieB9rkXrctvFZRbtz95Uobne11R8kDOG00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754240004; c=relaxed/simple;
	bh=qezdTFcR7X537i4pxy5meG/TintI1Jbhp+Yp8Rrbvn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEp19JimTc2RNJWwZ2xvcs8kI4crmXZg2VHPjk8T2oQ+9J5AdKp1NYzuth0xVpxx2BkgCSnsiLMDo7fkILt85ZzgpZlpenn9Fay29P8VCzGc9pv8ykJXgus8DO5lgEvVZpnW902YeixJJKK7yCAD/AKB3gCp5huqWET2V2uha7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDcKqE33; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC5EC4CEEB;
	Sun,  3 Aug 2025 16:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754240003;
	bh=qezdTFcR7X537i4pxy5meG/TintI1Jbhp+Yp8Rrbvn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QDcKqE33CcTBcv8Z+MBG0ZBWBEx5VCPWrvJtmTBUfU2xc/2nZSFDelYBDKm38ANpk
	 PeijJbflJhwyEZrNj5L2fe5hNeXZu3vi36TtscWjnaPl9wG2Bxu0EcmM0mD6vvVUxY
	 v2JEpin1I4WyGS7ELosG/KjPpXkGLo1ede6/NLxU8/nnDIkQQMQJXby2YJcwVN4wF6
	 1YJOLg1sez03QPzmEPMLLuwmRARlbI2lo+47TP+YRDxw2XJQg00cqZnQSzPkzbll2Y
	 9iP1KtGVIvoKHRY/vAzgMkeKFFo1LI1pNlGCaUo0DLTgGcuuZMUYtX5arS90ym1u3W
	 Qi+JbcXcjoBrw==
Date: Sun, 3 Aug 2025 11:53:22 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Otto =?iso-8859-1?Q?Pfl=FCger?= <otto.pflueger@abscue.de>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Kevin Tang <kevin3.tang@gmail.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kevin Tang <kevin.tang@unisoc.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>, Simona Vetter <simona@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH v3 01/16] dt-bindings: display: sprd: adapt for UMS9230
 support
Message-ID: <175424000200.522677.10470224183997281701.robh@kernel.org>
References: <20250731-ums9230-drm-v3-0-06d4f57c4b08@abscue.de>
 <20250731-ums9230-drm-v3-1-06d4f57c4b08@abscue.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250731-ums9230-drm-v3-1-06d4f57c4b08@abscue.de>


On Thu, 31 Jul 2025 17:51:14 +0200, Otto Pflüger wrote:
> Add new compatible strings for the DPU and DSI controller found in the
> UMS9230 SoC.
> 
> Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
> ---
>  .../devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml         | 7 ++++++-
>  .../devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml    | 4 +++-
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


