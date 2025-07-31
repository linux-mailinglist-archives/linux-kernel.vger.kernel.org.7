Return-Path: <linux-kernel+bounces-751482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4ABCB16A2B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 03:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15E8516C405
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 01:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D00013AA2A;
	Thu, 31 Jul 2025 01:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WusmOceC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363B73595A
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 01:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753925904; cv=none; b=oXFd1vk+Cszl8AMofirandYiKvHc0LKKf7E/qjcCnMHeie2LDNGMyXiCMTRoSes3lWmw305mL8E6QC61e7CUyIOgs1NMlIbrLbPCSkuRpcCwhzX0/NwF3GQPPID55QvkUfijiJ8vNzgLJNalELI3YC3Tq2LaKOMoeDP5HV8+tfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753925904; c=relaxed/simple;
	bh=8ya7e6/CKYInYotmvzdXqePRXf+We+Yf0/tthtPk6a8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q4b37ywHdRUFbOOtYpLP9CCjnKWrWtpYxZchqARS+N0uMXVMcZKoVlSB5C0O6soh4+zUS19XHiH5zkWkGEhwgLqDDYz6WoVwxcOBrj/ZIh9QEeHmcnE+lkqkP9iUH2ndj5Vx3ERdBbx9NCWOdugFI22sbtoOa0BdtxWjTQI3ERU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WusmOceC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753925902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e8OY69MZlq/xsrBb9axeH4pIVOb+xTllFUAYP1I6n5U=;
	b=WusmOceC1ChbgaCH44N4zpNHw8etE+AGdYv7kuF2STLFWXtPyYghoQt7GlO1StRDdPr2fr
	nkzYZcFGFUmVFnl5BEx0odabFjMiAUsB1f2rUMyX4ipZ1JOdGsXca2gMQotaHmvSRNzwn9
	mSMm1G9PzPiLjCk2/P/mG4AIAxwb/z0=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-eAEbgEnUN269TpYFXxAtXw-1; Wed, 30 Jul 2025 21:38:20 -0400
X-MC-Unique: eAEbgEnUN269TpYFXxAtXw-1
X-Mimecast-MFC-AGG-ID: eAEbgEnUN269TpYFXxAtXw_1753925900
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-87c33c0b62eso36666039f.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 18:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753925899; x=1754530699;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e8OY69MZlq/xsrBb9axeH4pIVOb+xTllFUAYP1I6n5U=;
        b=AoM+RBuoL/Uxzk6a3rEH3QRD6hxVI1c1QLJ7VNzt0vuZ709bwRr3ZoROcfOhbLV38H
         dkTHgnV3+h2V4kS0Ct8Bb/RzTwcCfCp8CIrNMfRXFBjxOdmJAr0/jokZHGBezl1A/eWB
         zhwmUt9h57Li2jh99MIMSX20aswP3NDdkCjfkwVm/+DUbbxWsqmQtQ4g6FBStaojgcpr
         qeID4agohERUzt+DUX/t63Mznx9ew1RpUnsjjFZ6eITZhYKw8aHCa9FItFEvZvE3s/84
         mLJ4OzsD58ERVI4qR946ve/wRBDAZ0VKd3hNSFMSuqqylIOSVkYG1sifkms8/MaTdXXm
         TH8g==
X-Forwarded-Encrypted: i=1; AJvYcCX5X4l4zYN6QxnbqKvv7RCMwmDqKfFf4IjG3z7sWIqK9edCaZAUHlEaMMIv47OFyACF/NsKurn8Kp3RUms=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuAIGo/QWDj9PvOi0orCJu7mFs6R6koTRsgXLFFiduLVlp4k5o
	qL9zRB14dysG1WQRXhctvoHrU8LPql0mBDOoYqRzRpjcAgjNt74RmvEvtX0Q2AXLdqmROoDiaZc
	/07VKdDxfS/RJcRJunqmvaDEo4oMQrbTlFReYMDhfM2TFjAbbJN4waxwKk6Jh6hv5/iUzPdnEuH
	Oj
