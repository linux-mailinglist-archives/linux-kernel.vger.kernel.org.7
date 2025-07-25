Return-Path: <linux-kernel+bounces-745255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E64B1174C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 06:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A4787B714B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 04:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2167023185F;
	Fri, 25 Jul 2025 04:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hja5JBXV"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3494A08
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 04:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753416391; cv=none; b=jbBXT7HCDYv0VY1PvHqY/WAjks2WNoLNseMLlShNmY/arRGRktPXt4SS4RoaoDXEXL3U9xU45zoVp/7l4LOhfEMoNkrrSqj+xStcHaUlZtyb1izuQ/lsgfURal5N2YNFa+439+HgLax1YF7JbDzG7PymNkFnSUGK/fGjnXDDOpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753416391; c=relaxed/simple;
	bh=Nbiex0cAfXxQfSvouhrM5Lo/7kXZCARpsH6Uszz/5iQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iDcH6qvc6Ds9DSKQyhQ8pMyh7ttFhIghR5lUVuEuHdTbMtziaGIKc97wRWWvMtgPEMspI9t7fdrwkR87NCjpcwq8wMlNUQf2nLCfqLB1FPRO+/UZF7Wks8nMoYuX6nZcs/cv125b13HVSinQGK6Nevfi9ZS+P7BabvHrhx/ADgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hja5JBXV; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2ffa8e58654so968343fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 21:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753416385; x=1754021185; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MxFwecxr/0B2ef20Od5cEy15w6qiFnt04wlLQ+u7uOU=;
        b=hja5JBXV41tSOC/5aYPECCCKvkbJZOGDHuwYLWlkRpRc1Vgx+hcrmo4BY0sfXQJ9x+
         jr7OoxYxRY4+GraODvDB/b4NKES6aEGnwAtEKW1LfCP0Ns+XS7Gjp0thEMlNZG7FXWTI
         i/YzgxKvdMMggFXM2zkonvtMeKp+4xngFTR7nRFszIlJ4qjLck4PzFSsnkKHVb3moiJ3
         3O7UJHOTO0/fLicGhAoJ35ef4tG8ZlXekzwWTVNtP7q3Cuytkyq9BIQt39lXlsu/BhnT
         Os0bz8zDuU+vKRrK49AveTN5V8bF3dD80nwE+tTK5TTWyKvaABuTijZ0PYj2yyazeswc
         xpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753416385; x=1754021185;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MxFwecxr/0B2ef20Od5cEy15w6qiFnt04wlLQ+u7uOU=;
        b=tzf+qXlNz/f+mLFqNVXI52deXzU7IOeo2mijYFGhtge0Q+9BuoTPfDDihteNEdl3jr
         Xp42jzt/DGwU+dI4wTnr+dQWgDDAeCieWUFP3M9RKd3lIFAF2lNiOYawl2ofBCoJ0Whl
         5a7W1bx74i+oARAhvm/xfMgVRjFFZYAFea3oqDNMvk/7amycG9AhxtANe5kcDnnFgFgX
         y8ZgruUfKM51w/9GlgTvjtMiA/9rnTsHbrWyTJK7dFjWN4rL5t4Fnt48ZF56lnfOr56q
         rkvjBKc146mMiYexxvSc7egho5/TSteyNaVOwtxKqnvEHv0D4a3p2N79WXaXvdNgglW+
         M5zg==
X-Forwarded-Encrypted: i=1; AJvYcCU/WCJbXr7Lzj+cA3kQOcFhEUqmuBTY70Pu7ziOppsUIXhAS4yDoOLQCf6E8nRtJHQiWpfaOmzGT5kWhOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZl4VXs5/J1YsmqQlwVoIPyrP0Id4W9QpuZqFSad3SaaRyXAdf
	QgqquUR6OO8qAjTMHd4KZ+8hdTvBWlbL39goSa6Ven14unrYZjxJGi+BbcY5zCszzGgU3JFUztz
	1Lh4r90FbcQgFj6tgAdzD10Sj39MRCv0=
X-Gm-Gg: ASbGnctHQpZ3/po/ZrYV98Ts0b4dBsVIwy/1FKm4RW6gfbU2P3eebIeftlTCBgDYuSg
	FIKokfEKxHpeYvZEpGCHN9yhpkpu1ua/NRMjl8OBNKahJZWoIpf4Y5C5Um9DboitHm5LijzzwHw
	zViC0t3shnlfO8lnlvIBd+G7yNJ6EhhZ4k9TzLgsy1R7fs17VwzFUO1bVeq9eICSQQnbtPgVvMh
	2aTQI7mNbcBW7dCgoE=
