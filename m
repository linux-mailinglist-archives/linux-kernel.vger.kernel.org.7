Return-Path: <linux-kernel+bounces-722729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A2BAFDE36
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 05:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E44223BB97C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 03:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E73E1FE45D;
	Wed,  9 Jul 2025 03:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ccZtHTWS"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA321FBC91
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 03:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752032146; cv=none; b=iKL/lGebfMnC9HVBBywxAZU314fOl5dIIvod/AeaF+yicVgtfV2D+npcMiTAZCJg9LHdBKI3klm3cGG/pAvq8UAepmvFnL7SfsoEY1wM79++PhsUw+er7sde9XJz5as9wf1YB1lRlls+qQzNfWCPT8W/r8ErxU7GLzTOpp5XbZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752032146; c=relaxed/simple;
	bh=bwyRTg45geoHW3hWOsuiqhqr+GwtWAX+IFqpRCFOT1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TjMIMWVb17Ef0ptMq7bjpu4jqhz61TyShb7KCUayEQbdxEgUsmSHUdCIOgBf3O+zIMWRV8ODRQes+Z8j6JPldzUkMB+79rZImwldi8YZDfLX6gPN3XPwsOlzH+Gbkca5GRLlfjWH2SUtgH1XKIJMCVwVnEW7RFvu5cWdZRwD07w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ccZtHTWS; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-748e63d4b05so2769402b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 20:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752032144; x=1752636944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qsb2CdBr2jL9dFDttosCIFqr1KdpEEAxAcF+R61NsJw=;
        b=ccZtHTWSQJ0mO3RRbAnuA7p5AC5Y6Ebc0XJenwHoTl6eqWopoxctsevxyK58Nh7OMY
         9K3A3Mjx9cdokiC9qKcQ3z1DynV0DkZAeyB+2twWiggbMXkrBhzvggo7loOVqCDo+zoq
         ARLuUIttdCguZyY6CmULheDYB1ZcPCkrWLjrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752032144; x=1752636944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qsb2CdBr2jL9dFDttosCIFqr1KdpEEAxAcF+R61NsJw=;
        b=qHoyd7p6C+dTft4lPpfbLgnf08nle/vCjNKgz0pQOu8Ywd35pZvAkAkaKlWm14nFHF
         c7Uedi2I2AHSReXD7GYEZEGcmGUvPbcre64zPaRNuA8sQp9oIxpo2gzvb0Wl8j8gvtr7
         3Q9kVzsZUyInnAoXyL37gLkhMYfTho6x6mujVD2o4Gf+TibgQ/8y4UMrg2dizPkxA0vf
         ncDX18amG4dCtEP4bob18Y568uirFPZ76qxyEX81fHfS1ChoOR7jnXUDpUe2eP8f/gpM
         M8AoxrRsa7mWqQhQZAQ1/aA/bur/OdFUiaAzDd7MLkWvfke5aKjlr0bzk9hB59HAH6Hs
         8iIw==
X-Forwarded-Encrypted: i=1; AJvYcCVgrD38f59tTwnLlB/zAhnqk/xwSmjPhG8PMhBj48s58Ah4GL6eqDt8Z2VidHPPmgtW5IziuKkDWbDx1ss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb/z/hDfmP0+R8PzCA8o7GaHhs5aKuR6edlfpdxEEUrw/mp6Aj
	ImmrsReDtr1RH6Nt8F5Mdatk+8sexfu3CpoMEYTb/gTJnoJaVEv6xiYjbOJCPjrEFw==
X-Gm-Gg: ASbGncvETfg5F9MjzrioBpUuDThk7xWfxmEh8ZA++3/mvOLNTnohbXnsUamU8KhNF4k
	X940CZLydcv9zXRGTub2k3jEgEV793+ALZdIidSW4awfuCFsaT0Kh2hPdgtW7RrwCuGB+Og41AG
	zhWLW4F3NjU3mY++FSw+uXKVnlvH3tkQeD21e6Q9GRAwXKKnYRc2FWS8Hh6ZUeDJeU7TZQoz2o7
	RqPa7vCB2/oRwbpcpFWpbT5NH8XhWNlHAek1F0Ada+PwFwrDfDWmiEwPPUBXvmdWVPpqbYqlcRr
	dBNQNRvAmZ6x7uera+BaUkjNswBTycBXxT2SfsIfNL+TCw3vUF4D8MKyCpHj2FJqZQ==
