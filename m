Return-Path: <linux-kernel+bounces-878101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F1BC1FC83
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0771A4262F4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3688F1D5ABA;
	Thu, 30 Oct 2025 11:18:46 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6562E54B6
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761823125; cv=none; b=mQrpY6uxrNuDBeB/zBDVatcWbUmb7z2R4H7ejh/MWyELC9CLsuall1UELMZ9nohhjx64rM1C/ur54OGdkNKOBoC1yrySb9TgDpkX9PxQ1wzj18XBFsk+phfvt3EsIUOKKpXZPr4Q/sbnyy+5T2Y2xwgFh922VqIkgKXQrI9G4yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761823125; c=relaxed/simple;
	bh=OAEB18qbfYKeHQqHstm/mBadpNZJ+rz9pWkywS9zNVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rEJ0ArCggSDmDQYjm+Jz6l4NCRuPM5qLcIQh7Yg3K5vXYCQ2EmOtjzoXzrU41XeoAP+dJFbFYPU5vCqL5j9l+7020/hcVCsEvKMi1IiGofY1Jxwme6TpqF5QNBvqmaaDLFlpWdNJL5s8lZwBo1+YYOmrUFCR+484e/0VbTIgDwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 59UBIBwD036845;
	Thu, 30 Oct 2025 20:18:11 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 59UBIAlk036840
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 30 Oct 2025 20:18:10 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <b16d9663-bf2c-41ea-a697-dc94fa2d6c1b@I-love.SAKURA.ne.jp>
Date: Thu, 30 Oct 2025 20:18:07 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add error handling to minix filesystem similar to ext4
To: Jan Kara <jack@suse.cz>, Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>,
        Taotao Chen <chentaotao@didiglobal.com>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        linux-kernel@vger.kernel.org,
        syzbot+4e49728ec1cbaf3b91d2@syzkaller.appspotmail.com
References: <20251028205857.386719-1-jkoolstra@xs4all.nl>
 <su4qka5wugz3asm3sakmptgeeogx6duj6kc7doom5r4fhdwdcv@ogp4lz5gxn7x>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <su4qka5wugz3asm3sakmptgeeogx6duj6kc7doom5r4fhdwdcv@ogp4lz5gxn7x>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav205.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/10/30 19:59, Jan Kara wrote:
> The patch looks ok to me but since minix filesystem driver is in the kernel
> mostly to allow mounting ancient unix filesystems I don't quite understand
> the motivation for adding the new mount options. Why not just fixup
> minix_rmdir() to better handle corrupted filesystems?
I guess that a filesystem which is not needed from boot time can be
implemented in userspace. Can't we migrate legacy filesystems to
fuse-based userspace implementations?


