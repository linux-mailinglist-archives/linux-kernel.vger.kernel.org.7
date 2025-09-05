Return-Path: <linux-kernel+bounces-803148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8E5B45B4B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7AE25C703A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E3E2F7ACA;
	Fri,  5 Sep 2025 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PRl0gyvY"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB9C2F7AC4
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 14:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757084182; cv=none; b=lUou4nub4uPQ2gmxDbntE1Gu6KcQ5zyB/PLWwYbZrV1oOIy64LzZ1nNrs0lx6vbg31igMF1Nl1TKg/QmY2dWOpgh3dF0TlY/QmdHevCVN3S49TOYh4BFtEoKOewtFfbUWaSiMOONmrXQYAxvIC1FjLDmBoIIIdVIeIf+SyEY5Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757084182; c=relaxed/simple;
	bh=dkBLRD4gj8ciWOVbZDkQbz6/yYdKcNPykgYzvKga97I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nK06RO4bp4IQBqC80yHBc86APBDgUr6AWnDbP8IN6w9XYIA30+BH40h4U2KDD4Lt2mnUqg0FKmZBnR/npWu6Ni1lpJ5w4nNSN72zI1LAVJjkJDJ98hi9xZ3/qGPe4TzQPuYCFrJ+Vm9C65XwIamlrNnzBfL3iZXwPTJgpv2dLps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PRl0gyvY; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 6E58FC8F448;
	Fri,  5 Sep 2025 14:55:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B6FBB6060B;
	Fri,  5 Sep 2025 14:56:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 191B6102F28D6;
	Fri,  5 Sep 2025 16:56:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757084170; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=1jcGlcOV37H7WUoFdZdwjtSdPqibMZqqIq92pDZU1HM=;
	b=PRl0gyvYEeox1nfHU+C5KY3I3MLYo4v5cltyfjofp4ijrZJfuIFWSrbK4ikaKcfxPhst9K
	HJzYMyg6pj1PDPrFgvHsm5NOwO3O5xm3hVaG1gmorCN73D9HQY9vdVB07LqgpoqqLY6XBg
	Ioo9P9AMhWxkI6qKHRFp9n9XmtOX2mxH5CZHDHbeKQP/tbOuEtDuPZAyi4KsleG0gYJXzw
	P+hcRPXaoWCEp0L76zIVqJoz8Me0P2o5XlEwkozqDOvitatv0RQx80P1ZSQqAPMSNzi2Wq
	H3+zn/SQoFdK6jBDiAVQWAhwJ166/eEYho3/LwFB5mWu4Wak43zTVa781ZonBw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: richard@nod.at, vigneshr@ti.com, 
 Wang Zhaolong <wangzhaolong@huaweicloud.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 chengzhihao1@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
In-Reply-To: <20250902092732.2244544-1-wangzhaolong@huaweicloud.com>
References: <20250902092732.2244544-1-wangzhaolong@huaweicloud.com>
Subject: Re: [PATCH V2] mtd: core: skip badblocks increment for blocks
 already known bad
Message-Id: <175708416143.334139.12983911214656984817.b4-ty@bootlin.com>
Date: Fri, 05 Sep 2025 16:56:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

On Tue, 02 Sep 2025 17:27:32 +0800, Wang Zhaolong wrote:
> Repeatedly marking the same eraseblock bad inflates
> mtd->ecc_stats.badblocks because mtd_block_markbad() unconditionally
> increments the counter on success, while some implementations (e.g.
> NAND) return 0 both when the block was already bad and when it has just
> been marked[1].
> 
> Fix by checking if the block is already bad before calling
> ->_block_markbad() when _block_isbad is available. Only skip the counter
> increment when we can confirm the block was already bad. In all other
> cases continue incrementing the counter.
> 
> [...]

Applied to mtd/next, thanks!

[1/1] mtd: core: skip badblocks increment for blocks already known bad
      commit: 1b2dd17dd514b699818afeac1b513651b003ec10

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


