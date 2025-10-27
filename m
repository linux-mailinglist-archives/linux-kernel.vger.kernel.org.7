Return-Path: <linux-kernel+bounces-871408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0D3C0D299
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D41C1403DA9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240612FB98B;
	Mon, 27 Oct 2025 11:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IRXwgraK"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404B72FAC06
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761564875; cv=none; b=MP5WNXR+2TNTqwV6YLeZQxrCq+SQZhAUUbjT1+Fvx6Lwcn+BLwwK+pnAm2pgrLV1C+BI3THujVCDnHBUuqMPOkY3ged43tGL3g21OAXspRxj+WVJBbGsyC7/D9zMvBV7ij3Lgyoz4tASPYM63pqRTBgGyBKfBNmbh9eJ9pBjEG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761564875; c=relaxed/simple;
	bh=YTeqLExdPZq47+Pk0ggUHT4a3r1pcc+0L54VXSjBGtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qX4qzl1TKPTd4xB0rtjqfqUt9WuaAM/7CMftkmxo1EHL4EGe9tRS6SLEY8xt5OX6xEqugRFnh4OeNCPbBV8DZSMlXOxiaIyNj2/ZF522ps+Ht4mPzaRyfNc+mnpgDCkUdR5IWuKXvfK3/2m7goUQyAQ9vKp10mGJQYdVeH+2kCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IRXwgraK; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47710acf715so5231845e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 04:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761564871; x=1762169671; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1C2VZ+aguVyMj3y/gHMKgvySgctkd7TNCLz329jWwaY=;
        b=IRXwgraKxGS9IusTFroTtnqO18h8mMlXohrGDkJRLYsmFLkSjUCX+EcSNnkJ746NBv
         JYSEzaa9zLasF9gomrBTZP1k+xVYOaE2X/EWDuGZzF8l9X/43HKOHDHq5/4dqjuG5BA6
         EKquYSSl0iiayd/Twiy80dSKs6M0AYNZwbVyY5cLI5sQ9kuN5KkeoCwfRLz5KUK6vasS
         W+CuIlO8aExCC0wXgoueddp90bs3ArlRdGF/qogBTzbQGz+QRhnSeocOYSBJhasFd1ZF
         9oKH/U+dw5R6IkgzX5316mWfYsXJgGOua430QXa8uLls1vwdYhyxjyJ7TqTb8Ey0bpg8
         4nDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761564871; x=1762169671;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1C2VZ+aguVyMj3y/gHMKgvySgctkd7TNCLz329jWwaY=;
        b=Zng+4HVXOpYdGtPS3+v/wP+P7adK4EkLwpjEunnkq1s+s4QHzaCDNH3RDXvIRaHquF
         pCuV860DrkMQOxVX0jPcTh/sO/O2Fysl7c2QwSN6FSAx/CfhGSbuH1mG2UE9HM0jYqZH
         /nt6YOyQjl7QszGq0+adeLhXYY3+mZBTEJ1a7mJm82pAkTTiLwEj5JpIwAAOBT+yj/y0
         rdXeCDlqg7tDhRA+w/y4FjkLMAg2h+ZVUKgWfiOmep4M5+ifn6+h5P2WP3e6R3zJgVEe
         I90tGqku9vj6PTV5V99SgQ1Y4Jx4FXvgXKPWCjn33bqMLye1qD454WNBvNQwnu369Oih
         ZDmw==
X-Forwarded-Encrypted: i=1; AJvYcCU7pzKG2B0M8ih/Y6ORgfj+u1yWCA6TuTFlqBhbKblfAseZAjn3IbE5+kWks0TIBlC8KyY7nu8Vej0Xa5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV15qFj261UZosjrc/3dLDqpzLK/dRsTDV5Br6c4pUncOr5f9O
	2zIKD5DpwQqk+4o8ibQGFVLXw3IfSPhBbQU/gDQXS/dFOCyuxDKpTHRH3BdhvgSV28wY5TaTzVr
	zjLR2
