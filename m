Return-Path: <linux-kernel+bounces-825355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 458E7B8BA5E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 01:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 038A35A70D0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 23:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF942D46AC;
	Fri, 19 Sep 2025 23:56:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E58417A2EA
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 23:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758326165; cv=none; b=CwESf47szR2TFVb2mQFew9+L2yLVEfjiDbJoFjltEnV39dKFYje+hbGeSjVrj+soI+eEYBLB+NJN38CkwBF7NZxCFmC4a7gyE301Tj7VoN8JBuTvY7HZl5ksb3ry39CZG962WminWO0jXvZAwej68DEYyjUScQHR+B2xIEpCdN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758326165; c=relaxed/simple;
	bh=9X5R2goBB8jp1Nriv9LEMzB0pYDuwx/Wb9x+QDf29vM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=j7liEPFUeU4v0hs0EC+YQ2+o7+aoxVukgJhnx6bWsRDHH3Wg6epu+kQvKg+8Qg5CsfWwUDINIEadKXzvH4j02jKiWJD1o/k0ccRb+R8Ic5j/CQgy0FQnI7GvpclYVnXNS5oUByOwcLbcR+EOcLAcRogGbnEtEaRYuNbM+XtpcaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4247661a0c9so29051015ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 16:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758326162; x=1758930962;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dLpxAsq3TAKmv+q8Abaa/51h1lJbJW44lPcHIzBtNQE=;
        b=ayedojxRrftwNQaySN90tbKsxr50jeRhW+WeYmotVFSzU6yVS1Ehwk2s03KnTT02E6
         J/ZD6xnZb/ctzbDecaIq212NxRFZDz9QlsSh1Lqo12GPp3HUkq+3E0wvCbGqMcRTSnRs
         WjZPDhTLbr1NS57hvsnLy+IFbDTeBQRk8rNtMty6hQNJ0YpjOriR2jh03bafupI8BPf/
         PktZvzoa8oXZJT+LTNvKZJFRPuAtuohbjAvq9ITgRnHHpveAj+5IuGUKxJ0Igdnpuv0Q
         qDSgur7ShEZwE1GuVaO/OaA7P/4k30d8evC/hbEKdprCVYheSgyu2CSyX2pza3BCoqKM
         8cYg==
X-Forwarded-Encrypted: i=1; AJvYcCUfmnmRR2LIxPrJ/GwlZD5vlaQF7hMCWINkE9PPhiVW0g99yHmdvwFoVOVpE3dTYcJgXkEzjEyhYecZALo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLC7Sa/euEr94o1cMVgnWKYlSVXLhA0LxAdPeIZqAdxV4bVLSJ
	qeAE4k8b+GdwWfRlLihYiKPpGvyhtxSJ+yp2s24/NutqgeCheYcxVPCsNvP2AIN/fR+PlTs3i9b
	eW+f899W8ZzqBNcoDCVnF2CkyRm2bsyYGHPt6rsgt02zgiPuaOJXWOKGMyJQ=
X-Google-Smtp-Source: AGHT+IF5B/2JN+uZpFWbtkAlBXZY2igI8ZUoA1rETn0NiN7NgiahSs5RxpeXjnj30JegUBlCXuwxs+NRe71rK3AnK6Q8Qp4Yas01
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:168f:b0:401:9e1:ce68 with SMTP id
 e9e14a558f8ab-424819298d8mr91424615ab.13.1758326162465; Fri, 19 Sep 2025
 16:56:02 -0700 (PDT)
Date: Fri, 19 Sep 2025 16:56:02 -0700
In-Reply-To: <CAHxJ8O9EHnwSkBNOmBOEg3GvDxcnqsQ5cURd+uG8G2EvUcXYfg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cded92.050a0220.13cd81.000c.GAE@google.com>
Subject: Re: [syzbot] [ext4?] WARNING in ext4_xattr_inode_update_ref
From: syzbot <syzbot+0be4f339a8218d2a5bb1@syzkaller.appspotmail.com>
To: eraykrdg1@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+0be4f339a8218d2a5bb1@syzkaller.appspotmail.com
Tested-by: syzbot+0be4f339a8218d2a5bb1@syzkaller.appspotmail.com

Tested on:

commit:         cd89d487 Merge tag '6.17-rc6-smb3-client-fixes' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=167ca0e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5b21423ca3f0a96
dashboard link: https://syzkaller.appspot.com/bug?extid=0be4f339a8218d2a5bb1
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14551858580000

Note: testing is done by a robot and is best-effort only.

