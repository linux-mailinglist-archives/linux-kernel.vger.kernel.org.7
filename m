Return-Path: <linux-kernel+bounces-842965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D8FBBE157
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 14:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77DEE1896694
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 12:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316B228136B;
	Mon,  6 Oct 2025 12:47:10 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600B61F8755
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 12:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759754829; cv=none; b=uTa94kjuO7qMdfa2CfiiMd4/CLk9f0iIhXtop7zHqrGgfsPEbISFOJXEh8VENlek55tVVeGj4ohM/RcW8doc8LrBkNv6F9PwAtT/d6eWoYYe1n+6a3Qa0+/dg76oO45z/eFV8c+24BReOTAB/L1A6kEJQTnrdRbg8oPEDz4iUzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759754829; c=relaxed/simple;
	bh=kWqOLnSk7aKG9iCb7b+4gAnUgO3Q7oXM/TKDVH7itxs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WWdM7XNnmNHciwWl+g5+d+Lcrkz0/W+66SgoVyie3FKKDnZN6WvchbjMbYlybNxm3u0OFqPsx0KyOPVm5ewf3yRJqhvBEtcHw8u0bDcklays90CE7Fp/cS5ALCH8v230sYHmS5oim0Mn9Lagosy9nA4jS0ZF1PlRC8+/okIdexU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-90dfda98b4bso1265609739f.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 05:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759754827; x=1760359627;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kWqOLnSk7aKG9iCb7b+4gAnUgO3Q7oXM/TKDVH7itxs=;
        b=fJ8avdD2kpm6pipWdrrGRECA7YewUrLUc8eCdRiUYixBCC5gs0aphwMUICjK+caX88
         /NQb2b/vs2vawsVWhMjrZDW5l5IuxtkxGAHrpSimOPTo1bqPdwHabjxJ3U8FKiM4bol6
         p9QxrxZcEIMJsScjK8b3hZ46oTldUX7mfW9cu734kzNwrzEq3ql/yP+sCVcuaKVzLOhc
         ArkGwWN2IcDryi2LZ1T7jBRbhdQm1FqIV/8x6bG9Zg/C3HwARMAXRyjlq83wDbUXyrk+
         yWEuqtXV/xPPkMX4FMa0MR14iJkTSX1G4L5JHr6ocFajvUnh3aGgFUl82pLo9+rytE23
         CExw==
X-Gm-Message-State: AOJu0Yya8SKNX2IKEhR4EQFN9xD1AqgdZhgNyI7IXqdhLpE+W0pSDo4k
	XedMNXTsj2gnhpTWAOUFSAJa32fAiUP3tH/diD8neHiig2hvg6FTP8M2Qso1va60ZXG/w0akXRz
	EnOU2hdiQVbZCY8BhiI+5gNxpgWIRwhEZ/RWt+pkEm7qCRzMWSHoZQPkyNH4=
X-Google-Smtp-Source: AGHT+IF1vxg8R1nOkRYSLmyZd1eYnV03HJqSre85lRxdi3A60Bpnixv3Cd2DGo3UHq2azPZhpXSw8hDiZuINbEo46nqpp3ZrmVaw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa1:b0:42d:d4f6:1128 with SMTP id
 e9e14a558f8ab-42e7ada8ce9mr164790005ab.26.1759754827529; Mon, 06 Oct 2025
 05:47:07 -0700 (PDT)
Date: Mon, 06 Oct 2025 05:47:07 -0700
In-Reply-To: <68e2ffd0.050a0220.2c17c1.003b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e3ba4b.a00a0220.298cc0.0461.GAE@google.com>
Subject: Forwarded: [PATCH] fs/ntfs3: fix KMSAN uninit-value in ni_create_attr_list
From: syzbot <syzbot+83c9dd5c0dcf6184fdbf@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] fs/ntfs3: fix KMSAN uninit-value in ni_create_attr_list
Author: nirbhay.lkd@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
master

