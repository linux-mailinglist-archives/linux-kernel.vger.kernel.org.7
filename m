Return-Path: <linux-kernel+bounces-803896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 745EEB466DE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 00:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B55C5C0F37
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 22:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899FF29E10F;
	Fri,  5 Sep 2025 22:54:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED261B85F8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 22:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757112845; cv=none; b=PItTxk3m02U9ELg+KrVgCIzTgYM2pKjCfC8ZoIxCK6kTZnIfAxv+gTeVy+se22AAlfa/D5zbzPmGv78o4J/QhxhmcUuF21CI6ND9gzy1NWjzV8ucNwnf+b5rLNR0RDlo3XIwZQza4xvk/SiNvGFpo7OvsWz+/QjngOyyRYupDko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757112845; c=relaxed/simple;
	bh=xmt+7MUYLe/TsNdv+UTy27pUcBGcGqm6Q3U60XaPyoQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EMHFTHpsEl7rmk98tvoFJD1GErH7OjbIAN/LJUEHAbEQFnFkftVCX+teSqrSt7oPcO/tWL3N95c99DiFUTDeTC2bRd74gGZ4WkTgaVNvrD+kCkmyuDfndD0SW3HmAI8J10XXJLaysDx4DDM1p0DSklb8P+7XtIv4xWbW67eGVkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-88778bf677cso3246439f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 15:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757112843; x=1757717643;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=COPuUn8LM+pX0RzcctilePF0Lz9RNH7VZuFaMlEVmdg=;
        b=UK4ufv3Qd6kToJmgLzK8wbLcXnhkY696meIm9fFzu7jEgUHT0KJ2NhOrJWFQl2Dos6
         T8akKM/ggR2hX3kC9J5rOdr+4L5lSuXzfTlr8KnNzQae5sBTrP2inEnN9HHgZ0pcQCcf
         at2fNJ1Abtkzybl6eE3BAuNvOlv97Y0cfb+CkuSNqF55KjiVE0OpzdDLlN51NAYhPnLv
         f8gKCCn7VqCc7idIxh+4JgfuEySsn5bnzwSRiZsDTauZttGIdEGvWmxbLbkBXPmurMI7
         qsut56IOyET889FQSxacoO9TiM2zqztulh186rM538ho6vXPDFfGw3+Ww0BqCvGu9B2B
         xN3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXD2c765F5RnXFySsbOITz+818j83P5h9Bk6A3Ws2uVZU4lSfi5wAmYdhINrhqLqg5B2iQwoC22vkOj9vU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzypntF85fVoP9LxCeAth3xCFKFwkjpFKN55Hxv7u969D2uKmYj
	k07q+25xV377RJT5IzJQQ6/1ThLcl6YdXDcF0d8CHDXESAINw4O/MOE+a+PtEWx+htRdprK/w30
	O+chrTY+fSVrbXV9UWkaBsJzC8mKUEzF7eEI7ux9MRvX/UtOHCLwG49NuEN4=
X-Google-Smtp-Source: AGHT+IEHOamtQTp9ShtnVHZx0Qpq4+0a3CZAv0AdYvOBwovxa8eWaiFwDq5yJg/DbuolI2h+7rl1AdMtyIvqKAj+FgJsMR10oQyF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3810:b0:3e5:4e4f:65df with SMTP id
 e9e14a558f8ab-3fd82163cbfmr10431275ab.9.1757112842915; Fri, 05 Sep 2025
 15:54:02 -0700 (PDT)
Date: Fri, 05 Sep 2025 15:54:02 -0700
In-Reply-To: <68bacb00.050a0220.192772.018c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68bb6a0a.050a0220.192772.01a0.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] KASAN: use-after-free Read in bch2_prt_printf
From: syzbot <syzbot+7f176adb30b21606c5fc@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit c21f41f6905be4fc5059a10a5bba94105ba87269
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Thu Apr 24 21:55:20 2025 +0000

    bcachefs: bch2_dirent_to_text() shows casefolded dirents

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12c65312580000
start commit:   d69eb204c255 Merge tag 'net-6.17-rc5' of git://git.kernel...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11c65312580000
console output: https://syzkaller.appspot.com/x/log.txt?x=16c65312580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd9738e00c1bbfb4
dashboard link: https://syzkaller.appspot.com/bug?extid=7f176adb30b21606c5fc
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=178ec962580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10097162580000

Reported-by: syzbot+7f176adb30b21606c5fc@syzkaller.appspotmail.com
Fixes: c21f41f6905b ("bcachefs: bch2_dirent_to_text() shows casefolded dirents")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

