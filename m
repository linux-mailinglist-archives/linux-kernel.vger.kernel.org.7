Return-Path: <linux-kernel+bounces-831333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AABC6B9C611
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A91217BFAC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 22:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6653189;
	Wed, 24 Sep 2025 22:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="BfvyTssa"
Received: from r3-19.sinamail.sina.com.cn (r3-19.sinamail.sina.com.cn [202.108.3.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A0E126C05
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 22:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758753818; cv=none; b=HDebGFtvVlmhfvIHESM7TgQEnT4uY3UVQ9fpuBDfKnaxP8VbLH7WRpybR6CM7MKbJOppVCyXfjdesRDGf6uvvOv4TSdp80bmIJ5cA471u2niyY8fv5l+u1eVFrwfxCYKYRCjtcYYWACAu0Ke3pkIEg58CUPvLwfYladorpMG7pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758753818; c=relaxed/simple;
	bh=gX91FlV085Zzj03a/JUrWAXzlp60Pblf+JBRa/t0dNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oUW7lIAVd5xcB2MPkdB+yt5A4+sm7JFTSEXCLwcPv9VSFS9KXB613aNskxX99Y3Sj8N112VpqDKVL8GB4xaUs2uJ/IJ4ksx8dPPBloqDbsp1G/89tvxS4k307eitQ+Ej1UGSVPGhukihLTmemfJGok8PP8j3+I8VQd33AoEQ1bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=BfvyTssa; arc=none smtp.client-ip=202.108.3.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1758753814;
	bh=9jzoboa1vOfIqQZDoYIh1fW4a4hloVEmA+RmS4r7Wa4=;
	h=From:Subject:Date:Message-ID;
	b=BfvyTssa3C2AwsHUzqOt88iDRNwbn0DEGhixHKzzp2aWBSepefbiB39J7mP66okYd
	 Ao+N/v0n6xyB+BFgeGy+Qp1qmcN4NMn/jqd5hSJQPNPS/7w0QPjac1UNaL7CmLybIA
	 n5APZce8C3Jhr9TGW/X7kEZ5j9FoTSI2cEW1srTI=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 68D473E8000051CE; Wed, 25 Sep 2025 06:42:50 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4969544456649
X-SMAIL-UIID: 63B27576B27242D597FF52660C38BAB2-20250925-064250-1
From: Hillf Danton <hdanton@sina.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	multikernel@lists.linux.dev
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture support
Date: Thu, 25 Sep 2025 06:42:36 +0800
Message-ID: <20250924224238.7592-1-hdanton@sina.com>
In-Reply-To: <CAM_iQpUwm0wOQx3Epo-5MmkfwZmLsehx6HmABNwzqpRNiPjTmQ@mail.gmail.com>
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com> <20250921014721.7323-1-hdanton@sina.com> <CAM_iQpXMjFs4LmpRVNqxeBnFp4KxEfgi9cB_Jwuy7VgOSqTfsQ@mail.gmail.com> <20250924011237.7568-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 24 Sep 2025 10:30:28 -0700 Cong Wang wrote:
>On Tue, Sep 23, 2025 at 6:12 PM Hillf Danton <hdanton@sina.com> wrote:
>> On Mon, 22 Sep 2025 14:55:41 -0700 Cong Wang wrote:
>> > On Sat, Sep 20, 2025 at 6:47 PM Hillf Danton <hdanton@sina.com> wrote:
>> > > On Thu, 18 Sep 2025 15:25:59 -0700 Cong Wang wrote:
>> > > > This patch series introduces multikernel architecture support, enabling
>> > > > multiple independent kernel instances to coexist and communicate on a
>> > > > single physical machine. Each kernel instance can run on dedicated CPU
>> > > > cores while sharing the underlying hardware resources.
>> > > >
>> > > > The multikernel architecture provides several key benefits:
>> > > > - Improved fault isolation between different workloads
>> > > > - Enhanced security through kernel-level separation
>> > > > - Better resource utilization than traditional VM (KVM, Xen etc.)
>> > > > - Potential zero-down kernel update with KHO (Kernel Hand Over)
>> > > >
>> > > Could you illustrate a couple of use cases to help understand your idea?
>> >
>> > Sure, below are a few use cases on my mind:
>> >
>> > 1) With sufficient hardware resources: each kernel gets isolated resources
>> > with real bare metal performance. This applies to all VM/container use cases
>> > today, just with pure better performance: no virtualization, no noisy neighbor.
>> >
>> > More importantly, they can co-exist. In theory, you can run a multiernel with
>> > a VM inside and with a container inside the VM.
>> >
>> If the 6.17 eevdf perfs better than the 6.15 one could, their co-exist wastes
>> bare metal cpu cycles.
>
> I think we should never eliminate the ability of not using multikernel, users
> should have a choice. Apologize if I didn't make this clear.
> 
If multikernel is one of features the Thompson and Ritchie Unix offered,
all is fine simply because the linux kernel is never the pill expected
to cure all pains particularly in the user space.

> And even if you only want one kernel, you might still want to use
> zero-downtime upgrade via multikernel. ;-)
> 
FYI what I see in Shenzhen 2025 in the car cockpit product environment WRT
multikernel is - hypervisor like QNX supports multi virtual machines
including Android, !Android, linux and !linux, RT and !RT.

Hillf

