Return-Path: <linux-kernel+bounces-820002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C156EB7E974
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEB0B522529
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 05:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6679127E076;
	Wed, 17 Sep 2025 05:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bahRn+WE"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0599926F44D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 05:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758087831; cv=none; b=OZrJRh/NTPE48B+MOVeTV22Dbq5epD3UXLTV7vT0gyvZR7NprTV8N0fQKYiiNJJHYptsETwVk8vk1H0Bx5aWZPTx5j6INObKraG97r3o6/fOCBKv2T+25kCDA/BWbb0Wf751DeeLnr679UowsybpqMxirMT8OBQ7vLMqWl3PGVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758087831; c=relaxed/simple;
	bh=2Rj2GVVJeO3cElmAMzCe+vsZ7kk7vpWF5sm/8l3AHd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sXh0l98v2poLaT7cJX5q+wod+R1aNQunynCpa3LKfMB1gflOj9Ndav4/bueEJdME53LPPxDO6lXfUg+d2QMLhti01egMz072YIjeSmP4foIO+GUkfhhhS/7D4gbxCt9KOq7EH1VRcyv7w0dx+3J6PnSnhs9MzQG+CaXykQCAiA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bahRn+WE; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b07c28f390eso850811666b.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 22:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758087828; x=1758692628; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CW6YRUB7XWZg6Z0QvIr5Jdp9CvsPmVtxl4KHm6Wzt7g=;
        b=bahRn+WE6Dm9TwNA8fqpX/CAWNUyUdT37CPdrvoYBZ+zF3AfoojbVZDika7I2d/O5i
         JAzevz8or6hZBhQeCy0coOVyjpNdqev5KgTseH4dv7Jvt3zucPhrSIY+J9Z978FQdIS1
         UsJUHi9S/7gUvi9thBF9ASjWAHM1wpSbMAr4YgqJoGdidfVDNDwXxwf8OXlWWxl1aCtf
         +kv5AdUQOifw85GCvDvPo3AodUv3QVhtJuPWpNSGlPQACDKb8Bqk6RjU3pqLvH9odVY1
         8DHh68E5LeURTLUuzIyKHaI5qnAOF7vSJQe5EVlPSN7/3YABk4KBHq1+F2MBNV8GvzoT
         6Fug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758087828; x=1758692628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CW6YRUB7XWZg6Z0QvIr5Jdp9CvsPmVtxl4KHm6Wzt7g=;
        b=rwZIez32XSl9EVHJAhEd5IusTmlAUsN47z6MMESvWJcobREV9DlhrZsmeAmu4tHUGJ
         FgPtc4v0t8V0uJH6dfaOanscb087OeEoHX7Eahha9WRyDxkvo04fzZ1uQjljkKVrmxlU
         e+7NjJXznVj/1hDoELMUgv6krUdjhb620qCbnDlGG03To1SELEU9x9GGbKauur4A/6Cv
         L2nKg8VIKQbqHZBUYJGreblQNIIjlTKz24smuL4hB5Rg7qR5smX64g7RnRWGjo3DZJcM
         FZf2GJoU0O8LYYI+9sOrsp/oBlnURrHlOtNl2ik2qJYKIuBVoCL4ZfyU/sBjE57sxUm7
         4NuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhzcGP1JU1MmuI0+j/W67h5LpNOjIIYSGahhjfP4tA1gHllm0Q/rnzjUfmPW20cfbA0aWDch372EFSXK0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw340eoYgEYhuJOEUtrQa98dqyXzFwdb6d32MO4NgCMSDoe+Cvv
	Zk7uunHk93H1svUw0S3RllsM36D4WUdAlMnhVHTU3k4YLn8P2u7z21uqaxoVDibigEk=
X-Gm-Gg: ASbGnctdl8k222FW7yB5gmJFwBI2E5UsuxAN+fijDIBthPsxBfKs6f8UEBPS7Cc1DBR
	036d9PLkOupxMhzT0l1M7r5T7/8zmuOBceWsCWrnYdZQzTOhaQzjLei2ex9t4j58NHFcd48STQK
	K4CqA9tX6lBnGNXux3/w2Sl2wJE5Ui6rIpMCYnpXhrgKtRh71AKBJmL5Um72IuYFXevMsb7rut8
	30rUcQUsz48jBkoXdul67+wazzwXL2AEVzel/99HkvD0IN2hx3BGwMndmqGhakPiPuXWBn6wzYs
	8J/nMqtYS07CcNzKOrwxQabDggNZyzZoWqxswqUeFJYaMKBnSHbg3IMviee5q/SkSf4QEkiIFxV
	Xy6HsPlTfbW3e8ART8gt/J8a1lMGc3w==
X-Google-Smtp-Source: AGHT+IEwTeAqrWw3yRYXMNv2Kyom1bFBunp2rNawKurYFNJfFiYeBaBgK7tfvL+8o/YQVxm7ewmS1g==
X-Received: by 2002:a17:907:3f0a:b0:b08:85d0:3d8b with SMTP id a640c23a62f3a-b1bb73a69abmr108132766b.21.1758087828294;
        Tue, 16 Sep 2025 22:43:48 -0700 (PDT)
Received: from [192.168.0.24] ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07c6110c27sm1088029366b.66.2025.09.16.22.43.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 22:43:47 -0700 (PDT)
Message-ID: <8df2cf28-c15e-4692-a127-6a5c966a965e@linaro.org>
Date: Wed, 17 Sep 2025 08:43:46 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v3 09/16] genirq/irqdesc: Have nr_irqs as non-static
To: Thomas Gleixner <tglx@linutronix.de>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, andersson@kernel.org,
 pmladek@suse.com, rdunlap@infradead.org, corbet@lwn.net, david@redhat.com,
 mhocko@suse.com
Cc: tudor.ambarus@linaro.org, mukesh.ojha@oss.qualcomm.com,
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
 jonechou@google.com, rostedt@goodmis.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250912150855.2901211-1-eugen.hristev@linaro.org>
 <20250912150855.2901211-10-eugen.hristev@linaro.org> <87cy7q9k8y.ffs@tglx>
 <87a52u9jyl.ffs@tglx>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <87a52u9jyl.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/17/25 00:16, Thomas Gleixner wrote:
> On Tue, Sep 16 2025 at 23:10, Thomas Gleixner wrote:
>> On Fri, Sep 12 2025 at 18:08, Eugen Hristev wrote:
>>> nr_irqs is required for debugging the kernel, and needs to be
>>> accessible for kmemdump into vmcoreinfo.
>>
>> That's a patently bad idea.
>>
>> Care to grep how many instances of 'nr_irqs' variables are in the
>> kernel?
>>
>> That name is way too generic to be made global.
> 
> Aside of that there is _ZERO_ justification to expose variables globaly,
> which have been made file local with a lot of effort in the past.
> 
> I pointed you to a solution for that and just because David does not
> like it means that it's acceptable to fiddle in subsystems and expose
> their carefully localized variables.
> 

I agree. I explained the solution to David. He wanted to un-static
everything. I disagreed.
I implemented your idea in the v2 of the patch series.
Did you have a look on how it turned out ?
Perhaps I can improve on that and make it more acceptable.

Eugen

> Thanks
> 
>         tglx


