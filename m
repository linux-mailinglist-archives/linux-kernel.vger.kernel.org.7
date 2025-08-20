Return-Path: <linux-kernel+bounces-777372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 138D3B2D8A9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52A9916B8F0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D5F2DE6E7;
	Wed, 20 Aug 2025 09:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="duA9A6kC"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2630E2DCF63
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755682424; cv=none; b=JpZHF2Ji2wgKuEEqiXYXeSxj/NCatUHmJPDBvBfAd7ETyWdIBOStipSmcbNEuNHpsRwmRQNAwos8ykA4/Lm0aItmghlIhn1I9edOI9eBtqeJE+XIzofceldD6EENTCfFRb2FQi5EBAJNYJznEhQ0SA6MqdJ59FMmohQRY0aFDX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755682424; c=relaxed/simple;
	bh=HbWeIT+jA4hjhJwyfV83Luo/UR3MkpPBEH6bueMs7M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdbqg1C4TmHdluzDgx1q8bCIQiXPf1bJNxR4OYGETQwimMEaayc5RYNXXv5cJ3ykE5vipfHK6CxLsCUUMwBtbq0W++rTJverR0I9aJW7awxhGgFnMeR9l6gOYAwItoa2l7f1GPBb1dHYuYjoipMRfrz6GezydMgHc7hRmas0czY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=duA9A6kC; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb73394b4so933631966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 02:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755682419; x=1756287219; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lUtGYQFblf9pQrLVu24aMqFiXE6ucdsRYulZCvjWiao=;
        b=duA9A6kC3HOqmG2Rk8w0ShnAkmkf8hGtqV4AiTqqchMOW5fnKWmwymg7jGC7w0UTsp
         yAQtpXC95gm1550BBP4BKXVvlM2TSSDlE5oJuPE6LyhYb5ki2K4E+JS2BJV36hPvWJB0
         5TXgPESO+Yc2Otq+Wwy16KIJLhJJyBU9kAbppf+ilzDiMVwkRBXLLj3SJU2OsrGqduKa
         RKFbXGRLnjHUYW0x6Fs3ViXwe0RJcs2bdCHqZeMiOcS7qoI1VI6nHftRxdA7eKA3/tqh
         ExZRKThvdxjdCFacd21AbwDT7LNGeGHzxMiN7b3t2yuuZOB3Gk5SqEmI2ppRwGzVE9mY
         yFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755682419; x=1756287219;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lUtGYQFblf9pQrLVu24aMqFiXE6ucdsRYulZCvjWiao=;
        b=V4e52MX2LjQWNyh2DAmOGeyNq73UJ7HIqW1zzGGXSwHNjGy0m2kMDGn3DsYJkpWS1w
         fKkM0BcZSv1GS93wBZw8gfsOFcLnlejQK5fDtlEEubOnosV1usjo9WVidHPy3EKQj1gJ
         IIeteG/SlbRa17j3ALqvsOJhpFm0yl0S7avKu4PXAYLDekdK/SjnGlpNiIr/fBOBeosg
         Cjo+C580tZkZO6PMeb4I+2SxFNarCc6BHrrGBBVNkDqkd63sTEe3WvCXeCm23QIrWtup
         +e5MP2JcZhbbkneXQ/MqH8PBQsTcybM3EJds0as4ILp4vzPtHvrhY0M2iboSw6v07TK3
         1ZSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCfbXbS1UNzCOul3MGkjZZQHJwIEdmkWB5t8MNJmBqktl0Nto1Po5gv+3sQ/GWPvfePqRB56/r+7oTM68=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFWNf4U/J4oc+la87sZBOB3xNzBjHGxh2FJjmP2Z7anyBVds05
	rNlEDrTa8+EekraWQl4eW+d/BYd9IbvQLzdX24kjKnkctX2a2m/zNyc+Z8bDShSLAQU=
X-Gm-Gg: ASbGncsVa40TY4IaMXOkdZx19PE72+HRk0uj9NO/EGiIg/ZsJyQkkEfnOA9k9Ynb3Sd
	qPjuIzH8yQSL6efj7DDMGQfJ06rsrIvC34Qb09wldORkXL571Wv+h7qLHusVZEiSHzgFezKAD+U
	1pskbXCj2Bz0DHNKJmkxCTbGQ5IwoN6tozI27arT7u2Lnw2hBD0c3IAq7/pMTik2eypXNISFZsI
	uAJkTFnPBT9PwTdtQPUEmQ+FbU5hpFvz2K/TPgk929MT5+y0LKZ3KetCM4ylFSaBGcGaFgo0lTt
	dnek2/8oVHpn3MZq6ms2fN8N/SVhLnfiXMx5TqWrOLLjNx51wskYYj+01HFB6eBXUIsTLuIemGl
	NR287HNVtNcDk0YurGDukLYQwbfEr1UPA6ayR
