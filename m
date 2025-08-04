Return-Path: <linux-kernel+bounces-755340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D233FB1A521
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 16:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E6CB7AA248
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D14272E70;
	Mon,  4 Aug 2025 14:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAHmztOB"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C04272E72
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754318525; cv=none; b=HjsnxAXN8V6vAiNy6Px9ZbCxVzt/rfDSN9OoakZn49TR35AOUEKkw8Hyp0SiWUtTEmoSX/DqQtgLH40gnT28F/xREgbQUfqDdcjkcc7abBXZ/4tik+5+v1ewpollvHTxXsyqGomQMzMpnovcTDx6E5+OXDq4xUuX33H0wF0zgqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754318525; c=relaxed/simple;
	bh=j0hmUz7md469kCBUca3ORjGBdYa2O39tvf6/D4vBFu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q6f/0/z8FyYlQnYtyV4eFzcuSyps4QnWrM5e7QZk3dM2GcXEbxPBLaC39iz62SKLpw48j5QgHkoA2FCjP4Rto42vKd+gx1WgkhRsk+br9bfUzzbYDxhbDhF3oQp7KGmhS50vw3tQ6+7U1ySWssKF7tO+cVFyBOdQph44OxwnzBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAHmztOB; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71a379cecd5so23678047b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 07:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754318523; x=1754923323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9Qh5bbxJ0F6IApOoCKKQaIcT54l6R0cIJvpxKuBMDc=;
        b=bAHmztOBlIFuUboCEpDn1p6M/2cn8kF9smbLERt/2nZMYJv6E106UQe8/1vjtH79uK
         I3UHjToatCMR9m0VWCF7JuQseoLq3yHP0YO8RnZlv3lySAzFZ8dFBEOI+rbintJVQSUC
         uLetQoKjJwbzSeG5qwK9MCSm6M8rhQ+VBp2CI7z6QEDHOoVciMVqVPFb6fbLQvL78url
         5sHPzAQe9gmw2BfVqsOQljrRWOY8Xstjm6KVJr+hqkYZdMYxsCEAbStDv3eohW2a2jGe
         wlWpu8gQXg53R31L18C2c66rof6gR5ortGb631jGfWnDY9TdhgWCspa/YUX4RUZF1osu
         Pl0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754318523; x=1754923323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L9Qh5bbxJ0F6IApOoCKKQaIcT54l6R0cIJvpxKuBMDc=;
        b=Ju20e1inMhbUG/6FUapYrA2DYvxnBY00xXH3r7CtC3AlPgrQD5TMlQz1AErfXomq+/
         r+I67UCbZzGpdJwLueVloQCb/A5kph8lqrkL/Ysji+MJ/iIwCcFzPxBE8ZkFjUNp15QG
         Cqi8VnaJ+nsFmq5SXxVuKEtMslEYIiKexTGcRhlp/8qUMDr80zHyrxxL9F9yX+A9EyqN
         IgOabr9mse4ouhtojqchI4oAqjuYHYHZYrmd/X3+XyVcXE2UdJgHiTS9addzm41TbKGO
         1ToOWeGW5P6GAHCVmkFELCYOlEWPVwLqR2/Nub/qM41YwV0nLMgvLemD7RyMyWCeMldm
         Mu0g==
X-Forwarded-Encrypted: i=1; AJvYcCUYDiRwSipZQmiPdYjrii2az5qtDO93/5LNPf6C7PMCODa/wSxB+/KOHS/FbtLWtoRTzlHqIRbE39hjZ6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYfZNqD9TISRWSibfvymCGyo53TGrnZpjaNciKjbo2Z9p1y6/G
	q5P5PVSzbAf/Z1aDqWTorUrkDJaJi1rRu9hLYOAub8PkPcpOodk39mI9
X-Gm-Gg: ASbGnctN2tcL9mUYCRkZUs+71o1tAGwjmDnikifuKLZDON+ZwHWtrlnzeev31u8Bs2w
	i9faoMoxr4WrTafQvs0n7nvVwPGAUjTJCiaCxZKnbXm+AHxXHLPgjNrk0pVwGrA+lemLbDXRGtV
	8qEKPbNC59KQPo9RgS/aRQzoc058PsmqqerlqyiIJcq+v+zTuVS8XRtG4UMZvH5t01e56wYDWQr
	T3k0C32HUb1hiTvI0BogK9MW0B/Jtmuj6/nOd54Ol2eJplvCgxuMrjCRywtoors7Hf5jDix1X5K
	8HDWI8VKWseij6WG9GiQAoWrS0aSvqGdETUF3uIR4Y5ZPVNgiI96ejUI4BgkbRZbCoWceDc7eE2
	A1IN6XOr2ox1JFySajyHqrQ==
