Return-Path: <linux-kernel+bounces-891348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FFAC427E3
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 06:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D8E64E5480
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 05:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331EC2C0F97;
	Sat,  8 Nov 2025 05:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ft2LWwSR"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21EF25394A
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 05:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762581109; cv=none; b=Awad7N+pT00v60nbBPoaAjd3ugSHMbn1HtJOONd9M/GBshCHyI0+91tEQEXMH794l488+cjx34Gfkb9FA71Ul2mo/bJtFDs4DFMzk44Esz1tsc0LKzztPkeZhCcn1Ax+vg+dfUfFVjv92cTPrgukS3A8G6LCkJqWyn8QeqmNg6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762581109; c=relaxed/simple;
	bh=XVJel/GC65JasbnZWN+s1dEMdQaYBj8pYLjdWWABm8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jQ2iu1AOegL3m1lVDWbRlb+53N5TzanCQ6cuBP9bX1LdjIvQOuwVccGHw8awDkhKmI1PvG9oRIm35NUT+PV94BSlcT1zyzK/3X0dIUySAhm1hpsIiD7Y6BeWYNKmclL6ZUqyoLB0TO7C41TE7sfqAjW9mM8N4Qdi7m3TFVB5tH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ft2LWwSR; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b5b823b4f3dso202242266b.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 21:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762581106; x=1763185906; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XVJel/GC65JasbnZWN+s1dEMdQaYBj8pYLjdWWABm8c=;
        b=ft2LWwSRgBBmNdoxzcVW4o0wDoZYgxI9UMaqUHQctakWI9ZoqyJMHS+/olFuNaE6m7
         N8OiakQ4BUU20Bq2AKsTC2Tc46rpBBE11JlsCVL19vVUgSNoM+imaBwIw/JMDdMqEugs
         yvm5mTznfcwUk7UgMH8L6dNKNDjlsOhHBGsPIaces46csuwe1QTunsP1SeGg9fIEriXU
         ed62pd9azxanYd0E6VH1aq2lFucyC/2fZrKRB29sEPCusgg98m1YUkY5J5ePF7Pm4KX0
         tEWnGP6gu4iaAiuF3o1gxluxMQFKHpPKdXa6ULPZpHYNjDd6J4qwc3INB3fseZCUe9Ss
         ADIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762581106; x=1763185906;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XVJel/GC65JasbnZWN+s1dEMdQaYBj8pYLjdWWABm8c=;
        b=CsFC79dVDyKCCxM3wefkSEDX3Q/6IjeTTYkj1q3TOpNEpzek7nSxgyvuZlQZEUJHw7
         wxDvmm796aFVuIpw3CkAZvEd7fTDLZkAObKWeXo4NIZ/aSL2np2D/+Pc869oiMlAv76L
         gFuInFgn3pP21868xGL+lZ4Y1lEEQ19tdLCbM6SbxSEUrj49AbatYJnyoCZbHi1kaLzr
         jHEyhgp9niw/4DtfjY2urGe/i6KwmYUTAd4l9xC5zNM3eiFupG6z4Exi1aLOUI8MX5XM
         +duLhpk5WUucdA1oNiI/KdJZ8kqcSrslS6Q7Y44SBRaMjgP5EUxd8mpSKCBvFK80fPkr
         47zg==
X-Forwarded-Encrypted: i=1; AJvYcCUjU+oeLLQXuewE4kXnKD0piMZsN9SjRVOhI1EvET9/hWNYj8+8mzn8aXcLHDlMn8cg99F1C6VFUfssCuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHbyMXA/6zEim/tgyQrwh+gcIIGi84LbHFpPpSYP/dIvylRjIa
	EcSSPQYXYWpSGuKWHZHZ2or48736SY0mPm0bXfwALz9rlPPt92b3xoW38tHrKw==
X-Gm-Gg: ASbGnct87+QBsIR+SvblViGOHcgP4BII2pyNNrZu0eSEGiUJSynA/zoOwu68HPa+VpU
	w4I76tuiOZEB76vvSddGAuHTtwmRlmlSH+UhX2Q0gmxH66lt2IlG77IEVsa/hla0BggLLjOq3fn
	EOWGM8o/r0MOZCQy9GSOo9HSF3p1tenJK3w7CrTqlZvCD+m8OT3/Ct9367ukG7z7D/UvHvSybhe
	rCQFALp97Zr0UoFdUYYatZQxFzM4ePEkj6/oDCEuq6rl01ZxakDP4bx4mV32wDDamsvxvJq9PQb
	PkRe3MbgTrSq+t679HkoVwBBY4U3CnzZ/H0jXvbveM9hpF/i4sVqIg1QhRON6fgRfQUOPNQVCyd
	6mJx7KCdZySBVnkvpB+pR3fEftYLJAUenMfztW68WIcR8PTG0l+5PQUxbqIY4zQo/Fj6DMCdwX7
	9OEbN68WLf
X-Google-Smtp-Source: AGHT+IH0Ma11e2l4b67D8Lr8TSDtfmbxdRsj2ctAmcUFYCbTXdZai9gzxybp4oIqw5DFwNoACkqzyw==
X-Received: by 2002:a17:907:7e8c:b0:b72:58b6:b276 with SMTP id a640c23a62f3a-b72e061a90cmr161041366b.54.1762581106194;
        Fri, 07 Nov 2025 21:51:46 -0800 (PST)
Received: from [192.168.0.101] ([95.90.185.18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bdbca75bsm443256166b.14.2025.11.07.21.51.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 21:51:45 -0800 (PST)
Message-ID: <f367735d-e480-4eb1-a2a9-c6d311661fdd@gmail.com>
Date: Sat, 8 Nov 2025 06:51:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] staging: rtl8723bs: Rename camel case enumeration
To: Bryant Boatright <bryant.boatright@proton.me>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1762576396.git.bryant.boatright@proton.me>
 <38533b30dbcb39f370fd778ee2a6838ca7b962a1.1762576396.git.bryant.boatright@proton.me>
Content-Language: en-US
From: Michael Straube <straube.linux@gmail.com>
In-Reply-To: <38533b30dbcb39f370fd778ee2a6838ca7b962a1.1762576396.git.bryant.boatright@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bryant,

Am 08.11.25 um 05:54 schrieb Bryant Boatright:
> -enum ParseRes { ParseOK = 0, ParseUnknown = 1, ParseFailed = -1 };
> +enum parse_res { parse_ok = 0, parse_unknown = 1, parse_failed = -1 };

The constants in enums are usually named all upper case.
PARSE_OK, PARSE_UNKNOWN, PARSE_FAILED

Best regards,
Michael

