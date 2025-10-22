Return-Path: <linux-kernel+bounces-864620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA61BFB31C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC458567420
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED043054C8;
	Wed, 22 Oct 2025 09:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dRePhIDS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAB8298CA2
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761125954; cv=none; b=VEVrpnXnZeTmZoigz4xBgoDYfNElmdW9u4I9jVkfeU9gx7pkDsStuZXP3M1Zppc5mNGi5E+Wfs1EmsifoxyKGvPetT1DF6O6tVbBknOtju9c2RqlyaVJ1q5FgiT9smmTB4RIsPpG023dhsiNJjzengYMBNBmMdZY9Twes5sS+QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761125954; c=relaxed/simple;
	bh=UZ0OPkGP8yNVJlDHumkQcuasIKQr+bwGLQCUf7u5PAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W6lpfvN4p+aIvrPLzU+Y0OJCbsuIatqEDvVVEnmfO16w0+xixWjm0lTgPKCBDu6EKJKsPLNzK+LU0+rYba8izEAX6hE7aS0HdRKTMyGf0hotZcMtlAyqNcHXbHGVX+kJGHmMwvCxN7ur/zrJz9kumuZ7RkO/g2PhUt6abXs9ouk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dRePhIDS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761125952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MuYmiOLCaPZRj40EIc99HdJ/xOeorodHm2jhiotawYQ=;
	b=dRePhIDSGb6E4K2W29vvLfCsyocAp1bR7KN6/ImCMY6UL7BN85ooRJj8hk8mQshxJkgiIX
	P2MrB2ygvLJUlAaotbfB/S4CjR10EWiAAOOE46CFkXkf1bpJw38OKQRn4d4PX8CFXRckUQ
	uKkMjSapvX93m6X1aHXXp+95QpzL1fs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-4xzLA-JKNsWVaPfQQtQ2EQ-1; Wed, 22 Oct 2025 05:39:10 -0400
X-MC-Unique: 4xzLA-JKNsWVaPfQQtQ2EQ-1
X-Mimecast-MFC-AGG-ID: 4xzLA-JKNsWVaPfQQtQ2EQ_1761125949
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-426ff59a320so7944804f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:39:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761125949; x=1761730749;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MuYmiOLCaPZRj40EIc99HdJ/xOeorodHm2jhiotawYQ=;
        b=OoZUCwJXk8z03H/hYVG5t9zGwMjJoT3R7UCjL98iTYlUsuAixcrPQLhHntOg5+gHhR
         gw+iYQUcmE3kNTlTIiJA3R0zzJqnpi0vbsnIqUrQoY12loymCuUGKTqdGFByEPqxKT9a
         ERW1w6Ptes5rXVZ+zojQYZWmpFR/vghyF3tM5MyUVyF7E/TZCi5i5CWQ6TTsuHhXBPjB
         ZloyKn3PiG+rWsxcCh6wZbT/bvi+mSh6gHCknO+zeR+9XSz6KEbvas0GExGiqJbfw7VU
         SFAdmKBfAuU6OiN6NfX/DtRqPyNnwVawj0QzF5DioOdqUYvWpCmJU2spx429hHLgXWkB
         TaUQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9Z23V2Ds0bJdQ9OEN8bEo9qlwyn5euf2ysnA2kogJtuZmvXn+moFy90dImJrN9IAu2mRH2NSNtd0Bodk=@vger.kernel.org
X-Gm-Message-State: AOJu0YycjaYoJcpsb7324lZZlxV9NqZNe8roOJ+U90/6DxBNmaIXOGck
	k+ptBnOwDW9VW5jMYzGLE1Om+s628mk7xmamt9wH05Ph23fo5Fie+46ajN7jRvQrXJyFCL2eptB
	ZoMY4LEFT67rTBpUGaNp31PC96CDtVEPxc3smBNqToyZkTMe4SQRaKTm2PJjygZKDTA==
X-Gm-Gg: ASbGncuNzDQYlhn9CGP7MDz9/J5fRslbtiw6jbfXbBZwrZqcrR9E6yjgW1ORAKVb2Ro
	ysnyw1JMr1DgFyatDlnuj/B9sVOdcl6HADD7C5O1D8Xj6k9WF7dzPs1xlXWdKbw6VvS8Tl262Q2
	tNMZPSXO1iC0ErdjVdUXIFf2LR0cctKrfJON0KNzn7J5LF6xARxqn+I2Hp6E1oRkSnwPXS9BvOP
	oKF5RQtF1kvey4eUD6m9LqxCIWY/1ZuTbIJ1tf6AMOKZ+vQkNdubba6wQaokDATYvIKGqXb7wUP
	MpO7542msdLXAOSlV7k4JH18MRzMToPKauodRjLBBujsZeB5HyCFI53N4Ie7G6qa7n8HTWAfzQA
	clN9GOvl2oPhgPQJ7cMidReOCaUAF8Onh79Qc
