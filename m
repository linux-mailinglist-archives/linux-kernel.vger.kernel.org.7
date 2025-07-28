Return-Path: <linux-kernel+bounces-747715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A54B13726
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 867233B7917
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489411DFD9A;
	Mon, 28 Jul 2025 09:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="grTU3/QE"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998ED20DD42
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753693458; cv=none; b=ojHofp5wJwgAtxQjQAfFVWAGR9IwCIf0pRK2oS0aLAheYrRJZZQGohTndLyoDIBPLJ4tj1SALSXDRIaFeU9bS4hEtL+7GIc27df0fE5sHeGi9pK15tq9R2eib2jQPxZQrmJN8x1cST9o4kGxiFSuo2leGSoCYk8+ErVxr2T7kN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753693458; c=relaxed/simple;
	bh=RH+Jko+Tb1m7SJqaKfCbTFyWtMVP2/FOi/lR8OyAC3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWKJ3DSLVs/XZMdvPlL8+oEpacuT3gCc+UxjgE3KKS+Ef1or+PdLlDggT1rDWQFq1iHOGOX77VaXBI167bdyW7NRFy7eQOYwS+o/NMgAcxcrEJsct8iMtNB8FuMwd1am+s4xclb+wSsZLiXmcyIj6y0EdiE5V+OjD8BaBLVbXmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=grTU3/QE; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae0c571f137so796676966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 02:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753693455; x=1754298255; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S68O6AzwEdKLqEq8namz/L+It2W3CWex5pQxYxKgojs=;
        b=grTU3/QEaHpSuq/pDeJ3cKrrVCYEc1v0acJ3KWL/3274kqbsjEILGMUtS50CeUskK6
         T/TZKMuILtKrcpwPGpluCOhYXbBfe9mbvy8wIvAMVqUtc/35aAk9AX7z8n6vAfiCkYor
         X+MCi2+Y9u0Sf20yIxLpICAhogkoHu0KFZp36ynl6cAaFr78RavTfmK4+YP7SLfwHCRM
         D6QnC+4OUlO6jMjfAMxFVfBacU5abqnAOTp5K0brdb/Nofh05ZulbFEgA5CD48MMGCWw
         Tcvu6IHnST/2OuNr7r0/QKgsItZfAR6Flvm7pTvRT/K12o8bCzc7JSjN3Xx9T7iBXJqw
         dLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753693455; x=1754298255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S68O6AzwEdKLqEq8namz/L+It2W3CWex5pQxYxKgojs=;
        b=DsDw3RaP1T3pn4b3bZa7rQzuMdY5cEnkQFb+PlCPtvM9c3psSDTk80w8RzHB/ts1ae
         8MwHamiXcVNxCOAMGcBzye3OEUk/7WjBuwUmhoOVIaB0wCGQBQFfCy70TgSvzjXd8bH0
         CNcygk/ERMf8USt/Kr3IiW9jhHX+7mNd2grKUcjtRAZM5a57RGtznAN1Tm2gBGuI+tHo
         T0nxIGPElRR8HZfa//OCGwcQCoyg25FvcTw5R6umV8KgmQzrM32KaGH4+rcLEFAZ9dYz
         lwqdLVQK4yfcR1CYvBp3Zjd69KaB/67XMM+S7JcZ7HQ2IJqpvYCjrwlS6ZbZZ+2Do8D4
         8Mpw==
X-Forwarded-Encrypted: i=1; AJvYcCXaxcC8TGxbRR+X5afV9VjFcTpIcNcSRwkukc7tPlkV38Vzy7PO9qrEGL2injoRfDxoBY7thlpoOxzptrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqCW/puRJCe8/uV/3S31+r749raC4OdfrEQQrZW2Xn/sHXPS+m
	JpbvXiEE9XJB7i0W5SNcWfjr7c/ByEM2L7yXKL/Gjm6jc2x7yqCBVUqomyniWhNFcrc=
