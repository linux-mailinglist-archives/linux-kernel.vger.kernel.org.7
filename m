Return-Path: <linux-kernel+bounces-844844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE26BC2E60
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 00:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C4433C80B3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 22:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5B82566E2;
	Tue,  7 Oct 2025 22:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjgncizV"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD44924679F
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 22:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759877572; cv=none; b=j1JnVL7X1umnl5YZLjccZqqczjvURXJWfmaTj9SN8Y6MDU5GFHJqZ4XUlRUVxV6XmqGU/VK53DmAaw0i3Lj5QCf6Hc3pP3XxKMXxdbHCt2EctJhudeCT6ICxiyA+xoGT29IATxU2DVDyg7EmWGUhNCmcgX0R4j1zupGPZlNN7WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759877572; c=relaxed/simple;
	bh=qxgVnmWqC+KwtESvQbS74fVT/0Bn4M3+cV3DjGpZfWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZWYHHgJzPgwm8UMvJFN/kV7eikVTNWNlPlYdaPfqHBpdvY94rlljZUElAhAVDnx0TrXaLt7D4KBoXSN2Ww+23G8dSP/cMXv5lo/nAq8+M6FdO6E1ki2fWGpoLvp+qkhrHCpSCoCrU3EDJdIhR7UNM+GZfFbFHJiVlz+txBEpSjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjgncizV; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42421b1514fso3220438f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 15:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759877569; x=1760482369; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0RpARBk/VGx2IT+Z6HHZn2PJGTtFCDMF9v41q9D1XPY=;
        b=HjgncizVmla7zaf4M8RZZsfInoAM/m9lrPoZDo89mavUFUsLT+qvtuO+KPdBLTMKwT
         r1SD9WHmir9luicoAjdWMCkXNg4BycwDKyUaLpgLUd+3QJzVGj+GpVAUgPo1WZ0gwpKh
         j0DrRMMnO6kv78m4iqx7duk270LnROWRuFgOBlZ+e7nOlc+A9wf6d0MhdWNoYHN4H7vp
         IZTP4inYGGMU07HxGl75SjGDJotQzca9Yp3NZGsNBtJWhWdZYvYTWWbFD3w44GwD5g2i
         tqRQg81rVYYD9M1qpPqYtvM2yo+iEpjAf2foL/6AfIlu0zeBmu3VPsJLwMua0hcmWgbO
         E94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759877569; x=1760482369;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0RpARBk/VGx2IT+Z6HHZn2PJGTtFCDMF9v41q9D1XPY=;
        b=OtbpeT1x4+QlIePzt3AwkI8QwExr9b+neo24+s2JxaMkhLL9xLmnkg359ofVWM64do
         +pnwnIVUhEPc52DGZ2Kwojil6lrviQ70RiJpCtAi9IygfKamK8TAEvJc4o3nOu5qdKo8
         L81BUQLM1W1O+43qUeGlSftrQKmlpsHmppzB3NEAaOOnT5OFeEPhyDn8z2YAfI+MGuDd
         FAs/l+AFWxUKlB1i4u+fucGXTx4cDKp1uO4hx2q2zjfOpQL0U0HRe5k5eX7Xcbuw56Ub
         uE81gDr611la7KLgvpsMEfI49WWKlueB85xbKP4DAqZDEnyxyDiTKCHtHUOQtr6/qOSp
         7OWA==
X-Forwarded-Encrypted: i=1; AJvYcCU5qNCGs0gp0umKjTZDCVz/YNikiQvJasHv4kzAC4SGFubARKgjtAFtuDLlddK6h+z+1Sa4AFlwm4qWejw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYhIvlFJJ1muJcxOSmH3RINbn2yJqW0+eqSCH+mBlbIOD9O5R/
	bOhNxD06Ue2UR6FW7lwXNKsrhUckpbh1KMssIBwIcwb+jO9uv/V4XbqfZ93CdQ==
