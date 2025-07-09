Return-Path: <linux-kernel+bounces-724551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F18CAFF42E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 23:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63A48484FC0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FB3243954;
	Wed,  9 Jul 2025 21:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KC8OYREL"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7E723A9A0
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 21:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752098259; cv=none; b=ay7HZUR6gsMzdISBY2/8bZO4IqT+0T8SwzQyoqisRbWpfAxVjW1kKuRniOQznzWr14vbOZ6bueg9CPCu8KQz02YlcSP0SsYiT3H7/XAP/NOYaARVQZvIB/UfbvfQDbSzg2dX8ftx6QcOSuyex4nxDBzWiQVUzYam9/NzCbVD7Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752098259; c=relaxed/simple;
	bh=GggSCL7kVc/JLMhCJJIxTUCZhV6z3eCmnLw/ITJfK4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h1lmuffYqvFFkbzsr5gReRx9d/rwvJP/gmNt1pC8pOQb7sfjf/jIlyByk5KihLWsPYaUzGpzvVDuwqrGsNwiW9bu5yPFEom0LgGVTmk9o1BGebE/Zw5ZttiQpqBEAPj+1d9uBYvrIgw6DzRHhxaT2zAUdVq639xIEgcZIWGq0JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KC8OYREL; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-876ae3f7768so36496639f.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 14:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1752098257; x=1752703057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4cIZsTs8Q4emZ1Mk4QMwxb5IW3akMn2LlzUjyqD/9w4=;
        b=KC8OYRELIlgXs2pnAjuTUdAIn7InagPFcr0gpWzXSbjgR54S28RUiS7DXmPaKavLhn
         ioARpSqw38VcTEt2SkVWW2sWc2ycj3YFnPHPS4t/7ozw6Tm13Py5vXQ+mtvZ/V79NewK
         4uUp/gpc2fFNenXGFRI7i9N8us+33DrigMirQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752098257; x=1752703057;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4cIZsTs8Q4emZ1Mk4QMwxb5IW3akMn2LlzUjyqD/9w4=;
        b=kpcUoAP8SWCBr9y7W12BShIxytIBhi2nZr6Y9lRdreoYLXfZG2cu4+8mqiZtMBgdNH
         rHMRIFJxQkHWG27j7lF2Bzv7XR6orxgHPSJmi6MFp+PBh7oWOquQrWCLoHzGLGxihhu5
         M/pUdMzt/4eZo9Z4ENmelygpkZqI+PCkV2+e4/Ei/PDgA9JfZONgQMTlg7nAyA6tSW+V
         q2Y2QyLOpWxQqrK2jWmjXlC0mQ4lPkhQkMPpxP9zVEFaRx5YdqTmbu4Nhba5/ZOH07jl
         KhsaGxnsSA0NbYkBMzt+lSrVTRtcquSKVG5UJC29G5HMkdZZBQikIjGYdzlZE5V29ba1
         Z/Xg==
X-Forwarded-Encrypted: i=1; AJvYcCXX83hRHJ9efF+ayP20VPg2CxkKIztqOcpqPaJ/mY3J4GPmB1Ced+cosxfw9kRFOxDyNmbeAzlIJMHK+m4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ8EVmVQ9Xl7gzK3igZagz3oF80gcF+bBfkBK8CWw6j6Ea/WlJ
	wKHdcW7IFLsR5L8GwQx3VDUTLspHXyum7mfrfm+fnlFw5bXrBX8cfAYuzcjpIQ5yf2c=
X-Gm-Gg: ASbGncuHb5gr9PPPKK4LsOo6ge2cRsMzVN8DWxWbf4bB18TrUu5NGMt3sPnwySpNQ3I
	FfYnGFa8mnSPeIA7wB/+jMhcXd+9RZBzMyMgf4IqEqp4fJXVyqpSHCTCI/b+xRt6Wfnzd7QQIfs
	e97oQWkiypokyPpFp9UXMET7Cz8VGLbwbaPMPsg4ASjriBjAgSGIfhVrvaxvLXP58R+EpzEjKaA
	/QKIXviimgkHMi3Qc/sAIShnolPQtUjioGejaIWS8+Ch7e2qAPaE71xTIqcuF2s4otKczIsg0D1
	Wlg8MNiqKrCgVpTokt2swRF5pk8sV5dweONimXzoArogb/WFSOudRPIooWgVGy1LZtOazQbKBw=
	=
