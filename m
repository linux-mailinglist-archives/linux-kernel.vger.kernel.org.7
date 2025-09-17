Return-Path: <linux-kernel+bounces-821002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A61FAB80017
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A3C62A0D25
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203592BE032;
	Wed, 17 Sep 2025 14:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wMacfxa6"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A574E33C776
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758119175; cv=none; b=qrnLZwjOboEMhToestFOvKBQ1cD8MODnNBvDsgpnGOeJzBIGpA4SXl4kEGeY8DQD39F5I/4v8NO3z78M9Qbd4KgJm99k09ayyA/3ASegMRkAgQzbjjXn7jaCtpJjrZMqN6TF8Tf5wZs61Lv4gnhugR4qV7wnQhjZtSp5GoQtwvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758119175; c=relaxed/simple;
	bh=JZxC59+l0K5DkGdV5aRYQYUWp1YC5ovZfqzD3FPsuz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=StBn0c6YR08CXwcOBZQyaVZrgyKFAlFXr941ScivFiON61lewlll27U3Vj9QNdo69XNTvVq0MnRP9f4kWSnJ3WUtjQci7LTy9fxk6N3fAkildWB/Pd5VKfeNs1q/4KrJKUSmfg2W/hFYaqBkpyEaV0z+OwJL5aSeufwyQqwyerI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wMacfxa6; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b0473327e70so546563266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 07:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758119171; x=1758723971; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=10t2Z6sgnABIAwDZkTB26QdFfX0ldYEILJpBIALC4NU=;
        b=wMacfxa64V+hZqJdlMnXg2iSd8LdTVPmi5yXWNYYsPUQc/J8+hrz4DoD5nrQhJ42fn
         lqYPw4FMS30yNrWWuIwJIIfpA35RmuASBsHIvLBSzdg20DpRwJU7UuxQdqsfZZ/myoN2
         BgmpKgzbgIR9kuV8egT9fW7/uShJv18fYzfI5NdxS/JAzWA7HSLDoVYVOjt1/v+LZHOP
         73H2hVA/lfUhzCm3SsnPH1BFNGNc5ii4yvJvXJunecjrn419i291yAPce4q3nT6ClaCZ
         ZMWGweox/NDihX+XLcQlPvFDH8S2PZNE5jw3jJYdSH+c1b3qisNVF4MkZ9md+bo3CF72
         4TXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758119171; x=1758723971;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=10t2Z6sgnABIAwDZkTB26QdFfX0ldYEILJpBIALC4NU=;
        b=hF/Bc+GXp8TJSuBxX82oUDFe/tyFXxal3NsMdRaNvV2zICdD+bt3aCDAbb63/0CxRk
         K62MqtnP/sv5exwlz/8DXcpP7oFO9qCmAsFZGQCBKfQmQdkInP/+IV8oH5aV/GoW6heD
         onTV/eonBYRDuhXoRpFA9ZaEbeZyUIdW6/jeOck4NIcPvqganB2lL7D+VpCxF7mCLrfS
         EI9dm3n409sAd02OfBDSMROo4XreeaY0GTUl1fn1zMMJ5kFHgMgyDpTSbSve6Alh+Rx+
         Jw79leJDia1pTRklzksQWQV+Y4kMzPTPB/OPugYjlwqJEVYX66Zt2C1erkQF8zRowkUX
         8KoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdbDJ9MHl7hHWaYjQMqkNWsT4mM65/5wdEr+KHv04L+53+yGJNAQSZm/flZD80cNf/Evb0gu3DtX80jy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMaVZS+cnHbTTLMS6I9scP5WY24yVxDpcpHaNVJbc5h2iR1mAh
	N8Dowh/l1l4qr1q/wqwfik/qdfqypHsCspwu8bu4QktryAzbO6GrAQPRLKE5Me6LXh0=
X-Gm-Gg: ASbGncv6gHkk7fpY05uu1BndOf6tnd7rJe0J3vVrKT2cMtjjSXDX/iNffpAyHbEVaII
	KH2BF05yjq9bk6EVfmbfwg6GrZqj8hX7NuLBWM5Q7AqPB9SjCKM19fLPpjmt8Wzbs0SslcoY0aC
	N5lNGO4ThRmMkHNFgQkx2NyqkcLQO9lXlsKWZUHmjc7yAJpBnkQXuqAj+bQSp/fLZevDQVo6UkY
	3UtlFsCEFC92JCFnu5XfzVhLMIE9AzgBqMjHfOfLw1+wzgQrBEoDfok4cc9MpZFBR5ZrU1Ag3xc
	O41BMRJ+AdemLfHfJb6dRpvMZUXXwbQrKzK+lvGolnaIVvI6/4yrdW7wOUNGvwCmbUmiUtJtggr
	ZMOmfKVOa2meGKZ9fdZwmvKhg6vmGhrZhPJwkErICtEc=
