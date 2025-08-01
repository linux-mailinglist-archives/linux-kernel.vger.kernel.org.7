Return-Path: <linux-kernel+bounces-753531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B04B18437
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07EF61C2713F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23D326CE3A;
	Fri,  1 Aug 2025 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/3gKrg0"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD7E221283
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 14:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754059842; cv=none; b=L1Hsk78gSUqOD/GZyIo4zextwZgttB42dRtvb7AVmoy72s2BJpBgzv/8028UP3o7JaT6tbdyqrZczJz7M+0QqVHDd3C1k+z+QBMYPNkfBs/xUNR7Hl1m2tr3Bf8Druv1ndJDeDiXW20iXv9gAEBS+9PeE3dSYJNdhkRHqEY3lQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754059842; c=relaxed/simple;
	bh=7LxIdFIT1CTmA3AVL1QMVFTBfnQcDiTfF1Ik/jfRx2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3wLDAWbBK9Uf+swzLNTQwbtcstxmovq8Oedcpu30mG1eoW9SMxrIjt4SX5PoJ5PbgL8uuczotgkqEcUUqWL6458q7Msv/qp2eTr72dGQhNTI4fkunxFc3rv/AwsBvSHlCgeevNjauML8ibxP7hTvDuqCYKmcMvo+tkAmwNna2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/3gKrg0; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e8e2a260926so2087075276.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 07:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754059840; x=1754664640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjg07z5yf4Lf1nLCjxfxMn6+NFk9uurEps7NM4R0GOc=;
        b=T/3gKrg0d2NjcWXr7tCGTtgM9nIiolIb8M6Yz7Ux1CVshmUi52Wzoc+CvCNMoOKFQi
         CACP8nmYgrKIbpY1IG0lEiXbUvZ/4UVLl9bX679DXGLGs40O5pRMLLOXEkAPCus/W+of
         JcVoz0e4mPXG3eYK4QiHBn6ddiHbaoSbc3A/r0uZHH+Wxb+mJruAZQOjg/IcauCP/zlM
         d3Bb4YaPgF6Sih5TrUmlGu9WvYnmdoaFYazSoTjFXnsDtcxd7Mv5ieAx0tz+wWr5PDgC
         dv2d4VzFuu7n2qGEOeB4++Gj3yOQEqt82suZWbFrp8gRi05ZnOCSmDyT8Xp4Gp1t8BQK
         DzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754059840; x=1754664640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rjg07z5yf4Lf1nLCjxfxMn6+NFk9uurEps7NM4R0GOc=;
        b=L4OZmFHkTKQfkBKpu5JHdDxtZt+BoHugeE/W8LA/SvvYASnKU1ITDcB6UE4YmDr8EP
         7zLesOhTPTOPLtLML1qfH8djfotlxOHDggXCxUTQLWpevxLPeJgStu4E793w8jWdPMFJ
         J0FVDOKeYY0Pwq82/i7I9BOm+aWtrNwbu/uw29Hc+25748JQLxBF7qlkijXyZSy5A/1U
         8YsB0Ar9RuKXxIy4lSzGkODbcQ51c5y1G914JI7wYCehJBHMql+nns4bXjPfWbQ7+6O1
         JIcCB2jj3nTLJpPXGQezC0eNoqEMz79Hkxw/VA6nbI32fYMB13e+TyXSZPTV4uThADf/
         QONg==
X-Forwarded-Encrypted: i=1; AJvYcCW3EDHj80xsbgkCFNjAoFnlUdhflJ7twkhnUxWMsZloXOllr9+ODF5uhnL1upk2dgTpsTJEabUigduJBrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIID9/6D+7zX6gspEKwwtYz4dZOVEbMGiQ0i/M5JXwMgjvBVMR
	j2b0+ACzMD288Rew18PjCX4E1dQTaspJMneC+dQDz3wD9b3OoiBue/1P
