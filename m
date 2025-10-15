Return-Path: <linux-kernel+bounces-853894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A524DBDCD72
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02F503E2563
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 07:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063C3313271;
	Wed, 15 Oct 2025 07:12:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A49280014
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760512324; cv=none; b=VQ7mV/D88xsr9bCuHKFufFcPBtlF0+MWn3WhnMkjeDjCChkyBBP8Fd0sg/luxJ0oEjqiKQkFEHDYMVK6X0Qr4mu9bi9Qqv07rwiH1unoRkyL4IwBT8KEWo3+p/k8cJ/8CujPCsIlPl97mji1FOCd2tvo2/EW4bnT0Z/rHzmtxsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760512324; c=relaxed/simple;
	bh=xh2uFZDovD6N/0vH/Ze1fDF8ekV58mQNBBzKuRbRj0U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=s4wDu+qPwinxZ/ezUvZskGsy5aj0EaEXzW05GIdUr8k3Hu3H2UaM/b9JD+Y6Ct68vymwd5NNse9A07KkYHhHOLotU0I8tKhukeZIBFJ1NWY6Mhub3Kk64faa6ysTvtFf6UNepKaMKbpB56ETSstF2ffgd7RFlbOVeQqFT/+FZaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42955823202so6626635ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 00:12:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760512322; x=1761117122;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+zPKTuhm0oAnH95sT6WQbt7cnO42FE6Lr0aOkmMLfMg=;
        b=PCSXFx/S7k3GtswFNobBDpQ95UV9DcDx3EUazUPXrS/Abj1RIVLx23igmQbXS/KJId
         7yU2hqx2kDC7IFqJqPz7RTdvab4sTKv7DivJ6RL9zFsrr2OFKVxxDkm2/kzeP5cGZ/uJ
         EKDO5LtPv9ElNNzbbVilj0ZIytVTibDe6nfM979zdLUQTlXwVb8L+WrxJTTx/qXFeBwj
         t3RXI4UoceEYW39Dfn0/EMB7gH3R5ncIcW2PbzmSL1WTIPVV4X11dWw9+xhHSOBLTjk/
         VWU4LXuQH4io7hMI8B5pFYI+kw42K78S/diMnVzBNcp3J2mfyN2Ev4x54RPWtUy87kCl
         sPpw==
X-Forwarded-Encrypted: i=1; AJvYcCW2h0bCi1YY1icRo/TMG34dyaO4/SAuqbG5ni8CwAzuFo1yadKSI6BiOdNLFqKvuebChjZLkv/J/2IK1Gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIh9+iiHWsZifTnpNp8W2X/PBwhoAWIjVhXu7Vu51jcZkNz9B2
	vE7gh3n/YgkYHndyu/RhSuL1L66H22yN3A93sZcqwwn1nZx5NZyxBJl1ICreMkX4g5WbWeE5Gdx
	HSgWpTxD8euDwp6FZUxXQkXZ1vorryk7qQTaxZsIOPMORJnP0WApzv2m6BXc=
X-Google-Smtp-Source: AGHT+IEztuYRTyzIFD+npJCaCAAtIFqJbXsdTH1iVpuuxlzvEwKI2rAXfa28A+KzWgt4o+hxDo8YWixOoGdenSSQv4FtA3Q9wmpl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3708:b0:42f:8bdd:6e9c with SMTP id
 e9e14a558f8ab-42f8bdd7091mr291023375ab.14.1760512322156; Wed, 15 Oct 2025
 00:12:02 -0700 (PDT)
Date: Wed, 15 Oct 2025 00:12:02 -0700
In-Reply-To: <20251015064502.30763-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ef4942.050a0220.91a22.0233.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] UBSAN: array-index-out-of-bounds in ocfs2_block_group_fill
From: syzbot <syzbot+77026564530dbc29b854@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+77026564530dbc29b854@syzkaller.appspotmail.com
Tested-by: syzbot+77026564530dbc29b854@syzkaller.appspotmail.com

Tested on:

commit:         13863a59 Add linux-next specific files for 20251014
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1590ac58580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=76790fe131481879
dashboard link: https://syzkaller.appspot.com/bug?extid=77026564530dbc29b854
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=179a7b34580000

Note: testing is done by a robot and is best-effort only.

