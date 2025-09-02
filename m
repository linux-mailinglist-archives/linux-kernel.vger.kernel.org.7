Return-Path: <linux-kernel+bounces-796799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8964FB4074C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B930256776F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB163126A0;
	Tue,  2 Sep 2025 14:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VR913EFY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2449F3043C3
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 14:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756823934; cv=none; b=P2X5EcG8mNl9fAuruk/Q3TFOAWuGxtGsQpdqib2CGVJBga9ArfO/0bQeKfctrPGGCXcpIIKJy4cyp8e48ITr1LDLq1yY0zWFWMnLAA4a6iqBIhoFEGoQEPuugN0B2CzTcD0GlDIONkzigJLmPcDvNMNdw/X+VeoO25QNHcxOd2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756823934; c=relaxed/simple;
	bh=B+bjGs0ahIjkuQh5AbaAzAbFKFrXHeStEYCujezPTSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmJHESC6vSq+sjEGkIA9leWx1jUHcOfKZLXo8rXVAs5zL/HphpIlhzBbbd5eGJcmaZZqW4oBeMWFdqVmpvUc0vRJntWah6SZS6tAsAcEobX0IB4Nu/Ub+e1C00VD/FSx9ic39o9SdsPWH8W6wcdrpKJ21jMdMAPIvBYE0JAtWGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VR913EFY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756823931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nDfb2mNQlYUJreeSqjEK8maAKMo/DjLg7OZ89XZP+PY=;
	b=VR913EFYpQEZ8AMJjB8nrqiX+lVF1lFV20hnDPaQWXFBEp3+UX4xWtiqJMWEvO+Ex+KFfX
	NGCj+1nVn00Hn7vNH7NL4QFwDrwtMLFOSXGB2i2P7lfMgJc848ErBxSuFlTYLTMjoY3B1z
	cmHZ7pOti7cKXaO0gnBGwhjBQsoBFO0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-DWhYT4r-NnK5dMJXHPyIzw-1; Tue,
 02 Sep 2025 10:38:48 -0400
X-MC-Unique: DWhYT4r-NnK5dMJXHPyIzw-1
X-Mimecast-MFC-AGG-ID: DWhYT4r-NnK5dMJXHPyIzw_1756823925
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B869418002D0;
	Tue,  2 Sep 2025 14:38:44 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.32.37])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 3861318004D4;
	Tue,  2 Sep 2025 14:38:39 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  2 Sep 2025 16:37:22 +0200 (CEST)
Date: Tue, 2 Sep 2025 16:37:17 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Xiang Gao <gxxa03070307@gmail.com>, joel.granados@kernel.org,
	lorenzo.stoakes@oracle.com, linux-kernel@vger.kernel.org,
	gaoxiang17 <gaoxiang17@xiaomi.com>, Liam.Howlett@oracle.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] pid: Add a judgment for ns null in pid_nr_ns
Message-ID: <20250902143716.GB23520@redhat.com>
References: <20250802022123.3536934-1-gxxa03070307@gmail.com>
 <20250819-anbeginn-hinsehen-5cf59e5096d4@brauner>
 <20250819142557.GA11345@redhat.com>
 <20250901153054.GA5587@redhat.com>
 <CAGudoHEoK9f=M6-iOL5yHqK=o4wiJW_78t88BEwsAksAW5HNqQ@mail.gmail.com>
 <CAGudoHHY7dMmxAc7x0avSxpNz-MfitQa-Shv2MSisLm-r4GH-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHHY7dMmxAc7x0avSxpNz-MfitQa-Shv2MSisLm-r4GH-A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 09/01, Mateusz Guzik wrote:
>
> On Mon, Sep 1, 2025 at 5:44 PM Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > On Mon, Sep 1, 2025 at 5:32 PM Oleg Nesterov <oleg@redhat.com> wrote:
> > >
> > > ping...
> > >
> > > We need either
> > >
> > >   [1/1] pid: Add a judgment for ns null in pid_nr_ns
> > >   https://git.kernel.org/vfs/vfs/c/006568ab4c5c
> > >
> > > or
> > >
> > >   [1/4] pid: make __task_pid_nr_ns(ns => NULL) safe for zombie callers
> > >   https://git.kernel.org/vfs/vfs/c/abdfd4948e45
> > >
> > > in any case imo the changelog should explain why do we care
> > > to check ns != NUll, "Sometimes null is returned for task_active_pid_ns"
> > > doesn't look like a good explanation...
> > >
> >
> > Since I caught this a stray patchset I'll bite: given the totally
> > arbitrary task struct in an irq handler, why even allow querying it
> > from that level? The task is literally random, and even possibly dead
> > as in this crash report.

I won't really argue. And initially I was going to "ignore" the original
bug report. If nothing else, the code which triggered the crash was buggy.
But then I changed my mind. People will do mistakes, I think it would be
better to make this API a bit safer. See below.

But in any case, at least one of the patches above should be removed from
vfs-6.18.pidfs.

OTOH, the trivial/cosmetic

	[PATCH 2/4] pid: introduce task_ppid_vnr()
	https://lore.kernel.org/all/20250810173610.GA19995@redhat.com/

makes sense imo, and it was missed.

Now. I mostly agree about IRQ, but to me it would be better to avoid the
crash if, say, task_pid_vnr(&init_task) is called from IRQ context.

But lets forget about IRQ. Please look at the changelog in
[PATCH 1/4] pid: make __task_pid_nr_ns(ns => NULL) safe for zombie callers

Even task_ppid_nr_ns(current, NULL) is not safe if it is called by the
exiting task after exit_notify() in the process context, and this is not
immediately clear. This doesn't look good to me.

> Maybe even go a little further and assert that the task at hand is
> fully constructed and not exiting yet.

So what do you suggest? Add the current->exit_state check somewhere?

Oleg.


