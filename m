Return-Path: <linux-kernel+bounces-746570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C37BB1286D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 03:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C16367B032B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 01:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD6D192B7D;
	Sat, 26 Jul 2025 01:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFO43ymp"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB8715E8B
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 01:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753493053; cv=none; b=bg3Z14on2FsNzqmxn9+6eGcb9TqCK4xb/4vn87Cr0T9vig2HPiFo77PVhp5AeWHwDL88j4hQ5F65Eb6+I1CdfmvErZ/lXOGCvHSS4YIZ8pt2kmJYF5GZ40JQm8mUzVOwxuIMRPp9DlpzGzPwn4thtW4AEh4PJ6Be5HJGexczJLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753493053; c=relaxed/simple;
	bh=3ZaZ8e8M5OOEbvz4OaoSVzzXCjQSK7tINv1wDtDA2BU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kf7A+LYZnwpkW7Evfa+GVE4hlxuqvL1G1OicDTnuNQ+aznfYMEJ9sWE3TMVxnzaB4UKFdwhJM5/Y0V4aHI8xFEbiXJLsUDJm8g+SBN37xa+GEew52wEj1pwQiRJl569emJRxyw2A1PO/mbbkseuG6twPXDq8mODO2USb46sO7HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFO43ymp; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-712be7e034cso27847807b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 18:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753493051; x=1754097851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAoS2k2FG0BBzk7na/Di2MHMPEED+EAUzwwQBgazTVE=;
        b=kFO43ympbJAxP/TYi0y4jXGdFKGubMo8l6CWwoR5pBy7n6YLVfDSwRvK0uKFSxY+GQ
         r0sGuGiTFHBM5eE3z7SX44AMI5tiUFbhEYvQPU5LLzLGzOznQybnhd+IEayPxWYk1YLO
         Sl1WXh/LtHoJeEAM2XAVUhg/Wl6Af52LFAYG/84v3+AsogfmkGAoM7XPzoyYGfdgGlMv
         4fp8bWjgGNlULJaqYHtwY7nCZASejRtAXVjsMx1Czer2Who5dypywtxRJ6Yrsv1sBj7G
         kL3dQVzOSA5w5hWZ4PC2k2I4tjMUTUWZ9toFqIDvAb6kaLKwRMRUWYD4m2iSkgBLpwsY
         QKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753493051; x=1754097851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hAoS2k2FG0BBzk7na/Di2MHMPEED+EAUzwwQBgazTVE=;
        b=tfl85a+ellL2h7PWAS7tsTPn4GMXmMcYL80KD0G0DCFyBDfxxOmdyfD3TFfBV0u00w
         7JffvGpZIroseDwaON+dyJKSSBthgQDhwQ+5t5te+QmbMQBwug4WlBswgLFeW70Ad1Bq
         2xXnivsjuj1YEhEUjvTO8JMKlr+Spsi1bZSamGuiciGag79ZMQWHhxZOOFpLEh68nJCP
         tKD1ghDODoxRXfbB8Nv+RGHJrt+4XTsCMs7AbWpYi725uVzFYyaGIUKIm+BwHdDMaqtA
         Dp3ex7Q36cPRyH+Jven5dKnUTACBUvLXQY15xrvODuUCrr9EImGhAAcBZd1FSa/XjkEL
         YJCA==
X-Forwarded-Encrypted: i=1; AJvYcCWT8CrZ6NXM7WqpBTsctqCBUEUtPkHgpL7PTnJLGLTQnbgQWnPhUfO/7UVGIADR1hWCJ7w+vknNzlA4Se4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQD7FEkdiqYEW2jp3/B6u1LSp8ubO7jGIFA8Q50uH+H9vAK/LL
	xB9rKn6VCxM8XuzR6uPvx8mq/F2sgtMVrF0ZiPinhN1sofy3fjGLbkPZ
X-Gm-Gg: ASbGncswwMBU5MoKc9fujiBE4p/Yw+zvCCmMe+DtOwnXbK93hdylqCEu5da59xz62KU
	ItxTJrsrpzpGC9RKhRr18YEY4GzXAt9xp0gahjjLCUAfx6Fvix0EZCCIBKh4m+R6l+WM6BBOSkW
	h3Ge2G0rOjb2+4Dn4IB7o+LgwwftoLbAxFnlCpLeJKdY+NLXIxlirj8swP3WpcK5IHYrPNnPK4N
	3MCIR/TQLNpz1/zpzXKlhrkDxGxMP9KSiY732uGLWkMVa4VpJNPrrkaROaUYPxz+LebwBXSdsNB
	WuY5dyb76Ce80sFOJ/FcBNIEG9WJbUx2Tdbcw5YYW7ZUOJf/09ssHp0zzijizZ+ePNzeznAihBI
	oDF+yO5npe1syf8Nssim2rw==
