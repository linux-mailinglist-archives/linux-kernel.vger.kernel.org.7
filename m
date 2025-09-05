Return-Path: <linux-kernel+bounces-803393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B950AB45E8B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 525DB1C83643
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD8630B528;
	Fri,  5 Sep 2025 16:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="PqUI1bfD"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07CB306B2B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 16:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757090750; cv=none; b=NTwlY2zJlM/lA19VqIYiOyMpEY/h+89iydDwJmzTIf7g8y0RRNe/EiWl9Ro+bbKNP2gEyZbhS+ICIUgN/FYwmQEx/jk6akojzw4sw/Kv4hV0Gtv+GDEbMOeCVzZVeb+ED6spgR1isph9zN7z06mAz+kRLLFrtLoalj0pO/kvrpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757090750; c=relaxed/simple;
	bh=sQ9gYJ4JANBJHHgEBCkXB60tdqWDx2vvMF5HyduuN9Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BCUEbFl3gfVj2axxn/fxwp98wiFhiT+cbpkC9fKbiOtgDHR6EPmE/jn/u2pvrlZT7MBjEAzhWgM4JF0CZw8kLASvSciqfrh+rJlhptsUOWwrz+Df8/97Ygrt6mhrQYt+Oo7LMl69mEEKcsdUNnTra8hUIvQ33/wMXSBvcnuewYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=PqUI1bfD; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1757090742;
	bh=sQ9gYJ4JANBJHHgEBCkXB60tdqWDx2vvMF5HyduuN9Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=PqUI1bfDVn1yd0don4CGfaDcPXwFMEXPN13UK5oxDLLoC7J+h4+93CRWcRH+wm6yF
	 3mGt0fw65BmGp7sHfbttx8/jcorIh6XPMr9V/xhX1qRtAbcTQO3VxzCUmtMA2CMLQg
	 QCWiB7Ib9/PXrw9OsMhEbwgb49tSrmyP7aplwzpo=
Received: by gentwo.org (Postfix, from userid 1003)
	id 929914028B; Fri,  5 Sep 2025 09:45:42 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 911EE400C8;
	Fri,  5 Sep 2025 09:45:42 -0700 (PDT)
Date: Fri, 5 Sep 2025 09:45:42 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Frederic Weisbecker <frederic@kernel.org>
cc: Valentin Schneider <vschneid@redhat.com>, 
    Adam Li <adamli@os.amperecomputing.com>, mingo@redhat.com, 
    peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
    dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
    mgorman@suse.de, linux-kernel@vger.kernel.org, patches@amperecomputing.com
Subject: Re: [PATCH] sched/nohz: Fix NOHZ imbalance by adding options for
 ILB CPU
In-Reply-To: <aLrUgpOshn5mg6sL@localhost.localdomain>
Message-ID: <218b07e0-1cf7-fa8d-4533-d0e8572b3356@gentwo.org>
References: <20250819025720.14794-1-adamli@os.amperecomputing.com> <xhsmhtt23h0nw.mognet@vschneid-thinkpadt14sgen2i.remote.csb> <7438bb3a-96d6-485a-9ecc-63829db74b39@os.amperecomputing.com> <xhsmho6sagz7p.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <f6869880-1f7c-a39b-dc8e-4c3a84ba51ef@gentwo.org> <aLmaJEU-WwVmVdYI@localhost.localdomain> <9c8a2b87-5062-08a6-5a27-f53d986b1be2@gentwo.org> <aLm6q5-4bZ78cM5P@localhost.localdomain> <a968dba3-0acb-f175-fb73-aa384a2745a9@gentwo.org>
 <aLrUgpOshn5mg6sL@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 5 Sep 2025, Frederic Weisbecker wrote:

> > My wish for the future would be that nohz_full would be the default and
> > that the scheduler does correct load balancing regardless of the cpu being
> > in tick mode or not.
>
> Provided we ever manage to run nohz_full without tradeoffs (offloaded 1Hz tick,
> RCU user/kernel overhead, cputime accounting overhead, use hrtick when
> preemption must be maintained) then yes it would make sense but we are very
> far from that. I'm not even sure this will ever be possible.

We need a genius to have a bright idea on how to handle these tradeoffs to
avoid manual configurations.


