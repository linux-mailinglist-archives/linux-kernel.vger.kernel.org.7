Return-Path: <linux-kernel+bounces-810760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC8CB51EFC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 19:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60EC416CABB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8963C32A826;
	Wed, 10 Sep 2025 17:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hAlKPrfa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5834B28C2D2
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 17:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757525492; cv=none; b=UcSuAIer7NWTebJP/8EvrShyWxQLOIwCLyXxBxTK4ZqUc18PlXadHN5rqSurOnFWFta6xYdCXFYt32TCnjim/wXQXJj3qUhH7EUGWBNiWj8CS5COLgY7b5692k0ya/CD3NqHE1fxKQ3Ovb9ssl8CB9dkUpRTx1jvLbCHJuk1a3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757525492; c=relaxed/simple;
	bh=T42WLsYUag3i4x76FdcxddwpCrpFK4jtgY9tzWa7sDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OngBLO8ua8amZw8hUJFGbIHA9EgKkDg28F7zHSX3HSEEvrggAUZroho4vepC6uph6m+9lwllti79DsrnqamWiXkfVNwT4RpcaU3EVmSUb4UnNCzwzXl6eA2ac9VJWII6nNQCCFPun3PQcoMo4iNPuJxteAjy388ktl9fuwaaEio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hAlKPrfa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757525490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y4DBrNtiTrUiFvnKqXZbU34j/Yix0O34EDnkigeP54A=;
	b=hAlKPrfaAI/0yFydyk3T2M4nMoN/Nr7OGzmoNbgVznPfKp7nVqw2YeICl1Brx5BFoiEQMt
	Ly9l1i20EdZarSJu7/xnKqiAWtMRTOh8NqAWWxmLW10h4G3dRFC4OpJ60L0DkTEgMwg9Va
	u2IgcGuQhmS72Wrcy/suBvM4taQIWtQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-F2ttI1oxPJquUvy_WeqVng-1; Wed,
 10 Sep 2025 13:31:26 -0400
X-MC-Unique: F2ttI1oxPJquUvy_WeqVng-1
X-Mimecast-MFC-AGG-ID: F2ttI1oxPJquUvy_WeqVng_1757525485
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 70E6619541B2;
	Wed, 10 Sep 2025 17:31:24 +0000 (UTC)
Received: from [10.45.225.144] (unknown [10.45.225.144])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 935291956095;
	Wed, 10 Sep 2025 17:31:20 +0000 (UTC)
Message-ID: <4277866b-67e9-4d75-a7e4-9296b898fbcb@redhat.com>
Date: Wed, 10 Sep 2025 19:31:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] dpll: zl3073x: Allow to use custom phase measure
 averaging factor
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Prathosh Satish <Prathosh.Satish@microchip.com>,
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250910103221.347108-1-ivecera@redhat.com>
 <acfc8c63-4434-4738-84a9-00360e70c773@lunn.ch>
 <0817610a-e3dd-427e-b0ad-c2d503bb8a4f@redhat.com>
 <10886c5f-1265-46ec-8caa-41bde6888905@lunn.ch>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <10886c5f-1265-46ec-8caa-41bde6888905@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17



On 10. 09. 25 7:06 odp., Andrew Lunn wrote:
> On Wed, Sep 10, 2025 at 06:50:47PM +0200, Ivan Vecera wrote:
>> On 10. 09. 25 6:13 odp., Andrew Lunn wrote:
>>> On Wed, Sep 10, 2025 at 12:32:21PM +0200, Ivan Vecera wrote:
>>>> The DPLL phase measurement block uses an exponential moving average,
>>>> calculated using the following equation:
>>>>
>>>>                          2^N - 1                1
>>>> curr_avg = prev_avg * --------- + new_val * -----
>>>>                            2^N                 2^N
>>>>
>>>> Where curr_avg is phase offset reported by the firmware to the driver,
>>>> prev_avg is previous averaged value and new_val is currently measured
>>>> value for particular reference.
>>>>
>>>> New measurements are taken approximately 40 Hz or at the frequency of
>>>> the reference (whichever is lower).
>>>>
>>>> The driver currently uses the averaging factor N=2 which prioritizes
>>>> a fast response time to track dynamic changes in the phase. But for
>>>> applications requiring a very stable and precise reading of the average
>>>> phase offset, and where rapid changes are not expected, a higher factor
>>>> would be appropriate.
>>>>
>>>> Add devlink device parameter phase_offset_avg_factor to allow a user
>>>> set tune the averaging factor via devlink interface.
>>>>
>>>> Tested-by: Prathosh Satish <Prathosh.Satish@microchip.com>
>>>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>>>> ---
>>>>    Documentation/networking/devlink/zl3073x.rst |  4 ++
>>>>    drivers/dpll/zl3073x/core.c                  |  6 +-
>>>>    drivers/dpll/zl3073x/core.h                  |  8 ++-
>>>>    drivers/dpll/zl3073x/devlink.c               | 67 ++++++++++++++++++++
>>>>    4 files changed, 82 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/Documentation/networking/devlink/zl3073x.rst b/Documentation/networking/devlink/zl3073x.rst
>>>> index 4b6cfaf386433..ddd159e39e616 100644
>>>> --- a/Documentation/networking/devlink/zl3073x.rst
>>>> +++ b/Documentation/networking/devlink/zl3073x.rst
>>>> @@ -20,6 +20,10 @@ Parameters
>>>>         - driverinit
>>>>         - Set the clock ID that is used by the driver for registering DPLL devices
>>>>           and pins.
>>>> +   * - ``phase_offset_avg_factor``
>>>> +     - runtime
>>>> +     - Set the factor for the exponential moving average used by DPLL phase
>>>> +       measurement block. The value has to be in range <0, 15>.
>>>
>>> Maybe put the text in the commit message here as well?
>>
>> Do you mean to put the equation and details from commit message here?
>> This is pretty long.
> 
> So what if it is long? At the moment, it is hiding in the commit
> message. It is not easy to find, you effectively need to be a kernel
> developer to find it. If it is in the documentation of the device, it
> will be much easier to find and understand what this knob actually
> does.
> 

Agree. I will describe it in more detail in the documentation.
+ optimization proposed by Vadim.

Thanks for the review.

Ivan



