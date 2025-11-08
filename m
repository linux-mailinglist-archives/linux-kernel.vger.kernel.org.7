Return-Path: <linux-kernel+bounces-891455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0B9C42B2E
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 11:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BF213B2671
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 10:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2260F2FABE0;
	Sat,  8 Nov 2025 10:20:03 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112592F7444
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 10:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762597202; cv=none; b=SaloHK6XwoIFxr9LYtksvVikPPTEHBcaR6+h4IipUyh3Xv3bK6RjgyfwFrWJzMAjidVd4uLfv2hKSCIWQbN06/SHhGxwWnwjNjLSL3wAqYdVYgCgvIenOlrYbdir1qxSdQ6UrOfyoZgGcF8KAySE1xzEHAqHA82bIhsgerNDnDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762597202; c=relaxed/simple;
	bh=8a4HP+d2FfUB1WSXBOua59ve8+CanSYwYah1hcLW/N0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V6rtJliX98WWsRVNBJ7jL2JZnsOwg8msgd1A1ucJh2dElPvY8aOx+Qa8TmUJ4QZUv2itfE7HBaaljXJe7AUkiWOvE8ui6Y8aNq/XYYkIxf5t10141RB6HxVtbRLQFHTWpD+BNvXVeoja4lIPVQ7he14rNtYrs1gEh9b4nwM3AF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 5A8AJwlI005978;
	Sat, 8 Nov 2025 19:19:58 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 5A8AJvkD005975
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 8 Nov 2025 19:19:57 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <c3b11943-f8ea-4283-9d88-e442bc8ff547@I-love.SAKURA.ne.jp>
Date: Sat, 8 Nov 2025 19:19:55 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jfs: Initialize synclist in metapage allocation
To: ssrane_b23@ee.vjti.ac.in, shaggy@kernel.org
Cc: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, dsterba@suse.com, david@redhat.com,
        shivankg@amd.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com,
        khalid@kernel.org,
        syzbot+cfc7cab3bb6eaa7c4de2@syzkaller.appspotmail.com
Newsgroups: gmane.linux.kernel
References: <20251107200645.149093-1-ssranevjti@gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20251107200645.149093-1-ssranevjti@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav202.rs.sakura.ne.jp

On 2025/11/08 5:06, ssrane_b23@ee.vjti.ac.in wrote:
> Reported-by: syzbot+cfc7cab3bb6eaa7c4de2@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=cfc7cab3bb6eaa7c4de2
> Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>

Excuse me, but the reporter and link are for an ocfs2 bug. Please correct.


