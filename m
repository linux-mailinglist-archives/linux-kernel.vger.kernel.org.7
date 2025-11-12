Return-Path: <linux-kernel+bounces-896374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC94C5037D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 02:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7854018986E5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 01:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65662765ED;
	Wed, 12 Nov 2025 01:39:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30FC23A994
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 01:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762911546; cv=none; b=kiufniHTW+w1Y7Jj4Tchj6vqqD0+8HZHP5PRupZGmAKYbs/mHxsip1zMZX3gMdjBIEmsA5sBlo/Ia+Cz+ZYB8kkUR2GzP1rmPv57uQ7yHmwhWyhvrW2piAUtk2FsYlxaWbrkWynmlom/c0tdx6vEjKTfo7WjZPqtWV29mVrIg4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762911546; c=relaxed/simple;
	bh=iOFFy8TlFMvzUBeDLkDc0XuAbg1Bvbc8SLCN9vTAcBo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=m8/WMXQ1EnSmDr3pKBZQbxwl5tAROOI23DDHg+JvMT5mVYOttjS5d6Rzqnd0AdWpdiwsEmcY7+wzd8QH0AEMjL1sjXYs3/YDJnW8xDelvln3PqWM/My7V79bj0NhfGnXBBIEIVnGOIZwifu8L9P02Uo1Edvt4Xgc5ciLiwWzY/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-43376637642so3811975ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 17:39:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762911542; x=1763516342;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wyjgJ60h/mV3PA/EgcqOZeLqsAfi1oRjkzLzhwsIcks=;
        b=EFYw8WP/DNhUOn57hNs7+Mx6MnuFlzaJ2LT0zwcqnuM53VE36gs4j3uzoquz6SqS5p
         Yo6URZ92VIYhjO/cmOb35lPx37o7BQczziIjWd8t1tOX45DOu6Hy39SjcfmIT7VdKdJH
         lE2K4tnGkGlcdvdQaAnVo/raUU3lmmxTL7NtlmDW6ZvXe7xJ8BmGJWZErnV9K7FoiRA6
         ubXYsjCoytmlcFUcSh0eNWlBfCPYTK+PMZ2/CVWpu6g1KuLxHxCDg1zcO4zYwp7rCAvG
         RXjpTODMyF2Tlbamo6Bng4QZOK/ioHCJkvo5R+o3WUXflgv1NOKkgAA+zyVyDf2KdHjt
         F63A==
X-Gm-Message-State: AOJu0YxbfN2H/QTX3R/v2iV7ytKVJI/Cb7uiH/yH+OICmvuBzwmWRiSN
	jVCrmjPpQ55sFJKi4toDVGeZYel1z+pCuid9Cgg/R/oaBRTDWQNV0uliFJ+fK4U7laq2XbpirkF
	o3we+JssIrBN/7VHdTFCxMXXFWWvnKtNJVEYbSha/B/mjV3rccq3e/9tAPbw=
X-Google-Smtp-Source: AGHT+IEQDH7Bl7OsXkJQlfcRCsI88SVE31oggSAMCc1qibvINnmmd9IPcrjQymPOXgdImY0CNM+ruoz1SN5AtM2rD60akxxsXdzK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1909:b0:42e:72ee:cde6 with SMTP id
 e9e14a558f8ab-43473d11968mr20009555ab.12.1762911542131; Tue, 11 Nov 2025
 17:39:02 -0800 (PST)
Date: Tue, 11 Nov 2025 17:39:02 -0800
In-Reply-To: <aRPePxH1_OtOKcM3@rpthibeault-XPS-13-9305>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6913e536.a70a0220.22f260.0154.GAE@google.com>
Subject: Re: [syzbot] [xfs?] KASAN: slab-out-of-bounds Read in xlog_cksum
From: syzbot <syzbot+9f6d080dece587cfdd4c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, rpthibeault@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9f6d080dece587cfdd4c@syzkaller.appspotmail.com
Tested-by: syzbot+9f6d080dece587cfdd4c@syzkaller.appspotmail.com

Tested on:

commit:         24172e0d Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15208212580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f0fd60646ed018d
dashboard link: https://syzkaller.appspot.com/bug?extid=9f6d080dece587cfdd4c
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17308692580000

Note: testing is done by a robot and is best-effort only.

