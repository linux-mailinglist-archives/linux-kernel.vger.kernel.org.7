Return-Path: <linux-kernel+bounces-749355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F624B14D46
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FF3518A2532
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACD328F53B;
	Tue, 29 Jul 2025 11:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EBuzt60K"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3432253A1
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 11:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753790321; cv=none; b=V9xyXKEDjKYWefgq76b/pv/v8BdGoEsRXj8Lo4tAok5qSOvTAH2GtygaAvr0T5t2eexoKdw4Fp9nLLYS3iA3MhaHO+oV3pevm3l1CHvq1bI7idn7ohH9GdWyUN5RX9L6f9u+xgdpKQg7RqTyI4F79X6GtexsJztLscSoVdM60tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753790321; c=relaxed/simple;
	bh=bVD0PfkCAQYUz6/cGmLQRrpqTU+hcmgFsaNj04pnO8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=norHak0zFLiTS3giIjReE2DGT8T8MqiJgcJVRAL1EEtwC6VJHRfk9f0DMFtQKH3wXDs7vY3Z0JTv/LkFTv7dVMaf6+iC1CH1/HZJwiKq8BhNZdfq9tUg0xbdZW8E7eYzbwwH9bOOd834+ymMW3XYi6I/8ArRzmWbxP8LB+p7eCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EBuzt60K; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-af0dc229478so784833166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 04:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753790316; x=1754395116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=POGWpZ6qfhFiTvd9Pz2ShFbRonEQM2kdGcmdneyMevg=;
        b=EBuzt60KMgx97wBQ/QOBmPS3uXj5x9VWI2X5tE4zBsCrz4jt/K02+6XyPsdq+SCxWp
         cLaqiwVuIJtPLb1wCTbZBdS6qILSZzP3zesJUvqWlMcqzfEmRguRWYIopBKjGx3kcYnG
         MXXoA/YrtBCh/XZT7cS8nzaiJivJCG1lweIqO5Jmy9NQ6dxsv7pWoVCQdFWNxePiqd0X
         lXFja1OrI1zYnEWCmWIQGSwj+KDMWqjE7MxWFfk4B9PIqfVIUfDSH+PHs2q2JteP5knX
         4i9dvOD0KhmXXsWs7FTRMaC9FzeHJTHfbJfpJj0MWFNsM8D6pRaRgZ325WDGXVaBnXFa
         kDUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753790316; x=1754395116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POGWpZ6qfhFiTvd9Pz2ShFbRonEQM2kdGcmdneyMevg=;
        b=jmzf8+rZH1KEWN9YO68tNLpCczSFKTHREAKykEcFDv/0y3Ic8ONt8HAGlUizTNXJh6
         2+yzokjtkpBfxKfCivzyYU20yll6kxVuscjMzIvz7fEdp+b//8q16Clf/Qn7rDx/y74l
         6vndUHofIv5lcG9WtUU432PJQNuDwXS0PEhdYF8T24Kql5524dG8pMABjwSUCOtq2dA8
         KXJUYH4Ys2S0H6MQhhFefpKjUpyO93qlNU3arg4iNdm8Yemlw57zJDJnRzODug8c9HLG
         4hIgvaRAZFFxMthhjkzAekmj5zub/mVEolfL5Nvp1zl7Udgwvsw1SThCP2SFNBB/1y0U
         0AbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyg/qNvECos7eBTvQ15B7FCglwNzG4EE+t8dkwYUnQc7lbwzKkYer8Hi9MLnNxljlrcfW2cBl6E2bo3fU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEWlqPjHoIE4z348wGf0DyhoCya7BnvB/CVrjzIWX9oaEoaqU7
	COIqB/Lp+Rqjkn+Jc8WpbSIq3B2C4hlxO2nmE+psOEB5b38VlTpr/i05pnA+vyvifp4=
X-Gm-Gg: ASbGncuaEzTlyyH1aPflnPAJ2fK4jqnHV8YURYlJlmAjDbssT+dD9p4zPulE1AfxHm5
	YPM81sBG5c49YirWRCuREGoCYLmsTbUVtSJvkaqqim4t7ZToHKiQuyn1gaZyNPoqyOa+igKY+Cw
	L3w5oQZl3wJTjsjEaxe+EUA0cuzDigIONo56rZT3r9taaxqN/7JePRqebk4JBT/Vt/3cL/yldCk
	HtnMmR5IbNkdq9UsXf3w+nKIX0hTn6Kd93VEfhxEpHIPwbLNPJXJxPqEYcYCGg2eQgZhxRI5TyP
	PLEE8RoCvVLwsyGAonpjdNs4se9DNlarzc6dp89YLqehTWea8fDIAC7kX8R/DDtVy/6C+gZ9XCA
	8ts9RjrduKbQlsoaUATnqNZ/pnWg+x6+FNH4=
