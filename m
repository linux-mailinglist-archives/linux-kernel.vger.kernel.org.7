Return-Path: <linux-kernel+bounces-842274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CE1BB9646
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 14:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F269A3BA29A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 12:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BE826463A;
	Sun,  5 Oct 2025 12:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLMeXfqP"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA78224FA
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 12:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759667576; cv=none; b=QKHZZvPdYL0W+Tc4DEDVGbocKj3GEIxQgJV9mYlbWsI5gZKUtLfb/j3LsYFU/ZlxtSw1qEp7LePYEeJGHclvQKeG+qG7rO/msM0t/Lj/sCgbjAFwsr5V4HGMnvM9M/28pMJPuxQjLQY5a0eNdKtZWwOwpAKml2YOiG+Ln9hdEQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759667576; c=relaxed/simple;
	bh=isW39cBflKEuRL+cWorFd+Z/vYMoEyVFhVBij08XUFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sC4Pu3LaXxCXa0+7YPyD3xAdrrqPZYqQci64wWqqouYjA7RDXdLZXTY/nTSZlEucnQWvXRlZtfzmNDqmC2dWf9pgsSWhwH1ZWJVOGQiqBMVZMuq7GjGIcTz5zkDXjrd6iTaXX4Enc3Vn1CIPN2uNm53gDBLXJefgneJeFDOaCZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLMeXfqP; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e2826d5c6so30598055e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 05:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759667573; x=1760272373; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=isW39cBflKEuRL+cWorFd+Z/vYMoEyVFhVBij08XUFk=;
        b=XLMeXfqP7gEXqQenQT5Fyer4TufPr4kVjeCtrbUd8/Cqbw5MDg18/n6yVKDbtJ5GX/
         vy1PoT6ADsYKcet/LgyaN+VmfEiomg7Lcu4ZqAkr/w2EPJDP5eMwOeC5Y2wriizIVbEL
         FIw3nW3fZaMrFhoXsgpH1tMlyf0ljs6gwqacU+piuv9JwFZb+bJigHfvsjf17LCGt6Se
         6kRSPTjnlr2kMXH7aDgsGk5n67qqmdO1MRqoYH20F0mIdCAlCg9Nr+dHUmYmH88GVKVI
         OWF8TQUtOwyPYljrdc5nCC+v2ZAqfbgmIByfRcFOKbLS0UJlBYAn71KlsRq79CWoz8NU
         D+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759667573; x=1760272373;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=isW39cBflKEuRL+cWorFd+Z/vYMoEyVFhVBij08XUFk=;
        b=wDOx/yCia6B8gjmsDF2mR5+0Eh7OHSV7PCJlN9wrCzQs6a/aWBLrooGXieuL0M7Cxw
         zH0MRsyQXepkcXdW8F/r2Vk5SoixNG3w6c+hvT1bRPv+aa6zfUDtSCA38JF+SIX+3DZS
         WQCxjz1q5leHqbFcSYBBS5HYRwoxdicByh4fJkhNamsY7m+nF83lrfH1nLb0qruFf7SZ
         /A+BRvh590wjCt8SzpR/xe+QwSM4bRdKZll7qWZWLAC/XyPa21EKXy4xUVJuY/+TpWJN
         bx4egmBiGpNUikswrkXOXe7d0QFh6U6r/kAppVsuTwd3SJf96si/OfJYuOz02C1osmqq
         3nVg==
X-Forwarded-Encrypted: i=1; AJvYcCVNxTRTjlmXXmheCZ99SY9FeCTHSZq8SCmRb1F0PSb1B89S+Uak/HAJHIkuY5l8+Of+ZBiL+Zwo9xLCoQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJepGXHoInisJ43lJ3qQxaDiQxhBDB0QwP+ZJp1n7ARI0RQd6G
	XZziqaBiYLBTRnCBuPQSHllxF1KlFHyL/koaADCaOtka803FlngXPnQl
