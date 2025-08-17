Return-Path: <linux-kernel+bounces-772529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0CEB293C1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 17:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E88FE4830F9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 15:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4192D1B4233;
	Sun, 17 Aug 2025 15:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqfWHtay"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BFD15C15F
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755443351; cv=none; b=ROJYatD+37/oFI3GUQ20ShQbDh3vHQ4RhF5b0xeAdokCEs/DXlli/qsYYkGWQKR60ofaKfaAnkyVzBYU2ZaljWwLunJZeJUqVUv2YbX2zVkdGHV4ORfTJXwxyravOwGfCK47gEhsXO9nOd452rF1YT5YFv7/1puqIR50jgLqqgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755443351; c=relaxed/simple;
	bh=A+ebz8HvhohbyIH0WxRixTEhJi4dP1u8s4AcGRkso4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Up++b6zKqgtaEaSMsCPSzUSSLwyEv8GJUDl2yHK0ip4G9qwecE8gqjWKjxGWlT1UEW+sQrF5uSxLQuD1Jb1VEd+8E4mKD5xYZQHNkMfxPdRob7j0uMdE2eXXxce3ts8WeAjFwygErvmrmJm5vyKmZhPvmsWyzCrCr0KS7+v6d7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqfWHtay; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2445806c2ddso28492275ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 08:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755443349; x=1756048149; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=dcVwe3CS6ABxD26girNqbnXaPdVU4nYkaZaeprxQO44=;
        b=mqfWHtayO21US7Rybm2jk0HU8hPzEN8GJAaTSWQa365vj9CyBL9Apd4s6WCAP7kuOk
         865Ra0CJrUradzZ3bqayKpmwM9ovhYna63uTtUVVHXuP80BC9+7s1kDqwSNHXnTw586I
         CpJXpvPoCVYtMqaaTPR7xxHfSZSKeRtgjexl2pe/alxJT7QV+IoZqriFHFFXdKm1jlAJ
         UDuUM+/yYzlOMwKN8O0Zx2wSE/weOtHWV+7NicP4ZDYQv/mRsXVgDk551sVS9l36owlv
         ntoXnANlzXkcSUi3WTJJXh+F8Y9F2h+ypbhE34gXlBEHzpYCe56RCbkC1S4a3ChyjLwZ
         hDTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755443349; x=1756048149;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dcVwe3CS6ABxD26girNqbnXaPdVU4nYkaZaeprxQO44=;
        b=nz8/axgtDXM65xk2EIDSak4ge5g1OhSmPSrFPLQRpkCma243R9r4FtHKUY5MgKmp1q
         7OqyRLc/d/9JCGAzaK6JAkIE3OEdBIILNJK5T5vFxwGpMih7P+7JF+2i20/cMaSVvwXl
         2SBIhnBv0PYQsExmqPS4HlLWSJ15lKYgCvIa2sk2d2FZlkzf35rBAEnWvoRYrFbL76bV
         4AEMTMbVZxi3jR3o0r8HGeOzUMcabM5kQyx22pWIyPjcszJSfiMYED6Fp+H//GhRGjGo
         lxXrskZ1nxMOibYQLRXvT9wKP6Gle8aLNxhW+3oJ+frATkhxYchWx4307ryk1jJJ/i6P
         a2Xw==
X-Gm-Message-State: AOJu0Yz5F5JNGYhpvxeGZx8t2oNnb7+lkTm6c2YeQFfADNOQN632EXj4
	sTmaK2PGeh+wT0k5z2FBK7tv1Hz4iNg3pcEz65QqgsTl8NkPyqr/w4bN
X-Gm-Gg: ASbGncsCJ0qi8h67HJtrHtOtGqIrtScVsoJ6c6INrjfL05zYdU1lUH1Tycd0kE/xxhs
	WvF95Nx0G3VfqapMVN5jvcVTBRYxx9ewBgZ++rkYX8Vyt6V5XwTrx6FXPibc2TEPz2kAfJSPKdp
	mOgg3QoK/XaCKwkP2w4LCNw2DViJYBCCcAIKQefIcG3bnaGcDqjX0ghRFC786d2c6hlDvzccB4c
	rUKAlITC1ZFEZD7vAWcPtVFNwGZMVNVb8J10CogC1ke4H0Ian1Qveo+llhFfOnwgY3436gCvb6W
	QeplXCtknHW2L7AamMuMo/qgjhc79gL1pfsZhHU7eKKsegwCgvrybQX96yjGZbsZiluDGMZYkmq
	5w+Ti+ewQn7L6eZSpkACAFDLLLjRzvUrmxvYtUSTgKQ2qEymNR+FzUW0StKEqHpJ8jYOShSa2Xt
	zZ8tP+7A==
X-Google-Smtp-Source: AGHT+IHeM26Cv/RPxpMZKlAet1+evoONWlAKkOfkLcLynIzVttuLeaBqoVGPG207tmiOPGamer0bkA==
X-Received: by 2002:a17:903:384b:b0:240:678c:d2b7 with SMTP id d9443c01a7336-2446d72d0c9mr128903795ad.15.1755443349009;
        Sun, 17 Aug 2025 08:09:09 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d50f336sm57160065ad.77.2025.08.17.08.09.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Aug 2025 08:09:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b4cf04ea-d398-473f-bf11-d36643aa50dd@roeck-us.net>
Date: Sun, 17 Aug 2025 08:09:07 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] genirq/test: Fix depth tests on architectures with
 NOREQUEST by default.
To: David Gow <davidgow@google.com>, Brian Norris <briannorris@chromium.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com
References: <20250816094528.3560222-2-davidgow@google.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250816094528.3560222-2-davidgow@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/16/25 02:45, David Gow wrote:
> The new irq KUnit tests fail on some architectures (notably PowerPC and
> 32-bit ARM), as the request_irq() call fails due to the
> ARCH_IRQ_INIT_FLAGS containing IRQ_NOREQUEST, yielding the following
> errors:
> [10:17:45]     # irq_free_disabled_test: EXPECTATION FAILED at kernel/irq/irq_test.c:88
> [10:17:45]     Expected ret == 0, but
> [10:17:45]         ret == -22 (0xffffffffffffffea)
> [10:17:45]     # irq_free_disabled_test: EXPECTATION FAILED at kernel/irq/irq_test.c:90
> [10:17:45]     Expected desc->depth == 0, but
> [10:17:45]         desc->depth == 1 (0x1)
> [10:17:45]     # irq_free_disabled_test: EXPECTATION FAILED at kernel/irq/irq_test.c:93
> [10:17:45]     Expected desc->depth == 1, but
> [10:17:45]         desc->depth == 2 (0x2)
> 
> If we clear IRQ_NOREQUEST from the desc, these tests now pass on arm and
> powerpc.
> 
> Fixes: 66067c3c8a1e ("genirq: Add kunit tests for depth counts")
> Signed-off-by: David Gow <davidgow@google.com>

This doesn't completely fix the problems with the code, but it is a start.

From:

Unit test results:
	pass: 640019 fail: 652

to:

Unit test results:
	pass: 640559 fail: 114

Above tests now pass for most architectures/platforms, so

Tested-by: Guenter Roeck <linux@roeck-us.net>

Detailed test results are at https://kerneltests.org/builders in the "testing"
column in case anyone wants to have a look.

Guenter