X-Google-Smtp-Source: AGHT+IG1PlE2mU9I1BQPF6OmXGDdt5cctth20pJTLixg7HsQoYwzUDT2pBsAOMu+gzekNSgaFvaKhA==
X-Received: by 2002:a17:907:c0e:b0:ae3:a240:7ad2 with SMTP id a640c23a62f3a-af61c2af050mr1685740766b.2.1753790315585;
        Tue, 29 Jul 2025 04:58:35 -0700 (PDT)
Received: from localhost (109-81-20-172.rct.o2.cz. [109.81.20.172])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-af635a63aecsm576919266b.85.2025.07.29.04.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 04:58:35 -0700 (PDT)
Date: Tue, 29 Jul 2025 13:58:34 +0200
From: Michal Hocko <mhocko@suse.com>
To: Hannes Reinecke <hare@suse.de>
Cc: David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Hannes Reinecke <hare@kernel.org>
Subject: Re: [RFC] Disable auto_movable_ratio for selfhosted memmap
Message-ID: <aIi3ao2PV8GrYtRA@tiehlicka>
References: <aIc5XxgkbAwF6wqE@tiehlicka>
 <2f24e725-cddb-41c5-ba87-783930efb2aa@redhat.com>
 <aIc9DQ1PwsbiOQwc@tiehlicka>
 <79919ace-9cd2-4600-9615-6dc26ba19e19@redhat.com>
 <f859e5c3-7c96-4d97-a447-75070813450c@suse.de>
 <aId16W4EaqjANtKR@tiehlicka>
 <3e88642f-3914-42b0-b864-4ad374b659b5@redhat.com>
 <ac7add36-808d-4883-a09e-ef1bf6fd6834@suse.de>
 <aIiSEpQhWqPsvaST@tiehlicka>
 <41526d97-b3bc-423b-87f4-7e0ec6cd8292@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41526d97-b3bc-423b-87f4-7e0ec6cd8292@suse.de>

On Tue 29-07-25 11:33:58, Hannes Reinecke wrote:
> On 7/29/25 11:19, Michal Hocko wrote:
> > On Tue 29-07-25 09:24:37, Hannes Reinecke wrote:
> > > On 7/28/25 15:08, David Hildenbrand wrote:
> > > > On 28.07.25 15:06, Michal Hocko wrote:
> > > > > On Mon 28-07-25 11:37:46, Hannes Reinecke wrote:
> > > > > > On 7/28/25 11:10, David Hildenbrand wrote:
> > > > > > And to make matters worse, we have two competing user-space programs:
> > > > > > - udev
> > > > > > - daxctl
> > > > > > neither of which is (or can be made) aware of each other.
> > > > > > This leads to races and/or inconsistencies.
> > > > > 
> > > > > Would it help if generic udev memory hotplug rule exclude anything that
> > > > > is dax backed? Is there a way to check for that? Sorry if this is a
> > > > > stupid question.
> > > > Parsing /proc/iomem, it's indicated as "System RAM (kmem)".
> > > > 
> > > I would rather do it the other way round, and make daxctl aware of
> > > udev. In the end, even 'daxctl' uses the sysfs interface to online
> > > memory, which really is the territory of udev and can easily be
> > > done via udev rules (for static configuration).
> > 
> > udev doesn't really have any context what user space wants to do with
> > the memory and therefore how to online it. Therefore we have (arguably)
> > ugly hacks like auto onlining and movable_ration etc. daxctl can take
> > information from the admin directly and therfore it can do what is
> > needed without further hacks.
> > 
> Huh?
> I thought udev was _all_ about userspace preferences...
> We can easily have udev rules onlining memory with whatever policy
> the user want; the whole point of udev rules is that they are dynamic
> and can include policy decisions.

My experience with memory hotplug and udev doesn't match that. Udev
sees memory blocks showing up rather than understanding any concept of
what is the memory behind that. So any actual policy is rather hard to
define. You would need to backtrack what kind of memory blocks you are
seeing and what the initiator could have intended with them. 

While this could work reasonably for regular RAM appearing to your
system asynchronously (e.g. physical memory plugged in or virtual system
getting more memory) when you always want to online it in a certain way
I suspect this falls short for synchronous daxctl like usecase where you
know what to do with that memory and you can operate on sysfs directly.
Udev just makes the life much more complicated for the later IMO.
-- 
Michal Hocko
SUSE Labs