X-Google-Smtp-Source: AGHT+IGB/kb3vr5Nj+n5PpGd60goWuC3Uuhhz3EJf2x/C9sBHf+L0OViesyOOnLrwsGmMf9axZLG4g==
X-Received: by 2002:a05:6602:6785:b0:876:8bf2:e4d2 with SMTP id ca18e2360f4ac-87968f5741fmr26316039f.2.1752098257139;
        Wed, 09 Jul 2025 14:57:37 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-876e07bd7a3sm365388739f.16.2025.07.09.14.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 14:57:36 -0700 (PDT)
Message-ID: <4478924b-fbd7-4a5a-ad0d-4fe0569b4971@linuxfoundation.org>
Date: Wed, 9 Jul 2025 15:57:35 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usbip: convert to use faux_device
To: Alan Stern <stern@rowland.harvard.edu>,
 Greg KH <gregkh@linuxfoundation.org>
Cc: Zongmin Zhou <min_halo@163.com>, shuah@kernel.org,
 valentina.manea.m@gmail.com, i@zenithal.me, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, zhouzongmin@kylinos.cn,
 Shuah Khan <skhan@linuxfoundation.org>
References: <2025062004-navy-emboss-4743@gregkh>
 <2e0bbc5a-e74a-4fb5-884c-686dbaf99caf@linuxfoundation.org>
 <48ab511e-2847-4daa-98de-a234b8584b78@163.com>
 <fac026d8-12c8-4c1f-96a7-264ced8391f1@linuxfoundation.org>
 <a29703bd-08b7-489b-8fb0-15838a1245ab@163.com>
 <1a13cf53-ffed-4521-917e-9c2856a5e348@linuxfoundation.org>
 <4fc877f0-b55b-4fa3-8df4-2de4ba1ac51b@163.com>
 <2a901b8a-9052-41d9-a70d-76508ebd819b@linuxfoundation.org>
 <4759911b-8c35-4ca9-bc34-09dd41b14582@163.com>
 <2025070949-activist-mammal-b806@gregkh>
 <dd3659dd-7e45-479d-ab65-9f5c1bab26a0@rowland.harvard.edu>
 <ce96291b-c0b2-41cf-a71c-c13bd8d0f139@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ce96291b-c0b2-41cf-a71c-c13bd8d0f139@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/9/25 15:49, Shuah Khan wrote:
> On 7/9/25 08:20, Alan Stern wrote:
>> On Wed, Jul 09, 2025 at 12:06:57PM +0200, Greg KH wrote:
>>> On Wed, Jul 09, 2025 at 05:07:24PM +0800, Zongmin Zhou wrote:
>>>>>> In fact, I've experimented with adding PM hooks to the faux bus,
>>>>>> and found that faux bus devices then behave identically to platform
>>>>>> bus devices during suspend/resume.
>>>>>> See the attachment.
>>>>>>
>>>>>
>>>>> Thanks for checking this scenario. No surprises here.
>>>> Another part of my purpose in doing this is that the vhci-hcd driver seems
>>>> should still retain suspend/resume hooks. Therefore, the faux bus should
>>>> add corresponding hooks to allow the driver to call its own pm functions.
>>>> Though currently don't know how to fix this problem yet.
>>>
>>> I have no problem with adding the pm functions to the faux bus, BUT it
>>> needs to make sense as to why they would be needed at all as this is not
>>> a "real" device or bus that should need to do anything when
>>> suspend/resume happens.
>>
>> The unique problem faced by vhci-hcd is that the devices it controls
>> reside on external computer systems that have a lot of their own state,
>> much more than ordinay USB devices have.  Consequently vhci-hcd may need
>> to do more work for a PM transition than a normal driver would.
>>
>> As an analogy, suppose you're running a program that has an open TCP
>> connection to an external server.  If you suspend your computer, it
>> won't be able to send the TCP keepalive packets that the server expects,
>> and the server will eventually close the connection.  Then when your
>> computer resumes, your program may misbehave when it finds its
>> connection has spontaneously been closed for no apparent reason.
>>
> 
> Right. We have a few too many moving pieces here:
> 
> usbipd (user-space)
> vhci_hcd and the usb devices it creates
> 
> usbip_host, stub driver that proxies between the device
> on the server and vhci_client.
> 
> PM can be complex and it has to do lot more than it currently
> does on both server and client end to support seamlessly.
> 
> The current suspend took the approach of refusing suspend
> which doesn't work since usb devices underneath hang in
> usb_dev_resume(). Looks like this usb device is treated like
> a real device bu usb core. Is there a way to have usb core
> PM (suspend and resume) handle them as virtual? Would it
> help to use "supports_autosuspend" to disable suspend and
> resume?

Would it work if usb_disable_autosuspend() on the devices
that hang off its vitual bus?

thanks,
-- Shuah

