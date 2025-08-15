Return-Path: <linux-kernel+bounces-771316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 264ADB28570
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 19:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDECB7A8D97
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9807B2F9C28;
	Fri, 15 Aug 2025 17:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ePfxfxXT"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D231253932
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 17:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755280713; cv=none; b=dpSnc4hxaGgHMrhKa4CW1QvsGHPiELtCoGyC4Eq2yitz3rYAqs19rIajYb9k/smj/adRs5vI5ikyP+IsEI3Z8dAHKKLNvNGal5ay+WyFWbiPohEWLuJaa+z4OmkAv5uHNXuWOWs9jh/EZbcSqEKFYaSKgYoNVV9nGKc2YysbGdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755280713; c=relaxed/simple;
	bh=J0td2zoouhF31o7H+9b7gH8qiWkTQPnLC9UtUQImk4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+wUW7elBew6YdN7K7g8LB+jVUQ2Kc5MGhwhKg04gSR10gHMZFAtR/5xJadcQ7e9DmBonNxw6dQctZN6wc3LkCvS0bZ8j03MXj/e5bMK9I6SEC9vkuGrBBfe9bSaQpyrOj8uvOZ94oOv0bkEW8kjdXbM42njglE4rKg+VLAyEKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ePfxfxXT; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e2eb4a171so3005962b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 10:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755280712; x=1755885512; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SYP+7rbjuySHNq9ed5xHyLOGuxCWsmhv7zYPas8pOCQ=;
        b=ePfxfxXTKfarE/Hb/5EpneBWNUZyRSrVO2r6yh46ZW1PO3o19yEdPEODCnCCLUmK4C
         sGBkSaUhTxiSHTDt+7I8WOE/SA6kfcF9DZbd9Xou4xtffxfI908DI5vM1wQc5QXrxuh/
         7GH19kdeH9KqYjE+fvcG07DCjIcCNEU8FOEeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755280712; x=1755885512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYP+7rbjuySHNq9ed5xHyLOGuxCWsmhv7zYPas8pOCQ=;
        b=lLSugypiAYADH1dFaqARtfHU8rveQp3vpjM6XSZcqnMZseLOzcCm1owoEB3cmTMMxA
         ZTEUtDQlrEetFZP5Hto+3L/uo44Lub5+4NJSifZztDiwVPW0Xm4IGMOQ3ZzUZhwnTZiJ
         BvRrFqiGFhtPWprrp02JUFC3xwroZn/OM8YPEZWnG81DQ5Npfi4xLWD0VmDNAfXZyaeo
         aE8dR94gWS2d43LKB63TOoQjApLsemlfCh7Vsb2Vc/Hr2TDp5hWtWoiSP66Ih5PPgSYD
         y6LhRoYMJ3jYDZZRF6qGCJsFQuJBwl9cGw3AjhK817QduGOuZA5TCyR8rsJ+aG1V6ziG
         et3w==
X-Forwarded-Encrypted: i=1; AJvYcCWk7EVqtAUUeTbY7A4h4OUmQKDpeplwiSn+rm7fJnscjxRxWYn0EdvUqb3kLfFaflRmrj1k3EoSmTEhhnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlFy53h5/ojqugwpjcVK9d4kJoJFnM0DNO77pD66co39j7AHj1
	E9AI9+qHBoNwKI0CrXwqzqWA/+xhqEES3jcWeoQl4AAJd7FyfFkOUy2z5qcfhiFPDQ==
X-Gm-Gg: ASbGnctBLfO5eYSoZhBkGUofIEtNSRB5lQNn2yDMErdiZVQqPa4bDnMTLCTKjlW6G9b
	n5fzakKEDvxQ7/qK5poqbDLq/sm2Po6jR1PKyVBl5F49xdSGCdtLv3kV82vMszp79ddJlHX9nho
	OOoa6npnSqzrdHQQ7gtG2zkhnV7NmZjPZu0mAMQPFj/lHPHT32rXF8eLYaypP+VyWi7PLrf/wWq
	8TQp7ge1f6KvjGmuKgf8H1ADQ5mT+99DSMXoRRyloMLX3Jsz/jcqLT0M9mzj0dzytxwlJjC8Xrk
	+2psr4TAEagpCfFII1WpdKUX9ET8v7HOAp+dIZdeCPYKtCWGkgQ9E4foxf9I8BR/vFpqtQReCqX
	5Z8VWoK/kMJTvVhDDhvTomKeOr4U4pSVnQ2eHG8bW84Mw8Dwl1sPcWdwJr4oM
X-Google-Smtp-Source: AGHT+IEWwayBN2jYiBq6EgZL44fhRP2FJzOV3pSNvcqowgzPQ4YYHIc8jaIJM8lFWkDpamntCEnzVA==
X-Received: by 2002:a05:6a20:549d:b0:239:1c1e:3edf with SMTP id adf61e73a8af0-240d2f3c2famr4794369637.40.1755280711731;
        Fri, 15 Aug 2025 10:58:31 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:eaff:25b5:2a27:51d9])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-76e4528bca0sm1597349b3a.34.2025.08.15.10.58.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 10:58:31 -0700 (PDT)
Date: Fri, 15 Aug 2025 10:58:29 -0700
From: Brian Norris <briannorris@chromium.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Tsai Sung-Fu <danielsftsai@google.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] genirq: Add kunit tests for depth counts
Message-ID: <aJ91RRsMB-duD2yR@google.com>
References: <20250522210837.4135244-1-briannorris@chromium.org>
 <ded44edf-eeb7-420c-b8a8-d6543b955e6e@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ded44edf-eeb7-420c-b8a8-d6543b955e6e@roeck-us.net>

On Sun, Aug 10, 2025 at 12:37:31PM -0700, Guenter Roeck wrote:
> The new code calls irq_domain_alloc_descs(), making it dependent
> on IRQ_DOMAIN. However, specifying that dependency directly is not
> possible:
> 
>  config IRQ_KUNIT_TEST
>         bool "KUnit tests for IRQ management APIs" if !KUNIT_ALL_TESTS
>         depends on KUNIT=y
> +       depends on IRQ_DOMAIN
>         default KUNIT_ALL_TESTS
>         imply SMP
>         help
> 
> results in:
> 
> *** Default configuration is based on 'defconfig'
> error: recursive dependency detected!
> 	symbol SMP is implied by IRQ_KUNIT_TEST
> 	symbol IRQ_KUNIT_TEST depends on IRQ_DOMAIN
> 	symbol IRQ_DOMAIN is selected by IRQ_DOMAIN_HIERARCHY
> 	symbol IRQ_DOMAIN_HIERARCHY is selected by GENERIC_IRQ_IPI
> 	symbol GENERIC_IRQ_IPI depends on SMP
> 
> This is seen with alpha configurations such as alpha:defconfig after
> adding the IRQ_DOMAIN dependency.
> 
> I have no idea how to resolve this. For now I disabled IRQ_KUNIT_TEST
> for my alpha test builds.

How about 'select'? That's the usual way IRQ_DOMAIN is managed anyway.

It builds for me, but my distro doesn't provide an Alpha QEMU, so I
can't test it.

--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -148,6 +148,7 @@ config IRQ_KUNIT_TEST
 	bool "KUnit tests for IRQ management APIs" if !KUNIT_ALL_TESTS
 	depends on KUNIT=y
 	default KUNIT_ALL_TESTS
+	select IRQ_DOMAIN
 	imply SMP
 	help
 	  This option enables KUnit tests for the IRQ subsystem API. These are

