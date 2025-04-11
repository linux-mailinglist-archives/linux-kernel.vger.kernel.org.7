Return-Path: <linux-kernel+bounces-599854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE86A85897
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 11:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 378CE4E1E45
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 09:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6884D29B23D;
	Fri, 11 Apr 2025 09:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a7olu1SW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F186298CCB
	for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 09:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365392; cv=none; b=Fz7Gjonuvbqhg9P2Jla7wWzBAP4NPa9huoxE/0G2o75G35eUwrPqtFY/WQlZDPWbDkAqEHg6wzyoCMy76bxsYxcP1dkWrjicPUh1jG1Woqwltjj2VbnTGfbOAeMFppOUqV1iLEbfZyfds4RHv1haM6gD0QPjOL+Nc78YkVYVPYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365392; c=relaxed/simple;
	bh=5Il5jcJw3FuAIORfi213Pt6kpRXF0u1YVGrWeMfFeSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y6+TKHbB4hCvRjjODtvA6QZ293tUFSgagxrkEXrJMW8Yxbr7/1m+YtSo+avKNDKpPqAePL23XrfZk9nVkQlWfO6LNgxOPJfJrMVkveQ1KjvVpAtmqLAEnwJmj5PJI7aWTC0y9J1dwQC1LolUBKFQ7dn3TtsEytDeu8OLzCe+p7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a7olu1SW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744365389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ypViF9xwRKSdJxjymiRlr36Hbu2rzw35GmKD6sGYV+M=;
	b=a7olu1SW0J+8HRl/WgHhvxHf8FNMZVV4KbclSLXJd2jj5o9Ngun5weTmQsjAU4wTjQ1d0D
	WbjER+cfy3l5cg7ugT1BqKxhnCiPHFsE90tZmul+7Wul8C5YUldy8HszFS7W5Dpg5OJbDD
	yts9Z4qr3oJCJSy4xdYl6cmAtJPFKS4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-EcPimzzdMei2_fs4BcGaGQ-1; Fri,
 11 Apr 2025 05:56:25 -0400
X-MC-Unique: EcPimzzdMei2_fs4BcGaGQ-1
X-Mimecast-MFC-AGG-ID: EcPimzzdMei2_fs4BcGaGQ_1744365383
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7225618007E1;
	Fri, 11 Apr 2025 09:56:22 +0000 (UTC)
Received: from [10.45.225.124] (unknown [10.45.225.124])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E0908180174E;
	Fri, 11 Apr 2025 09:56:16 +0000 (UTC)
Message-ID: <7e6bf69b-0916-4ad9-b42f-8645f5c95d5d@redhat.com>
Date: Fri, 11 Apr 2025 11:56:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/14] dt-bindings: dpll: Add support for Microchip
 Azurite chip family
To: Andrew Lunn <andrew@lunn.ch>
Cc: Prathosh.Satish@microchip.com, conor@kernel.org, krzk@kernel.org,
 netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, lee@kernel.org, kees@kernel.org,
 andy@kernel.org, akpm@linux-foundation.org, mschmidt@redhat.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20250409144250.206590-1-ivecera@redhat.com>
 <20250409144250.206590-3-ivecera@redhat.com>
 <20250410-skylark-of-silent-symmetry-afdec9@shite>
 <1a78fc71-fcf6-446e-9ada-c14420f9c5fe@redhat.com>
 <20250410-puritan-flatbed-00bf339297c0@spud>
 <6dc1fdac-81cc-4f2c-8d07-8f39b9605e04@redhat.com>
 <CY5PR11MB6462412A953AF5D93D97DCE5ECB72@CY5PR11MB6462.namprd11.prod.outlook.com>
 <bd7d005b-c715-4fd9-9b0d-52956d28d272@lunn.ch>
 <7ab19530-d0d4-4df1-9f75-060c3055585b@redhat.com>
 <4e331736-36f2-4796-945f-613279329585@lunn.ch>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <4e331736-36f2-4796-945f-613279329585@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111



On 10. 04. 25 11:12 odp., Andrew Lunn wrote:
> On Thu, Apr 10, 2025 at 08:33:31PM +0200, Ivan Vecera wrote:
>>
>>
>> On 10. 04. 25 7:36 odp., Andrew Lunn wrote:
>>>> Prathosh, could you please bring more light on this?
>>>>
>>>>> Just to clarify, the original driver was written specifically with 2-channel
>>>>> chips in mind (ZL30732) with 10 input and 20 outputs, which led to some confusion of using zl3073x as compatible.
>>>>> However, the final version of the driver will support the entire ZL3073x family
>>>>> ZL30731 to ZL30735 and some subset of ZL30732 like ZL80732 etc
>>>>> ensuring compatibility across all variants.
>>>
>>> Hi Prathosh
>>>
>>> Your email quoting is very odd, i nearly missed this reply.
>>>
>>> Does the device itself have an ID register? If you know you have
>>> something in the range ZL30731 to ZL30735, you can ask the hardware
>>> what it is, and the driver then does not need any additional
>>> information from DT, it can hard code it all based on the ID in the
>>> register?
>>>
>>> 	Andrew
>>>
>> Hi Andrew,
>> yes there is ID register that identifies the ID. But what compatible should
>> be used?
>>
>> microchip,zl3073x was rejected as wildcard and we should use all
>> compatibles.
> 
> You have two choices really:
> 
> 1) You list each device with its own compatible, because they are in
> fact not compatible. You need to handle each one different, they have
> different DT properties, etc. If you do that, please validate the ID
> register against the compatible and return -ENODEV if they don't
> match.
> 
> 2) You say the devices are compatible. So the DT compatible just
> indicates the family, enough information for the driver to go find the
> ID register. This does however require the binding is the same for all
> devices. You cannot have one family member listing 10 inputs in its
> binding, and another family member listing 20.
> 
> If you say your devices are incompatible, and list lots of
> compatibles, you can then use constraints in the yaml, based on the
> compatible, to limit each family member to what it supports.
> 
> My guess is, you are going to take the first route.

Yes, this looks reasonable... in this case should I use 
microchip,zl3073x.yaml like e.g. gpio/gpio-pca95xx.yaml?

Ivan


