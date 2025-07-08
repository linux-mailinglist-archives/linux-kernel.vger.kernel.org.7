Return-Path: <linux-kernel+bounces-722393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1976FAFD97F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 23:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 221A33BD5B1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 21:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50E4246764;
	Tue,  8 Jul 2025 21:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZamDFZxo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F014E23D298;
	Tue,  8 Jul 2025 21:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752009381; cv=none; b=g5JmwYOT2GacqArvu0mJF4F6bG8L5Fnlp7rGO2tf5p2zi9RTudpBPyfY4Q3dfcG7dIVLUkykgbOU6//yq1i/nhBltXl1HVC8dwSC63XUl/X/FnAJNeK7cg171eDHdHquL6AipOZ6XwVb6H3m66V8nxWexjoFSVqEndcWA3VhaOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752009381; c=relaxed/simple;
	bh=ltXtFs+FCm7kdZYRy8gh9v9vkGeWsCBaQ7k3C/UgmI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTQN4ghiuRDdVjr7UYRh3hVRWBO9pJd7Yjq1anH4ff93Yc9+ENgZksmLwxsCusvJob3wFjN8x87Se6YMrmF99Y5LVdqblVAT+BtEIsOUcIi9nfvGpb3gHIPjGHmDf7NrppORsUaiZRLxxZbyhV5MqIUEfuFV5/qU3WOcjAMrf8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZamDFZxo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BDE2C4CEED;
	Tue,  8 Jul 2025 21:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752009380;
	bh=ltXtFs+FCm7kdZYRy8gh9v9vkGeWsCBaQ7k3C/UgmI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZamDFZxoUKnJ50jqbuzf+mtCNimN+KnRAHw02TOqvhnP7JYLwu3iAIRak9q6CbuPh
	 Tm9NOOK+IZHdF5YxaVfKzqX1iIO2C1Z7g0G3jF9kByA5pHxPC6eYvpOghY9g2l38Uc
	 w6Rks0L2Jkv3BPhcEOCglupnmTsLWTlO1Y5VQRlohfL1xXRb9d7Z48jJg4wI2cEhaj
	 tZkl0Qtt9tBtM0J/DL3tFlV8Z+VMViPe8aGypq9UF4oa4fwtZmWITcuJURdpQNICfo
	 pZ7ioh1TlUXff8RrD64B5n074XRUvpNFkKeXaHqy/Ck1GNwRpcScus2WLD9/yDMR0l
	 pNMVwtdwZuRyg==
Date: Tue, 8 Jul 2025 16:16:19 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: LiangCheng Wang <zaq14760@gmail.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Maxime Ripard <mripard@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	David Airlie <airlied@gmail.com>, Wig Cheng <onlywig@gmail.com>,
	devicetree@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	dri-devel@lists.freedesktop.org,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Simona Vetter <simona@ffwll.ch>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: Add Mayqueen name
Message-ID: <175200937878.1039013.16279385818262913331.robh@kernel.org>
References: <20250708-drm-v1-0-45055fdadc8a@gmail.com>
 <20250708-drm-v1-1-45055fdadc8a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708-drm-v1-1-45055fdadc8a@gmail.com>


On Tue, 08 Jul 2025 18:06:44 +0800, LiangCheng Wang wrote:
> From: Wig Cheng <onlywig@gmail.com>
> 
> Mayqueen is a Taiwan-based company primarily focused on the development
> of arm64 development boards and e-paper displays.
> 
> Signed-off-by: Wig Cheng <onlywig@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


