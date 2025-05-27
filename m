Return-Path: <linux-kernel+bounces-663987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF43AC5039
	for <lists+linux-kernel@lfdr.de>; Tue, 27 May 2025 15:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6C493B9BB8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 May 2025 13:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA3A274FD8;
	Tue, 27 May 2025 13:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wEP++0Lo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SAHv6+tz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990A3271468
	for <linux-kernel@vger.kernel.org>; Tue, 27 May 2025 13:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748353876; cv=none; b=PFmtZsv1nrw/8zAPHFR0uBaGiaWLj+dEKKsD3tf33fK5J6ILwnPg4qCxT/5yBZMM9L0nZJqMxah0zXpyaapIXb3O4vZAsMFHmFjUi4ejwolpZ8+8+q/a/2qOgX0L1wpEIdqeEJzg4QdEq50TNKU6nlDKbqtKHdMauHlZDBix58E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748353876; c=relaxed/simple;
	bh=Xjm1UOsIF4B3Ar2Lun4M/5FKyHNeXHHMjLqO5gqdvxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOjgYCGudq/e8+zlgUoy5mtBqOg2GtrEKUd+euqbIdbQW4WNTcwi6zF1g/pp4iOpY8cIJzAd7fnU91qV8n/7BkKu2T7czFitiDCAKiroCu8c18TEY9MICUI1RIOVd/UFHHUJB2+gcEGJWXqYPbKunfl73sA7BjEcXxpOcMyLvr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wEP++0Lo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SAHv6+tz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 27 May 2025 15:51:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1748353872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ds/AnRw/jhbjzyOWkUzO65tFmw9WcAGz+APKGjnNuuk=;
	b=wEP++0LoI9x2DikxJHRC2V4nqusNd0UlMxHe0D8XmTeP5XPp0NTO+wrwDta36RvayRwKHS
	y80pbLZeAcUtYg7lBwTpvHQQZFkr2xA+MLGTdqphu9ygVyRfzF4nttyO6uQNIuKPOCgUy7
	fqxpVw4/FC9tZUYhKzVtf4gPyqlYUL3o4JBqdFryMLLu7LJ4ABGHx1/3pyPL8q4p5pmf4U
	EgrKz8eSLgcvPm0Lpvv51YHnIlVkb351KDsZ66jLhMhHXsRbjY9l4eqfkR+vYz4WJV7x4V
	GKgLRNJcrexaGjMtBEVLXKp+DwzIHP0a+4v7hrcvj3FGUxF6tUIqdPNknQPxlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1748353872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ds/AnRw/jhbjzyOWkUzO65tFmw9WcAGz+APKGjnNuuk=;
	b=SAHv6+tzRb4kodTCP2PWZVPvaUQ+sN11E2V4Vueqn6oQgnS7thkjR2f1LV2Uaytt71j6Ek
	Dcou20PbDW87f/BQ==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>
Subject: Re: [RFC PATCH v2 00/12] rv: Add monitors to validate task switch
Message-ID: <20250527135111.NFCeqkvT@linutronix.de>
References: <20250514084314.57976-1-gmonaco@redhat.com>
 <20250521071544.1adrW9ry@linutronix.de>
 <719b183dbf2dadac8d5359cd68ff4b51769752de.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <719b183dbf2dadac8d5359cd68ff4b51769752de.camel@redhat.com>

On Wed, May 21, 2025 at 09:31:38AM +0200, Gabriele Monaco wrote:
> On Wed, 2025-05-21 at 09:15 +0200, Nam Cao wrote:
> > On Wed, May 14, 2025 at 10:43:02AM +0200, Gabriele Monaco wrote:
> > > I'm keeping this as RFC as I'm planning to make it ready after
> > > merging
> > > the LTL series [1]
> > > 
> > > This series adds three monitors to the sched collection, extends
> > > and
> > > replaces previously existing monitors:
> > 
> > What is your base? I cannot apply the series (maybe because I'm
> > illiterate
> > on git...)
> 
> Mmh, it /was/ linux-next, I'm not sure if that gets rebased and breaks
> stuff, but it shouldn't.

Turned out it was because this series conflicts with ac01fa73f530
("tracepoint: Have tracepoints created with DECLARE_TRACE() have _tp
suffix")

I resolved the conflict while applying, and all is good.

Nam

