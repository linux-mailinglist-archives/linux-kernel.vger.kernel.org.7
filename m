Return-Path: <linux-kernel+bounces-854695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD229BDF221
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 478FF3E55E4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540CE2C21E1;
	Wed, 15 Oct 2025 14:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="mLbxQqnF"
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8081626561D
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760539289; cv=none; b=nEOszWTmVPLX9fvPEuI9pUQfzEhN8+eZL0aLyw0HpuPkhQWWdYAH3GfYlQSSIVLeoXyX5rIsDUnqbYyUKONMHUgl34P+3uLarBAdPJCG/zsWm9br3CmVYtn4rfPWa5b7fHlHtdRbbZLKeftfUukLdPOySZLWtr+Wfbcs3oFqhl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760539289; c=relaxed/simple;
	bh=V7VYIRk8OejL6Gv6cGPzS8ATNGeHZvbM/4nyR/l9fF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXtR+AZ9gd1QMi5QhunpBrGz+rX5nIB157Su2JboWukC4jFN0ucMv/30X/g9DseyXujtBj4J17AVyhbuUuXhA14AcqZe52YeKkJzpDHO3YQpRrL7mrY3w7brusWGdb4LvFBmcfNPvBqq0JXvN75xWIxMzXuNYFMZHSV+c36i6oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=mLbxQqnF; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 5D13B932DA;
	Wed, 15 Oct 2025 14:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1760539285;
	bh=V7VYIRk8OejL6Gv6cGPzS8ATNGeHZvbM/4nyR/l9fF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mLbxQqnFpZswwvlTJ7tmK+ovDtpONpdAvG/7fFMnI1+lddxT88wDoJDCft2Fswj7v
	 clfh6xXTpOIKc2mVLbUlCS1PW/hQ05LC0Vke0BQzLgFq5GK/hpMVQ46l1LNCOGXAys
	 Kn2h3D8DNEKe4gpuOyvGY0pPYQ+YbA17M+wHAQsM=
Date: Wed, 15 Oct 2025 14:41:21 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/stats: Optimize /proc/schedstat printing
Message-ID: <aO-ykZkJzLxGsmPC@shell.ilvokhin.com>
References: <aNvu6uDQN7FSr1Gp@shell.ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNvu6uDQN7FSr1Gp@shell.ilvokhin.com>

Hello everyone,

I wanted to follow up on this patch and see if the proposed changes look
reasonable to you. I'd greatly appreciate any feedback you may have, and
thank you in advance for taking the time to review it.

Best regards,
Dmitry

