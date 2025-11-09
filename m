Return-Path: <linux-kernel+bounces-892066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E179C44461
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 18:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEE341888CB7
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 17:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B939B307AC4;
	Sun,  9 Nov 2025 17:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXG8AE28"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BB3306B01;
	Sun,  9 Nov 2025 17:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762708732; cv=none; b=Iws77et4eIqxF/LZfBJS4ixsXum8JV39ZMbzyINdN2HB5pPn4d9vCwnYq/6vwmVVxfuDfJeJe9HW/mqZ4FkrtHG4RKNAUupgmkMSej94QJkXyaEYOvjAWT9mXPr8SPOOaePHrh6eQJzIDmU/aoq/cf7hzqisukwdMPv42+JZ0X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762708732; c=relaxed/simple;
	bh=nkg22z2ppe49/uZ19yN89Sdc29GKykFNpzXJ4F3iA/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2HNlHjDOZ4b8+ABLZA2dMebKuGRT1xpfPA/lSjVr+8yRhqU9iX68RxlJHChW5pJdrKkEXVz5EvcbK/QDBFe6laL+xRoH2zpS03oDOCRkdGCQCLeun0QbhXzRnoKDEPh28ZE0a/MkNiC71jXKVrmxw858qIOv2Gpquf1awnIenE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXG8AE28; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24ECDC116B1;
	Sun,  9 Nov 2025 17:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762708730;
	bh=nkg22z2ppe49/uZ19yN89Sdc29GKykFNpzXJ4F3iA/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eXG8AE28GKIpIYZIwueusJtwfyOJlBocHS+VPXjIcCGWTX93woRqN4kaFecAg5WJT
	 n3weM/e9nncrJeWTPI+yymUok3KRorbpaBBJAIapsehImnSrtJNg2bJA5yIjtuc9N1
	 9/QzCOlJtvzcJYpqdEyAhet5UPq2U1AlbXh3WT+FggxSHRAxjSFlrXEi6g3kuYdhQ2
	 JYyFe6Ow8y0D8ZIx6SiG+1EEFyGFpG9LtNFsWsx1KsYu7JDgXjRnETSrqEmekoBdpr
	 NTyzvwzcm7xjrswvbN771zsOQf1/rKMrKptKD5NKIpPMLv4QGMCgkUEFYE166wbxai
	 k2kOF+eC8QE8Q==
Date: Sun, 9 Nov 2025 18:18:48 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alex Tran <alex.t.tran@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Hans Verkuil <hverkuil+cisco@kernel.org>, 
	linux-media@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] dt-bindings: media: i2c: et8ek8: document missing
 crc as optional property
Message-ID: <20251109-hospitable-poised-scorpion-bdf833@kuoka>
References: <20251108233200.2068334-1-alex.t.tran@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251108233200.2068334-1-alex.t.tran@gmail.com>

On Sat, Nov 08, 2025 at 03:32:00PM -0800, Alex Tran wrote:
> Add the optional crc property to the endpoint node for the et8ek8 sensor.
> This property enables CRC checksums for the sensor bus and was added to
> match the new driver support for reading it from the device tree.

We do not add bindings because you want this in the driver. Please
describe the hardware.

> 
> Signed-off-by: Alex Tran <alex.t.tran@gmail.com>

Your patchser has broken threading. There is no patch #1.

> ---
>  .../devicetree/bindings/media/i2c/toshiba,et8ek8.txt        | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/toshiba,et8ek8.txt b/Documentation/devicetree/bindings/media/i2c/toshiba,et8ek8.txt
> index 8d8e40c56..5fd30f59b 100644
> --- a/Documentation/devicetree/bindings/media/i2c/toshiba,et8ek8.txt
> +++ b/Documentation/devicetree/bindings/media/i2c/toshiba,et8ek8.txt
> @@ -30,6 +30,12 @@ Endpoint node mandatory properties
>  - remote-endpoint: A phandle to the bus receiver's endpoint node.
>  
>  
> +Endpoint node optional properties
> +---------------------------------
> +
> +- crc: Enable CRC checksums.

Looks like SW property, so not really suitable for bindings.

Also, no changes to TXT bindings are accepted, so first this would have
to be converted to DT schema.

Best regards,
Krzysztof


