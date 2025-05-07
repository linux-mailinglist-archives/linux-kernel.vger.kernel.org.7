Return-Path: <linux-kernel+bounces-638322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAC1AAE463
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 17:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF756520131
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 15:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B0E28A407;
	Wed,  7 May 2025 15:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBrwAS5s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A6C155CBD;
	Wed,  7 May 2025 15:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746631117; cv=none; b=VROW0D7/DrHs/OTEdbbbjEI9niHkUm0tKZrKDJ2jWZaexbuBp3kS/1CwRwg3DuDRAHlRAp6M8VfJlb+whB+D+BovOexYIJEE/7tLEsEhPMDl9ldxCBo57ULhL9JM1RaWkc3Ssnr3wX7szTKVG7R9Q2FaJ0oUkktnOVtL1/JPzwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746631117; c=relaxed/simple;
	bh=XKcJueuFpqD8GYZ9LLQB/CLJN3H6ACFCEdW05J9NxMk=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=cNtwxgoHS9yY83mQ+M1by7FQ+MWC+SUcdZ7ka+POs2LQLCJoW4ubyC9ZxzFdAoybZtR8bRfGojCD+QjCQpsaWHnUF3ldTN+IsQKHleAaFpTEnMqjBctcB1hJeInPZKE1IhKwBE7Oy0BL8cpd4v6kZXJr2LPxu9JeaJVLebCaHmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBrwAS5s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5D9C4CEE2;
	Wed,  7 May 2025 15:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746631116;
	bh=XKcJueuFpqD8GYZ9LLQB/CLJN3H6ACFCEdW05J9NxMk=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=UBrwAS5sHH3KMHQGQFmz/tQNAcTWVQ6gycxf8zZXfonRFcf2/Bk7DS+my1SrkvYGg
	 81+mByHAKymqFZEPZlLnRZ8c7hKDGXQJM16qj4R2Z7735wcdtZieALcUEf2osn4NeB
	 Ik+taf0+vjFJmNZeHSp/ZpvND6xGyDqiPwpDwEc/B9VKG1soj1pg46ucLH8BmM4gW/
	 vBMlh17LZsZQYtufBAngX3C1JMB8kXT1IBOwfo9Wtx7nuR13vL/JOrOtkCdsb/o2X6
	 F6CdUVVxpg0+q66JUiN/6WHSxcbBvKgpHRDhYYYKDfLc6lNEYYvmfOnJmOPCF/M9Ow
	 X0jkC9rB5pY/Q==
Date: Wed, 07 May 2025 10:18:34 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 linux-kernel@vger.kernel.org, 
 Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
In-Reply-To: <20250507135147.1328639-1-dario.binacchi@amarulasolutions.com>
References: <20250507135147.1328639-1-dario.binacchi@amarulasolutions.com>
Message-Id: <174663111457.1398857.14653136407863606416.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: iio: light: apds9160: add missing type
 definition


On Wed, 07 May 2025 15:51:38 +0200, Dario Binacchi wrote:
> Fix the following warning:
> 
>  Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml: ps-cancellation-current-picoamp: missing type definition
> 
> raised by command:
> 
>  make dt_binding_check  DT_SCHEMA_FILES=fsl.yaml
> 
> Fixes: be464661e7532 ("dt-bindings: iio: light: Add APDS9160 binding")
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
> 
>  Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/light/brcm,apds9160.example.dtb: light-sensor@53 (brcm,apds9160): ps-cancellation-current-picoamp: 62400 is not of type 'array'
	from schema $id: http://devicetree.org/schemas/property-units.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250507135147.1328639-1-dario.binacchi@amarulasolutions.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


