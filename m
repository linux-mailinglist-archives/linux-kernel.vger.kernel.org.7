Return-Path: <linux-kernel+bounces-810208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F17ECB51742
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70BB21BC4FCA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8211D31CA4A;
	Wed, 10 Sep 2025 12:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pltq6KfJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DAF31C57E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757508709; cv=none; b=o2b1sbke5nAimDDBlltHfH2TqxbQuc2/1Zo6EyIt8C5+KskeICUlYym60dT4hZJfqWh5zn2Y1l0iEM/ld8ov+9g1vGfiXk5qEVS6Y9F2IX3/XcMklr5SBjjf6x/23apG8xnZjOrEUBzTGfdnhyDbnpeShtHmwbCE8c/RohbcaCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757508709; c=relaxed/simple;
	bh=r2jAEhbN4xsHGh1Uf6qscOG8PZsW7orCgvKgjYy4i/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y6hNnET2jGk92vlGjLgeaDb6cFtp1hA2gjlpRa46EcgF5QX36kuJw1q7uQMLALsIg4MUhfczyo/hl+VqviYxjmrpWHtsEy9UYpyCgULcNIHYyisYq9ircOQYiIVabTgTFsTxHxYE39rnHPCSYvMsllqIeqCV7KUlL3s69ie43OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pltq6KfJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757508707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=muXGymnR0Ck2Gspyi/n7s49QXlP0Ml/xlcXFqVMuFR4=;
	b=Pltq6KfJCsF/TMcROoIO5IQmf3OL6e13O0FYM8OxgUksqO60pQuIOFvgbIe+ceKrTh2cWO
	z0gCgVSQ6c5dAZGLyurmjP7A2+4pR9pNdOEwNxXWVivAxheztfhkh7ybtWJB1ZKvcLVl9k
	4BRf0TX37Dy8i5XDafl0eXF81LCUIFM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-8NXqkBmqNy2JsBM0TRxoUA-1; Wed,
 10 Sep 2025 08:51:41 -0400
X-MC-Unique: 8NXqkBmqNy2JsBM0TRxoUA-1
X-Mimecast-MFC-AGG-ID: 8NXqkBmqNy2JsBM0TRxoUA_1757508699
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 65B2C180057D;
	Wed, 10 Sep 2025 12:51:38 +0000 (UTC)
Received: from [10.45.225.144] (unknown [10.45.225.144])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7C7B31800447;
	Wed, 10 Sep 2025 12:51:34 +0000 (UTC)
Message-ID: <dcca9d10-b2b7-4534-abe6-999a9013a8e9@redhat.com>
Date: Wed, 10 Sep 2025 14:51:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next] dt-bindings: dpll: Add per-channel Ethernet
 reference property
To: Andrew Lunn <andrew@lunn.ch>, Jiri Pirko <jiri@resnulli.us>
Cc: Rob Herring <robh@kernel.org>, netdev@vger.kernel.org,
 mschmidt@redhat.com, poros@redhat.com,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20250815144736.1438060-1-ivecera@redhat.com>
 <20250820211350.GA1072343-robh@kernel.org>
 <5e38e1b7-9589-49a9-8f26-3b186f54c7d5@redhat.com>
 <CAL_JsqKui29O_8xGBVx9T2e85Dy0onyAp4mGqChSuuwABOhDqA@mail.gmail.com>
 <bc39cdc9-c354-416d-896f-c2b3c3b64858@redhat.com>
 <CAL_JsqL5wQ+0Xcdo5T3FTyoa2csQ9aW8ZxxMxVOhRJpzc7fGhA@mail.gmail.com>
 <4dc015f7-63ad-4b44-8565-795648332ada@redhat.com>
 <350cecaf-9e41-4c34-8bc0-4b1c93b0ddfe@lunn.ch>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <350cecaf-9e41-4c34-8bc0-4b1c93b0ddfe@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 09. 09. 25 3:50 odp., Andrew Lunn wrote:
>>>> Yesterday I was considering the implementation from the DPLL driver's
>>>> perspective and encountered a problem when the relation is defined from
>>>> the Ethernet controller's perspective. In that case, it would be
>>>> necessary to enumerate all devices that contain a “dpll” property whose
>>>> value references this DPLL device.
>>>
>>> Why is that?
>>
>> Because the DPLL driver has to find a mac-address of the ethernet
>> controller to generate clock identity that is used for DPLL device
>> registration.
> 
> Maybe this API is the wrong way around? Maybe what you want is that
> the MAC driver says to the DPLL driver: hey, you are my clock
> provider, here is an ID to use, please start providing me a clock?

Yes, this could be fine but there is a problem because clock id is part
of DPLL device and pins registration and it is not possible to change
the clock id without full de-re-registration. I have provided in zl3073x
a user to change the clock id via devlink but it means that the driver
has to unregister all dpll devices and pins and register them under
different clock id.

> So it is the MAC driver which will follow the phandle, and then make a
> call to bind the dpll to the MAC, and then provide it with the ID?

In fact that would be enough to expose from the DPLL core a function
to change clock id of the existing DPLL devices.

E.g.

int dpll_clock_id_change(struct module *module, u64 clock_id,
			 u64 new_clock_id)
{
	struct dpll_device *dpll_pos;
	struct dpll_pin *pin_pos;
	unsigned long i;

	mutex_lock(&dpll_lock);
	/* Change clock_id of all devices registered by given module
	 * with given clock_id.
	 */
	xa_for_each(&dpll_device_xa, i, dpll_pos) {
		if (dpll->clock_id == clock_id &&
		    dpll->module == module)
			dpll_pos->clock_id = new_clock_id;
		}
	}
	/* Change clock_id of all pins registered by given module
	 * with given clock_id.
	 */
	xa_for_each(&dpll_pin_xa, i, pos) {
		if (pin_pos->clock_id == clock_id &&
		    pin_pos->module == module) {
			pos->clock_id = new_clock_id;
		}
	}
	mutex_unlock(&dpll_lock);
}

With this, the standalone DPLL driver can register devices and pins with
arbitrary clock_id and then the MAC driver can change it.

Thoughts?

Thanks,
Ivan


