Return-Path: <linux-kernel+bounces-820911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D15A8B7FA87
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAB1C189B23E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EBA284888;
	Wed, 17 Sep 2025 13:55:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C0E2F260C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117305; cv=none; b=nIUQRPvL8jdqyjoZhaB+d+YOegneyVZWf8DZksi+1AialSu1S9JaShd1cofG6WOMLNWhLtUlgQab7zfT/OxZRyDnPFnz0BlWBDsXHWQwEOm9agHY4nxxkjcbLi52qxf9Ej1Wb86lP3tqqYQ76KTtju224nrjzT1gwoL1/UI3PAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117305; c=relaxed/simple;
	bh=uto1/Izx36Wbb6EEFXePx9tDPDwuwN4iP+0cn0SIpNI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=htAPvmPhMpLEzk2SO6KhneJ08hFGeFHhHq6gzYOYt/4z6XLm66NQJmxO2nYHw1cNNWtZqsGc59onGSAhoxgwRFOD+AWSC3WlHHlfaLCWF0bNyhwA/gLUmThmSzWP83M21F9d+KCEHD5Fla1lw2ylGeKiaxA33ExHV7PmFIZ6LzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-400bb989b1aso210024545ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758117302; x=1758722102;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wloQr1BZ0ckEL+UVccfizSPRSePRCWY2K6gzJqsNQy0=;
        b=NrSL6nq4c2xoM9brVwlOxNFq2QfhA6sXlONiEC0NrME7xRsKdw6YAeh+CTV/+o8Pxx
         k/Gf5s1UPEcS1DSH9O9UXPBkwQyKS00aiMSSd0Caz0d+dDaTcD2Nehdu70YzMTaK5vde
         qXW7UvTPFRpcf8FWQHA+ZJg7g7o8tJok3ofV9+4LyKkwOu1GsxhOAtKCtiP1HHlj+/Xh
         KEmgyElGMrKhZjl85zGdIzfOfselukSpwO4eX0Xt/RQs4whLTbPJlFDpueIFP3Ae+H+I
         GiURccCjsmXY03qGjjQzpDXSG+RYBAeRoXcgwCPCsgkOQ88HBB+2K5fkfxRh+yI8pRfY
         44Ew==
X-Forwarded-Encrypted: i=1; AJvYcCWGVJTACRhcF2nq4suwgT1Zc2DuEcySEAyJfNcVyE0nUCGydpfRFKos6uD+NzjPjqqU5PVn3Dq7NHa5weY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcE/gioa0Td9Yx+J/PldRxGRmsOqoT1JGdj+60Gy1nobPEca6k
	7BJASLN97eAaJk92heBnMrV/pS/IojZq1TnUYlEZr6HH5/7ojdo4w/O2br5loi0WifwqPatbn1B
	S82+TIoJ7kGj4ENh0TH6Rp4swcLhjjw6IR86RIiZ0YeaPUoRzThSjQIP6vzA=
X-Google-Smtp-Source: AGHT+IEmOv3xBwi1c2gJMp3VfxoV/Mlu3h8pcf2qHYjd503q/jaBDYapz5poEDDPsKmBOo5j5DyQpKm8SqPytxUml8Ix5NEgYnCn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:450a:20b0:424:1c3e:772f with SMTP id
 e9e14a558f8ab-4241c3e781fmr16418195ab.20.1758117302377; Wed, 17 Sep 2025
 06:55:02 -0700 (PDT)
Date: Wed, 17 Sep 2025 06:55:02 -0700
In-Reply-To: <CAC_ur0pPzCg9kY==OJVRJG1jPuP67Upp2hBDMTWDxJaScekZwQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cabdb6.050a0220.3c6139.0fa6.GAE@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KMSAN: uninit-value in nci_dev_up (2)
From: syzbot <syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com>
To: deepak.takumi.120@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com
Tested-by: syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com

Tested on:

commit:         5aca7966 Merge tag 'perf-tools-fixes-for-v6.17-2025-09..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14cd8c7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b093ccee5a9e08c
dashboard link: https://syzkaller.appspot.com/bug?extid=740e04c2a93467a0f8c8
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13dfaf62580000

Note: testing is done by a robot and is best-effort only.

