Return-Path: <linux-kernel+bounces-822343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 899EAB83968
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4393E2A7DC9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05EA2F8BD3;
	Thu, 18 Sep 2025 08:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YprNN1z3"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF4C80B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758185405; cv=none; b=AflLA3FTbTqRLbvFssak6fU31LysbnWsCn6ybA18xwDlJUCVYkwlaiNDNv3e8Y2HaXHiI+MzB3l93nB6Odv+CiP7iubKDyRYGr18xys8OOa+bUOqHNb7IQnAerjF5uJXpTp4LW0aFFdJqlk2Y9px3L+r3uEoNVJ5UCfRHD9N+Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758185405; c=relaxed/simple;
	bh=OtYeX22g9/+XJ0SIiCXG6aaSoiPRTOD8Qa/Iimf3XUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhbSER0U8uwk1QTLQbYdlkki7sQ23ca+blsp4ds87uvbykke2sFnQElw5bpRPRSocCi3YoLmsvElM7AIfnFfQyOrb2AheVUiEioiNoDzGsITBuHzrMejfa+Edwzb3gGAr0apaKanUYhVpClbJsiYbeRnLtdXtQGJLiVBYQsktOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YprNN1z3; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-62f0411577aso1398788a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 01:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758185401; x=1758790201; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hDS1lqd8rZbXZbUYB/FWM+UPwaXwxFfwGYspDhm+zY0=;
        b=YprNN1z3wt6y45n39aYd6h2GpGfmgja6JLBQw673B1IIdd+pgGtyFlXfQ011RpijUl
         h9BuL0+O/OjGmkDpzoygp93E2twefrpuCFx9M3ejVWaBa5PEYWql3Okk6WXVdXKrvSva
         25MGMyMi0cqSzZ14SZtTBGHm4wfsJpnIwNfwOX8oQxrSE5Cxv0W2TqaX32SzvVeOn/d+
         xBRGdG0NDc03ZUGIwee1j3bYVGaVhcaeOguepJh0yvtFBs03RU1hJFlbaLfCLr3XdWsq
         ArrFSO6kmoGpTgt6wKnJQvDCgBEEFmr9OAPdl0S4V9teYXDvz4ViBUN8cEhKBIwj4Rf7
         GYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758185401; x=1758790201;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hDS1lqd8rZbXZbUYB/FWM+UPwaXwxFfwGYspDhm+zY0=;
        b=EkaEw2w/LDID/2mS4i4ivaCRVOqYOu6Ag++k3jk53Vxryh2j+HfRhmMwJu3/W11vi5
         Vs5f0rdb8sz3Gats9HwW67Vr4Xi0IftrVozZpx8Xr84wxaQnxip2O7WwxMwFBRpWAK7e
         kqwl2FbFozREiBwVRqYjEt8TthRuWwy7VEp/Z+ILM2m7a5wOtnKxhW5y1kb5ZVinLvLz
         Jk60wsursMwWFPbMqPwoFPNMzW+9vltoUnf5htcRgHwYL645XYExR93V9wbpRfUAXAfI
         VyjlSOmYDuydROM/dw8b9jEgamNDzYPfk788iAG0yCD5n1Ftph7Iz4m5CJ6QKAQSk16q
         WVnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkzMILXjf39rJUAg2iWUuC6K9iOgNa15arqkiXoODC985u29e1XWvlp5oeF2tk2a2oklpSEzZ6MjMI2Vs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzznhFsb84hmg5ZhOmB7PeETDV3AEFeWR2TWk7HjdDQrUy2oEF0
	bFJG2EUO1BWUYdwMbkwuVgxuZ4KncJMXrmuwlNCuO/+bLEULpsL/VgPkiIa94k8V28o=
X-Gm-Gg: ASbGnctkE5UQGqqwPgcnRP3EW2o9pubxMVcBBvUXHR85pWi2iXUa2NtYc8dKEXKeoI0
	Y/i0h3OLDGYn7S74d06LwyD1iqCCbDDQIrZXAL83tqwcIdAy+FFphB1oflznrWaq8N5UyC6Dvbg
	n2BQ8NaIGhPHQDru20zdTFWBiDfBtHTfcyYG4fRLmNPB2Mgko/+PRJ7v7CF7SBzZXrg4NW+BHdo
	v2oeY4mWmY3UPneyrFIS36agwhF+S/bbOghT1cHutQcYibrUTOphckdjKjTeUeXtMal5f668Sac
	KNISGHqFJBUSEBWzvmQ+IOszldW3i8SXLGJ2SLG9Con4i8vcP/Q2xg3cNTKRSt2MARmJTEiu9q3
	HubVp6EXgI2VHS6l4RVqUHcjnZgxYhuafR4cYjtzf2RpJuF281WmG
