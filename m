Return-Path: <linux-kernel+bounces-810715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C53FAB51E49
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7291481DA5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B0C27B33E;
	Wed, 10 Sep 2025 16:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IHLDYn0T"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E65275B13
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 16:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757523070; cv=none; b=Ay0zV/Nu2f5bZmcZYBfEdd978DJiN7EWqo4HpC9z+t/oXcjYPePo+70kQSbF3E0DwiOFpFxQwgQ4s04Mv4fG6haCI8WMKM6cDnWy3pZCmI+P1BAjOP+vPx0khYy5q9D5/kBj/PK20cTojlwU6b/zzHRPkZyZARSeiKsJt90GD7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757523070; c=relaxed/simple;
	bh=h3/FAOSRRVmznFBcQ4npGgTTtGHAFrZyox46Q/dAY2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VDu3e3wm0dMi53cNFoNPVk/X7FrEbe1jSUktd/BqqRxwLVEN6e79g4x9rCagoy3ok9qeY4rGZGhq+VUP/F2TingPLmfOn1xeEU/HpBfAzUTIVoHIkQ56u39wpqSEwSszOkA/M5/zuJGeYG4r7y0aARljdzsCqQRQhqBx6oMiHM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IHLDYn0T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757523067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IQKT4ZzpNa/yKWGTVArTDPi3S7egIlUSjK6QBqA8Noc=;
	b=IHLDYn0TgrB4Q9SKj6yIQgQKq792+ngnAYADtkEm8FP+LhiprJ2wzwWw/CsUfGkqog37Zc
	eryjvjo3WneTc4q6PNiFR4ePIbaxABZuZHZI1ZbDxQvvyFboG8sX/LPploSsHpkqwf4sdr
	bUpVZGZ3VGEcPA7cBOt2Kx6BggIUJv8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-tD-GeKuiO0mEr3n384YwTQ-1; Wed,
 10 Sep 2025 12:51:02 -0400
X-MC-Unique: tD-GeKuiO0mEr3n384YwTQ-1
X-Mimecast-MFC-AGG-ID: tD-GeKuiO0mEr3n384YwTQ_1757523059
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2F5C5180048E;
	Wed, 10 Sep 2025 16:50:59 +0000 (UTC)
Received: from [10.45.225.144] (unknown [10.45.225.144])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4DC7B180035E;
	Wed, 10 Sep 2025 16:50:53 +0000 (UTC)
Message-ID: <0817610a-e3dd-427e-b0ad-c2d503bb8a4f@redhat.com>
Date: Wed, 10 Sep 2025 18:50:47 +0200
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
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <acfc8c63-4434-4738-84a9-00360e70c773@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 10. 09. 25 6:13 odp., Andrew Lunn wrote:
> On Wed, Sep 10, 2025 at 12:32:21PM +0200, Ivan Vecera wrote:
>> The DPLL phase measurement block uses an exponential moving average,
>> calculated using the following equation:
>>
>>                         2^N - 1                1
>> curr_avg = prev_avg * --------- + new_val * -----
>>                           2^N                 2^N
>>
>> Where curr_avg is phase offset reported by the firmware to the driver,
>> prev_avg is previous averaged value and new_val is currently measured
>> value for particular reference.
>>
>> New measurements are taken approximately 40 Hz or at the frequency of
>> the reference (whichever is lower).
>>
>> The driver currently uses the averaging factor N=2 which prioritizes
>> a fast response time to track dynamic changes in the phase. But for
>> applications requiring a very stable and precise reading of the average
>> phase offset, and where rapid changes are not expected, a higher factor
>> would be appropriate.
>>
>> Add devlink device parameter phase_offset_avg_factor to allow a user
>> set tune the averaging factor via devlink interface.
>>
>> Tested-by: Prathosh Satish <Prathosh.Satish@microchip.com>
>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>> ---
>>   Documentation/networking/devlink/zl3073x.rst |  4 ++
>>   drivers/dpll/zl3073x/core.c                  |  6 +-
>>   drivers/dpll/zl3073x/core.h                  |  8 ++-
>>   drivers/dpll/zl3073x/devlink.c               | 67 ++++++++++++++++++++
>>   4 files changed, 82 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/networking/devlink/zl3073x.rst b/Documentation/networking/devlink/zl3073x.rst
>> index 4b6cfaf386433..ddd159e39e616 100644
>> --- a/Documentation/networking/devlink/zl3073x.rst
>> +++ b/Documentation/networking/devlink/zl3073x.rst
>> @@ -20,6 +20,10 @@ Parameters
>>        - driverinit
>>        - Set the clock ID that is used by the driver for registering DPLL devices
>>          and pins.
>> +   * - ``phase_offset_avg_factor``
>> +     - runtime
>> +     - Set the factor for the exponential moving average used by DPLL phase
>> +       measurement block. The value has to be in range <0, 15>.
> 
> Maybe put the text in the commit message here as well?

Do you mean to put the equation and details from commit message here?
This is pretty long.

Ivan