X-Gm-Gg: ASbGncsLZGwIlFaShP94ZuyyXAGDMnzhbvL3aVE5Iut5ml94gzq0IosKa95Zp2smNua
	QlNAUsV1H9J6/b4AbSD236vVqyFl2j5A/8G6ddpy6H7+Z5DUia7FcSrPMI/88KMdaLKZ9v8jPHR
	dtoHLXnz8THpL151Y/8w77MRQkhyVirr6FFsN5NCXQ+nQvEwGWNHwlQbfyK1sf2Gw196DFpK5Oz
	Hn8X7tXwsF3AwzgBNFYL3iNcpbWxMJCupVfdCW44mDCfBTYZonQTx/6nMYClujjeEFOQw5WeiIf
	diZx1Nbqyvviai4HoMedabuHlPJa3A0XvhRIYXs0EhlshW2Qy1mwu7n5dpir5N9fTgbzuefrjhv
	22LMby3s3mhqCIQNE4gt0Xhq59QHdvh1QignmGVPeCO8wU2BT5Tc2U206eZGbL/kGIwQG48Tr7g
	Dt6ObTdxfvCS3ytcPW8UwOG0UAGJtN/1jsFKjUbsQIEA==
X-Google-Smtp-Source: AGHT+IEOP0KMn3yulmSLAsD1ntkNExuQaCcYwzis5uWiYSN7Izw6YtqSHSliek9+xL4bNXYcORcUkQ==
X-Received: by 2002:a5d:5887:0:b0:425:7591:7072 with SMTP id ffacd0b85a97d-4265ef60236mr527285f8f.0.1759877568861;
        Tue, 07 Oct 2025 15:52:48 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e750:1b00:1cfc:9209:4810:3ae5? ([2a02:6b6f:e750:1b00:1cfc:9209:4810:3ae5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9d6269asm10726435e9.15.2025.10.07.15.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 15:52:47 -0700 (PDT)
Message-ID: <09689e62-a8bd-4822-84ba-0f72f94fed52@gmail.com>
Date: Tue, 7 Oct 2025 23:52:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hugetlb: allow overcommitting gigantic hugepages
Content-Language: en-GB
To: Andrew Morton <akpm@linux-foundation.org>
Cc: muchun.song@linux.dev, osalvador@suse.de, david@redhat.com,
 linux-mm@kvack.org, hannes@cmpxchg.org, riel@surriel.com, kas@kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com,
 Shakeel Butt <shakeel.butt@linux.dev>
References: <20251006185607.3257340-1-usamaarif642@gmail.com>
 <20251007152429.4c28fb85205635703229b027@linux-foundation.org>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20251007152429.4c28fb85205635703229b027@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 07/10/2025 23:24, Andrew Morton wrote:
> On Mon,  6 Oct 2025 19:56:07 +0100 Usama Arif <usamaarif642@gmail.com> wrote:
> 
>> Currently, gigantic hugepages cannot use the overcommit mechanism
>> (nr_overcommit_hugepages), forcing users to permanently reserve memory via
>> nr_hugepages even when pages might not be actively used.
>>
> 
> Why did we do that?  Just an oversight?

I believe this restriction was added in 2011 [1], which was before there was support for reserving
1G hugepages at runtime. Once that was added, I think we forgot to remove this restriction.

[1] https://git.zx2c4.com/linux-rng/commit/mm/hugetlb.c?id=adbe8726dc2a3805630d517270db17e3af86e526


> 
>> -	if (hstate_is_gigantic(h))
>> +	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
> 
>> -	if (hstate_is_gigantic(h))
>> +	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
> 
>> -	if (write && hstate_is_gigantic(h))
>> +	if (write && hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
> 
> Maybe a little helper for this?
> 
> (Little helpers are nice sites for code comments!)

Will add this in the next revision, Along with a paragraph about the history
of why this restriction existed in the first place.

Thanks for the review!
Usama


