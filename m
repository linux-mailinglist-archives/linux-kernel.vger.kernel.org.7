Return-Path: <linux-kernel+bounces-869949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D77E7C09179
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 15:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44901AA7BDE
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 13:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64492FB0B7;
	Sat, 25 Oct 2025 13:58:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342722AD3D
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 13:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761400686; cv=none; b=uFh1ymvEBVvicwQmFE9HcVGiWLlLNr83sPx7WIb+UJy29UVLDUfeIPwxQPl6tNYptzs+tZNd+z+h9/LfpthinQHWVBwlmdPGOhlOTFEoh9aBrnBCBiP6KIcrpW4z4O4AXpmwU6+AF6BWmkbxVlYp7eFo/chO2fGjajFyz4sEWLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761400686; c=relaxed/simple;
	bh=nv1LmrIhYPZPpwRpv0ke9kCHlLBAMLKb8eL1U81ihcw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Jt7uYUVhvQhChU+KZh7WdRx301lQSEhq6qvCmkjO0vn8ElVuw6CRNZ9XjThyNWbAfdUYXQea//wE+pxXZpMMH051Et54afuSQWF3oV+IUfcWTJ4o1wySZaSWdbyKGq0OXZ2Y2TE/j8+s26bbHLs0vfexqGgc7X0ncKjICTe05CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-940dc0d7a38so464003839f.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 06:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761400683; x=1762005483;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0hX7Xmy0Kxtzd20tdCrVN3WPsq+s3O89wFoVx+waOf4=;
        b=gbvLv+nqvE3bRdpwLuQBdDDexBpUnjvKfIcTBOUBKjniELiEH4VqUckJ1bs9FMoadc
         wRdt4j9TiUpsjt0dHboKLLah3HQDa9mqaOOBPabl7ZKLappbgtzlMh88FRiMviRcARaX
         qC0GCHbNF0TEHYtyR1iW/eo8uA1cs7bEZ1QE7L3YkOJkEaZk6gXJAfZ4ZkaDJwGkLc5E
         D20bGSZp17AbD7yl0SUQN97BFZF2D2/LDC9PVDs146hnlvXKa+C5MDgwij3Yq1xsBWa0
         N7qNb9okZkvD73I7SDujjOVEZssRVVCFVb0FUzmT2E8RChnTVPZ2Zw+y/T8/XduckTOB
         +gxw==
X-Forwarded-Encrypted: i=1; AJvYcCUHohg3fPjPCHe+bFAhvo8HsG7GTzwZkFJ4WR2HJaAvZB6zFcbQsX0iPq1HSwJsZspFOiH1yI7xBVqNpdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN/Jkl/5bro/+rS/SYJoPRpDs42DaOgpx8X4gFtWMpUTklI0Fk
	Td3CwttHUQiz1/LfOln+nDmw/hDhRSXuSKrVSGUTXmNSei5QUIdf07pyFdpGV331OTSfS8YgIgV
	4SY1v2pFVg7sE1/anzKqR5aCcMst8phz20E92WJo+L4iTYXjXtF48UwPjVWc=
X-Google-Smtp-Source: AGHT+IHLuGup7FvrtWEhAdxQW6pc+HkJp5VkQy3kaEW+3FCzq6/u86oSYHu5ceNO3JAKYd3Jh6ecMUpxSMld3GyW6SPg7BvYdW9I
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3c85:b0:424:805a:be98 with SMTP id
 e9e14a558f8ab-431eb63e7bbmr73145145ab.9.1761400683341; Sat, 25 Oct 2025
 06:58:03 -0700 (PDT)
Date: Sat, 25 Oct 2025 06:58:03 -0700
In-Reply-To: <kwl4tk52z4cl5d5wahcmfh6skff5mypsa2jylyd6ag5nhrad3j@yawn25geajlz>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fcd76b.a00a0220.9662e.001a.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in raw_ioctl
From: syzbot <syzbot+d8fd35fa6177afa8c92b@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, apopple@nvidia.com, byungchul@sk.com, 
	david@redhat.com, gourry@gourry.net, joshua.hahnjy@gmail.com, 
	krishnagopi487@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	matthew.brost@intel.com, rakie.kim@sk.com, syzkaller-bugs@googlegroups.com, 
	ying.huang@linux.alibaba.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+d8fd35fa6177afa8c92b@syzkaller.appspotmail.com
Tested-by: syzbot+d8fd35fa6177afa8c92b@syzkaller.appspotmail.com

Tested on:

commit:         72fb0170 Add linux-next specific files for 20251024
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=133e1d42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e812d103f45aa955
dashboard link: https://syzkaller.appspot.com/bug?extid=d8fd35fa6177afa8c92b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10c72614580000

Note: testing is done by a robot and is best-effort only.

