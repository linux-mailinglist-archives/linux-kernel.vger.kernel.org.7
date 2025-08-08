Return-Path: <linux-kernel+bounces-759815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 696FCB1E32E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6800C18C0F1A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 07:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033F7239E65;
	Fri,  8 Aug 2025 07:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lprjZq9w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550AB1CBA18;
	Fri,  8 Aug 2025 07:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754637376; cv=none; b=EZLGpQEzKDcycVHB3shl7DytJiGTQUiYZj0W0qY90lTqWGiA23qwMUQ26j+hGSOpM27ORsHSUzLV91or38XJc0OKfz9o8ZYrNLn3k3g3eH3hF2FbaFR3Ug6+SWDF6KWFkuDkSkUS85tYCMbziLzIlcJLgVEtc28DIDSl+AtBUNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754637376; c=relaxed/simple;
	bh=lxMiesZ65+2oiwectZttyK6zke/KLfLuNPyKzaZqUWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OagQi8PGEVNLdHpmjToyUl0GafzDTYJVWF6SeyXhjqc47BUaKCtoNJqiNpH3EY2wiIe9HsuBUvYbW97RIutrfhc00FTwCnk7hd0fq3LUQOjsb0WUyibA+QmByrEf5Q1G9TwybjJDUowwHRHxUudM0drJy8OSqZh1zc4iHHCRSNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lprjZq9w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D7DAC4CEED;
	Fri,  8 Aug 2025 07:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754637375;
	bh=lxMiesZ65+2oiwectZttyK6zke/KLfLuNPyKzaZqUWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lprjZq9we62oH/qshRmSLjmBGsxNQZwPuBp/ZZAKMMfB+pFF8PXwy/ARW8GZaGXSb
	 HZRk1JYI/Y6lE2/PadXvN+P6Q4UyrwnTnye7MlutKza8GSfJlCRBr7X8GhG4qDLYIy
	 8fZauGzq32mxjCsFTNRkB4kc2XkqSbZey2oNwl7QAhp+2L0WeqCspFkXWa0XyfokV6
	 dMC7y0KfyY6wOpxnkyIo7QpctK9uewqIS8oz6gIcITMxn/2BsBShPfkku0OlFSwtR5
	 /b8/TlgH4Vs2p0GoGcF6VqEAtylcWUg7Ahn2o2sfSYGPZHoSB+BBYpbP/qIC6Mq0HQ
	 c011nK78AE3Fg==
Date: Fri, 8 Aug 2025 09:16:13 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: "jdelvare@suse.com" <jdelvare@suse.com>, 
	"linux@roeck-us.net" <linux@roeck-us.net>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: ti,ina780a: Add INA780 device
Message-ID: <20250808-hypersonic-electric-skua-ceca2e@kuoka>
References: <20250806005127.542298-1-chris.packham@alliedtelesis.co.nz>
 <f2972a86-f58d-4360-b43a-486377b101e1@kernel.org>
 <aa814850-79ee-4c88-87d8-a3d70036ef2d@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aa814850-79ee-4c88-87d8-a3d70036ef2d@alliedtelesis.co.nz>

On Thu, Aug 07, 2025 at 08:46:46PM +0000, Chris Packham wrote:
> 
> On 06/08/2025 18:32, Krzysztof Kozlowski wrote:
> > On 06/08/2025 02:51, Chris Packham wrote:
> >> +
> >> +properties:
> >> +  compatible:
> >> +    enum:
> >> +      - ti,ina780a
> >> +      - ti,ina780b
> >> +
> >> +  reg:
> >> +    maxItems: 1
> >
> > This looks a bit incomplete. Where is a supply? No shunt resistor
> > choice? No other properties from ina2xx apply?
> This chip doesn't need a shunt so pretty much all that is required is 
> compatible + reg. Guenter did mention rolling this into the existing 
> ina238 driver (and ina2xx binding) so I'm looking at that right now. I'm 
> also thinking about dropping the A vs B distinction. They are ordering 
> options that do impact the accuracy of the ADC but driver wise they 
> behave the same.

Then I suggest to skip a/b. Usually we do not have compatibles for
packaging differences or even consumer/industrial thermal choices.

Best regards,
Krzysztof