X-Received: by 2002:a05:6000:2911:b0:3e7:46bf:f89d with SMTP id ffacd0b85a97d-42704db22camr15953038f8f.44.1761125949400;
        Wed, 22 Oct 2025 02:39:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/aOryQn5sy8rYEtqe6i7g3LA3GyVmEJjSxmfNQPD4o765qZMFTbY8a7U8TNz9fPJlo12+lA==
X-Received: by 2002:a05:6000:2911:b0:3e7:46bf:f89d with SMTP id ffacd0b85a97d-42704db22camr15953008f8f.44.1761125948937;
        Wed, 22 Oct 2025 02:39:08 -0700 (PDT)
Received: from [192.168.68.125] (bzq-79-177-149-47.red.bezeqint.net. [79.177.149.47])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5a1505sm24495428f8f.8.2025.10.22.02.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 02:39:08 -0700 (PDT)
Message-ID: <075914db-d497-4428-97e2-256b35f40729@redhat.com>
Date: Wed, 22 Oct 2025 12:39:05 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 02/14] i40e: support generic devlink param
 "max_mac_per_vf"
To: Jakub Kicinski <kuba@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Rafal Romanowski <rafal.romanowski@intel.com>
References: <20251016-jk-iwl-next-2025-10-15-v2-0-ff3a390d9fc6@intel.com>
 <20251016-jk-iwl-next-2025-10-15-v2-2-ff3a390d9fc6@intel.com>
 <20251020182515.457ad11c@kernel.org>
 <d39fc2bd-56bf-4c5b-99a2-398433238220@intel.com>
 <20251021160745.7ff31970@kernel.org>
Content-Language: en-US
From: mohammad heib <mheib@redhat.com>
In-Reply-To: <20251021160745.7ff31970@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Thank you for the review.

As Jacob Keller mentioned, this change enforces that a VF can never go 
above the maximum allowed value. However, there could still be other 
hardware-related restrictions.

Regarding the scenario you described, if the maximum is decreased to 2 
after VF1 has already added 4 filters, then the next time the user tries 
to add a new MAC address to VF1 (or to any VF that already has 2 or more 
MAC filters), they will see an error message in the kernel log:
  "Cannot add more MAC addresses: VF reached its maximum allowed limit 2"

I didn’t really consider the decreasing scenario, since this change is 
intended to be configured by the system administrator once, before 
setting up the VFs. If for some reason they decide to reduce the limit 
during the VF’s lifetime, I believe it’s the user’s responsibility to 
first remove the old MAC addresses and filters from the VF.


On 10/22/25 2:07 AM, Jakub Kicinski wrote:
> On Tue, 21 Oct 2025 13:39:27 -0700 Jacob Keller wrote:
>> On 10/20/2025 6:25 PM, Jakub Kicinski wrote:
>>> On Thu, 16 Oct 2025 23:08:31 -0700 Jacob Keller wrote:
>>>> - The configured value is a theoretical maximum. Hardware limits may
>>>>    still prevent additional MAC addresses from being added, even if the
>>>>    parameter allows it.
>>>
>>> Is "administrative policy" better than "theoretical max" ?
>>
>> That could be a bit more accurate.
>>
>>> Also -- should we be scanning the existing state to check if some VM
>>> hasn't violated the new setting and error or at least return a extack
>>> to the user to warn that the policy is not currently adhered to?
>>
>> My understanding here is that this enforces the VF to never go *above*
>> this value, but its possible some other hardware restriction (i.e. out
>> of filters) could prevent a VF from adding more filters even if the
>> value is set higher.
>>
>> Basically, this sets the maximum allowed number of filters, but doesn't
>> guarantee that many filters are actually available, at least on X710
>> where filters are a shared resource and we do not have a good mechanism
>> to coordinate across PFs to confirm how many have been made available or
>> reserved already. (Until firmware rejects adding a filter because
>> resources are capped)
>>
>> Thus, I don't think we need to scan to check anything here. VFs should
>> be unable to exceed this limit, and thats checked on filter add.
> 
> Sorry, just to be clear -- this comment is independent on the comment
> about "policy" vs "theoretical".
> 
> What if:
>   - max is set to 4
>   - VF 1 adds 4 filters
>   - (some time later) user asks to decrease max to 2
> 
> The devlink param is CMODE_RUNTIME so I'm assuming it can be tweaked
> at any point in time.
> 
> We probably don't want to prevent lowering the max as admin has no way
> to flush the filters. Either we don't let the knob be turned when SRIOV
> is enabled or we should warn if some VF has more filters than the new
> max?
> 


