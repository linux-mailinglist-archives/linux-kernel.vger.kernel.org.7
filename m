Return-Path: <linux-kernel+bounces-823030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 196DAB8558A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 656DF1B23407
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3E8239570;
	Thu, 18 Sep 2025 14:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="De9Oh+La"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE85717BEBF
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758206892; cv=none; b=MQ0rTbWPYpa47G9jrUcI+WldIRasFKaM/B10FdLKxTBDJjm/JrxVzxaFpgD46w9O2+fo3z6rU7V85y16qSRbPMIa6uwv4N6kyoV4E0veA5lyP6OiKw2XClhQu3ai6DZnWm2pGZLY5JMS1J4MKtfeIMRMFeMwOgLg8JxgtFspu9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758206892; c=relaxed/simple;
	bh=+6Pm7oe860827VjuzLws11HsAxMWZ3KkG/LCw0TwnQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q8Zxs+8uHLASY1lvFyJww9T+YxUh1JMW6/3KUmLeZZQf2bUhnZ1cIkGakQFkb13UBPo4FYRcT7piatcx7Cg3c3UdOC8vX00p9uBp4c4YthuZS8lKNQOI8XIrttSgDBT6wWPfWtbatp1dAVUQ3xN2bUAJRTZvKWW3cSz+GD96aJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=De9Oh+La; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-577228eb9bbso181930e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758206889; x=1758811689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iAxT3fVcqeuUfVjtRTsWYQE3cdG0LYpzTMO+2TQXp/o=;
        b=De9Oh+LaCTXV0rIHvODfatPxtQcXzKgovpQp58geWHtEpE9JdD3hgB59dsRCUoizBo
         2S0W73jXkVl9E4poR5bBI8Gh8KBCI87W92cS0pOv3GPF0Tvf7g++EscyLpcptHH7vYdm
         1NqjMkS8YYKQ884xJom+tvzgNHoiELqWsmZXZDpMOQBzb4VgjiAeVORrApQs+pYC0ghR
         uCiw61jExlnb99GG3dpCUjLPxG/QMqpwWzK39SnloLB4oBnEILHHJVYXCga+ISKSY66v
         PB6MuXFJsjJuADbvdQNU2kB4R6UpDvFNRsyzTdwK/Hqq1aZuENtrZOMgI9fLxyXGTQQY
         m+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758206889; x=1758811689;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iAxT3fVcqeuUfVjtRTsWYQE3cdG0LYpzTMO+2TQXp/o=;
        b=CysdOEIrDt4TdzPukrrDSYY/YvNWE0myXHJhRM+vUDZRfPnCQMWz3PzavP1RsrlUtu
         Ke4LDQ/2d/zRDTqW9lSIPwSEvcp+bc678MtT9TGGOQhG+i8RitNzhP49zsIgnec770Gg
         rWkgcf9iAYQN3tS3GA4HIHhZS9Rs7DzKfjhuUweJhFZKVmsFDc3NzN+suAw3m3D1RDRi
         J7oZXdlWxIZlBaUXl2lDnEFJmA0TKq0OwgfJF0Y6hQ3TZ5j/t7elIWQx7HGI+fHLJfWV
         7skgwyWoTZbLnog7I4vkeL6uT0IbKp/qP7fLZGxTUfy4R3HsResVOuu/KEYoYICoNbn0
         3Kxw==
X-Forwarded-Encrypted: i=1; AJvYcCUAnI6ThZDRTpmGMnpAZQHf62JLVh/9scyt96cKqtGYByI0hFV87uI2FaaWQuy9QaqO4TYHK9tMV02K5Qo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs5AHnxbYen66MeGCYAz4aG6CvTGOPhnD5uoAvirHKlz8Xsene
	dUOOFA/wdlSW/vRAVYscA0WXylGT1apH9OtK9K1tyy3hInUBlB/sFghR
X-Gm-Gg: ASbGncu1eNNrKgx27Bp6TCqRNh/oglPYyNrNzNaBoXVSt9NqhhGbazgZv8YM6vmxo14
	MLXaiUxsEi0DjpZHH4SwxBk3PLmSncy/JiZSDv5V9orPnQteIVv4G9XJtxiOgzMwl4p3bLZ3W5i
	1TuwblGmIYr5LNeSc6sMnZ79xiUYjANjhnD4zTmwrzb7S2qUPeC/SMw0vtQBRpn6+OlxUqbII5t
	EJVhaOY4wscKASNEm30MLQsNjF/rbGuPVBQG2CGii/BBp97PLfsLaH9t5cX6b3uK9wMnmlV+SU7
	Fdvdjaugq8DcEyQyuqOoWYw7mvvJp41uWvZ0KRQam/RUZnqsFtbLYyBmAj5sQtTFiCgI7uIeG9y
	7gyNTKroON0BYDnTokCdX4f/BsoFs03zczQqRCnA/Tlw8ic5YBLELo8102A==
X-Google-Smtp-Source: AGHT+IGHEzqw59r0e8igL1+CPPVfjvLXVyO+/F/7yKLyQTtxPDFzXxzv7jI8gfftK+xRhHpq+exTSA==
X-Received: by 2002:a2e:b8c5:0:b0:356:25da:89eb with SMTP id 38308e7fff4ca-35f64fef9cfmr8254611fa.4.1758206888768;
        Thu, 18 Sep 2025 07:48:08 -0700 (PDT)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-361a1e07947sm6404731fa.12.2025.09.18.07.48.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 07:48:08 -0700 (PDT)
Message-ID: <9f332ea7-4210-42f8-b640-3135cdd808be@gmail.com>
Date: Thu, 18 Sep 2025 16:48:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] kasan: apply write-only mode in kasan kunit
 testcases
To: Yeoreum Yun <yeoreum.yun@arm.com>, glider@google.com,
 andreyknvl@gmail.com, dvyukov@google.com, vincenzo.frascino@arm.com,
 corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
 akpm@linux-foundation.org, scott@os.amperecomputing.com,
 jhubbard@nvidia.com, pankaj.gupta@amd.com, leitao@debian.org,
 kaleshsingh@google.com, maz@kernel.org, broonie@kernel.org,
 oliver.upton@linux.dev, james.morse@arm.com, ardb@kernel.org,
 hardevsinh.palaniya@siliconsignals.io, david@redhat.com,
 yang@os.amperecomputing.com
Cc: kasan-dev@googlegroups.com, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
References: <20250916222755.466009-1-yeoreum.yun@arm.com>
 <20250916222755.466009-3-yeoreum.yun@arm.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20250916222755.466009-3-yeoreum.yun@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/17/25 12:27 AM, Yeoreum Yun wrote:
> When KASAN is configured in write-only mode,
> fetch/load operations do not trigger tag check faults.
> 
> As a result, the outcome of some test cases may differ
> compared to when KASAN is configured without write-only mode.
> 
> Therefore, by modifying pre-exist testcases
> check the write only makes tag check fault (TCF) where
> writing is perform in "allocated memory" but tag is invalid
> (i.e) redzone write in atomic_set() testcases.
> Otherwise check the invalid fetch/read doesn't generate TCF.
> 
> Also, skip some testcases affected by initial value
> (i.e) atomic_cmpxchg() testcase maybe successd if
> it passes valid atomic_t address and invalid oldaval address.
> In this case, if invalid atomic_t doesn't have the same oldval,
> it won't trigger write operation so the test will pass.
> 
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
> ---

Reviewed-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>


