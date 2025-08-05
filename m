Return-Path: <linux-kernel+bounces-756938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA59B1BB42
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 22:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A365A17B5E5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 20:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AA4232368;
	Tue,  5 Aug 2025 20:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAf2fehi"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0417B217F36
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 20:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754424204; cv=none; b=X1BmFnwhCOgPYgEH0nglw4fTS19e1/zZfaSL+TWlvKEYL74PFr8iT9hPch2AuwGBLUa8wcbfBq2r6UqNM2hGqUJ/WmIOCZO0du+wZA7fcPRpZLWozqPgHAFJygTJPt7T8XyIa/OE9rewjai3FJqBaylqmqWILKZj7eD3RvFdoPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754424204; c=relaxed/simple;
	bh=kkK7uAJUahm01Mvv0DG1Aj/KtgqzV4K4zfohF/1l0tY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o2j2RU+fE2xRvA+mD9UPddl+EOhZCQA/BJB6HeuO0Q9aYJFidAqlkZhkRRIr/Vmdb483jCPGtcSKoi06XcfjzsKLG/Fihfi/GPGCVbE3x/72O7SLV2fPaz4iIq0ZpH+IS3oKLzneK8N631u6Bb5psOjoHwPaKig8p+TZkuAxu/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UAf2fehi; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e8fe5f3f340so248435276.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 13:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754424202; x=1755029002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HURENJIwBW4HrYnDuyD6HC79md6aohHgiDH/gmZ6R4Y=;
        b=UAf2fehiMzIqhqM3dREsFjYhOq4kT/iiDn5aXBvLSOW3N7cJWA5+Z2ral3o/G38FWk
         F3r8F3WqWhnQNsOWq/Uy4SGBS15EffoE9QBvCoGsjJWJkYo4dYJozWRknJEsFIk5bsTk
         O1B0uRppZFrD+S7YgzG/kLH4oHBPyLljfCTbIG3I885p4hmSyWLQB0x4sbMHCFGm2zkK
         toerXPsm6WNTXlcsDo1GGO+04qdau3shYHVmFdepbKJwfGAFpF42Oc3aGS2bEkUKwu67
         /dZBTQxu7ntWtfxosmnIhPO86CNspKSPX/s4YZALlrzyMwvWdO0k6N5H0/COutxNM5hR
         HRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754424202; x=1755029002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HURENJIwBW4HrYnDuyD6HC79md6aohHgiDH/gmZ6R4Y=;
        b=kxKGJr1BnZWZB09aDguxfgfe5gJyNJy9jNpvVXjRIjsd366r/h248hhdW8IZIcmPUf
         7mtJ/QGtBU9zizdEwnLOfaiOHIXNwA08htmFuC9O6C/oNyH0jABgXgDGyJefUbxkk/BM
         uQuuSQh8BwwqcbG692CPKlo8vcG4B4GQsoGKjywq0B19/ppgtMSTWl5ruBmkdiw7KLdp
         RAchub37avB97Qczr5MDafEJDGeftaHhLX3bKZRS8MeQMrbKc4HRXIMkWuivb0qvwHtZ
         yKqbxkQ9b6Ydt2VUdmjOZjgYWoOBROAcjPGcCfR4osp9s72pSk17IytaW7sxBaeARdBz
         gytQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlzj9ZffRiM6EvGGp9uuXXItZagRXp9JN7zeUnmPb5bogjlZRqIGRFRx5uHxedCu+l9/nE+Qh/h2loOF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YykcmI9ImjQqQxEriauSuhNjVrvnFqtfPZFLLZJpq/F3BhNPa7F
	BY+/UitVRC79iSynMsElSj/V6FqS5a9CIHEU2Pbvkv/XO1c8ju9tV0OQ
X-Gm-Gg: ASbGncvYb33Nei+DIwl/vOET241dplkZsSTZKQjpw0fEDZ36Z6aZ7/p2z9gN9dv7zHP
	U1haCcbIkwPlkkZBeUvW/LstDG27896BjIWjRH3em/ASLZOw65M5sQSuXLgSg6iZvgQ4nCl0GnD
	YvXEXHYvDXEeQa8lxqE7RNrkYtIM90hKANRtdkAnR3xtdqtQUBGDZNtWzWoogS0u57FwvxEwlVx
	pGbJzTUAfMA+hzrIjA9+HG1RJML4siDtseZaJnK1v1FXifd/YUX9tWpRWZuzXOnLL6T+ZeRrJBB
	09JXjvletfK3Mb/9EoKE1heMZcCPl0wNpSTf9kP+iipooNe0a1TXsqCKmxFtpFl8g5Sl/6JGNLx
	zBYb4YNlZQIB6g8zguSdXTqIyhnMRLqI6
X-Google-Smtp-Source: AGHT+IFnzMQf5da51VExlk1Urn50FIjZRa8sDOuW02dJ1AnrX7pyCFyQYMgNkjSpbi1PpgHTIjcXag==
X-Received: by 2002:a05:690c:6b03:b0:71b:69b6:9438 with SMTP id 00721157ae682-71bca5db9acmr3454587b3.0.1754424201439;
        Tue, 05 Aug 2025 13:03:21 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:50::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a3a9986sm33829937b3.12.2025.08.05.13.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 13:03:20 -0700 (PDT)
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
	kernel-team@meta.com,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v2] mempolicy: Clarify what zone reclaim means
