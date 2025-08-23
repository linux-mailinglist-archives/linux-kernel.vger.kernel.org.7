Return-Path: <linux-kernel+bounces-782865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B91CB32628
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 03:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE2054E28C7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 01:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78F819D071;
	Sat, 23 Aug 2025 01:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQqmTc7l"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3FC1B4F2C
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 01:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755911638; cv=none; b=SatnbqzLFJGpS3Oj5RGbd0PJLgWdw8fjYRRmmOrmMTcVREHwv6zer9+OFISliEP5mIqhhMbX3lne/AOXnxd0wCUK1DRPE4f1n/N737ycG/TCqR1mIfr5vMb6tIeKx7z9nVxuFZTPpJftykH9mQvCh4Bf/UUkFZFW8klMxbLwKhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755911638; c=relaxed/simple;
	bh=oe4PKEz/cvP7KV7ko0mimaA79f+hZFnaqwxwVJ45Jm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xw/yQwo5S6hA1zqqpu70VR+H4yMsChTjc0y6yQyylSOBbkYLdMRQanojtHv3jy262coOEdPgCZh7MKvTh7ORUzO7hlmEnps5bWpx/wYrwV+NUyk3sjSvbCgAAZW5gQCPY/NnOQ9c4acx8sLJUFxxwU3vwlyOweqvoCWQS2rAB5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQqmTc7l; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b4716fa7706so1795778a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 18:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755911635; x=1756516435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5fZDhLqfuS6uJdGNm+qE8o+l+LEzoDjlacSLv+bvJJw=;
        b=cQqmTc7lH3oV1ztRNEz3w7KcU5mEjFlQzjWOjtOIfF7za5Mnj9dRgpum2gem0Rg1uk
         dFxX7EPis+sPf9LVE9jpkXiSwWDo1cZS9Ay5YvpALNQWuhAiEmtQiIrhLVt/cwIIXnjR
         2heqkl+6APmU9trXkeyGuTwI8Ey+5lAznDN9/MNUhDLIpgdThTKsmTfkgV/FsG5vrPHb
         +84oJqb0DGGavAaCxjYM2UQ4yCXlz3FpkVbVFSxS7Mwo5ZOB7i5Zp65xeL8To9vmRpZ/
         WRqGpdZ3yAnZvXq2fSzcmVnjBDwb2gcGmy8mLyoMiuU4tlCAtgXZnylSzDHA6MlQkc8t
         LCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755911635; x=1756516435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5fZDhLqfuS6uJdGNm+qE8o+l+LEzoDjlacSLv+bvJJw=;
        b=SDYTUnSazVa7m98BvCVxOZu3P+Xo3pkUT65DX/9CAow6z4N2dOiO9ISIoYN42fL61n
         cAqh8iVteTJEeMY0gVqeUWWX1NCi4II/q6MSUtSIIjmsliQPl5edLvEPfk+tx35PX2tD
         4cIxKPvmqo0YbyWEJn3SnCwb3Lt5byLPDVP3fxBez+fdF1AM2rbYEZqmhSOH8Eje40hH
         pNZAs407GAD2twvm5I+jgz8GhxJIPG0g+pcl6+UVsIXvQQydajmU2LIVjX7nx0FlTUbe
         EFqM5z9bfyyw985T0vQVrb7hsEpcqRNvuGImG6oALp8lLphPREszjEJP0M4vSAAGilA1
         9v6g==
X-Forwarded-Encrypted: i=1; AJvYcCUjUX68rqlKxFxekZGcfNCJiMdx3HGZ5MVWPTkiMwJ9afcw77cBs40ei0ZUlJ/SHEMcuTWjMlzHgWhgRFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMfaaky4/chPcnnTwIJlVDa3lu61e63tBGJKwsEsIDJIiBCD1k
	YVTx2GSAYYOVL+8UNHGo9jZk1mYk593w5wg1I1Z/vCK9dkrrB4hw4JaM
X-Gm-Gg: ASbGnctznbBRR+rZEu1W+G8VAvtqVAm7hF5HBlVdijlkTVIjuPEIfJ6b3E50F1vbj9i
	QCNjKtbt1Y/GFuZbUC8YHFDnMnLJaxv3Geiynw9X+VZlc24qVjSePYVmHBvXYf25s2lDZS+y3wi
	bfHAb7aONuSFPq/X6Or41+OmS3hs7htqXVw36K/XsWqTKEEMP+wYJZd/u3lgZ1eyj7acDOeYjQn
	5p15a2vzQ2c7CqAeyYihmkyM2KjVg+XjrAd6jSOnCrXnBtQHAjOK2Fo7OPLIshq34KsoE2Dg2qa
	/icZvkwX5RifDPF9vCvOTjjPq7yPXrKm/l6/ouwUFVUhorR8pGqCLFnv27EHHWB4fyQWPj+6TpT
	mkggEjflOKyufySRqEPBwqDeDggcLJA9+P8ofCvjdrF8/jg==
