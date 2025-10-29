Return-Path: <linux-kernel+bounces-875904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E33AC1A16E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D8CC58120D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B8E330337;
	Wed, 29 Oct 2025 11:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h3Labvbx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786C73161B8
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737795; cv=none; b=M0XEBxKtAhYZ6YbaACgSiDTkXcaCyCwEU7Q3hD8HogCXJVn+mi0aijboL5rRPpqVckp64g4O4KOysAxPfhmWGT8HQIuDwksDoj+M1DmXZlJWIp+PQiX/s2W2++pr51tSgf2Ck1CLsb5qJCJzJvW1+lD8ubkPKlGcd9d8dL0fybU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737795; c=relaxed/simple;
	bh=uBh/VIvn4X+SWEQPE+uFpXGqcS5G3IgcPGIJmDTsaWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NkSfpE8pqRVNC2dfmtI80ogEz91+FqLzOkHyJZehueFT0qCL5wfeRJgmdEZu9SmXL1p0HRifFEWUhCBLd0+NPUlMO2vfEpJ0v2FKHDRQPEoo76PK+RHqSI68dAZ5LZIvyfwo7mi4BQR+T1uJvgfhq2V/u8A2QYowVRh7Etiv/6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h3Labvbx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761737792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JewGrExeY4YUsH2Q4/QPO/3tV8s8JWgMbXOK4V6Kv3s=;
	b=h3LabvbxEb6SceoL9YIVUJ8j4gIcYfZ75O5IU1AiJR2jSIhjqJnwwIfb05iZbE2+SKy3ZX
	jBfDDlvwRX0q4l5/pyhkn5TBTxiQkYFlX2GAxAwBHPJJrL6rlc5U8eLIWWYrx2LDJuggLz
	21cj+G4IstnnhftDvCM1qKlZaNPzaJc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-YWvrsIZNM_63qENBF2bUfQ-1; Wed,
 29 Oct 2025 07:36:29 -0400
X-MC-Unique: YWvrsIZNM_63qENBF2bUfQ-1
X-Mimecast-MFC-AGG-ID: YWvrsIZNM_63qENBF2bUfQ_1761737786
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF401180899A;
	Wed, 29 Oct 2025 11:36:24 +0000 (UTC)
Received: from localhost (unknown [10.72.112.80])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 015433000223;
	Wed, 29 Oct 2025 11:36:20 +0000 (UTC)
Date: Wed, 29 Oct 2025 19:36:08 +0800
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
Message-ID: <aQH8KJ8RsnzbLfN2@fedora>
References: <20251022121345.23496-1-piliu@redhat.com>
 <20251022121345.23496-3-piliu@redhat.com>
 <877bwgw9yf.ffs@tglx>
 <aQAvnjVvJOUx78Nk@fedora>
 <87qzunuqqo.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87qzunuqqo.ffs@tglx>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Oct 28, 2025 at 01:59:11PM +0100, Thomas Gleixner wrote:
> On Tue, Oct 28 2025 at 10:51, Pingfan Liu wrote:
> > On Mon, Oct 27, 2025 at 06:06:32PM +0100, Thomas Gleixner wrote:
> >> When kexec() is in progress, then running user space tasks at all is a
> >> completely pointless exercise.
> >> 
> >> So the obvious solution to the problem is to freeze all user space tasks
> >
> > I agree, but what about a less intrusive approach? Simply stopping the 
> > DL tasks should suffice, as everything works correctly without them.
> 
> What's intrusive about that? Task freezing exists already.
> 

Thanks for your guidance. That's a good point -- system suspending is a
good analogy. I will check how PM handles it.

> > I have a draft patch ready. Let's discuss it and go from there.
> >
> >> when kexec() is invoked. No horrible hacks in the deadline scheduler and
> >> elsewhere required to make that work. No?
> >
> > To clarify, skipping the dl_bw_deactivate() validation is necessary 
> > because it prevents CPU hot-removal.
> 
> If you freeze stuff there is nothing to do. Hibernation works exactly
> that way without any magic hacks in a particular scheduling class, no?
> 

There is a nuance: DL bandwidth represents a commitment, not necessarily
the actual payload. Even a blocked DL task still occupies DL bandwidth.
The system's DL bandwidth remains unchanged as long as the CPUs stay
online, which is the case in hibernation.


Best Regards,

Pingfan


