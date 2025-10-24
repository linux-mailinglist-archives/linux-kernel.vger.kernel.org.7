Return-Path: <linux-kernel+bounces-868511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A54C055EA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A44311A087C1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C48D30AD09;
	Fri, 24 Oct 2025 09:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SnNmkUOu"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE9E303A0A
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761298520; cv=none; b=dNKeSvRw0iOK3dwcPOmHMkE7AusPdhb80VWiGIZ8p1GaX1YKnK2WlxzBzNuDlrKumOXNlY6kXdeMUnNfjFjcPAZG0sGgjlondLcOlxsybrdn0cKArw+FCW/OJ39pgc7LGp07rS+oRpqGwM7n6jcD5+F55hodcg0GE3MEzIm3BIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761298520; c=relaxed/simple;
	bh=GlUefLpUxaf97bsCrf8Uoodrh4iCQAJxJMfBklTXkSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eI5l7Asaz+M9vZLnqikHq8MnITiyPEVAwWliQLnebmHf8N+D4kBBmtBj1H1eBeb9iR0AFB8sFLhTFRT5J175Oneyk86/dNlWlfv37KbnJeFNhpirNQ+nLm4wOLmRwhAWvAXCu3IyKK80zKEuTOqPQfif1Zi4rQJI7JAiASJBajA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SnNmkUOu; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-471131d6121so14286685e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761298516; x=1761903316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JbHQ9Yll+18kGv8Q4G1mY89TauTgNbmP1REuXJUqmFg=;
        b=SnNmkUOu3Jwr33LD25oYRQBeuU1XLHTJCAD4fRQZNxT2UQ19f9hQAwgPO4x5PVs8qw
         24ISYGOIi0DIo3md4LhHjp39UeOcPCexf4VPE9Nd2Jaei6DO0GkHNVHJWCTX/wwkKLTc
         soaxSSwoshEE5d1+iR2JPhtd64CTCe+cbgJm1ogqZibcD5GG8tn0iziL4YzeTnf4YMY7
         zZr0u7iaqi5ZtJsAyV3ESsWd0fxRduraC6Si6RAIXeALe+fzIFU2M2tN2dggEW4jP8ee
         oQSjMq7i+73C/tghdik81JeMjLGAkIrVWwzSHDytUBkeZq4dy0PIuQ3erNVbDx16oUqW
         vQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761298516; x=1761903316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbHQ9Yll+18kGv8Q4G1mY89TauTgNbmP1REuXJUqmFg=;
        b=RGTmGB4AzhY/UzklJjwZZ1C1VsU8KJto2DWb0tRVbyqpHY5GRUjX2TOC1MhC6L/fAQ
         uey92s7plra4QVbNocwY7Nh0U97mGq0hKrNsclqgxZ3nksYwZjhvbP+1ncAOJL9Xrmt4
         l/AssAQ9hVhCuGlvORiGvE+kCAMjaqhN72LYDv/ipJpkePAJast4HDCoyR9xb79Fu8Up
         X2YkJPoKqMZxtu1N99Jk64SCuyjQ3eCmuGSnifBYLmNu5+qIRW10yQ4tiyfuXERgw0tl
         doufXUwf07yoZInLpKPy/ZbZteGoC1llwks+kYhmFa429s3bNSvmIZorQLGD294shKao
         PTFw==
X-Forwarded-Encrypted: i=1; AJvYcCVOYGoQSUmIrzbEjGIkNLPa9fu3mYGY2gDHnzl1Y0KCi2JISAkKHJAXWXvCM6wGScVRjbSKmNO+MujLyN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHunAGlDc6iycpF6fA8K29ejWtSeJtspIj0yHKbG2gGutHNLn3
	WTfUkz2vDQG1AKGfhTw10wVrZjMbpgJEE2QiVAYXPNc+Gz3InB2gLRxRkNp5JY3aLrg=
X-Gm-Gg: ASbGncsmLYz20AeVGqVtuQ28onOZP7Tew38EV9zrjHsV2Z6zJT5sZFdCJJymqcuoazK
	2v1lDxDyhDBbKvwNpKrJ3seKSpDGaMqBwzQUmnXZ7896RjJdITunbWonK0dIKGGNOffdraBI4yE
	a9PqNekPEf75ukjSMJjmNhbzS9l7CLaz4XMZdaWHsiyXeCOroSKvSOxlMpfvSoDjTxQmLO+fl/i
	LWPJEPLLUdj0UpVjNjxlkcN6LQmPpSVcTnPLve50+ARdLWXs6AuAWYAaCeQK92MOmZABtxeNE0I
	nQAnaE/4Bwa9RnQHOrFwsC6VM+Q8+nyqthYbM8n3oq9q1J9lKNTTOZBj9VPBmxUx6rlFdpS0+Wx
	7izYTt6CNAHUds/P1SYdXGmwA1OshCo314lmXe8LWJ1WaY+Ys9w/PitmhYYCKoWgWnmsTviLOUr
	BYA48=
