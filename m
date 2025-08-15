Return-Path: <linux-kernel+bounces-771540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 941C6B28890
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 00:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA064189DF3F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 22:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514FD232395;
	Fri, 15 Aug 2025 22:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YFApGWgZ"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1DC278E7E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 22:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755298144; cv=none; b=XHBNOhGapZXfx8baeg8NdcJmeeNzAZNHPSV1Bd+qMMkh5Cgu52mPVUYXwtsg7QDGvSvRu8mSwH1lE5uj6Brv5sxnXrGv1WSeE6GtZMEPJlhaCqQ7ZtaZ3EFlKMmOy2vNZNI3tqMrY7kXdbgqsOb1j5VqNC5fW672gtA6I5638vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755298144; c=relaxed/simple;
	bh=hEYQ53E0RtOrd4ZHHqZCFyxPntSx5bEyNvRaoEdS9oA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lY/37o3x1svmh0Q7gQBwyez1KlhpCmZEKMSrljdBB/ix9Jr9jN8WSub236UEBFFERA4vxrDIIaiejei5DvBtqui6L06bgrvT//3R+Ke/8n1GdUk/JBkEYWWaJnbUs188TFrxTzw1v4zBd2CsrSTWyHFu+9VZ3LvenJOKTKqE+gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YFApGWgZ; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32326e21dd6so4464177a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 15:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755298142; x=1755902942; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9euPIpMrSJ979EFr8xoLMZB5t9W9T4ZhzaVwBCZaeas=;
        b=YFApGWgZlqvHa3gZvY+VX4rvK4uz9jSyo0AuZwXEhnPJ//3M+pkqNAY8nZrcg4mcB1
         S2+GJ0ADjC0qCCtoqBOQNYqojxHGVqObjDYqGXENzbJ2nTWUwxCNewQNOtPKUoMgvV5l
         kIe7y1k65tNzk4SJ3Fh33KkRVk65rx4eZ64VXOhTiEeA4F0gxjXV0b0klP5VwrZBH5pO
         BG0ZdSh8YUsclaZqwsVTzrebnclLCoTfiLV2Sr1MIjTYi+wNmyLzU4BtffVVulhUnMGj
         f6iR02xJ1avOSqkPFHHfpoL/ePCAdYnuY7QwpEZbAlUsPTTLyc4pyZfb2oHXDro+3sDI
         HUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755298142; x=1755902942;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9euPIpMrSJ979EFr8xoLMZB5t9W9T4ZhzaVwBCZaeas=;
        b=t6GkiQM5hLb+s+DTXkcaGzpGLq4tayrGmcZL9SdjrvwSsva3h497rqf/7PrrvlpjtA
         RQIrpXjHUVJrHF+MgOoFr3ZvUaMqxQzQ08uBTwTqG4DCbr+yHzqYhe4k1v9BlVRg5sS4
         88iaElSrKfryQ7D/fXyhACRZy1oUYf/L3gQeAThS0XkipS8YI9DbT8GgZJUKr2EE4MDT
         4Nw/GEcy6rRTkXmDqTpsqewDmD0GiVu/Fm0NBefd+vC1GVQHFUpGTdeWl3Dh4c2up2uB
         SbBuS5yHpl9Pc7M8Yy8OTMYnpjG7cKGh9ot7z/JZwM+XrVC2ptQdly6mpyrpIwVjDZ6K
         kHlg==
X-Forwarded-Encrypted: i=1; AJvYcCVqkLsSOchiWmMcNdYQcx0oIXHayVvwzRLg45idYA9mqSgcTr1oT5jz8JW3KETG4XV6PLZQFecApiMjOpE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6SXEW+SHTMsiHVy+UJjIp3xzslLeFlCSc9T4p+UbcPixGh9Tr
	mg2nJ1W9h4tI+T1SGjVYX21pNz52Zmyn/Q7ZNW3X0SGgCvOgNocxAhlWZ+D8RW0KnRcY9gM6Xj2
	SDmjlqw==
