Return-Path: <linux-kernel+bounces-764011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2BAB21CD8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 07:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15CBC1A2273E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 05:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC47217736;
	Tue, 12 Aug 2025 05:31:04 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DD418FC91
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754976664; cv=none; b=Cfb9qWSD+1b0vOxqV93rahBHjvUET4ruwrqGw+OoHtnCCeKvNj3RlbECxvJ4dWWkSM/j2fOk8rt3p0ZxCodbwmzgPw6APudl2SKrpiTeZy+c18X+TrMfUeivAAvrC8hDz5tqjx5MCS1z656yCT6xm2tRHprOZ3mIU7s1Sb0MYj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754976664; c=relaxed/simple;
	bh=lrVyQeKpefgRR3WdfACekhdULtf0LlpnDSWMxKTnUsY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YVk2a1y2ulgJ40NZtNDVqHvFj4is4C8AVbIywHxZVTKZibueaEVWVGf0DjAMXcEcIndufK58PXe3Ax+bd94WSiFjFECyncUMuGFvCsT4/tP1jiDa43qKCL3ecGKUFHmaaRbS0DDM0AG9QZfvgU+hzfM3wd/74Da5adMXa1QV9Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-884132279f5so153791839f.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 22:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754976662; x=1755581462;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NrQp+Nlak+6pLdW8kr9MajiBzMUdpVQ9XY+QypQfSJQ=;
        b=fb59zUXTz5u2MjzduYQO4FcOmFbN6X8j32luVkMCJzX3ibYwgb9Z/g+4wjC9hReEmD
         J9L0xaSuYqDTT6u6R3Riywen/fIoW9Ff7uFxbM+tWOUQXuBNyhk2CIur4QsSpor6+E7w
         mpg4JHZQ+PX/I4easqqp7o6faU+PIa//hhGWFcYiX6NJqLaEINEeo6d33eVKn1yPdSzn
         Jhm+mTtHApKPYQ51SnCrRzY+vM46LuFjL6wv41m7zG/2Adxjdhgh1ocqkftpAK3BxYle
         w2+HES5TFeY3mu19fuLPXeaNnU5OMPtJ3LnB7uVPaB/qTUEnPC1weVDS84I7bR5ICUu6
         2LGg==
X-Forwarded-Encrypted: i=1; AJvYcCWUVkrt6BleI6+HWXdjUacOCr1jOwWYhAhK3HwCu9qbuIe0VDlEHI+EkP99JZFO4TuoI6zZl16enz718vM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx+KTerlRD4aj2FvPVoh56Ea3VBEMLyct3wwtIz79ZLmfIlJjU
	TJtDCaLjCkdcMqzSGTkwln7h+FFxfvf0ww3MSay54laZjkopTLCPl5cR4iY7xPJGwSncv/CONf7
	rByvPqqaU3NEzVt7Y9aL1JLIH/JTVeQYZiAO/Zm8Ou+KSAHHVV0Qxq6bSWaY=
X-Google-Smtp-Source: AGHT+IGun4n3kKkWZSXtGpgDWnvH3zqHpvFyoLnpSK+9YfPN/HoubZuRf8gq1Dq0Df3kOfbpw7Jy9+fjFp6PqvV4JaZuovBlZsCW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6c1c:b0:884:115:d88a with SMTP id
 ca18e2360f4ac-8841c357594mr427730539f.8.1754976661806; Mon, 11 Aug 2025
 22:31:01 -0700 (PDT)
Date: Mon, 11 Aug 2025 22:31:01 -0700
In-Reply-To: <20250812050829.4213-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689ad195.050a0220.7f033.010d.GAE@google.com>
Subject: Re: [syzbot] [wireless?] KASAN: slab-use-after-free Read in cmp_bss
From: syzbot <syzbot+30754ca335e6fb7e3092@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+30754ca335e6fb7e3092@syzkaller.appspotmail.com
Tested-by: syzbot+30754ca335e6fb7e3092@syzkaller.appspotmail.com

Tested on:

commit:         53e760d8 Merge tag 'nfsd-6.17-1' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17fe2842580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d67d3af29f50297e
dashboard link: https://syzkaller.appspot.com/bug?extid=30754ca335e6fb7e3092
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12168c34580000

Note: testing is done by a robot and is best-effort only.

