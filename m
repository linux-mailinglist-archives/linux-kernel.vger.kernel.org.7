Return-Path: <linux-kernel+bounces-733618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C168B0770E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADA1416CD27
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722F21C8626;
	Wed, 16 Jul 2025 13:32:36 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981C119AD70
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 13:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752672756; cv=none; b=jmLTvMCIEz647+Iki6UWaDfoMQz5Th4OomneAMRqJApBcIMQcyuV7N/Qxvjp0Rx8I3hTH/LkEqsh1UrGdMl/82sAqVWWR7XPLF6TQmbQSiMUKoB3TvhQLf5fR9pUnegMTFq2qWPqICyn76p8QYYdxT2ratC3+/OTInbisFYCVNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752672756; c=relaxed/simple;
	bh=s9wiVqEv7FVGkYWryVhcyy09SBRSex2NkNIE8XwhuhA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=euyc41m1a9zieByvK5tHrAzPWt1V0dQrRzScYBjOmKtinyFLBdAbd5oRCcksbmq+k+VxGFSfNRa0PUxVTja+KOD17UW8BC4MLwrLFfCK8HMvDblggVyS2lde/bkF9Bo0gBhZjjIr2UWU4701FM+PeGWZDnzeasYHHxx+m2p+Yhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-876afa8b530so704615439f.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 06:32:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752672754; x=1753277554;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vgn0xmZHthjgAn+KnHTiASDgddPV3bcpglBCZEEu6ho=;
        b=KiURNVvXTJ3i1AhXxbVs0kuMomM8eW5w3pEDpVfMM31ATy5LxdVp4nAjKRBIMFPkSG
         TN//eV22r2P0eLccwjIZetRdYBt61rI3oPsEkdOM3XxraqvUg/xgoEARQ8cGV03wk5Vo
         B0y6tXDioFeq0pGyfUxHbpinqF6AE3dsW5KyMRm5sxEetWg2bo8oM8GLFogXCUAUqfJU
         kvieE4PEgcFwonqnp8SskXged0acjw2ya22rvpURCQBWJErIN9dtj0uYvurYBXeNHzJc
         DAgHR2eAbtpS0Mppkf3sRW6TcBGdg3DTi4vgnJig+T9vU45TIKCE8IF/hrcC0u4mtxyH
         BFKw==
X-Forwarded-Encrypted: i=1; AJvYcCUtvzYd+CDORfaBuyYpx/+74ntRfKTj+BxDRwCgJU27lALi7Ea4Vycj4PIE/U3Osb+sSZZh2aOQd3dLQ4A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4fDEePe0nnILTcM03tqthuxQLALJ8yGG/ekoEQrBvCjurzRA8
	6khiQ2ppQ4KeOWZSLvL+9hawwu0fxZNkwqPy1bX2G3ruD5O2BfbxO5pucPZw/UOMptDTI0SrRVC
	PZ+fWTaLFn9W5mU4Oe8yq64po+ZuvpiFquU3Tv1hsicp64X9A/5xzChf0soQ=
X-Google-Smtp-Source: AGHT+IFvUraherRgbSXurdx0AB3q8qotMgYb4crkMwuuEZWe8rQcFQ8GHsUQ4Snofe4k92Zo4uae4RrXhBghxCWidt93CgRfeqtR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:36ce:b0:861:6f49:626 with SMTP id
 ca18e2360f4ac-879c08a6572mr432116139f.6.1752672753754; Wed, 16 Jul 2025
 06:32:33 -0700 (PDT)
Date: Wed, 16 Jul 2025 06:32:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6877a9f1.a70a0220.693ce.0029.GAE@google.com>
Subject: [syzbot] Monthly v9fs report (Jul 2025)
From: syzbot <syzbot+listcbdb3965d35bcd9aeb59@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	lucho@ionkov.net, syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello v9fs maintainers/developers,

This is a 31-day syzbot report for the v9fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/v9fs

During the period, 0 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 37 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 4792    Yes   WARNING in v9fs_fid_get_acl
                  https://syzkaller.appspot.com/bug?extid=a83dc51a78f0f4cf20da
<2> 1167    Yes   INFO: task hung in v9fs_evict_inode
                  https://syzkaller.appspot.com/bug?extid=56bd5818697f0f93fdd9
<3> 916     Yes   INFO: task hung in __iterate_supers
                  https://syzkaller.appspot.com/bug?extid=b10aefdd9ef275e9368d
<4> 80      Yes   WARNING: refcount bug in p9_req_put (3)
                  https://syzkaller.appspot.com/bug?extid=d99d2414db66171fccbb

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