X-Google-Smtp-Source: AGHT+IFq3cRfkS463mO6STS9/bqaq2B+E4mgisgdVwoE3RpChGzqX5rt5oxN+5Xa//+7hZetgSk3cQ==
X-Received: by 2002:a05:690c:6c8c:b0:718:344f:73d0 with SMTP id 00721157ae682-719e3297e88mr56579327b3.3.1753493050536;
        Fri, 25 Jul 2025 18:24:10 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:58::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719f2152de0sm2402717b3.2.2025.07.25.18.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 18:24:09 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: Re: [PATCH] mempolicy: Clarify what RECLAIM_ZONE means
Date: Fri, 25 Jul 2025 18:24:04 -0700
Message-ID: <20250726012407.297378-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250725214426.51487-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 25 Jul 2025 14:44:26 -0700 SeongJae Park <sj@kernel.org> wrote:

> Hi Joshua,
> 
> On Fri, 25 Jul 2025 10:35:45 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> 
> > The zone_reclaim_mode API controls reclaim behavior when a node runs out of
> > memory. Contrary to its user-facing name, it is internally referred to as
> > "node_reclaim_mode". This is slightly confusing but there is not much we can
> > do given that it has already been exposed to userspace (since at least 2.6).
> > 
> > However, what we can do is to make sure the internal description of what the
> > bits inside zone_reclaim_mode aligns with what it does in practice.
> > Setting RECLAIM_ZONE does indeed run shrink_inactive_list, but a more holistic
> > description would be to explain that zone reclaim modulates whether page
> > allocation (and khugepaged collapsing) prefers reclaiming & attempting to
> > allocate locally or should fall back to the next node in the zonelist.
> > 
> > Change the description to clarify what zone reclaim entails.
> > 
> > Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> > ---
> >  include/uapi/linux/mempolicy.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
> > index 1f9bb10d1a47..24083809d920 100644
> > --- a/include/uapi/linux/mempolicy.h
> > +++ b/include/uapi/linux/mempolicy.h
> > @@ -69,7 +69,7 @@ enum {
> >   * These bit locations are exposed in the vm.zone_reclaim_mode sysctl
> >   * ABI.  New bits are OK, but existing bits can never change.
> >   */
> > -#define RECLAIM_ZONE	(1<<0)	/* Run shrink_inactive_list on the zone */
> > +#define RECLAIM_ZONE	(1<<0)	/* Prefer reclaiming & allocating locally */
> >  #define RECLAIM_WRITE	(1<<1)	/* Writeout pages during reclaim */
> >  #define RECLAIM_UNMAP	(1<<2)	/* Unmap pages during reclaim */
> 
> I agree the new comment is more holistic.  It explains general
> zone_reclaim_mode behavior (how the system works if the mode is turned on by
> having any of rightmost three bits is set) well.  But, I think the old
> description is for the specific mode of it (when the rightmost bit is set), and
> the place is appropriate for that purpose.
> 
> What about keeping the old comment but adding the holistic description on the
> upper multi-lines comments block?

Hi SJ,

Thank you for your kind review as always : -)
On second thought, I think you may be right. To be completely honest, the reason
I submitted this patch is because I was looking into zone_reclaim and got
a bit confused, and thought there was a possibility that others might be
confused as well. It might only have been confusing for me, though ;)

> And the behavior is also well described in zone_reclaim_mode section of
> Documentation/admin-guide/sysctl/vm.rst document in my opinion.  Maybe putting
> a reference to the doc together for readers who curious about more details
> could also be useful?

Yes, I think this is a very good point. The comment block above the #defines
were added because in the past, RECLAIM_ZONE was actually removed by a developer
because there were no explicit users (although this has changed since).
Perhaps pointing users to the admin-guide can help explain more about the
context of the first bit, as well as explain what I am trying to do with the
comment change. 

> 
> Thanks,
> SJ
> 
> [...]

Thanks again SJ! I hope you enjoy your weekend : -)
Joshua

Sent using hkml (https://github.com/sjp38/hackermail)

