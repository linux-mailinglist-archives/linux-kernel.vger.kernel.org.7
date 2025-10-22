Return-Path: <linux-kernel+bounces-864493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F421BFAE5C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02556485965
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1A230CDB6;
	Wed, 22 Oct 2025 08:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlvaVfNC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C29309F06;
	Wed, 22 Oct 2025 08:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761121788; cv=none; b=W9gIQd4dbeBGjiwCasRm4hP7tnoHxoKTTz08z03dRh6YGzq3tsoV49YbUelVSEh+hX5p7GXTHsMdRjdx1XnW9S/3xwGuMzN+s6oEFSuKwLbdRSWl0B6HBmkd18Ue/HSEez2OQiSxcgoKXwJUunVpDNE8CbG2C1Yz1a0t2bETFyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761121788; c=relaxed/simple;
	bh=bJvkdLkKFo0sTg8s8eWRSm9R4+waidmhRJp00c5NgGo=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=NdrVbBjyPgxn3VmZWK7vxv9vYWKiiTyUAh/A5AgrYWxcXhmKhlA8DSCS7Durx9aLMV/Kjuw6JkBIl49IoqTxmpZKei0iTIvcirthIWJybSI82ANLgpI7kSrkg2Qturwm6TuGNQSfXmDD27KtVAb34t20Q8Ve6MZlAfz/UmtEke4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlvaVfNC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4832C4CEF5;
	Wed, 22 Oct 2025 08:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761121786;
	bh=bJvkdLkKFo0sTg8s8eWRSm9R4+waidmhRJp00c5NgGo=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=WlvaVfNCIyo0A4mIEINni15Pmtn2QUO/oxkwZyta/5wSgisbjCfOWSke/UqJucMpR
	 h6BjpROGL77x5P72guB7+pxCArRuVD8PBpJz5akRFSUf/ZwqZbPj0rmmK4hKu1M+G3
	 Xe/446NTd49UIcVX6NT5waN3TKkEOBFzOE+Mrglsjl5aUSx0G1wEh2knXIcNuNl2f4
	 abRjfaFDFM+xU8HxAWtYAkIFXvrAXm/GsDtIWyHhjUJ/DyYVhNQnXR8BjtULqPqiBF
	 3qjmjHWuDvMquALiJRvU08PJqjSMxiSToG84NJB02WYcQpHTuZtKlAIrGvymMBl9hY
	 xekgbD/yoq0VQ==
Date: Wed, 22 Oct 2025 03:29:45 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>, 
 devicetree@vger.kernel.org, jk@codeconstruct.com.au, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Chen <kevin_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
To: Ryan Chen <ryan_chen@aspeedtech.com>
In-Reply-To: <20251022065507.1152071-2-ryan_chen@aspeedtech.com>
References: <20251022065507.1152071-1-ryan_chen@aspeedtech.com>
 <20251022065507.1152071-2-ryan_chen@aspeedtech.com>
Message-Id: <176112178506.2826837.14168081869073363718.robh@kernel.org>
Subject: Re: [PATCH v5 1/3] dt-bindings: interrupt-controller:
 aspeed,ast2700: Add support for INTC hierarchy


On Wed, 22 Oct 2025 14:55:05 +0800, Ryan Chen wrote:
> AST2700 contains two-level interrupt controllers (INTC0 and INTC1),
> each with its own register space and handling different sets of
> peripherals.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  .../aspeed,ast2700-intc0.yaml                 | 97 +++++++++++++++++++
>  .../aspeed,ast2700-intc1.yaml                 | 94 ++++++++++++++++++
>  2 files changed, 191 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc0.yaml
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc1.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc1.yaml:94:7: [error] no new line character at the end of file (new-line-at-end-of-file)
./Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc0.yaml:97:7: [error] no new line character at the end of file (new-line-at-end-of-file)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251022065507.1152071-2-ryan_chen@aspeedtech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


