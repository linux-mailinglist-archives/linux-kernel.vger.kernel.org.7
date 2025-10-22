Return-Path: <linux-kernel+bounces-865916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D2596BFE539
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 23:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4A519352DE1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 21:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9794E301027;
	Wed, 22 Oct 2025 21:36:08 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B7C2ED165
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 21:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761168968; cv=none; b=B4/IuOl7NWU08LgxYm2I2xyeRLyzRJ27dl12Nelsw+c6fHCsi7PCIkh9NJTG2jX0z4DMtS5ZSLbF4fPmd5vu/yUGQ3+qmoP9UeM0mvtItrOmYlEPr4UUKqQSuVrolaJrczwQMJjeVabqw2rr0ojD3sQm+n5b71tt7V2gg3OmCA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761168968; c=relaxed/simple;
	bh=Cp5gMWn339G8q84Z6K1dTIcIIdRpizjSb41WLZoDLyw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dHezqt+obQYlqGP7Xrt1/Wrw1Kk4BKD5BDYPX0zOJYb0fXdNCyjwRsg6LeTNTI5iv8N8KWaNq91S7yv3lLJMRnipRmqi3ATJAgXeXymWntggrtpdMDIxZSClEUatnkpH4h6zEIckQ2l3SCunRzzdYNFsctGxWMjyekW1VoyxI6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-940f5d522efso13207439f.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761168966; x=1761773766;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=egPucBdyw7Mvi1THNQ1+AU8O9JwrCUcN/CEpCiTlyws=;
        b=KNmF3E0T2gI6JAhonXfMNU3rTpK6gnX+bHVPrNI2RYO9TWKghWVLkhNGMkszPEQYLa
         NoaRGsysNDWJUOBWrUYVLEBfy8JYrwRKU8WQCnIDiLAnGy9hT1y7Qn+FsVPXYuqyyv4e
         zQBbn1HqgiPhEB87mmHEfjHm4SnZo4cKy9zflJAmJ7TQCCcL8gUI6D/9tR2V+N7aBMw7
         5pkxKSI76q6lWzxZAkSG6V/D6MOKq8Atnq34BCP8Pa67pGG6Qw7jFixw5G+gdWafwSEm
         rHLNvmhXNXpOKqWjY43TnNxzKTizd3R33Wo+YIg4J6JtMIxDSQQ//XnBKmauVuPOJXZc
         qf6A==
X-Forwarded-Encrypted: i=1; AJvYcCX8oVXFw4LQj7pOuFupt03Vv2R4A1Y2iN3jg+7JQ3DgKXllCdvjSRPPUAK5ejWEEObVASth/9DMu5s7UnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkFtgBzKX2x3eM2XXJ/LQEPl7vwOQFknIoQDqn2kmlVY15eXO9
	8Y1xA5TTIbIABYad4CHuZo0SQl4m5H6J87mCYDmkUUTNerjAmd3lXXCtX7qf/mDxfxLmpmJhjtx
	TS25wurHtILZL0vd9jLipQ6mTH0sDjZJnnjX5jz1MVdkgjDeyhQzuj6FRJVU=
X-Google-Smtp-Source: AGHT+IEUNXixGrchG5I4xEMJElbwu087bCs0O+pXqtumbzQilmjE0sLy4o77/MtmRPnlBHkwbxOUsom5ny3AkYZxpIo1zGTQx2rp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2144:b0:426:2f95:31a5 with SMTP id
 e9e14a558f8ab-431dc23243dmr3735555ab.29.1761168965854; Wed, 22 Oct 2025
 14:36:05 -0700 (PDT)
Date: Wed, 22 Oct 2025 14:36:05 -0700
In-Reply-To: <CAPqLRf0ab_gT9w9gphrW8TnNdPHsQErWP4Aqen8o47OqDrEOrA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f94e45.a70a0220.3bf6c6.0028.GAE@google.com>
Subject: Re: [syzbot] [mm] KMSAN: uninit-value in sw842_compress
From: syzbot <syzbot+17cae3c0a5b0acdc327d@syzkaller.appspotmail.com>
To: kubik.bartlomiej@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/ntfs3/frecord.c
patch: **** malformed patch at line 13: diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c




Tested on:

commit:         dd72c8fc Merge tag 'platform-drivers-x86-v6.18-2' of g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=35c699864e165c51
dashboard link: https://syzkaller.appspot.com/bug?extid=17cae3c0a5b0acdc327d
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1131f492580000


