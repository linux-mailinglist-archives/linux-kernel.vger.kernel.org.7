Return-Path: <linux-kernel+bounces-742669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D499B0F521
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 16:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C4427AEFBF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122752EBDE0;
	Wed, 23 Jul 2025 14:22:53 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACB42E5415
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 14:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753280572; cv=none; b=f1qnwUvWG9EobOo85C7iwqy3R5ee7p2d5FT41+XM6M5rf3sKcZUPSaUVoJKk4h8zj7gZmp3z6m4p9HwEIi9CL18po3csr/yjtG1+WUpK7IGSZuncwaMiQMqmQdejLs+uAlLAWZGhcFgH5w+KvrmXPvTadeZt9ZDFtHAcl035ef0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753280572; c=relaxed/simple;
	bh=VrQ6bCUXf7qU+LdSRfvEhWSEonk7Kvo1rpyBqHfvezQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TbrNcoE7IgK9iioxo8L6Bkeyh3bG04g3TIaX8REUy4iCa9TCVihTMbp3b/OmABoWhy/9+6aJhASXHWMvPUTSlYjgpfvGhL3VpEoWCjA5i6Yi/3o5wV54NoxgyG6XTcq+lfsYaAOf3MspeoFInYRU6N4e6ZOZi8qXC7r6b+foNVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 772CEBAD60;
	Wed, 23 Jul 2025 14:22:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 3E9A480011;
	Wed, 23 Jul 2025 14:22:46 +0000 (UTC)
Date: Wed, 23 Jul 2025 10:22:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Nam Cao <namcao@linutronix.de>, Tomas
 Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark Williams
 <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v4 00/14] rv: Add monitors to validate task switch
Message-ID: <20250723102245.75631501@batman.local.home>
In-Reply-To: <374df509738db8314aa45971ba8b5469fa4e673e.camel@redhat.com>
References: <20250721082325.71554-1-gmonaco@redhat.com>
	<20250722205047.621efa7e@gandalf.local.home>
	<374df509738db8314aa45971ba8b5469fa4e673e.camel@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: f57doe1apw9dqk3bhdrntk8okwjbwyqb
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 3E9A480011
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX182jORDrkAEZC28WiUNytXNXFi8Rmy1THY=
X-HE-Tag: 1753280566-380829
X-HE-Meta: U2FsdGVkX1+hvXNO4qMmG0yFhgT3nBQyKo+5GyN/2Ib1fVeGdvykXO6T98nYOT1wdzmdd8aY+zIo2AW7zoUd9uMb+d4TMlZTBMTnbsXzGP4XCCRCuvutWvPoOtvG5u0J4MX/jMqp6+vw6A0WHCh1H5X+OH/SPT1LZFsO99Llm9JIslBQGUYvZlDfz/Gm529y6qcn8SVMNDZfnADaYvMg379mDDSbvnKolmMZUXLwwikC/fP4BuWS8V1pxxMS1V2pHE8WyPO1x8wXRAzHZmXH9Z+7OKHs67xVk0LHeoLwf3M50qbOkPUi6LKA+ysJQpA8RD9EEj4VGbQqhAqpl5YksKL+6Ua/XxfS

On Wed, 23 Jul 2025 11:55:50 +0200
Gabriele Monaco <gmonaco@redhat.com> wrote:

> The rationale is that tools files changed in the kernel patches are not
> really tool stuff (dot models). And kernel stuff changed in the tools
> are something that the tools generate, and to test them a build should
> suffice (kernel robot would do that). Having them together eases
> testing the tool, I believe.

Yes, I agree with the above.

If you make kernel changes that a new dot file is going to use, then
sure, keep that in the kernel side.

I'm basically saying that any tools enhancements beyond adding new
models and such should be in their own series.

Thanks,

-- Steve

