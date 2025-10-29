Return-Path: <linux-kernel+bounces-875853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B80A2C19F57
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 691934003A3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40923310635;
	Wed, 29 Oct 2025 11:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ik887B/n"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0328D30BF4F
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761736687; cv=none; b=KojjXL5/Ee/6kN+n4pUxGRSJEB+vXK0gzMSKnZK5Knrk0LSszcDhi4tuPmpkgLT0Df/kLayQWCNYlArRl6D+/p9KrCuTqpUCX1dcJfGUMdfwbVfNcETVZSsJ5rFhb3qaT2DJm2jTLF+Wh+OhpXfYmvK1jV7ckBhkxhNHHvdrXTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761736687; c=relaxed/simple;
	bh=BEP8CKlzTei/mvVC1phKau3fHCdBJSAGP7FMTFlF2Vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j5ns3vQVwqyTnUcUce0iSHN+fktJg/stGdGRqNmjj4l16g8QguFqZZSTWib5+UqraPmuY9HqurPxg4Q1Ycbsp5NK6p7cyoS9obDBtxP8CSyuSn+lApCU7wQJ5DGBgNbZNBJDWdcvnmDaRKb0PjMgJ/mID1ew9emxrYPqBwwWDa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ik887B/n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761736685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pEY6oeNCGpaA654JDXvJncm9eIGUKl+4Cv09+13n8AI=;
	b=ik887B/nP9E6dLAV7OHTjgoUQ45VuZTP5By4ceCLsYkM0xknq7aqk0F0Y3uhba5K+fWOEN
	EdIQlLcbhtl8WblTXIsHZ1s494btTF4uG7p3gPlJa2JDVOoQq9smFoUK3l52rcz3/IRd6R
	UdW0yomV9NTtHVl+mFuXau7H8oFg8pc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-221-trR1RE14NYqXqL191-OPow-1; Wed,
 29 Oct 2025 07:18:01 -0400
X-MC-Unique: trR1RE14NYqXqL191-OPow-1
X-Mimecast-MFC-AGG-ID: trR1RE14NYqXqL191-OPow_1761736679
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 55AB51808972;
	Wed, 29 Oct 2025 11:17:59 +0000 (UTC)
Received: from [10.44.34.31] (unknown [10.44.34.31])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3DE3119560AD;
	Wed, 29 Oct 2025 11:17:53 +0000 (UTC)
Message-ID: <d397e88f-acb5-4e0f-aaae-8f6eddf60164@redhat.com>
Date: Wed, 29 Oct 2025 12:17:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] dpll: add phase-adjust-gran pin attribute
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org
Cc: Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251024144927.587097-1-ivecera@redhat.com>
 <20251024144927.587097-2-ivecera@redhat.com>
 <2e878c19-077c-4e2f-8065-fe62296a5094@linux.dev>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <2e878c19-077c-4e2f-8065-fe62296a5094@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 10/29/25 11:20 AM, Vadim Fedorenko wrote:
> On 24/10/2025 15:49, Ivan Vecera wrote:
>> Phase-adjust values are currently limited by a min-max range. Some
>> hardware requires, for certain pin types, that values be multiples of
>> a specific granularity, as in the zl3073x driver.
>>
>> Add a `phase-adjust-gran` pin attribute and an appropriate field in
>> dpll_pin_properties. If set by the driver, use its value to validate
>> user-provided phase-adjust values.
>>
>> Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
>> Reviewed-by: Petr Oros <poros@redhat.com>
>> Tested-by: Prathosh Satish <Prathosh.Satish@microchip.com>
>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>> ---
>>   Documentation/driver-api/dpll.rst     | 36 +++++++++++++++------------
>>   Documentation/netlink/specs/dpll.yaml |  7 ++++++
>>   drivers/dpll/dpll_netlink.c           | 12 ++++++++-
>>   include/linux/dpll.h                  |  1 +
>>   include/uapi/linux/dpll.h             |  1 +
>>   5 files changed, 40 insertions(+), 17 deletions(-)
>>
>> @@ -1261,7 +1265,13 @@ dpll_pin_phase_adj_set(struct dpll_pin *pin, 
>> struct nlattr *phase_adj_attr,
>>       if (phase_adj > pin->prop.phase_range.max ||
>>           phase_adj < pin->prop.phase_range.min) {
>>           NL_SET_ERR_MSG_ATTR(extack, phase_adj_attr,
>> -                    "phase adjust value not supported");
>> +                    "phase adjust value of out range");
>> +        return -EINVAL;
>> +    }
>> +    if (pin->prop.phase_gran && phase_adj % pin->prop.phase_gran) {
>> +        NL_SET_ERR_MSG_ATTR_FMT(extack, phase_adj_attr,
>> +                    "phase adjust value not multiple of %u",
>> +                    pin->prop.phase_gran);
> 
> That is pretty strict on the uAPI input. Maybe it's better to allow any
> value, but report back the one that is really applied based on driver's
> understanding of hardware? I mean the driver is doing some math before
> applying the math, it can potentially round any value to the closest
> acceptable and report it back?

I’d prefer to use the same approach as for phase-adjust-{min,max}.
Because we could treat them the same way - the user sets a value
above/below the max/min, and the driver clamps it.

Would it be better? I don't think so.

Let’s say the granularity is 1000, and the user sets a value of 499...
then the driver rounds it and sets it to 0. The user then reads the
current value via pin-get and finds that it hasn’t changed - quite
confusing, I’d say. If the user knows the granularity in advance,
they can adjust accordingly.

IMHO, strict behavior is better than smart behavior.

Ivan


