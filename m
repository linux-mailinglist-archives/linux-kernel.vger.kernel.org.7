Return-Path: <linux-kernel+bounces-653840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E43FABBF54
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 15:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DAD27A279F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 13:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F3327A118;
	Mon, 19 May 2025 13:37:45 +0000 (UTC)
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD48279901
	for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 13:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747661865; cv=none; b=CuC4vKHm3l4T+sZJEpCoNVmZOAVXvuTbE3f5VAN3t/ISzmfBJk5gGvDwygp823Byh+fO1BGnCkaWMjG20Buo+Ow0OawaSpPVh6ICgZTT8+xYy8GQyi4lPeKpNE/5kwqynxR1ZSDHGaXB1jC35zaPT0k+2EfyLcmJq/TmEMIrR+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747661865; c=relaxed/simple;
	bh=4ezMdT4TCdJi9BA4h1T0RMJWKu8DgGKgRqI8FBr88aI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TX8HFRuiHS/+jLLZxiQiGXfRJJaWiCP/Z31tPK8gwM6oUIDyriZtRRyf1IbPHURwKL8vXCClsftMJ9b9QihcRDbYiXMxI5e+EA10vFt3Ij5khamqiK86kiR+H2Z1rb8SSm5rFgCul47zN6YnavQRS/DXj4IkwMDqI/Dqr9NVRNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-30e895056f0so3794699a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 06:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747661863; x=1748266663;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FmHmVLS5to/1J2qUe6GSOAdXZhUuNyL4y5/tJYS0NHg=;
        b=luZfaaBf5O1MKfV9LlYxFrHTH3JDeO5zTpTn6lsBJ9mq2h3WSSKcp8BvbCmoIJK3KS
         gRpkLb9s8oH/IAZDQjGrhM0A5YbQAORga645nTTmN1R2YOajkThj6zny+MEODZxzhGXX
         eF4SlaPzmDxh96dBHaf6MLB4TK09dHav92zfgKvdxfy+OyRPJeDVDPGk2ReV3Y4xw8Ge
         N99HKg+U7MWaFYmEyp6Qf9T+OGLhzQO9Y18vFUl1d5zEuJZ+CwerD+0fP5JIbWMI3HNT
         8NAiiEdfMg334Nk/6M/oeOQtIASBPlwSBLYC831o11OabdyJfyWPfSWZMjwnJgnKbVqZ
         0bgA==
X-Gm-Message-State: AOJu0YxlbFmscA1gu+w1mqPkllgUtcPfNEm4sdZxkxTRhN9sNOZvjVwH
	oW/O9H+JqkPIqonULjwQHrl9w1kjDshtCinF2LFIxkmUAxYt5qVw+CtybbZhkJrFMGrKG+SfaLC
	FFV6JscaEibNhcjQ4ZdvtgyRWeLmlEyTGqmcDnbeHrYvCK2HvcPVpt4H5bck=
X-Google-Smtp-Source: AGHT+IE6y7en3BV9Ror6OfNRB12PQDAh/yNXSR/J6voL1fvH/8PiqEKEpIoTMvtE13gDtcDTx3KRIEg3ZF9avl9PWv70S7YjQXCl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6a8a:b0:85b:5494:5519 with SMTP id
 ca18e2360f4ac-86a231b453bmr1566008739f.5.1747661852704; Mon, 19 May 2025
 06:37:32 -0700 (PDT)
Date: Mon, 19 May 2025 06:37:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <682b341c.a00a0220.7a43a.0072.GAE@google.com>
Subject: [syzbot] Monthly rdma report (May 2025)
From: syzbot <syzbot+list07ae2e9bb5b19774106a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello rdma maintainers/developers,

This is a 31-day syzbot report for the rdma subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/rdma

During the period, 2 new issues were detected and 1 were fixed.
In total, 10 issues are still open and 64 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 442     No    INFO: task hung in rdma_dev_change_netns
                  https://syzkaller.appspot.com/bug?extid=73c5eab674c7e1e7012e
<2> 274     Yes   WARNING in rxe_pool_cleanup
                  https://syzkaller.appspot.com/bug?extid=221e213bf17f17e0d6cd
<3> 48      No    INFO: task hung in rdma_dev_exit_net (6)
                  https://syzkaller.appspot.com/bug?extid=3658758f38a2f0f062e7

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