X-Google-Smtp-Source: AGHT+IFVq2sed4Q3r4rw6Dy9QgRMBqAMf8fLudYYr+d9ZFG7cvHGyBa1fE+AwgBBwCGEV5dFY3/rew==
X-Received: by 2002:a05:690c:6183:b0:71a:2dc9:a209 with SMTP id 00721157ae682-71b7ef6121bmr119241167b3.22.1754318523063;
        Mon, 04 Aug 2025 07:42:03 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:55::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a5cabf8sm26176687b3.62.2025.08.04.07.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 07:42:02 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	SeongJae Park <sj@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Alistair Popple <apopple@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2] mempolicy: Clarify what zone reclaim means
Date: Mon,  4 Aug 2025 07:41:59 -0700
Message-ID: <20250804144200.1047918-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <8734a7zxo0.fsf@DESKTOP-5N7EMDA>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 04 Aug 2025 09:24:31 +0800 "Huang, Ying" <ying.huang@linux.alibaba.com> wrote:

> Joshua Hahn <joshua.hahnjy@gmail.com> writes:
> 
> > On Fri, 01 Aug 2025 08:59:20 +0800 "Huang, Ying" <ying.huang@linux.alibaba.com> wrote:
> >
> >> Joshua Hahn <joshua.hahnjy@gmail.com> writes:
> >> 
> >> > The zone_reclaim_mode API controls the reclaim behavior when a node runs out of
> >> > memory. Contrary to its user-facing name, it is internally referred to as
> >> > "node_reclaim_mode".
> >> >
> >> > This can be confusing. But because we cannot change the name of the API since
> >> > it has been in place since at least 2.6, let's try to be more explicit about
> >> > what the behavior of this API is. 
> >> >
> >> > Change the description to clarify what zone reclaim entails, and be explicit
> >> > about the RECLAIM_ZONE bit, whose purpose has led to some confusion in the
> >> > past already [1] [2].
> >> >
> >> > [1] https://lore.kernel.org/linux-mm/1579005573-58923-1-git-send-email-alex.shi@linux.alibaba.com/
> >> > [2] https://lore.kernel.org/linux-mm/20200626003459.D8E015CA@viggo.jf.intel.com/
> >> >
> >> > Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> >> > ---
> >> >  include/uapi/linux/mempolicy.h | 8 +++++++-
> >> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
> >> > index 1f9bb10d1a47..6c9c9385ff89 100644
> >> > --- a/include/uapi/linux/mempolicy.h
> >> > +++ b/include/uapi/linux/mempolicy.h
> >> > @@ -66,10 +66,16 @@ enum {
> >> >  #define MPOL_F_MORON	(1 << 4) /* Migrate On protnone Reference On Node */
> >> >  
> >> >  /*
> >> > + * Enabling zone reclaim means the page allocator will attempt to fulfill
> >> > + * the allocation request on the current node by triggering reclaim and
> >> > + * trying to shrink the current node.
> >> > + * Fallback allocations on the next candidates in the zonelist are considered
> >> > + * zone when reclaim fails to free up enough memory in the current node/zone.
> >> > + *
> >> >   * These bit locations are exposed in the vm.zone_reclaim_mode sysctl
> >> >   * ABI.  New bits are OK, but existing bits can never change.
> >> 
> >> As far as I know, sysctl isn't considered kernel ABI now.  So, cghane
> >> this line too?
> >
> > Hi Ying, 
> >
> > Thank you for reviewing this patch!
> >
> > I didn't know that sysctl isn't considered a kernel ABI. If I understand your
> > suggestion correctly, I can rephrase the comment block above to something like this?
> >
> > - * These bit locations are exposed in the vm.zone_reclaim_mode sysctl
> > - * ABI. New bits are OK, but existing bits can never change.
> > + * These bit locations are exposed in the vm.zone_reclaim_mode sysctl and
> > + * in /proc/sys/vm/zone_reclaim_mode. New bits are OK, but existing bits
> > + * can never change.

Hi Ying,

> Because it's not an ABI, I think that we could avoid to say "never".

My personal opinion is that we should keep this warning, since there has
already been an example before where a developer tried to remove this bit [1],
and this broke some behavior for userspace configurations. However, if I
understand your comment correctly, you are suggesting that we should change
the wording to not include "never", since sysctls are no longer an ABI (and
therefore we should be OK to change what the values mean?)

If that is the case, then I can send in another patch since I think the goals
are a bit different for the two patches. With that said, I think we should
keep the warning just to avoid any breakages in userspace, even if sysctl
might not be considered an ABI anymore (also I must have missed this, I didn't
know this at all!)

> > Thanks again for your review Ying, I hope you have a good day : -)
> 
> Welcome!  You too!
> 
> With some trivial tweak, please feel free to add my
> 
> Reviewed-by: Huang Ying <ying.huang@linux.alibaba.com>
> 
> in the future version.

Thank you for your review Ying! Since there is a question remaining about what
to do with the "never" statement, I will wait to send out a v3 with your
review : -) 

Have a great day!
Joshua

[1] https://lore.kernel.org/linux-mm/1579005573-58923-1-git-send-email-alex.shi@linux.alibaba.com/

Sent using hkml (https://github.com/sjp38/hackermail)

