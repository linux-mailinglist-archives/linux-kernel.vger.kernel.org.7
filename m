Return-Path: <linux-kernel+bounces-644236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A024AB395D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 15:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2681D188373D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 13:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB500295510;
	Mon, 12 May 2025 13:34:30 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127FC3987D
	for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 13:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747056870; cv=none; b=PqNnNSDuZTdODAt/hXo+jq7VimZ/3b4HGyyuUV3tqolsh09QdHE+bo5APNGX2XOEmhjz+Zr/FFIHq1DRAtnvvDKNkhjWAmVhdPLOePpVaal/objVi+TsVgUDrgPgO1A2NziWxsNJLAq+58ho4dGhjh7zs+nJFYYoQSZpWmunIEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747056870; c=relaxed/simple;
	bh=4Vv5Yavxgz87k3KuWmpKhv4WsaWKlfAaBZkeX599/AI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=b+IZK64Ql+9GmfEex/HV+a9BuLxtIBjH1oR83qoNduJC7NV6v2RkW4c6BA1c7NefhOfjRRPUU+oNza+gxyOhXOw22aeI4R4rBY+cd4/nRpXtgzPGC9cTT+xSAZkVR1ehnJjCoaI34Br9T6dn7L1dPmPdS9imkofbtv4TjPnzhnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-86465e3f1c6so519396539f.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 06:34:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747056868; x=1747661668;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z9j2UdJGB9ncPUm9WnqkIs+crKjDK28ACVt9UMi6y/c=;
        b=L43g89OqXJm4YP6GLKS5Qh7boqkqsZBcoAGuPR3X4cXufkAdFBFpQpDJDcviJL26c7
         dueYHhs4gkKywb/f67SSAwOn0BaHS4Rnrq91jskczeU2GXuYRL82T2NueqPF0GiDmW/J
         LeSsRQ9f24silHtPBklZL2l0dAuJvM40IPFUrPo38RpD0r03BmQAxwP8eSxUtZwpOr3f
         ko0Pcqz3FshIl0xb9pCIcR4/Iweh1KdBwSr33tiVg+0GfNSWrxOJiCWzaP9c3sEHhtj7
         uhU4pxssq0p48KUQIX5efeVrLppNB6K4nfRD5iUiIFZeukxqsFZaqQzghT6ia5w8wYCz
         RkUw==
X-Forwarded-Encrypted: i=1; AJvYcCUUF8JCyJwZuRk9PZ4pXbmBEgTunb/ACI1lYaIyAQuvCeZJs9xto4N0OBocgZD/sxlUlMtY70Lk6TNqThc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrsneTH8h64Oz3D/EqZiCjSgK5attG4vFJXah0hrJO7k9FidEQ
	mZNayG+mHAzwKI6X2L5gu+DVOUvemHcGXyujVTVteppCwYm+S/P4ksxYmqD1YC9oF3/NCsf+iDN
	YHI7D0ToRKW52TzYNsmnyTifYM8f98QVqVcHPyuiiC9yE0peIao7aM68=
X-Google-Smtp-Source: AGHT+IHHriIn233CQCM00NI3zG6RxV1LoxUc7TKJ43olQ7KOLrk7exRKx9VgDgN+GkhkyaOpluyPTlV/aeUW3UE5tSTki/ffnh8X
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2612:b0:3da:70a8:5b26 with SMTP id
 e9e14a558f8ab-3da7e2b03dbmr135754495ab.0.1747056868146; Mon, 12 May 2025
 06:34:28 -0700 (PDT)
Date: Mon, 12 May 2025 06:34:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6821f8e4.050a0220.f2294.0062.GAE@google.com>
Subject: [syzbot] Monthly kvm report (May 2025)
From: syzbot <syzbot+lista6f7ce0ccccfec4c13d0@syzkaller.appspotmail.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello kvm maintainers/developers,

This is a 31-day syzbot report for the kvm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/kvm

During the period, 1 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 129 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 506     Yes   WARNING: locking bug in kvm_xen_set_evtchn_fast
                  https://syzkaller.appspot.com/bug?extid=919877893c9d28162dc2
<2> 6       Yes   WARNING in __kvm_gpc_refresh (3)
                  https://syzkaller.appspot.com/bug?extid=cde12433b6c56f55d9ed
<3> 6       Yes   WARNING in vcpu_run
                  https://syzkaller.appspot.com/bug?extid=1522459a74d26b0ac33a

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