X-Google-Smtp-Source: AGHT+IGBZ7w/dfI527SR+DjinfNWuVbsu36wytkW8N4l6YT8Yd5aYP89lAVW8ZijJwwDy/9hDaIyx8WtdOiU1h8rzkU=
X-Received: by 2002:a05:6870:9e8b:b0:2ff:8c8e:c222 with SMTP id
 586e51a60fabf-30701d5dc82mr361913fac.14.1753416385412; Thu, 24 Jul 2025
 21:06:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724165639.13926-1-suchitkarunakaran@gmail.com> <90864bf5-2edb-4901-9566-c89431c6d717@arm.com>
In-Reply-To: <90864bf5-2edb-4901-9566-c89431c6d717@arm.com>
From: Suchit K <suchitkarunakaran@gmail.com>
Date: Fri, 25 Jul 2025 09:36:14 +0530
X-Gm-Features: Ac12FXz44GOWvQ9VHe3SSaOhUjxs0ZPwCO46dWoM-kiLqy_XkQMRtojfL8c4zg4
Message-ID: <CAO9wTFgFqmKWdF5bhpqh2ffrUb7QH8mqUNH1nieOMDFn_fUcDA@mail.gmail.com>
Subject: Re: [PATCH] arm64: allow NR_CPUS=1 for non-SMP and adjust default accordingly
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, 
	linux-arm-kernel@lists.infradead.org, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 25 Jul 2025 at 07:46, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> On 24/07/25 10:26 PM, Suchit Karunakaran wrote:
> > The arm64 Kconfig for NR_CPUS previously required a minimum of 2 CPUs.
> > This patch changes the minimum allowed CPUs to 1, enabling single-core
> > non-SMP configurations.
> >
> > Additionally, the default value for NR_CPUS is now conditional:
> > - Defaults to 1 if SMP is not selected (non-SMP systems)
> > - Defaults to 512 if SMP is enabled
>
> Just curious - what actually prompted this change ?
>

Hi, sorry I think I should've explained it in the commit message. So,
in linux/include/linux/threads.h, there's this fixme comment:
/*
 * Maximum supported processors.  Setting this smaller saves quite a
 * bit of memory.  Use nr_cpu_ids instead of this except for static bitmaps.
 */
#ifndef CONFIG_NR_CPUS
/* FIXME: This should be fixed in the arch's Kconfig */
#define CONFIG_NR_CPUS 1
#endif

And the original commit is as follows:

commit 278d1ed65e25d80af7c3a112d707b3f70516ddb4
Author: Rusty Russell <rusty@rustcorp.com.au>
Date:   Tue Dec 30 09:05:12 2008 +1030

    cpumask: make CONFIG_NR_CPUS always valid.

    Impact: cleanup

    Currently we have NR_CPUS, which is 1 on UP, and CONFIG_NR_CPUS on
    SMP.  If we make CONFIG_NR_CPUS always valid (and always 1 on !SMP),
    we can skip the middleman.

    This also allows us to find and check all the unaudited NR_CPUS usage
    as we prepare for v. large NR_CPUS.

    To avoid breaking every arch, we cheat and do this for the moment
    in the header if the arch doesn't.

    Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
    Signed-off-by: Mike Travis <travis@sgi.com>

diff --git a/include/linux/threads.h b/include/linux/threads.h
index 38d1a5d6568e..052b12bec8bd 100644
--- a/include/linux/threads.h
+++ b/include/linux/threads.h
@@ -8,17 +8,17 @@
  */

 /*
- * Maximum supported processors that can run under SMP.  This value is
- * set via configure setting.  The maximum is equal to the size of the
- * bitmasks used on that platform, i.e. 32 or 64.  Setting this smaller
- * saves quite a bit of memory.
+ * Maximum supported processors.  Setting this smaller saves quite a
+ * bit of memory.  Use nr_cpu_ids instead of this except for static bitmaps.
  */
-#ifdef CONFIG_SMP
-#define NR_CPUS CONFIG_NR_CPUS
-#else
-#define NR_CPUS 1
+#ifndef CONFIG_NR_CPUS
+/* FIXME: This should be fixed in the arch's Kconfig */
+#define CONFIG_NR_CPUS 1
 #endif

+/* Places which use this should consider cpumask_var_t. */
+#define NR_CPUS CONFIG_NR_CPUS
+
 #define MIN_THREADS_LEFT_FOR_ROOT 4

 /*

This motivated me to do this. Please let me know if I misunderstood
something or I'm doing something incorrectly.

