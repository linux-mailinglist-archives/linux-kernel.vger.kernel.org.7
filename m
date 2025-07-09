Return-Path: <linux-kernel+bounces-722714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BED6AFDE17
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 05:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD2F55682E8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 03:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DB01F55F8;
	Wed,  9 Jul 2025 03:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KPUlI0u5"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C57E1DF970
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 03:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752031642; cv=none; b=ZqalaZlXbNXjBZJuP7XFSKlXa2UvGW45t+kPu2G04GFkGkglp1oRRR6N38E8ioS53jgJlypc7/mqLONN2t8sCF6K7U9k3/mv4WkmM8AvClwpDBFLe9rIR2XIDu2zKj8wzB9w14tW4FiNjjQkLE/KjqBDX401NNszSBhpZ0wqhhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752031642; c=relaxed/simple;
	bh=6b9Ey+t3Z409SM8UNbNeG8Oac3l11WQ8QOzdmoG8QTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=baTY5FeqJ13ytY29qTeJ2vuiJJbOfnm7rOM6rHpAn9lqD8MIy4oV/i4GTA+JRKR/7kk0993TrdtkBAJh4W6wjzENb/9QD+2dmvNl3X29e4nzJrP/s/ryR+xZHkhmfkWleCURfvfZXaRiPGpV+O5Y99yNokj4rqP0ztyrqN14pDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KPUlI0u5; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752031630; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=zXBLnMS5RETQ23u5rVHHtnY4TUYUS4WhWz9n1i8t/mc=;
	b=KPUlI0u5BqvpePP4fwkXZsieLYzUKgrGSLXF8EGzBP+z3E7pocKLf59rc3GHd7IDaOIq4/t1XJXNH2Nj4AWmO38o+nGRMgFqKxdWxlfUrqIHuVqe4rT2dnDgsfHWSXthQ799/DJEBzbt/aZewDhjcM405zRasgpKfwm69+Se0Ak=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WiVtxX-_1752031629 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 09 Jul 2025 11:27:09 +0800
Date: Wed, 9 Jul 2025 11:27:08 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 3/5] panic: add 'panic_sys_info' sysctl to take human
 readable string parameter
Message-ID: <aG3hjKg81xrDHjZc@U-2FWC9VHC-2323.local>
References: <ndckw7vr5zxiz2olstjaxxk4a6qgrnbo65rex4242u3swnvvhm@whxmilgtgoyd>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ndckw7vr5zxiz2olstjaxxk4a6qgrnbo65rex4242u3swnvvhm@whxmilgtgoyd>

Hi Sergey,

On Wed, Jul 09, 2025 at 11:29:37AM +0900, Sergey Senozhatsky wrote:
> Hi,
> 
> [..]
> >+#ifdef CONFIG_SYSCTL
> > +
> > +static const char sys_info_avail[] = "tasks,mem,timers,locks,ftrace,all_bt,blocked_tasks";
> > +
> > +int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
> > +                                         void *buffer, size_t *lenp,
> > +                                         loff_t *ppos)
> > +{
> > +       char names[sizeof(sys_info_avail) + 1];
> > +       struct ctl_table table;
> > +       unsigned long *si_bits_global;
> > +
> > +       si_bits_global = ro_table->data;
> [..]
> 
> Somehow this breaks the build with:
> 
> lib/sys_info.c:52:19: error: variable 'sys_info_avail' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]
>    52 | static const char sys_info_avail[] = "tasks,mem,timers,locks,ftrace,all_bt,blocked_tasks";
>       |                   ^~~~~~~~~~~~~~
> 
> Moving sys_info_avail[] inside sysctl_sys_info_handler() seems to help.

Sorry for the trouble. I assume this is clang?  I locally used gcc v10.2.1

Nathan Chancellor has helped to post a fix here https://lore.kernel.org/lkml/20250708-fix-clang-sys_info_avail-warning-v1-1-60d239eacd64@kernel.org/

Thanks,
Feng