X-Gm-Gg: ASbGnctJxmN6VzzWkPC+xst8dehYUWfofaxKggfO35uF5I2Kb2Rpq3kcS6Kd2VkaO3n
	zmQ/sZL3JAOmULTUZOzZEEqlzuwPYV7qy3ve/NAqlxpaQLJHi6gN01nyGx8pGW3kTziwJfd7xix
	KxThh/5y72BzboUoC5tV9UwxIjV8QxnhU8R9qMjuOwtgfr7XkN7egKIN7qv7Vgwwc2B2ZKKd61e
	epreyQfyu0JpaRXXZIZbcrqrn2pdGHHMHgfDUkdnMiKLCDX6Vn9j308DTp+RPL8TYwh/cdMp/73
	09x2x71qwhMvx755VxPtr6Kon28rL9pVLGoU58TxGvur1v+Lrx892QAcw5REuszpr861dNVt4xO
	Ndj6P//sb/Qu3k6OoiRbhpzE1cGx3aO/tV80=
X-Google-Smtp-Source: AGHT+IEzh/qHTBwjwxEhORlk/lRtm1Z2u7uAFeJXCmfVLX4GecccD/ls2PXjMoHMCkKaDwgZUeZLtQ==
X-Received: by 2002:a17:907:3f03:b0:ad5:42bd:dfab with SMTP id a640c23a62f3a-af6191eedbamr1150118566b.30.1753693454544;
        Mon, 28 Jul 2025 02:04:14 -0700 (PDT)
Received: from localhost (109-81-20-172.rct.o2.cz. [109.81.20.172])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-af635aea689sm393941666b.125.2025.07.28.02.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 02:04:14 -0700 (PDT)
Date: Mon, 28 Jul 2025 11:04:13 +0200
From: Michal Hocko <mhocko@suse.com>
To: David Hildenbrand <david@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Hannes Reinecke <hare@kernel.org>
Subject: Re: [RFC] Disable auto_movable_ratio for selfhosted memmap
Message-ID: <aIc9DQ1PwsbiOQwc@tiehlicka>
References: <aIcxs2nk3RNWWbD6@localhost.localdomain>
 <aIc5XxgkbAwF6wqE@tiehlicka>
 <2f24e725-cddb-41c5-ba87-783930efb2aa@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f24e725-cddb-41c5-ba87-783930efb2aa@redhat.com>

On Mon 28-07-25 10:53:08, David Hildenbrand wrote:
> On 28.07.25 10:48, Michal Hocko wrote:
> > On Mon 28-07-25 10:15:47, Oscar Salvador wrote:
> > > Hi,
> > > 
> > > Currently, we have several mechanisms to pick a zone for the new memory we are
> > > onlining.
> > > Eventually, we will land on zone_for_pfn_range() which will pick the zone.
> > > 
> > > Two of these mechanisms are 'movable_node' and 'auto-movable' policy.
> > > The former will put every single hotpluggled memory in ZONE_MOVABLE
> > > (unless we can keep zones contiguous by not doing so), while the latter
> > > will put it in ZONA_MOVABLE IFF we are within the established ratio
> > > MOVABLE:KERNEL.
> > > 
> > > It seems, the later doesn't play well with CXL memory where CXL cards hold really
> > > large amounts of memory, making the ratio fail, and since CXL cards must be removed
> > > as a unit, it can't be done if any memory block fell within
> > > !ZONE_MOVABLE zone.
> > 
> > I suspect this is just an example of how our existing memory hotplug
> > interface based on memory blocks is just suoptimal and it doesn't fit
> > new usecases. We should start thinking about how a new v2 api should
> > look like. I am not sure how that should look like but I believe we
> > should be able to express a "device" as whole rather than having a very
> > loosely bound generic memblocks. Anyway this is likely for a longer
> > discussion and a long term plan rather than addressing this particular
> > issue.
> 
> We have that concept with memory groups in the kernel already.

I must have missed that. I will have a look, thanks! Do we have any
documentation for that? Memory group is an overloaded term in the
kernel.

> In dax/kmem we register a static memory group. It will be considered one
> union.

But we still do export those memory blocks and let udev or whoever act
on those right? If that is the case then ....

[...] 

> daxctl wants to online memory itself. We want to keep that memory offline
> from a kernel perspective and let daxctl handle it in this case.
> 
> We have that problem in RHEL where we currently require user space to
> disable udev rules so daxctl "can win".

... this is the result. Those shouldn't really race. If udev is suppose
to see the device then only in its entirity so regular memory block
based onlining rules shouldn't even see that memory. Or am I completely
missing the picture?
-- 
Michal Hocko
SUSE Labs

