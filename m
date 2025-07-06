Return-Path: <linux-kernel+bounces-713571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 499A8AF5BB0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 16:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87C06481706
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 14:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9443730AAC2;
	Wed,  2 Jul 2025 14:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cwdmQY4F"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B0730AAAE
	for <linux-kernel@vger.kernel.org>; Wed,  2 Jul 2025 14:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751467926; cv=none; b=IXtkvleF0rmZftq0rQQfcpZYShrs4Gt4v2lmtamZXKtL7Jevmy7LY37NJCPMyynRHoyciuduy9oqwV7DpBSPZ/92auAAvmMat6mESYZ5wYhW9ir097+Iw1+aCYuyzt+dUntEyR/jwbF44JE0wXhMvBlBIbnTTlwuAhjmwJU4eL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751467926; c=relaxed/simple;
	bh=Rm4uKekevq9QVlWcJTU8YYPuS+Ao27X0DY45UpImAO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iLogZuByb+7+R9lA24B3xCF4UuHkSnzszlB1JUnfV9IJUVzvBOdaZtjGLOuIVuzuTuT/Bhwg5uXpL/FDJrligerxm3qf1LOQ9dKV8Y25NAMxSEauGNZXkVDJsrTLcnRf12AV/05a45RkqUDQ2jHxSGWI3I3XIFc2Q+sXOR/NHt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cwdmQY4F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751467923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GD9a+U7xk2HtEH8u7J5QH3o1jHrobpwDVeF+J5TvPOY=;
	b=cwdmQY4FQxdRmGvoMRTHJZqMGiKd+TWnnhsoqZElyh+9wAVlFqgJgLXjqWj/UBb69v6SHh
	nQAxp9W3yWIP8hHRqQ45UuhwKGHRBttlhTzzYPO4hH6Rl+nw+dhuB7iZAbVUIEmhQxFTzN
	9AOOolL7ehaxAFKB+Jt0Wu+GP2PI6ww=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-uepZUSRPOmKXasvFohXj5Q-1; Wed,
 02 Jul 2025 10:52:00 -0400
X-MC-Unique: uepZUSRPOmKXasvFohXj5Q-1
X-Mimecast-MFC-AGG-ID: uepZUSRPOmKXasvFohXj5Q_1751467917
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8067D1978C9A;
	Wed,  2 Jul 2025 14:51:56 +0000 (UTC)
Received: from [10.45.226.95] (unknown [10.45.226.95])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7888630001B9;
	Wed,  2 Jul 2025 14:51:49 +0000 (UTC)
Message-ID: <4f2e040b-3761-441c-b8b1-3d6aa90c77fc@redhat.com>
Date: Wed, 2 Jul 2025 16:51:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 07/14] dpll: zl3073x: Add clock_id field
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Jason Gunthorpe <jgg@ziepe.ca>, Shannon Nelson <shannon.nelson@amd.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>
References: <20250629191049.64398-1-ivecera@redhat.com>
 <20250629191049.64398-8-ivecera@redhat.com>
 <amsh2xeltgadepx22kvcq4cfyhb3psnxafqhr33ra6nznswsaq@hfq6yrb4zvo7>
 <e5e3409e-b6a8-4a63-97ac-33e6b1215979@redhat.com>
 <cpgoccukn5tuespqse5fep4gzzaeggth2dkzqh6l5jjchumfyc@5kjorwx57med>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <cpgoccukn5tuespqse5fep4gzzaeggth2dkzqh6l5jjchumfyc@5kjorwx57med>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 02. 07. 25 2:01 odp., Jiri Pirko wrote:
> Wed, Jul 02, 2025 at 01:43:38PM +0200, ivecera@redhat.com wrote:
>>
>> On 02. 07. 25 12:31 odp., Jiri Pirko wrote:
>>> Sun, Jun 29, 2025 at 09:10:42PM +0200, ivecera@redhat.com wrote:
>>>> Add .clock_id to zl3073x_dev structure that will be used by later
>>>> commits introducing DPLL feature. The clock ID is required for DPLL
>>>> device registration.
>>>>
>>>> To generate this ID, use chip ID read during device initialization.
>>>> In case where multiple zl3073x based chips are present, the chip ID
>>>> is shifted and lower bits are filled by an unique value - using
>>>> the I2C device address for I2C connections and the chip-select value
>>>> for SPI connections.
>>>
>>> You say that multiple chips may have the same chip ID? How is that
>>> possible? Isn't it supposed to be unique?
>>> I understand clock ID to be invariant regardless where you plug your
>>> device. When you construct it from i2c address, sounds wrong.
>>
>> The chip id is not like serial number but it is like device id under
>> PCI. So if you will have multiple chips with this chip id you have to
>> distinguish somehow between them, this is the reason why I2C address
>> is added into the final value.
>>
>> Anyway this device does not have any attribute that corresponds to
>> clock id (as per our previous discussion) and it will be better to NOT
>> require clock id from DPLL core side.
> 
> Yes, better not to require it comparing to having it wrong.

It looks that using clock_id==0 is safe from DPLL API point of view.
The problem is if you will have multiple zl3073x based chips because
the driver would call dpll_device_get(0 /* clock_id */, channel, module)

For 1st chip (e.g. 2 channel) the driver will call:
dpll_device_get(0, 0, module);
dpll_device_get(0, 1, module);

and for the second the same that is wrong. The clock_id would help to
distinguish between them.

Wouldn't it be better to use a random number for clock_id from the
driver?

Ivan


