Return-Path: <linux-kernel+bounces-726013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E19B006A5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F376E7A7797
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4A62749C6;
	Thu, 10 Jul 2025 15:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TghXF2Vp"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E19F22E3FA
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752161396; cv=none; b=l0MzVmKShwu0KCZEnjv+2l9Xs/L/I/DxopB1ddSXIEz8Z0j4laTrUc1ik6DkmHPulpPcdRwrgVvXpRATivDbeXm1Rv1SsjknxKGaBwprjBurLajDcSXn12KmoLmObppu+IQTUgaR6k2AQWaa26MgS6B+kfKrwI8TsxHGpC+HGpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752161396; c=relaxed/simple;
	bh=uXJ+Su3o1PPVQEWJgsrtc7LhMk7UVVMuONL6hP2mVEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKYEg//Pg3WkL38c5vz+p3+wodzfcRwldco3Onflz+HAKp51ste/GDRS0dDDWNU18vns/Juw4kIaz/kD2EPPpBrQXP4NgkPdXACy69HdCD7EwtnJf3Gia9+vWdBL8JAlS0B3Ky/Y8V8bpi/t5s5H7JrWkbdUAvzEhaDXH0Kb4OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TghXF2Vp; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so1440961f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752161393; x=1752766193; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lSMS5g0FtH2qkHkZ1jt4pZS7KJcBgB7lox3WtRiFnhw=;
        b=TghXF2VpNrDmLhksrMjT1MBzMUWYHez4Nx2SFdab9OTP0Dk7QBwVTJ+DwO3Suvn7d5
         jZd3PFzoPLKeHKpeX+jnvfMDcbJTF/Y3DK+hE+A7FiBX0roZbRFrQOhnYYrNUbBNDo6P
         kg8uITPqaIPsepc9/6OAfHI9THkxH0ajKjabWr+RV9wa5WZwW9pWDxLSrZXNEfcGjy5F
         PPo43ZZ/9AEcAF34q9tkSmMNrnZYRMPnlRfVsj+lBy+hVzmiG0EKl3Rz0ZP0ykiL3cm/
         h2J5qoIWr3WdorgNfVlJCVTdOsB+o3jXrwvxV3Do4PaLv2gz8aPy3aMCugfMJ7lTv/Ah
         EccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752161393; x=1752766193;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lSMS5g0FtH2qkHkZ1jt4pZS7KJcBgB7lox3WtRiFnhw=;
        b=NTZCD7X72Zvrs4/xywDUZXlX1bgO0feUJwNz8oEcTSj7zKvzRG51r6UpDZt+Q7HyNB
         htS8Tj3bv+FwiukbhItEygLxdt+YFoQ/QQ8s4iPmxVXkQ8QuBhiqpoEo7rv9Lltc+QBI
         9zLZWb81WqXQEsJsogMB3y6ltpZ/LsSyq7vjHEcBP+EdhbqnJt9Y3cVfJIdzQjvNosEU
         jugJd12L+Le5XMutTX56P4kKolWW0sHnKZ7EcMlFEDrKT27T8Yk3l33QJp1UtsMyPwzm
         +OXjTgfMLp2yODZKAXZn4FYypMjXHP/Tz+6tSDVf08mZtETb5weaP/2K0QfpxIWJOUrr
         nDQw==
X-Forwarded-Encrypted: i=1; AJvYcCV5HL1b5jwIlYi6tqHXsy4FSnQiRd/dZn/Xp6gKZwQVkKan9QlPE6jR6Rs3ssxSu+jSGivoRXrqpDFtK6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZmnVlNUWE7H4cKSJ6JZZ4DnR2Y9LiPJSjmT3MTnE1bvgDdb0o
	Y8l/R2zQ5oQam1CS+vGxwcEH2QZte0NGXoIm/VU8l1Jy1ajcTv3KhoP2Isf31/zxmvs=
