Return-Path: <linux-kernel+bounces-801876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A17B44B08
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 02:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C8451C264DE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862A51D88D0;
	Fri,  5 Sep 2025 00:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A41k/Grc"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC16194A6C;
	Fri,  5 Sep 2025 00:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757033892; cv=none; b=KaNIgakTPP2GBuHBRrDPSLJ1iExIHMZeUpku3X4vR4RIcJBAeNYgOm7WJZJvrZBwZPORcb9Qm7h00I0erLHBxqTgRZpMqXwb2PNYEKdbxVe/q976B0gg9q6dHE7HTjn3JoElv2aYQzuVddGMw7WomdgI3raW8zZP+ZgsNf+3hpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757033892; c=relaxed/simple;
	bh=xbk8pyvLrP0pm05hmTCr/Mh88tw39MoGoO5XwLk87Yg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pI+EQ/NGBzbqXVN6lZRRxGYHTfDvfd6Lwc0C+AcXZ7giP7ntI7S4KYiBnz9k5eaqjcsasXOrOGlGQOfUg8cHJ5SMNbiZnBn9R0jmk5s6jSDYG2C5/1KmIn87o9fjOVkz+m1sYB2m0bwDeA2Hyx4fqZv5BcqVtjJ27kT/coLH1uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A41k/Grc; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-77256e75eacso1515240b3a.0;
        Thu, 04 Sep 2025 17:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757033891; x=1757638691; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bkqYPu8rOaY/q+A6P2O2P33O5z9aUpMhuyOs4Z4WjeM=;
        b=A41k/GrcWFsNbki0ijFu1tvG09gG6YDEyhNu/vF1jnaiBHayypJpnQ+b9lQ/mo+D0s
         F4wpFLrDJU5PF8LB4YdAKO9XvC+1A/UhpyBtXaeTefW+xrDFsTleuFKBlQt9FJy0tL5m
         K2/90OBFbrJVwSAgWMIHb4GpP5yeUvpuOl/yxArEhIH0onFU/fsP4ytBiGESH4y8awrZ
         1oPy7t3J8vVFa8Vr5fTMG6t7aEux22SLQaPmQWdJCN69O04KTEIT8f8XaOpOgLvkwhKB
         39bPUQq6Q0L/PY2vwS0OcKG+8Ptsd+VraFFB30OnUNo6aJWsDMUUJ8HHlk6fOd/Cfx2u
         7ksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757033891; x=1757638691;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bkqYPu8rOaY/q+A6P2O2P33O5z9aUpMhuyOs4Z4WjeM=;
        b=NendRrMo0fGROM2b+AXZsm/slH0X1Lbq1RwqUO8u8f7704ZyH98Lt/KDDP6nTWp7mF
         BhE1dicqdvGDaOduiEqG84750/Gv5t0kNMS5tTcanXUBbPOXcktaK2rKeDD/4wTWqfJz
         n2WiF53bHfuJoBDlZbkkZqC467mwKdPg/88DmXgvv/EvUrJINBPmcJNAD07m262E1JUo
         5ObT+9/Wz1+WY5coitm19IhZv2MxBJDXIifT/AmXgdQsBN3w06wPdhgnAC5pFWVhaD4f
         urS92moHVzFHRnHyp7QUnN6P4o5eVclXFVilHczF4BS2vMIzAjuBp9tdGAUuDtFVO63u
         1UYw==
X-Forwarded-Encrypted: i=1; AJvYcCVtUZxkiJc9SPR9n50vJ4qH+IN5opKblScOjhj0aSakGXy1AeP3+7Hmbg3KA+UKBZB0dBIcmhL+i5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqWUw5k2/r7jJGR0iSut4QqGizKYVOKwqMmrYPH4Xfky2BBK9X
	Z/psyhldRgYzSmgzh4m5v/toiBqplMGZX5kBDuPxBK/RXvc28txOqngQ
