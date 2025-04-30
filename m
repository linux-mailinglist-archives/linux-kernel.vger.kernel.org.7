Return-Path: <linux-kernel+bounces-626204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D1AAA3FEA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 02:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 222627A4E9D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 00:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F4C11187;
	Wed, 30 Apr 2025 00:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LcLTnVww"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4180A921
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 00:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745974726; cv=none; b=lwZk/zibpOeuHKfhcrsrcUSfw4oMqJvAu79t4EXj7AIgNpQhVhi003KvtOtF0kKi/PDGA41jqLrM57YXpoa4qyBWbBDowz8ttho0y0+fy8dN68YCUXJkdJI6R48YOYW3z48AF3cCdK/8mJqG0MhcpNkDNYuad20+3kjw77UBAo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745974726; c=relaxed/simple;
	bh=XYE+lheTdejl+h+X68SEDhsnG9Y41Au8JIlwwtV516A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O42vpRkmfz3m/ZYrbowrv6xhErEX8RTAuU49wtUKnl4y6HsItQ0uV/ZeElZ2AEkfEJImieulTzDL1X0EAW+XORnkyqYC2VyUnWzrZy+vibLCcDl5phaTE2nj4x9vANX8cT7dtsNRZZXNQFX4awfzxVZSjk018RT0vIORglFzwdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LcLTnVww; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 30 Apr 2025 00:58:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745974721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7aYN2EqMpbenGtMK43lQY6ujzZxaQdPs5BavHhf79/8=;
	b=LcLTnVwwI5WKnGjxtzPMeol2A5h1yzHoM4CXh2wDLTDg0+ZTWtexpPF3bISsdzTEpnWV3D
	siXDCZEOTKaJmCciNzhhDY20DKdEkJmpElS9vckNnggO3NtmmnMS/1dbW5WBZXLh0yHDsK
	tBzYtbH2vcgHFmyLoaAXwXuJrtRf1HU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	David Rientjes <rientjes@google.com>, Josh Don <joshdon@google.com>,
	Chuyi Zhou <zhouchuyi@bytedance.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, bpf@vger.kernel.org
Subject: Re: [PATCH rfc 09/12] sched: psi: bpf hook to handle psi events
Message-ID: <aBF1sPtO_UbE1fYo@google.com>
References: <20250428033617.3797686-1-roman.gushchin@linux.dev>
 <20250428033617.3797686-10-roman.gushchin@linux.dev>
 <CAJuCfpEdyZWac7diTUYV7JjkpAPDuy9hwT5sfE2AC2zDVPA9ZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpEdyZWac7diTUYV7JjkpAPDuy9hwT5sfE2AC2zDVPA9ZA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Apr 29, 2025 at 05:28:59PM -0700, Suren Baghdasaryan wrote:
> On Sun, Apr 27, 2025 at 8:37 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> >
> > Introduce a bpf hook to handle psi events. The primary intended
> > purpose of this hook is to declare OOM events based on the reaching
> > a certain memory pressure level, similar to what systemd-oomd and oomd
> > are doing in userspace.
> 
> It's a bit awkward that this requires additional userspace action to
> create PSI triggers. I have almost no experience with BPF, so this
> might be a stupid question, but maybe we could provide a bpf kfunc for
> the BPF handler to register its PSI trigger(s) upon handler
> registration?

It looks like it's doable using struct_ops path: the .init callback
can create psi triggers and "attach" them to the loaded bpf program.
But I need to figure out the details.

Good point, thank you!

