Return-Path: <linux-kernel+bounces-776219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CEEB2CA2F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1D477B0B32
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53542C235B;
	Tue, 19 Aug 2025 16:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="KsqoxlUY";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="oiJPzeNU"
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B641283FFB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 16:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755622681; cv=none; b=GQxzop9japNEbfZjl15gQ1XVV53x0/65qzeXMB5gNhHkLeNj6nLf2NqThFsgX+Qf3ubBYB364+Dpnv51Qv0tTgLKZsCK/rJutHS+/z0MIxSpmsGfudiH/KqoH4nwp/gngDuz3ZYAHsCgNb2tgI9B1BR5m6XxfF8CF5k7vOrlXDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755622681; c=relaxed/simple;
	bh=rmfmQ8q5Dr0B3yYy5s7uCTj4iD3pS9+IoJk9Xs6pL6M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RA8Yhv7mvORDFs5lqURVh+xQDIpT9zk/ey0B31z3iXmxaccIn40CJD2SJ7ETRofKOADsHRoRIFpyolBcffTY0QwUwVEZGjIY68N5OhgNHMIW0abH70XpuLC7HT1NXEYzDPKrlu/fa2RVp0qosLkMcK3abBGHhWioK6Li5LPl48o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=KsqoxlUY; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=oiJPzeNU; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 4E81F209679B;
	Wed, 20 Aug 2025 01:57:56 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1755622676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+MW5KjHfFhl8y5Pnin0bowUL7HRF6u/NjDuZsrZChmY=;
	b=KsqoxlUYDjPJsIeJYwmu6Hr81SWv2YMt/oLDQ8pKbDohakDmREPtdN/V3nUy3V25JuTzYf
	Lw1glOHtCcAky5cllAW5Vt938nwftNPdboO21jMx88cYxIyA8JHWvG1nQcME1jImcRqxkT
	ADjoPuaTbqtyoRyaKJCQsQU+ZQK+XM1RfgWsJeESoRKUE+eZMF1d4la0hHTQxOp9gP5PKB
	9epIl7yn40+LuHeuuMam+hSoWVGWQJxy+NtRauf/8laJ4pXZ88AU/EFOtPZOH1SjT0hepM
	H2zjW9D8TQ3Js9bSUg2cu0NucAsIJ5dc2CWAB75fBAzOUDsDDmtHYlb+fM8lVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1755622676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+MW5KjHfFhl8y5Pnin0bowUL7HRF6u/NjDuZsrZChmY=;
	b=oiJPzeNUDzD38GNAGhiad5KRG5/ZQwFAjbaOrovbUuSGuXSkdMlSWPIZ7ISiiF6Q5sTqtb
	IGXqorPUDJ6wVQDg==
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-7) with ESMTPS id 57JGvtJA032827
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 01:57:56 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-7) with ESMTPS id 57JGvtxk007412
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 01:57:55 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 57JGvs3R007411;
	Wed, 20 Aug 2025 01:57:54 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: zhoumin <teczm@foxmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfat: fix uninitialized i_pos error
In-Reply-To: <tencent_93CE617328A1683191A7418BCCE87AFE500A@qq.com>
References: <87o6sbz5kd.fsf@mail.parknet.co.jp>
	<tencent_93CE617328A1683191A7418BCCE87AFE500A@qq.com>
Date: Wed, 20 Aug 2025 01:57:54 +0900
Message-ID: <87jz2zz1t9.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

zhoumin <teczm@foxmail.com> writes:

>>> The i_pos field remains uninitialized when fat_fs_error_ratelimit() reports
>>> error, e.g.,
>>>
>>> 	[ 1642.703550] FAT-fs (loop0): error, fat_get_cluster: invalid
>>> 	cluster chain (i_pos 0)
>>>
>>> Since i_pos is assigned in fat_attach after fat_fill_inode, the error
>>> message lacks useful debug info.
>>>
>>> Path:
>>> vfat_lookup
>>> 	fat_build_inode
>>> 		fat_fill_inode
>>> 			fat_calc_dir_size
>>>           			fat_get_cluster /* report error */
>>>       	fat_attach  /* i_pos assigned here */
> 
>> No. It is initialized as 0, and it must be unavailable outside
>> between fat_attach and fat_detach.
> 
> I see that it was initialized to 0. What I meant is that when
> fat_fs_error_ratelimit uses i_pos for debugging output, it doesn't get the
> correct value.

Not big issue. IOW, 0 is still a valid state.

>> IOW, this is introducing the race.
> I'm not quite clear about the race condition you mentioned here. Could you
> give an example to explain it?
> 
> Actually, the modification I initially considered was as follows. I'm not
> sure if this approach carries any risks. If it's acceptable, I'm ready to
> submit a new version.

When you try to change logic, you should read and understand the current
logic before.

For example, fat_iget() and __fat_write_inode() have to grab only valid
and live inode. And the orphaned inode must not be written back to disk,
because same entry can be reused already.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

