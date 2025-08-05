Return-Path: <linux-kernel+bounces-756352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B02C4B1B2FB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 048903A8B7D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DF8251791;
	Tue,  5 Aug 2025 12:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="pVaG+XoW"
Received: from r3-23.sinamail.sina.com.cn (r3-23.sinamail.sina.com.cn [202.108.3.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6681E8836
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 12:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754395228; cv=none; b=q3NlNsT9enygbcZIp/rzDlvuSRuEfzVMa6G7DLOQJBAsUGYMiyBHabtQPFUuslQRMLeb6SkT7UnKUxKHcWQ9/6WtEzJUlRDcty3Rm0Nn4w0XHIlrnAH20CbbrqQ5I8wTe70hzeIBsBUp902jRNhTlvrmxLSmgTxOrULsTgU3SMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754395228; c=relaxed/simple;
	bh=kFfEauye1RJdd7ksADH/nQO/TnuUnyrtM27EwfRMaF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rA7htwJOCUda6toiqnNZTQ0KfBxgGEwUffm62I0IizLQ09hXaGfOb3XNMrWfz+qPqy9XHqdTYfdDVdHAxjsSTV1n4nqV1ZpvIaAtpPqy8/ESPm6VJDalPGSQLqga/8o7/efOnDaQv2dG1as2L1RHQZPYma+rvnmdUsqmO1gRMpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=pVaG+XoW; arc=none smtp.client-ip=202.108.3.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1754395223;
	bh=8xLf7biF5AouiZse7/4e7D5sffThqJBeE04rLUxEIb4=;
	h=From:Subject:Date:Message-ID;
	b=pVaG+XoWv2f+abiIPHqtfMVQgA7OJ68el6ldeDdvK9lx54fJ4IHX9WkAlxrJf4NXt
	 siOEbU6MWstjPM6s3dgGPrnle2+9RH34KGnQoZIotF9HW6aPemVmHDhg2UsJY377uQ
	 A63P3IIQvU9D6Jfc8BQqpw7WpoqhvKgVc8+IFAik=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 6891F24B00003FF0; Tue, 5 Aug 2025 20:00:12 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9361966816215
X-SMAIL-UIID: 944879F75C2849E68EEB7C448AB9AF49-20250805-200012-1
From: Hillf Danton <hdanton@sina.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Ujwal Kundur <ujwal.kundur@gmail.com>,
	axboe@kernel.dk,
	ming.lei@redhat.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+2e9e529ac0b319316453@syzkaller.appspotmail.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH] block: prevent deadlock in del_gendisk()
Date: Tue,  5 Aug 2025 19:59:59 +0800
Message-ID: <20250805120001.3990-1-hdanton@sina.com>
In-Reply-To: <e312219e-aa6c-a9a6-fa01-cf38435010be@huaweicloud.com>
References: <20250803134114.2707-1-ujwal.kundur@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 4 Aug 2025 15:51:48 +0800 Yu Kuai wrote:
> ÔÚ 2025/08/03 21:41, Ujwal Kundur Ð´µÀ:
> > A potential unsafe locking scenario presents itself when
> > mutex_lock(&disk->open_mutex) is called with reader's lock held on
> > update_nr_hwq_lock:
> >         CPU0                    CPU1
> >         ----                    ----
> > rlock(&set->update_nr_hwq_lock)
> >                                 lock(&nbd->config_lock);
> >                                 lock(&set->update_nr_hwq_lock);
> > lock(&disk->open_mutex)
> > 
> This problem is already fixed inside nbd by:
> 8b428f42f3ed ("nbd: fix lockdep deadlock warning")
> 
Deadlock still exists [1].

[1] https://lore.kernel.org/lkml/6891742c.050a0220.7f033.001a.GAE@google.com/

