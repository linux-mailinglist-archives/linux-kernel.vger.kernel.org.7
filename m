Return-Path: <linux-kernel+bounces-728875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7FBB02E50
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 02:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FFEC1AA3A69
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 00:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EB217BA6;
	Sun, 13 Jul 2025 00:43:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7094D2E36E5
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 00:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752367384; cv=none; b=ck3d2FfdiwPYf8Hcc7e7OxTw65zRCpGemumsgPSgkFKlDuU/70ehU+W2WNW63Ab30xjDi2eQnU50zSskVXfXVDG+yBloO29MkqQt39DrmnQZSPx4T026jzuPFpuo6X8djpCGVCU2xQzMhQtG94UzG6fuTdg8FH1U941rNEXAajo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752367384; c=relaxed/simple;
	bh=fe/Qba4s+sPTmxqH807ScgXqIUcBj+hKu3wiSHNcoTQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GKjiuMqQXH3gkBLuuOBHg92hxXTEmPhBuj8h4s7yisgtVeAu+LpIRAIIcEk07J/btrDiq0YocFCJ7mh7M26Xc7ECAvyqNwyxRYz2xeo3bX8UIK2KUjWDPJUHgsXD3WVKcO/LeYG23m9EylE+ZlNS7pJXKwopSrwx14O9eD+MfxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-86cc7cdb86fso346990839f.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 17:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752367382; x=1752972182;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MI1fvt/QGrdXbGLCQqvrZE0a731Mc5x2hIX2WjaPahY=;
        b=ekRSCOOZJmdDJEb97HhRm0vJiQNuVPNYT9JylOUU+aNkvbpNHg2oPs1GpeJnCsVGGV
         MkYf/7EzhrIcD0+u6vqeI9EewgTcxoVRQGtGwxwucmgKmQ5wVvs3p9HyUVL0ss7hySBF
         1NQj0Em1VKHnu7Ypx8TgStY2xT1iZr4wruvGYLaa/Vvjveu9rnhTpyKP2Vq4fdkfSvFU
         IzKr/0nkrV0XdNFG5PIJoRYTFJarf4tCEmZujwxXLSvrysA955fijZm/dCHlhPcpCMTV
         UURYIDFz9QBCqN3M3g7DfTQXfrICxsP8obZkJatCKo6k0fTpUi8AkiBqU7plOsCs3wgP
         SRTg==
X-Forwarded-Encrypted: i=1; AJvYcCWOvL1/SzGyfg6tzqYa8tOINIlwCOOe2zfoJTqMu36DzaNC8+jckFFn9fTA/HPQEyq9iDNlEke3ICrKcnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuAGTtlgKF7FU3lDtV3uLeQ8OZO5e8yFw8OVc7nxwqRVSGWOat
	U/4FI1CBCPviaqEY77h+I8W2D9nYIt7Y11S2Gy3aO6G2hP8/5r7vo4KKDuKY0muJSxN3/APSL0s
	TYZnwXqTeIDlclokVPgkEEjiIrCMc3MpI6JOGWEF+7pgnI72utAXV0gAXfYw=
X-Google-Smtp-Source: AGHT+IEYrO29lQ0icQg/NGeLiJ1QsKD9q3vGMpXk8kBMJWNev/khUD6GXNHwphdIYd9/QbE+avHXd0wySkpI+A5fQJsg6J5TdW/V
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1343:b0:873:f22:92fb with SMTP id
 ca18e2360f4ac-879787d3c3dmr875699439f.1.1752367382611; Sat, 12 Jul 2025
 17:43:02 -0700 (PDT)
Date: Sat, 12 Jul 2025 17:43:02 -0700
In-Reply-To: <2154988a-c4c5-4ae5-a6d7-475fdefa7576n@googlegroups.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68730116.a70a0220.3b380f.0017.GAE@google.com>
Subject: Re: [syzbot] [kvmarm?] WARNING in pend_serror_exception
From: syzbot <syzbot+1f6f096afda6f4f8f565@syzkaller.appspotmail.com>
To: kapoorarnav43@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file arch/arm64/kvm/guest.c
Hunk #1 FAILED at 844.
1 out of 1 hunk FAILED



Tested on:

commit:         15724a98 Merge branch 'kvm-arm64/doublefault2' into kv..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git next
kernel config:  https://syzkaller.appspot.com/x/.config?x=82bd3cd421993314
dashboard link: https://syzkaller.appspot.com/bug?extid=1f6f096afda6f4f8f565
compiler:       
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=153d90f0580000


