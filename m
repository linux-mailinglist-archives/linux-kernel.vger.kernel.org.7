Return-Path: <linux-kernel+bounces-731010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CC9B04D79
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 03:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72DBC4A6575
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 01:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CCE1C1F0D;
	Tue, 15 Jul 2025 01:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CK8exIdF"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15C585260
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 01:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752543293; cv=none; b=afuPRS2SkMLcTUvTJ4aPeyYnM6rZfftoVr3ZhnS0HsN3Z/UkdDA0zfqqwZd2007htWpAhn4zzGWaHM/R+XWqH1TNhPBYELP+xQ8+8vCQii/KHGnhFGKTLDtszpyb4KJzBUhCirB6yeJ5B9lZtG5lDHWG7Mh0Zec2OA+1dylPZIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752543293; c=relaxed/simple;
	bh=hEjrIJCzbSynNZpMBOUdAjcUejwKVrefW8m0+Lo4J80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vydp8UEo+w/7qWflz+JiT+7lCDZT6qoi5LDDPCJiziOA+a2UrSw+2nhTX92vBu/q60mOs0xptyKDrP8XFCPOvN78t9lltaNXheHOLNxqAbsJnGcfSr4N/JA7KvyYt6l4IWBvGj9MnLovzkxTZa0sKXhEW4J7rW7UQhLkBR00o6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CK8exIdF; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752543281; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=nSGjrdZGOigXh7Te4xTEC+YR6s7zavKIs5oQcXGxMFE=;
	b=CK8exIdFLqBXTVtxk7AuPRog59yI1EhtBozuj2yZ1WoTl5G7NLihSFr9O455THAwPupDGL5a13ZChRyd/eCXoBPfbOQBuqml8x5dyyU50fl7O+u+OcqT4JyOyWx8w26JWPzEkfyOpDWFYTEUlGdf6I0BdGw+AbWBFwcI8+Ai52U=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0Wj-Jyxg_1752543280 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Jul 2025 09:34:41 +0800
Date: Tue, 15 Jul 2025 09:34:39 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Askar Safin <safinaskar@zohomail.com>
Cc: akpm <akpm@linux-foundation.org>, corbet <corbet@lwn.net>,
	"john.ogness" <john.ogness@linutronix.de>,
	"lance.yang" <lance.yang@linux.dev>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	paulmck <paulmck@kernel.org>, pmladek <pmladek@suse.com>,
	rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 1/5] panic: clean up code for console replay
Message-ID: <aHWwL7TdabnGna3D@U-2FWC9VHC-2323.local>
References: <20250703021004.42328-2-feng.tang@linux.alibaba.com>
 <20250714210940.12-1-safinaskar@zohomail.com>
 <aHWliJhyIZnq97Mm@U-2FWC9VHC-2323.local>
 <1980ba9224c.11f5e5a9635585.8635674808464045994@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1980ba9224c.11f5e5a9635585.8635674808464045994@zohomail.com>

On Tue, Jul 15, 2025 at 05:18:10AM +0400, Askar Safin wrote:
>  ---- On Tue, 15 Jul 2025 04:49:12 +0400  Feng Tang <feng.tang@linux.alibaba.com> wrote --- 
>  > Thanks for trying the patch! 
> I didn't try it. :) I merely run normal mainline or distro kernel in qemu.
> 
>  > My understanding is, 'console' have kind of different meaning in kernel
>  > space than just /dev/console. In printk.c, you can see 'console' is
>  > used everywhere,  which are mostly bound to kernel message.like
>  > console_try_replay_all(), console_flush_all(), console_flush_on_panic(),
>  > which are consistent with the new name suggested by Petr.
> Okay, I agree.
> 
> But I still kindly ask you to revert changes to Documentation/admin-guide/kernel-parameters.txt .
> Previous documentation is better.
> admin-guide is written for admins, not for kernel developers. And they understand "console" as /dev/console .
> 
> I run kernel with panic_print=32 in hope that this will flush console (i. e. /dev/console), because this is how I interpreted
> your patched documentation. And I got different effect.

I see. How about changing the patch to: 

-			bit 5: print all printk messages in buffer
+			bit 5: replay all kernel messages on consoles at the end of panic

Thanks,
Feng

> 
> --
> Askar Safin
> https://types.pl/@safinaskar

