Return-Path: <linux-kernel+bounces-726449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BC8B00D32
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FC8D1C864C9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 20:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55082FCFFF;
	Thu, 10 Jul 2025 20:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="egxE2DuR"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F2B28B7C2
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 20:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752179628; cv=none; b=nxh/XGK/b61a1rfu3xn1+YLpsHhWwQ3C5jYpvIHF8cUfz7RvQOHZR05qfmkaQuc4vPiIAzHYcLPVrZnV+Ifbb1wqs37Kd2rnUx70mWfA7FSdFvFL2Uh1Lk9wOchytYcYdlwKP00sRnWiN1DB6stpvhcUdmjdT5QXEcs8FMSLUhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752179628; c=relaxed/simple;
	bh=5qy1xyi+PHINNpx4IHchgApbMnho5lSQw+phPAe5HCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d7sDphKO2t3BV7jVrO/tTgHhMenKLc0z7ERb+WK2mQsZwhkE24whxc9UjKxBinHrWt/8xHeq8b7kXpm0HkST68xMljCnjKDPVFk7g2zZo2D4fhrFtwiXRpS14N3ov/XY/YLdBIbZQazF7N4J4HFmejhNFGGMoSVIz6A9oM7ZY68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=egxE2DuR; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-86d0c598433so47551139f.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 13:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1752179625; x=1752784425; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wG9xDNp/XB+Bnyp+PUjlusXMGkQH6UQD40ceGqSuxnA=;
        b=egxE2DuRL9wZNVoYOcgSTkWc39SAe3opQafqB/2wd5FeOzo+cN1uqGDFd6Qn0sZ6kY
         larSuOajWunUelCltCZhCuCmZ2uFQCOBf7KI5t42cpww0l2kJ+33q+suMo2ADp1zgse4
         frEA5RZJCWgc3M5Uhg0xHX2D+b9HLTqir8UeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752179625; x=1752784425;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wG9xDNp/XB+Bnyp+PUjlusXMGkQH6UQD40ceGqSuxnA=;
        b=QFzS9ORIwUZMp6S9nBxiSBUH5gbhblhf4DJyvpiw0wvY9n6I5yWH/nZ3hP8yc5wrrZ
         daBN7hZmW2puAaMuQ6gClKgf2CmhTdFwKkxpnldBfBgyUOMdJlZJhsUuQunQv2frbFwe
         3t7RZYpVVzzIQyWJ84cybqEkGyguffmKJCU8ryyiy+zuU4tb/zuqs00ojvHHr8lALKpk
         2kNfWgVz28BElyvvZFUTiVXqAG17wmbHHXP8u/n4dabbOlUqMnkAiId+KR3UbnoSS1xo
         EuyIPXgVR3ojYkI3wgdvhV7U91jO4gyHxvGUraLLLDAoGySROsCghcBmXwChHN20tdTQ
         wrGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXy6Ln+V62zfASz46T5yxMhz3bgms1Z21VETZLd5tX82ICsKwQexCrUoRa9yxuwVGGis6+dJ88DNHn0ZHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiGhKdeFBSjFzBPYJ0Z/lWOeCymHBt1cvqwXZsRCf0MSE4zdz1
	4a2GQwdmFuAecVh2qzT+cbdWjHegCKWRxyJEBrqRbgPnhYTidv97IcTKyfJZEM83yW8=
X-Gm-Gg: ASbGncuWkatOBVrNqZa1KSDHsSvb1diz38QTm55FTKtV4/mA3VS5nTFkeqkxNXC4zrP
	7Q8hOPS15sZaIloNIO/9Qg70sL5Lnh8CcBuMAfbx5SIVwLI4v2WO87uSL/NpOYYrSYnNKt+NiJD
	rpV4He5y1t06gHu0PY9YqxhQywgVlb4x4XLeeFjSYUVrWLzXGmiLrCBUmu8Xkbd1uPNO8lU07bp
	/AYrmM7r037FXpqjtJsAuQG3T5bHACBLpo5DomxtoL1f7s7xFvNUNlKtxCnexU5S292hI4IwYGT
	C2TLjlay6OQOV8GANNfg1EqDMnVvLek/xhWN1J4XF+fQhmuVkJ3nU+njsPUXnrv4uiZO88y8vA=
	=
