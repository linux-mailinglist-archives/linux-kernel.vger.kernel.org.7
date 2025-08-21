Return-Path: <linux-kernel+bounces-779857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A56B2FA59
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9311F18961C7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CD43375DC;
	Thu, 21 Aug 2025 13:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fn5z5mc+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AD13375A7;
	Thu, 21 Aug 2025 13:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782695; cv=none; b=MXJiubU14ZQaHWUyHN6h+F/PED8Poy/sTuHdxUJKIJ+srBAe1tN0fcEV5dJJAgpbjPNo0GgAbxQMPaFa0J30XHmyW9StmCmEOsAUnu6MvzalbYWl5bsVdCMgPib85P3ALtPcHfkOlHxPPS+6rfiHzzzv0gE4pNRs7WWa7d9bDnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782695; c=relaxed/simple;
	bh=ig4z4tnt9l7x37xMppuHnDgvmKZ751NxA2ltoAruDcE=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=lu9kR/OBbSqFqP3g2hUP84zn/BwHCxUxd9T0nUhZ7ucvJgXz3wPAbsKpxt8xLL8dJUfMA/Rl77Sa1cxWFjbyCpG7+lnsf7ISskkHhbGqiYkoWvFCbJZKFCGfysYsHOhtzdlR09hh/Ku6OWhXMNr3ObY46jCOmxvJqouAvUPFLeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fn5z5mc+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C700C116C6;
	Thu, 21 Aug 2025 13:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755782695;
	bh=ig4z4tnt9l7x37xMppuHnDgvmKZ751NxA2ltoAruDcE=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=fn5z5mc+1kgrUEx5Wawgdva2u8IvuLmJbamexcV/AVy5q29ZTYqRGEvnRqsY3lSsN
	 lmOqqI89tae8H9lk0XRIs4NbBCNKhRuf7/VVLlwT8rjFntk2mHLMpYUr95rY2RL3iC
	 qXb+UegseJ7NQv71CcAPG/XPV5oaCKHh/+RWrejwofWWb62f82yBwnap8bqoRzfl3p
	 btWTTfGjW1F7BzV6wvvOOVnYqwW9QITLkG2dwpJPm5ObjV6H7wY4BbTiNDmsxnEN7u
	 e4pRZDpo/fZfRilQ/58M+orohl1Nd9RjD7f/0fKF7xGrAQLkKvDpxeDoJLjd/iWzRC
	 aTlpAOkWtOaGQ==
Date: Thu, 21 Aug 2025 08:24:53 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, Guenter Roeck <groeck@chromium.org>, 
 Tim Harvey <tharvey@gateworks.com>, Mathew McBride <matt@traverse.com.au>, 
 Lee Jones <lee@kernel.org>, Benson Leung <bleung@chromium.org>, 
 chrome-platform@lists.linux.dev, Michael Walle <mwalle@kernel.org>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250821062840.9383-2-krzysztof.kozlowski@linaro.org>
References: <20250821062840.9383-2-krzysztof.kozlowski@linaro.org>
Message-Id: <175578240828.3438836.9383803134622022528.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: mfd: Move embedded controllers to own
 directory


On Thu, 21 Aug 2025 08:28:41 +0200, Krzysztof Kozlowski wrote:
> Move ChromeOS Embedded Controller, Gateworks System Controller and
> Kontron sl28cpld Board Management Controller to new subdirectory
> "embedded-controller" matching their purpose.  MFD is coming from Linux
> and does not really fit the actual purpose of this hardware.
> 
> Rename Gateworks GSC filename to match compatible, as preferred for
> bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: Mathew McBride <matt@traverse.com.au>
> 
> Lee,
> Can you take it via MFD?
> ---
>  .../bindings/{mfd => embedded-controller}/google,cros-ec.yaml | 2 +-
>  .../gateworks-gsc.yaml => embedded-controller/gw,gsc.yaml}    | 2 +-
>  .../{mfd => embedded-controller}/kontron,sl28cpld.yaml        | 2 +-
>  MAINTAINERS                                                   | 4 ++--
>  4 files changed, 5 insertions(+), 5 deletions(-)
>  rename Documentation/devicetree/bindings/{mfd => embedded-controller}/google,cros-ec.yaml (99%)
>  rename Documentation/devicetree/bindings/{mfd/gateworks-gsc.yaml => embedded-controller/gw,gsc.yaml} (98%)
>  rename Documentation/devicetree/bindings/{mfd => embedded-controller}/kontron,sl28cpld.yaml (97%)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml:
	Error in referenced schema matching $id: http://devicetree.org/schemas/mfd/google,cros-ec.yaml
	Tried these paths (check schema $id if path is wrong):
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
	/usr/local/lib/python3.13/dist-packages/dtschema/schemas/mfd/google,cros-ec.yaml

/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/remoteproc/mtk,scp.example.dtb: scp@10500000 (mediatek,mt8192-scp): cros-ec-rpmsg: {'compatible': ['google,cros-ec-rpmsg'], 'mediatek,rpmsg-name': ['cros-ec-rpmsg']} should not be valid under {'description': "Can't find referenced schema: http://devicetree.org/schemas/mfd/google,cros-ec.yaml#"}
	from schema $id: http://devicetree.org/schemas/remoteproc/mtk,scp.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/remoteproc/mtk,scp.example.dtb: scp@10500000 (mediatek,mt8192-scp): cros-ec-rpmsg: Unevaluated properties are not allowed ('compatible', 'mediatek,rpmsg-name' were unexpected)
	from schema $id: http://devicetree.org/schemas/remoteproc/mtk,scp.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/remoteproc/mtk,scp.example.dtb: scp@10500000 (mediatek,mt8195-scp-dual): scp@0:cros-ec-rpmsg: {'compatible': ['google,cros-ec-rpmsg'], 'mediatek,rpmsg-name': ['cros-ec-rpmsg']} should not be valid under {'description': "Can't find referenced schema: http://devicetree.org/schemas/mfd/google,cros-ec.yaml#"}
	from schema $id: http://devicetree.org/schemas/remoteproc/mtk,scp.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/remoteproc/mtk,scp.example.dtb: scp@10500000 (mediatek,mt8195-scp-dual): scp@0:cros-ec-rpmsg: Unevaluated properties are not allowed ('compatible', 'mediatek,rpmsg-name' were unexpected)
	from schema $id: http://devicetree.org/schemas/remoteproc/mtk,scp.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/remoteproc/mtk,scp.example.dtb: scp@10500000 (mediatek,mt8195-scp-dual): scp@a0000:cros-ec-rpmsg: {'compatible': ['google,cros-ec-rpmsg'], 'mediatek,rpmsg-name': ['cros-ec-rpmsg']} should not be valid under {'description': "Can't find referenced schema: http://devicetree.org/schemas/mfd/google,cros-ec.yaml#"}
	from schema $id: http://devicetree.org/schemas/remoteproc/mtk,scp.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/remoteproc/mtk,scp.example.dtb: scp@10500000 (mediatek,mt8195-scp-dual): scp@a0000:cros-ec-rpmsg: Unevaluated properties are not allowed ('compatible', 'mediatek,rpmsg-name' were unexpected)
	from schema $id: http://devicetree.org/schemas/remoteproc/mtk,scp.yaml#

doc reference errors (make refcheckdocs):
Warning: Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
Warning: Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml: Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml: Documentation/devicetree/bindings/mfd/google,cros-ec.yaml

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250821062840.9383-2-krzysztof.kozlowski@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


