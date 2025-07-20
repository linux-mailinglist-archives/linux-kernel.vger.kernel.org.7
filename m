Return-Path: <linux-kernel+bounces-738502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 111FAB0B93F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 01:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0011A7A3C2B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 23:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC69922CBE6;
	Sun, 20 Jul 2025 23:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPshk5gB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4698E8BF8;
	Sun, 20 Jul 2025 23:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753054378; cv=none; b=SydkofWvk8B1hmSMIMLmeYZqo0gUH0LgIfEr0MM2HHPU9MNCHtl5p6eZ00eslTPnjjbqQyKRkYF+KmdrMBc3z03sqApTMvqNhFX+l8fK8GrNWoTx5usgpuUEVeopvT8gnOlxj1TaT7PFYaCxt0Cmvo6gu4NdRynnJXky3xcuIfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753054378; c=relaxed/simple;
	bh=RWzw0XSPmQWo0yyYpdgifZLEFyFQUyfb+2mlWFliVck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCoEFW4g7+cSoP2KyboZwqD+eR5bZXPI9QuRK8ncYFWzXdWBGG0LISF4KVM79vEDrAZFxYZBi2nBUJryoybRHhBm8g877g3Gq62q0xvHNzTsZq1iFp3b6DItlJR3uc4phYa7DKWerz64b5bNCITL7d1wQIy8vXKZxStp9FU+vlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPshk5gB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1DB9C4CEE7;
	Sun, 20 Jul 2025 23:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753054377;
	bh=RWzw0XSPmQWo0yyYpdgifZLEFyFQUyfb+2mlWFliVck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hPshk5gB24uJbZXtW3soM7eQk8qsqUoAKCAQ6/KkBG9aTsQkfP5NP0/e1VcE58pq7
	 3l+nb777W4YUxChIdTz4usAK5jiOexBieszc2fiuNHY0S0aRgHoZmEhga+NsvOyv67
	 DO2XmvzyOCoaUrqZpZeyZNCyd0tOBlSUzLm32jtT1kTdPe+KoIbRuf1fbvi8kHSh0F
	 aQw8IJOiiqOcXhIhx0Q9PffxfDHxiqe6BsnoGgSn6xuwXHdKYl65y/h4UfUMd7JhRw
	 cU8XzrxnTZCBpwGpy6Di2dOApHVqMo2bPaKxcoADzd3vmTFIv/AefqWa5xDf4o2lHm
	 qzU77vlo30lFg==
Date: Sun, 20 Jul 2025 18:32:57 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>,
	Simona Vetter <simona@ffwll.ch>, Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v1 1/2] dt-bindings: display: panel: Document Hydis
 HV101HD1 DSI panel
Message-ID: <175305437636.3071163.14273228535635494887.robh@kernel.org>
References: <20250717135752.55958-1-clamor95@gmail.com>
 <20250717135752.55958-2-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717135752.55958-2-clamor95@gmail.com>


On Thu, 17 Jul 2025 16:57:51 +0300, Svyatoslav Ryhel wrote:
> Hydis HV101HD1 is a 2-lane 1366x768 MIPI DSI panel found in ASUS VivoTab RT
> TF600T tablet.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../display/panel/hydis,hv101hd1.yaml         | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/hydis,hv101hd1.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


