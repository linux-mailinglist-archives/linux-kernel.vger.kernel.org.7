Return-Path: <linux-kernel+bounces-881895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77811C292A7
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 17:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FDFB188E290
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 16:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA86625A343;
	Sun,  2 Nov 2025 16:40:38 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65A72750E6
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 16:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762101638; cv=none; b=aWHB+EXxcxLBQC83dhThEeOILscDcISWC1Uq1PEDoaqw6BzzPS4uH24SJlAFbwNYvtmYeSONR5JrO8M5Ty3UwIaUcgeNsNdHms4xTPwZOv7CFsnPXg8Z6cbYMxwdkOu3GLRkqYXR2kMAsW+CdY9mowb3xzowo4ZDHBqtFCk/a+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762101638; c=relaxed/simple;
	bh=QduZi1NzE+SfK5A3e8pSAx6KVKDLFiQ9Sgyq72/8nYA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bVFkgZw1KWp+dZucuSV+nUit9eJpFJbk13iOuOGgK82L6HbYLpkZFNxxJLa7aKJYrjebCkpRqbxkGDeAkynBRsd2GK/DRsU1FtobXbw+6xAr0pZ69M/dMAfC4UezPC+SPVlJTOUgYeaJckC9VRJh+igaVGF25bdFnGcCBw+7+gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-930db3a16c9so327888539f.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 08:40:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762101636; x=1762706436;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qtCoZX3uWFC8u57cAATErVm+EHuv+gA7rZz8edZ2ZpY=;
        b=afAZYBhsYtJ5SsiYgIZ+xdJAfXTzBES2NxX5qW3ciF92KxjXPAPwDqg07wJ0oVc38H
         YCqx+WFjy/oJCzOayGMmOxkz4uN2Vds01kdltjZ6UPyODv9EPPBsNojdLrA4RrHIyRvu
         U2X65gi2vJYXTEDtyJFgPFSQ1N6O/nFhIeni/6plAy8yb2y14LCt1EFUnG2+oJvZemny
         NjLPOoOwaT7nvYZRPG9sKRo8zDqEe7thjFejlSROB/Cd77M+Xf/ALVJpNxZsNFrl0X5g
         97DgqYRLtYyV1aUrA1ChyhOT6R28cXkZ6Qzv5OTOTooo4T6D+Buoijs36Jte/ou/8ioL
         j/3g==
X-Gm-Message-State: AOJu0YxVI+ktnNZ96w3RyxpXs4m2I+BeDI+o2cJes7IvVBolLJO6P8TS
	tSEPfTjnwpq6iZyMZthQOJxFOv3SJGjtanPYDzNO8wG7kE0D5BrTFm5z4u6ar9D3NgF8I6tnXeT
	asQGV/Q4vpWIiwF58Gyjwwp8OCuZamjKIGHRCEsgQKUar734dhMFP+R3s0vU=
X-Google-Smtp-Source: AGHT+IHCBChi0Uer+J5aOYqui7semzWA7qs1fv6Wraz2d3RP49edD13ds0diQQGGnj1y1GHatoBxQnCDcsWWcH7QYCD/HSMnJfv2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3498:b0:433:2597:8cc with SMTP id
 e9e14a558f8ab-433259711f3mr62204295ab.29.1762101636090; Sun, 02 Nov 2025
 08:40:36 -0800 (PST)
Date: Sun, 02 Nov 2025 08:40:36 -0800
In-Reply-To: <69015bf1.050a0220.3344a1.03f8.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69078984.a70a0220.eb9ff.038c.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+2e6c1eda2eff0745b028@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: jkoolstra@xs4all.nl

#syz test

---

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index aae1f32f4dab..f193912d8632 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -704,8 +704,8 @@ static void ntfs_put_super(struct super_block *sb)
        ntfs_set_state(sbi, NTFS_DIRTY_CLEAR);
 
        if (sbi->options) {
+               kfree(sbi->options->nls_name);
                unload_nls(sbi->options->nls);
-               kfree(sbi->options->nls);
                kfree(sbi->options);
                sbi->options = NULL;
        }
@@ -1670,8 +1670,8 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
        iput(inode);
 out:
        if (sbi && sbi->options) {
+               kfree(sbi->options->nls_name);
                unload_nls(sbi->options->nls);
-               kfree(sbi->options->nls);
                kfree(sbi->options);
                sbi->options = NULL;
        }