Date: Tue,  5 Aug 2025 13:03:18 -0700
Message-ID: <20250805200319.1298046-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <871ppqy2v1.fsf@DESKTOP-5N7EMDA>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 05 Aug 2025 09:27:30 +0800 "Huang, Ying" <ying.huang@linux.alibaba.com> wrote:

> Joshua Hahn <joshua.hahnjy@gmail.com> writes:
> 
> > On Mon, 04 Aug 2025 09:24:31 +0800 "Huang, Ying" <ying.huang@linux.alibaba.com> wrote:
> >
> >> Joshua Hahn <joshua.hahnjy@gmail.com> writes:
> >> 
> >> > On Fri, 01 Aug 2025 08:59:20 +0800 "Huang, Ying" <ying.huang@linux.alibaba.com> wrote:
> >> >
> >> >> Joshua Hahn <joshua.hahnjy@gmail.com> writes:
> >> >> 
> >> >> > The zone_reclaim_mode API controls the reclaim behavior when a node runs out of
> >> >> > memory. Contrary to its user-facing name, it is internally referred to as
> >> >> > "node_reclaim_mode".
> >> >> >
> >> >> > This can be confusing. But because we cannot change the name of the API since
> >> >> > it has been in place since at least 2.6, let's try to be more explicit about
> >> >> > what the behavior of this API is. 
> >> >> >
> >> >> > Change the description to clarify what zone reclaim entails, and be explicit
> >> >> > about the RECLAIM_ZONE bit, whose purpose has led to some confusion in the
> >> >> > past already [1] [2].
> >> >> >
> >> >> > [1] https://lore.kernel.org/linux-mm/1579005573-58923-1-git-send-email-alex.shi@linux.alibaba.com/
> >> >> > [2] https://lore.kernel.org/linux-mm/20200626003459.D8E015CA@viggo.jf.intel.com/
> >> >> >
> >> >> > Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> >> >> > ---
> >> >> >  include/uapi/linux/mempolicy.h | 8 +++++++-
> >> >> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >> >> >
> >> >> > diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
> >> >> > index 1f9bb10d1a47..6c9c9385ff89 100644
> >> >> > --- a/include/uapi/linux/mempolicy.h
> >> >> > +++ b/include/uapi/linux/mempolicy.h
> >> >> > @@ -66,10 +66,16 @@ enum {
> >> >> >  #define MPOL_F_MORON	(1 << 4) /* Migrate On protnone Reference On Node */
> >> >> >  
> >> >> >  /*
> >> >> > + * Enabling zone reclaim means the page allocator will attempt to fulfill
> >> >> > + * the allocation request on the current node by triggering reclaim and
> >> >> > + * trying to shrink the current node.
> >> >> > + * Fallback allocations on the next candidates in the zonelist are considered
> >> >> > + * zone when reclaim fails to free up enough memory in the current node/zone.
> >> >> > + *
> >> >> >   * These bit locations are exposed in the vm.zone_reclaim_mode sysctl
> >> >> >   * ABI.  New bits are OK, but existing bits can never change.
> >> >> 
> >> >> As far as I know, sysctl isn't considered kernel ABI now.  So, cghane
> >> >> this line too?
> >> >
> >> > Hi Ying, 
> >> >
> >> > Thank you for reviewing this patch!
> >> >
> >> > I didn't know that sysctl isn't considered a kernel ABI. If I understand your
> >> > suggestion correctly, I can rephrase the comment block above to something like this?
> >> >
> >> > - * These bit locations are exposed in the vm.zone_reclaim_mode sysctl
> >> > - * ABI. New bits are OK, but existing bits can never change.
> >> > + * These bit locations are exposed in the vm.zone_reclaim_mode sysctl and
> >> > + * in /proc/sys/vm/zone_reclaim_mode. New bits are OK, but existing bits
> >> > + * can never change.
> >
> > Hi Ying,
> >
> >> Because it's not an ABI, I think that we could avoid to say "never".
> >
> > My personal opinion is that we should keep this warning, since there has
> > already been an example before where a developer tried to remove this bit [1],
> > and this broke some behavior for userspace configurations. However, if I
> > understand your comment correctly, you are suggesting that we should change
> > the wording to not include "never", since sysctls are no longer an ABI (and
> > therefore we should be OK to change what the values mean?)
> >
> > If that is the case, then I can send in another patch since I think the goals
> > are a bit different for the two patches. With that said, I think we should
> > keep the warning just to avoid any breakages in userspace, even if sysctl
> > might not be considered an ABI anymore (also I must have missed this, I didn't
> > know this at all!)
> 
> Sorry for confusing.  I agree that we shouldn't change the sysctl
> interface in most cases.  I just thought that we could soften the
> wording a little?  For example,
> 
> New bits are OK, but existing bits shouldn't be changed.
> 
> I think that it's still clear that we don't want to change the existing
> bits.
> 
> However, my English is poor.  So, my suggestion may not make sense.

Hi Ying, thank you again for the response!

No worries at all, it was my misunderstanding : -) This suggestion makes sense,
and I think it's small enough & relevant to the code block, so I'll also fold
this change into my patch as well. I'll send out the next version shortly!

Have a great day!
Joshua

Sent using hkml (https://github.com/sjp38/hackermail)

