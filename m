Return-Path: <linux-kernel+bounces-729516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD4DB037CD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A896F3A847C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 07:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD99233704;
	Mon, 14 Jul 2025 07:22:33 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81664322A
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 07:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752477753; cv=none; b=Uabx+TiJegybGSxQNCqPI07YjtZt+Mk6ZOptEYC4vVOJsOncIAfSIiF0KhjKb6ZAKQM+l4AKeghzVzIuSr/huNEckB3/kZ44OpOoFgWyoliqU8xrVsda7xgVCPqfrKzXyLLchmDE8i+wUCh6Rc7MkpREmgDKmaRBIV9qEBBhfPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752477753; c=relaxed/simple;
	bh=cUjRIPbmUy0lKKYkcdJFj/W6+blRgUvmQPyiuwbVx8A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hi2SF84x+X1qqElJ7xqLwCE2vJ4NFfhANBJKH8n3GwdJxI0nw9mjdb/xEODFCCkgeSwpZ8ZSsOxdODMhLg/M7JwYXdl5qTqz3b8ZegVuAW9raMdlwA8jvgf2uRpD24A8ysauM5QbLyXfyinqYx8pbVSO7aYJIpFyv3Rjbt88dH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-86d126265baso369621239f.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 00:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752477750; x=1753082550;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Po/A+wtbc1jdSXvCuFG0YJfDF9pUij39LY3Ij2dIkBI=;
        b=N8yz/12a/O+wpUyIaXPa/tBehQQccZs92i0IGGiIbPutlOJT1WCcxg07ELo1+O2u1g
         UZROjkrCRe7fMpD6mU2N2jZa5sCH67xKgC1iigYx94V5uNRPZIG5UemfDzxocMGiFfcH
         fkERMzAIVOUtp3yrh72BYMNELnweXwx/8jFLgXECDcHMLE1IzdzwBA3JJV2gbpaAOdRm
         YIqC0pfhh3W/MSyeybmAzq6/7rSgtl3rq4hc6c1Y7hde3bom5rcLIjVFsq7f7M+6kCqt
         dBym5Abg7fxnM45ACCVv/CIFc4O0NlUaA3+9pDprAQv2DfZqtZd/L79mpOhgP2srMEzD
         cYvA==
X-Forwarded-Encrypted: i=1; AJvYcCXT6ry+tXRDYt1rzcgW4GvEdFvIX2nRAq+TH03lCLnJVAFQuElYvVHPDiKsJYwWByhibiqz1UrpJL0uAUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0k/ycoB8eRyTC+RxUNA1/6AUWOlN7nqK3eBuIT/HW1GO6cQfh
	QVuzjWJ3BU6cH91a8GIQRMOdVg34tyq4kT1qJd6Kn3wAsqixzQTFInX7MGZpVDnLezTN3saLq1M
	/6TE0SGtDlzRWw/wBE2neIQnvi8PG4I7sX4H3tNck5FMhrKO4fSjgGRlJdA4=
X-Google-Smtp-Source: AGHT+IHow8fclkeQxrcpSvlhr8B47ljuvaAAHcrVgmrSeuvEPnUISMKfj5mI/kwyQvb1q1n87wIAn9yS2VssI6EbHb6hN6UsaG7H
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1354:b0:876:d18f:fb06 with SMTP id
 ca18e2360f4ac-87977ea916amr1283794839f.0.1752477750675; Mon, 14 Jul 2025
 00:22:30 -0700 (PDT)
Date: Mon, 14 Jul 2025 00:22:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6874b036.a70a0220.3b380f.004b.GAE@google.com>
Subject: [syzbot] Monthly fbdev report (Jul 2025)
From: syzbot <syzbot+listfb4485d95eabb4a677d4@syzkaller.appspotmail.com>
To: deller@gmx.de, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello fbdev maintainers/developers,

This is a 31-day syzbot report for the fbdev subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/fbdev

During the period, 0 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 26 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2587    Yes   KASAN: vmalloc-out-of-bounds Write in imageblit (4)
                  https://syzkaller.appspot.com/bug?extid=c4b7aa0513823e2ea880
<2> 192     Yes   KASAN: slab-out-of-bounds Read in fbcon_prepare_logo
                  https://syzkaller.appspot.com/bug?extid=0c815b25cdb3678e7083
<3> 39      No    KASAN: vmalloc-out-of-bounds Write in fillrect
                  https://syzkaller.appspot.com/bug?extid=7a63ce155648954e749b
<4> 28      Yes   KASAN: global-out-of-bounds Read in bit_putcs (3)
                  https://syzkaller.appspot.com/bug?extid=793cf822d213be1a74f2

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

