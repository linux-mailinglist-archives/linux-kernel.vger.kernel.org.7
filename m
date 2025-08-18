Return-Path: <linux-kernel+bounces-774087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 231ECB2AE76
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF2B07AD0FB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97F826059F;
	Mon, 18 Aug 2025 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZPSDzHws"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8951B3925
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 16:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755535517; cv=none; b=VRZml3+NH5bbUDqpCZWT2huiIYVoZ6ccjLUzQQmkA4CsFK2WiR6iim5+Yxjo0oHA5JxUxhGuDNOCuP3w2M45wE3uuwZrqlEU3S1iXqfNlvXOUcMTbQdOVxBSwNxPQZufhZ8g/BsGVdagWWBuKY0MOvA+xi4hZ3RUPJc5ScQcKdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755535517; c=relaxed/simple;
	bh=//+xPLeguSbIhURoF1x1TOjb/MysEorKhJmgrcYM7A4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkP/EJB8f2EAjaNmSOTgQvGns4c/oaCvMvzahYuPiqy47RCBDQ6+3gN8Bm+W+wRdE+rUOfAaba/rTW0ftvYypxYcVcTFGv6Md0qLy3t7U9fD7DGpzwaeF+9IaR0ShkcxWEFo3Gr5xr+RNIuTknbdLHNM6ap0B9dug7BKs9q84ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZPSDzHws; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76e2e8bb2e5so4742034b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 09:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755535515; x=1756140315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jm38DmhvKObx+QQg+EIYMCZcP9/JdQjzADgmfVxXQ9k=;
        b=ZPSDzHwswwzIgpR9kndSC7oMfx/nxueSZbN/AxH8Xrg4g3g09ba3K/oHqDmgYZIBAH
         JKv9CAa95l/fUz9upnC0tP+uDSGypfJ+S96udDGtt4PnlkgcOXrNF5N6n+m1TOdG5M3K
         FwHKn4CUk1+STXDeIMCtRnmMDRcpKylZu1ZIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755535515; x=1756140315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jm38DmhvKObx+QQg+EIYMCZcP9/JdQjzADgmfVxXQ9k=;
        b=eE7L96WlrypXnlJx9jJe2KwIu65P6gfPsRMjgY0R3fq8JquGsIeAH4OTNtSNJPoMh5
         P509SB3u/xDirJNkTV6QnsnEJs/Bsx2xKiBcFNmEQLXOsooLDUvIc5Bg63zFZsrPEKRF
         Jj4Cr5jt39BBEY0YkdulKtFWN1QXokRI/YWtRFw/YOThl3j8wZaP3M7UvNqY4Ad1CpFv
         WFKY9Q5sYQU8/leAson913FNfVXVvzpivK/jZawBsuLQ8J5Xo+r1ll4NvtiTZItUUcht
         3uf+PJqAAFfqm7N4sED/7nEsmZH1B+agi14Z+YCZDs+rqeKrcpfQzD6X6QAmYNZIRFcN
         Wg6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVpyVPUURcuUTcFsYKaSFooSgpmoyocLyGvq1j3Zk253FrJAJ5YZlCS/DDrhtkUAQlQoNNrEeAA2UyMqfI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4peHXs2afeDpc4EYOlzyVOs2zIpCTt7Te8WzGZ43Zat1CnxPJ
	p24LOuAnuWX1pg4JJMwRag9DvHP3Pqcsp6SBPlDIXE+TGWf1rSoXkXYwghsP0aA5rQ==
X-Gm-Gg: ASbGncuPJOXrtVBBPNtaXgVQEM46Gtqt33lw9BV+Ca5xQ+mZ0tq4OOK11I5LxtGjPFU
	rMKr7dRV5G1TW+pJ+pgcmdkrN2ZQuUkUY/0RLOEYgytNNLRk++4CvItgaw4p5hD4ao7lAmu1eCO
	7kTHQ2aRzzA6mKxqkkEq9797xnUVwYu5nzzBY5jGF51+imOJy6X6P2wNIwQUy4IDPDwOX/VVUI7
	06PomZZDTO2/Eg6MJezFZuIe8t8SgRAQ4laopBDZGHSOL9KeEIJs83JRJ5OFwhnmDcRitEqy1ac
	PSz2FL7HFm6YgZaPP9YL5QMyEjhjOhoJNlRvynU/+woRXEJXLbQ7gDLavqEjS2IP4P6EdTVDXjl
	AbOMMYbsZckBQ4yMDIK+oJPq8eiUrtKMxrbB49z1cCM6vGsPycPrwRRGJcgE=
X-Google-Smtp-Source: AGHT+IGCsom8v5brkFIG9eBO3FYPrudaSNdjF4q6/gYtF8XXZ8oxmpwRgTAAHQn1TRQpxY+1jZMBjQ==
X-Received: by 2002:a05:6a21:3287:b0:23f:fa6e:9125 with SMTP id adf61e73a8af0-240d2baf7femr16966611637.0.1755535514835;
        Mon, 18 Aug 2025 09:45:14 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:8b1:3a35:d843:1d0d])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-76e7d4f7818sm85399b3a.73.2025.08.18.09.45.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 09:45:14 -0700 (PDT)
Date: Mon, 18 Aug 2025 09:45:12 -0700
From: Brian Norris <briannorris@chromium.org>
To: David Gow <davidgow@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
	kunit-dev@googlegroups.com
Subject: Re: [PATCH] genirq/test: Fix depth tests on architectures with
 NOREQUEST by default.
Message-ID: <aKNYmKU1Q59Gb-n1@google.com>
References: <20250816094528.3560222-2-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816094528.3560222-2-davidgow@google.com>

On Sat, Aug 16, 2025 at 05:45:28PM +0800, David Gow wrote:
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

I was about to send essentially the same patch. Works for me.

Reviewed-by: Brian Norris <briannorris@chromium.org>
Tested-by: Brian Norris <briannorris@chromium.org>

tools/testing/kunit/kunit.py run 'irq_test_cases*' --arch arm \
          --qemu_args '-smp 2' --cross_compile arm-linux-gnueabi-
...
[09:44:15] Testing complete. Ran 4 tests: passed: 4


