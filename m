Return-Path: <linux-kernel+bounces-886052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF2BC349B2
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 09:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8839356053C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 08:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F69D2E7F1E;
	Wed,  5 Nov 2025 08:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJSPmQEY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638D72E7650;
	Wed,  5 Nov 2025 08:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762332599; cv=none; b=FWxRObC92DsMVPbtE/W9/yU0lSDnOs4QPTmg0VpqsqJ43e2zGLA1pRRHBGPRAZ75AtSWnHhtvyfcnFA4IMutWuOOCIaItzRxSDjHwnNkkKkb2fdBVg6Xb50rzCkSNUYm/PWfc2LcCFxquxIjxtPPwOZf7vyVA2LVRAmKutq5ERA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762332599; c=relaxed/simple;
	bh=2Y1w6bkA2Q5H1e/6/2oG37f+BVtHYYjkIoM1/5dBfiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJsOIFJ5V7kGeTJxihS7OccFKEeTP4ewlq+1JwPgP4Tms3gFg5bUbVkBf3T2emROE9OSSBSTsIoTt9bApPMQHDGQqZ5pTKYKoIU6ZA2l6YxNMS+vGa1jv9S87oLxS+swwG+INvJj63TPW3WmyuZhWwQ+DRxhpEkYpR8QydvHLrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJSPmQEY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EFCBC4CEF8;
	Wed,  5 Nov 2025 08:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762332598;
	bh=2Y1w6bkA2Q5H1e/6/2oG37f+BVtHYYjkIoM1/5dBfiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jJSPmQEYTzfQYPTiek+jRvogb/YBMztLwwi7hhdfdJlXd556tHxFp+VkmjCAfIh41
	 f6Iah2WW4+4Orano4Wim+FwboOprywWhW2OefKKctrEhFFuEVa3APLSatzvawLcIeD
	 P0EZnPODL+7kWzrUaV/s++lRMQAr1KMn3JNxDRVkFOi9Ko7sz9Bd8zidiQSsabIfYO
	 EBx5VpgB7kQqFkRxNOnVUFoD5//NgbaFVVIjic4oqVMLySYmHmf3rbsJxg3tzzzxhh
	 k3dum8VVKQIKdMVrZrL+wbmXFjW3I2CPMOPIS6LTkkzt4YjKph3tQSGRWfeSd17q3p
	 Jcy2tEad3dcrw==
Date: Wed, 5 Nov 2025 09:49:56 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
	linux-media@vger.kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Guoniu Zhou <guoniu.zhou@nxp.com>
Subject: Re: [PATCH v3 1/3] media: dt-bindings: nxp,imx8-isi: Add i.MX95 ISI
 compatible string
Message-ID: <20251105-fancy-practical-saluki-1a6ec8@kuoka>
References: <20251105-isi_imx95-v3-0-3987533cca1c@nxp.com>
 <20251105-isi_imx95-v3-1-3987533cca1c@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251105-isi_imx95-v3-1-3987533cca1c@nxp.com>

On Wed, Nov 05, 2025 at 01:55:10PM +0800, Guoniu Zhou wrote:
> From: Guoniu Zhou <guoniu.zhou@nxp.com>
> 
> The ISI module on i.MX95 supports up to eight channels and four link
> sources to obtain the image data for processing in its pipelines. It
> can process up to eight image sources at the same time.
> 
> Signed-off-by: Guoniu Zhou <guoniu.zhou@nxp.com>
> ---
>  .../devicetree/bindings/media/nxp,imx8-isi.yaml    | 27 +++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


