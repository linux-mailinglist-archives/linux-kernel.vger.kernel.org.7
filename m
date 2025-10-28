Return-Path: <linux-kernel+bounces-872953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8CDC12B23
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 03:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3B8E1885FF6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 02:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC2B2777EA;
	Tue, 28 Oct 2025 02:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iMLsEB6P"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2413FA92E
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761619885; cv=none; b=cHmvqOrk/h+HIdveffLgeqOoLItiKODDVca5Eg2H1diI9aQAe3P3CaOUFcQeye8UDGRrsI8l/mttm/rk7Wz3p4nlU3PI/crZUCse177Ini1MAe3XDpvTz/INCyRt/WBf4j43VBAOUlTmbpJfVBOuvtN+TlStw14OaFz0/JpKhJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761619885; c=relaxed/simple;
	bh=2XZeoXAHmrvmL/h1x+qgzdGqiTGDwqqzaK+klC5aXAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3Xidf1oPsBM1EdgTSoRxAmdVZhZPrUv/6z7H/CpCMJSaMNgWT2Ac+fGtQfHwFPhLd1P+cfGuOMJ9+J2nwzzMWEcLkFJXlmxRNcTRnqMFkZU1/KEArN6Q/iIMH+HOsH6F1UFYo3OncJwqz5MG90MwERRDmxMgSGZiB+mt5AqP3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iMLsEB6P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761619883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6bHyVAfRhdtoMkPIMCM0f6+n/GpxOic0/cT5m6U1ju4=;
	b=iMLsEB6Pk5jx1vcaKNKUIVpZLMgYVMWOF3fzbynLlR5g/vxDrCAeOp1wiZ6lO/kOV4zyQz
	w9sk7/gbQpBDwT3LFzBjemeouUqjcS54nU5FrMC1sbuftHQc8wDQ3fQGkLjEROzSxDmcp5
	aGbbz6X5NgcZMzmUPlygS4LfTAC2DaY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-331-sEyS3Qa7N72ZSQg-1oyOLg-1; Mon,
 27 Oct 2025 22:51:19 -0400
X-MC-Unique: sEyS3Qa7N72ZSQg-1oyOLg-1
X-Mimecast-MFC-AGG-ID: sEyS3Qa7N72ZSQg-1oyOLg_1761619878
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0910B180035A;
	Tue, 28 Oct 2025 02:51:17 +0000 (UTC)
Received: from localhost (unknown [10.72.112.84])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 94F2D30001A2;
	Tue, 28 Oct 2025 02:51:13 +0000 (UTC)
Date: Tue, 28 Oct 2025 10:51:10 +0800
From: Pingfan Liu <piliu@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Joel Granados <joel.granados@kernel.org>
Subject: Re: [RFC 2/3] kernel/cpu: Mark nonboot cpus as inactive when
 shutting down nonboot cpus
Message-ID: <aQAvnjVvJOUx78Nk@fedora>
References: <20251022121345.23496-1-piliu@redhat.com>
 <20251022121345.23496-3-piliu@redhat.com>
 <877bwgw9yf.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877bwgw9yf.ffs@tglx>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Oct 27, 2025 at 06:06:32PM +0100, Thomas Gleixner wrote:
> On Wed, Oct 22 2025 at 20:13, Pingfan Liu wrote:
> > The previous patch lifted the deadline bandwidth check during the kexec
> 
> Once this is applied 'The previous patch' is meaningless.
> 

I will rephrase it.
> > process, which raises a potential issue: as the number of online CPUs
> > decreases, DL tasks may be crowded onto a few CPUs, which may starve the
> > CPU hotplug kthread. As a result, the hot-removal cannot proceed in
> > practice.  On the other hand, as CPUs are offlined one by one, all tasks
> > will eventually be migrated to the kexec CPU.
> >
> > Therefore, this patch marks all other CPUs as inactive to signal the
> 
> git grep "This patch" Documentation/process/
> 

I will rephrase it.
> > scheduler to migrate tasks to the kexec CPU during hot-removal.
> 
> I'm not seeing what this solves. It just changes the timing of moving
> tasks off to the boot CPU where they compete for the CPU for nothing.
> 
> When kexec() is in progress, then running user space tasks at all is a
> completely pointless exercise.
> 
> So the obvious solution to the problem is to freeze all user space tasks

I agree, but what about a less intrusive approach? Simply stopping the 
DL tasks should suffice, as everything works correctly without them.

I have a draft patch ready. Let's discuss it and go from there.

> when kexec() is invoked. No horrible hacks in the deadline scheduler and
> elsewhere required to make that work. No?
> 

To clarify, skipping the dl_bw_deactivate() validation is necessary 
because it prevents CPU hot-removal.


Thanks,

Pingfan


