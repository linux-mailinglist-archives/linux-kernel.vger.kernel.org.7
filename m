Return-Path: <linux-kernel+bounces-819334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA940B59EDA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 19:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1DA548612B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6812F5A36;
	Tue, 16 Sep 2025 17:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0oZprcg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9159C2C11F0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 17:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758042472; cv=none; b=niWdXWSucqoTiD1Wj5KlAdQ55uPLe8XpXO+RyTvd0JNo2GFRAkaJ+OLVZ0fe+p7WouI3raRWNzUdZk83Sj+8M3vAECV9jEiDBfrrDliYkZZmhu0n0kXKgqm1/CIWRMT3dmBTUD8NcTmRgtjoYrXyxEvI+EmlCRlsa8BDqtDuwzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758042472; c=relaxed/simple;
	bh=x4t62n6qoMGHUscwTZJIKGNpPN6wwdruLXh4XohgnEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5soJBPdEJVWWO4yDmz2axYUd5sgYbdUMJ+trkfjKKckS5K9vb3L0h6Ifk1Atj9FE6b6mBErgwnjbTPt5xB52OUA4gJwQqZ9PtnynTs0mHVp/mSQoEBsPK3x0rJXq5/PJKsG4cW8K/rfMk7IrSLb11hClC5Aw1lVFRNSfVq/+M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U0oZprcg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758042469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G3KbOpCV6y4vZCLZsd26ud6uAmRpvckeE+th1wdyLDI=;
	b=U0oZprcgyozPppvfVZ6xd1sGVQPgQNIqEeotcjjTT0CIpP6jh33fB/fYa9p6vrNuSBHcwO
	g236DcmOOU2nGsFCDFT3iZBC/pTts+JtYC5sQoGlcXOhCjr2gq7E4EkYz4uU86AriGVERk
	t7C581tu7TGLngcwaAhWQtwqH20Ft/M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-116-wH0zHu9tP0a9pF-lDN59bg-1; Tue,
 16 Sep 2025 13:07:44 -0400
X-MC-Unique: wH0zHu9tP0a9pF-lDN59bg-1
X-Mimecast-MFC-AGG-ID: wH0zHu9tP0a9pF-lDN59bg_1758042462
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 146CC180047F;
	Tue, 16 Sep 2025 17:07:42 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.65.67])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 51326300018D;
	Tue, 16 Sep 2025 17:07:38 +0000 (UTC)
Date: Tue, 16 Sep 2025 13:07:35 -0400
From: Phil Auld <pauld@redhat.com>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, shashank.mahadasyam@sony.com,
	longman@redhat.com, tj@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: Report failed rt migrations to non-root
 cgroup without rt bandwidth under RT_GROUP_SCHED
Message-ID: <20250916170735.GA5293@pauld.westford.csb>
References: <20250916011146.4129696-1-atomlin@atomlin.com>
 <6zi6fp2kgs2hjychav3rrf22qwwskegdq53ew33tfn7rylueik@slugq2khaakw>
 <4nafhr4wqvta5uk4jfuxi7rc7fyaurflrfxa54ajaajy3o57mj@55qzh24m2u6s>
 <3emv4bx2o7mdv7oc72ffdinlltqohqjt5nxgccdiyw47xjgbww@drvkcpiy5zq5>
 <ziakoghx6xbfvcocc5kcrcw5gv4xlphto44bptadkfbbtyf6op@d2fvj7rbec26>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ziakoghx6xbfvcocc5kcrcw5gv4xlphto44bptadkfbbtyf6op@d2fvj7rbec26>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Sep 16, 2025 at 12:57:04PM -0400 Aaron Tomlin wrote:
> On Tue, Sep 16, 2025 at 05:44:14PM +0200, Michal Koutný wrote:
> > On Tue, Sep 16, 2025 at 10:47:56AM -0400, Aaron Tomlin <atomlin@atomlin.com> wrote:
> > > I would prefer not to take any action. However, is there a strong
> > > preference to demote the rt task so the CPU controller can be enabled in
> > > this context?
> > 
> > Maybe more context clarifies. The preference is not to end up in this
> > corner.
> 
> I see. If I understand correctly, in this context, are you suggesting to
> modify the identified task's scheduling class (e.g. to SCHED_NORMAL) so the
> CPU controller can be enabled?
> 
> > I wonder does this combination come from a distro or is it your custom
> > setup? I assume the latter (but I'm curious if there's such a distro), in
> > that case you likely want to have the cpu controller on v1 hierarchy. v1
> > usage is what the boottime switch is currently useful for, v2 de facto
> > doesn't support RT group scheduling as of today [1], v2 systems should
> > simply unset CONFIG_RT_GROUP_SCHED to avoid issues enabling cpu
> > controller.
> 
> Yes. Under Red Hat Enterprise Linux (RHEL) 9 Kconfig option
> CONFIG_RT_GROUP_SCHED and Cgroup version 2 is enabled by default.
> Albeit, upstream can disable SCHED_FIFO/SCHED_RT group scheduling at
> boot-time via rt_group_sched=.
>

 CONFIG_RT_GROUP_SCHED is not enabled in RHEL9 and later.  It was on in
 RHEL8 which also defaulted to cgroupv1.


Thanks,
Phil



> > HTH,
> > Michal
> > 
> > [1] This [2] didn't make it into tree thus I'd be reserved with the
> >     message printed in your patch too.
> > [2] https://lore.kernel.org/all/20250310170442.504716-11-mkoutny@suse.com/
> 
> I see. Understood.
> 
> 
> Kind regards,
> -- 
> Aaron Tomlin
> 

-- 