X-Google-Smtp-Source: AGHT+IG0wNQCVJNSXqLv1MCrt4+kreF5JyhfXEr3SDWdJx4iU/0M131wKAhbdIVdLnmoP5zwmOA2Zw==
X-Received: by 2002:a05:6a00:2d0c:b0:74c:efae:ffae with SMTP id d2e1a72fcca58-74ea63e3dbfmr1403424b3a.5.1752032144186;
        Tue, 08 Jul 2025 20:35:44 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:9611:46f8:eaa3:1a41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce417e852sm13761178b3a.85.2025.07.08.20.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 20:35:43 -0700 (PDT)
Date: Wed, 9 Jul 2025 12:35:40 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 3/5] panic: add 'panic_sys_info' sysctl to take human
 readable string parameter
Message-ID: <vksfx7stglvc7dvdsbu6b6eflmacg5eexnmzu47tdkak4uwscm@rm2ilr5ntriy>
References: <ndckw7vr5zxiz2olstjaxxk4a6qgrnbo65rex4242u3swnvvhm@whxmilgtgoyd>
 <aG3hjKg81xrDHjZc@U-2FWC9VHC-2323.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aG3hjKg81xrDHjZc@U-2FWC9VHC-2323.local>

On (25/07/09 11:27), Feng Tang wrote:
> > >+#ifdef CONFIG_SYSCTL
> > > +
> > > +static const char sys_info_avail[] = "tasks,mem,timers,locks,ftrace,all_bt,blocked_tasks";
> > > +
> > > +int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
> > > +                                         void *buffer, size_t *lenp,
> > > +                                         loff_t *ppos)
> > > +{
> > > +       char names[sizeof(sys_info_avail) + 1];
> > > +       struct ctl_table table;
> > > +       unsigned long *si_bits_global;
> > > +
> > > +       si_bits_global = ro_table->data;
> > [..]
> > 
> > Somehow this breaks the build with:
> > 
> > lib/sys_info.c:52:19: error: variable 'sys_info_avail' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]
> >    52 | static const char sys_info_avail[] = "tasks,mem,timers,locks,ftrace,all_bt,blocked_tasks";
> >       |                   ^~~~~~~~~~~~~~
> > 
> > Moving sys_info_avail[] inside sysctl_sys_info_handler() seems to help.
> 
> Sorry for the trouble. I assume this is clang?  I locally used gcc v10.2.1

No worries.  Yes, clang.

> Nathan Chancellor has helped to post a fix here https://lore.kernel.org/lkml/20250708-fix-clang-sys_info_avail-warning-v1-1-60d239eacd64@kernel.org/

Great.
Would __maybe_unused be better than something simpler:

---

diff --git a/lib/sys_info.c b/lib/sys_info.c
index 46d6f4f1ad2a..3bd789fe29d2 100644
--- a/lib/sys_info.c
+++ b/lib/sys_info.c
@@ -48,13 +48,11 @@ unsigned long sys_info_parse_param(char *str)
 }
 
 #ifdef CONFIG_SYSCTL
-
-static const char sys_info_avail[] = "tasks,mem,timers,locks,ftrace,all_bt,blocked_tasks";
-
 int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
 					  void *buffer, size_t *lenp,
 					  loff_t *ppos)
 {
+	static const char sys_info_avail[] = "tasks,mem,timers,locks,ftrace,all_bt,blocked_tasks";
 	char names[sizeof(sys_info_avail) + 1];
 	struct ctl_table table;
 	unsigned long *si_bits_global;

