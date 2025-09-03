Return-Path: <linux-kernel+bounces-799100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 113C9B426FA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B64AE7AC2C0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6082F99A4;
	Wed,  3 Sep 2025 16:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5BLGUmj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1175B63CF;
	Wed,  3 Sep 2025 16:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756917195; cv=none; b=U/0ZWQ0FbpupzRP0//EPJT3THA/F6L+tFbpGyHGVnkIzVVrlJxPVk00YAts9Irryy1FbitCpX+xOn4kPMUAI4g0qwNMIvLGzCMgYWeWQxqxzy4rQicpI5PXWpHuCIgkBYsRxxi5Ha8HDm8oXc8XVrxMgNz972cy0bY8dAf8n7o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756917195; c=relaxed/simple;
	bh=lXGbRbBGPukctJiSqyL/CgDyF8977mhP+cJ851KLN20=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=PjuOBOJjxUasCnsKUmaIZxpZ4NSF0twjCpyfX+CrCvmLK719RqoAczvyou9vVjnOGjyN9lz3PxouJYwjs7V7e6LefIBkvsRT7PWy0kgUycW8trTuSDPFOGhmnmNo8woFTKN4pmUDJMaSPNm48UH09NCFhAV3v4DqevT25EqAMlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5BLGUmj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AEC2C4CEE7;
	Wed,  3 Sep 2025 16:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756917194;
	bh=lXGbRbBGPukctJiSqyL/CgDyF8977mhP+cJ851KLN20=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=T5BLGUmjdfEK8W/sDyCOl/2csWAxLz0kRN1hBp5T87MlliGPflUg2uOYpARqtxpj+
	 HcG0JU+aI5k8ENu/dsIXOr5DqBLnwtRihq0hN+aU1qopV+YoTUoE11wqAnZZaxrkhw
	 nPAjDQD4qtPKsKzSyG7txdpD4etFhBEUoS9t1LRUHII2bTTjskXxyJ3VmEj21ZNzBH
	 +73nPfw33w50jXZny0Eo3KCIr6bL5iQA19lvz8aU2+5dzaxoRZ2ISysaA+aQDABf+H
	 j/dkaYQ8s8pJR8KiT/X8leXhWfYlAZkN1HVWVyTsXSkLtcESMb1Zog3qM8PtVxgWB1
	 hZCUKUcjNImPQ==
Date: Wed, 03 Sep 2025 11:33:13 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: neil.armstrong@linaro.org, devicetree@vger.kernel.org, 
 Laurent.pinchart@ideasonboard.com, yangsunyun1993@gmail.com, 
 andrzej.hajda@intel.com, jonas@kwiboo.se, dri-devel@lists.freedesktop.org, 
 rfoss@kernel.org, jernej.skrabec@gmail.com, krzk+dt@kernel.org, 
 conor+dt@kernel.org, linux-kernel@vger.kernel.org
To: syyang <syyang@lontium.com>
In-Reply-To: <20250903123825.1721443-2-syyang@lontium.com>
References: <20250903123825.1721443-1-syyang@lontium.com>
 <20250903123825.1721443-2-syyang@lontium.com>
Message-Id: <175691717884.2393851.6340903042726389490.robh@kernel.org>
Subject: Re: [PATCH v1 1/2] This patch adds a new device tree binding
 documentation.


On Wed, 03 Sep 2025 05:38:24 -0700, syyang wrote:
> - New device tree binding documentation at
>   Documentation/devicetree/bindings/display/bridge/lontium,lt9611c.yaml
> 
> Signed-off-by: syyang <syyang@lontium.com>
> ---
>  .../display/bridge/lontium,lt9611c.yaml       | 123 ++++++++++++++++++
>  1 file changed, 123 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/lontium,lt9611c.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/bridge/lontium,lt9611c.yaml: warning: ignoring duplicate '$id' value 'http://devicetree.org/schemas/display/bridge/lontium,lt9611.yaml#'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/bridge/lontium,lt9611c.yaml: $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
 	 $id: http://devicetree.org/schemas/display/bridge/lontium,lt9611.yaml
 	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/bridge/lontium,lt9611c.yaml
Documentation/devicetree/bindings/display/bridge/lontium,lt9611c.example.dtb: /example-0/i2c10/hdmi-bridge@41: failed to match any schema with compatible: ['lontium,lt9611c']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250903123825.1721443-2-syyang@lontium.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


