Return-Path: <linux-kernel+bounces-794941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E479BB3EB1F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61494189C8A3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A8F2D5924;
	Mon,  1 Sep 2025 15:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ot6/pVbJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8157F191484
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 15:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756740750; cv=none; b=p+lgZdcAU6YgrDAGgvflobsUQD7/+Tdz1ykKKJoQE07E2CaIicHRLafCMPWieSkYtRc/NFF6qJfM6a0Q2diadXsCCnWPu3mf2xk/sZMCUo76XsLKUwS9R8kAnnsx9k1OjfJ1gA4NggGeyeCUZdJUXRCqlrHj6Lsjx7uQ0kGTT0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756740750; c=relaxed/simple;
	bh=RcvhfihX6YU4et0XfG7utIubbDfCoaYkRi5WUgcIWjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oB6j30/Stw8enUv/e+RLEghFooHi7HgAWBhC38LPH8uk2PEXC1JrWgrUSdcOFiD/rQq1r8Foh5J3UsuOBoEXf5+WLvDgj0Tdfux8msldhwuMA+Smij7ie0z/iv+7ZO/h1jwk27vioy4lNflm20r/WRtE3DcWfefrsRyH6mGyzZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ot6/pVbJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756740747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9ceJOwXYjEfi6iZwg8CY4/yrYQPsO+14he7tUO05MVg=;
	b=Ot6/pVbJ+g7qjnbP+fyAFBgSzVcai3I15gPnbStutdPJxO9vX0rMcgdH3gvqu37zUf8Yf/
	8PCoKecfPaUR1vSuXZ9F/UqMw1bwvQBK3eze7p5js/ygn6jOk58ZmC1cUEX/sUBJj4e82A
	YgSCNiAUDRUYTeFzewnGd+QoHYDEemA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-t9iRqwykPFmsFf3Tbab8zQ-1; Mon,
 01 Sep 2025 11:32:24 -0400
X-MC-Unique: t9iRqwykPFmsFf3Tbab8zQ-1
X-Mimecast-MFC-AGG-ID: t9iRqwykPFmsFf3Tbab8zQ_1756740743
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B5E6B18003FC;
	Mon,  1 Sep 2025 15:32:22 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.32.37])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 53B2F30001A2;
	Mon,  1 Sep 2025 15:32:17 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  1 Sep 2025 17:31:00 +0200 (CEST)
Date: Mon, 1 Sep 2025 17:30:55 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Xiang Gao <gxxa03070307@gmail.com>, joel.granados@kernel.org,
	lorenzo.stoakes@oracle.com, linux-kernel@vger.kernel.org,
	gaoxiang17 <gaoxiang17@xiaomi.com>, mjguzik@gmail.com,
	Liam.Howlett@Oracle.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] pid: Add a judgment for ns null in pid_nr_ns
Message-ID: <20250901153054.GA5587@redhat.com>
References: <20250802022123.3536934-1-gxxa03070307@gmail.com>
 <20250819-anbeginn-hinsehen-5cf59e5096d4@brauner>
 <20250819142557.GA11345@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819142557.GA11345@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

ping...

We need either

  [1/1] pid: Add a judgment for ns null in pid_nr_ns
  https://git.kernel.org/vfs/vfs/c/006568ab4c5c

or

  [1/4] pid: make __task_pid_nr_ns(ns => NULL) safe for zombie callers
  https://git.kernel.org/vfs/vfs/c/abdfd4948e45

in any case imo the changelog should explain why do we care
to check ns != NUll, "Sometimes null is returned for task_active_pid_ns"
doesn't look like a good explanation...

Oleg.

On 08/19, Oleg Nesterov wrote:
>
> On 08/19, Christian Brauner wrote:
> >
> > On Sat, 02 Aug 2025 10:21:23 +0800, Xiang Gao wrote:
> > > __task_pid_nr_ns
> > >         ns = task_active_pid_ns(current);
> > >         pid_nr_ns(rcu_dereference(*task_pid_ptr(task, type)), ns);
> > >                 if (pid && ns->level <= pid->level) {
> > >
> > > Sometimes null is returned for task_active_pid_ns. Then it will trigger kernel panic in pid_nr_ns.
> > >
> > > [...]
> >
> > Applied to the vfs-6.18.pidfs branch of the vfs/vfs.git tree.
> > Patches in the vfs-6.18.pidfs branch should appear in linux-next soon.
> >
> > Please report any outstanding bugs that were missed during review in a
> > new review to the original patch series allowing us to drop it.
> >
> > It's encouraged to provide Acked-bys and Reviewed-bys even though the
> > patch has now been applied. If possible patch trailers will be updated.
> >
> > Note that commit hashes shown below are subject to change due to rebase,
> > trailer updates or similar. If in doubt, please check the listed branch.
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> > branch: vfs-6.18.pidfs
> >
> > [1/1] pid: Add a judgment for ns null in pid_nr_ns
> >       https://git.kernel.org/vfs/vfs/c/006568ab4c5c
> > [1/4] pid: make __task_pid_nr_ns(ns => NULL) safe for zombie callers
> >       https://git.kernel.org/vfs/vfs/c/abdfd4948e45
> > [3/4] pid: change bacct_add_tsk() to use task_ppid_nr_ns()
> >       https://git.kernel.org/vfs/vfs/c/b1afcaddd6c8
> > [4/4] pid: change task_state() to use task_ppid_nr_ns()
> >       https://git.kernel.org/vfs/vfs/c/d00f5232851c
> 
> Hmm. The 1st patch adds the ns != NULL check into pid_nr_ns().
> 
> This means that "[1/4] pid: make __task_pid_nr_ns(ns => NULL) safe for zombie callers"
> (commit  abdfd4948e45c51b19 in vfs-6.18.pidfs) is not needed.
> 
> OTOH... You didn't take
> 
> 	[PATCH 2/4] pid: introduce task_ppid_vnr()
> 	https://lore.kernel.org/all/20250810173610.GA19995@redhat.com/
> 
> currently in -mm tree. It is purely cosmetic, but imo makes sense.
> 
> Oleg.


