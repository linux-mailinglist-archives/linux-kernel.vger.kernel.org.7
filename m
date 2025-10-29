Return-Path: <linux-kernel+bounces-875819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1ABC19E26
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5A9E1A65846
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430A232A3D8;
	Wed, 29 Oct 2025 10:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqcfmcKF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5C924293C
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761734888; cv=none; b=YwKmxC+y2BYCdytcVQLJCM9Ox6lHMp4bcYiPjoQ0euGudkL8sE3Atow63u8iYHKnIGQ9Kllo+viHBGJECSojfD8UBEpYKBHJ26OG0O4WsxHtCsFmY38/GF5BFDuXZCBQI8fUCpj2OGC9qcHJAKxXmyJS5+Bdz80gjApliWMmFhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761734888; c=relaxed/simple;
	bh=k0xyPnnJykAXBImiZDPRP273138hbAIuyyyIm7R6xac=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FhHdLslvX1Kr/qXpDkZjru8JH5blNW0AmI4HiFm7v3TSisYoOGJKpOH4lWdnnv4UGUBBOWvmf4emr2APzEYa3QRV0v4djgROq/JA/wUKlvUMYG75sw13mXiTb1ggNcJQtmT1WFbFSFa97E30cC3kUuE3Ba0qXVHxFLxuvHr6XJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqcfmcKF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B59C4CEF7;
	Wed, 29 Oct 2025 10:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761734886;
	bh=k0xyPnnJykAXBImiZDPRP273138hbAIuyyyIm7R6xac=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=bqcfmcKFQe+GzaDSYYHETpRQo8NMmKt/GCgw4hb5XGq4+JrTvlk3E3TOx+g5iLXW/
	 1BxBb861dAKu+KRPxeOfNFTZCKARdbnhEGnpBDk5Gf862KVmlSC2AY4Tu0HJpfDrcM
	 k7nUt1GFIi//ILheiSJGNoIxj6MDGp0AeoyYg1OTp2WUIgUW/W45MwVKnKMSOr3LAG
	 bI6XIRkmaAVL8pBWE71+uzleiISXvYXrq82CNsTTcjZ7XLf6MXfIV3lQ/WIeFQ5dlj
	 AwlkAH1X07bCQL9mtvfwf7BBF/Al9Y4ER4m/HtJeSCfFWJkXgFYohkiWO5ebl//ikv
	 Ae4gQGYKeWq1w==
Message-ID: <f2ff436b-d0de-4d68-8374-1c6bf777d6ee@kernel.org>
Date: Wed, 29 Oct 2025 18:48:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, jaegeuk@kernel.org, daehojeong@google.com,
 linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH v1] f2fs: fix uninitialized one_time_gc in
 victim_sel_policy
To: Xiaole He <hexiaole1994@126.com>, linux-f2fs-devel@lists.sourceforge.net
References: <20251029051807.3804-1-hexiaole1994@126.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251029051807.3804-1-hexiaole1994@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/25 13:18, Xiaole He wrote:
> The one_time_gc field in struct victim_sel_policy is conditionally
> initialized but unconditionally read, leading to undefined behavior
> that triggers UBSAN warnings.
> 
> In f2fs_get_victim() at fs/f2fs/gc.c:774, the victim_sel_policy
> structure is declared without initialization:
> 
>     struct victim_sel_policy p;
> 
> The field p.one_time_gc is only assigned when the 'one_time' parameter
> is true (line 789):
> 
>     if (one_time) {
>         p.one_time_gc = one_time;
>         ...
>     }
> 
> However, this field is unconditionally read in subsequent get_gc_cost()
> at line 395:
> 
>     if (p->one_time_gc && (valid_thresh_ratio < 100) && ...)
> 
> When one_time is false, p.one_time_gc contains uninitialized stack
> memory. Hence p.one_time_gc is an invalid bool value.
> 
> UBSAN detects this invalid bool value:
> 
>     UBSAN: invalid-load in fs/f2fs/gc.c:395:7
>     load of value 77 is not a valid value for type '_Bool'
>     CPU: 3 UID: 0 PID: 1297 Comm: f2fs_gc-252:16 Not tainted 6.18.0-rc3
>     #5 PREEMPT(voluntary)
>     Hardware name: OpenStack Foundation OpenStack Nova,
>     BIOS 1.13.0-1ubuntu1.1 04/01/2014
>     Call Trace:
>      <TASK>
>      dump_stack_lvl+0x70/0x90
>      dump_stack+0x14/0x20
>      __ubsan_handle_load_invalid_value+0xb3/0xf0
>      ? dl_server_update+0x2e/0x40
>      ? update_curr+0x147/0x170
>      f2fs_get_victim.cold+0x66/0x134 [f2fs]
>      ? sched_balance_newidle+0x2ca/0x470
>      ? finish_task_switch.isra.0+0x8d/0x2a0
>      f2fs_gc+0x2ba/0x8e0 [f2fs]
>      ? _raw_spin_unlock_irqrestore+0x12/0x40
>      ? __timer_delete_sync+0x80/0xe0
>      ? timer_delete_sync+0x14/0x20
>      ? schedule_timeout+0x82/0x100
>      gc_thread_func+0x38b/0x860 [f2fs]
>      ? gc_thread_func+0x38b/0x860 [f2fs]
>      ? __pfx_autoremove_wake_function+0x10/0x10
>      kthread+0x10b/0x220
>      ? __pfx_gc_thread_func+0x10/0x10 [f2fs]
>      ? _raw_spin_unlock_irq+0x12/0x40
>      ? __pfx_kthread+0x10/0x10
>      ret_from_fork+0x11a/0x160
>      ? __pfx_kthread+0x10/0x10
>      ret_from_fork_asm+0x1a/0x30
>      </TASK>
> 
> This issue is reliably reproducible with the following steps on a
> 100GB SSD /dev/vdb:
> 
>     mkfs.f2fs -f /dev/vdb
>     mount /dev/vdb /mnt/f2fs_test
>     fio --name=gc --directory=/mnt/f2fs_test --rw=randwrite \
>         --bs=4k --size=8G --numjobs=12 --fsync=4 --runtime=10 \
>         --time_based
>     echo 1 > /sys/fs/f2fs/vdb/gc_urgent
> 
> The uninitialized value causes incorrect GC victim selection, leading
> to unpredictable garbage collection behavior.
> 
> Fix by zero-initializing the entire victim_sel_policy structure to
> ensure all fields have defined values.
> 
> Fixes: e791d00bd06c ("f2fs: add valid block ratio not to do excessive GC for one time GC")
> Cc: stable@kernel.org
> Signed-off-by: Xiaole He <hexiaole1994@126.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


