Return-Path: <linux-kernel+bounces-857970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEB9BE86CA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 007EC6E2BDE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601FE34AB15;
	Fri, 17 Oct 2025 11:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LiXrD0Io"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FD034AAFB
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 11:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760700851; cv=none; b=g+Kv8Yv1+LtHC0iXH1lYQQMwAaC0hpEaoQu9mSfAgZYbxL/Sksx+swAHZW9v2QIdf9BhuYh/4pspfu+fGQMmubMKeXsdi7bVmTSPVR+IApk8YelF4zsXMIBdhataDsTfbljeGVIgLf+H4IQ+ie9/mScB81TYyvHYVM0uvDv504Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760700851; c=relaxed/simple;
	bh=6UuS0oOQIT85kTgtGPRWnqJQa8gZp8Ff7I1X3a1wt/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6fpy1WsMmimVCiyen2T4S64UcQ2SgMKuAP2IEpJgYMVWOGe5IEt+s984kksdsAC4fa4slo75qKzF31wnd8ms0cL2wNo9EKqhSmfGkqcg8vtvphOi7dD3qs3j5ijHmAgoDLC9tGUv+J7SAjCzmpbMdh6tXuEHtxHOpxNLTjd734=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LiXrD0Io; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47117f92e32so7499045e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760700846; x=1761305646; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SvkRtEfFY44KSkmHTWo/OqVypeDVfWVsWktvMnmmBeo=;
        b=LiXrD0IoKoP9WN5WK+e3tUk1N6JA2SeELvvH0/xBQtxON/n2hkbry52AMz3H+TWZTA
         ujawuOkbzTHIsiykTdQ9A7sE2g7FZyKXH92r0FJAbCwe6O7et8nn+ynsHvbb6qnLL3Ga
         Q+vGsbvs8Y14gihOLPggfZanoqo2jDitefNKkkX1jJ0pUOc0Cg2NbJUnsuayrqrJNeiG
         ZGM1ICewMy7RFl9D2TBE7GGtGUtUNbePxgBjD4D9NsDrkDnA2OnEXKXiCMG4KTRMdiJW
         KkRRWEYAjqft6QKYDb3okJel0DdoNtM8h3oRVR01kfGrwBVMi5Jh4orrL85o/E2Os+hb
         TdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760700846; x=1761305646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SvkRtEfFY44KSkmHTWo/OqVypeDVfWVsWktvMnmmBeo=;
        b=akzP6Ou4BbWQtkwis7L/q2aCyymg8to8nr1bIBPmRWYcVWI9cE5IQV8orlBzBg2fCH
         DjnlJiAFIN8Rb3zI3fIEJEDM0CC3UPLfapHLTPUbrgzvoFrk7eZtwbZiRstGVe5Lv53t
         3IkEMiLZKrfdewpQ7XFelm2OLftyw5idK2G4Tbwo6dYUK6Q2IfgosknE1T47+mPA+a/F
         4w6wQtUDk6guWRkno1ToTVvsBDt7AtHBrp2IKYB3D0j3PKrulxtH7eOcH+0OpmPS1beh
         B91dKm1H6G/Drvq9lTzpj5nT8rbqAagqy82ZJeGIwErOcAYW57mCfVGvIqje2J3IhXlR
         NxmA==
X-Forwarded-Encrypted: i=1; AJvYcCV9HoeoKb77bNjo8aqi7Z86e4xMOPqw0oUks2wEJ9Qr7zwet8xw+QePg3G5bkHZtz8+IGGK8VWhcbPhkbk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7FF9wM9+G2JeahG1I9EYBNkqdFj8wRAgCLPU6YBNKv/lEPsYa
	LX4u+Vqnle4CLd7gvDVLqu8Xxix6vXpIq+0VCcLxeJ92iz1boJAOiCrM8gATkNunMDk=
