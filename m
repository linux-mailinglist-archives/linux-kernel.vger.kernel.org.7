Return-Path: <linux-kernel+bounces-727239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DA6B016F0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDB0C1C22923
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A1A20D50B;
	Fri, 11 Jul 2025 08:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGXMa5go"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24832080C8
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 08:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752224081; cv=none; b=sB0+W1KXS/GYFbaEmv6vGZhQrQ87+vsZhvjDFuENGEUyTcxP7BllSs+wHEiyqKQ257SYeoX1cueJelmH7t2X8vHoR6BquIfqC5tkSLdO7fJEk7lHHbCoBub3aIUK2I3zbnugSvKeOzYThFnZyFErlkrchrU7GSual3jXkMn4cHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752224081; c=relaxed/simple;
	bh=nc/SvkTbpBhT+d4ORjgE3oFjs6JCVP03Zm2AtIezNs0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9tRHduoy+71Pn6jPDU/hn/OzWwHbBtIlp9I+JvnmL4TTjLLY2gssNzPe8Ys3mAUMVvi+DCNPVBG0jlSPCdwwAlSHG0s4jX0RzsURjuYkXA5fqz5KDL0WlaHJYVVt0+P+5suIhdDRmL41kTiuygukdLqQlkgQ1r3rYq2j/1Vl8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGXMa5go; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-555024588b1so2098980e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 01:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752224076; x=1752828876; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ziEQtJ6TzJ+Y/Zcb94FyvvcznpnXNVBhWXC9sDmSYV4=;
        b=FGXMa5goGilNhlKOSjAI/2OjvMPlDrEBtob8WLi3l4JiDzR6p1SU30sYQg7mkpF7fg
         0D5cpepqXosDmkZgdkGfFZg4r1QUS6yYd8ZJnx01TxcZZ5D+uPUpQ/z46toT4TOGUYj2
         ANcM/NzxAMRjaGEPxlDP7h5gdF91Ym8nzqKnAwxkI9klu4elpFMCmti80iilVbfWFk/e
         t63tjIspZ4UdE4NxPJ8ni8ZsF7CeRe5D3DnIf7jCDNUEd4DmLfKhEiSd7BFchyISQk1E
         oCNq1E1Fj24MWz9mIlslv9zhALabVxSlaxpfQiLArVO1ctmm6aiRxeBVODGvy/ODb5n/
         x0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752224076; x=1752828876;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ziEQtJ6TzJ+Y/Zcb94FyvvcznpnXNVBhWXC9sDmSYV4=;
        b=TZhQNJWTl9VC+arLC958RBMpIgNucVvRBUZQk6+/Q0Wzo0tpOtPpsiQWFHNrq2UFOM
         jNWiHTqvEwtDCcvtUiTsgIPuSlIyfAdL/3LR/Rl+9P/v9M0m3pCEQckNH6PHHDjkNrOn
         3Gwb+xDm4KLXxr6+z8fcLfewW/bfjvUxZkI5ow6kTuMcOo54QUmqmafljo58wOO9pdHj
         oAAaOiwXcCnrO6uxvPdt4Py80mRv1M+xSQsZYrG0XdU9bA0WAmvMKJWH9YRZtxYDl3+Y
         V0GiBzUSdcO3Ek3KB2g88aHSCXNNyjHohDOmWmAWL27hnhPMguphmpqejhF/pmam/NSr
         0Lpg==
X-Forwarded-Encrypted: i=1; AJvYcCWCvLKyUrETfUPi58yCMTLaRKHMMOZ6g506voWTN/E3ZZlWwrADklHklLC01xxc+pe5K/fth72rVGyZUWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHf03TQwmZuRIc8Wn7H8GD2P138Av1EiDOtiEy4Gxty4ft4ELI
	5PFl6XvWfHKd52AoihL5yI5IHKbIRJoHtmlMtocJe3mI0BOPx0fTwSTU
X-Gm-Gg: ASbGncvBHrcOQxdqbdtweXLs592627ewZGUQS1rNQxQNHkCIsZ4bBENeGGIaklq6V2X
	onvd7ouvPfUL25tZr9Iv3iaTQoyVRMHksfPxlbYH6GHml/LazaFhGzN9t4tnSd1AGWU6rFt5gzx
	hu+uMXlPATZZwjvnwWZL69Itl0mm93a2pOvhfx35MbOgU2TjGFXhk789puw1LnkKtyetScPTre1
	mD51jUSboXkuC0OmnuDrTUr7Dk6pzBpzadQvVtviX3ml95BHmmh+/yvrKbjIgwAK80h3Wea8a+M
	z/adzipKKVZJf0ubb2EKE/jLLm8+PhyN5DMEQTknjvznspZQy4yUEyh/Kxj8OvdHk7WxngH3yOq
	p+7yV0USRv15BTGEA4OHF1RjslMj4dVgUOdv7EzzCRP9TQVJ1/w==
