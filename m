Return-Path: <linux-kernel+bounces-730974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E481CB04D1F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 02:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85EB51A615DB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 00:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DBA1922C0;
	Tue, 15 Jul 2025 00:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nYjMZUud"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D798154BF5
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 00:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752540564; cv=none; b=dlyb6FeJJgzBzTwIh0dzkhmQr7+tNgpdWeGbZcSFGPO1IyIPdGxLdqaa5tm7+gViTZ/ItTAE/nx8xoTbbIXuU4+CZgk9Cnwz5MOF2Fi6TBJD4gW20LWbmV+eqhnB6mKohsps3sKdZvc35Y3YH8BB8JciqqxxsmFjCFPU1Ead/pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752540564; c=relaxed/simple;
	bh=7fZoM4t02b45CdHMylPH1WlTWzxT3Y0yCfv3k6j5ixk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKye1SnMTwuJFjAleGDsWdK4QAGUhjWyEhpbBTN/o87iEccAdgLjzJ9ILM9qb3Vxk8zHLeZOiL7HW4WyueJdkdRTmrItDG7GZrIw2Cu0SwPz8UYjrVo75iL0vJyEuHQ4AkV9kuJ8Rlz8MS7XwbHd1UAfQGLAEvaFVo1LGL/+gg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nYjMZUud; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752540553; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=naJuq7oTOsCZzbpCQjF1px87CH+eMOjlm5xGHwjWux0=;
	b=nYjMZUud0/sXAf4EmSQJDuZRuz+/1R2VUebWNwQ0PyqiUd4S56MPHjJ5LnCpL0ZCb5tD3+a9ptmuva3+kRiEQ6ka0Q2fa04pMcqFJdGNhhJ64XfMzeYudMqHKI1LVPCldGGJel6hQrR0cZNuM37oUW9Yu07wFxR5NJJZV0vG0qM=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0Wj-0hLl_1752540552 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Jul 2025 08:49:13 +0800
Date: Tue, 15 Jul 2025 08:49:12 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Askar Safin <safinaskar@zohomail.com>
Cc: akpm@linux-foundation.org, corbet@lwn.net, john.ogness@linutronix.de,
	lance.yang@linux.dev, linux-kernel@vger.kernel.org,
	paulmck@kernel.org, pmladek@suse.com, rostedt@goodmis.org
Subject: Re: [PATCH v3 1/5] panic: clean up code for console replay
Message-ID: <aHWliJhyIZnq97Mm@U-2FWC9VHC-2323.local>
References: <20250703021004.42328-2-feng.tang@linux.alibaba.com>
 <20250714210940.12-1-safinaskar@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250714210940.12-1-safinaskar@zohomail.com>

Hi Askar Safin,

On Tue, Jul 15, 2025 at 12:09:40AM +0300, Askar Safin wrote:
> I just tested bit 5. It doesn't replay all console messages (i. e. everything printed to /dev/console ).
> Instead it merely replays kernel messages (i. e. printk/kmsg).
> So, please, rename PANIC_CONSOLE_REPLAY back to PANIC_PRINT_ALL_PRINTK_MSG or possibly to PANIC_KMSG_REPLAY.
> And update admin-guide/sysctl/kernel.rst

Thanks for trying the patch! 

Petr could have better understanding on this, as he have been working
on this for many years and maintained printk.

I brought out the name for kernel space debugging, to replay all the
printk message on the tty console I have. 

My understanding is, 'console' have kind of different meaning in kernel
space than just /dev/console. In printk.c, you can see 'console' is
used everywhere,  which are mostly bound to kernel message.like
console_try_replay_all(), console_flush_all(), console_flush_on_panic(),
which are consistent with the new name suggested by Petr.

Thanks,
Feng

> 
> --
> Askar Safin

