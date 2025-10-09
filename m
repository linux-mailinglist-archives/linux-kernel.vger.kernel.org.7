Return-Path: <linux-kernel+bounces-847013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D78BC9A73
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 12CB04E707E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022D92EB84F;
	Thu,  9 Oct 2025 14:57:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15ECE2EB85C
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760021825; cv=none; b=g85RljUMSnpGRyFZ3Yh0DgOY9sh1EOo7bLa+NOtNm1LAlqI6kqslXgKOiocbzFj/t5GWH++n9O9KWyn2n4dk7BEwP8yOifKKENlHASlKeS524TDSTkVvch0o/ASBMhc4TwxfG2BYQvrvnlmiHHxPMuz4zDjka3rLkaBDEcJd4cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760021825; c=relaxed/simple;
	bh=N4fJ9Q1gvOQlVCwKef/0uJmrn1Qq5v9cGcBX51cF3S8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UkAN6IfLktzVxqTwbkW/W5JQW8LhcAWTMSOUPwnRiSzSGShtqxEQYu04PHom5uVAUu0hkmz5+onvEYKFCUKiPh1d3FiJpZU6L83G+9G2TBGvybK9CHyJQ/zFxB/CbArbm6KT88rgH4Pg9CBIb6VuwM6zGOSgrl5WT9uVRXQbIQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-9228ed70eb7so418110539f.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 07:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760021823; x=1760626623;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bTw49+OLUobK2JxS2YL+SxWcxXbe7InIuPqvTtsdFvg=;
        b=NM2IPJ5nMADGEEtJi/Rm3nEj/dDqV65S81sGboxseVo35L3311tMSnMtfQepaU94aH
         WJpIVGTpYE8ztstn02dYDlhgR+Q9fgh438nvsE9BW4NAAvDDYfIOQnxejpVFcngiBPM9
         1jAwe9x8mmXEXlDo7Pts9cvX0AnsUth/HFDm3/hqQwuQOXsoDruK3CHOr/QRYPPWQxvR
         HTAezr5c+hpWK0G/l+CWyLByZtx1yfoDNBIeTVqJWJbls2jKUIOAEfynZkzZw0Exr8qI
         ZVRPrMfW1tS74SvK8G475gdyYpJd4hAgWEfFm8mMI/mlCoHaSqQPPGhfkCJsf49CqHB4
         vnEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW73J9WvVcRxOJR2awAHLl9kbAeCSR7ZKNMfDPmDLeoDLMcfRCJfAteEePZC4wb0iRUxNOZOnJlz9gobQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI4T4RF7E1zRGZTGfq8gB39l+/L/VBa7KyS0FRllTPjNvGWsr0
	IT9ZIhr6rq2fnLjJCCfatHwnsVMKK49S8qjh9QsFtPKJucCAO7W0f+Vd8C/dSwaWz8HK62hLh3v
	UGZyI63YnKkyBBe8rHqWXdTHfF9S/TuLFpuZ9nF4/H6mMl/0TpsL4hXIc6oY=
X-Google-Smtp-Source: AGHT+IF5fE36uNOPgJE0LksCqbg20Nt+HZH+5cAr4F+KwlmWmURzgZZ2LvuUP2c5d53CWH+iXo+VGOQh2myAHz6tJrLiBZrgM1mg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2d83:b0:918:f2e8:ba6c with SMTP id
 ca18e2360f4ac-93bd198bccdmr789564639f.18.1760021823154; Thu, 09 Oct 2025
 07:57:03 -0700 (PDT)
Date: Thu, 09 Oct 2025 07:57:03 -0700
In-Reply-To: <20251009143611.517872-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e7cd3f.050a0220.91a22.0007.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_refcount_cal_cow_clusters
From: syzbot <syzbot+6fdd8fa3380730a4b22c@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+6fdd8fa3380730a4b22c@syzkaller.appspotmail.com
Tested-by: syzbot+6fdd8fa3380730a4b22c@syzkaller.appspotmail.com

Tested on:

commit:         ec714e37 Merge tag 'perf-tools-for-v6.18-1-2025-10-08'..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1480ba7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a19be70789ed377
dashboard link: https://syzkaller.appspot.com/bug?extid=6fdd8fa3380730a4b22c
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13ca1304580000

Note: testing is done by a robot and is best-effort only.

