Return-Path: <linux-kernel+bounces-746157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B858B123B9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64497179DD1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76134246BB7;
	Fri, 25 Jul 2025 18:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVWKw+Cb"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5409A242938
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 18:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468050; cv=none; b=R5kYztlG7UKpqF6R92A2i46ldL/odpNj+8B+T2uIORGrVC3T7BB8YRsuyP6+KiTlCo7gIzcCqyi8OT8lZjJoHDKVQpttH0Xgj40k2XbkFabtz0a47ABPDhx7lwNEO5wC3yn3F0uWsc0Xcwk5IdUJyVvQnG9DHi1XzzxFb6MGzck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468050; c=relaxed/simple;
	bh=IlYBsdsMuSu8j72dbjMYAWyC80O48ZjHYCSjfeo8fy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UmL+VzZN4M4QKVRa9EHsLlChxVnQuGlnDknlsq1cFiqpF/cdtxlCA+5Va+QpsvcsjChHP3u6Zvniqlynq0HpIp5acfkOSCGbj1YuPjRjF0QaV+f5vU41EqXkRrhyNBzvN7bWEPph8BKVtXVAC0AIY64jKT4MNBOLP2T17HI/260=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVWKw+Cb; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-70e3c6b88dbso17658707b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753468048; x=1754072848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGsJdJPVFg6ouh8HRlVVj9qvC5pGjbJ25tCnf1EI3MY=;
        b=GVWKw+CbIL2yNStbjV7zYOLFrJswwU9yx/ZAX5hM4FWqRCn5ryn17BPi+nj78KH1ro
         yMMVWxVlkBFqOOtG7i14tKbeWkElduXipcZnw+AjweiVGzT6E7wnE172nzShNcI9XGpm
         rHeiHac3tfJQ1ZpFvFwwNJnCiKHyuysK+DW9+zzC3LV7q7405tuc6Q51keEwqooCIVMR
         CitBIQ/1W8crkL2jbg4QqOU+54e9s9NgabtuL3YQA6jj34Wuo8vvYMgIlLE4CBJJprXl
         d+VnlXfj8L95ykpgclhQYXVOuL8xpFybF5+eSeluO7RFt/5fC65acvId49OYFjfLm5tA
         HFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753468048; x=1754072848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KGsJdJPVFg6ouh8HRlVVj9qvC5pGjbJ25tCnf1EI3MY=;
        b=eDAszGoM9+wW9Om1G00l/J+HJlCQ92ohxj2hdLESRtHEMZdSO8iO6eyEbyprnxHMa1
         q4WLvrv16t11xC8fjejMWiXsgFRPKEMmLQ3zK1Yn9ywz8x23BRwxnEZuOLQ/1x9BBvPf
         OOmQyFJyGf37BSWhcPHKxUCeU6q1hGE05Qi/XPTaOgiUg/2n3lvg+H7gykIohgztLLKd
         5NzwW8lieIRDwT+LejZG11FEYcoxDEedTgvP1wSm3GeC0SZIIK0qBlDxTqMEZo7Yoz1Q
         W4UJZbKRfMehivsmejUn4+gSwtgzlawq1Qct4fq/EWIYYRiZ5VEU+bPvE6V13qI6PI7a
         KQgg==
X-Forwarded-Encrypted: i=1; AJvYcCV8wLz1IAJoKTvsHP/xZA7NhA2mrUQp1WObLgoIS6eRHVUeVOOXlYpc6Bjh+zXPgFuUYPWkOUIBNx9gRNw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx8EqWJfgHX6QCkAmEANKGCm/oEUTNmxRvdy4/n87YuzewceEI
	u5QDo3mGttfa9X52psMQ6EF8SMna2k0knmaQP299j3Lc3DFspOaxZEts
