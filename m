Return-Path: <linux-kernel+bounces-868623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5EDC05A4C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 209824FF983
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD6F308F13;
	Fri, 24 Oct 2025 10:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bekDeUsl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF291D5CEA
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761302545; cv=none; b=GVD/5Ov/+U7J4gLAAh30Ym6jKWyx4e+Cq+EhHxhkmPefHoGsILnVNrTcfcX5K1R/LyheD+cIpWo05w6+7zd/MfXfq4rcZMQFrdZpaGshroZGwZhr5JswqUwKI1xF/iTDQIZQRN1kidHQfigt6/JS28WyjQ2b383LKi4aPJPCUQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761302545; c=relaxed/simple;
	bh=TU+SB4chmKlAHFAsYM8hhOGvRKhnkpvHMT+cCK8DBK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkXR7t3O4nuytnRhh0NXD3e37SoVrwtfV3DEfQ/vqaiu5WJiAhZGatR3TT6R+d2xXxPH+qTamZmuhJ3moeabTbRhfmuvZmQCYowntsI2vnSzd13BANL7DvIop6RAP3AbTdbXggL+Ca8xvDOHrr18QANJ7zUNnBj6Ik9WPoiDGtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bekDeUsl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761302542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TU+SB4chmKlAHFAsYM8hhOGvRKhnkpvHMT+cCK8DBK0=;
	b=bekDeUsl/OS7JpHPypW311n2LRbbab4F1xChTgpsIiCHBh/KR1L2Zn6scfFWF/7u9TQgiP
	o8MjQULANoWi34s7Xi8EqtypJNqoElKPOIH+hcrcPa3iXZSZeTlAPllMv2iK/JAkQBStc9
	xwBap6OG/8LpROiRMjNbep2dDeTHAoc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-182-dmQMLV8MMymkTOt99hgAMw-1; Fri,
 24 Oct 2025 06:42:19 -0400
X-MC-Unique: dmQMLV8MMymkTOt99hgAMw-1
X-Mimecast-MFC-AGG-ID: dmQMLV8MMymkTOt99hgAMw_1761302538
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D7F1B1809A04;
	Fri, 24 Oct 2025 10:42:17 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.19])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 12A67180057E;
	Fri, 24 Oct 2025 10:42:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 24 Oct 2025 12:40:59 +0200 (CEST)
Date: Fri, 24 Oct 2025 12:40:56 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] printk_legacy_map: use LD_WAIT_CONFIG instead of
 LD_WAIT_SLEEP
Message-ID: <20251024104055.GE771@redhat.com>
References: <20251022154115.GA22400@redhat.com>
 <20251023103234.GA27415@redhat.com>
 <20251023142655.FvZkeSa-@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023142655.FvZkeSa-@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 10/23, Sebastian Andrzej Siewior wrote:
>
> On 2025-10-23 12:32:34 [+0200], Oleg Nesterov wrote:
> > printk_legacy_map is used on !PREEMPT_RT to avoid false positives from
> > CONFIG_PROVE_RAW_LOCK_NESTING about raw_spinlock/spinlock nesting.
>
> Could we please get rid of CONFIG_PROVE_RAW_LOCK_NESTING here? This is
> lockdep internal implementation and has nothing to do with printk or
> anything.

OK, but let me ensure I didn't miss something (again ;).

I mentioned CONFIG_PROVE_RAW_LOCK_NESTING in the changelog because if
CONFIG_PROVE_RAW_LOCK_NESTING=n, then LD_WAIT_CONFIG == LD_WAIT_SPIN
and lockdep will not complain if spinlock_t nests inside raw_spinlock_t.

IOW, without CONFIG_PROVE_RAW_LOCK_NESTING printk_legacy_map is not
really needed.

Right?

Oleg.