X-Google-Smtp-Source: AGHT+IFPqpkRmTjKeGpVvTou+tnFlMgMi9ZNeCVtfH9Y1Rk4EXvSbZNZFUirIWgtanrq34tOCvqwWg==
X-Received: by 2002:a05:6512:e9e:b0:553:543d:d996 with SMTP id 2adb3069b0e04-55a04609b15mr657418e87.33.1752224075346;
        Fri, 11 Jul 2025 01:54:35 -0700 (PDT)
Received: from pc636 (host-90-233-194-86.mobileonline.telia.com. [90.233.194.86])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55943b7a6f2sm820437e87.235.2025.07.11.01.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 01:54:34 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 11 Jul 2025 10:54:31 +0200
To: Byungchul Park <byungchul@sk.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>, akpm@linux-foundation.org,
	glider@google.com, dvyukov@google.com, vincenzo.frascino@arm.com,
	bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
	max.byungchul.park@gmail.com, ysk@kzalloc.com,
	kasan-dev@googlegroups.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	kernel_team@skhynix.com
Subject: Re: [PATCH v2] kasan: remove kasan_find_vm_area() to prevent
 possible deadlock
Message-ID: <aHDRR6WBISSljdcd@pc636>
References: <20250703181018.580833-1-yeoreum.yun@arm.com>
 <CA+fCnZcMpi6sUW2ksd_r1D78D8qnKag41HNYCHz=HM1-DL71jg@mail.gmail.com>
 <20250711020858.GA78977@system.software.com>
 <20250711021100.GA4320@system.software.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250711021100.GA4320@system.software.com>

On Fri, Jul 11, 2025 at 11:11:00AM +0900, Byungchul Park wrote:
> On Fri, Jul 11, 2025 at 11:08:58AM +0900, Byungchul Park wrote:
> > On Thu, Jul 10, 2025 at 02:43:15PM +0200, Andrey Konovalov wrote:
> > > On Thu, Jul 3, 2025 at 8:10 PM Yeoreum Yun <yeoreum.yun@arm.com> wrote:
> > > >
> > > > find_vm_area() couldn't be called in atomic_context.
> > > > If find_vm_area() is called to reports vm area information,
> > > > kasan can trigger deadlock like:
> > > >
> > > > CPU0                                CPU1
> > > > vmalloc();
> > > >  alloc_vmap_area();
> > > >   spin_lock(&vn->busy.lock)
> > > >                                     spin_lock_bh(&some_lock);
> > > >    <interrupt occurs>
> > > >    <in softirq>
> > > >    spin_lock(&some_lock);
> > > >                                     <access invalid address>
> > > >                                     kasan_report();
> > > >                                      print_report();
> > > >                                       print_address_description();
> > > >                                        kasan_find_vm_area();
> > > >                                         find_vm_area();
> > > >                                          spin_lock(&vn->busy.lock) // deadlock!
> > > >
> > > > To prevent possible deadlock while kasan reports, remove kasan_find_vm_area().
> > > >
> > > > Fixes: c056a364e954 ("kasan: print virtual mapping info in reports")
> > > > Reported-by: Yunseong Kim <ysk@kzalloc.com>
> > > > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > > 
> > > As a fix:
> > > 
> > > Acked-by: Andrey Konovalov <andreyknvl@gmail.com>
> > > 
> > > But it would be great to figure out a way to eventually restore this
> > > functionality; I'll file a bug for this once this patch lands. The
> > > virtual mapping info helps with real issues: e.g. just recently it
> > > helped me to quickly see the issue that caused a false-positive report
> > 
> > I checked the critical section by &vn->busy.lock in find_vm_area().  The
> > time complextity looks O(log N).  I don't think an irq disabled section
> > of O(log N) is harmful.  I still think using
> > spin_lock_irqsave(&vn->busy.lock) can resolve this issue with no worry
> > of significant irq delay.  Am I missing something?
> 
> I prefer this one tho.
> 
> 	Byungchul
> > 
> > If it's unacceptable for some reasons, why don't we introduce kind of
> > try_find_vm_area() using trylock so as to go ahead only if there's no
> > lock contention?
> > 
>
I wish we get rid of using the find_vm_area() from already existing
users including KASAN outside of vmalloc. In some sense it is not
safe to access a VA because of "use after free" issues.

--
Uladzislau Rezki

