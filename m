Return-Path: <linux-kernel+bounces-883455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFBCC2D7EF
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 18:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F1F74E462F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 17:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362E931B81A;
	Mon,  3 Nov 2025 17:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQFg2V5Y"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D2B21E0BB
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 17:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762191447; cv=none; b=C/NlC7Oq03bG+unFAbUGr1L/o9aO8P3LHK8E1uM4DtsXsjNXltF50Y4AbvuMWkhozprBdiBlufpCKIkZ8XJbeL1MbsQJkZ9pXiP2CEPsFW7bX0e2qZO72hex0pxHahFt9x5XT2a8Q4g4l/zVejk7qspzvjUTjvCUrZS+JNXDhoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762191447; c=relaxed/simple;
	bh=XbRkkU/y+WXWuRuCcmwKBN7yxN8eo0c4Ja83KHz78Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ysvw8PCs7OP+b16qbvK8B1TuJzfX17UF/DgCq0MEMv88xyfWr5dbJ6HEbf1yBIjBVvTdWxzYIFFetytaTPATorilH7qzxiUsh5x/FqyAUoU0GiwyUWo+wbUYkjB+hRSZjMhRxKKGfBpc6HB2no85A+xiDD00eOZ8eRG6QRejEH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQFg2V5Y; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b7200568b13so38964766b.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 09:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762191444; x=1762796244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xv2TUizFlKHrEoEkI9C+SG7QzMAufZsMKxgTYMKXnw=;
        b=nQFg2V5YuXhssjYkat9ydQy4WgBH8JETvYAksJGOVvMcIks3POkeTua6FyqGkxiqN9
         s2H4py/bYoVpPK+flmGWwju94PApbIacP8Xq36jZVUGjeIUOz/i2DzMM4j4otvjc1PMx
         Bamfhzd8QR8lnMRx29DqVPWrPW/+JCo4aY3zHNb9fMkM8SVP5u+QP8tg+6HHlPsfUjdg
         N3eLHe/vtNC7bEaSfDXIGLipfpCSzqMPNMGwUTGk4rjpJHro/iQHdAqnRauWlsMpwQOG
         ww7QuJ7PFKq1UDGR9xU3HlzRHf1sDUf4av3rsXdmNTaCIeziajCWm3syMnpimmiWjrGa
         mCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762191444; x=1762796244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xv2TUizFlKHrEoEkI9C+SG7QzMAufZsMKxgTYMKXnw=;
        b=F590Hphg5ZNG5mGsGStWRB221fPx6iMcggY/e6oLy+XYHPJpMN1rkkqe7KJmDSi0wT
         zeos9InIUAkhhQCs7t7fauS1+8TVfqYhUh2pNlDataG9/P3tTsKs4DPxEgsYVvlKt1Gt
         Xq2KcZZcWnOUZKk+1FPGy8YuzjkYxXFKSA2uINet4257G0jSOhaAtN1NFum5/zPVEoHO
         jELkolWsBDjqE4MyphZwkEsB0iwR/pblwsP/S7tSe6Dfad5qFXtutRYZg0lXF0to7czR
         TS7OkiJbQcS7eCYJKzHfjzgvp4seOQvCwVL1Em3kkc57iZkLJJNGyI+c1HzPpE7X/kqZ
         kHMw==
X-Forwarded-Encrypted: i=1; AJvYcCU+kICkWpU/WfZ170a2uqVFArfsE3fdTFz45LVDU34UBoAVeMRy714AbKcNjdpAHt/vGCziLEwStll4yog=@vger.kernel.org
X-Gm-Message-State: AOJu0YynZJaRENW6lULrBum4XCdUvdw0iU+F9KeBnImdBSatlaV56gUD
	3jhtZudgrEqid3GdpO5cnFgcl+Ak4fxrK6emtxd2tHQh/aU9QEF5lume
X-Gm-Gg: ASbGnctzuPPggaJLNpj3R/z4HP3ptnbmVSAdrg0BOput1RmyC06dcHP64drsVSvwtdS
	kXIBf0YrC2DepTEUIDukTR40hfCKSxajOCH2K9NagVH/Twk21spi+Cz33Ycwrh/mOuR7sHCiP06
	wL1LFefmhinknN0yHEMQ2N8itLLEQkxtBp1CuBdqci+grG+J2YqPevVVB0G3EaI+qLyDj8/5Nne
	3jepc8vNTHIxgcOHud9xr7w5pl95KxcMBUl1e8smgCOP7V3Nr9rE8GEg/rGMN4eHvDOlKzPdEtr
	eToQCH2fw43BYofOAUulieMV3AoazxAW9G/TRMrG+HmAIyPmt5PPiKl14/KBWZslY6DU0ngCPGJ
	FDF/4UWNGaO1wnkDecLnDnfQQ8S5zrzl1w8ML84VBt/E8CBw4q1XwvQqIYjDL07F4kUBeHJbluO
	AaAwvPsu768L9u
X-Google-Smtp-Source: AGHT+IHk868j9a9wb2OAGpqZlWfOedq09o6IrtN/LlLShyla2ph8C3h2GPaP3U2BeMZDni3GJkgNbg==
X-Received: by 2002:a17:907:9448:b0:b4b:caf9:8cc4 with SMTP id a640c23a62f3a-b707012901dmr1383853666b.15.1762191444213;
        Mon, 03 Nov 2025 09:37:24 -0800 (PST)
Received: from foxbook (bgu110.neoplus.adsl.tpnet.pl. [83.28.84.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b70acf84c51sm573083166b.30.2025.11.03.09.37.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 03 Nov 2025 09:37:19 -0800 (PST)
Date: Mon, 3 Nov 2025 18:37:13 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: bp@alien8.de, da.gomez@samsung.com, dave.hansen@linux.intel.com,
 hpa@zytor.com, jpoimboe@kernel.org, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, mcgrof@kernel.org, mingo@redhat.com,
 paulmck@kernel.org, peterz@infradead.org, petr.pavlu@suse.com,
 samitolvanen@google.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: [PATCH v3 22/28] x86: Use RCU in all users of
 __module_address().
Message-ID: <20251103182917.74ecb8a6.michal.pecio@gmail.com>
In-Reply-To: <20251103113750.qam3KIkT@linutronix.de>
References: <20250108090457.512198-23-bigeasy@linutronix.de>
	<20251103110835.1dca378c.michal.pecio@gmail.com>
	<20251103103434.D6m23Iud@linutronix.de>
	<20251103113907.4e647f33.michal.pecio@gmail.com>
	<20251103113750.qam3KIkT@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Nov 2025 12:37:50 +0100, Sebastian Andrzej Siewior wrote:
> Now, get_stack_info() where the warning originates: It starts with a
> check to see if the stack pointer belongs to the current task's stack
> frame which it does not. Then it checks if the task found is the
> currently running task. That it does. So in that case, we must be
> serving an exception (such as an IRQ) because the stack does not
> belong to the current task.  However preemption is not disabled which
> indicates that we do not do this.
> This in turn suggests that nvidia replaced the stack from while
> entering the syscall probably in _nv003168kms() or the binary blob
> which invokes the kernel function does not have a proper ORC entry
> which leads to a wrong turn in the process.

OK, I see, preemption should only be enabled in the first case, so
others are free to assume it's disabled. No bug.

Thank you.

