Return-Path: <linux-kernel+bounces-828374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E79FB947D5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A6A87A199B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 06:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879F330DEA6;
	Tue, 23 Sep 2025 06:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4e14nSs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF5C266584;
	Tue, 23 Sep 2025 06:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758607435; cv=none; b=FPsUqXGaor5OK9KnBUZDvDjElAnUKtf/CNnguyB4BQL0M1OKBtdzNIJtS9hOAmiiJNknCnIZ+fnDV/QJJYyK0bQJNWnFOoG4tvCBZQNXmjfLtrvmPRe7CVqiHLjo4uXbB4POM5rcUQQfvak2VIAJBj7sbRAV0OwJAPoyKaLo0bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758607435; c=relaxed/simple;
	bh=Akpi3WyvrbZk+0Kn3cw3wKYlEF+zREUQ7cH8FLZet9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndTlZpnyiupVzgwKhUF9i+zi2BiUUeuRGR/lFIihCsCQpTp23h1C5HgDIHavio30vaEXhVjdExMXxRnQL1WqSrFOlqxGXUq3M2havUrkGYWL5xW8N0yWTsXZ6I77JDP3EJ9pGy+sDCzMV04W+4798mGSnZIppaXI8Uqp18TrhMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4e14nSs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C25DC4CEF7;
	Tue, 23 Sep 2025 06:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758607434;
	bh=Akpi3WyvrbZk+0Kn3cw3wKYlEF+zREUQ7cH8FLZet9M=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=C4e14nSsgXMKMJmh2tQoiD0av/KbiujxLDhRy1NQTa1sprOvlL9OFQVdb3LiRg8ei
	 S2F8U3wzlvlVjF4bbmy5k4yunZb1WLtfGG9E9AA/Cvr9wFISZcDOsuzMGwbVIRkD1e
	 sKmUoikiDzaX+14IBU1yBtkZh04O+HguECvzst4IUxE0xd2qFISUljBqKDJbqU1GO4
	 rL9ihOROdwu9ooL+HwU+ovL8gbTo94s7vmaX27fAmL9++dY618HRgacHDEQ6Uc5wtv
	 zF7b+pebUXyyfdyL2OY2oPybfmtG9xXWcJCIjl+9N+tMJlf0E+BRAqxvISWCrIp/2I
	 S2H4Z0LQ1mkRw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 377CCCE1395; Mon, 22 Sep 2025 23:03:52 -0700 (PDT)
Date: Mon, 22 Sep 2025 23:03:52 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: "Li,Rongqing" <lirongqing@baidu.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"lance.yang@linux.dev" <lance.yang@linux.dev>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>,
	"pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>,
	"mingo@kernel.org" <mingo@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"kees@kernel.org" <kees@kernel.org>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"feng.tang@linux.alibaba.com" <feng.tang@linux.alibaba.com>,
	"pauld@redhat.com" <pauld@redhat.com>,
	"joel.granados@kernel.org" <joel.granados@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [????] Re: [PATCH][RFC] hung_task: Support to panic when the
 maximum number of hung task warnings is reached
Message-ID: <36db2f10-ebbe-4ecd-b27f-e02d9e1569c2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250923033740.2696-1-lirongqing@baidu.com>
 <20250922204554.55dd890090b0f56ad10a61f5@linux-foundation.org>
 <f11f4dd1983f4073a8008112e55f92f8@baidu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f11f4dd1983f4073a8008112e55f92f8@baidu.com>

On Tue, Sep 23, 2025 at 04:00:03AM +0000, Li,Rongqing wrote:
> 
> 
> > -----Original Message-----
> > From: Andrew Morton <akpm@linux-foundation.org>
> > Sent: 2025年9月23日 11:46
> > To: Li,Rongqing <lirongqing@baidu.com>
> > Cc: corbet@lwn.net; lance.yang@linux.dev; mhiramat@kernel.org;
> > paulmck@kernel.org; pawan.kumar.gupta@linux.intel.com; mingo@kernel.org;
> > dave.hansen@linux.intel.com; rostedt@goodmis.org; kees@kernel.org;
> > arnd@arndb.de; feng.tang@linux.alibaba.com; pauld@redhat.com;
> > joel.granados@kernel.org; linux-doc@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > Subject: [????] Re: [PATCH][RFC] hung_task: Support to panic when the
> > maximum number of hung task warnings is reached
> > 
> > On Tue, 23 Sep 2025 11:37:40 +0800 lirongqing <lirongqing@baidu.com> wrote:
> > 
> > > Currently the hung task detector can either panic immediately or
> > > continue operation when hung tasks are detected. However, there are
> > > scenarios where we want a more balanced approach:
> > >
> > > - We don't want the system to panic immediately when a few hung tasks
> > >   are detected, as the system may be able to recover
> > > - And we also don't want the system to stall indefinitely with multiple
> > >   hung tasks
> > >
> > > This commit introduces a new mode (value 2) for the hung task panic behavior.
> > > When set to 2, the system will panic only after the maximum number of
> > > hung task warnings (hung_task_warnings) has been reached.
> > >
> > > This provides a middle ground between immediate panic and potentially
> > > infinite stall, allowing for automated vmcore generation after a
> > > reasonable
> > 
> > I assume the same argument applies to the NMI watchdog, to the softlockup
> > detector and to the RCU stall detector?
> 
> True, especial RCU stall detector

There are the panic_on_rcu_stall and max_rcu_stall_to_panic sysctls, which
together allow you to panic after (say) three RCU CPU stall warnings.
Does those do what you need?

							Thanx, Paul

> > A general framework to handle all of these might be better.  But why do it in
> > kernel at all?  What about a userspace detector which parses kernel logs (or
> > new procfs counters) and makes such decisions?
> 
> 
> By leveraging existing kernel mechanisms, implementation in kernel is very simple and reliable, I think
> 
> Thanks
> 
> -Li
> 

