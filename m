Return-Path: <linux-kernel+bounces-880323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D66A5C25799
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 021FA566595
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454CB24BBEC;
	Fri, 31 Oct 2025 14:08:08 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC8A2376E4
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761919687; cv=none; b=Z2FE2BpraImjEFks5LUWFOsRd9+Yi1SYPWgda/wP3luu6fZjoKewUDsoHKW0stoTsz+NZOz7d7LWJONTHXvtmK1sBfqdG3OLjWlpEOqhj8NWIZDmd3TJlIW6tzFUwPwU7Lo5s9XIu3nHAyFWIo4TnuTQanbhXQrrEOXnbQT4/KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761919687; c=relaxed/simple;
	bh=ED55lrngjHdyUGWie8rUBxgKpxuLBSaAPRCkhxJJ6y4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ORJYepFCusCmIojEzYKrgBGqn1MzchYWATA/GsST1xU+BDVI7Fe/krNM+QOafe9L6hlz6EH5dxn9UPL+fbt2FQQFiqZv6gSotT0nH2qb8JVOqmF0SSYAtkFAjrj0lQapYf1M+WQDygmgVtu1W1nBPjZz7D6DtCKJatQjsT90+Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-43317e91de3so13791055ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761919684; x=1762524484;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dqGZv0OA3JPtNgEU2HhNrVe2OgAbIOHp6T3YcLWrtZ8=;
        b=Clo/NvtjzBcXLgHKGR1AZrTqbwvPWFKqe9VVxI7fpHFuS1SYbf4AqgdyAr/uxGsXXi
         AlXD14uf08jc5CDEENGIPZPozXBA7UKHrhlvdGkZrnkDrXf8jq7zvQkmkQxZCytPmIRL
         8kLQS5jvhuADGqiiaATv22Klzh1Nu/Z8Tc1DoKmVMBuY8JdAESu6RErDdySk/M9stbzx
         2Uu2cpZvaTKmmLXxTSE8L1Ke60cMbAF7msab/FxA12piHFJ/YqwaiMfQ0VN8r2sUdDm2
         ypvJWSVs3PPSnku2CRJgg31DRiX7Q7D8UVBQtPQuqbky8ExQNdLp+g8vSCcG80QPLKOw
         VTxg==
X-Gm-Message-State: AOJu0YyrKR0m22MIuzRIQMpLRaYFPZkLjDLfGU5Kk8ACfTvrzq9QfrTl
	tXu4TE+qiMmpMlQFNgcItyZrjCDcjSMtL38T2WSXqfIbD/OUHRCJfYk1V+FBtRDS8HX4Ml5O9wd
	POjXAzujQXpeEAOtJB67l2gYhFJmIE9xox7OE9j4PQcum9E6+2vTwt/+xKVI=
X-Google-Smtp-Source: AGHT+IFW9DXXqbx3JNJFkKYSLmQcH+2RI1VkTY5OlTkYqdwaTURBKKMMHfsMKZD04cgCuY06QYrJ05HasoRW7g3rlNznR15wgd8D
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca46:0:b0:430:a183:7b with SMTP id e9e14a558f8ab-4330d12268emr59295065ab.3.1761919684444;
 Fri, 31 Oct 2025 07:08:04 -0700 (PDT)
Date: Fri, 31 Oct 2025 07:08:04 -0700
In-Reply-To: <CAHjv_au2GAuojVcQcij5m4U4S0QYgqXXUV_hUUUGtD+3VMJXXA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6904c2c4.050a0220.e9cb8.0012.GAE@google.com>
Subject: Re: [syzbot] [bfs?] INFO: task hung in bfs_lookup (6)
From: syzbot <syzbot+e7be6bf3e45b7b463bfa@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	zlatistiv@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+e7be6bf3e45b7b463bfa@syzkaller.appspotmail.com
Tested-by: syzbot+e7be6bf3e45b7b463bfa@syzkaller.appspotmail.com

Tested on:

commit:         d1271768 Merge tag 'linux_kselftest-fixes-6.18-rc4' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=131e7e7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c614fa9e6f5bdc1
dashboard link: https://syzkaller.appspot.com/bug?extid=e7be6bf3e45b7b463bfa
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=167f5258580000

Note: testing is done by a robot and is best-effort only.