X-Google-Smtp-Source: AGHT+IGXHe3+t3BEKmunC18D/1Y6ekjPUy9xaq9clkZufAl4R+B2NGg/Uju7EdG3WK9qHxpL/vyc6w==
X-Received: by 2002:a17:907:3e8f:b0:af2:5a26:b32a with SMTP id a640c23a62f3a-afdf01b27bcmr193049566b.30.1755682419377;
        Wed, 20 Aug 2025 02:33:39 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afdfc4bfe65sm12791466b.85.2025.08.20.02.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 02:33:38 -0700 (PDT)
Date: Wed, 20 Aug 2025 11:33:36 +0200
From: Petr Mladek <pmladek@suse.com>
To: Lance Yang <lance.yang@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	paulmck@kernel.org, john.ogness@linutronix.de,
	kernel test robot <lkp@intel.com>,
	Feng Tang <feng.tang@linux.alibaba.com>
Subject: Re: [PATCH] panic: Clean up message about deprecated 'panic_print'
 parameter
Message-ID: <aKWWcPOf9qPIoCe4@pathway.suse.cz>
References: <aKRJKZHgcxyNF3y7@pathway.suse.cz>
 <202508200907.PsZ3geub-lkp@intel.com>
 <ae9bb2ea-c6e5-4a4b-ae25-aea1d6fe084d@linux.dev>
 <33a897b4-7d9a-4641-9c7a-07c19bb9cb6f@linux.dev>
 <7a34da58-874d-4271-9dbb-7991468d58ff@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a34da58-874d-4271-9dbb-7991468d58ff@linux.dev>

On Wed 2025-08-20 16:57:48, Lance Yang wrote:
> On 2025/8/20 09:56, Lance Yang wrote:
> > On 2025/8/20 09:54, Lance Yang wrote:
> > > On 2025/8/20 09:31, kernel test robot wrote:
> > > > All errors (new ones prefixed by >>):
> > > > 
> > > > > > kernel/panic.c:952:2: error: call to undeclared function
> > > > > > 'panic_print_deprecated'; ISO C99 and later do not
> > > > > > support implicit function declarations
> > > > > > [-Wimplicit-function-declaration]
> > > >       952 |         panic_print_deprecated();
> > > >           |         ^
> > > >     kernel/panic.c:958:2: error: call to undeclared function
> > > > 'panic_print_deprecated'; ISO C99 and later do not support
> > > > implicit function declarations [-Wimplicit-function-declaration]
> > > >       958 |         panic_print_deprecated();
> > > >           |         ^
> > > >     2 errors generated.
> > > 
> > > 
> > > Oops, panic_print_deprecated() is defined within the #ifdef
> > > CONFIG_PROC_SYSCTL block, but it's also called from panic_print_set()
> > 
> 
> If Petr is cool, @Andrew could you squash the following?
> 
> ---
> Subject: [PATCH 1/1] fixup: panic: clean up message about deprecated
>  'panic_print' parameter

The patch was malformed probably by your mail client.
Below is the fixed and revied variant.
I am going to resend also the squashed version.

Here is the fixed followup patch:

From 35ded31e9ff2c9925d7a78472115c9929b582c63 Mon Sep 17 00:00:00 2001
From: Lance Yang <lance.yang@linux.dev>
Date: Wed, 20 Aug 2025 11:25:31 +0200
Subject: [PATCH] fixup: panic: clean up message about deprecated 'panic_print'
 parameter

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202508200907.PsZ3geub-lkp@intel.com/
Signed-off-by: Lance Yang <lance.yang@linux.dev>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/panic.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index d3907fd95d72..24bca263f896 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -77,6 +77,11 @@ ATOMIC_NOTIFIER_HEAD(panic_notifier_list);
 
 EXPORT_SYMBOL(panic_notifier_list);
 
+static void panic_print_deprecated(void)
+{
+	pr_info_once("Kernel: The 'panic_print' parameter is now deprecated. Please use 'panic_sys_info' and 'panic_console_replay' instead.\n");
+}
+
 #ifdef CONFIG_SYSCTL
 
 /*
@@ -122,11 +127,6 @@ static int proc_taint(const struct ctl_table *table, int write,
 	return err;
 }
 
-static void panic_print_deprecated(void)
-{
-	pr_info_once("Kernel: The 'panic_print' parameter is now deprecated. Please use 'panic_sys_info' and 'panic_console_replay' instead.\n");
-}
-
 static int sysctl_panic_print_handler(const struct ctl_table *table, int write,
 			   void *buffer, size_t *lenp, loff_t *ppos)
 {
-- 
2.50.1


