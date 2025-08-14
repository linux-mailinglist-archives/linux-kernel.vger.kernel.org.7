Return-Path: <linux-kernel+bounces-769569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6595B27073
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 22:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98123A27E2F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 20:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6045273D66;
	Thu, 14 Aug 2025 20:57:11 +0000 (UTC)
Received: from sxb1plsmtpa01-14.prod.sxb1.secureserver.net (sxb1plsmtpa01-14.prod.sxb1.secureserver.net [188.121.53.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117BA259C9C
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 20:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755205031; cv=none; b=HIZNJFuuA+PxexacUQwV/dJbV2hkEn/YYy0YUbfg0rSOKYd3RH0rmrBReyX8QRley8WMaI5v523nmx7Wpi4gAcyfTlOFuu698pc5kZ48m+t3ynVMNZp0dtG1loY3uLKZqZ0OIOoMMrR45Z/S5P4kQCMz090OpAJvmQrDFBb0lXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755205031; c=relaxed/simple;
	bh=he5wJQ0o4xMW0AOM6Up68MM+42r3CQ54xIuwKLxlBCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=A4n6g3YstupSRDv9efr+iakBSVBFUxBPoD2PseWTfdP1zAx7Ijv8waSiTw48rMVm/iUbBmt7ook1v8m2CZO8+pVyysYu9nzzxrjYYZIrI4lZAuXPZvVAbCpYKe51KVWjg0ijqmmI9SLR9rtD28To3e//laBv72J6zZIgI5++uRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=188.121.53.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from [192.168.178.101] ([82.69.79.175])
	by :SMTPAUTH: with ESMTPSA
	id mZebu7GFx32OcmZeeuzCe9; Thu, 14 Aug 2025 08:14:13 -0700
X-CMAE-Analysis: v=2.4 cv=FrhcP2rq c=1 sm=1 tr=0 ts=689dfd46
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=IkcTkHD0fZMA:10 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=FXvPX3liAAAA:8
 a=aNkumETa1H_BtnESXfkA:9 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22 a=UObqyxdv-6Yh2QiB9mM_:22
Feedback-ID: 3ee615484e0d781ceb010cc4a840136d:squashfs.org.uk:ssnet
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
Message-ID: <224b26b2-f06e-497e-a3d3-de56360d1a61@squashfs.org.uk>
Date: Thu, 14 Aug 2025 16:14:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] squashfs: Verify inode mode when loading from disk
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Andrew Morton <akpm@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <f63d8d11-2254-4fc3-9292-9a43a93b374e@I-love.SAKURA.ne.jp>
Content-Language: en-GB
From: Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <f63d8d11-2254-4fc3-9292-9a43a93b374e@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfHXMQJu/um3/QEl9Cv5/vaYXfjRH0BDFuTzStxEsKQERMamVa4usW+AcOSXF4iiqHVYXViBxkLB6Uy9PeCy+U7Ya30DRwevB97JLFVgDQthYv6LmP4iZ
 4wNhvKdH4R5aia0vJvRUR9SLUwrpu3WJjedaivi6dvzuoY+2yFp7lM9axCdYD0jf4SY7BR7v/8TtaqVfKoyftd7TouTpM27rYVhiEsweKUpG7MjHYqaNHMJG
 G9MCKfv7cysCeea9WGbZYJMTS7F/l5aTjt54Njn7/rKiD+6d0TOcLdd5N2lt2T52

On 13/08/2025 08:17, Tetsuo Handa wrote:
> The inode mode loaded from corrupted disk might by error contain the file
> type bits. Since the file type bits are set by squashfs_read_inode() using
> bitwise OR, the file type bits must not be set by squashfs_new_inode() from
> squashfs_read_inode(); otherwise, an invalid file type bits later confuses
> may_open().
>
> Reported-by: syzbot <syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.com>
> Closes: https://syzkaller.appspot.com/bug?extid=895c23f6917da440ed0d
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Reviewed-by: Phillip Lougher <phillip@squashfs.org.uk>