X-Google-Smtp-Source: AGHT+IEVeOtivGKfs511LEFtRbNEpqMJ8MKLLCrxeJpIhAwP+fpOLm4RUScJ1XdRje4QVNuYGFJqOw==
X-Received: by 2002:a05:600c:3555:b0:470:fe3c:a3b7 with SMTP id 5b1f17b1804b1-4711786d42dmr203430315e9.5.1761298516428;
        Fri, 24 Oct 2025 02:35:16 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475cae9253bsm78998185e9.1.2025.10.24.02.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 02:35:16 -0700 (PDT)
Date: Fri, 24 Oct 2025 11:35:14 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Oleg Nesterov <oleg@redhat.com>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] printk_legacy_map: use LD_WAIT_CONFIG instead of
 LD_WAIT_SLEEP
Message-ID: <aPtIUq7hf4R5-qfF@pathway.suse.cz>
References: <20251022154115.GA22400@redhat.com>
 <20251023103234.GA27415@redhat.com>
 <20251023142655.FvZkeSa-@linutronix.de>
 <87wm4lbqt2.fsf@jogness.linutronix.de>
 <20251023151112.goqBFQcM@linutronix.de>
 <20251023154657.GD26461@redhat.com>
 <20251023191442.Uu0mD_Nq@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023191442.Uu0mD_Nq@linutronix.de>

On Thu 2025-10-23 21:14:42, Sebastian Andrzej Siewior wrote:
> On 2025-10-23 17:46:58 [+0200], Oleg Nesterov wrote:
> > Again, quite possibly I am wrong. please see my reply in another thread,
> > https://lore.kernel.org/all/20251023152942.GC26461@redhat.com/
> > 
> > On 10/23, Sebastian Andrzej Siewior wrote:
> > >
> > > This does not matter. My point is that there no need for this ifdefery.
> > 
> > I disagree. Rightly or not. To me this ifdefery in printk.c make the intent
> > more clear.
> > 
> > I am still thinking about the possible cleanup of the current usage of
> > DEFINE_WAIT_OVERRIDE_MAP(), but I think that, whatever we do, this cleanup
> > should take CONFIG_RT into account.
> 
> Right. Please just do s/SLEEP/CONFIG as discussed. Please leave
> PROVE_RAW_LOCK_NESTING out of it while arguing why this change is
> correct.

It is clear that the commit message and the comment above the mapping
caused some confusion. I thought about better wording.

I wanted to be as clear as possible, But the problem is that everyone
has different background and might understand the same term
differently. Also I am not a native speaker.


/*
 * Some legacy console drivers might violate raw_spinlock/spinlock nesting
 * rules when printk() was called under a raw_spinlock and the driver used
 * a spinlock. It is not a real problem because the legacy drivers should
 * never be called directly from printk() in PREEMPT_RT.
 *
 * This map is used to pretend that printk() was called under a normal spinlock
 * to hide the above described locking violation. It still allows to catch
 * other problems, for example, possible ABBA deadlocks or sleeping locks.
 *
 * The mapping is not used in PREEMPT_RT which allows to catch bugs when
 * the legacy console driver would get called from an atomic context by mistake.
 */


And the commit message might be:

<commit_message>
printk_legacy_map: use LD_WAIT_CONFIG instead of LD_WAIT_SLEEP

printk_legacy_map is used to hide possible violations of
raw_spinlock/spinlock nesting when printk() calls legacy console
drivers directly. It is not a real problem in !PREEMPT_RT mode and
the problematic code path should never be called in PREEMPT_RT mode.

However, LD_WAIT_SLEEP is not exactly right. It fools lockdep as if it
is fine to acquire a sleeping lock.

Change DEFINE_WAIT_OVERRIDE_MAP(printk_legacy_map) to use LD_WAIT_CONFIG.

Also, update the comment to better describe the purpose of the mapping.
</commit_message>


Is this better and acceptable, please?
If not then please provide alternatives ;-)

Best Regards,
Petr

