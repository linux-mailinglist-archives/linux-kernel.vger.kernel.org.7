Return-Path: <linux-kernel+bounces-877044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E25CC1D0E1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7701A4E0190
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBB135A139;
	Wed, 29 Oct 2025 19:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBTsrI1y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0822D3237;
	Wed, 29 Oct 2025 19:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761767374; cv=none; b=QHtKg7/jMZOQBaePHWezY95v4rhepiA+pXaYCfBuTexZp3w94p4hVBDzeiwjzG3JR8ha1QdIbzuSqerIk7YljON8jZxT2mVlHeZijikinJMQNUuJs/x6SeKZ2rxqXZlNx41fQ5yqlNWC+QjKfSrq0nJErwwM6C+BsMr7EC6m/SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761767374; c=relaxed/simple;
	bh=cgW3eaNa1qTxN0mCfqwnT+I4/Tb+epp984COA7HO+0E=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=bvUgq/vXIEaVyZvthtAYEesm7S1PCnWcGH5abvcUXcoozKXTIi2GPtmC5PsPbA/C+dSRybZ+8HTXqmwpqA+bmzxnMQ2PKEYn7i3xeEiinY3hy89Y52h5NOMyOpEbMLdg9GJhazc38c+L9d9+NwwyJ/MPH59yJdhNziYuHjQ+Gko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBTsrI1y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596C6C4CEF7;
	Wed, 29 Oct 2025 19:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761767373;
	bh=cgW3eaNa1qTxN0mCfqwnT+I4/Tb+epp984COA7HO+0E=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=eBTsrI1yyG/5IEBOvpulu2NhU99j0sEVLtdj8hbSkWDsiMAYCUJg4ULJKi8yRVk2D
	 wnHzaS7GDiEDzkSeW8qzXfrjrf989UcPqwvuaanih9J1yswudljclqy7geLsKf27bi
	 YJoEWXmdeqGFcMNpKog7EeL7YdvNghoVk48LDUuX0jg5hFhMVmwz1zfsLtdJwjIiZb
	 N16/SJNKr+BN3tcnk9I6U1MYcvl+CE5qvdrkf3mIYhNnXNr3OGCUMAJ/qbNU2Xn8rf
	 zONEsmd/lUy/EASyRwrpv0g5Jk+xl47waAewpAD/v+28gBwn06vC0MiSxxfZymkPl4
	 p2SzxTBjr8gRg==
Date: Wed, 29 Oct 2025 14:49:32 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, 
 linux-arm-kernel@lists.infradead.org, Guenter Roeck <linux@roeck-us.net>, 
 linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Joel Stanley <joel@jms.id.au>
To: "Rob Herring (Arm)" <robh@kernel.org>
In-Reply-To: <20251029185448.2121857-1-robh@kernel.org>
References: <20251029185448.2121857-1-robh@kernel.org>
Message-Id: <176176737216.2539117.14470144508390937372.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: hwmon: Convert aspeed,ast2400-pwm-tacho
 to DT schema


On Wed, 29 Oct 2025 13:54:47 -0500, Rob Herring (Arm) wrote:
> Convert the ASpeed fan controller binding to DT schema format.
> 
> The '#cooling-cells' value used is 1 rather than 2. '#size-cells' is 0
> rather 1.
> 
> Some users define more that 8 fan nodes where 2 fans share a PWM. The
> driver seems to let the 2nd fan just overwrite the 1st one. That also
> creates some addressing errors in the DT (duplicate addresses and wrong
> unit-addresses).
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../hwmon/aspeed,ast2400-pwm-tacho.yaml       | 105 ++++++++++++++++++
>  .../bindings/hwmon/aspeed-pwm-tacho.txt       |  73 ------------
>  2 files changed, 105 insertions(+), 73 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,ast2400-pwm-tacho.yaml
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/aspeed-pwm-tacho.txt
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/aspeed,ast2400-pwm-tacho.example.dtb: fan-controller@1e786000 (aspeed,ast2500-pwm-tacho): #cooling-cells: 2 was expected
	from schema $id: http://devicetree.org/schemas/thermal/thermal-cooling-devices.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251029185448.2121857-1-robh@kernel.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


