Return-Path: <linux-kernel+bounces-793990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BF2B3DB3C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75CA7176483
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 07:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA6626FDB6;
	Mon,  1 Sep 2025 07:38:35 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4286026F2B9
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 07:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756712314; cv=none; b=BLYnPLrmACs5VIpN3GQP0iStUHLT4JSd14B9OfGfYfJWeqIsiVdYywdIkdRHpPe/hwLipf02TMjzXiBQ2XYnoIjoOr0H+l/hmirhUtp3CzdWG1Gm0FN9sewToLG2bU4ESxANvOnok3NAwp/u2CP13ZmtGlDTuiIs5aNwqm2BShQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756712314; c=relaxed/simple;
	bh=sQQSWSV885Jj7JQz8gNeil7CoEvnftgq44GNzVub6YY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=V0YVS7BPDJyFiWxocp+AKeqe51vlgZ0zbtwbMIfvd2DqiNTAx/g//JQZaHLvLBpVLCqO8dnzfOaduwXINoHAMXzEFxueaRXfXL/hxW01eW7lHsXqI28KJND6IApH9x1Pmc+ds/w+VgVhCnpZ0uD/s17BEqJwvK3L4MvY36g+caM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8872c4cda51so96577339f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 00:38:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756712312; x=1757317112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v/UJh+rH1Sl4Vn0nGhSgqQ4p60qWqfFhvtpOqby8hKc=;
        b=OQ0PbNqo4D3ip0C4D2Mmh5YQGyPIePcgGKgzOzeRPOeCzp3fNQD9V0MsrG72lNK1YV
         YDNL3RXgnqWQUisQey96Ap7RRE60hhzdSlhcmN00PzLAwmuzYJduk13Fe9l8COPLFYdB
         oSNnwAb+kOcJ+CQmvg3kBqBedmTPAFSVqRpBAUC+VDkUbpJ175Q58h+ncWTWAAOGUkyN
         WaSux+dw7QS4xVAKljW3rOmt5D6fnR9MlC1QY2fywawyl4GAf0tzibJVABHfFbd7FEeo
         N9MuhWnV/zKxBKX5TpxpGN9hfuNs/LACdeufuowfDhzQbFB/5vOQxutjfjSX5XJzl4Gr
         cvYA==
X-Forwarded-Encrypted: i=1; AJvYcCU9DZ7L3w8XsErMpUE16VCy/7VMVg7WJMaF8VgLFDTDTHZp5r86ctao1eXdvOBvQWbUtWl1mhiFJWlsOdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiKT0ikGa1V8SKRZ/nZ4HHbMMW+tjDTgndaCPlXQu9htnySJeP
	05aRHnjdP7WENGg0r3kxfa3L1nA5z+8A4eOm5zEkrVFUSmdhWyISTQNfgwGOpf5uW+QbgipaPd8
	FvJDAZ89DdgNYLuNQ3puOWIkT9+Rdohzn7LrEhbZ0Otf06X8sup8RFYKOIMs=
X-Google-Smtp-Source: AGHT+IFkkBQAyNX7DfacqOon5FLlqQQuwgLSAEcCYpBtrVoXRt0WPjWg5fiX9a/wlMI3TuAJltytLrbohZAL5o0tmXACkIu6aQJG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2cd3:b0:887:1779:9a8e with SMTP id
 ca18e2360f4ac-8871f432d05mr1423849839f.7.1756712312419; Mon, 01 Sep 2025
 00:38:32 -0700 (PDT)
Date: Mon, 01 Sep 2025 00:38:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b54d78.a70a0220.1c57d1.0542.GAE@google.com>
Subject: [syzbot] Monthly kvm report (Sep 2025)
From: syzbot <syzbot+listceb50001a1986a9527bb@syzkaller.appspotmail.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello kvm maintainers/developers,

This is a 31-day syzbot report for the kvm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/kvm

During the period, 1 new issues were detected and 1 were fixed.
In total, 4 issues are still open and 64 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 635     Yes   WARNING: locking bug in kvm_xen_set_evtchn_fast
                  https://syzkaller.appspot.com/bug?extid=919877893c9d28162dc2
<2> 13      Yes   WARNING in __kvm_gpc_refresh (3)
                  https://syzkaller.appspot.com/bug?extid=cde12433b6c56f55d9ed
<3> 6       Yes   WARNING: locking bug in vgic_put_irq
                  https://syzkaller.appspot.com/bug?extid=cef594105ac7e60c6d93

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