X-Gm-Gg: ASbGncvm49tR4r5Za+Gh4OiVxnhWFhZooTzrSVWE975foOAM2E+r37JDjpoRq7vr9r1
	V0/SESqrHh4W/E1rGu1g/9fAX/8V66s0xjEkJM6wYug3XVa1krOqvfuYm/YQahSRKJfc0lUUOmy
	gx/LpLf6Yb1b2Hm+ixKiQWtYY3oS7PshKLbEs64AZ0QDNtdoBHrkv/TzAzMQxBrmdTxAIxDn85K
	j52sWLG53ZRJmt6jKZQ9vv0LeLkaBJX7GghybxXBViTNif3eNzXxDTjQSFSbVktKCFvFKI8J3nV
	uUFYTN31PQls0vlvIqIYURRAzMOj1BrsLo1yNrDwYW/jCT07JTtix/nkn1stmWEt6QFYXCBw8W5
	ITT5apNxj2sWrBMA+PACQR85F+edHoCXLDDeS4QoJXUZlQJT0l7ZvJ77ZiLjsVayeYaMhUp3qwi
	HZonU=
X-Google-Smtp-Source: AGHT+IG+UnEp2b7Yue1jCZ/70/3WE2TI5L6wdx4OGrQSOn0VeOaD8ulTrB8zeTdZAWnnw8KF5KoYOA==
X-Received: by 2002:a05:6000:2307:b0:425:8125:b108 with SMTP id ffacd0b85a97d-42704dab10dmr2158926f8f.54.1760700846044;
        Fri, 17 Oct 2025 04:34:06 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42704141cdfsm7138939f8f.4.2025.10.17.04.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 04:34:05 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:34:03 +0200
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH v6 0/5] Handle NBCON consoles on KDB
Message-ID: <aPIpq17rUbNbLEWT@pathway.suse.cz>
References: <20251016-nbcon-kgdboc-v6-0-866aac60a80e@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016-nbcon-kgdboc-v6-0-866aac60a80e@suse.com>

