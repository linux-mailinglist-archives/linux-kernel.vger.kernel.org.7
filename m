Return-Path: <linux-kernel+bounces-889578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E57F8C3DF38
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 01:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D48994E0FFE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 00:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76AD1F875A;
	Fri,  7 Nov 2025 00:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dyhD011n"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395BD1E3762
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 00:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762474318; cv=none; b=LTGI+w4RxLmxhQsHsp1IAbfmDnKJEZ8EwsC9xQimOcEVXHNTlAMupW5WKWXHV0A+iu6WlbK6JX0pzClXUgq6hZmHJxo38dVfcb65xZ/GHU1t5SQ2FF76SX+NNURfvPyFrWtPlYeUWSpz6T80yhWIxmI9HrLqNTHOLzYfAnC32Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762474318; c=relaxed/simple;
	bh=Gz94VwghZAcWH0Y4Qii83vg3Xhzkg1tWELnBwvoWwmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RIY7yYTuCHJggKDmQZZ6sasCCyVUGtYudpvL/HxVc1bwoNKDyLVbNrQdWdx1ZsCqTDy9NYHwwUnYmqKlMPwN3YCKugkZYABRsA9/zDAoPqVCjohGK0SiX6qd+NgvUw7oWPdPXQkq9fIcmhqa//EwMUB9xfcrlZkWT53CYqoItlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dyhD011n; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-43346da8817so1203235ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 16:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762474315; x=1763079115; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5GwBxceYDDYB1hhqN34v7e/nCrVCNwzzouj9wlQU3do=;
        b=dyhD011ndN2+t0uiZtW4n88oc2ixKfg7swcEQ+a8qfXvIDDbeyoD0XlKQZkrcyCVkM
         6/0RAKI0InVydH51Kq/9RK25+8oRxKg4+s8tt6QYHrHiN415Z8HBvT9NIc7j2BhA+Xzw
         n0fLDMhLj3IukolCmnPDZ7UfpTELHPE3EIO/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762474315; x=1763079115;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5GwBxceYDDYB1hhqN34v7e/nCrVCNwzzouj9wlQU3do=;
        b=asUwX09P1BOyf7YiTgR2O5QOWyc+QTvJ4lWtTqHcIiwzMm820HUqAIVhFJvCCWrNoA
         y8u7cCWC55gx4WrYBXys6M4pNN40az13MuAWLX1EeSLIfbsPyEePvgxS2nSVTdiIE549
         x692zmH36I/y+kFMkf4dTIog6Lg75rHSk9xJI/MTt4+Ymkfcd6ILrSwOOJVZUmZfIkLb
         AIy/0bnY1KraON4YS9OPyLOThwMyg/sv7aPs+ZwKE3yL3yzk1X0hnFqfgbhnzeXj7ODt
         ieuxF5qM7hlnf36NeRssQk81gQeWp1WloSTE+U7h7ri4n4hvfcWO2cvfqMpsfY5AfFhf
         WUYw==
X-Forwarded-Encrypted: i=1; AJvYcCVZyc1LIB3l+HylDB/j2Ke5nifmejR0qMGXp8VQpI0qpmrvUZJM4gUQmXfmTXMycOoKOEuOJMwI2zLFaiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB7ci80ePEsH5Tq6p2ca+Yz+lONqAAi1/LlXzybtM/x6o58y+E
	JPHNdLmJetJWNSKWiccJTXqdqoOpc2cJL19O/XSA7taWglRcClPegcLLoyJMLcyUOT4=
X-Gm-Gg: ASbGncuCIX7TY60Ih6WV1DTeCzJ1yG5k7Mey2OHPwUsmoE1I29H6zBCQSOWb6u2OuJd
	D/PoFDAI9380ehZiNOU5HmNBKeuqdJiG/FwZbt4oiBOuhtYROWMlHq4BB9Jd6bmmpgEKQdPLtUx
	DS3nZOx01oLMbsCWHl2tO/2Ceo5VfoP3HKC4GiWTv/FqbimM7+FiSlE3lLFeZ77DYbeqyEX16Gk
	6W01fkKSMxIBzuGDCYFw6wVFq0QdQQVU/+M97WNOq81lUsNKGbsTHiY03xMWVKipRWiAo3HtzoR
	w1Wypv5Gs08LF50gMvmbNrzV7rDVBg+V1gNBUKrVeRVMNGOF6Etp1gCiEWtwHB0W5iNVLfgfci3
	ygHD9DC5qkO9r5r+zY+BrP1s2E+fKXwIfoPtEfeX6rSoLVBIdXXs3sr4UJJfEVLh/HvVTE0M6pn
	0pWFsHJQL7qYF84PJVQXx7u5g=
X-Google-Smtp-Source: AGHT+IFXbwBzw/G+QcPg/t1QNjcHfjVbP/MOFLMN2clgnclgPEyW0ZVqwz7uIpdbibH+YlR1+l7hPA==
X-Received: by 2002:a92:d786:0:b0:432:fc40:f323 with SMTP id e9e14a558f8ab-4334ee812eemr67104275ab.10.1762474315341;
        Thu, 06 Nov 2025 16:11:55 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b746923cbasm1421935173.33.2025.11.06.16.11.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 16:11:54 -0800 (PST)
Message-ID: <c64985f5-f1e5-4880-876d-0a3c9d83629c@linuxfoundation.org>
Date: Thu, 6 Nov 2025 17:11:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: vimc: add RGB/YUV input entity implementation
To: opensource india <opensource206@gmail.com>
Cc: kieran.bingham@ideasonboard.com, mchehab@kernel.org,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251101052651.6197-1-opensource206@gmail.com>
 <959ac74b-a8b7-4d4e-9d34-3b3d971f9f8a@linuxfoundation.org>
 <CAKPKb8-nFzqgh+k3aBxUvZ8g28usiAt5BEdFDQysVnCk3S+sEg@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAKPKb8-nFzqgh+k3aBxUvZ8g28usiAt5BEdFDQysVnCk3S+sEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/5/25 22:03, opensource india wrote:
> Hi Shuah,
> 
> On Wed, Nov 5, 2025 at 10:43 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 10/31/25 23:26, Pavan Bobba wrote:
>>> Introduce a new vimc-input entity to simulate a color frame source in the
>>> Virtual Media Controller (VIMC) pipeline. This entity outputs RGB888 frames
>>> and allows testing of pipelines that start from a pre-processed RGB/YUV
>>> source instead of a raw Bayer sensor.
>>>
>>> The patch adds vimc-input.c with basic pad operations for format
>>> enumeration, get/set, and stream enable/disable handlers. The entity is
>>> registered in the VIMC core configuration, replacing the previous temporary
>>> use of vimc-sensor. Frame generation is not yet implemented and remains a
>>> TODO for future work.
>>>
>>> This change enables link validation and format negotiation for the
>>> RGB/YUV input path, paving the way for software frame injection and
>>> test-pattern generation.
>>>
>>> Signed-off-by: Pavan Bobba <opensource206@gmail.com>
>>
>> I see 4 patches - are they dependent then gerenrate a sries
>> with cover letter explaining the changes you are making.
>>
>> thanks,
>> -- Shuah
> 
> even though all 4 patches are part of vimc driver,
> these are independent patches

Independent in the sense that they can be applied and tested
independently?

thanks,
-- Shuah


