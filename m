Return-Path: <linux-kernel+bounces-791533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B000B3B822
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 12:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7FA23AE69D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEFE307AE6;
	Fri, 29 Aug 2025 10:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cP9kTF7p"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD3D26FA54
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 10:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756462051; cv=none; b=TX2ojqqXw8pUjJEjlU61v0G7Wx3r1JMrhUXejo6hVZsI3NehREmyhAPC8F16MQzrGP2ui0kId1DgxLuvx+nc4JG6YhEUAE9SQf76+n8ILm3o7BKdegny1yvujestx40SRfQu1I2Q42cXKk/oAQG5YdG4QDht9Naunap1nJMRjDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756462051; c=relaxed/simple;
	bh=v2W9xDCcu+9VlNyLrtKfV/tsRN5JrD4945xE5Fkwo/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYD5+NjPSG/TSa1MbYoMB7ifc0lL3Hu+GEsUC5GhfbSx0FXOIh4ze5/ZDdUzXWL4lNY5OlC+Y5GcoUBFJoVh+wj6t3sToiQe3ha+Gn9jMy/cmNw73Rznaqo1pUoDizyzWTH3OulySKQ7RO+5QaeHJeCAapyYnaXaplyrOohmRDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cP9kTF7p; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B6FB840E016D;
	Fri, 29 Aug 2025 10:07:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id VxiTSg8jUX0m; Fri, 29 Aug 2025 10:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756462043; bh=QEFSrhPp85FXdA0GfLZlIAyIPh84w+8VIwpAxAsS+M4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cP9kTF7peUcA7k/OnrmvhcmI8P7nAhcawbPFwXLyu4RXx6Y408k9YReDkf+q66uOA
	 DY5C0QNjnebb73ABFQk2RgFdZUCJy0zDxDIJfCv/4XG/FnNPZm05I1l2PDJqrrJr24
	 e9ao+QnNCvhD4nIklztwqMesFhMzB4ixZx7jTEQKJd8c16ezjYOB1yQyILO8p/WQEp
	 bu9czzWDihBPcg4HFQ3WgxRQdCGjMzT5wStcvNG7xktorB5BYKyB9w9PlGHpgv5tlH
	 dOOpuZPqIZ8DRls46JObVP93LVVsjcH9679j94PRk03vDBgElgUQxF+kGpUfK6p9QJ
	 vGuzOr72NuAYg+OdjOxCVTsmoMsvbqJmKX6Y2RJz4m64/ZFA6nVkHb42GkwZP2Nmc3
	 6crtR37serySXx4VavvxbSFiJT6eCbs8TrBzV8zepDcuF3iBLZe3NO1CLXQif7qtFo
	 bGTtF1iuNI1aAzIGoB3RX5ZYPoURBvGacFnYUiUuNFAdExHU6UgsIfg8Zc6HOUKO83
	 9LCEz4wO6T4V7Ihty4EkhY5qjCjC2qyuMMpTaNyyTr1Lrmihze5r3o/rmN8IjpGeLY
	 Fv7j2x0H3r/KCtx3HiXPp9CvhEuxQSSyieTlcNtRHeQhcL/XQelz6TTLV3h3+Plsc3
	 buun/NW5SqI4ipbM9xc9Gyqg=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4D2A240E0177;
	Fri, 29 Aug 2025 10:07:11 +0000 (UTC)
Date: Fri, 29 Aug 2025 12:07:05 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc: Waiman Long <llong@redhat.com>, Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>, kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/futex: Fix futex_numa_mpol's memory out of
 range subtest
Message-ID: <20250829100705.GBaLF7ycOvksu9H6KN@fat_crate.local>
References: <20250827154420.1292208-1-andrealmeid@igalia.com>
 <9d4c0d27-0ebd-4c6d-af38-d32ef420fde4@redhat.com>
 <61725722-f933-447c-a041-71b2d28e7f90@igalia.com>
 <20250828182037.qkdKVaTN@linutronix.de>
 <c61e7737-bfc7-4de8-962e-652aa3dbfd40@igalia.com>
 <20250829061624.sC9Bavj9@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250829061624.sC9Bavj9@linutronix.de>

On Fri, Aug 29, 2025 at 08:16:24AM +0200, Sebastian Andrzej Siewior wrote:
> > No objections merging Waiman fix first, but we are still in -rc3, so maybe
> > there's time for the rework in this cycle?

... and you can rework all you want. When your solution is ready and everyone
agrees, there's nothing wrong with queueing it ontop or delaying it for the
next merge window.

> On the regression list, we this one fallout in the testsuite. I would
> like to get an easy fix for -rc4 and be done with it for this cycle. 

There's absolutely no place for hurrying things, especially for self tests. So
take your time pls.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

