Return-Path: <linux-kernel+bounces-756807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BCAB1B988
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 19:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B39E518A6A64
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B491D23ABB2;
	Tue,  5 Aug 2025 17:40:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93EA1F8EEC
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 17:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754415604; cv=none; b=KDLpoYdFcHyX7AFgk6rshlCtbEyRG9ZS3FIffxSrWrAzl6UU01mDBpc2CCMntFPbDrgrJI2RIJIzNuiPfgXS1mrnI1SBDjGJLVKZkqsKBbKSjwfOLwAMjyyzLWCqOiC3xdM7yRNEjoLP1NIFnBUpOe0BQy2JgCTZcXw3pRAKohM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754415604; c=relaxed/simple;
	bh=u0aNxpRLMYwkco2Uh8LMZDlR44Fbmz723HWl+xcCpW4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nVn+2oM93U4cS5aFdjQSioinNxwWuoP7tEHnTcJF4wwG4TMSlT+BR28m0oiRkxEwtJA0TiLlL4jTH3U0J5njqraWG+sfkQJFpVm6B9A9e1gedTKAUCC7AV5Yfkc3OBLttvU38K9er+DrBR9KoTiOmkCCDCX+LoDX0x5HSBud2is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8816e763309so282681639f.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 10:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754415602; x=1755020402;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oPjWOj100uzX2UDMd/tmZ3Rhr+ncHucN9RF9E77d5CY=;
        b=mVRHZURYch2yZOQkxv0iMJEh06vfjvJpr56eVea4WHE1GG9WunyirTjq81e5HADCAq
         Q95zACRlojCz+CZWmMZYb5etiXN/AXpdjBYCTKuVybDcrt34Lv3vfw7i12cIq9tLigNK
         ZPt4CM7GQyczseutcOm18eqEx8Ad/tKtfyK3bEBOhjdZ6ydAbFxGbbyTk9j0LdRExdpW
         gKKrbaYtfujIsZsJpxjxBkurF9dIi5qF0xAoPhLp/+tuqZV0vJXQSoUT8eyfogplJRek
         ekQAt89F7i5QHpdIySqiUlhgJaKWO0Hs57qn6QmENmYOkseNz56UU0OhO7Pzbyed4xhe
         Pl3Q==
X-Forwarded-Encrypted: i=1; AJvYcCW0ty1KyMk0EBZ4T80EEeGRnMwox62+svnZJrhC4MWNuKIgHJdqFHa+TAsb289OBdCD7nPqQGUt7JspxhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGL5zATI0ANmzniiF/6ZzuQvEUmHLh+pJbxByBS5XmZiCVSZX7
	UGIIVUoHIQd8/fBoSvHOIDKDJhZtYdXIxRArTl/msP/Ed40G2YlXWGI2G5Z1bn1GRwgrQv92q7h
	mk3IF17YqmVE8Ef01MtACJzI7M5vSJptf2X1SiEAniC9hs7o26dX1v6dGHjY=
X-Google-Smtp-Source: AGHT+IE1YjQQJWEFv0QU9FBdrEkga98AZRQhEf/5Ro9g/ysBOcSLpkv0Anh7QjdyOy9PnrCCWkNAovSawIUM7GjP7vJ6elCRjwsJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6b81:b0:881:419d:4a31 with SMTP id
 ca18e2360f4ac-8816830d61bmr2293528639f.3.1754415601956; Tue, 05 Aug 2025
 10:40:01 -0700 (PDT)
Date: Tue, 05 Aug 2025 10:40:01 -0700
In-Reply-To: <aea583b5-cf8b-4b62-a13a-56b8d4cfe755@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689241f1.050a0220.7f033.002c.GAE@google.com>
Subject: Re: [syzbot] [usb?] [media?] KASAN: slab-use-after-free Read in
 load_firmware_cb (2)
From: syzbot <syzbot+db4326df1b9af04f68fc@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+db4326df1b9af04f68fc@syzkaller.appspotmail.com
Tested-by: syzbot+db4326df1b9af04f68fc@syzkaller.appspotmail.com

Tested on:

commit:         7e161a99 Merge tag 'i2c-for-6.17-rc1-part2' of git://g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12cab6a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=63ccfb75e22d24c7
dashboard link: https://syzkaller.appspot.com/bug?extid=db4326df1b9af04f68fc
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=170e86a2580000

Note: testing is done by a robot and is best-effort only.

