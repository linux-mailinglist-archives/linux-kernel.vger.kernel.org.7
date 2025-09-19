Return-Path: <linux-kernel+bounces-823987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F083B87DDE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 06:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7BB1C8434E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 04:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBAC26529A;
	Fri, 19 Sep 2025 04:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9GesE2i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2311FDA;
	Fri, 19 Sep 2025 04:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758256356; cv=none; b=AJ9JaQxlZ+iXR/FmaCS/0UyyiDz0VOXaFduEpgKT1ui/70ZZmn0oMCyU377RUtDUWaLt22xiNxTrNWgglrfH42rS46jYr9x9WzcVKoXWYfOkDhexzFruCBxRopK4NVA3Bqg4SP53PjSgRYSgWZIkM4qGmc0CkF6heACxobVqy1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758256356; c=relaxed/simple;
	bh=3a5ARfQN6M49MZNrLnb8vQh0OVxHf2I5dFYOmr8qHDY=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=XpHwbzDSKx4HqJSYzxXSwRhXqekWzzCPnvCKTOKzN9z8xYff/er125vj1EujAIPsQ8UBcsn55XLfo+0THnn1ficA4gWuKP5bvVyU8QiHiRdGzG7jNDCszGguAFdob8MxghcolRysQc7F2n/Zbu23pA5c0zXbIFh3P2vfUW+BCII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9GesE2i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2412FC4CEF0;
	Fri, 19 Sep 2025 04:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758256355;
	bh=3a5ARfQN6M49MZNrLnb8vQh0OVxHf2I5dFYOmr8qHDY=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=a9GesE2i8kYtgEJK/zxCLE/hVnQBvVSQXSRZLkkOiZU/t4xaOaTE5rLYrHfsjAaEA
	 e+hacSlEKswWMzU+rONH0cy8S/SNgJrzWmgeza3M9C7khzSWUTQA4w1uVeiWWVOKxH
	 7DH17A9jhPOPxoaocsdW0vJAqhCAuvHc0b2E7xQ6QniWdc003vWjqyHhOfpRrEod4w
	 XrdZ22YTQBUNjkyyymtq95l2ItJAAnYtIYbXiOoKm+nbc9tdHxVrHdnyFu2PCUvrhh
	 imn6tkgLb9x4oeIzzMbMEIDR4uz62paJyWRzyLVvHs6OeULtHEkIdEJjLr4pfd6j6m
	 KpYEIFLhp8F5Q==
Date: Thu, 18 Sep 2025 23:32:33 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, linux-usb@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Alan Stern <stern@rowland.harvard.edu>
To: Ryan Chen <ryan_chen@aspeedtech.com>
In-Reply-To: <20250919025712.719246-4-ryan_chen@aspeedtech.com>
References: <20250919025712.719246-1-ryan_chen@aspeedtech.com>
 <20250919025712.719246-4-ryan_chen@aspeedtech.com>
Message-Id: <175825635392.3818629.9388010825543490994.robh@kernel.org>
Subject: Re: [PATCH v3 3/4] dt-bindings: usb: uhci: Add Aspeed AST2700
 compatible


On Fri, 19 Sep 2025 10:57:11 +0800, Ryan Chen wrote:
> Add the compatible string for Aspeed AST2700 SoC.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  Documentation/devicetree/bindings/usb/usb-uhci.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/usb/usb-uhci.yaml:57:2: [error] syntax error: expected <block end>, but found '<block sequence start>' (syntax)
./Documentation/devicetree/bindings/usb/usb-uhci.yaml:58:7: [warning] wrong indentation: expected 5 but found 6 (indentation)
./Documentation/devicetree/bindings/usb/usb-uhci.yaml:62:5: [warning] wrong indentation: expected 3 but found 4 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/usb-uhci.yaml: ignoring, error parsing file
./Documentation/devicetree/bindings/usb/usb-uhci.yaml:57:2: expected <block end>, but found '<block sequence start>'
make[2]: *** Deleting file 'Documentation/devicetree/bindings/usb/usb-uhci.example.dts'
Documentation/devicetree/bindings/usb/usb-uhci.yaml:57:2: expected <block end>, but found '<block sequence start>'
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/usb/usb-uhci.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1525: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250919025712.719246-4-ryan_chen@aspeedtech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