X-Gm-Gg: ASbGncvTxfJ5lHTbPro1tsEd7Rz5MzC8D8gAS/vFogw06zWWUVsT0NnS02e4QCqlsh3
	WA96bs7EHjyDLaZeLkjV57YzSC1517aGkDNO+Q+Papg4lllHqz4wSfar1Q1o0YEh+f4ljKJcn38
	wIkv5JRN+MhpR9AnFhkjNBLYbnk4HAA+xr2EnaiV7+zPY0n/uTBBWvavP9pJqnliw9B20y6nonw
	YXGrLztKeTA7Zdnw8FjAO+Qos8o+2OFDIypxw2cvpXLoQKN126/EDGSYoiHVH2PzXJ2/IaD6v4r
	AuakkvvVZ1XtIqyhUTsCjlYiAmZtTBzaS4PcvpDfCShUtROPgngXV5FU17tn1SKstpEK5r70rob
	EEVdaqeiCxPhqiD7ZW9gsLQKzdSyCvR2VRAeLCYvqRZ7sDjTRBwjfcf6DIRZhCnrG98gmXORnAF
	WoXjer7FJF8FqPY9Zl6QG8V0+pqxQ=
X-Google-Smtp-Source: AGHT+IGY6AXsbYm++jssbQuNMr7ZsaUxdk1xycKt6CVdnC3MskK8bFE6cI4QYwa7tTae7itRv+/G7g==
X-Received: by 2002:a05:6000:200f:b0:401:5ad1:682 with SMTP id ffacd0b85a97d-42704d521e8mr28986464f8f.14.1761564871552;
        Mon, 27 Oct 2025 04:34:31 -0700 (PDT)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [109.121.142.122])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952e3201sm13899375f8f.47.2025.10.27.04.34.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 04:34:31 -0700 (PDT)
Message-ID: <754ee3ec-8819-47df-8251-dec2906a020b@suse.com>
Date: Mon, 27 Oct 2025 13:34:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 34/56] x86/alternative: Save old bytes for
 alternatives
