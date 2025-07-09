Return-Path: <linux-kernel+bounces-724070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CF4AFEE3C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F3DB4E5038
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6022E9748;
	Wed,  9 Jul 2025 15:56:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103F42E54C2
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 15:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076565; cv=none; b=f+MHpiSRXTyXs4RL18QrQGdwEyrFuNVYjNQGpOQWnkcjzDETwHs5x1CYjNbqM/xwWtn+SVv24a6oWKRRlDJ7tXdYNTIkqtoKUiM0VKuZ1Gbu9SUWb+CfQI39a6nh33y3Ti6+HNQ/CcPmO88cqSCvsTrkuSDgkgtgs1PmNNJ9JAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076565; c=relaxed/simple;
	bh=Klhcqa0zXjE1jMAuczJtOID00nhS1/VKgAh4s0ac6qY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fnb5iPemzy/11RVlbDoZ/DifXeW58lvVSUcc7y6hjQewg6+LEU3hgI6fo5Jnddvy2iqP1BYFKgfVmIGfy10C4xjq2GA3kyKMxw1jC5/haY677xNNQBkDTBIVLX+mX/28lXVNCN35vEEDQssg6BxrOhHrN+zUE08k6t4P3s0NQWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-86cfea700daso10364339f.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 08:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752076563; x=1752681363;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZA6788H/o3UPwVHElcOp7R8jW6eULSWFdSmHy0kTRYk=;
        b=JkQDp4FRUg1Vs7BYvjEcZ6p2a8gJXpIXIEBq2Ytgfy+lNFGaku22oiccACImQcb2dX
         y5pcydr4DZ+X1qgQ63i6UF7bDYwSVTRGiRz5QRlgVnhidJqP1MXx4JNS/fpIT7Xmy2Ie
         ZoVdjMBJpaynmokGqX6x+q+yWF/1vyABIbsp/29odvEDXFuzcBE/IsKFBcZWQ3mNgHjL
         lN3iJ9xepAvozBzCHXk21s5u5u3XF9Bc1l26h6tjgBvIkV+7uMAiWQ8RTPp2tq/R5BWy
         qwmn5/RzL3YY1LSZQd1dLEQ2yt2jQXAMPuqriHC1PkGwF0dMzyh+kUvf4FFyhmYdYKkR
         kPDA==
X-Forwarded-Encrypted: i=1; AJvYcCXqxaQLUF/f6WC6cLjlLdLl2nMT/B7KDDUvcLK8uNE1Mm601OLbDT3FtrELNOKqjJNkpVXDWpQ2eZ8zdSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVkImC8J+2MZwYosmtofdepfyesciNGeQwwUeuXRNu8v1cPZ+l
	1r8ww6X951y+57LEcItqvZmZe8C6ho42QvXvj/SgqLwp62eYr0fALFziK3sInUIWODwTku73JYh
	lN/8XX0Fq/k6LPnke+T0hmInHJr5HaSyeXKiFqYneznPxxT+sBu5YgXo4QRQ=
X-Google-Smtp-Source: AGHT+IHMYgVqoKgL7WaXTj2pN1Mdf52GVHjXjp6h7wMS57lXGHBOyXymkA/DWtdO3E5Hq+lBFpPsgwQ04QJsgHUr9H+vfOMSG0RG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2dd0:b0:86d:d6:5687 with SMTP id
 ca18e2360f4ac-8795b0c7254mr416874739f.6.1752076563029; Wed, 09 Jul 2025
 08:56:03 -0700 (PDT)
Date: Wed, 09 Jul 2025 08:56:03 -0700
In-Reply-To: <5644bdbc-8449-407c-8e0c-e725e10a40f1@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686e9113.050a0220.385921.0008.GAE@google.com>
Subject: Re: [syzbot] [usb?] KASAN: slab-out-of-bounds Read in mon_copy_to_buff
From: syzbot <syzbot+8258d5439c49d4c35f43@syzkaller.appspotmail.com>
To: bentiss@kernel.org, jikos@kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+8258d5439c49d4c35f43@syzkaller.appspotmail.com
Tested-by: syzbot+8258d5439c49d4c35f43@syzkaller.appspotmail.com

Tested on:

commit:         d7b8f8e2 Linux 6.16-rc5
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=1155ebd4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f51185bd4f40ad44
dashboard link: https://syzkaller.appspot.com/bug?extid=8258d5439c49d4c35f43
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1113ff70580000

Note: testing is done by a robot and is best-effort only.

