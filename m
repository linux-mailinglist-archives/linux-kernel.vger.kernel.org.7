Return-Path: <linux-kernel+bounces-829821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C98B5B97FAB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 03:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BB0F2E5495
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 01:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1667C1F1306;
	Wed, 24 Sep 2025 01:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="HC6MxHj3"
Received: from r3-17.sinamail.sina.com.cn (r3-17.sinamail.sina.com.cn [202.108.3.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1162B1A23AF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 01:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758676382; cv=none; b=sUXghJa4oxZIp6It7zzNlBrjoAfZlGzZsdaHUecydS3MYTlBGNBC+/qUbYzBkjP6sW8OMGkJ9XddvIwQOq4Eo+huxLvL5rYW8+if4Q6ZZlWiHtsJjd2Od6KY4ipVHoXnEmfRWBshQ8nFLX7+zn9+4doCtSzOvwNFIw/1AjyuFHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758676382; c=relaxed/simple;
	bh=owpdYRV9n2RNq1eyrwaFN6REoctcqQrhga4D0updH9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DAhjjecUhDluFVot4rNkFIkqwD0tG3HKUcANG4DeJGbVtMfz6YmjKBpzKXmbIR4YC5dO2qtqcwaVeIrMpoh4lw4Yr5vvhCqD/Mv5pleCHey+tb64EDfQTBMb9QSNG9F4mUcd9aVo2D3mDu3uY6NKWUMuW4xfh/qCfOsnnsGOL/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=HC6MxHj3; arc=none smtp.client-ip=202.108.3.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1758676377;
	bh=8F3Vev1S7aV8UUtT9qzzcZZdbgYkh5ZuQnEAJO6fFqg=;
	h=From:Subject:Date:Message-ID;
	b=HC6MxHj3UW8NhUCyGF5yw4+OK1uuYc5BCQMPA7x6+7Yfw7Xzl1d38zQJPm+T2+Zbb
	 nZ7eTloG1akwjlhIxXzfan+MbY21PRcwhx1DBcPrtA80z2SUtYmQKHBa1lDecc0Z5O
	 hguArYy2PzbwRSzrebAfu7IQew4ri7dPmFpi+z7M=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 68D3458F000026EA; Wed, 24 Sep 2025 09:12:48 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5722796292116
X-SMAIL-UIID: 3BE03A43A15B4C7999275EDEE5C853FC-20250924-091248-1
From: Hillf Danton <hdanton@sina.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	multikernel@lists.linux.dev
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture support
Date: Wed, 24 Sep 2025 09:12:35 +0800
Message-ID: <20250924011237.7568-1-hdanton@sina.com>
In-Reply-To: <CAM_iQpXMjFs4LmpRVNqxeBnFp4KxEfgi9cB_Jwuy7VgOSqTfsQ@mail.gmail.com>
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com> <20250921014721.7323-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 22 Sep 2025 14:55:41 -0700 Cong Wang wrote:
> On Sat, Sep 20, 2025 at 6:47 PM Hillf Danton <hdanton@sina.com> wrote:
> > On Thu, 18 Sep 2025 15:25:59 -0700 Cong Wang wrote:
> > > This patch series introduces multikernel architecture support, enabling
> > > multiple independent kernel instances to coexist and communicate on a
> > > single physical machine. Each kernel instance can run on dedicated CPU
> > > cores while sharing the underlying hardware resources.
> > >
> > > The multikernel architecture provides several key benefits:
> > > - Improved fault isolation between different workloads
> > > - Enhanced security through kernel-level separation
> > > - Better resource utilization than traditional VM (KVM, Xen etc.)
> > > - Potential zero-down kernel update with KHO (Kernel Hand Over)
> > >
> > Could you illustrate a couple of use cases to help understand your idea?
> 
> Sure, below are a few use cases on my mind:
> 
> 1) With sufficient hardware resources: each kernel gets isolated resources
> with real bare metal performance. This applies to all VM/container use cases
> today, just with pure better performance: no virtualization, no noisy neighbor.
> 
> More importantly, they can co-exist. In theory, you can run a multiernel with
> a VM inside and with a container inside the VM.
> 
If the 6.17 eevdf perfs better than the 6.15 one could, their co-exist wastes
bare metal cpu cycles.

> 2) Active-backup kernel for mission-critical tasks: after the primary kernel
> crashes, a backup kernel in parallel immediately takes over without interrupting
> the user-space task.
> 
> Dual-kernel systems are very common for automotives today.
> 
If 6.17 is more stable than 6.14, running the latter sounds like square skull
in the product environment.

> 3) Getting rid of the OS to reduce the attack surface. We could pack everything
> properly in an initramfs and run it directly without bothering a full
> OS. This is similar to what unikernels or macro VM's do today.
> 
Duno

> 4) Machine learning in the kernel. Machine learning is too specific to
> workloads, for instance, mixing real-time scheduling and non-RT can be challenging for
> ML to tune the CPU scheduler, which is an essential multi-goal learning.
> 
No room for CUDA in kernel I think in 2025.

> 5) Per-application specialized kernel: For example, running a RT kernel
> and non-RT kernel in parallel. Memory footprint can also be reduced by
> reducing the 5-level paging tables when necessary.

If RT makes your product earn more money in fewer weeks, why is eevdf
another option, given RT means no schedule at the first place?