X-Gm-Gg: ASbGnctylD0oYfR0AUQBOenVV4e44+StZwTZlcx4GRoQCbmXCWfQm6YAVGNCJjsjwHg
	9AexkHKgfCQtGVpkLw8QiJqG1ej41pnmIKWlNdDgEKuGEnQKKrqlT2aqf8XpShicxGudb5ELfJq
	wd9nBjlOoSrabiN/rObu4sUfMiBaDF+17INnEHmthU7BDu0H4LtoYEJVXnOOj/9Fe4uUq0y671l
	/z/ihGLLlahjU7iKQLQc8a84P5gseIxdt15K8e+P+9hfspmhqg6BxM52Ixm+MlDfsP1jhRGgT+V
	8a82DWINKR+eIvY+PLXTj2GTNt8CmamoBxfl0Dwjrt2XJQdYPGzTt6CNI2oup8gJpc/M6ZRaUql
	tf7GAurXedF1hAZ7hnXoXr0YKRnkSdxvupNZxeFnd4Hw6P+eYBuaaRALISvb86QyavBMK
X-Google-Smtp-Source: AGHT+IGzrKwwsHQdYbXSgoPw+uethUqjKei1Bx4Pwg+bX1Lce60YWjP3PTtlYHqN9FPJ7CVOBqQhNg==
X-Received: by 2002:a05:6a00:2d99:b0:772:2f06:3325 with SMTP id d2e1a72fcca58-7723e308b0amr28277605b3a.17.1757033890494;
        Thu, 04 Sep 2025 17:58:10 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77256a0f916sm13511746b3a.63.2025.09.04.17.58.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 17:58:10 -0700 (PDT)
Message-ID: <2955d7de-71a8-4767-914d-23e8d9f63971@gmail.com>
Date: Fri, 5 Sep 2025 09:58:06 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: ja_JP: Update SubmittingPatches for 'Fixes:' tag
To: Jonathan Corbet <corbet@lwn.net>, kurita <akito5623@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250903113552.2010371-1-akito5623@gmail.com>
 <878qiunyhu.fsf@trenco.lwn.net>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <878qiunyhu.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Thu, 04 Sep 2025 07:22:37 -0600, Jonathan Corbet wrote:
> kurita <akito5623@gmail.com> writes:
> 
>> The Japanese translation of SubmittingPatches is based on an old
>> kernel version (2.6.39) and is missing several new sections.
>>
>> This patch adds the missing description for the 'Fixes:' tag to
>> bring the document more in line with the current English original
>> (Documentation/process/submitting-patches.rst).
>>
>> Signed-off-by:Akiyoshi kurita <akito5623@gmail.com>
>> ---
>>  Documentation/translations/ja_JP/SubmittingPatches | 4 ++++
>>  1 file changed, 4 insertions(+)
> 
> So I only saw this because of Akira's response; something in how you are
> sending your mail drives SpamAssassin nuts.

It didn't make my Gmail's inbox nor spam folder either.
I only spotted it at the lore archive.

Akiyoshi, I see you have submitted other two versions of this patch already,
but both of them failed to make my inbox.

Your email message at the lore archive has these in its header:

ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=www.redadmin.org; arc=pass smtp.client-ip=49.212.207.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=www.redadmin.org

The mail-list is probably generous and accepted it.
But Gmail is getting very strict these days.

I'm not going to review your patches until you fix whatever issue
on your (or your ISP?) side.

> 
> Thank you for working to improve our documentation!
> 
> In addition to everything Akira said, I must express a bit of worry
> about updating this document piecemeal in this way.  Backporting
> specific pieces in this way will yield a result that is not a
> translation of anything - it is a new creation that never existed in the
> original form.
> 
> It sure would be nicer (says the guy who has no ability to do that work)
> to bring the translation as a whole current.

Jon, of course that's the ultimate goal.
And that was exactly I did in commit 991dabb24232 ("docs/ja_JP: Convert
SubmitChecklist into reST with belated updates").
I did it because the original check-list has only 137 lines and its
direct translation would have ended up in odd looking one from Japanese
speaker's POV.

Thanks,
Akira

> 
> I'll accept pieces with acks from people who can properly judge them,
> but I would prefer to just have a current translation.
> 
> Thanks,
> 
> jon


