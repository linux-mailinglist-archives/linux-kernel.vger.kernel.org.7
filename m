Return-Path: <linux-kernel+bounces-777137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA2DB2D5BF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 673EB7B464D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3052D9797;
	Wed, 20 Aug 2025 08:11:38 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FFD2D94B8
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755677498; cv=none; b=V6rj5WGMp1Pmi+QL8NYmUm0NZNSU+xg5QQJAiR3qOWkzTCHtKYqX8TI+7ZIkl3qviAZyP0LT9xjuEdBz0GQ1wghTvWdx7FOdaG6BV/fzkMD/Zvn1uGyhlgKwIUgpEh6O6Kq5Y+t1pqV7XJK7bOKgXrQEkbIoLmJKtEqRG/UCDL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755677498; c=relaxed/simple;
	bh=BLo/SK0OwyLXmx4CkLXt0Zv4XSiG7FN8vxZrhqD9o9A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QSWEnqMlgGgC/fJCsDmxEUBcN2LBi9g4Smvo0Uf3F3s3f8wfcJ+a7EyqH25iq09dLtFuVHpv/2eTcj0r9fmp18gwz302e3+iex4pvbl9h9y+e3W/t20281mpy5B1KrqQ+/sDgh+Gdi+Rzqk5xDoU2RrTvcZp7TStifLNIz5UKOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3e6670d5bafso88514955ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 01:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755677496; x=1756282296;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nxnWMV7nk+HUWAMMTqThfYs5utB2u1ueiMVLfITSQbU=;
        b=lJ5TyaP4rNaXWxyuHIEI0ZdPas3F/Sjlk9D4y36A+eFkoUeyDGRJs9Eu++4G4Y0loy
         TT7ndOXYAKJv79Y2THUqSzIVx2QS554BPoU+9n48QgWPmr2MvwRmImpeGmsw9eoocHBV
         p4mU2a6wMbGPIzOaPOV2tq0asBtQEhAYuN0itRmbnDpBWIfNLRvc6y3fzxu7Cs8PqcMB
         3xbBdqC4RHZwiqc45yrIGdG4Yn2TCtkFWdMapHxDJqrbcigWZv95vaiTXQvVLX9lQUnd
         MiaVsyxPEA+PZSxxd3T7eKBMjoNyAunllO4GfHVneI6eV1sVVLCsUKWoULU1sOGQ95eb
         Mjzw==
X-Gm-Message-State: AOJu0Yyg58CqShsr7swQPU2zlWvy0GEEwsf0SR+OUOCIXHjckc9phUQM
	qohMdEVd1tsc/TLL7EZSqIKpaMpEV1A/LmBsZikGok53MnRY7Jr3lnJPGFGYSMAvsQKZlx9VAIw
	x3wWSnlyEtrZzBlilGseAcyoVdOKAAGDncEMN1UDxea2944tkh3/QZ3WwBLk=
X-Google-Smtp-Source: AGHT+IFgeuEM3R5jjreDnx783f1j+D6ZavtdfNGu7vZ6rTYRTO689dyA93mAmaz0QwfaU3/2wl/YgWTulJDhCQTdE/oRAQPR+L7I
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c06:b0:3e6:7aad:25ff with SMTP id
 e9e14a558f8ab-3e67ca3920emr40494565ab.23.1755677495895; Wed, 20 Aug 2025
 01:11:35 -0700 (PDT)
Date: Wed, 20 Aug 2025 01:11:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a58337.050a0220.1b2f6c.000c.GAE@google.com>
Subject: [syzbot] Monthly trace report (Aug 2025)
From: syzbot <syzbot+listba220efcf7f3e6e8ea56@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mhiramat@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello trace maintainers/developers,

This is a 31-day syzbot report for the trace subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/trace

During the period, 1 new issues were detected and 0 were fixed.
In total, 12 issues are still open and 55 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 576     Yes   WARNING in tracing_buffers_mmap_close
                  https://syzkaller.appspot.com/bug?extid=ddc001b92c083dbf2b97
<2> 80      Yes   WARNING in blk_register_tracepoints
                  https://syzkaller.appspot.com/bug?extid=c54ded83396afee31eb1
<3> 52      Yes   INFO: task hung in blk_trace_ioctl (4)
                  https://syzkaller.appspot.com/bug?extid=ed812ed461471ab17a0c
<4> 52      Yes   WARNING in tracepoint_probe_unregister (3)
                  https://syzkaller.appspot.com/bug?extid=a1d25e53cd4a10f7f2d3
<5> 8       Yes   INFO: task hung in blk_trace_setup (4)
                  https://syzkaller.appspot.com/bug?extid=9c1ebb9957045e00ac63

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

