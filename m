Return-Path: <linux-kernel+bounces-837048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B01BAB29D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 05:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20AD04203D4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 03:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CFC230996;
	Tue, 30 Sep 2025 03:44:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23745212556
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 03:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759203844; cv=none; b=ogRTTA+C0fUZpSLFVzXf/Ec6TKnoRwL1fWLMvjmkUG2pLzLfpgLRgk51CtAtY8TLL1B49ohbsyax2zi7CLgerzcwGvyZZMclpFRrT10It98vuugcVK4wD2csWvDJ2K4Ivr8v7TtRL9HXua1TVzKwU33GibD30LPDMFf1mFE6s5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759203844; c=relaxed/simple;
	bh=Bo8BiOeqn6Jfar/RyM4MD4/iQCXlMPHlCpJQH68vxLA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LbGLFKnyvVfubfLH/n/BBPv0l9IovA34pHwRN/Rvbzrag029LKl/PIrCgVHio5Gc/56Pzi2V4U+p8MSn6h/E1SrlrJpqAj8yovURn66PiZiZv7vafK6k+Q93Kf61LfChLU/lCPx/GTp4OTcJVkGVxfrKhsOhGFtb4Ta1lBOzWLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-911c5f72370so440926839f.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 20:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759203842; x=1759808642;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zzqzp1MjM5oNK8h4YXTU1N2MSP8PGd8kNvh04gqEpbU=;
        b=JZnyK1YjyT6R1hEjqexgOV8k95RzAt+bMvofBoNsCOAdgF/rbmC9FsNP9ohb1I+XLO
         Oj984D7E3KDsggwviJ5YpYAhTfz3zvfjnCJ2l4yEHiqcEW3+qrCqGgd3jGc01a6fKqId
         m5ZkYa5bnle4kGE+V1bTPoa/5wdXJmEDTJksvYsPnNBSzTedVLQTsakr30CLUBlsCirj
         qt9SsXNTk6csMVJKazqhE+gUCBa0Y48y3RtjwZP/H9LT5aoRuGscJPDHn6QgNL9C1HgZ
         xGa/qIGogL4aeU2g097cyZ1rbZQXBuHUm5o9W105M3G93fvMKmntDjsCw+2rjG1qzocf
         DKWw==
X-Forwarded-Encrypted: i=1; AJvYcCWc73+cPUpn5+gG2W5WQyqygs5O+5pBtwkmu0hf8+RKuoQ74rn2w7YjDkTCgrvnyIVD30usbS+K5HQA46c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfBoDFkUuG9oXOLDinSHhilsepL82Pr0m7GwrNjp84xTu7wxGE
	cKjGivbYwZi0u5ex7+l93Yd76232PbK5f0wV/laPmUCvOkfYKNh6hxtOnPC7g1ElvtsO/SAR7HB
	nsoAgnDygguxj7A1t4wYx42FwX02U+uDlDQ9/2dPj/X5oxSerseqykQfMRoc=
X-Google-Smtp-Source: AGHT+IFaW4E3tLmOEcpglAA9EiZpRJTdwGxib1GbXncH18tQRRY+akyFHUZdAHPjbdt/aPxqg2sqf1Ds8fRFDjtQegUQ8nozMDZH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a6b:600b:0:b0:886:e168:e087 with SMTP id
 ca18e2360f4ac-9016b7237a4mr2280052939f.13.1759203842302; Mon, 29 Sep 2025
 20:44:02 -0700 (PDT)
Date: Mon, 29 Sep 2025 20:44:02 -0700
In-Reply-To: <tencent_E5865E49816ED4AEC2CC9AA7DF86CC12E706@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68db5202.a70a0220.10c4b.00e6.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] KASAN: slab-out-of-bounds Read in bch2_btree_node_read_done
From: syzbot <syzbot+ba71155d3eacc8f42477@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
can't find file to patch at input line 5
Perhaps you used the wrong -p or --strip option?
The text leading up to this was:
--------------------------
|diff --git a/fs/bcachefs/btree_io.c b/fs/bcachefs/btree_io.c
|index 590cd29f3e86..ab14fff1452f 100644
|--- a/fs/bcachefs/btree_io.c
|+++ b/fs/bcachefs/btree_io.c
--------------------------
No file to patch.  Skipping patch.
1 out of 1 hunk ignored



Tested on:

commit:         30d4efb2 Merge tag 'for-linus-6.18-rc1-tag' of git://g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5b21423ca3f0a96
dashboard link: https://syzkaller.appspot.com/bug?extid=ba71155d3eacc8f42477
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16afc334580000


