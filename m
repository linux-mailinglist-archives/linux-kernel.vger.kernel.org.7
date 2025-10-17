Return-Path: <linux-kernel+bounces-858572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AB8BEB2E0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 20:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF2F34FFF9B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107F7331A5F;
	Fri, 17 Oct 2025 18:17:05 +0000 (UTC)
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC8032E120
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 18:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760725024; cv=none; b=YyA7uZWyo08yoLtSgRWMbET+6Mufo395cf3PiVArdQbtrHtPfudnFNSgskeBVTgb7LHSgJUbbogIaMkG/2ZhRCHB2gp4YmsOh/8HhWHD1qAvwa2L+iNkZWJF7ItJiKLIWr0/6zNVx3n9ySvjBcXHuvY8OIHVbYnnJsH13DKhcd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760725024; c=relaxed/simple;
	bh=rJvNrY02s+ZucFNBz2Jl9T4sf21+yp9XMDRTutLQMTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r8Hu5CsQ/zdzLJfNeAjyxcGpMSVZrHzOjev9jUFO0qGC7DQdK8cE1KLSsULphSaPnqOc1I3Y3vrZ8nPTsg626yQMZ6ur4rpnx8eGJPdjS11L8nIMl/fx9lWSSRqE0Sjbm/nlJEIC9/Lk4K+CsU05kw2nbMz0rou1a8B+U6t5Mik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=yonch.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=yonch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-36f13d00674so1551263fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 11:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760725022; x=1761329822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cINqQqiT3g7xyevR8+vmcEschd9JtkqaiiAdm399BSs=;
        b=lt8FgnJnnoOR1IvlS0ExsqrXvvu4q/EKih+ByiQedE+e5b/GZR2nWYvqBKMusLi9pT
         RrGmOgtlxKRLQGao8nRogUbLlOJTaTe9oDu6PpEBI1XMPN2f8gv0yPMStoZa+w6YWM8k
         L4MIRcF7KDs/60ftKTJEEm8hhlryybZrz4tNep5CTX+CPYWD8pVu/ig9gVNlkkusFoSO
         tHvXd/d+Yd6kQXIF36xqsoZY47W9lICQvrdT3HcAnUrOp3famt+3I+Li0lbRLKSIWc/d
         d0eblqiigiY6rkvlCa6KSskmkRL3YxjASnb16h79rCnT5N+9CEUoFFmb3KUR2dcdsaTE
         fyjA==
X-Forwarded-Encrypted: i=1; AJvYcCUTzBePseLN5AyjHlvtoQcQdeJO79P7gH0DkMdrkS4eOdpVhqPUtEgVom2jDNrsAmH+xrPuQjn91KlEAJk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/svh0wy3eqhZwmFSYLDneHhGIaXQ8lV4z3EVwZIt7d4HTylCS
	43iqOpNM5I+XCq94M+ycibAy4qw7XH547dUNeHAtULqZ7BfUO3HjqdDd
X-Gm-Gg: ASbGncsvdHo0lQIJl2d4Hf6vE6vjA0y+aDXBwYV2qxM+Nng3bTPAo8yATXTp3hIEyBR
	fDHpsG4938/Jc8kLqw9IvM0PNbfopIWw1zkLxUAaaY9wxlMydfnJ5LtVjAcwRQVBrH59it3lMkP
	ZTmeTREllRliLhG3dElnC6kbbUarL78j55p0uspZQb4N6Ee7OMv97xxTWBmyI7RuTSW7Y/9LZvg
	/Km5cDX8XzPjZMQCMbE1vBw8RaaDmGlQnRvJM+j8o9FWQdoBPry9Q+LbY8VwkdYg6lKFnqdNn6X
	IEneMsjLdSnalmb5txd8P5+qMW4GGegjEjt/XFuJ3X5qNRMI3cboxdGNhrjwuE94fAsbrPH25L0
	inIuvnyhkAQNd2cjAKnRbEWUffqRkEy6/0zsIZC7lIz8rGgeSXm9CzjxNp+SmUzBcUOUCdD6xSi
	kw2H/kyfDhDSmU9WOYUxzD77OQKqfKBeH+rnwT/7kflh5/q8PVQvsmiqQg9n7RzuoHmgM=
X-Google-Smtp-Source: AGHT+IEkYynijOfioNXgVBL/J+ORYFf4SqheuHgsScwjHWbPv0aCz+9813qwbla3Zfgt+qTr9snjaA==
X-Received: by 2002:a05:6870:71ce:b0:332:3a47:9a05 with SMTP id 586e51a60fabf-3c98d0ac503mr2005539fac.26.1760725021852;
        Fri, 17 Oct 2025 11:17:01 -0700 (PDT)
Received: from localhost.localdomain (syn-067-079-108-173.biz.spectrum.com. [67.79.108.173])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3c9aefc4f9esm75178fac.7.2025.10.17.11.17.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 17 Oct 2025 11:17:01 -0700 (PDT)
From: Jonathan Perry <yonch@yonch.com>
To: tony.luck@intel.com
Cc: yonch@yonch.com,
	corbet@lwn.net,
	james.morse@arm.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	reinette.chatre@intel.com,
	romeusmeister@gmail.com
Subject: RE: [PATCH 0/8] resctrl: Add perf PMU for resctrl monitoring
Date: Fri, 17 Oct 2025 13:17:00 -0500
Message-ID: <20251017181700.62980-1-yonch@yonch.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <SJ1PR11MB60837F4BB475207D990C8293FCE9A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <SJ1PR11MB60837F4BB475207D990C8293FCE9A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > > Motivation: perf support enables measuring cache occupancy and memory
> > > bandwidth metrics on hrtimer (high resolution timer) interrupts via eBPF.
> > > Compared with polling from userspace, hrtimer-based reads remove
> > > scheduling jitter and context switch overhead. Further, PMU reads can be
> > > parallel, since the PMU read path need not lock resctrl's rdtgroup_mutex.
> > > Parallelization and reduced jitter enable more accurate snapshots of
> > > cache occupancy and memory bandwidth. [1] has more details on the
> > > motivation and design.
> >
> > This parallel read without rdtgroup_mutex looks worrying.
> >
> > The h/w counters have limited width (24-bits on older Intel CPUs,
> > 32-bits on AMD and Intel >= Icelake). So resctrl takes the raw
> > value and in get_corrected_val() figures the increment since the
> > previous read of the MSR to figure out how much to add to the
> > running per-RMID count of "chunks".
> >
> > That's all inherently full of races. If perf does this at the
> > same time that resctrl does, then things will be corrupted
> > sooner or later.
> >
> > You might fix it with a per-RMID spinlock in "struct arch_mbm_state"?
> 
> That might be too fine a locking granularity. You'd probably be fine
> with little contention with a lock in "struct rdt_mon_domain".

Good catch. Thank you Tony!

We might be able to solve the issue similarly to what adding a per-RMID 
spinlock in "struct arch_mbm_state" would do, but with only a memory 
barrier (no spinlock). I'll look further into it.

-Jonathan

