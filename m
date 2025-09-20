Return-Path: <linux-kernel+bounces-825495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 41575B8BF48
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 06:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1EB7E4E06B2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 04:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C7D212564;
	Sat, 20 Sep 2025 04:48:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E2A1FDA
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 04:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758343686; cv=none; b=TppHv2fDQovFNE3cek7Jg7AorKngPPGpaECqPggPINxZfuoASaqtKb3bBVPoVef99KDqEQ7XSSPDUfnH4SJRNzQtt24XbPJujxFwy4c/Fg6o2SmSIdk+ZxZzIbZcp9wIEv3dc1dPLxT5gOOv0v0CrhYp3Co9vodsRENnlPSMS8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758343686; c=relaxed/simple;
	bh=S4edpwgwU0msm0/rkNiWrcLi7BFXArBFH/BL3Ds8b3k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kmyH8Xje7Ms6SMKb1TvodGxni+Gnskr2IDbgTwdssyo4Dqc5zfT2GuaUibo2Psj9uRbeYgE0SeTJ7AlhnU67tKDe4yuFZ3uGw6NNm3xtjeNAT1gQitvuC9r9/Y/Jp53dV+oZuatZp0izp0CGWznygqL1Cyv//kvgRFNIf/5J2lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-4247e23f070so20925745ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 21:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758343684; x=1758948484;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+WocuQEB+RwIHIBCyiRPZIXfIWw6CMooLSjkqrtMnQk=;
        b=u9ANzmT/v60MmrL8DU2rVKvxKbwAbUIHnDC9UTz4GY9gb9BHV2wvD9mFpzIkf4Aj+K
         FgmAVwkiicH2sza2JbOhjUmxf+qXP8setPuzD6YBq+YJSBnbvd4ttca0TPtNXZWmVH+d
         zzRTdX8cSTqA89UJVXm1/cU/JuDB7CHTxHA8v2Xx30ZEGWC9NJHtkNziSjTUgxd7xrzV
         MIk6j/f/ELVp+oedpWvQoUCYF7HPE7dqon9pHqae9oB6Ev8MzHtUMabK+F04oXLZWGCN
         pGrfif6vRQUPrEueLem4WavOTpCMPrYq3L0Hu6LXcl/BU9kSJ5d5tWkouozed/mb1h38
         HvtA==
X-Forwarded-Encrypted: i=1; AJvYcCVxS+GByK4Kos/vPYyytjpSOdwyHrjn16Rjdu3kvdSoxGht4w3b3zKA3x0ZRCqAnjp+HFlmZTqYKpH+1LM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEG7qR1R/WgbOgHnGvQ+UXLVNyFp2T9/dqaqR1IDzghV+HZN/E
	fF0z340p8Tc6oev9re7FYkEYUJIYr0QFr44aUbxgf0FlQ02t/bv6qYDAFIbZ79pieE+AeVr//J7
	6QIiP/y/s4xMaAMDsfnDS2bdij2UX0ftp35VifSYztby0PH6d+UvtwLYdbF4=
X-Google-Smtp-Source: AGHT+IGyUTZ82BIMhPhlpParLn8kLi1Rtf8Ogh9l65QH03EZSP6y34+ki0FuElH+lbCKh/XvJQy6NJiwJAi12k7RyFrrZAsq6g8L
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188d:b0:423:f924:c885 with SMTP id
 e9e14a558f8ab-42481938b95mr95673615ab.13.1758343683994; Fri, 19 Sep 2025
 21:48:03 -0700 (PDT)
Date: Fri, 19 Sep 2025 21:48:03 -0700
In-Reply-To: <20250920025550.7294-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ce3203.050a0220.13cd81.0010.GAE@google.com>
Subject: Re: [syzbot] [mm?] [usb?] WARNING in __alloc_skb (4)
From: syzbot <syzbot+5a2250fd91b28106c37b@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5a2250fd91b28106c37b@syzkaller.appspotmail.com
Tested-by: syzbot+5a2250fd91b28106c37b@syzkaller.appspotmail.com

Tested on:

commit:         846bd222 Add linux-next specific files for 20250919
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=162b5c7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=135377594f35b576
dashboard link: https://syzkaller.appspot.com/bug?extid=5a2250fd91b28106c37b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16eabe42580000

Note: testing is done by a robot and is best-effort only.

