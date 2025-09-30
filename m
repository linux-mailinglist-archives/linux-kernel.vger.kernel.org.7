Return-Path: <linux-kernel+bounces-837803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0520FBAD38F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73F991940AA7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374932727F8;
	Tue, 30 Sep 2025 14:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4G6i1Y2"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F3F3054DB
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759243200; cv=none; b=eru/tuY50XQejizsSblSbrdnNEXTd5IYiEKJEI7I/Z6rQNqEp4B77X4pRXb2uLUp43J6tZAcLnZvYdBLSH+8o9q90keg8u0Sl7p/iUsOTaJoQW/x2KlXKjXePbMHsEqk6l2pBSu/pkW1FHpw7XGbEljkHTaF7YfwFYGWpAOZwP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759243200; c=relaxed/simple;
	bh=jsVrDiO7WCcp9VuvmVqhb+yojB8EHih7vcl6a4qUo24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nP9NUaxqhSK9x3jpH7/UcC398nPiMqF4rZpxZoope2iLtgVNUwGAYkr8Mgz2g92zcMCES84Rjg7vFRnrKD713T10l4QMpRwuKZgk0PiyYFk4eGN/DGb56fifelDnhNkywzzY2neW7nR7IlBwbgmnqSRjwLgBacJM94qCIHlllgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4G6i1Y2; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7800ff158d5so3955716b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759243198; x=1759847998; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=D6Ghftnwj+NaC3a9sRXMvFD5tjT5PwN7VnTzNH98qws=;
        b=e4G6i1Y2sGvesE0O1KOLMH5eDIj0N/E6A9ErwyohYNbNQYRFBGN6mHYffYYl8hfQBV
         5P4KUxMc9c/oOVFwMtEEKBgWevoTkD0vkcV74u7RykQiPAJkhv9wWZ06thLJm5JFsgpt
         NBQCiSy7eGKekT5DE65X0eHlDi1wwPVU8mLAi/Ri9OI2+OEm63G55Cc6xaDK6nN6aGFG
         qHTCtxgmj29Y3EwikDlef2M3L/7NxpWGzlzEGxuogyJToIkUWgLhMZvkOUC7T/us8hcP
         QSGO/IVcCwUGZCcu7X9L9F3+jZpk+Zf4heIezkVo2mBTvKO/G2naJwn/eccZ5G2AaQlo
         JExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759243198; x=1759847998;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6Ghftnwj+NaC3a9sRXMvFD5tjT5PwN7VnTzNH98qws=;
        b=Al8fHO0qG5tXpuuhlOiZF217NjHoziYegZeb872KNqS2YbhPee3Ds66j/9kk7Yvi2d
         xw80o2mxxL+DrBiH9ezZK2LYb2UzOpwVhxvnEqJWJ/5bDl26FFy6PhIWPmKpqNfAaor9
         Am53mfxIIk6cq9eqK4PVLAM8UxZefSA/cRLQojnovKT0oNiJ1LsUrJOc+syfs4wrX2Eu
         iU5dy1xpv/nE//Epbr+A8W1boJIZE5yvrRvHU6LqTy/5oQa39DiBWFY0NNCI1CrnP+9A
         OKxmdGEGxyjO01JAMYIKGF2HuSvGAVGH2KurnuxIYLrQzzED/CEuDFsOZFm5YY3vR2DG
         MkXg==
X-Forwarded-Encrypted: i=1; AJvYcCWfRwEqa9XZirdWNWtMuyhazgCVXxPP+ZEtvTC1AaGQJtGKiSG+CJgy+mfotzcR39digUnS+RDNtKqW5WY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDziQ2zjrcL1wKJrIJSbEtlAZFg2vpBkz8dT3Cz8sseCcrjXoS
	Rhpgf3AHofehUCKVtMYJT2SsXg1Z389C5uIcX4zX6ZSgkl5FqAvKADJH
X-Gm-Gg: ASbGncshGqAXf2SZcDJCzzSOvabQg7lO5m3L22GSg3MuE34nboXCJX+dbALBMNZHEw5
	oPu8UoUyJwc04VBXgBqwo3w7SSqYnoFJYBi0Qub1DaqYi8uaNpuD4SIHqBIwEtRRvd4Crw6rNe0
	ewalQG0nhx5IGg78OhrdPGw//PBLkhel92G82BEguNFbXcrHSP7yN5/fTAJg7Ip+HCIYCW7vuA9
	Uw6xvWxodJFhEBHrxi7PlPtQYq8KAeLlaj833GDWuDsdJme8dF0KO6cH4xnNGXIJX36LIep03q4
	pbEgOB/yptt7MNpv6l1mYVZbTZu3OSWAcS6NTJysyf/KVaUPMTWZz8sRFrxSma4HhEJXKf4PA8g
	hj7hWDs2t81GizAx76bJqOOzPnL5oSYP/CGEFAeMs6wjJN2dxU1+VfHf8DB/kEHuO3a1WvHnUJu
	YLAYjeum/XHtayu4oEFf2NnEnnFL9p9g==
