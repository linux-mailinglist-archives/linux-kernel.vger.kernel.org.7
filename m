Return-Path: <linux-kernel+bounces-733184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 361A9B07144
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34C82178F0E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F322F2707;
	Wed, 16 Jul 2025 09:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGaQsBMi"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBED2F2365
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752656968; cv=none; b=aNM5E2omZuDTA6Hg9KSjOnrd29ojgrERVvvqtAo7ju5tv1liUEYFb8T9jNTH31rVqsSjMf0NEQbfJKX1IMCkBtpEhnY8CCzjgl8/p2hWk8pRnjus2w/gSpbT60d7L2iu5KMknhxWp6E5xMFBces4sVQrYJI+pV3aogtJ81GgQ+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752656968; c=relaxed/simple;
	bh=Wlyj5BDsEtRjW9virg0GuEbkQegL6rlEcKbTaJYzgE4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlZsJ7aP2HnlG1xIrPIYLNSdut8zyD4hhALqWCIaBEZhkP11aijhZ3EGkVQp6EPfpxZA3vz6vAyNKooD4qY+2UOg8LdFxFCpbkm+HQJKkacOz1tupdiM8SKezeqY8WErgDI6oo4GKCYW8fZ1IKcm5jYmbGMpLM4FCXB5p/vj2ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGaQsBMi; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-555024588a8so5566264e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 02:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752656965; x=1753261765; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2eOTiw68BIyhYHvtk2S5wRVGB/8ahHu3vX68UO+Adzs=;
        b=LGaQsBMi5lVZ9p9Q/KpHdR4PE1nW8UPouZP3Ac/aXsDt/w+UIxDi3vFD536u9LOG3W
         psSWmZJP0ohdlm/QybrFgfGy7f4uhTvvZ9gBBqj25UzUacvfdJT0pNHmzpdE1pEqejFn
         MSMrt41xq5Pg7pHVCSvWjwjbuP8YwlyFpCO1IGDEqnxHUgWVVbGFflh117K2j01teTsf
         ruWMpwVJrIAKQTw76e9TwxUmncwULZ/LeX0V1P7z6oNclPu16U3ZxssI/zFuxVgIVJjr
         wDhK09gUftxt27WkJKPTiPL64qEt0Zzlu6dIy1iukypQhot0wTgABAmJy93S7TMVLUVS
         xzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752656965; x=1753261765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2eOTiw68BIyhYHvtk2S5wRVGB/8ahHu3vX68UO+Adzs=;
        b=aecMtaJuHaNkLP0wtZ95c2nuwEZusMhY4dy0lJcEzrzCFMIFCRWRrGc7Zi1bbY6f1A
         o68b7NlAX6nLeKfhf/Mp9cZihSFBCEzVPziwj5jOLVF3VKYL6Via+PpycWbjuOVxzDIB
         5PUT4d3HVLjBZTvEE8nFRsiqvTQIAbQ/HfWBsRZyQspOo8J4on742uOXHEPGbhB27KU4
         mI7nBn3965MD99DoeavJ6z5iXxrjmQq/XxoWpVljF5Xj1QTdAxSA5lWZ8vOi6Yh/ZvuW
         im7eCuDFO6S/auxTT6QeSblpiIs6iBc6f+DwDBpq6j0sPP2VUCQup7yDqNUAKewu7V0D
         b4yg==
X-Forwarded-Encrypted: i=1; AJvYcCUCMvUkYA9FDnEpy4XqQ9lz85L1jUpWpDXLxcRkwHMx6gK+wWpjyr36CdOEz+amkdINPJ3Lv0SNOFxEwTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQSFfeNCMvV8BcJtSn7f8mJIJQWXO879xASqJ8VXf2HBWoLfK2
	Whbz9tIaHSKu6xEeBWvYiiUTGgXV5GcrYd/DQCZ+HkZ6fvWWf4ylqhs+