X-Google-Smtp-Source: AGHT+IEaxm2Ezs6X9pAGeZTfGiDeZKKFcv9jYxAWmPiRXScidoOV/iqJhV2uKVKOhqCyY8zfonbwMA==
X-Received: by 2002:a17:907:970e:b0:afe:c2e7:3705 with SMTP id a640c23a62f3a-b1bb2d0f4fdmr263147466b.22.1758119170855;
        Wed, 17 Sep 2025 07:26:10 -0700 (PDT)
Received: from [172.20.10.3] ([109.166.135.151])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b3347b90sm1356906866b.109.2025.09.17.07.26.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 07:26:10 -0700 (PDT)
Message-ID: <b8a0586e-a79a-4e14-87d8-ee156436d1b0@linaro.org>
Date: Wed, 17 Sep 2025 17:26:08 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v3 09/16] genirq/irqdesc: Have nr_irqs as non-static
To: Thomas Gleixner <tglx@linutronix.de>, David Hildenbrand
 <david@redhat.com>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, andersson@kernel.org,
 pmladek@suse.com, rdunlap@infradead.org, corbet@lwn.net, mhocko@suse.com
Cc: tudor.ambarus@linaro.org, mukesh.ojha@oss.qualcomm.com,
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
 jonechou@google.com, rostedt@goodmis.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250912150855.2901211-1-eugen.hristev@linaro.org>
 <20250912150855.2901211-10-eugen.hristev@linaro.org> <87cy7q9k8y.ffs@tglx>
 <87a52u9jyl.ffs@tglx> <8df2cf28-c15e-4692-a127-6a5c966a965e@linaro.org>
 <2bd45749-e483-45ea-9c55-74c5ba15b012@redhat.com> <87v7lh891c.ffs@tglx>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <87v7lh891c.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/17/25 17:10, Thomas Gleixner wrote:
> On Wed, Sep 17 2025 at 09:16, David Hildenbrand wrote:
>> On 17.09.25 07:43, Eugen Hristev wrote:
>>> On 9/17/25 00:16, Thomas Gleixner wrote:
>>>> I pointed you to a solution for that and just because David does not
>>>> like it means that it's acceptable to fiddle in subsystems and expose
>>>> their carefully localized variables.
>>
>> It would have been great if we could have had that discussion in the 
>> previous thread.
> 
> Sorry. I was busy with other stuff and did not pay attention to that
> discussion.
> 
>> Some other subsystem wants to have access to this information. I agree 
>> that exposing these variables as r/w globally is not ideal.
> 
> It's a nono in this case. We had bugs (long ago) where people fiddled
> with this stuff (I assume accidentally for my mental sanity sake) and
> caused really nasty to debug issues. C is a horrible language to
> encapsulate stuff properly as we all know.
> 
>> I raised the alternative of exposing areas or other information through 
>> simple helper functions that kmemdump can just use to compose whatever 
>> it needs to compose.
>>
>> Do we really need that .section thingy?
> 
> The section thing is simple and straight forward as it just puts the
> annotated stuff into the section along with size and id and I definitely
> find that more palatable, than sprinkling random functions all over the
> place to register stuff.

+1 from my side.

> 
> Sure, you can achieve the same thing with an accessor function. In case
> of nr_irqs there is already one: irq_get_nr_irqs(), but for places which

Not really. I cannot use this accessory function because it returns the
<value> of nr_irqs. To have this working with a debug tool, I need to
dump the actual memory where nr_irqs reside. This is because any debug
tool will not call any function or code, rather look in the dump where
is the variable to find its value. And nr_irqs is not in the coredump
image if it's not registered itself into kmemdump.
So to make it work, the accessory would have to return a pointer to
nr_irqs. Which is wrong. Returning a pointer to a static, outside of the
subsystem, is not right from my point of view.

> do not expose the information already for real functional reasons adding
> such helpers just for this coredump muck is really worse than having a
> clearly descriptive and obvious annotation which results in the section
> build.
> 
> The charm of sections is that they don't neither extra code nor stubs or
> ifdeffery when a certain subsystem is disabled and therefore no
> information available.
> 
> I'm not insisting on sections, but having a table of 2k instead of
> hundred functions, stubs and whatever is definitely a win to me.
> 
> Thanks,
> 
>         tglx


