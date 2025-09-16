Return-Path: <linux-kernel+bounces-818926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98221B59832
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EED54E4B60
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BFA31D742;
	Tue, 16 Sep 2025 13:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzwLIuCW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08C631D75F;
	Tue, 16 Sep 2025 13:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758030738; cv=none; b=stxiMDyGV3mcs1iO5HH1HVoF5YUB9BYY/58LnNQhZgC9UZKjolY1Pc/gz6YM7UfOheAr72BLervhIdzx3+r+fNrzxRqWp1phTVIPev+9GpLUlkWVSIqK/VFvLvpFeKrTks1a4faY/lFl8txYqDnavu+ZR5XiEi8iM6XE//FXi3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758030738; c=relaxed/simple;
	bh=ai1oXYeVOfINUAOzqKrno3a6vcH5X8osrVp0OAwCDSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxDGBcxCENTk6pYtgduxY0mqZGcj8dnItGTxINTnbzi2uPT6+Vl9qs9PzqkEkJRzjP9mo7pagDc7Qam8YzpaWBHiK+gN2rsG5EabsMAAxKlnukJq0Kky7Bl32L0WXeB3moCF2x/S94SqicYqsgOTHpghcPKL7NjCSs0tWDabSdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzwLIuCW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57A5C4CEEB;
	Tue, 16 Sep 2025 13:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758030737;
	bh=ai1oXYeVOfINUAOzqKrno3a6vcH5X8osrVp0OAwCDSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZzwLIuCWYBfCMzOJEHWQkphHl5ZPnPFg8NAZmQ8lAPZZttfShcP0bZNh2WUYEqs6M
	 IRPZFO3XEoeoRDWeOiu5oq19fx00aJEUe4k3PnO9112I+OynSPISmMf/zTnZBTRt2h
	 Gp/Y+qmF1t3ytr3zX5ytGKj5xO9oEI5us/dwUpQ9StjHr4UOJse/Lxhw4lXlLcNINd
	 TpGuu2F9i3RUcYWLuVku/k+eMPtIxwyf0z2Iu5JIyxkMWiL7HIct4EFH17BI/sHe23
	 qkPACzA1VTcsq7gViuDlsiKDgdEQCepYJGKAlHgVC9b+F8de8s4BRpI+7CyRZE6+JL
	 Zhdnmhf764OIA==
Date: Tue, 16 Sep 2025 08:52:16 -0500
From: Rob Herring <robh@kernel.org>
To: Troy Mitchell <troy.mitchell@linux.dev>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: Add CTF2301 devicetree bindings
Message-ID: <20250916135216.GA3674673-robh@kernel.org>
References: <20250916-ctl2301-v1-0-97e7c84f2c47@linux.dev>
 <20250916-ctl2301-v1-2-97e7c84f2c47@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250916-ctl2301-v1-2-97e7c84f2c47@linux.dev>

On Tue, Sep 16, 2025 at 12:46:45PM +0800, Troy Mitchell wrote:
> Add dt-binding for the hwmon driver of Sensylink's CTF2301 chip.
> 
> Signed-off-by: Troy Mitchell <troy.mitchell@linux.dev>
> ---
>  .../bindings/hwmon/sensylink,ctf2301.yaml          | 49 ++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/sensylink,ctf2301.yaml b/Documentation/devicetree/bindings/hwmon/sensylink,ctf2301.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..fe98f5b578320bc1b43ff88f76667990821a88f7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/sensylink,ctf2301.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/sensylink,ctf2301.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sensylink CTF2301 system-level thermal management solution chip
> +
> +maintainers:
> +  - Troy Mitchell <troy.mitchell@linux.dev>
> +
> +allOf:
> +  - $ref: hwmon-common.yaml#
> +
> +description: |
> +  The CTF2301B is an I2C/SMBus compatible device featuring:
> +    - One local temperature sensor with ±0.5°C accuracy and 0.0625°C resolution.
> +    - One remote temperature sensor for external diode-connected transistors, offering ±1°C accuracy and 0.125°C resolution (temperature range: -40°C to +125°C).

Wrap at 80 chars.

> +    - An integrated PWM fan controller.
> +    - A 1-channel fan speed monitor (TACH input) for RPM measurement.
> +
> +  Datasheets:
> +    https://www.sensylink.com/upload/1/net.sensylink.portal/1689557281035.pdf
> +
> +properties:
> +  compatible:
> +    const:
> +      - sensylink,ctf2301
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ctf2301@4c {
> +            compatible = "sensylink,ctf2301";
> +            reg = <0x4c>;
> +        };
> +    };
> 
> -- 
> 2.51.0
> 

