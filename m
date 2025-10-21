Return-Path: <linux-kernel+bounces-862376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F02CEBF51AA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D3BF63520DA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7B3287246;
	Tue, 21 Oct 2025 07:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fr985TNJ"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CD427F74B
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761033334; cv=none; b=apKWWyX68zOZI+CZ+C6IlK7JgeSIQTf93ho812AlxcNtz5CPHM47uVD78P1om0xVylC2rTqJ3LJdG4HRpo7BsT6qOuhp1+gF7fqGKoY+gz2p9/7yK4TpnO0hcS96lMF9debXB/61rAhG/Vyoqt1MHnVak+qpmYHGMrp2SHNsnE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761033334; c=relaxed/simple;
	bh=CGRUDgLWjS0TmZAu53/lKB2uFT14B1wVJwssuRZuUZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iL2+7B/tOlNyQ7hLqPVvftC3XtTZoFyst6dTlHwO/IepV/J4zEAMjAlHC57GXwDXtCwX0F4FgJ97eE/Wl7OaayOlzpO6JVZLVC2YPxCnTQNMI8fEFdrPGh9j7/1hb507WjD69ficqozGP/Yf+dRYTqU4mD05vaem4rcA/KFdaZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fr985TNJ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-63bbcab353dso886546a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 00:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761033331; x=1761638131; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UDT2YCTKVhWQzLZXmbHmhx5CBJhVxoIzObMnL9LgsZQ=;
        b=fr985TNJo/21m/y2HwxHMgrw2pkYgFnra6vJdridZlw4bTt7f1z27ZkSrG+m1HBnJI
         UGgMaIGtP5SSyK3Aaf1kdxjcK1HP40ObIfbyZap+CCm8r8NKYji3iVH/8frOxKHHnVhl
         FKmnWh5xYcn19+6H+DUEyL9suMSygF2pMDT0Zb/jkGYPoYyN14acZraAFHNq9xDFItsS
         E1ZWVFzZmetG694DsIIN3wCGTeWX4kWeJrPDeLB/ipnrs5cSJ9suaPsAN+GVYGdRFvCy
         HMZOpeIYG9oqPsGl1rEpgc6IH/4lrKVbVHkYpPDy7SvUKPpjU7qZ/vxMJ0uadblcasoF
         /iwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761033331; x=1761638131;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UDT2YCTKVhWQzLZXmbHmhx5CBJhVxoIzObMnL9LgsZQ=;
        b=X0qKI6ubuXah0qWaBCmwxpPleXRonf+d1s4//oQ2TzfGx2kJy5HbDJ6uWsv/xQiaZo
         buCAbiKO7wcobKFO8swdICN/h8VyN0jfe1i5RVkZpWM593mB7TGq1oIG+DHOQ6M9cNnk
         cg6TGFmIiAI/C8xJFh48zEixSAB/8zcFTOKaVVyZvcUZ3+Yqxahp1DBoFIyngFS0fxk2
         jsqdSadLlyjW6lEteEik14BOzxi0Rg3i4l77AgSN9JynzFiXewxK7S8vORqGAg+TCx2V
         9MGEUvKYCYtKEXUAB8NxGPesgQSIkiqi4SK98VMnNLXvoNwSRlBA/7d8g/x8DfSyR5D4
         zzFw==
X-Forwarded-Encrypted: i=1; AJvYcCUBI9tb6g3lHrBJTl93ul59yGcgxvpS5TSEIz9+NPMRZMv4v5fSBxNqze4bzbBZBMIytUZgi73/nWry5ts=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWaGWGJ0B3vRtvW024jLuSvD6hB59dIs9esgkPWRdcS8RQ5KWq
	5rcWPgLA6LLRPm1gFBGB+lTIGJ0vkdDS7URrQSFrCWriBz8XVsuCf0Y5
