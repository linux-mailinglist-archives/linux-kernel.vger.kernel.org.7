Return-Path: <linux-kernel+bounces-818429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9599B591A3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33E5C3212B8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D2328C2BF;
	Tue, 16 Sep 2025 09:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wqW07NSA"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D11F10E9
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758013327; cv=none; b=mMH+6zG8KM5tYPAnqTmM9TdMdmUxrW77WbYi+8/dnSP1zL7tsezjei8+teGVDGYhz1J0YAodg+SpJtDEJh3FrAhqQfXgUQ61mqSoy0Qa8G/kX94UEiBlkCAEuYVJvjj6qMtq5QnwLwcOe664NQ1WheVROfCcV46JZtH1LE5wvu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758013327; c=relaxed/simple;
	bh=ydOvMSYGLBPG/Sw3HqmtS98YZtsA/FvEeL+izFPO4Ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gd7s9K8OSX+lLXRlJ0mxT/U8nhODP3IjI4riDeDTrSpQbCIpswkca5JCwZeLBwdlw5Z2+dzdZV43e+li8C0MYeqrpdh1Ndqe6hGctoC1YcjEP/ZTEWxG1eJ0LZ0AJPHNEW2XXxB4/tF5wEn1U4IIAdivXJ9En8UzjAVULdT9UHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wqW07NSA; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758013316; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ydOvMSYGLBPG/Sw3HqmtS98YZtsA/FvEeL+izFPO4Ak=;
	b=wqW07NSAj6vDCd4CDOeNA9+zbfwh3Uf1OhSLi7ui2G07R5hCRNYsNrARs9NR2dRan/1V7Ir6gUUXoG2HWmBTpOf/YEo8MtDLaQNKbsAH8NtMY02nWn6zf14zlA6AbPmX9fmoybMiFN881yqI8uj/zuQtCYl9DeklAEFHUa3YsE4=
Received: from 30.221.130.218(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wo851Ss_1758013315 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 16 Sep 2025 17:01:55 +0800
Message-ID: <e0650e39-f555-4fe3-8c80-cddc6414a449@linux.alibaba.com>
Date: Tue, 16 Sep 2025 17:01:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [erofs?] INFO: task hung in erofs_bread
To: syzbot <syzbot+1a9af3ef3c84c5e14dcc@syzkaller.appspotmail.com>,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <68c8583d.050a0220.2ff435.03a3.GAE@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <68c8583d.050a0220.2ff435.03a3.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test

