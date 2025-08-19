Return-Path: <linux-kernel+bounces-775976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0913B2C70C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 985265A1BD7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EC22641FC;
	Tue, 19 Aug 2025 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OIWsH0mU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEBB25C816
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755613650; cv=none; b=dZDCiceEQQC1KZITWbxstc38quHkJzFhCWcpyLrBsa6Gtm3dCoEYZevTOWkCw8vsSjddHAAJVzWCMEGIdKxFZcLHLeAEsoF+P5imQT3xCzjtydwYUedBQ5yFCYS0muPK3l4AGQySdDj4Z/1Drf1cyJT6t+4plzUqPnw0pzYZ4Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755613650; c=relaxed/simple;
	bh=OQd6WyJiBXivtkbcozQYOMBkQHzyHn3BeH0okt4mHFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9fSmjDDkUw4hMvJ5rplm0u3kO1j2W21TQC8OG0szj9jdLRDuZGbLTub0dOK4fyNj6MhEIrGR5Z0hjlGwRYLxjD6bwVY8VfUGFXgBBiYx5Yra3paCq373AoDb+SNO7YciyC9ziK3sHqHEGQH5QxcUWJD4gJf/8DIsEBVxYiq1As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OIWsH0mU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755613648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kBL4QIUEuCXE0TXbnT7c7x6cfNngTzRNwvM7EKSyCmw=;
	b=OIWsH0mUwR2EZfTzr4qTcpsXVnGM0weweDmMDocXSQIOWTA3gD8zLJxnSWwBBH34Qqevev
	Yd7WmiMILBxpfx6xbqss4v9FbhE0NCJKPS9CV7s4NuTW65ulRlWRCiqYeIcPx/xRc9SXsw
	9Vm0v0PJqdkFC27m4i8afTmP+kfOlZc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-rcGsyx_uOJu8BGHY0iISAw-1; Tue,
 19 Aug 2025 10:27:23 -0400
X-MC-Unique: rcGsyx_uOJu8BGHY0iISAw-1
X-Mimecast-MFC-AGG-ID: rcGsyx_uOJu8BGHY0iISAw_1755613642
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C43A1195608A;
	Tue, 19 Aug 2025 14:27:21 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.95])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 1B54019A4CA1;
	Tue, 19 Aug 2025 14:27:17 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 19 Aug 2025 16:26:03 +0200 (CEST)
Date: Tue, 19 Aug 2025 16:25:58 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Xiang Gao <gxxa03070307@gmail.com>, joel.granados@kernel.org,
	lorenzo.stoakes@oracle.com, linux-kernel@vger.kernel.org,
	gaoxiang17 <gaoxiang17@xiaomi.com>, mjguzik@gmail.com,
	Liam.Howlett@Oracle.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] pid: Add a judgment for ns null in pid_nr_ns
Message-ID: <20250819142557.GA11345@redhat.com>
References: <20250802022123.3536934-1-gxxa03070307@gmail.com>
 <20250819-anbeginn-hinsehen-5cf59e5096d4@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819-anbeginn-hinsehen-5cf59e5096d4@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 08/19, Christian Brauner wrote:
>
> On Sat, 02 Aug 2025 10:21:23 +0800, Xiang Gao wrote:
> > __task_pid_nr_ns
> >         ns = task_active_pid_ns(current);
> >         pid_nr_ns(rcu_dereference(*task_pid_ptr(task, type)), ns);
> >                 if (pid && ns->level <= pid->level) {
> >
> > Sometimes null is returned for task_active_pid_ns. Then it will trigger kernel panic in pid_nr_ns.
> >
> > [...]
>
> Applied to the vfs-6.18.pidfs branch of the vfs/vfs.git tree.
> Patches in the vfs-6.18.pidfs branch should appear in linux-next soon.
>
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs-6.18.pidfs
>
> [1/1] pid: Add a judgment for ns null in pid_nr_ns
>       https://git.kernel.org/vfs/vfs/c/006568ab4c5c
> [1/4] pid: make __task_pid_nr_ns(ns => NULL) safe for zombie callers
>       https://git.kernel.org/vfs/vfs/c/abdfd4948e45
> [3/4] pid: change bacct_add_tsk() to use task_ppid_nr_ns()
>       https://git.kernel.org/vfs/vfs/c/b1afcaddd6c8
> [4/4] pid: change task_state() to use task_ppid_nr_ns()
>       https://git.kernel.org/vfs/vfs/c/d00f5232851c

Hmm. The 1st patch adds the ns != NULL check into pid_nr_ns().

This means that "[1/4] pid: make __task_pid_nr_ns(ns => NULL) safe for zombie callers"
(commit  abdfd4948e45c51b19 in vfs-6.18.pidfs) is not needed.

OTOH... You didn't take

	[PATCH 2/4] pid: introduce task_ppid_vnr()
	https://lore.kernel.org/all/20250810173610.GA19995@redhat.com/

currently in -mm tree. It is purely cosmetic, but imo makes sense.

Oleg.


