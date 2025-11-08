Return-Path: <linux-kernel+bounces-891577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9B5C42FAD
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 17:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C60C188D3C6
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 16:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D8E18DB26;
	Sat,  8 Nov 2025 16:15:47 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCED11713
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 16:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762618546; cv=none; b=FNvG/wANuYdaTY/NhqvkKFkTMScA/0TOdzJ7pgO5miyNPSBcCJOkqLmUutkyBSGQGe5cGYbxY8KHpvgNEG/MJj51iLE9VwM+dEj181qGBTSDK/YXB2BEv48A09EWcs7b06iJTE0r+kpY63SbG0SbYXZqaGJO6OCahNJ/f+ZZ8e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762618546; c=relaxed/simple;
	bh=9ayEQsWenNFVfHQEzc3PbdPL1JAfWU29HptA+qrE5zo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uG5gyafUHHvxzJcBWz8jH8b1DMPf+SXNwsHxSVfMJ7pKk/fH1Xdel9YnwLJBhwT1PmW3o8Y0TFp2J0uSTd/yA1oQ8fWPBMPK1mgwA+zAQPTAB66sLONbDqEaAQH+JF6/yGvpJDveqA4CwJ91irvwN+WHPsURohJly7rB0FWSCZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-433692f7479so23858455ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 08:15:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762618544; x=1763223344;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PzEGvAK4/TfjqGDU/ZQoRjnBCTA75eEzMfSD7guJ6/w=;
        b=Tmd207/p3DlFeuOOvYi04eaS9v4nRozGkllXglJ1pcV3eB6JDCm/r9Sg5+euYYhm3e
         eSTLhm9Tn2AUX0cc5vSix6FZqw8IZlXhZ6X8WKCDcDkxFjLH61S1E3rFLHv2DDD3vXMZ
         9qySlVoeCQPQ31u4I4JD1SA9HNbNxoMNO7O60Ci7fWd+kd6ElL5O47PAHWoTdtB1HFom
         vZBGLUE9aBOIcauXprrCr7dhkmoA+ie0mDDVhhZM+TNEKRfPfjpP5Hfb+x9fixdERJlG
         7FJ1P90XHYca6wBRMtPGOV+0zwx/3AbDFsmZT5CLq9cUPjnjjSdhnAHD4wnjMyCFBxjv
         bk0w==
X-Gm-Message-State: AOJu0YwR/dYf7eKAyX9ypubFnWm8jKBBq6EyLxoyDKxbVX90RbuDxO3L
	yEa1nGTJeP8532j/p5lro64lyu2H2WPPFjV3G/yFA+dQkMxxTLDw42hQNbAhGt9WSdMa/bPmQ9g
	ifEvlPCIWLEB92YmJ9nTVS6v136rzhOMxvBzTY6lhaA7K6ACx5Nc9gzemfNc=
X-Google-Smtp-Source: AGHT+IGXqXWo1TboaftsDCiCCvTnkVkWwQgP/S6IpTiGaYp4elJeQ0IcOWGJMMr4FY3irWoe/eVIDvOBXAf5atLw0DE1FVyRMGPq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4c:0:b0:433:2d7e:3076 with SMTP id
 e9e14a558f8ab-43367e7accdmr41925495ab.18.1762618544486; Sat, 08 Nov 2025
 08:15:44 -0800 (PST)
Date: Sat, 08 Nov 2025 08:15:44 -0800
In-Reply-To: <690d9fd3.a70a0220.22f260.0021.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690f6cb0.a70a0220.22f260.0085.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [jfs?] general protection fault in txCommit (2)
From: syzbot <syzbot+9489c9f9f3d437221ea2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [jfs?] general protection fault in txCommit (2)
Author: yun.zhou@windriver.com

#syz test

________________________________________
From: syzbot <syzbot+9489c9f9f3d437221ea2@syzkaller.appspotmail.com>
Sent: Saturday, November 8, 2025 16:36
To: linux-kernel@vger.kernel.org; syzkaller-bugs@googlegroups.com; Zhou, Yun
Subject: Re: [syzbot] [jfs?] general protection fault in txCommit (2)

CAUTION: This email comes from a non Wind River email account!
Do not click links or open attachments unless you recognize the sender and know the content is safe.

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/jfs/jfs_txnmgr.c
Hunk #1 FAILED at 1073.
1 out of 1 hunk FAILED



Tested on:

commit:         e811c33b Merge tag 'drm-fixes-2025-11-08' of https://g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
dashboard link: https://syzkaller.appspot.com/bug?extid=9489c9f9f3d437221ea2
compiler:
patch:          https://syzkaller.appspot.com/x/patch.diff?x=177f4412580000


