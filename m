Return-Path: <linux-kernel+bounces-866622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB493C00415
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59D21188AA79
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798D13081D4;
	Thu, 23 Oct 2025 09:32:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964E93081A5
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761211926; cv=none; b=bHR4gMBTgtv65/dM4t1oq+TFEYKOQysTgSUyl0o0FXT9br0LCEYGGxbarJHK0etsXMVyLfkR3P2MHUiA8UX0u37Qhpbza/QTifEWSvkJeMdNFPY0gfXK3iLGrXSWo5GxRPAQca/AANkQbsrwtnB5eJjbp4e42YQsHEFMAAnG+Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761211926; c=relaxed/simple;
	bh=+6slzJasBPgf8DaQYB9nLQ+CxAn3jBPfN2anMtXIJ3M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ke6qBnQ8tzYkY5qCUe1qVuT1eYAZ6inzMgPp7PoS3S8A6pH4XdrbeGZ2tvRXDNLYNa8aSSQnlSVQcAFct/Z8V8hP+FLMZ+9jq/SY2Ak+/GbrY74zdev5mc4zfk7vxGtqHhI2G5PmJzgOfFQp/OI93HwlNlHMwW/HCbBSaxYOctI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430db6d358bso28603055ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 02:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761211922; x=1761816722;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tHmLM4WYoYQHrTqyhBDObKTnjVI5RI6oZmd0aefTWp0=;
        b=SSdWo0VubvTA7luwOPnFP7pp0MX6zTA5Pbnm7KbeHUpT7piQqoDn/RlrdllnG8ILyt
         PrIsGepbh7rBKOzjDbbBIc6J4/QVu3hsL4DZDLuImCnqfy8XKl1pqKn+TFB2WgCOkSYX
         SJ0vbLBV/7oHSez7BUT6S9PYp0EgxoAGE++9o/Br34dbBmGU6dyRMUANjcHT+9Qx3VEv
         t4ihIr3+Kc8lHEZYmiVM56CGzzDmJhli537W2InFo3BQNOMTJChoZATrFh/FqjeN8mdf
         U0U/CUgM0a6Mc7IF33ZfaU1LsVxl7CkwK69lyJ7bt3j4PAGG+onWTEe9Jx4Txle9LDU6
         mwDA==
X-Forwarded-Encrypted: i=1; AJvYcCV2lLOa74wttw1R1SX3tW8l94hf+McApsnrl2wynq6P+9X1gHAbdrgmL033DtUqCjIJZGG4GZuzirFvH0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAzFjPh6pJI5GrLUwigAuy+KTEowckP/dhEXmI8yByCVRegKNA
	RdwAASlqVOVJufEmiXMGdy3GveawoaAr61MxkaETZPnKAAUld9ZFczvhZrGoPcV4eUAoorsGMdn
	HJj8D2LJEQaVrwaxYDpflFHAh6gKOhs0nB0aGExqpur+NoCdux5LJRfrfh1w=
X-Google-Smtp-Source: AGHT+IHOCbKdQcMGwtjKgyN1gYWRl+Nc8j2CNe9gcve7GieRBMlg4Ry4pht7y+w7pRm+PcZvHZs8NDo9l47kdhq64kyi5LT1oAeg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3c05:b0:430:ac49:b3b1 with SMTP id
 e9e14a558f8ab-430c5247174mr390187105ab.12.1761211922679; Thu, 23 Oct 2025
 02:32:02 -0700 (PDT)
Date: Thu, 23 Oct 2025 02:32:02 -0700
In-Reply-To: <CADfthj2Ycc0apak2Y_fpix4SWhLT9Xq89pJ=gCENGrkv1R++hQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f9f612.050a0220.346f24.0074.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] WARNING in ocfs2_unlink
From: syzbot <syzbot+55c40ae8a0e5f3659f2b@syzkaller.appspotmail.com>
To: albinbabuvarghese20@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+55c40ae8a0e5f3659f2b@syzkaller.appspotmail.com
Tested-by: syzbot+55c40ae8a0e5f3659f2b@syzkaller.appspotmail.com

Tested on:

commit:         43e9ad0c Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14d8c3e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1215729170d20fc
dashboard link: https://syzkaller.appspot.com/bug?extid=55c40ae8a0e5f3659f2b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16974614580000

Note: testing is done by a robot and is best-effort only.