X-Google-Smtp-Source: AGHT+IEmTy8brzxjFB4ioL+2r7Yjh+0rohzBTIL5RZsLYaPKtB9/039kAKsXYHt1LncgE8kFws/S+YGJ0VE=
X-Received: from pjbst7.prod.google.com ([2002:a17:90b:1fc7:b0:321:6ddc:33a0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3886:b0:311:a314:c2ca
 with SMTP id 98e67ed59e1d1-32341e9f029mr5402699a91.6.1755298142434; Fri, 15
 Aug 2025 15:49:02 -0700 (PDT)
Date: Fri, 15 Aug 2025 15:49:00 -0700
In-Reply-To: <20250815220436.GJaJ-u9FUVTmjyaaua@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250721181155.3536023-1-yazen.ghannam@amd.com>
 <20250722165615.GCaH_CryG7kNrAS4O6@renoirsky.local> <20250723183426.GA1158000@yaz-khff2.amd.com>
 <27E487FE-EC8D-42AC-B259-F8A18776C802@alien8.de> <aIKehTDgP-Nu36ol@google.com>
 <3cc16f7d-c650-43f2-b0ca-d99c427cd69b@amd.com> <aIKmeclza-9TDe4U@google.com>
 <20250725065009.GAaIMpIVgAKi0kMBVv@renoirsky.local> <aJ-pJvrPyHyPI0qS@google.com>
 <20250815220436.GJaJ-u9FUVTmjyaaua@fat_crate.local>
Message-ID: <aJ-5XDXp1CxKB_7J@google.com>
Subject: Re: [PATCH] x86/CPU/AMD: Ignore invalid reset reason value
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Mario Limonciello <mario.limonciello@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, Libing He <libhe@redhat.com>, 
	David Arcari <darcari@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Sat, Aug 16, 2025, Borislav Petkov wrote:
> On Fri, Aug 15, 2025 at 02:39:50PM -0700, Sean Christopherson wrote:
> > Not all of those use cases will want to access "bare metal" features, but my
> > point is that inferring anything about the system setup based solely on the
> > HYPERVISOR flag is all but guaranteed to break sooner or later.
> 
> No, that's *exactly* why I will want to check HYPERVISOR. Because I don't know
> what any of that virt zoo of paravisors, smaller layers, this and that layers
> are hiding from me.
> 
> That's exactly why I cannot trust that register anymore.
> 
> Or do you have a better suggestion how am I to know in the kernel whether the
> values I read from that register actually come from the hardware the feature
> support was added for? Or not some funky layer in-between.

I'm saying the kernel shouldn't care.  This patch fixed a bug/flaw where the
kernel didn't check for valid data.  Here's another in-progress bug where the
kernel isn't sufficiently paranoid/hardened and runs afoul of a VMM that is
operating within spec, but differently from bare metal systems:

https://lore.kernel.org/all/ZjEfVNwRnE1GUd1T@google.com

In both cases, the kernel can avoid badness without needing to know/care where
an unexpected value/result came from.

For things like zen2_zenbleed_check() where the kernel needs to check a ucode
revision and toggle a uarch specific chicken bit, yeah, go ahead and query
HYPERVISOR because there's no sane alternative.  But I want HYPERVISOR to be
viewed as an absolute last resort, not as a way to paper over kernel flaws.

> Hell, I can't even trust HYPERVISOR. Because some sneaky layer might not even
> set it.
> 
> Which makes this even worse.

That's pretty much my point: HYPERVISOR says that there is a hypervisor underneath,
and that's about it.

> > That seems like a gigantic waste of time/effort.  E.g. imagine the pain/churn if
> > MONITOR/MWAIT had been limited to !HYPERVISOR simply because early VM setups
> > didn't support executing MONITOR/MWAIT natively.
> 
> No, that's called enablement. You test the kernel on your new hw or HV env and
> then you send patches and claim support. And we support it.

That simply can't scale.  If you really want to make everything off-by-default
for VMs, then the kernel would need hundreds of HYPERVISOR checks.

How would you draw the line, i.e. how would you choose which features get to be
automatically used when running as a guest and which features need explicit
enablement from someone?  I think the only reasonable answer is that features
with any kind of detection mechanism should just use that and not check HYPERVISOR,
because checking HYPERVISOR would add an extra layer of "enablement" with no
meaningful benefit.

Which is what I'm suggesting here.  If an MMIO load reads back -1u, then it's a
darn good signal that FCH_PM_S5_RESET_STATUS is either unsupported or malfunctioning.
I don't see any reason to drag HYPERVISOR into the mess.

> > I don't mind HYPERVISOR per se, what I don't like is disabling code (or going
> > down different paths) based solely on historical use cases, i.e. based on the
> > assumption that "no one will ever do xyz!".  I have no objection to pivoting
> > on HYPERVISOR if there is an explicitly documented limitation, or for cases where
> > there's a very high probability of making a bad decision, e.g. using FMS to
> > enumerate features.
> 
> I don't think you're reading me here: it is not "no one will ever do". It is
> "off until someone really says she will do it. And do it according to the hw spec."

I am 100% in favor in holding VMMs to hardware specs, but IMO this isn't a case
where the VMM is operating out of spec.