X-Gm-Gg: ASbGnctXA58kxU9NGyn/Jp/xfuQPT+/eYfRMZrH5tiCcD4ehkSRldFSTgxm4OL8bpPd
	AdNf7ojJzE7cxnR0TUjWHVzmd3NhIPyGUrFEdr1Hb+ps4Qx547mPLOv1qtJ3IFikAnLVe1B+LXX
	pM4y+PAmOcHGxqzfTQhAEAP1OANcwr+bZ7nbw7hY8yGQJBBVphJ/laxr1uVcogGvhCNdILJnKae
	xAfAF3OiJl4XaU57gygdSe+MEbjF/cdWfPypilU7rwv3OpCPrVZ4//LCjy7UbqkpbkDtSGlf2NG
	D0S+CkXNjMY6jwvT8VjgWn7b3QKFdB6pcpractBzBtQylmRCyMP0qpsCz11Lp9kUO65o/6LlcuI
	zaThwtuU6Im2CAzPJJB3DiA==
X-Google-Smtp-Source: AGHT+IGvP02ssugHzK68/uifaDc8Ut7qztKieRH0z/WUQl+bdaCcOjca5FRzv6cc0PXhAr8U0F4sEA==
X-Received: by 2002:a05:690c:724a:b0:70f:6ec6:62b2 with SMTP id 00721157ae682-719e328b19fmr41101687b3.8.1753468048036;
        Fri, 25 Jul 2025 11:27:28 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:50::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719f23e1f19sm866757b3.83.2025.07.25.11.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 11:27:27 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
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
Subject: Re: [PATCH] MAINTAINERS: Add missing headers to mempory policy & migration section
Date: Fri, 25 Jul 2025 11:27:26 -0700
Message-ID: <20250725182726.2540602-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <a2a3b527-8ed0-45e0-be15-85ec4ef1afa1@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 25 Jul 2025 20:23:04 +0200 David Hildenbrand <david@redhat.com> wrote:

> On 25.07.25 20:17, Joshua Hahn wrote:
> > On Fri, 25 Jul 2025 20:03:09 +0200 David Hildenbrand <david@redhat.com> wrote:
> > 
> >> On 25.07.25 19:56, Joshua Hahn wrote:
> >>> These two files currently do not belong to any section.
> >>> The memory policy & migration section seems to be a good home for them!
> >>>
> >>> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> >>> ---
> >>>    MAINTAINERS | 2 ++
> >>>    1 file changed, 2 insertions(+)
> >>>
> >>> diff --git a/MAINTAINERS b/MAINTAINERS
> >>> index a8bebd0886df..dec8db8b5cc7 100644
> >>> --- a/MAINTAINERS
> >>> +++ b/MAINTAINERS
> >>> @@ -15838,7 +15838,9 @@ S:	Maintained
> >>>    W:	http://www.linux-mm.org
> >>>    T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> >>>    F:	include/linux/mempolicy.h
> >>> +F:	include/uapi/linux/mempolicy.h
> >>
> >> That one is already on that secion on the mm/mm-new branch
> > 
> > Hi David,
> > 
> > Thank you for getting back so quickly : -)
> 
> :)
> 
> > 
> > Unfortunately, I can't seem to find this file in MAINTAINERS in mm-new.
> > Perhaps I am not looking correctly? Apologies in advance if that is the case.
> > My HEAD for mm-new points to dd811f4553a9512501205ba8e58ef1a6af4cb291, for
> > your reference.
> 
> Sorry, I was completely wrong ... I got confused by the other 
> mempolicy.h file that Lorenzo also recently touched in here as part of 
> the MISC section.

Hi David,

No worries at all! Yes, there is a lot of movement in the MAINTAINERS file
right now and there are quite a few files to keep track of : -)

> Sorry for the noise, I shall stop working for today and enjoy the 
> weekend (and hope you will do as well)
> 
> Acked-by: David Hildenbrand <david@redhat.com>

Thank you for the ack! Hope you enjoy the weekend!!
Joshua
 
> -- 
> Cheers,
> 
> David / dhildenb

Sent using hkml (https://github.com/sjp38/hackermail)

