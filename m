Return-Path: <linux-kernel+bounces-761982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E66B200B9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E1FB420946
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846932D9EF6;
	Mon, 11 Aug 2025 07:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pS0s9wkg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3481F03D9;
	Mon, 11 Aug 2025 07:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754898541; cv=none; b=OFYbyL7zjh7PQ9e9XXTZ2rHcIkl20YhpKAgCqd5ht4590kyKpu7y5aXG0d2zZLkTszz4w7x+DPhH+L3NkDNQ3qpOUWX/TFUbBr/e36mVbj1GMJRTWe54+m3mRz4v5X1buhyCQOljrT8O4WBRphlYwHpr+gVXY3VyMNBzDslLmjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754898541; c=relaxed/simple;
	bh=baeyeGu2iP9CInxAIYDtexBroZfdM4XJvypIfebRVLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CiW5BAntAVqM6M1TRJqpB1XbwZ1Dvf67WDofpYYd1GlxXqhGzh+kyuDeClO7WWkJh7cxxyMuyPw2BfxPLs54nCwqmGakT3jbFbWjwqZvdjX8WWzC8Iyqk19yZrf8bwpJsCzheFHr7jF4sXV0GmjkJYsrqq06Utj8BdlH5tDPUXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pS0s9wkg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67D9C4CEED;
	Mon, 11 Aug 2025 07:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754898539;
	bh=baeyeGu2iP9CInxAIYDtexBroZfdM4XJvypIfebRVLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pS0s9wkgtFc5B6v3228fIKrwjz7UIgdcv0vXy/fqkPBjTdyOcFAZBFlHoj8WF+BVD
	 KRjPMTHENl03ZVJv4l/y4D60A/L6+eYNk2kxuILQDPOZjLuC1v9cj/J+mCNmkePQC6
	 Y7ROJV4UUelNuVz/goa2hJ/K8DO0EcVXEuekzmZOs7wqGyJqixjsCVBXZmTjNA8ThI
	 zxgz1RN3CJBIk9zV7dywLiNreq7JTIFzvMB4DKrX0G6qL9fl+JDrKrjbeB52RwRW3D
	 qFIArXZKoI8RA9UP/rqVS+JVSYC8w4Lqy4eSv0HEsxP26+3SU5DoBuM6K/auqx50co
	 NJxVzKxw0uHWQ==
Date: Mon, 11 Aug 2025 09:48:56 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jay Liu <jay.liu@mediatek.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/6] dt-bindings: display: mediatek: dither: Add
 support for MT8196
Message-ID: <20250811-unique-finicky-toad-cc56a2@kuoka>
References: <20250808125512.9788-1-jay.liu@mediatek.com>
 <20250808125512.9788-3-jay.liu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250808125512.9788-3-jay.liu@mediatek.com>

On Fri, Aug 08, 2025 at 08:53:57PM +0800, Jay Liu wrote:
> Add a compatible string for the DITHER IP found in the MT8196 SoC.
> Each DITHER IP of this SoC is fully compatible with the ones found
> in MT8183.
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Jay Liu <jay.liu@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,dither.yaml    | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