X-Google-Smtp-Source: AGHT+IExSfEkzVaMbV+FOgP+NzxTfw/rdIofSI61Zlupzj6rvjRAxJximmaZ9/psf15TWbTBKn1hCw==
X-Received: by 2002:a05:6a00:18a7:b0:781:2069:1eea with SMTP id d2e1a72fcca58-7812069208emr18132877b3a.24.1759243197825;
        Tue, 30 Sep 2025 07:39:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c06e5csm13917492b3a.76.2025.09.30.07.39.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 07:39:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <cfde5583-fcc1-4c08-9893-5a09a148b475@roeck-us.net>
Date: Tue, 30 Sep 2025 07:39:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] mtd: spi-nor: macronix: Drop the redundant flash
 info fields
To: Pratyush Yadav <pratyush@kernel.org>,
 Cheng Ming Lin <linchengming884@gmail.com>
Cc: Michael Walle <mwalle@kernel.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>, miquel.raynal@bootlin.com,
 richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, alvinzhou@mxic.com.tw, leoyu@mxic.com.tw,
 Maarten Zanders <maarten@zanders.be>
References: <20250407075400.1113177-1-linchengming884@gmail.com>
 <20250407075400.1113177-2-linchengming884@gmail.com>
 <d98f6eee-d5f7-43b7-bbc8-d6e7e274723a@roeck-us.net>
 <mafs05xh6pf7s.fsf@kernel.org>
 <da58fc81-3c99-4951-85bc-e3c139283b5a@roeck-us.net>
 <a2a0c40e-69d7-4408-add2-88616c92b0ca@roeck-us.net>
 <aa2a4480-9b78-4ed9-8f9d-b18a87eb01e9@linaro.org>
 <CAAyq3SYybDgBvkTKh2ZB4UdKq1XV_nnzx3Tj1P915W5x_7_nNA@mail.gmail.com>
 <DD10QMSJVZ2K.26U45JAXV5EY7@kernel.org>
 <CAAyq3SYyqi-oR8T039Zd0uaF6UieX3SdF9UF2kxOG6+yJqAEUg@mail.gmail.com>
 <mafs01pnoceum.fsf@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <mafs01pnoceum.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/30/25 05:19, Pratyush Yadav wrote:
> On Tue, Sep 30 2025, Cheng Ming Lin wrote:
> 
>> Hi Michael,
>>
>> Michael Walle <mwalle@kernel.org> 於 2025年9月24日 週三 下午8:11寫道：
>>>
>>>> The root cause of this problem lies in the failure of parsing the SFDP
>>>> data for the flash, rather than an issue with the patch itself. I believe
>>>> we should not revert this patch.
>>>
>>> I disagree. There are Macronix flashes with that ID which doesn't
>>> have SFDP.  And this patch is dropping support for them. See also
>>> [1]. Now I'm not sure it is worth reverting this commit. Nobody,
>>> except Guenter complained, but only *so far* (and that patch is in
>>> since 6.16). Any opinions?
> 
> When I read this I was just hoping no one complains and we end up just
> dropping support for these flashes that no one seems to use...
> 
>>
>> I agree with reverting this patch. When I initially verified it, the
>> devices I had on hand all supported SFDP, so I did not catch this issue.
>> After checking again, I confirm that some older flashes without SFDP are
>> indeed affected.
> 
> Do you know if these flashes are used in any devices that are actively
> used and maintained? If so, we should revert. If it is likely they
> aren't actively used, then maybe we just keep things as they are?
> Dunno...
> 

qemu emulates the chips, meaning the qemu emulations using them no longer work.
This is how I found the problem.

I carry a downstream qemu change to instantiate different flash types on the
affected boards, so this is no longer a problem for me. In case anyone wonders
if/why I didn't submit that into qemu - I did. It was was rejected.

Guenter

>>
>> Would it make sense to only change the `.name` field to use a comment,
>> while keeping the rest as is? That way we can still support flashes that
>> may not provide SFDP.
> 
> Sure, that would be a good improvement over a plain revert. Maybe as a
> follow up patch to the revert?
> 