X-Google-Smtp-Source: AGHT+IG4z+jZeq1yjJy3Ti/gLn3mMpWd8Kx6Qn4z/mzv9vrTQJUrkSBDG/jxlLpzthmjUB8AgQcPyg==
X-Received: by 2002:a17:903:22c9:b0:246:6f78:1fd2 with SMTP id d9443c01a7336-2466f7821c0mr17109055ad.34.1755911635529;
        Fri, 22 Aug 2025 18:13:55 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687b0ca3sm8254125ad.57.2025.08.22.18.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 18:13:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 22 Aug 2025 18:13:54 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Brian Norris <briannorris@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, David Gow <davidgow@google.com>,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	kunit-dev@googlegroups.com
Subject: Re: [PATCH v2 5/6] genirq/test: Drop CONFIG_GENERIC_IRQ_MIGRATION
 assumptions
Message-ID: <5073cad4-d960-40c1-a777-1f597a4ca999@roeck-us.net>
References: <20250822190140.2154646-1-briannorris@chromium.org>
 <20250822190140.2154646-6-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822190140.2154646-6-briannorris@chromium.org>

On Fri, Aug 22, 2025 at 11:59:06AM -0700, Brian Norris wrote:
> Not all platforms use the generic IRQ migration code, even if they
> select GENERIC_IRQ_MIGRATION. (See, for example, powerpc /
> pseries_cpu_disable().)
> 
> If such platforms don't perform managed shutdown the same way, the IRQ
> may not actually shut down, and we'll fail these tests:
> 
> [    4.357022][  T101]     # irq_cpuhotplug_test: EXPECTATION FAILED at kernel/irq/irq_test.c:211
> [    4.357022][  T101]     Expected irqd_is_activated(data) to be false, but is true
> [    4.358128][  T101]     # irq_cpuhotplug_test: EXPECTATION FAILED at kernel/irq/irq_test.c:212
> [    4.358128][  T101]     Expected irqd_is_started(data) to be false, but is true
> [    4.375558][  T101]     # irq_cpuhotplug_test: EXPECTATION FAILED at kernel/irq/irq_test.c:216
> [    4.375558][  T101]     Expected irqd_is_activated(data) to be false, but is true
> [    4.376088][  T101]     # irq_cpuhotplug_test: EXPECTATION FAILED at kernel/irq/irq_test.c:217
> [    4.376088][  T101]     Expected irqd_is_started(data) to be false, but is true
> [    4.377851][    T1]     # irq_cpuhotplug_test: pass:0 fail:1 skip:0 total:1
> [    4.377901][    T1]     not ok 4 irq_cpuhotplug_test
> [    4.378073][    T1] # irq_test_cases: pass:3 fail:1 skip:0 total:4
> 
> Rather than test that PowerPC performs migration the same way as the IRQ
> core, let's just drop the state checks. The point of the test was to
> ensure we kept |depth| balanced, and we can still test for that.
> 
> Fixes: 66067c3c8a1e ("genirq: Add kunit tests for depth counts")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Reviewed-by: David Gow <davidgow@google.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> (no changes since v1)
> 
>  kernel/irq/irq_test.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/kernel/irq/irq_test.c b/kernel/irq/irq_test.c
> index 56baeb5041d6..bbb89a3e1153 100644
> --- a/kernel/irq/irq_test.c
> +++ b/kernel/irq/irq_test.c
> @@ -203,13 +203,9 @@ static void irq_cpuhotplug_test(struct kunit *test)
>  	KUNIT_EXPECT_EQ(test, desc->depth, 1);
>  
>  	KUNIT_EXPECT_EQ(test, remove_cpu(1), 0);
> -	KUNIT_EXPECT_FALSE(test, irqd_is_activated(data));
> -	KUNIT_EXPECT_FALSE(test, irqd_is_started(data));
>  	KUNIT_EXPECT_GE(test, desc->depth, 1);
>  	KUNIT_EXPECT_EQ(test, add_cpu(1), 0);
>  
> -	KUNIT_EXPECT_FALSE(test, irqd_is_activated(data));
> -	KUNIT_EXPECT_FALSE(test, irqd_is_started(data));
>  	KUNIT_EXPECT_EQ(test, desc->depth, 1);
>  
>  	enable_irq(virq);
> -- 
> 2.51.0.rc2.233.g662b1ed5c5-goog
> 

