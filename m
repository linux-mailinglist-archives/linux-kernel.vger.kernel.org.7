Return-Path: <linux-kernel+bounces-832868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F48BA09BB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAADE1C21B3F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCEF305E20;
	Thu, 25 Sep 2025 16:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HjVua/qf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F483054CE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 16:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758817775; cv=none; b=Fz+D37MP0cI4bQuZvJYSDh0eeaE1gVq7lCF7fxJ8+PwApHcNyM+S3Mfi0fGM/4VeGipouPu/yiAXwGSuQIFS+cpycmK931ifPuzxXWIJzxgFR4MfVCcs1qj2ihKpu+d2vbotaD323unrnky8PIcDWGwUBivQ7zmZXwllaj+F0C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758817775; c=relaxed/simple;
	bh=4Q02x58ff8xo3XJUxT85sRS1fAqIrAbAgZJmVj/b/TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZexkHQyfdkGLAnKjb6wofG39boryZL6Hw9EFTKut2faQ1SoISPv4XmH6PQeyn+qOyJidvU9i82sdboMiZsFsGFHlKkssbtSSa1VCE8UNkMiGjK6sEdnSMO3kxSdVU6cAoAtjSaP1iinOQfi5ptPXHADEAb4IdUqWtGQz0HWtoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HjVua/qf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758817772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Q02x58ff8xo3XJUxT85sRS1fAqIrAbAgZJmVj/b/TU=;
	b=HjVua/qf4IbgOJ1U7Gtc5ak7BwJmwxFSnuaJtksdE2wQk5lFRKueG9LiIHEFWEWhhWT8Zz
	wX+uRMmdRCEU0RrvACXFnJqVTNctY+6MH/hT6kVDu+7PKqiA58darXJvtn+/H1lJld9Imn
	5OmjPytQ5RHLZjUhDKrPDw27L45wBOE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-Xkm417t1MkCuW39w9UZ8-A-1; Thu,
 25 Sep 2025 12:29:28 -0400
X-MC-Unique: Xkm417t1MkCuW39w9UZ8-A-1
X-Mimecast-MFC-AGG-ID: Xkm417t1MkCuW39w9UZ8-A_1758817767
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A3F011955D48;
	Thu, 25 Sep 2025 16:29:27 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.32.16])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id BDF0D19540EF;
	Thu, 25 Sep 2025 16:29:24 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 25 Sep 2025 18:28:04 +0200 (CEST)
Date: Thu, 25 Sep 2025 18:28:00 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel: Prevent prctl(PR_SET_PDEATHSIG) from racing with
 parent process exit
Message-ID: <20250925162759.GA25838@redhat.com>
References: <20250913-fix-prctl-pdeathsig-race-v1-1-44e2eb426fe9@gmail.com>
 <ef4878fe-3edf-4bd0-bb33-116ced1a4eb8@gmail.com>
 <20250922154819.c3049158ca006e1561ff5dcb@linux-foundation.org>
 <20250923120344.GA12377@redhat.com>
 <CAGudoHED4nx8QT-yw-zdcUApUyvt2HCOR9c3SQ3tAm9J7Q1jEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHED4nx8QT-yw-zdcUApUyvt2HCOR9c3SQ3tAm9J7Q1jEQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Sorry for the late reply...

On 09/23, Mateusz Guzik wrote:
>
> On Tue, Sep 23, 2025 at 2:05 PM Oleg Nesterov <oleg@redhat.com> wrote:
> > As you correctly pointed out, forget_original_parent/prctl lack the necessary
> > barries. So lets add the barriers instead of abusing tasklist? As for sys_prctl(),
> > I think that ret-to-user-mode + enter-the-kernel-mode should act as a full
> > barrier, so it only needs WRITE_ONCE()...
> >
>
> So I looked over this and I think I see why you are not eager to fix
> the problem to begin with. ;)
>
> I agree with reluctance to take tasklist lock to handle
> PR_SET_PDEATHSIG, but I wonder if in practice this is used rarely
> enough that the lock trip would not be a problem? It avoids any
> modifications to the exit codepath.

Yes... I mostly dislike the fact that this patch adds another possibility
to easily abuse the global tasklist lock from userspace...

> By barriers I presume you meant smp_mb() between
> RCU_INIT_POINTER(t->real_parent, reaper) and
> READ_ONCE(t->pdeath_signal) in forget_original_parent.

Yes,

> That's very
> nasty as the full fence is quite expensive.

Well, the exit_notify() path is already heavy, not sure smp_mb() or
smp_store_mb(real_parent, reaper) can add a noticeable difference.

> > Or perhaps user-space can do something else to sync with the exiting parent
> > instead of using getppid() ?
> >
>
> I never put any thought concerning this mechanism, I do think it
> nicely showcases the prctl at hand is kind of crap. The non-crap
> version would pass the PID you think your parent is, so that you do
> this race-free.

Or PR_SET_PDEATHSIG_FOR_CHILDREN(pdeath_signal), or the new
CLONE_WITH_PDEATHSIG. Or something else, I agree that the current API is,
well, not perfect ;)

> I don't know if makes any sense to add this.

Neither me.

OK. I won't argue with this patch. At least the usage of tasklist_lock is well
documented.

Thanks!

Oleg.