X-Gm-Gg: ASbGncs8IW/cBcVQYWQ4KmKj8B/0uSSoqzcpQ7dEmW8qtMmjySU8bSn7AW5qAB/jXu4
	7lzXTf7g8tecDsRZt8CsMN4cLeAtp4Z4SReFDBd6ihY+mvVt704JwgZOnWrknKsMpE4O17EkdEb
	Umcb4VIgYAMIECS1Qz06/2+7KNfoqaKPWBJNSMv64o1Z0RhSkOvHd+VZ+Gwp/D9J6fNOGDDnirz
	5ZV+jejnVKKPynuVkpExz8smV0eDAJ2ddNDQGB5eiZblPDfMAT+T1R7+YMQidGHV9ftGXtTglVq
	rNdLR67FmP0TqgNCAWfMsfZQuU401e2XHvAeuJmS+6X91BZWEs5liqPzbT9g0wMQowMvfmnXpD+
	d7Xpe0zGYdfY5ARHMy7IVlprDfaBYkcScuEt4HceR2gBo+nM8IlYoaVfrSM1eJGsEEb5GlDhJp6
	wnAPJB5d5jbwoazZbK8A==
X-Google-Smtp-Source: AGHT+IFXWmYLO1Aa5Kw3gLn2Us5/ulNstPgt+twYj6ayh+e2XP/zbYFG3ArVGNoGv4PQDRU/BmkoIg==
X-Received: by 2002:a05:6402:1d4f:b0:634:4e0:8377 with SMTP id 4fb4d7f45d1cf-63d16aedfe1mr1304424a12.2.1761033331200;
        Tue, 21 Oct 2025 00:55:31 -0700 (PDT)
Received: from [192.168.1.105] ([165.50.73.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c4945f1ffsm8869668a12.31.2025.10.21.00.55.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 00:55:30 -0700 (PDT)
Message-ID: <71bb9475-07ba-48a9-9fa4-76e18a310b3a@gmail.com>
Date: Tue, 21 Oct 2025 09:55:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/solomon: Use kmalloc_array() instead of kmalloc()
To: Javier Martinez Canillas <javierm@redhat.com>,
 Shuah Khan <skhan@linuxfoundation.org>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 david.hunter.linux@gmail.com, khalid@kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <20251019145927.167544-1-mehdi.benhadjkhelifa@gmail.com>
 <2541f99c-1081-4253-ae58-97654694cd78@linuxfoundation.org>
 <e4f0290b-5d15-472f-acee-e1e1b0629ec0@gmail.com>
 <3f523293-8a8d-4136-b4bc-4ad0d4a50c59@linuxfoundation.org>
 <8dc12a18-58ee-4df6-a9f3-12d8c05a0954@gmail.com>
 <878qh4ae1i.fsf@ocarina.mail-host-address-is-not-set>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <878qh4ae1i.fsf@ocarina.mail-host-address-is-not-set>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/25 8:51 AM, Javier Martinez Canillas wrote:
> Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com> writes:
> 
> Hello Mehdi,
> 
>> On 10/20/25 9:56 PM, Shuah Khan wrote:
> 
> [...]
> 
>>>> I have a raspberrypi zero 2 wh that i'm using in combination with the
>>>> ssd1306 OLED panel via I2C to test it's rendering and it's working
>>>> properly by using modetest and seeing no regressions or warnings in
>>>> dmesg.
>>>>
>>>
>>> Send v2 with all these details and why this change is needed
>>> in the first place.
>>>
>> Okay, I will do that as soon as possible.> When and how does this
>> potential problem trigger? Is this a
>>> theoretical or does this happen in this code path and how?
>>> Next time include all of these details people understand the
>>> problem better.
>>>
>> We'll do in the next iteration.Thanks
>>
> 
> A similar patch was posted by another developer a couple of weeks
> ago and is now queued already in the drm-misc-next branch:
> 
> https://cgit.freedesktop.org/drm/drm-misc/commit/?id=940dd88c5f5bdb1f3e19873a856a677ebada63a9
> 
Hello javier,

Thanks for the heads up. I will abort working on the patch.

Best Regards,
Mehdi Ben Hadj Khelifa