X-Gm-Gg: ASbGncv9QX4v9JM0P5Wc8uG7ZnoehOmk7V48y8FSWf6O9jizO/Vg8NFSKAkeMcBTwzs
	vk1k3O7GbRLp6dNCQeZBwUFXh3/2EpHQL4cX/IKhqitoxH8DDCH9OIiuo5qEgQ5N9Wb5YxbGHT+
	IKN0Sw2YM08KI/NCK/BAnhU7Oxr1vmNSJVdBw5++GRg/1AkhC+s6G0cOdxVD1QH2wjgelrtN9GV
	Axr0aXO+QufY+3pv0vwqPeEm23SV6JFWZg2bR9WiNotJrcxgAnnqwx19iraNB03O11lTWCkjE1a
	rHdcb0EekhcMdPrzKTboJb4aDiDRFhwKr0ccgHSvFd6WipGMShV+ILj9XesUZEGqj12+QTVKRhx
	exouXkEWXI/idZvFR/S1zhHs6x16iP0nKlEpZsKsemIDAwKlzmaVunADGyFQ0
X-Google-Smtp-Source: AGHT+IFk2T9s8yBTZY5YN/FN9+iyw79NZ9OXdGX+nVkPvugA8SSWCXDFYS1g0NfJLrnuJxR1kZ155Q==
X-Received: by 2002:a05:600d:41f3:b0:46e:3e63:9a8e with SMTP id 5b1f17b1804b1-46e7114735amr56865305e9.26.1759667572385;
        Sun, 05 Oct 2025 05:32:52 -0700 (PDT)
Received: from [192.168.1.121] ([176.206.100.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e9719sm16522876f8f.31.2025.10.05.05.32.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Oct 2025 05:32:51 -0700 (PDT)
Message-ID: <92d61a7e-4aa2-4fb9-9d97-52e04b34df4a@gmail.com>
Date: Sun, 5 Oct 2025 14:32:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH v12 8/8] platform/x86: asus-armoury: add
 ppt_* and nv_* tuning knobs
To: ALOK TIWARI <alok.a.tiwari@oracle.com>, linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Limonciello, Mario" <mario.limonciello@amd.com>,
 "Luke D . Jones" <luke@ljones.dev>,
 Derek John Clark <derekjohn.clark@gmail.com>
References: <20251003185520.1083875-1-benato.denis96@gmail.com>
 <20251003185520.1083875-9-benato.denis96@gmail.com>
 <86282444-f489-49e8-892f-46ce655030b5@oracle.com>
 <34852b92-a859-4e18-ba2a-c3cab814c2b8@gmail.com>
 <18fb538c-0165-41bf-adbd-596d75b5cb9e@oracle.com>
Content-Language: en-US, it-IT, en-US-large
From: Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <18fb538c-0165-41bf-adbd-596d75b5cb9e@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/5/25 14:30, ALOK TIWARI wrote:
>
>
> On 10/5/2025 5:52 PM, Denis Benato wrote:
>> On 10/4/25 13:42, ALOK TIWARI wrote:
>>>
>>> On 10/4/2025 12:25 AM, Denis Benato wrote:
>>>> +struct power_data {
>>>> +        const struct power_limits *ac_data;
>>>> +        const struct power_limits *dc_data;
>>>> +        bool requires_fan_curve;
>>>> +};
>>>> +
>>>> +/*
>>>> + * For each avilable attribute there must be a min and a max.
>>> typo  avilable > + * _def is not required and will be assumed to be default == max if missing.
>> Hello and thanks for your suggestions!
>> I am not understanding if you are suggesting of just fixing the typo or changing the phrasing.
>>
>> Thanks,
>> Denis
>
> only avilable -> available. 
>
Perfect, thanks. Typo fixed and new version coming in a few days to give others time to review.

 

> Oops, I had a typo in my previous reply :)
>
> Thanks,
> Alok

