Return-Path: <linux-kernel+bounces-797152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6793CB40C9E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51B647A31CD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCE8343D8C;
	Tue,  2 Sep 2025 17:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqrBGoEw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A51C286D69;
	Tue,  2 Sep 2025 17:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756835848; cv=none; b=B7cmKFK8ifLhGfbpxymIDZk8UjwMW0G+iBe4fgxuRkLSLZLzTY4f1zN+5nVSyBYinT9mXaoWzUajLiadXubB7yQLgMJg6WP/nlFxjPG+PpkuHTHESLKYFcy94qHhDzJJocJvJ97a+pw8v5Q3x8AQGdO50KRBWRCpqc+cIS2N0yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756835848; c=relaxed/simple;
	bh=NajCRsREB6rWXuMhOuOZJW01EgK0za22LT6u6sfxwrc=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=UaSHArVH6Dwb/l8AMFO2j1MZSon28rbHU9KoEcoat45KAy5dUdXyi1FU414bhxEa+YitU/fd9DxDXxo9ROPIQHrz4glYAaOcuOvUqSLZOebijZgwI9RjR9gpEZd2Xok5kcHGlH10JbW7pkFGzmNYYjZhWCEwMjfL7VAKrhsROd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqrBGoEw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35EBC4CEED;
	Tue,  2 Sep 2025 17:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756835847;
	bh=NajCRsREB6rWXuMhOuOZJW01EgK0za22LT6u6sfxwrc=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=DqrBGoEwc9k0455eR+TX56WiJArbQu5hzcMCMD1t7bjjRr5n6KjCGJ0CXS3Gw+7gG
	 cxsFhwsyjGPMYpxYJcBNSq/9YPFlms5Qr4GZXDnDXc7p/Lia8sdcKF34uDO110d26A
	 pBUQZm3r1nwZ0FK9Ni1YFWFyMv7pjA+FPZnvXm/OWtoyDeUyKyxvli/ZK+mAoz4Dna
	 XUjTIj5lGKDaFtwpMTkRDoHbJVPey8Jty17I3F0d+60Q8xrcCldrWBLXI2Dkg61gDw
	 qTK4VSKfdVfPyDUjgk+1EL5eLzvfBRhFASNsc4HgtHVJhkfnoZyBWhf6GQ9g4vdpI9
	 OEBdlJZtflzGA==
Date: Tue, 02 Sep 2025 12:57:26 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Hans de Goede <hansg@kernel.org>, Lee Jones <lee@kernel.org>, 
 devicetree@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Pavel Machek <pavel@kernel.org>
To: Aleksandrs Vinarskis <alex@vinarskis.com>
In-Reply-To: <010201990a1f5ad8-fc97fc84-9ef9-4a03-bf1c-2d54423c6497-000000@eu-west-1.amazonses.com>
References: <20250902-leds-v1-0-4a31e125276b@vinarskis.com>
 <010201990a1f5ad8-fc97fc84-9ef9-4a03-bf1c-2d54423c6497-000000@eu-west-1.amazonses.com>
Message-Id: <175683578222.936579.14691292401216531153.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: leds: add generic LED consumer
 documentation


On Tue, 02 Sep 2025 11:10:51 +0000, Aleksandrs Vinarskis wrote:
> Currently supports passing 'led-names' used to map LED devices to their
> respective functions.
> 
> Signed-off-by: Aleksandrs Vinarskis <alex@vinarskis.com>
> ---
>  .../devicetree/bindings/leds/leds-consumer.yaml    | 69 ++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/leds/leds-consumer.example.dtb: camera@36 (ovti,ov02c10): Unevaluated properties are not allowed ('led-names', 'leds' were unexpected)
	from schema $id: http://devicetree.org/schemas/media/i2c/ovti,ov02e10.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/010201990a1f5ad8-fc97fc84-9ef9-4a03-bf1c-2d54423c6497-000000@eu-west-1.amazonses.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


