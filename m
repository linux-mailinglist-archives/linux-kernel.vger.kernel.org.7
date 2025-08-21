Return-Path: <linux-kernel+bounces-780800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E68CB3098F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 00:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2D693BF2AC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 22:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FB42EC57E;
	Thu, 21 Aug 2025 22:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsOTfEIS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFCC2EBDE0;
	Thu, 21 Aug 2025 22:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755815990; cv=none; b=P+ntV4BcNnehSez8d/+AUc2ZBIHzv0AzyzEckkATSivnbL6BmdhG9rW6zePg3h6ewI05y8QmUsfcRhTloSxyL8WfYVTS/4UY4pxXfki9u8cSHFM+tN2x+GMRjc9AS9MaKVn5Y05Dv/yoScYjrYqTZbZ+zsm5itI7ePSFKq/Gmmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755815990; c=relaxed/simple;
	bh=io9I6VGK8q7KzQy6KUpb2S3gNX6eTucWeJnH+LIZ/Ow=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=ne/dAqeZAC/S3JEvSt3PaFTa8hEDwGLoaEbWjOQprL5sT5b838b9y1wZqJDn2EPUcxL6JURHj901rvgT8pH4uD2OL9z9q4Cpa5DlMe4RENEDw2JvHyjfKKBpr3/YK8I+tOg97DqGNDALxWZ6w2q1HKd1ye5jIP1a99+B6iSZhME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsOTfEIS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF9BEC4CEF4;
	Thu, 21 Aug 2025 22:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755815990;
	bh=io9I6VGK8q7KzQy6KUpb2S3gNX6eTucWeJnH+LIZ/Ow=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=AsOTfEISq7BGKYDIyO9Uzzsq6FNFQjGpsTT1dUPbb4yM0OF55Yx3c5HYElfCcnxMg
	 bCc0W+ORNFSQ5okY3uOBXlNbvqTFysBiqzGpFeRdTFXUlggzKqzQ9GXfHEALFfxDIM
	 HHiHArFJLSOFvLpdqJvNt6783wxLcAlkxr+h98+Qw6xv99sSukhlxcINWm2EWFcTui
	 dRaC7JPyVRuw1OLj7jpc/Hr+3mdeZmbneSU47rHljZCPjRzo2S8qXZmLcay5FdvGWz
	 93ue2fFidCRPK3P2mjWRdYBGRn+0V2Sjdqx1wXppFqHCaz8vi3+ojg1zLbE3Bf1Dfr
	 m8M0Bi3669iZA==
Date: Thu, 21 Aug 2025 17:39:48 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
In-Reply-To: <20250821152429.26995-2-jszhang@kernel.org>
References: <20250821152429.26995-1-jszhang@kernel.org>
 <20250821152429.26995-2-jszhang@kernel.org>
Message-Id: <175581575625.1136124.14166801245928231276.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: timer: Add ARM SSE(Subsystems for
 Embedded) timer


On Thu, 21 Aug 2025 23:24:28 +0800, Jisheng Zhang wrote:
> Add binding doc for the ARM SSE(Subsystems for Embedded) timer. Here
> is the document URL:
> https://developer.arm.com/documentation/107610/0000/System-timer-components?lang=en
> 
> Although the IP is mostly seen on MCU SoC platforms, but nothing
> prevent it from being integrated into linux capable SoC platforms.
> 
> The IP core may have a system counter to generate timestamp value,
> a system timer to raise an interrupt when a period has elapsed, and
> a System Watchdog to detect errant system behaviour then reset the
> system if a period elapses without ping.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  .../bindings/timer/arm,sse_timer.yaml         | 90 +++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/arm,sse_timer.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/timer/arm,sse_timer.yaml:43:111: [warning] line too long (145 > 110 characters) (line-length)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/timer/arm,sse_timer.yaml: patternProperties:^frame@[0-9a-f]+$:properties:interrupts: 'oneOf' conditional failed, one must be fixed:
	[{'description': 'timer irq'}] is too short
	False schema does not allow 1
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250821152429.26995-2-jszhang@kernel.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


