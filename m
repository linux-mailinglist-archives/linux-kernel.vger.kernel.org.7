Return-Path: <linux-kernel+bounces-828126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 027F2B93FF1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 04:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9DDC2E1446
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 02:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E41266B66;
	Tue, 23 Sep 2025 02:25:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6111DDA09
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 02:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758594305; cv=none; b=DjSoF1tynOsWmTyO9wfwdtAZFIrtwNPBRm8ymaDxpd09w9S91aO6t8ZXW1XRpvYkhTS9O33gFxxcwLrY42WCEFEUcAr87y+vmXHMA5b/FQTuPZsfHjPZ03Ol41yA3GuTxMmrJRFqN6TNNS2EaEoK8gC302DQL6+TfsVfbozIKEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758594305; c=relaxed/simple;
	bh=Q1KlGZTVV96q5l5fsllEuWOggjoI5qDrE6e0Lhms7HE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=krpzeOTchPbWhxY7Zv0x+JIhpDgLvmtFEbcLgURYH66ujYAulQjYuUJMkvKhD8xOsVpovWuumRiJ92Do2TiV9X62dtvdnRRBalrLXxP/SqrW2dV5nwtuRvKMbslXn453sGDmkLsEKRkkAuu/0GmNkQ7npfD4lzFfIRcRl9QZ6Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-889b8d8b6b7so555521739f.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 19:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758594302; x=1759199102;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jGZHIGftnbXw/Hnzjtcpe8U6fwyOUd5V7jn/yA/myC8=;
        b=HK9HFbHuPfD3rS0bwJ8NUWE31sWz3BqiL8cyM7rtmo2PTIPdk5tkycWXsTe5FpPxmI
         TBRtbAZ1LDnxoo8H2ngW8O5TkAt6YuAjGTIfA1eaz3csHMehPIugiMAzwB7mhoohCZfS
         DcRMA9l6FqOnOEaQA77nHRdiqnee3ZfTAiVkPFUEP5BbfChaaknOyP2G4qZZDipw5Zwu
         L5DO8J00yd36KkIYE9p3W56BHMIceVATfhRy/5j2Xtu8pQ3FbU8RplZNajWb2mclDwVr
         lzNxxXq2brhi9tNNILSq7kbm0pljdZE8IBpfteQfyRCpJ0ewJF9dLnAqq+cC7OBWm3JK
         gc/A==
X-Forwarded-Encrypted: i=1; AJvYcCXoLAaY3E1DSlmyGB0ffFsKop9VsHVhcRVn0DTioigVbiIuEOB51VzWzCqoD9JVLvpImve5zif499v/RN8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2nMM2GsbMXUmaddpdoV5+j4Td6Z0p2EwPnRDMZIZpyfZE+qz1
	UIFyA6mZ5Bt11UHoOsdQqwPPK5N6TiQBiXERmzRHtp/S/WykoJoq5CFJuTzOheRajS1AmOWM/yR
	Vffm7rVtkA+uRR7nyIo8T2RYzeXZlG3IZHnkHrH3G4WnImVt+7uVW85jQW0k=
X-Google-Smtp-Source: AGHT+IHfqSwI/kJBkh6vwxfQTY/a8zLbIEvFQh1u0s3n3Id33vwYZdaBh792HkZ92NRgB+ysuppYwx2hDruRBL/0ajPAlrbcXy04
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a6b:7e06:0:b0:887:5e28:688a with SMTP id
 ca18e2360f4ac-8e386f2b2d0mr118783139f.6.1758594302621; Mon, 22 Sep 2025
 19:25:02 -0700 (PDT)
Date: Mon, 22 Sep 2025 19:25:02 -0700
In-Reply-To: <20250923014809.7447-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d204fe.a70a0220.1b52b.000b.GAE@google.com>
Subject: Re: [syzbot] [block?] general protection fault in blk_mq_free_tags_callback
From: syzbot <syzbot+5c5d41e80248d610221f@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

arch/x86/kvm/emulate.c:4092:2: error: use of undeclared identifier 'Fastop'
arch/x86/kvm/emulate.c:4093:2: error: use of undeclared identifier 'Fastop'


Tested on:

commit:         bf2602a3 Add linux-next specific files for 20250922
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=135377594f35b576
dashboard link: https://syzkaller.appspot.com/bug?extid=5c5d41e80248d610221f
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14143534580000


