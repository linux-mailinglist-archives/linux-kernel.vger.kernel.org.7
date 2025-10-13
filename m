Return-Path: <linux-kernel+bounces-851108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 853B5BD5900
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 642D53A81BA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348FC238176;
	Mon, 13 Oct 2025 17:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="SqHb8g6I"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2620C19CCF5
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 17:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377274; cv=none; b=tJjllea3Y9LtbgUYvsCWZtTsuYhd1j0UTtscvyuw9VHTKmA8hoELeTnU0MEqcPOCjxPJqnXujuueq/9pRhuigNle6sTgaMG9GPAvIlWLYJA7pAvXQfHDVWKWtd/8zIwCHUHrWdUfTMLZ08TBJErapX6phvjO4DC9/6MDMSLrU2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377274; c=relaxed/simple;
	bh=94egnTRdgLc30wdtlVSvU7tat0yXpqCx45KEvuUD7wI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhrHPC8Qs1Hvl5NtUWtpYhXvhV7lH93YPmJyqbf/ZmNYsnBjV6j4g2BAN9d2Wu1oudTtL9IXVTDLJw4aIXtHBSSKNO8QZrdXPhUfBN+bpcqXGu8wgySaPXjCYpe7o0yCuwVt6XvuOkDli0bgEf9mTzd1Lldu2j4vq0UJO7rYq0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=SqHb8g6I; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-93ba2eb817aso451196539f.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1760377272; x=1760982072; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UltuTfLMWFwExhawJAiiHDqM2t3dFAy15foosSKHKoI=;
        b=SqHb8g6IHYPewx+ScxjYTRkkxkp1SalWwNZ0S6e6udUNu6W0gP5aZBf6VF7jO13oRv
         7Zy0cMbIwdZTWL/g3oGM4nJLmGqbzWZAUCbkp1uZuxbPJPtslYlNRXxNTcYSMIwCC95l
         NiN/og5jaRCrhe7R4LmlzP+qqwCEXBynCkbmU2QJLHqQ9CQXxoKRaVRimNSweUaKiG26
         lMv/H8q+Zhvynu0RN+0rpQQQFFY/7zKd9lPoROfJ5fHwm2OhYt9Ez/dYQxdsRRswJuh3
         vtFTS999VfW5VbXwmKRjEPPttLBZZkF4VU6dF/dsC2N23hY1ro7MLrsUWTS3AvqiaGIH
         0SIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760377272; x=1760982072;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UltuTfLMWFwExhawJAiiHDqM2t3dFAy15foosSKHKoI=;
        b=bnqHPgG/Ka8qdrwNQggRCw+3RB6VuK19s7k6VeQSJaeVPaTDzdQWJf3wZe7dZYFrW+
         F85xpZHaloOH4bKBhuXhcGeSjc5UUZv/6O2MoOzcRBcJEEwAkGVQA3Bx1mGjCQHfBkb2
         bhh9hRcfqI4przl+Mlt/DcqHWipUfZlXYhuxi1XNr+vzhB3r4IEpusNpmp96kltBhBjs
         MInw+Np+TUIsGctS4fzRDjBkQw3+GCCAL/+Y/tz21tqPZl30HZ4aNztyISFLXMTuaqOj
         kkUiO5MaT1Y5xbKSKsOCzx+0nvUSHLX8xIrNBoV7C+NWVeGJbrai6cyrqvkJewZfyk0q
         cd0g==
X-Forwarded-Encrypted: i=1; AJvYcCX7+YhXGB5OSVY+7Xssc7DKZgoGEPAaWJdDm/tnsLpIWFi1+ey5RavheI66ox6INk1UE+6vN855wTBW/e0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyclP1bmO9/SVBG3IwtdvSZHtrBpJ6UpQakhnFEisVPI7JKsvIp
	fcCP1NThg2jvNzdazgTIeUbZAAxQjDaEO5Tbras2HS0hkly1caXqMFAF3EH5USHNbfM=
X-Gm-Gg: ASbGncvpszJ9SA4d0l7oV9u8iXggVFtTT6mO4+yKYi6+fUNZ8H/Ys3NzEXVL2CFyngZ
	PsSCX1VWw7qzYY6BbAS/VxQ1twvYIAqex8ElDVMQR6CUlSsjHM67sfCNklqy6O428MS1mfr3KcL
	kuEZlcHjSJ56tnE+nOnFeQUuMVu4wftymCBoNFUj/FC9rRzX928iDW9nO+zMoyVNtPVMFwJQDkN
	DAuKCBJfuatK2LMURec52XpFhnTN3UkROLgjiAm65vHMB3TNkp4Hj7a3Q613zbjgxq8P6dfQaeP
	HOHHQeVHsq8BvGrywAL1aOCJS/4fooZOxCud6iQYxQKL22T+M+vH4HPQFZK1HZwINj3Dk57KRr4
	kKjH6qlNgH0QtMp4hjLic6nze8+TyxcdZexPYSreHTHU=
X-Google-Smtp-Source: AGHT+IGksZJATtR9dICb9YFDLoYCnIOn9SbEaI89/f+xN2pNKg219Slp1yc0ndJtssXs/Ex7tkdSVw==
X-Received: by 2002:a05:6602:740e:b0:887:638a:29b5 with SMTP id ca18e2360f4ac-93bd1975876mr2285945239f.9.1760377272238;
        Mon, 13 Oct 2025 10:41:12 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-58f729ce111sm3807015173.58.2025.10.13.10.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 10:41:11 -0700 (PDT)
Date: Mon, 13 Oct 2025 12:41:11 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Yao Zihong <zihong.plct@isrc.iscas.ac.cn>
Cc: alex@ghiti.fr, alexghiti@rivosinc.com, aou@eecs.berkeley.edu, 
	cleger@rivosinc.com, evan@rivosinc.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, palmer@dabbelt.com, 
	pjw@kernel.org, samuel.holland@sifive.com, shuah@kernel.org, 
	zhangyin2018@iscas.ac.cn, zihongyao@outlook.com
Subject: Re: [PATCH v2 4/4] selftests/riscv: Add Zicbop prefetch test
Message-ID: <20251013-b0cf6d4c5952c56cd489eca9@orel>
References: <20251009-49032bae395a1c26cbe80928@orel>
 <20251013161645.29357-1-zihong.plct@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251013161645.29357-1-zihong.plct@isrc.iscas.ac.cn>

On Tue, Oct 14, 2025 at 12:16:41AM +0800, Yao Zihong wrote:
> Thanks for the review, I’ll fix those issues in the next revision.
> 
> Also, do you think it’s worth renaming cbo.c to something more generic
> (like zicbo.c), or should I keep the current name for consistency?

The cbo (cache-block operations) name represents all the cbo.*
instructions and all the prefetch.* instructions, just as section 2.2
"Cache-Block Operations" of the CMO spec introduces all of them under
the same heading.

Thanks,
drew