X-Gm-Gg: ASbGnctF2W22CjCNpp5KNwKNCMJSMIBRC2SEZJertGK1dpPu5TXfiHHRUrKXCW7bif/
	rCmB1KayJ7gDH2qdJV/Iwqfza6Yw0HeRpLTNYqo/1No2+bFp1WysoWtAbZUoZEs7KubBJrRZusF
	WiBPUjhiUCTIZoGi1aeBKdjkJbEHjYeh1SBMNBGGxWIr0Jsldjbh0AFXAkHGesH/GKCKp4x/hyR
	FIqFaHI0xlMByBn+rTGJaHFyxKlSeY71JXpmGkRIKeTFFmhIw4uKoAuSJLZgB3GKuHQ4N7Wsjs9
	krpixon9w9FVPVrdTeOLn0D9WLWEoM+X1yq6Mon2J38YR32xb5A12QXTpM0Qg5mFCfLHcx+YjaD
	Kmy/1f0gECK1DWvnE2lIofw==
X-Google-Smtp-Source: AGHT+IH4tV3VnN1zoMGZDId5fHOF0lyF9qZcr1Qx7AyM+nVUAAwrra+7YHKAW3JU1kk6B+TJVQjCFg==
X-Received: by 2002:a05:6902:1147:b0:e8f:ea53:b692 with SMTP id 3f1490d57ef6-e8fea53d9b8mr1443000276.3.1754059839336;
        Fri, 01 Aug 2025 07:50:39 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:58::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8fd38c0bafsm1514733276.44.2025.08.01.07.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 07:50:39 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ying Huang <ying.huang@linux.alibaba.com>,
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
Date: Fri,  1 Aug 2025 07:50:30 -0700
Message-ID: <20250801145037.2078591-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <3939866f-e57e-4caa-919a-558bf6866b82@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 1 Aug 2025 11:04:00 +0200 David Hildenbrand <david@redhat.com> wrote:

> On 01.08.25 00:41, SeongJae Park wrote:
> > On Thu, 31 Jul 2025 14:07:37 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> > 
> >> The zone_reclaim_mode API controls the reclaim behavior when a node runs out of
> >> memory. Contrary to its user-facing name, it is internally referred to as
> >> "node_reclaim_mode".
> >>
> >> This can be confusing. But because we cannot change the name of the API since
> >> it has been in place since at least 2.6, let's try to be more explicit about
> >> what the behavior of this API is.
> >>
> >> Change the description to clarify what zone reclaim entails, and be explicit
> >> about the RECLAIM_ZONE bit, whose purpose has led to some confusion in the
> >> past already [1] [2].
> >>
> >> [1] https://lore.kernel.org/linux-mm/1579005573-58923-1-git-send-email-alex.shi@linux.alibaba.com/
> >> [2] https://lore.kernel.org/linux-mm/20200626003459.D8E015CA@viggo.jf.intel.com/
> >>
> >> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> >> ---
> >>   include/uapi/linux/mempolicy.h | 8 +++++++-
> >>   1 file changed, 7 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
> >> index 1f9bb10d1a47..6c9c9385ff89 100644
> >> --- a/include/uapi/linux/mempolicy.h
> >> +++ b/include/uapi/linux/mempolicy.h
> >> @@ -66,10 +66,16 @@ enum {
> >>   #define MPOL_F_MORON	(1 << 4) /* Migrate On protnone Reference On Node */
> >>   
> >>   /*
> >> + * Enabling zone reclaim means the page allocator will attempt to fulfill
> >> + * the allocation request on the current node by triggering reclaim and
> >> + * trying to shrink the current node.
> >> + * Fallback allocations on the next candidates in the zonelist are considered
> >> + * zone when reclaim fails to free up enough memory in the current node/zone.
> > 
> > s/zone when reclaim fails/when reclaim fails/ ?
> 
> Agreed, that confused me as well.

Hi David, hi SJ!

Thank you both for catching this, I definitely missed this before sending the
patch out. Will fix in the next version!

> Acked-by: David Hildenbrand <david@redhat.com>

And thank you for your Ack : -) Have a great day!
Joshua

Sent using hkml (https://github.com/sjp38/hackermail)

