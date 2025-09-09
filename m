Return-Path: <linux-kernel+bounces-807894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E46FB4AAD0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A88831899177
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9CB31AF0E;
	Tue,  9 Sep 2025 10:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TyZpiP4Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E542C235F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 10:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757414154; cv=none; b=S3pJ3+/9pEnz99UUmsFe4PaT7+aV6Vlu03Ca5d7vAbd9W5SMBkhoV9siYkUWmXPLnOjwtS4WFpPLBt/icRLr2eK4BzuIzhfT3nhsPAXIZYwyZuAaEGsSu9yoTbKE1jJSUOUbXF9AQkAY8zi5NSbPfq3/Nsf5bHIeOZF+pDPoihM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757414154; c=relaxed/simple;
	bh=jXzv9iCGp3BL8Y5WtKFZfKQOrd9Gg4g0fNzVnx7sU3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rE1hMwekXkHo3OlEYsIkFateIPhdJyROv17Olnza8xCyJtC3yKpLe4Fc1I3pSI6c59FgBtSaxQ+eGnze2MC8zcgSmkoFQ+q+lqmYvbi7kOgKDBG6ACU8ChJu9qYwqZO5jD9rhHRHme0ZRMYrH9viX70J8Q2pP4HlxAYMyjIboC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TyZpiP4Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757414151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hcq5eJSCSrjCKibAj2Df80bFB10pidDrkH3C2Ui1bf4=;
	b=TyZpiP4QKU4Z/f2cA32fTVs9aufbjyOmDdOTk18UfgLfftppgkUksk+fzJUTQjaYTTQZ4R
	Fyk6DSjjUIZvfEy1FCKUbHZkNvzmedv46jBcSFn97gK8wYRT/K440dcTMrilFX9Imus+tF
	pWO6HuBhuBml2QmChvpar+lLG0aFHiY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-z8jBojxoMg-XfFJKMtrINg-1; Tue, 09 Sep 2025 06:35:50 -0400
X-MC-Unique: z8jBojxoMg-XfFJKMtrINg-1
X-Mimecast-MFC-AGG-ID: z8jBojxoMg-XfFJKMtrINg_1757414149
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3e014bf8ebfso3138978f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 03:35:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757414149; x=1758018949;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hcq5eJSCSrjCKibAj2Df80bFB10pidDrkH3C2Ui1bf4=;
        b=BlB1CLsJhMvR2Q9pREx/tbhu4NupbNDbchgNhShneUieGj50LFRGnHfxVf5hH/4yzJ
         uQf+gfTsjBB8xFIrFxWy2+ZExoS8gJoFY9ZuVkh8WMA9fkrqCpi6ZQy+Xd+E/dNHMgG4
         L8bS0xN+RgA0k5NkFB9ErF/j1XGdyV5yGH+e01MI4FA2276Xax4HH2c6TWLktOEvEcCG
         hbwOWA4YrIhe6jrhkLblIy2Lm2NtN+Rosaey3NVhS0xDZdxVgNZj7DgPvuLXIyinvXAd
         EBZNOd3XVIrZjjTpXGKy3tg3slnFT/saM1ADfTWU9K6uIBFEOKlAgcXdT6+bx3LmkB0a
         KA1g==
X-Forwarded-Encrypted: i=1; AJvYcCUHrkAlZLPXakefLVl8Mvxps8wUF6R5tvZKoMUYdMsf3hQl53XReMaqRTxp0lJ6i3O45WA7vhqi3VnVQr8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo6OTeDnN6Mv6JZS32ok2piOZxDUixik5MJJKsmLySyi5Mce1m
	Iacx+EVPQs+o1zUNbT3wG12SNtzA+oOpDgrt8HDN/6VEw1d9391UIHW417pmy4MK+STEyJtnYKu
	pw6CUj74zkOy9xolvOmfvZphLLsy5AJlZx+eiFg8gJtnYr1O/Tba9LyeUCT05aI2SYg==
X-Gm-Gg: ASbGncs/coR09juvn6SYrH03if3+XJ6keK6C7VD8PZYLOfTFUusCPQLH4y4Rb3MzlqC
	II1J48w06XxHV6AuhUSUEzyQ5NdyTncBJag96HtgJA+LRGfUq7w/aur/fu4EHt/FE1JolzjOawF
	yJZcnFfbiXyP90C5fR/7S9bRq+r3ActFJnOTqyuvh9XEapHxL1fGMUtOa5MCWxyTMEFi3M1PCIT
	JBKIELMpc0kyM0Abp5D5LqYbbAzF/Z09l/eupiFrmV8UBSlklJ296tgZ/8mGNrU6OROeUcPxEIW
	fy6Xk+H4IhbWb2p92k9GPeR9sj+HK3PMGSZ4EdJQ5uFre/e2Km7Z5JGnh4waweLDTXY/Bcfq5ux
	tgQyG2Qc61xM=
X-Received: by 2002:a5d:5f42:0:b0:3bd:13d6:6c21 with SMTP id ffacd0b85a97d-3e2fa64c720mr14413376f8f.0.1757414149022;
        Tue, 09 Sep 2025 03:35:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGrFPUq1e+l+KDZXb55Z+P5p7wP8w31cGiVGtf+1tnvj/A13Xo8l0XSiIZ6DWfdHjx5QJgTA==
X-Received: by 2002:a5d:5f42:0:b0:3bd:13d6:6c21 with SMTP id ffacd0b85a97d-3e2fa64c720mr14413349f8f.0.1757414148634;
        Tue, 09 Sep 2025 03:35:48 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45decf8759esm32939185e9.23.2025.09.09.03.35.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 03:35:48 -0700 (PDT)
Message-ID: <c649a695-caeb-4c20-b983-9035c396e145@redhat.com>
Date: Tue, 9 Sep 2025 12:35:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] docs: networking: can: change bcm_msg_head frames
 member to support flexible array
To: Oliver Hartkopp <socketcan@hartkopp.net>,
 Alex Tran <alex.t.tran@gmail.com>
Cc: mkl@pengutronix.de, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250904031709.1426895-1-alex.t.tran@gmail.com>
 <a7c707b7-61e1-4c40-8708-f3331da96d34@hartkopp.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <a7c707b7-61e1-4c40-8708-f3331da96d34@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/25 8:25 AM, Oliver Hartkopp wrote:
> On 04.09.25 05:17, Alex Tran wrote:
>> The documentation of the 'bcm_msg_head' struct does not match how
>> it is defined in 'bcm.h'. Changed the frames member to a flexible array,
>> matching the definition in the header file.
>>
>> See commit 94dfc73e7cf4 ("treewide: uapi: Replace zero-length arrays with
>> flexible-array members")
>>
>> Bug 217783 <https://bugzilla.kernel.org/show_bug.cgi?id=217783>
>>
>> Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
> 
> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

@Mark, @Oliver: I assume you want us to apply this patch directly to the
net tree, am I correct?

If so, @Alex: please use a formal 'Fixes:' tag for the blamed commit and
'Link: to reference the bz entry, thanks!

Paolo


