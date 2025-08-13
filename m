Return-Path: <linux-kernel+bounces-767532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38436B255AA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 346041B64F6E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7127D3009D0;
	Wed, 13 Aug 2025 21:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="yq1icT55"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129C73009C1
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 21:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755120989; cv=none; b=l9tdu1NrBBnKvulGGN4VkL95p592+C1oAuFRMxazrJ8yS1r3EbarpEwjzS5yKTg/N8AQ4n73C0iGT+sRlKc/bTLCImmSgq2bkhYrRuTi4HjbmI2DM5dwGNC5NFrXn6PU+rRkPwQbAuTaFqQduzBWdYjGdkW/FBMTjo83jQzRgeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755120989; c=relaxed/simple;
	bh=KaKtP6/fQmuwkPhKN9njIATDmQm7QOAxxtfB251M0Jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AF5kxVS7ycI1jIltNXLqrHm1Lvvudy+PARiCNVE+DAOzZcqyQvpL0y7p+yTm5pvFDg+Sah4sOMgl1WAllYR2ItWTxe8Be9wORYeTwl2z6r6ijAsZcjVSaHAU5VM30A5vfH3dOI8+XnRzmpTu3EDawK5xmuVnZ95cXced4RsN9/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=yq1icT55; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24456f3f669so3896505ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 14:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1755120986; x=1755725786; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tr24kc6YMKoaJSfkaK1JwPBQsMe3qrp77b0BiixsD6M=;
        b=yq1icT55pBM1FWrUEypHLSg5NRNKPQcbG8ZxsDiWtWK/I5csRyWKzM+uCcSqbYqDCN
         0dcbPVuCI9d2RgyMVVq/81W2mtED9FGF21f6EibK/U5T4Oq1zJGr66pJKNe2TLgq3mnG
         IO0KL63+UxKh/kqaFUTKBr9m2TM9046y4toRCN9pjbLPbCnX1z4/b880oHt6YvbU4cl+
         Cd2nCwaEMyuhvg8mCL2FDP2WcCVREeyLag1u3HO3KUBbdEUh3MIdn4Mp03yFGnDhWUkQ
         jc2OKWzVzaX5om1fGx4Sg99NtTUxF93KZyIIPilmA6cyd8B5/HKAQYca8f+5HVFiuxcb
         0VoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755120986; x=1755725786;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tr24kc6YMKoaJSfkaK1JwPBQsMe3qrp77b0BiixsD6M=;
        b=xPLrBrpQHHvR9BKRLup4vZ3J4ZV2oGOWTU83odb5V8a3FpMfrP4S4altc20gWBmqRU
         PXFMQYe9RIdU/he9keVHHL8TmF6ZNr/oW5FPuKqhiEsl4+liJSxKyHHmQEKBRk44SdEu
         5DMHnUfLnwKeRvAm6dcbMpoYsecyOYoW/jwr9iOXbVsJUpgq3GiUY48WdCip0aPdpck5
         lgtdKVNuSt7bU/SM6yVSVZYGA+t1IkPOoFRs6saoow7l614Ewi4WXy6SotSZ19goJxjd
         pF6yyqdAqAy0XhlVGnPpgw+vEOTSIfPfB64oJjTISfC5/N/LWgYRG0QApUBv9PTmgr/J
         TMvg==
X-Forwarded-Encrypted: i=1; AJvYcCXybM5jJnR8asJCiOgAvTMNsPaibAcppn7mEqF9xpZD4lnkgn/CSWeqpbgXG7SMaFJ4q0tPyrfhTzj9SCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWNvLEKBdgCHqyqDjWS/i37mbIaQV7aRjvX553wEqkG0iQ4c//
	JskQzcL+ZEiLvG0zoUQ5VsWVDb3+y+8UG9YuiCo3tmRRLqq1sqjxcgc3tXEXUSKxbNA=
X-Gm-Gg: ASbGncuikk//AyQr+z/6dXYzq2jiny2C9Siw975Brah1zbBxyssOOJbOp7NvTsja/bZ
	m6TDN4cReKkWTgFvFAieb4a8e2RlrOblLFJeNIWcK+GAIrz9G03sspDU7kdKWx71/6yofDXSaba
	H8+c0VprMEYYV+FnxMKnV/Ogi2/3XeficxxXNxnCUmli9Bhw5XQgz9LFOVBySGHP5B/7WL4Hkkl
	HuVgLx0xXspBMJ+VTh/0EmqldSUNdSpBM2JvqD4SLqJgZVhczp92/sH3VfCnDt764xx30dltF/B
	+iEJrQtHg2RzXXka/jWFNp5X6avIFr6etTn/yXPUz0fH7a2W5xnmkV53d9WoHJH3jlWKot5Cx+F
	03tPDHf0IOE1825YpEF00
X-Google-Smtp-Source: AGHT+IGeDPbO8/HL+LTc/1kGTiBfE4mlGjodpPbpAi9x8Bs6k4nOjtcdGDm1ghZdsuLXoWwZFzayCg==
X-Received: by 2002:a17:902:e784:b0:240:1ed3:fc28 with SMTP id d9443c01a7336-24459b78603mr3300265ad.12.1755120986247;
        Wed, 13 Aug 2025 14:36:26 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aab53dsm333271255ad.170.2025.08.13.14.36.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 14:36:25 -0700 (PDT)
Message-ID: <6b428c1f-4118-4ede-8674-eceee96036c1@kernel.dk>
Date: Wed, 13 Aug 2025 15:36:24 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 00/11] rseq: Optimize exit to user space
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Wei Liu <wei.liu@kernel.org>
References: <20250813155941.014821755@linutronix.de>
 <12342355-b3fb-4e78-ad5b-dcfff1366ccf@kernel.dk> <87bjoi7vqx.ffs@tglx>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <87bjoi7vqx.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/25 3:32 PM, Thomas Gleixner wrote:
> On Wed, Aug 13 2025 at 11:45, Jens Axboe wrote:
>> On 8/13/25 10:29 AM, Thomas Gleixner wrote:
>>>
>>> suffered badly from the stale eventmask bits and the cleaned up version
>>> brought a whopping 25+% performance gain.
>>
>> Thanks for doing this work, it's been on my list to take a look at rseq
>> as it's quite the pig currently and enabled by default (with what I
>> assume is from a newer libc).
> 
> Yes, recent glibc uses it.
> 
> Could you give it a test ride to see whether this makes a difference in
> your environment?

Yep, I'll give a spin. Won't be before Monday as I'm out of town thu/fri
this week, just as a heads-up.

If I recall correct, I'd see rseq at 2-3% of overall CPU time last I
tested. I'll try and do some pre/post numbers for some of the stuff I
usually run.

-- 
Jens Axboe