X-Google-Smtp-Source: AGHT+IHJ6xSlvwBJIDdm09ENnEV7apeA12zqjKVNjvrbj9aWgSqDk9GVscCBVpWo2sK3SG+bEj7tEg==
X-Received: by 2002:a17:907:dac:b0:b04:4975:e648 with SMTP id a640c23a62f3a-b1bbd49ae49mr599268466b.35.1758185400841;
        Thu, 18 Sep 2025 01:50:00 -0700 (PDT)
Received: from localhost (109-81-31-43.rct.o2.cz. [109.81.31.43])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b1fc73ba1e8sm148009566b.31.2025.09.18.01.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 01:50:00 -0700 (PDT)
Date: Thu, 18 Sep 2025 10:49:59 +0200
From: Michal Hocko <mhocko@suse.com>
To: Ye Liu <ye.liu@linux.dev>
Cc: David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ye Liu <liuye@kylinos.cn>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmstat: add header line to /proc/buddyinfo output
Message-ID: <aMvHt7Z2PMuZaned@tiehlicka>
References: <20250918071741.526280-1-ye.liu@linux.dev>
 <aMu01xIkj-3hgW88@tiehlicka>
 <1a9f44a1-855c-450e-9dc4-415a29b90011@linux.dev>
 <780aa9d6-a85c-4050-820e-c0ca9f5bb658@redhat.com>
 <6d6e2e33-c221-4ab8-a29b-3d14fb1a592c@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d6e2e33-c221-4ab8-a29b-3d14fb1a592c@linux.dev>

On Thu 18-09-25 16:31:22, Ye Liu wrote:
> 
> 
> 在 2025/9/18 16:16, David Hildenbrand 写道:
> > On 18.09.25 10:11, Ye Liu wrote:
> >>
> >>
> >> 在 2025/9/18 15:29, Michal Hocko 写道:
> >>> On Thu 18-09-25 15:17:40, Ye Liu wrote:
> >>>> From: Ye Liu <liuye@kylinos.cn>
> >>>>
> >>>> Add a header line to /proc/buddyinfo that shows the order numbers
> >>>> for better readability and clarity.
> >>>>
> >>>> Before:
> >>>> Node 0, zone      DMA      0      0      0      0      0      0      0 ...
> >>>> Node 0, zone    DMA32      5      8      6      6      7      5      8 ...
> >>>> Node 0, zone   Normal   1113    351    138     65     38     31     25 ...
> >>>>
> >>>> After:
> >>>> Free pages per order       0      1      2      3      4      5      6 ...
> >>>> Node 0, zone      DMA      0      0      0      0      0      0      0 ...
> >>>> Node 0, zone    DMA32      5      8      6      6      7      5      8 ...
> >>>> Node 0, zone   Normal   1113    351    138     65     38     31     25 ...
> >>>
> >>> Why is this needed? And have you considered tha this might break
> >>> existing parsers of the file?
> >>>
> >>
> >> Thanks for the review.
> >>
> >> The reason for this change is simply to make /proc/buddyinfo self-describing.
> >> Right now you have to know which column is which order; with a header it’s
> >> obvious. This is similar to what /proc/pagetypeinfo already does, e.g.:
> >>
> >>    Page block order: 9
> >>    Pages per block: 512
> >>
> >>    Free pages count per migrate type at order   0 1 2 3 ...
> >>    Node 0, zone DMA, type Unmovable             0 0 0 ...
> >>
> >> Regarding existing parsers: the patch does not change any of the existing
> >> “Node … zone …” lines, it only adds a single header line before them. Most
> >> parsers match “Node” lines and ignore everything else, so the risk should be
> >> low. If you know of any existing parser that this would break, please let
> >> me know so I can address it.
> > 
> > What if there is a single one out there that has hardcoded to skip the first line only?
> 
> I understand there may be no way to be fully compatible with all existing
> parsers. However, /proc/buddyinfo is essentially raw data intended for
> human and tool consumption, and parsers are expected to be robust against
> format changes.

I am pretty sure you can create a trivial wrapper to print that header,
right?

> Adding a '#' prefix to the header would allow most parsers to skip it,
> but it still changes the file output and cannot fully guarantee that no
> external tool will be affected.                                          

That still assumes that they expect something like that.
We are trying really hard to not break existing userspace even if it is
not written in a robust way. That is simply how Linux kernel handles all
the existing interfaces. There must be a very serious reason to add a
change that might _theoretically_ breaker existing userspace. What you
are proposing here is not such a reason as it is trivial to achieve what
you want from the userspace.

NAK to the change.
-- 
Michal Hocko
SUSE Labs