On Thu 2025-10-16 11:47:53, Marcos Paulo de Souza wrote:
> In v6 the patches were rebased on top of v6.18-rc1, added Reviewed-by tags from
> John and did some small changes suggested by him as well.
> 
> As usual, how I tested the changes:
> 
> Testing
> -------
> 
> I did the tests using qemu and reapplying commit f79b163c4231
> ('Revert "serial: 8250: Switch to nbcon console"') created originally by
> John, just to exercise the common 8250 serial from qemu. The commit can
> be checked on [1]. I had to solve some conflicts since the code has been
> reworked after the commit was reverted.
> 
> Then I would create three different serial entries on qemu:
> -serial mon:stdio -serial pty -serial pty
> 
> And for the kernel command line I added:
> earlyprintk=serial,ttyS2 console=ttyS2 console=ttyS1 console=ttyS1 kgdboc=ttyS1,115200
> 
> Without the last patch on this patchset, when KDB is triggered, the mirroring
> only worked on the earlyprintk console, since it's using the legacy console.
> 
> With the last patch applied, KDB mirroring works on legacy and nbcon
> console. For debugging I added some messages to be printed by KDB, showing
> also the console->name and console->index, and I was able to see both
> ->write and ->write_atomic being called, and it all working together.
> 
> [1]: https://github.com/marcosps/linux/commit/618bd49f8533db85d9c322f9ad1cb0da22aca9ee
> [2]: https://lore.kernel.org/lkml/20250825022947.1596226-1-wangjinchao600@gmail.com/
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
> Changes in v6:
> - Rebased on top opf v6.18-rc1
> - Changed some includes, as suggedted by John
> - Reworked comments as suggested by John
> 
> Changes in v5:
> - Added review tags from Petr
> - Changes the way we detect if a CPU is running KDB.
> - Link to v4: https://lore.kernel.org/r/20250915-nbcon-kgdboc-v4-0-e2b6753bb566@suse.com
> 
> Changes in v4:
> - Added ifdefs to only check for KGDB if KGDB was enabled, suggested by John Ogness
> - Updated comments about KDB on acquire_direct, suggested by Petr and John
> - Added a new patch to export nbcon_write_context_set_buf, suggested by Petr and John
> - Link to v3: https://lore.kernel.org/r/20250902-nbcon-kgdboc-v3-0-cd30a8106f1c@suse.com
> 
> Changes in v3:
> - Only call nbcon_context_release if nbcon_context_exit_unsafe returns true (John Ogness)
> - Dropped the prototype of console_is_usable from kernel/printk/internal. (Petr Mladek)
> - Add comments to the new functions introduced (Petr Mladek)
> - Flush KDB console on nbcon_kdb_release (Petr Mladek)
> - Add an exception for KDB on nbcon_context_try_acquire_direct (John Ogness and Petr Mladek)
> - Link to v2: https://lore.kernel.org/r/20250811-nbcon-kgdboc-v2-0-c7c72bcdeaf6@suse.com
> 
> Changes in v2:
> - Set by mistake ..
> - Link to v1: https://lore.kernel.org/r/20250713-nbcon-kgdboc-v1-0-51eccd9247a8@suse.com
> 
> ---
> Marcos Paulo de Souza (5):
>       printk: nbcon: Export console_is_usable
>       printk: nbcon: Introduce KDB helpers
>       printk: nbcon: Allow KDB to acquire the NBCON context
>       printk: nbcon: Export nbcon_write_context_set_buf
>       kdb: Adapt kdb_msg_write to work with NBCON consoles
> 
>  include/linux/console.h   | 55 ++++++++++++++++++++++++++++++++++++
>  include/linux/kdb.h       | 16 +++++++++++
>  kernel/debug/kdb/kdb_io.c | 47 +++++++++++++++++++++----------
>  kernel/printk/internal.h  | 45 ------------------------------
>  kernel/printk/nbcon.c     | 71 +++++++++++++++++++++++++++++++++++++++++++++--
>  5 files changed, 171 insertions(+), 63 deletions(-)

With the two below compilation fixes, the series seems to be ready for
linux-next.

I am going to wait with pushing a week or so to give other printk and
kdb maintainers and reviewers a chance to look at it.

The following two changes are needed to fix build with
CONFIG_PRINTK and/or CONFIG_KGDB_KDB disabled. I am going
to do the in the respective patches when committing:

diff --git a/include/linux/console.h b/include/linux/console.h
index 81d2c247c01f..690a5f698a5c 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -664,7 +664,7 @@ static inline bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt) { return
 static inline void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt) { }
 static inline bool nbcon_kdb_try_acquire(struct console *con,
 					 struct nbcon_write_context *wctxt) { return false; }
-static inline void nbcon_kdb_release(struct console *con) { }
+static inline void nbcon_kdb_release(struct nbcon_write_context *wctxt) { }
 static inline bool console_is_usable(struct console *con, short flags,
 				     bool use_atomic) { return false; }
 #endif
diff --git a/include/linux/kdb.h b/include/linux/kdb.h
index db9d73b12a1a..741c58e86431 100644
--- a/include/linux/kdb.h
+++ b/include/linux/kdb.h
@@ -226,7 +226,7 @@ static inline void kdb_init(int level) {}
 static inline int kdb_register(kdbtab_t *cmd) { return 0; }
 static inline void kdb_unregister(kdbtab_t *cmd) {}
 
-static inline bool kdb_printf_on_this_cpu(void) { return false };
+static inline bool kdb_printf_on_this_cpu(void) { return false; }
 
 #endif	/* CONFIG_KGDB_KDB */
 enum {


Best Regards,
Petr




> ---
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> change-id: 20250713-nbcon-kgdboc-efcfc37fde46
> 
> Best regards,
> --  
> Marcos Paulo de Souza <mpdesouza@suse.com>