To: "Kaplan, David" <David.Kaplan@amd.com>, Juergen Gross <jgross@suse.com>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
Cc: Alexander Graf <graf@amazon.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-35-david.kaplan@amd.com>
 <d897be07-ed59-4538-aceb-53c6512aeccf@suse.com>
 <LV3PR12MB9265295ABF26898CA59B86D594E8A@LV3PR12MB9265.namprd12.prod.outlook.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 xsFNBGcrpvIBEAD5cAR5+qu30GnmPrK9veWX5RVzzbgtkk9C/EESHy9Yz0+HWgCVRoNyRQsZ
 7DW7vE1KhioDLXjDmeu8/0A8u5nFMqv6d1Gt1lb7XzSAYw7uSWXLPEjFBtz9+fBJJLgbYU7G
 OpTKy6gRr6GaItZze+r04PGWjeyVUuHZuncTO7B2huxcwIk9tFtRX21gVSOOC96HcxSVVA7X
 N/LLM2EOL7kg4/yDWEhAdLQDChswhmdpHkp5g6ytj9TM8bNlq9I41hl/3cBEeAkxtb/eS5YR
 88LBb/2FkcGnhxkGJPNB+4Siku7K8Mk2Y6elnkOctJcDvk29DajYbQnnW4nhfelZuLNupb1O
 M0912EvzOVI0dIVgR+xtosp66bYTOpX4Xb0fylED9kYGiuEAeoQZaDQ2eICDcHPiaLzh+6cc
 pkVTB0sXkWHUsPamtPum6/PgWLE9vGI5s+FaqBaqBYDKyvtJfLK4BdZng0Uc3ijycPs3bpbQ
 bOnK9LD8TYmYaeTenoNILQ7Ut54CCEXkP446skUMKrEo/HabvkykyWqWiIE/UlAYAx9+Ckho
 TT1d2QsmsAiYYWwjU8igXBecIbC0uRtF/cTfelNGrQwbICUT6kJjcOTpQDaVyIgRSlUMrlNZ
 XPVEQ6Zq3/aENA8ObhFxE5PLJPizJH6SC89BMKF3zg6SKx0qzQARAQABzSZOaWtvbGF5IEJv
 cmlzb3YgPG5pay5ib3Jpc292QHN1c2UuY29tPsLBkQQTAQoAOxYhBDuWB8EJLBUZCPjT3SRn
 XZEnyhfsBQJnK6byAhsDBQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheAAAoJECRnXZEnyhfs
 XbIQAJxuUnelGdXbSbtovBNm+HF3LtT0XnZ0+DoR0DemUGuA1bZAlaOXGr5mvVbTgaoGUQIJ
 3Ejx3UBEG7ZSJcfJobB34w1qHEDO0pN9orGIFT9Bic3lqhawD2r85QMcWwjsZH5FhyRx7P2o
 DTuUClLMO95GuHYQngBF2rHHl8QMJPVKsR18w4IWAhALpEApxa3luyV7pAAqKllfCNt7tmed
 uKmclf/Sz6qoP75CvEtRbfAOqYgG1Uk9A62C51iAPe35neMre3WGLsdgyMj4/15jPYi+tOUX
 Tc7AAWgc95LXyPJo8069MOU73htZmgH4OYy+S7f+ArXD7h8lTLT1niff2bCPi6eiAQq6b5CJ
 Ka4/27IiZo8tm1XjLYmoBmaCovqx5y5Xt2koibIWG3ZGD2I+qRwZ0UohKRH6kKVHGcrmCv0J
 YO8yIprxgoYmA7gq21BpTqw3D4+8xujn/6LgndLKmGESM1FuY3ymXgj5983eqaxicKpT9iq8
 /a1j31tms4azR7+6Dt8H4SagfN6VbJ0luPzobrrNFxUgpjR4ZyQQ++G7oSRdwjfIh1wuCF6/
 mDUNcb6/kA0JS9otiC3omfht47yQnvod+MxFk1lTNUu3hePJUwg1vT1te3vO5oln8lkUo9BU
 knlYpQ7QA2rDEKs+YWqUstr4pDtHzwQ6mo0rqP+zzsFNBGcrpvIBEADGYTFkNVttZkt6e7yA
 LNkv3Q39zQCt8qe7qkPdlj3CqygVXfw+h7GlcT9fuc4kd7YxFys4/Wd9icj9ZatGMwffONmi
 LnUotIq2N7+xvc4Xu76wv+QJpiuGEfCDB+VdZOmOzUPlmMkcJc/EDSH4qGogIYRu72uweKEq
 VfBI43PZIGpGJ7TjS3THX5WVI2YNSmuwqxnQF/iVqDtD2N72ObkBwIf9GnrOgxEyJ/SQq2R0
 g7hd6IYk7SOKt1a8ZGCN6hXXKzmM6gHRC8fyWeTqJcK4BKSdX8PzEuYmAJjSfx4w6DoxdK5/
 9sVrNzaVgDHS0ThH/5kNkZ65KNR7K2nk45LT5Crjbg7w5/kKDY6/XiXDx7v/BOR/a+Ryo+lM
 MffN3XSnAex8cmIhNINl5Z8CAvDLUtItLcbDOv7hdXt6DSyb65CdyY8JwOt6CWno1tdjyDEG
 5ANwVPYY878IFkOJLRTJuUd5ltybaSWjKIwjYJfIXuoyzE7OL63856MC/Os8PcLfY7vYY2LB
 cvKH1qOcs+an86DWX17+dkcKD/YLrpzwvRMur5+kTgVfXcC0TAl39N4YtaCKM/3ugAaVS1Mw
 MrbyGnGqVMqlCpjnpYREzapSk8XxbO2kYRsZQd8J9ei98OSqgPf8xM7NCULd/xaZLJUydql1
 JdSREId2C15jut21aQARAQABwsF2BBgBCgAgFiEEO5YHwQksFRkI+NPdJGddkSfKF+wFAmcr
 pvICGwwACgkQJGddkSfKF+xuuxAA4F9iQc61wvAOAidktv4Rztn4QKy8TAyGN3M8zYf/A5Zx
 VcGgX4J4MhRUoPQNrzmVlrrtE2KILHxQZx5eQyPgixPXri42oG5ePEXZoLU5GFRYSPjjTYmP
 ypyTPN7uoWLfw4TxJqWCGRLsjnkwvyN3R4161Dty4Uhzqp1IkNhl3ifTDYEvbnmHaNvlvvna
 7+9jjEBDEFYDMuO/CA8UtoVQXjy5gtOhZZkEsptfwQYc+E9U99yxGofDul7xH41VdXGpIhUj
 4wjd3IbgaCiHxxj/M9eM99ybu5asvHyMo3EFPkyWxZsBlUN/riFXGspG4sT0cwOUhG2ZnExv
 XXhOGKs/y3VGhjZeCDWZ+0ZQHPCL3HUebLxW49wwLxvXU6sLNfYnTJxdqn58Aq4sBXW5Un0Q
 vfbd9VFV/bKFfvUscYk2UKPi9vgn1hY38IfmsnoS8b0uwDq75IBvup9pYFyNyPf5SutxhFfP
 JDjakbdjBoYDWVoaPbp5KAQ2VQRiR54lir/inyqGX+dwzPX/F4OHfB5RTiAFLJliCxniKFsM
 d8eHe88jWjm6/ilx4IlLl9/MdVUGjLpBi18X7ejLz3U2quYD8DBAGzCjy49wJ4Di4qQjblb2
 pTXoEyM2L6E604NbDu0VDvHg7EXh1WwmijEu28c/hEB6DwtzslLpBSsJV0s1/jE=
