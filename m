Return-Path: <linux-kernel+bounces-842569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F72BBD09F
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 06:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 585223B629C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 04:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAD021FF5F;
	Mon,  6 Oct 2025 04:31:04 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C109A1D61BC
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 04:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759725064; cv=none; b=fn1hRuAisb5fGALA+g9XXkaE1y0PFrPtjrjpW3Q1eIYFPB/LOET6YYTLkgDoHcu/ynYNMFgPFsUyGC7FXvjaspqdkPA0+moYS7OrzP2ZGPyywE2T+Ph29x6KqyfxrNrzCkJHD6PatXarzXLwaV9byyuR5CyfdLvdhRV0J6oG1c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759725064; c=relaxed/simple;
	bh=s+LrhnWS0EhHnKEs6tpduejKoSfYy0HkXTqdykcBHaQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=r+fx/uOQk1ahbaw2BOZ9Kzvb2PsSk+DWmrapA/KyoBjNyeIMIGESCB1LwsYhb1ZpLVE2w5ROYLwy1yv92/twSBf1W4obn5fK7Em5CVbp8lch9PkyFrbsnaXrwtRIjpq1l4xDAHHNG9QzpKbt9XnwF9o/pnPz4cSbqs+Dh1meAeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-886e347d26bso565482139f.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 21:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759725062; x=1760329862;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qYAPlWh5QqZG7ZzTdDdbGHnHnrg7g0fCemjpqHkKvfE=;
        b=N7LdYIFLFW0LmAf6pIOm0UvbyB0gnrRLrL/zxl/jam8natGjFKuQQGzxoJlFEqTyJt
         A/dszgtpilT0VCy3lMx83FQH6o0+ft3dWbZqeKO+qP8s5NX78X1Q69OtqLd2OaGAu8EE
         dw5Av3tKSR6DQ1VAr7Z5Rtp09chwqbg7Uag+XgEeNfDpLEJR6CWzI3cnd/KBEAcL5jfB
         rfRz5Rd1XC96CBBnnAQHvuMHXWNWVaf1RqUGFqSueDJRYETx71V1fqwRlwx3dDldOoO2
         JlB2k7h94+EXGNnFmVK7Z+hrA0tnzLN3YXYO4sTME7fbKFTbLNMUdYgjpUAi+bjVHOOM
         uT2w==
X-Forwarded-Encrypted: i=1; AJvYcCUmkYX6rl8sOiuwBtzfj+YPZmhwNjMRo3m/KYbsMOeF/FVieG0/8CVI55j+Hu0C3X8MZ6K1CIBsNXomOac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy8NlkaAT2ACufG7Hq2E7oWMQwRvVxme4NF2Rpki2XyM+XOHkb
	O58BZNxtlTtzrLM1RWCLUbQO/2x/W1CJ7m5TLHUK2ZvkfOsUcgz03A022H7Ks06jD3up8LonKWi
	ZZKBTkhtGz8sQmKL5d5IuChuQDbiCn2eiVty08VXFHLEwSfN2H4xOt6js6RA=
X-Google-Smtp-Source: AGHT+IHwLCNlpvRxDJJexJ8mhE1ZlKnw256X+/lDKuYPrCek1Z8+Yc8wXHgdMmtWPWEKUKQ8yZDEMknakJRpwxf7DcUT9oblcO6+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:26d3:b0:93b:a3c3:1b09 with SMTP id
 ca18e2360f4ac-93bac7ec583mr937979839f.6.1759725061890; Sun, 05 Oct 2025
 21:31:01 -0700 (PDT)
Date: Sun, 05 Oct 2025 21:31:01 -0700
In-Reply-To: <68e2ff90.050a0220.2c17c1.0039.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e34605.a00a0220.2ba410.0021.GAE@google.com>
Subject: Re: [syzbot] [exfat?] KASAN: stack-out-of-bounds Read in exfat_nls_to_utf16
From: syzbot <syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com>
To: aha310510@gmail.com, ethan.ferguson@zetier.com, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit d01579d590f72d2d91405b708e96f6169f24775a
Author: Ethan Ferguson <ethan.ferguson@zetier.com>
Date:   Tue Sep 30 04:49:00 2025 +0000

    exfat: Add support for FS_IOC_{GET,SET}FSLABEL

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12933334580000
start commit:   6093a688a07d Merge tag 'char-misc-6.18-rc1' of git://git.k..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11933334580000
console output: https://syzkaller.appspot.com/x/log.txt?x=16933334580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2b03b8b7809165e
dashboard link: https://syzkaller.appspot.com/bug?extid=98cc76a76de46b3714d4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=161a3334580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13827942580000

Reported-by: syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com
Fixes: d01579d590f7 ("exfat: Add support for FS_IOC_{GET,SET}FSLABEL")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