X-Gm-Gg: ASbGncu7x0FPFKmPNj3RMsvIQE8uMcBfnfvjMRusq/3krI0QKIHxYkqGhJU0FY2twx7
	/zXP1JLhMe0FnMVzYZ0w5+r4WdnVGHx+t1v4CvAf1A2+atHtkgsvmG5oqJWa3MOik0qMY+XDAzS
	+A+TaYEXe25jxyy3up7uFn83WqMq3O+ZEQlCUE1rHOoFFq0wZ4rnJU+6AxbdwWpC/KwpQqob+B1
	oQz09f6qf+OycDn5aTydxoiaMP9aZ4GxuwmW0Sf8hb4rc7k6ezRxdVAGDsLo4TNshdVftc3u+bF
	75Je3dJ24M1v9NKI/c3CICI1l71lTYJnKbgH/W8G779b6kG+PAWi25GfDc2w2DVQLfw/3FtzPUK
	UMSRHKxnpv71rOweqehbhjjQcWYsV0qXFZicRWeqaN+bw50U=
X-Google-Smtp-Source: AGHT+IG5WLfntZKDWbVYrqQzZ0ESIP+d42sAu4LjtSqz7jbMmWEtzmxAMa2+osPJFNGzNyu9Jnn4yg==
X-Received: by 2002:a05:6512:1313:b0:553:1f90:cca4 with SMTP id 2adb3069b0e04-55a23eef245mr521782e87.13.1752656964569;
        Wed, 16 Jul 2025 02:09:24 -0700 (PDT)
Received: from pc636 (host-95-203-27-91.mobileonline.telia.com. [95.203.27.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c9d0f1fsm2561084e87.107.2025.07.16.02.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 02:09:23 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 16 Jul 2025 11:09:21 +0200
To: Byungchul Park <byungchul@sk.com>, Yeo Reum Yun <YeoReum.Yun@arm.com>,
	Andrey Konovalov <andreyknvl@gmail.com>
Cc: Yeo Reum Yun <YeoReum.Yun@arm.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"glider@google.com" <glider@google.com>,
	"dvyukov@google.com" <dvyukov@google.com>,
	Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
	"bigeasy@linutronix.de" <bigeasy@linutronix.de>,
	"clrkwllms@kernel.org" <clrkwllms@kernel.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"max.byungchul.park@gmail.com" <max.byungchul.park@gmail.com>,
	"ysk@kzalloc.com" <ysk@kzalloc.com>,
	"kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
	"kernel_team@skhynix.com" <kernel_team@skhynix.com>,
	"urezki@gmail.com" <urezki@gmail.com>
Subject: Re: [PATCH v2] kasan: remove kasan_find_vm_area() to prevent
 possible deadlock
Message-ID: <aHdsQYvKN-dLQG2O@pc636>
References: <20250703181018.580833-1-yeoreum.yun@arm.com>
 <CA+fCnZcMpi6sUW2ksd_r1D78D8qnKag41HNYCHz=HM1-DL71jg@mail.gmail.com>
 <20250711020858.GA78977@system.software.com>
 <20250711021100.GA4320@system.software.com>
 <GV1PR08MB1052126BB553BD36DA768C998FB4AA@GV1PR08MB10521.eurprd08.prod.outlook.com>
 <20250713232740.GA18327@system.software.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250713232740.GA18327@system.software.com>

On Mon, Jul 14, 2025 at 08:27:40AM +0900, Byungchul Park wrote:
> On Sat, Jul 12, 2025 at 03:46:10PM +0000, Yeo Reum Yun wrote:
> > Hi ByungChul,
> > 
> > [...]
> > > I checked the critical section by &vn->busy.lock in find_vm_area().  The
> > > time complextity looks O(log N).  I don't think an irq disabled section
> > > of O(log N) is harmful.  I still think using
> > > spin_lock_irqsave(&vn->busy.lock) can resolve this issue with no worry
> > > of significant irq delay.  Am I missing something?
> > 
> > I don't agree for this.
> > since in PREEMPT_RT case, it has the same problem.
> > 
> > In case of PREEMPT_RT, spin_lock_irqsave() becomes rt_spin_lock() which is sleepable.
> > But, KASAN calls "rt_spin_lock()" holding raw_spin_lock_irqsave() which is definitely wrong.
> 
> It's another issue than irq handling latency, but it's about lock usage
> correctness.  You are right.
> 
There is vmalloc_dump_obj() function which should be used IMO:

<snip>
pr_err("The buggy address %px belongs to a vmalloc virtual mapping, dump it...\n", addr);
vmalloc_dump_obj(addr);
<snip>

we use trylock there to eliminate an issue if invoked from the IRQ
context.

--
Uladzislau Rezki