In-Reply-To: <LV3PR12MB9265295ABF26898CA59B86D594E8A@LV3PR12MB9265.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/15/25 16:45, Kaplan, David wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>> -----Original Message-----
>> From: Juergen Gross <jgross@suse.com>
>> Sent: Wednesday, October 15, 2025 5:38 AM
>> To: Kaplan, David <David.Kaplan@amd.com>; Thomas Gleixner
>> <tglx@linutronix.de>; Borislav Petkov <bp@alien8.de>; Peter Zijlstra
>> <peterz@infradead.org>; Josh Poimboeuf <jpoimboe@kernel.org>; Pawan Gupta
>> <pawan.kumar.gupta@linux.intel.com>; Ingo Molnar <mingo@redhat.com>; Dave
>> Hansen <dave.hansen@linux.intel.com>; x86@kernel.org; H . Peter Anvin
>> <hpa@zytor.com>
>> Cc: Alexander Graf <graf@amazon.com>; Boris Ostrovsky
>> <boris.ostrovsky@oracle.com>; linux-kernel@vger.kernel.org
>> Subject: Re: [RFC PATCH 34/56] x86/alternative: Save old bytes for alternatives
>>
>> On 13.10.25 16:34, David Kaplan wrote:
>>> Save the existing instruction bytes at each alternative site when patching.
>>> This is only done the first time, and these will be used later to help
>>> restore the code back to its original form.
>>>
>>> Signed-off-by: David Kaplan <david.kaplan@amd.com>
>>
>> Instead of saving the original instructions at runtime, why don't you
>> expand struct alt_instr to have an additional offset to a saved copy
>> of the original instruction, located in .altinstr_replacement?
>>
>> The new field should be guarded with #ifdef CONFIG_DYNAMIC_MITIGATIONS,
>> of course, like the added handling in the ALTERNATIVE() macros.
>>
> 
> That's an interesting idea, I think that could work.  That would make the kernel image on disk (slightly) larger though, as the original bytes will essentially be duplicated (at the original location and in .altinstr_replacement).  I'm not sure which is the better trade-off (kernel image bytes on disk vs runtime memory usage).  Although I think we're talking about a relatively small amount of memory regardless.  Most of the runtime overhead of dynamic mitigations comes from remembering the call sites/returns.

It's not just about memory usage per-se but also memory pressure from 
allocation and the resulting fragmentation, though I'd think that 
majority of the allocation will fit into kmalloc-32 bucket, still having 
them as part of the kernel image eliminates the additional allocs.
> 
> Thanks
> --David Kaplan


