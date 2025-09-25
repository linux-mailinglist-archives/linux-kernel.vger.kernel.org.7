Return-Path: <linux-kernel+bounces-832320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54765B9EE7C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0066D38541F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57842F8BC6;
	Thu, 25 Sep 2025 11:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="BO2bFX3O"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF762F7ACE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758799763; cv=none; b=sXFqBKiZqQLTWQMQRgR2PmGTa6aPRjj9nnCUBot09raeICDBaCWa04RMfXG9SHBb8CCwKc6Tdvh4u28ZipZ+T94lXu7mjTDbcsezHk2DM7/dBxRFmRjrwRspcCSlBTzWM2pZt/AeHAUoY2ssQoWK9Yyhl9kFS9oDJio0E0Il/VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758799763; c=relaxed/simple;
	bh=N4eb4ivmGU3+zSAOaLguUis7kF3GWbFjQPyW/QLtbVE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=FMwr797xnv1pRPC4mf5Z0TWe0SmfjSxmByVcjDakcCM93RZrVZ/nwGBIX0tlvPthztXy95WRHcrAlO8SP4FlSyAOvsdlCL46EvDkCpgFqO1et+71NGstvoGuBtkxrKhTtHPeWdLqvE7to1kliFSKXylksrknYg+KoyoXEoBScA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=citrix.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=BO2bFX3O; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e317bc647so5834175e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 04:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1758799760; x=1759404560; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/QqSgSXAv1zJap9Vi/qpQS5Qzz4ZHVJdj7cYYe5fWEc=;
        b=BO2bFX3OUmiRZEyq0Pe64ST2ZyhexGiul6e7+J4tlo6lqsFnyihEkqNyHg8KCKBvdu
         AF7JIEJ/1BjjaFc2gGSRdNmCY/WtnWRB6Pde/JQhOwQSWyNShmerrujR2WnCQZKd9NuD
         WtOVj1Dy6zd2F0IU2405o4qzaJOd6ojwnfHoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758799760; x=1759404560;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/QqSgSXAv1zJap9Vi/qpQS5Qzz4ZHVJdj7cYYe5fWEc=;
        b=JzC3yW9FBdcoBwKYev1/qtoIlW4F7s9rPn5yqYlX+DTQWSM1Vthv5W1nYR0x9kbSES
         WjcE2WEIeI5UZ7aTvRUYwWGVP2PcfLrqb9cc3Fe9Tecd2VTjD18Vws36PpLMJwoYzHFw
         pfsj2v08A1q4o1xgjNChN1/s1lhE6jedCxrwRaDRyJzFtKOV3Ym88lVR9qWK4OQUEZDi
         84tcUJ7UDpfHODg+GRvuASQUmm145rSmJLsoMJ0VmTEPs6uaWv6TpemXxulLe3rZxdNA
         SPqUMlykb5cQAfiNGSKmL9PzzG134NqMQ40ucLzsyB/TQsS+y6IypFCclYWU8rdYD/Oh
         8QXw==
X-Forwarded-Encrypted: i=1; AJvYcCWDrg8xigQvr7Ilt+WBe8AnH4uIBdz5u+zt36rWIExoCJ00Z+FYaukyQDI8Ty/PDNF8553duDC/tufnY8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx437IUwGK9IoiSPx3TXzKL/twNkaYjrvu0BcA5Zf2ADk/kds+l
	Is9GoZ1s3DNIWwSxaU1fDlx6zbWRkct0uLNUPNU0Zr9rN924OftbWZ7D+kxm3AcAhKw=
X-Gm-Gg: ASbGncsRWYuoOOPmW9fe/sxpNnShCJ7CCBrx6eA3UJ5FNiVeOROaMCeq+Jdqy7nZvaF
	ztw/HuYxBVrM70XcnLgXkID3i/Augo1up4tYKpdT5pHBet/yOZSdW3v2Ro42cmP5Ob9T19MKYsp
	i7CcXUAHD/YaeZTjuHxhzeq53jFJ0AQyVGEdjEB5zmSelMUj6j+o+m52zD8eEOifwIZQ4efs5ue
	rAaqjFjTiZGv+C94kNg64rfledfr2sJGA46UJ9lZY0s3pdiAm6YvFBT6rN7YKVlaqsEK0nJ+6DR
	SlRku2KjMKxFGPNxNGCtgxmTfYudg11hR66mI4ok2bDdtRb4dyThAieOMBbmP2h6LDFg1qRM6kR
	RHpz4iQEe+cMRWRltrZ0GuSN2NRAaBQjuSKpzBiQDgnXOkp7EH2DHfIZAT3wSfpWEDDPR
X-Google-Smtp-Source: AGHT+IHge0s3ENO9hXY4jtmVnktkVDEoCmSrCOlJG/8t/OJbeLunduZZ8YtR9kYMBs3+Gab25eMfPw==
X-Received: by 2002:a05:600c:8a1b:20b0:45b:43cc:e558 with SMTP id 5b1f17b1804b1-46e32a185f0mr25214145e9.35.1758799759650;
        Thu, 25 Sep 2025 04:29:19 -0700 (PDT)
Received: from [192.168.1.183] (host-195-149-20-212.as13285.net. [195.149.20.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33bede2csm29692415e9.17.2025.09.25.04.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 04:29:19 -0700 (PDT)
Message-ID: <a2f6775f-0be5-401b-bc01-effd3f428482@citrix.com>
Date: Thu, 25 Sep 2025 12:29:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: peterz@infradead.org
Cc: alexandre.chartre@oracle.com, jpoimboe@kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org
References: <20250925104251.GZ4067720@noisy.programming.kicks-ass.net>
Subject: Re: [PATCH 3/3] objtool/x86: Fix NOP decode
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20250925104251.GZ4067720@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> I've made that:
>
> 	case 0x90:                                                                                                                                                                                                                        
> 		if (rex_b) /* XCHG %r8, %rax */ 
> 			break; 
>
> 		if (prefix == 0xf3) /* REP NOP := PAUSE */ 
> 			break; 
>
> 		insn->type = INSN_NOP; 
> 		break;

Legacy prefixes can come in any order.  What is F3 66 90 ?

Also, VEX/EVEX/REX2 want excluding too, all of which can encode rex_b
differently.

Is it really only rex_b which prevents NOP becoming a pause, or is it
any REX prefix?  I would have thought it was any REX prefix.

~Andrew


