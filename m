Return-Path: <linux-kernel+bounces-598337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD874A844FB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 15:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B48697B1F4F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 13:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1F928A40B;
	Thu, 10 Apr 2025 13:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PnC6FyCW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BA728C5C8
	for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 13:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744292173; cv=none; b=BIBqS8bIpvJ1lSXjGg6+uK84XXxKK9Un1fSZ8sjl/RxI1Kq5OL9XXiv/CfFwX2LARK5x7xG/BladBk80j6N8gGhk8p2oKI3OkO/utNMTeQJA3sgkNjJ0df3IA6Rei1ImDtfU6Y70CU8wSpSJSWTdlNrEAm4qn1Zo8W9k5oKxOfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744292173; c=relaxed/simple;
	bh=5tYVFZIQYWA/C+9gLwzJ3xPs4I8Ri6YFpxx6K2/PD6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ppLgi2Qk0tIqauzGtQJ3Q0SrJ3GHZsyp+aipIQB7SnNsi/H/XIiJ0sEQ2aAw4G1qaedUtdHClBXmG8sFsjZWrc47Plg4AH2Op0Uz4Xo/JxZQwmKtJvxQs3xXiLjRYlq0MmysXwpLbOfBpPPR+RQxaW9ywL4+b0tOSKBDPTJ8UXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PnC6FyCW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744292170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KDNRXx/pLf3PiSQ+7oCQArk/I5u6Iz6jliw3UN4JAj8=;
	b=PnC6FyCWwGRj/M0iU/d+68nd0fqBdQvhuNEcmmP6AXdRdaV/sc7ELXOoLQx1YrRzp0A7Rn
	WC2pLDvBBD6muNnTI5W3neBrdAo80hFYVFuSOigbrCY7lFlWTusk88udSgkpTmDjYPTKk6
	ZCPSODaNfxH+71M//2x7V1yje/euh+g=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-Ah2_ozVZMqy_FIL9WYqSjw-1; Thu,
 10 Apr 2025 09:36:05 -0400
X-MC-Unique: Ah2_ozVZMqy_FIL9WYqSjw-1
X-Mimecast-MFC-AGG-ID: Ah2_ozVZMqy_FIL9WYqSjw_1744292162
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A64EB19560AB;
	Thu, 10 Apr 2025 13:36:01 +0000 (UTC)
Received: from [10.45.225.124] (unknown [10.45.225.124])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2C18219560AD;
	Thu, 10 Apr 2025 13:35:56 +0000 (UTC)
Message-ID: <6dc1fdac-81cc-4f2c-8d07-8f39b9605e04@redhat.com>
Date: Thu, 10 Apr 2025 15:35:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/14] dt-bindings: dpll: Add support for Microchip
 Azurite chip family
To: Conor Dooley <conor@kernel.org>,
 "Prathosh.Satish@microchip.com" <Prathosh.Satish@microchip.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, netdev@vger.kernel.org,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
 Andy Shevchenko <andy@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Michal Schmidt <mschmidt@redhat.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20250409144250.206590-1-ivecera@redhat.com>
 <20250409144250.206590-3-ivecera@redhat.com>
 <20250410-skylark-of-silent-symmetry-afdec9@shite>
 <1a78fc71-fcf6-446e-9ada-c14420f9c5fe@redhat.com>
 <20250410-puritan-flatbed-00bf339297c0@spud>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20250410-puritan-flatbed-00bf339297c0@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12



On 10. 04. 25 3:18 odp., Conor Dooley wrote:
> On Thu, Apr 10, 2025 at 09:45:47AM +0200, Ivan Vecera wrote:
>>
>>
>> On 10. 04. 25 9:06 dop., Krzysztof Kozlowski wrote:
>>> On Wed, Apr 09, 2025 at 04:42:38PM GMT, Ivan Vecera wrote:
>>>> Add DT bindings for Microchip Azurite DPLL chip family. These chips
>>>> provides 2 independent DPLL channels, up to 10 differential or
>>>> single-ended inputs and up to 20 differential or 20 single-ended outputs.
>>>> It can be connected via I2C or SPI busses.
>>>>
>>>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>>>> ---
>>>>    .../bindings/dpll/microchip,zl3073x-i2c.yaml  | 74 ++++++++++++++++++
>>>>    .../bindings/dpll/microchip,zl3073x-spi.yaml  | 77 +++++++++++++++++++
>>>
>>> No, you do not get two files. No such bindings were accepted since some
>>> years.
>>>
>>>>    2 files changed, 151 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/dpll/microchip,zl3073x-i2c.yaml
>>>>    create mode 100644 Documentation/devicetree/bindings/dpll/microchip,zl3073x-spi.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/dpll/microchip,zl3073x-i2c.yaml b/Documentation/devicetree/bindings/dpll/microchip,zl3073x-i2c.yaml
>>>> new file mode 100644
>>>> index 0000000000000..d9280988f9eb7
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/dpll/microchip,zl3073x-i2c.yaml
>>>> @@ -0,0 +1,74 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/dpll/microchip,zl3073x-i2c.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: I2C-attached Microchip Azurite DPLL device
>>>> +
>>>> +maintainers:
>>>> +  - Ivan Vecera <ivecera@redhat.com>
>>>> +
>>>> +description:
>>>> +  Microchip Azurite DPLL (ZL3073x) is a family of DPLL devices that
>>>> +  provides 2 independent DPLL channels, up to 10 differential or
>>>> +  single-ended inputs and up to 20 differential or 20 single-ended outputs.
>>>> +  It can be connected via multiple busses, one of them being I2C.
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    enum:
>>>> +      - microchip,zl3073x-i2c
>>>
>>> I already said: you have one compatible, not two. One.
>>
>> Ah, you mean something like:
>> iio/accel/adi,adxl313.yaml
>>
>> Do you?
>>
>>> Also, still wildcard, so still a no.
>>
>> This is not wildcard, Microchip uses this to designate DPLL devices with the
>> same characteristics.
> 
> That's the very definition of a wildcard, no? The x is matching against
> several different devices. There's like 14 different parts matching
> zl3073x, with varying numbers of outputs and channels. One compatible
> for all of that hardly seems suitable.

Prathosh, could you please bring more light on this?

Thanks.
> 
>>
>> But I can use microchip,azurite, is it more appropriate?
> 
> No, I think that is worse actually.


