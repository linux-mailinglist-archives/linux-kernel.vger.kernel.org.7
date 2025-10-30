Return-Path: <linux-kernel+bounces-878559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D93C20FFA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FD78464DF9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF403644BA;
	Thu, 30 Oct 2025 15:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HyQizJPZ"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A62427F00A
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761838984; cv=none; b=aqj+7wlnqwpKKEyEh9uh0YQGt/zxDS/7EZs9nbomaYyKemgNOsXYxvVvayRV69RafxWmGpy8VtXuNfHRg2582k6o5NyQDO+QYPTlt3h0M3jmoy4qElt/bBz21uN00QCLxIGTBjs+j72isdPydX4AnEaXVKgrVSqDK9Az4uv9jE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761838984; c=relaxed/simple;
	bh=qC3s8XREnWRqMlgKoDD7Aq9zNtoosSe+vXYCx7xDCLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hHleqEqvngNYe1/JPRxYu/xj3kGZCFz9jBvr8LzMEovQopxRP04fZrha4CfuswqTz0LdMubIMxjTCdtd1U3qLdqO8wpu7uenSCkss5UP6F6VT3fPTcSnNmY56AeH+z0AeDaYY0FbQZV9hw+gjeB/bjPh9QzeGKS8xPgkdw/jsSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HyQizJPZ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b3c2c748bc8so163217766b.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761838981; x=1762443781; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=F+5y8ea2hdjQjluEwp6AnorWU3zmqzKVGel4bStT298=;
        b=HyQizJPZYfjRmyPuAF7l1dCe6nTNNZYllwKo4kfkwNwLaEKQRt9+DezgcJ6+3N2eyt
         bBJnsiEnGb/407Mc3Ya85KndpIoYObd8qlvHowmuSbBp2fUmUSZ/wEnlOFAs3m2w6nsD
         ztppmA6IkUsCB/1560J3ITY/K1OsdS+YNp9k1cYYA1f1ho9HyzXiono9QUkDobjfYNVD
         B5JU1c5i2Mi8mH9hibLJfGVyMGNI8eY4gmSMjs1NcSRJU5BOiTjVQ1ZlawIPHiIreoaU
         b+uY9GO5ttN2c0POso3sv4CT9AFnfHzVcd/dOYkbhNJbm/NQDmmirY/fg5QfP6JVVF9P
         KU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761838981; x=1762443781;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F+5y8ea2hdjQjluEwp6AnorWU3zmqzKVGel4bStT298=;
        b=b1U6K/OlnsxHn2SwsVe9Ba3w4DzPoPjj3XU8Ot0h/FDV0fVlC0FvF3E3Atm6by1ueZ
         EAPYmES1UTQ7qjN0nqm5ZjQich7FVJhMMYANznMG89+KBOIDlWhMQF7otxGF+AbJvZXA
         GJCvOmsHIo9sdPE4O99xa5+fR39uhejZnnogjnAssmBDV2zq3A39geThR/3uzRI4Gtz+
         FGk6/2vK6ZjTY/OAOJ9T+9sclvZPJH6tUh/vbkVD481RWyx4VHIJi+2cy1U5h7/1qhb8
         8XOOWX9Lum0ybJmkYZAADPwrPSNzWbXibKnUEOJwmb5gJb9CZgUk2BQMFRXQ3q+o9OHd
         mcEA==
X-Forwarded-Encrypted: i=1; AJvYcCWFl4zktC1LKgoOGgsqSRCYGC/DMrmv0KRsdzj7HOO5hMzOxswUbrXLAdVx9mFzwfnLKka8x3w9Em7XXVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyzvVy+2M/FhEzRXhxpNQxD8ufyESn0n0vHemRKMHroRXvonbt
	mhflzbmTs9OG7oljbLWzWotrqAAQ0xqJADJ3fGUHsRglDx+7O9v2AT8k0myVTRwwbos=
X-Gm-Gg: ASbGnctw00uqJjVl3esT4tQP/mYpJhvchteyihGPGux/ON4ut/PhnZkLAbFrTzLXruL
	19/L3bWBCQElwHHkEt2URky268FzHA+XzbAY9sfM8ltxHy3O+IBnZ1c99a9fCZvmsfsEpwoidWa
	T1xN39nXI36Jvb4nzh/YJobDDBL+1T/VmT06zc1vLcqDCTZuo9AlWDQgsDayBkEy7VT36rXAQ94
	S1sOwDb1IrdIYdoofYqDmgg2x6a4kV1/ZGUaUAbq5dzCM+3NlYDzLBSdz+2Kpx+eyonEIe8BatK
	vFyCXCzouyOb4/ucvnvX+HdUET3BC7qFYrAAJwr8U1Hq2BP2RiBsZsSSM3pKW5scUYaGHuxL6lw
	9ThbF2XNyPu5VzOq5yvzW5l6Lbpp370sch1ap9xCGZI2uXL08IKC2jPD17hCkDCVKukpjWDrjsO
	uxXLc=
X-Google-Smtp-Source: AGHT+IEXf5gVHLIYGASKNgPqu+WqBQam7vsZp8bAAOJZpTyZZXvjde6+7yIGwtTg6c1cuODsMY58og==
X-Received: by 2002:a17:906:c113:b0:b6d:80e7:3740 with SMTP id a640c23a62f3a-b703d32670cmr787296966b.16.1761838980764;
        Thu, 30 Oct 2025 08:43:00 -0700 (PDT)
Received: from [192.168.0.20] ([212.21.159.27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85398439sm1791002866b.36.2025.10.30.08.42.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 08:43:00 -0700 (PDT)
Message-ID: <2ae957fc-b686-4662-9e10-6dca1f10c749@suse.com>
Date: Thu, 30 Oct 2025 17:42:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 34/56] x86/alternative: Save old bytes for
 alternatives
To: "Kaplan, David" <David.Kaplan@amd.com>,
 David Laight <david.laight.linux@gmail.com>
Cc: Juergen Gross <jgross@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
 Alexander Graf <graf@amazon.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Vlastimil Babka <vbabka@suse.cz>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-35-david.kaplan@amd.com>
 <d897be07-ed59-4538-aceb-53c6512aeccf@suse.com>
 <LV3PR12MB9265295ABF26898CA59B86D594E8A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <754ee3ec-8819-47df-8251-dec2906a020b@suse.com>
 <LV3PR12MB9265E559972E1C6693AAE7E794FCA@LV3PR12MB9265.namprd12.prod.outlook.com>
 <5f1fa90d-5c84-43e6-a99e-ef4a215b5055@suse.com>
 <LV3PR12MB9265295E1470ED9C5BE9EF9094FAA@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20251029221416.5b33e1fe@pumpkin>
 <LV3PR12MB92650036427F97D5F2413BC694FBA@LV3PR12MB9265.namprd12.prod.outlook.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <LV3PR12MB92650036427F97D5F2413BC694FBA@LV3PR12MB9265.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/30/25 16:39, Kaplan, David wrote:
<snip>

>>
> 
> Yes, there is an 8B pointer to each allocation (although I didn't include that in the number above).
> 
> There's a number of ways to optimize this, doing a single 'big buffer' with perhaps a 32-bit index seems rather straightforward.  And maybe there are then further ways to squeeze this.  But I think we're really talking about a small amount of memory, especially compared to the other overhead noted above.
> 


I spoke with Vlastimil who's a lot more familiar with MM and he said 
that allocations made early in the boot are likely to fall within the 
same 2mb block so actually what we are discussing here might very well 
fall within  "premature optimisation" land.



> Thanks
> --David Kaplan


