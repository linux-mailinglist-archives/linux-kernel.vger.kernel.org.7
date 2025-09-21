Return-Path: <linux-kernel+bounces-825956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBE7B8D330
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 03:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6C8217CEB1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 01:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E70015853B;
	Sun, 21 Sep 2025 01:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="hlskYpSf"
Received: from r3-19.sinamail.sina.com.cn (r3-19.sinamail.sina.com.cn [202.108.3.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4BB175A5
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 01:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758419266; cv=none; b=uH/4dbjm/GjGZTBs9abMnHQbQzz7nSBFppw+ptXy9WsyyhkzmiFWAfHdfVusAA+EFTlCdCnpkFcDSWxPGRKm+VB6N7GS1qr0UKli3AkWoXU9pd5os7xLmZCqkCSFLa/sr2jQHfT/XqN74NAaoTb6ZpZikbyB6mBjiGf8aSB+fsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758419266; c=relaxed/simple;
	bh=W1/1lUc/m2HAb6YMrHoo1rlUnLNxczMXhj5+JGxWQVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZW8ll/ZQlMpfuHJlrKk7P7T6CWuibEoc9EnovwqMCThsx5LCy2r+qmc9bDYpFRfgJ3JlXfx96jVbTf6gvct6MKkwB85lzg5dadXeFB+AAr+3qoBOKqohvg1WxBGTil83CROlGz3gF2ZXv6v0AThhT4r+JyLjFqJSOeXJa3Ap++Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=hlskYpSf; arc=none smtp.client-ip=202.108.3.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1758419261;
	bh=jeZHzicfmw3ew6bAKKgtPcL7f278bIXpwpqKyaudnJY=;
	h=From:Subject:Date:Message-ID;
	b=hlskYpSfxVYnpwyKp2ETYvOUxOppWu8LzS8OIKalcL9EqxcDMq0jz2OGBlaMyEmN5
	 7y6y4MlJHM+Hw+rs5NDB7v30fDeG6IGOyoUp+5+B/JCMxgLoI9m+Fz5odDW9lbl6n0
	 ciL0uUCh9RPzj6q+KOpLusJjFraBTr25KCIYaZ1k=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 68CF593300004ADD; Sun, 21 Sep 2025 09:47:32 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8160464456877
X-SMAIL-UIID: 3064C4316E1D4931B3261C34DB6AA6A4-20250921-094732-1
From: Hillf Danton <hdanton@sina.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture support
Date: Sun, 21 Sep 2025 09:47:20 +0800
Message-ID: <20250921014721.7323-1-hdanton@sina.com>
In-Reply-To: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 18 Sep 2025 15:25:59 -0700 Cong Wang wrote:
> This patch series introduces multikernel architecture support, enabling
> multiple independent kernel instances to coexist and communicate on a
> single physical machine. Each kernel instance can run on dedicated CPU
> cores while sharing the underlying hardware resources.
> 
> The multikernel architecture provides several key benefits:
> - Improved fault isolation between different workloads
> - Enhanced security through kernel-level separation
> - Better resource utilization than traditional VM (KVM, Xen etc.)
> - Potential zero-down kernel update with KHO (Kernel Hand Over)
>
Could you illustrate a couple of use cases to help understand your idea?