X-Gm-Gg: ASbGncvA0j0oBOqnXdizhUDCaPMbBdk+EPESKAZwbvkRb+vFclhSkM19BVzOw0X6pSZ
	CDvNxq/uyhZn01CIsd0eBBsE5iOJBXmMSnOvo8PIPE36WZnObXRHZe6MqXxS3c0IkMuOP2TkRFH
	6Qpm5r46kqBx/XeDkm8v4EVvj2iJjCeqnbBypQYLPkuF+gPquhYBHJfujIBHf53Qb9fhRx9bDHj
	TPIK/ciZCrr/KpCSDeV6PIwfIfKa17UcZGYTwJWNqkNtEPgPBQd3/ZF5wezjTsowIaMFP43xpO/
	oyMWmHYQyByRbZNjUD32ZCZZjYxRK/tWHIgus7RSIVrhC+Vmx2DMQCgs34ynhHz9tLGfi4SyZR0
	=
X-Google-Smtp-Source: AGHT+IGk8jb4Q5+TtKQe7i5KrsnU2L8JxV8a+7deRG1vITo0uj9HDseycRwujjfxpSFT3oO40oNjMw==
X-Received: by 2002:a5d:64e4:0:b0:3a4:e1f5:41f4 with SMTP id ffacd0b85a97d-3b5e7f2e929mr3675711f8f.17.1752161392588;
        Thu, 10 Jul 2025 08:29:52 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd5ac0sm2649648b3a.22.2025.07.10.08.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 08:29:52 -0700 (PDT)
Date: Thu, 10 Jul 2025 17:29:37 +0200
From: Petr Mladek <pmladek@suse.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	David Gow <davidgow@google.com>, Arnd Bergmann <arnd@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/3] printk: KUnit: Followup fixes for the new KUnit test
Message-ID: <aG_cYSfhXfxQoKco@pathway.suse.cz>
References: <20250702095157.110916-1-pmladek@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250702095157.110916-1-pmladek@suse.com>

On Wed 2025-07-02 11:51:54, Petr Mladek wrote:
> Hi,
> 
> this patchset puts together some followup fixes for the new KUnit test
> which were discussed on several locations.
> 
> 1st patch:
> 
>   + adds a comment exaplaing why the test ignores pr_reserve() failures.
> 
>   + was proposed at https://lore.kernel.org/r/aFUiQESkXjFIGqez@pathway.suse.cz
> 
>   + Thomas Weißschuh added into v4 of the original patch but I have already
>     comitted v3 in the meantime, see
>     https://lore.kernel.org/r/20250620-printk-ringbuffer-test-v4-1-8df873f1f3e0@linutronix.de
> 
> 
> 2nd patch:
> 
>   + dynamically allocates a cpu bitmap to make the code safe even on systems
>     with many CPUs.
> 
>   + v1 was set by Arnd Bergmann but it had some problems, see
>     https://lore.kernel.org/r/20250620192554.2234184-1-arnd@kernel.org
> 
>   + This version just integreates the proposed fixes from
>     https://lore.kernel.org/r/aFkuqaFn3BOvsPT-@pathway.suse.cz
> 
> 
> 3rd patch:
> 
>   + stores "size" instead on "len" in struct prbtest_rbdata so that
>     is can be used to check code sanity by __counted_by(size).
> 
>   + fixes https://lore.kernel.org/r/eaea66b9-266a-46e7-980d-33f40ad4b215@sabinyo.mountain
> 
>   + it is based on the idea from Thomas Weißschuh, see
>     20250626082605-c5fbbb88-f6cc-4659-bea0-a283cdb58e81@linutronix.de


JFYI, the 1st and 3rd patch has been committed into printk/linux.git,
branch rework/ringbuffer-kunit-test.

These two patches were reviewed by Thomas and John and were accepted.

The 2nd patch is independent and has an issue. I am going to send
an update separately.

Best Regards,
Petr

