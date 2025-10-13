Return-Path: <linux-kernel+bounces-851150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D8526BD5A90
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 40781350EA3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6FF2D238A;
	Mon, 13 Oct 2025 18:12:16 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A39F2459D4
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760379135; cv=none; b=AGMjvrv7hoPNTM92VNSj3bThgIenSsRuuT7ivEn//D2mcBMTpnAEaXllMddgLM5RBQbGuYRcxgjYDc21CoXA0DMnFU2Gcwqjwtnw6Zo/IFqsn+37TJMGGRzH+vStpjXq0yXuUeBFI6yg3uYQQd0Z703bk8dZVaHTe7lf+P8yBX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760379135; c=relaxed/simple;
	bh=gGrRo9gTBbpk9aISf1z9a9GPMtCKGbi1MdkO0Ti4TnY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YUHO2/SZhBS1MzVV5aX1QUrkhee83MMUFW+J6Hf1FVs9LhmHvLGmax8tnr4WMh+Y+cW6P61wEJwJfXvjOBC+Dz9Do32FtP1tIoS8KKSX0qlA/Pd0YS1SVPB7fvZ4urYY4nr765gIppfMKmVHFSySuM1t/C8CeAXxgUeM02B77Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 63FA31A052D;
	Mon, 13 Oct 2025 18:12:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 885D860011;
	Mon, 13 Oct 2025 18:12:02 +0000 (UTC)
Date: Mon, 13 Oct 2025 14:12:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "CruzZhao" <cruzzhao@linux.alibaba.com>
Cc: "mingo" <mingo@redhat.com>, "peterz" <peterz@infradead.org>,
 "juri.lelli" <juri.lelli@redhat.com>, "vincent.guittot"
 <vincent.guittot@linaro.org>, "dietmar.eggemann"
 <dietmar.eggemann@arm.com>, "bsegall" <bsegall@google.com>, "mgorman"
 <mgorman@suse.de>, "vschneid" <vschneid@redhat.com>, "catalin.marinas"
 <catalin.marinas@arm.com>, "will" <will@kernel.org>, "linux-kernel"
 <linux-kernel@vger.kernel.org>, "linux-arm-kernel"
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: [BUG] Kernel panic in update_cfs_rq_h_load() on aarch64
Message-ID: <20251013141206.0cf358a3@gandalf.local.home>
In-Reply-To: <1dbc8668-4607-45ae-a286-77def1037917.cruzzhao@linux.alibaba.com>
References: <1dbc8668-4607-45ae-a286-77def1037917.cruzzhao@linux.alibaba.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 885D860011
X-Stat-Signature: o8qbnjsogk4pfznskb7sdwi6eza4f7s3
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18a7obeNimm9thiVngEeXwfURZ9kY/r/2o=
X-HE-Tag: 1760379122-398151
X-HE-Meta: U2FsdGVkX1+b5IfbFdRBPPhBFpJF9rnTkKFgqRtXsuZKeXWrPK+qkjk8MIiV6cZZom1mu1Tx5qb79Z0D/5SyvBqmfcYY5Pvnt/5+/CsSIpRPhm3NMjZzXWXZarIZ9vZgcg5q+EZxLk2BAUDqW2ZcdSavvzHNMB2XSuYHbg6Cw6gd4OzNbKT3Hwh4aa734H7HLIVxPNIy26sVZuHfJQUjS6tEdGGLkV8JTP39ygCtnS5MbgXuL602jLVzIQW2JAUQjW1rmpz15Lvzbggye8/Afkg1yhvu3ftCaKq7hpckrGLwtTpY8B5oeYPWni+8jajylDzR3l3rOE8QfwzpaFj7jJ+H0wM6dbhy

On Mon, 13 Oct 2025 11:37:59 +0800
"CruzZhao" <cruzzhao@linux.alibaba.com> wrote:

> Hi, all. We are encountering a kernel panic in our production environment running Linux kernel version 5.10.134, on aarch64 architecture (aarch64 architecture only).
> ### Summary:
> - **Kernel Version**: [5.10.134]

That's an ancient kernel. Why are you sending this to upstream?

Please test 6.17.

-- Steve

> - **Architecture**: [aarch64]
> - **Problem Type**: panic
> - **Reproducibility**: About 40 times per week
> This issue leads to system-wide unresponsiveness and requires a hard reboot. We have collected the panic logs and backtraces, which I will include below for your reference. We tried to analyze the vmcore but have not found out the root cause.
> ---