X-Google-Smtp-Source: AGHT+IEMqYFgSMCk8HDzLOLRBp8ULbcPFi06hG8ha8tdAi1FYU8W2pWxGpw/obw774/Y9ibUji0poQ==
X-Received: by 2002:a05:6602:6d82:b0:879:49e9:5156 with SMTP id ca18e2360f4ac-8797889614cmr72906339f.9.1752179623641;
        Thu, 10 Jul 2025 13:33:43 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-505569cc09dsm494224173.96.2025.07.10.13.33.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 13:33:43 -0700 (PDT)
Message-ID: <9be8b1dc-9af2-4135-9a0f-db2eb7d10f06@linuxfoundation.org>
Date: Thu, 10 Jul 2025 14:33:42 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usbip: convert to use faux_device
To: Alan Stern <stern@rowland.harvard.edu>,
 Greg KH <gregkh@linuxfoundation.org>, Zongmin Zhou <min_halo@163.com>
Cc: shuah@kernel.org, valentina.manea.m@gmail.com, i@zenithal.me,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 zhouzongmin@kylinos.cn, Shuah Khan <skhan@linuxfoundation.org>
References: <fac026d8-12c8-4c1f-96a7-264ced8391f1@linuxfoundation.org>
 <a29703bd-08b7-489b-8fb0-15838a1245ab@163.com>
 <1a13cf53-ffed-4521-917e-9c2856a5e348@linuxfoundation.org>
 <4fc877f0-b55b-4fa3-8df4-2de4ba1ac51b@163.com>
 <2a901b8a-9052-41d9-a70d-76508ebd819b@linuxfoundation.org>
 <4759911b-8c35-4ca9-bc34-09dd41b14582@163.com>
 <2025070949-activist-mammal-b806@gregkh>
 <dd3659dd-7e45-479d-ab65-9f5c1bab26a0@rowland.harvard.edu>
 <ce96291b-c0b2-41cf-a71c-c13bd8d0f139@linuxfoundation.org>
 <4478924b-fbd7-4a5a-ad0d-4fe0569b4971@linuxfoundation.org>
 <a735f877-e13b-498f-9eee-53ebefa8ebc9@rowland.harvard.edu>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <a735f877-e13b-498f-9eee-53ebefa8ebc9@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/10/25 08:06, Alan Stern wrote:
> On Wed, Jul 09, 2025 at 03:57:35PM -0600, Shuah Khan wrote:
>> On 7/9/25 15:49, Shuah Khan wrote:
>>> Right. We have a few too many moving pieces here:
>>>
>>> usbipd (user-space)
>>> vhci_hcd and the usb devices it creates
>>>
>>> usbip_host, stub driver that proxies between the device
>>> on the server and vhci_client.
>>>
>>> PM can be complex and it has to do lot more than it currently
>>> does on both server and client end to support seamlessly.
>>>
>>> The current suspend took the approach of refusing suspend
>>> which doesn't work since usb devices underneath hang in
>>> usb_dev_resume(). Looks like this usb device is treated like
>>> a real device bu usb core. Is there a way to have usb core
>>> PM (suspend and resume) handle them as virtual? Would it
>>> help to use "supports_autosuspend" to disable suspend and
>>> resume?
>>
>> Would it work if usb_disable_autosuspend() on the devices
>> that hang off its vitual bus?
> 
> You have to consider PM on both the host and client.  And you have to
> consider both runtime PM and system PM (that is, suspend to RAM,
> hibernate, etc.).

This would be as a fix for the existing suspend hang issue.

> 
> On the server, any sort of suspend will interrupt the connection.
> usb_disable_autosuspend() will prevent runtime suspends, but you
> shouldn't try to prevent system suspends.  Instead, the usbip driver on
> the server should have its suspend routine close the connection to the
> client (rather as if the server's user had unplugged the device).
> 
> On the client, you've got a choice for how to handle runtime PM.  You
> can leave it enabled, and when the client decides to suspend the device,
> tell the server's driver.  The server driver can then attempt to do a
> runtime suspend on the physical device.  (You might need to add a new
> type of message to the USBIP protocol to accomplish this; I don't know
> the details.)  Alternatively, you can forbid runtime suspend on the
> client entirely, although it would be nice if you could avoid this.
> 
> System PM on the client can be handled more less the same as runtime PM.

Correct. This has to be a complete solution that syncs up server and client
side. I am going to look into implementing this - it might be possible to
do this in user-space. Either way this will require changes to the protocol
very likely.

Greg, Zongmin Zhou, let's hold off on this conversion yo faux bus for now.
I will spend time looking at if we can find PM solution that works end to end
for server and client.

thanks,
-- Shuah

