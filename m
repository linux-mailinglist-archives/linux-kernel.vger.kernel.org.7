Return-Path: <linux-kernel+bounces-854305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D77ACBDE0E6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 543D0427E7C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF132E283E;
	Wed, 15 Oct 2025 10:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1kbWUUT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5742F2BD029;
	Wed, 15 Oct 2025 10:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760524750; cv=none; b=G+9KAHNYVDZeUyv4wBOKN+VkVh8fXqOrVC1uc5vss/m0kEEscl6xnXKmf9SA6t/F7xywPWtpa5+VSFBPdAsrVuTv8NuFFMzhOObbECAYtbtyoI7AC2uNxN8awyBl/v4oL6QvQqOWw8qmIUghv8F8NV+W5kPvcoytTwsR77/PpA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760524750; c=relaxed/simple;
	bh=fkV88xzNOBxhiJYAzo+vp0/1S65ulX6h08+Utw4UAHY=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=CTiVJ8o401Yqf4V8qanpoh0vpATiWPpeft2gJzUAm5i9TxvkuN8BVeaXx75eVev6WfLccus9NEic2WsHCj8e96pZq/7pSN6BRqnVzQWe8pMOBlSIiNOGrfjLEhzk9iZQ4LAtwjxi2Bk8/cpfT8wGE5oSimfOan1aLOadaklgPgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1kbWUUT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D136AC4CEF8;
	Wed, 15 Oct 2025 10:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760524750;
	bh=fkV88xzNOBxhiJYAzo+vp0/1S65ulX6h08+Utw4UAHY=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=r1kbWUUTOfxyTdTPwOXpt39Rpr8e7g1k8pMwRkH/8bBKDHa484BEmKPOB9VengnP3
	 NeS4SFddmrPG/QoJT+QgM7+3MeA+MkssTYBKum/xlh86P4T8kPaFkvqLu57S5BrA7/
	 TNNcd6rXOIPuj6tvTXizxjjtkmH6XNyA3PtSBfp66sQkcY+WowJMWwA2Z2AAwnqu7q
	 ZKqsKyLrj+tG/Vni9KON3tR0GmyvuAp7PPn7lFRhEkqDTlMNxSq7noeisouuPY1CVJ
	 jIAXSEDUUM8Pta6qec8WdaUs5TZIOs/jzhoK7itDGZqd0f6WxHJxTiYAu7X05u/pRz
	 pfEloxPhWVd6A==
Date: Wed, 15 Oct 2025 05:39:08 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: huangtao@rock-chips.com, mturquette@baylibre.com, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-clk@vger.kernel.org, heiko@sntech.de, linux-kernel@vger.kernel.org, 
 sboyd@kernel.org, linux-rockchip@lists.infradead.org, 
 sugar.zhang@rock-chips.com, krzysztof.kozlowski+dt@linaro.org, 
 conor+dt@kernel.org
To: Elaine Zhang <zhangqing@rock-chips.com>
In-Reply-To: <20251015091325.71333-5-zhangqing@rock-chips.com>
References: <20251015091325.71333-1-zhangqing@rock-chips.com>
 <20251015091325.71333-5-zhangqing@rock-chips.com>
Message-Id: <176052474812.2747948.16094630687510808403.robh@kernel.org>
Subject: Re: [PATCH v1 4/5] dt-bindings: clock: Add support for rockchip
 pvtpll


On Wed, 15 Oct 2025 17:13:24 +0800, Elaine Zhang wrote:
> Add pvtpll documentation for rockchip.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  .../bindings/clock/rockchip,clk-pvtpll.yaml   | 100 ++++++++++++++++++
>  1 file changed, 100 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/rockchip,clk-pvtpll.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Lexical error: Documentation/devicetree/bindings/clock/rockchip,clk-pvtpll.example.dts:21.26-32 Unexpected 'ARMCLK'
Lexical error: Documentation/devicetree/bindings/clock/rockchip,clk-pvtpll.example.dts:117.26-35 Unexpected 'ACLK_RKNN'
FATAL ERROR: Syntax error parsing input tree
make[2]: *** [scripts/Makefile.dtbs:132: Documentation/devicetree/bindings/clock/rockchip,clk-pvtpll.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1525: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251015091325.71333-5-zhangqing@rock-chips.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


