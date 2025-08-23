Return-Path: <linux-kernel+bounces-782982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2211B327F7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 11:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FA7AAC2D02
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 09:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1CE23D7C6;
	Sat, 23 Aug 2025 09:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Pdq0N8j/"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368851B85FD
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 09:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755942063; cv=none; b=f/Te9JB86QhVmqekuLlummrYRpAXkRGrqbKFRKBPaVL66VNVoft4HrYMg5OWQ4ig65bsIi4mszTsAOcyhgmWfIg1E1mPHBAAjyCBLHiabuHGXtmGz2ZFLdMPmh3bW0PEhhUODrnX4JOtEHxwFLijC2jV7AFNp9HhSNXBttyRwZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755942063; c=relaxed/simple;
	bh=/qQNfaYLKV4EaeXfzNXPWlW10YGsWN0rafc9cEO+4rE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tgbPAcADHOnMyleCvQl16YWPJwBmADS+Cvv5N0nkQZQ1O0oEHbABSZXCqJmEG4XoW92/OqbwzYxKpWF96yMu9k1QZG10EZd2LdTl/wcgPqtmGuJ9qDWGLTZVQij9rJOrrBcEyyKaT5z80uZsYNoK+FDE7fqdv+xDAC8SAwBIXiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Pdq0N8j/; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755942056; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=qKcPSraqEL3YYPwyV4Fys//bzQfk4CBHUzNcoKYIWzQ=;
	b=Pdq0N8j/U7bSb+IrQYgiQT8p7YVUFkl3V51W9A4VDFhDkzKzjNvE1VeOLiuwc5H5NHCeCxQ6yaP2bcVvItArpsjlSiJj/3ykfjFW7oHtNLeKLOGts4M5pnErKmL4ZiZFlYKVigUQsE7XwhDslUsT7UE4327ztVNm/4DcVpkY8zU=
Received: from 30.180.0.242(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WmLtjN3_1755942055 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 23 Aug 2025 17:40:55 +0800
Message-ID: <c93c3ae0-2e72-48b3-9faf-956fd6f1a3d4@linux.alibaba.com>
Date: Sat, 23 Aug 2025 17:40:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: Prohibit access to excessive algorithmformat
To: Edward Adam Davis <eadavis@qq.com>,
 syzbot+5a398eb460ddaa6f242f@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <68a8bd20.050a0220.37038e.005a.GAE@google.com>
 <tencent_FC33559E331B7F4BA91BB62522BA1CBB8C08@qq.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <tencent_FC33559E331B7F4BA91BB62522BA1CBB8C08@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2025/8/23 09:53, Edward Adam Davis wrote:
> syz reported a global-out-of-bounds Read in z_erofs_decompress_queue.
> 
> OOB occurs in z_erofs_decompress_queue() because algorithmformat is too
> large.
> 
> Added relevant checks when registering pcluster.
> 
> Reported-by: syzbot+5a398eb460ddaa6f242f@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=5a398eb460ddaa6f242f
> Tested-by: syzbot+5a398eb460ddaa6f242f@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>

Your analysis is correct, but the fix should be applied to zmap.c
instead since it parses the on-disk map format. Also, it's actually
a regression out of new encoded extents since the old compress
indexes already has the check.

I've submitted a formal fix:
https://lore.kernel.org/r/20250823093018.3117864-1-hsiangkao@linux.alibaba.com

Thanks,
Gao Xiang