X-Gm-Gg: ASbGncuL0CbJiauyDfLOWtpP7hJXLBhLZsi9ShmV6USFLkKlcj1R4ZjsmKHk1Yi2bPk
	CfV6CUnialoGimwKRwW2QcklhjHlcGMqURDy6YDhlyi/xDusR1qCMQURHEanhBKPZriv9+FYyWK
	GXtWzb5ZzQGIHDdrLnlJB2o8BAzsfn1dyuCkHqIROS0bNoDniR2LEZtMaTW4RZE2o6ObqPPCXOM
	9M4KjFtgxsUpExlBdewejfuYw8BHXkEo9Ka1dYI01QSTYTZ8DBf4JU3vm0DJsqTEVI6s+JfTS5Y
	DxuZWEspn6FrGkMZPDotYtldo36s0n5xDhMlzGYGGcoxlyC4B3t2w9kj1y2OhNaPfTt9JBZ/G3t
	I
X-Received: by 2002:a05:6602:1592:b0:85d:b054:6eb9 with SMTP id ca18e2360f4ac-88138b04598mr1029070039f.14.1753925899509;
        Wed, 30 Jul 2025 18:38:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDYpvJqVTQun48scooKx53IQp8MzyEscpkj6Zf7fOtkrrh/YzKc++iz/oiD39bF32aJz1UpQ==
X-Received: by 2002:a05:6602:1592:b0:85d:b054:6eb9 with SMTP id ca18e2360f4ac-88138b04598mr1029067239f.14.1753925899081;
        Wed, 30 Jul 2025 18:38:19 -0700 (PDT)
Received: from [10.0.0.82] (75-168-243-62.mpls.qwest.net. [75.168.243.62])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8814dfa2282sm12147439f.27.2025.07.30.18.38.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 18:38:18 -0700 (PDT)
Message-ID: <fb7e2cc2-a13a-4ff7-b4ab-8f39492d3f76@redhat.com>
Date: Wed, 30 Jul 2025 20:38:17 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/4] 9p: convert to the new mount API
To: asmadeus@codewreck.org
Cc: v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, ericvh@kernel.org, lucho@ionkov.net,
 linux_oss@crudebyte.com, dhowells@redhat.com
References: <20250730192511.2161333-1-sandeen@redhat.com>
 <aIqa3cdv3whfNhfP@codewreck.org>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <aIqa3cdv3whfNhfP@codewreck.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/30/25 5:21 PM, asmadeus@codewreck.org wrote:
> Hi Eric,
> 
> Eric Sandeen wrote on Wed, Jul 30, 2025 at 02:18:51PM -0500:
>> This is an updated attempt to convert 9p to the new mount API. 9p is
>> one of the last conversions needed, possibly because it is one of the
>> trickier ones!
> 
> Thanks for this work!
> 
> I think the main contention point here is that we're moving some opaque
> logic that was in each transport into the common code, so e.g. an out of
> tree transport can no longer have its own options (not that I'm aware of
> such a transport existing anyway, so we probably don't have to worry
> about this)

I had not thought about out of tree transports. And I was a little unsure
about moving everything into fs/9p/* but I'm not sure I saw any other way
to do it in the new framework. @dhowells?

> OTOH this is also a blessing because 9p used to silently ignore unknown
> options, and will now properly refuse them (although it'd still silently
> ignore e.g. rdma options being set for a virtio mount -- I guess there's
> little harm in that as long as typos are caught?)

Well, that might be considered a regression. Such conversions have burned
us before, so if you want, it might be possible to keep the old more
permissive behavior ... I'd have to look, not sure.

> So I think I'm fine with the approach.
> 
>> I was able to test this to some degree, but I am not sure how to test
>> all transports; there may well be bugs here. It would be great to get
>> some feedback on whether this approach seems reasonable, and of course
>> any further review or testing would be most welcome.
> 
> I still want to de-dust my test setup with rdma over siw for lack of
> supported hardware, so I'll try to give it a try, but don't necessarily
> wait for me as I don't know when that'll be..

Cool, thanks.

-Eric


