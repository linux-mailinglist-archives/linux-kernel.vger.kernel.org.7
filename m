Return-Path: <linux-kernel+bounces-598892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E37A84C5B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 20:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 563A8177420
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 18:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8823728FFCB;
	Thu, 10 Apr 2025 18:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V6QoxLoq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6834328F934
	for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 18:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744310701; cv=none; b=EwK42rJGsC+AP2tE+TnQYIcCInv7mWEnye2iPZ1hWoUPLWE3aebDwy8XHwPS2JMOvfe5RJbY1XZ8RqV/UbpkPiFRCz8s6kkEPI3Wt++y9dxb+HpIIUQEYf+HVMPxL6CyZO5hAxNGSTbZ4IZ6fEzAyLuxQCA/StujfMFEPMFJuPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744310701; c=relaxed/simple;
	bh=v3n2R5O02yDEN9ynK2Ai+Tu/+qV1m7kEFX8OMWLqP0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WU8gO8R/nofVjNJTaV1hrT++oI2Wb73YkHiwpvNdCvz8wpKofRs3rrJ6YtinHqMLUSayqNreTdHVTceP02G0srmj7F3BX6b87TCrvXTB/P2n65ghb95kxJscpHVGhbCgoPZpWQy3jJkCTNQppYL1Pfv8glkCcQScxJuH3tlQ0pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V6QoxLoq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744310698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LI6/gRw/3WvDpk8qO8WgudVEqcKJWCfaWy2k2LrSLLQ=;
	b=V6QoxLoqEsgEEY4ABgwQpoi+bIhl7griwbKOZaq/p2ySN5SPmp7sNdKNBqAFhBWD0MspGf
	fiIdhpkyvOb1B808v+lVHnL15l6XDU77P+nASIHt0ZzOS1T9TDnfx0NRObLxFB9RjqFuZF
	GA6noKrSt3a/sjLblvVHnZAFCg41dyY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-145-IF_7rsMXNG22TdIt5Se9uw-1; Thu,
 10 Apr 2025 14:44:53 -0400
X-MC-Unique: IF_7rsMXNG22TdIt5Se9uw-1
X-Mimecast-MFC-AGG-ID: IF_7rsMXNG22TdIt5Se9uw_1744310690
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 519D1180034D;
	Thu, 10 Apr 2025 18:44:50 +0000 (UTC)
Received: from [10.45.225.124] (unknown [10.45.225.124])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 271973001D0E;
	Thu, 10 Apr 2025 18:44:44 +0000 (UTC)
Message-ID: <003bfece-7487-4c65-b4f1-2de59207bd5d@redhat.com>
Date: Thu, 10 Apr 2025 20:44:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/14] mfd: zl3073x: Add components versions register
 defs
To: Andrew Lunn <andrew@lunn.ch>
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
 <20250409144250.206590-8-ivecera@redhat.com>
 <df6a57df-8916-4af2-9eee-10921f90ff93@kernel.org>
 <c0ef6dad-ce7e-401c-9ae1-42105fcbf9c4@redhat.com>
 <098b0477-3367-4f96-906b-520fcd95befb@lunn.ch>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <098b0477-3367-4f96-906b-520fcd95befb@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4



On 10. 04. 25 7:41 odp., Andrew Lunn wrote:
>>>> +	/* Take device lock */
>>>
>>> What is a device lock? Why do you need to comment standard guards/mutexes?
>>
>> Just to inform code reader, this is a section that accesses device registers
>> that are protected by this zl3073x device lock.
> 
> I didn't see a reply to my question about the big picture. Why is the
> regmap lock not sufficient. Why do you need a device lock.
> 
>>
>>>> +	scoped_guard(zl3073x, zldev) {
>>>> +		rc = zl3073x_read_id(zldev, &id);
>>>> +		if (rc)
>>>> +			return rc;
>>>> +		rc = zl3073x_read_revision(zldev, &revision);
>>>> +		if (rc)
>>>> +			return rc;
>>>> +		rc = zl3073x_read_fw_ver(zldev, &fw_ver);
>>>> +		if (rc)
>>>> +			return rc;
>>>> +		rc = zl3073x_read_custom_config_ver(zldev, &cfg_ver);
>>>> +		if (rc)
>>>> +			return rc;
>>>> +	}
>>>
>>> Nothing improved here. Andrew comments are still valid and do not send
>>> v3 before the discussion is resolved.
>>
>> I'm accessing device registers here and they are protected by the device
>> lock. I have to take the lock, register access functions expect this by
>> lockdep_assert.
> 
> Because lockdep asserts is not a useful answer. Locks are there to
> protect you from something. What are you protecting yourself from? If
> you cannot answer that question, your locking scheme is built on sand
> and very probably broken.
> 
>      Andrew

Hi Andrew,
I have described the locking requirements under different message [v1 
05/28]. Could you please take a look?

Thanks,
Ivan


