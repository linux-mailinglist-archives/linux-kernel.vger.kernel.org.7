Return-Path: <linux-kernel+bounces-844588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAC8BC24A8
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 19:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A78DB401940
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 17:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942242E889C;
	Tue,  7 Oct 2025 17:45:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B915E2DFA31
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 17:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759859105; cv=none; b=N553xgZUKYvU2GEHy3z9efdY8kyVC2CPggUay1ohqhpRADXa4nqDCTqG4QuabbMo6Be/o1fxA9IOlaoJRa+cO9yPucyFxyg05mBWzmT0h0q1xa9Z7xHFxSNVy4dEj5o4p+yoN8htwKKZUKYwcZqIDyiR6Tj3fRNPCDVufXwfqn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759859105; c=relaxed/simple;
	bh=iHVSASOMpEg/He/hoeH9kIEP14zS1QbDrqdwO1rPbLA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PP2U/bEGN2h72Qnjmnx8AHcQcAUm/Xr41OKl8SufktVbXIJa0+NhikCaHztUnRHJssuox9anNVy0e0mQxxvH6oHLbZg+z1RXsAeneRpYK03qJkIKXTsRMQgBXk8n/MFnooyHmNsypqJd/O7asUo4aY4bmGAAuFRxeyOqhvv5h0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-92c4374566fso496756639f.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 10:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759859103; x=1760463903;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AQ8LwJ2kllcnIjhbSb8t8QQLy2sXIVFfw/qICKEG1sY=;
        b=V+uJoukKZgRRT0KbeN2H08oM29jXHcd/iJ6KhA+InwKupipcGMiJsTLU8xtNbwIXua
         3+e2vzxb7ejbtxg1Pcyo4ALM749j58Aohds7YJ0q9aV4B+txa0CId+mH8Yc1LSVafEoP
         TyXbIy7ajVcY++Av33S4X4CEopu9Z0zEdAk/fy+9bgepVMPVavk0QBe9eYs6ei7LxbyS
         SWkaui2MSYdlv3Sxv3j0+eqUz8a9ThqoLxf2K2hY/6PGtPxpa3F89frUGnc0KEX2EIAP
         Dpo2VsKtW4867IaOi8R0jEeMUjG9ZTJKhmu+e/qtk8RfUX2DWt6cUMWI3phWDUODQG6E
         IlwA==
X-Forwarded-Encrypted: i=1; AJvYcCWR1b5dkPpvK7BPF42BERt+KXd1xsmolMvcxu8q9/oP/ZknOuinZ5R8Vcun2nDRhXCebGE9/9NN/e8MalE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjm91o7sR+hMtYD4T9GIGWOLytLBVQgRvJ78aPyv8zeFze85QT
	zDd6hMOpiNsVZAQB8N+Z8w4M0Vq2OYE4g3CS0j9732du/N116gFDesr2aPfuzBsxgwFwZYdSfiy
	rBCOpOxj536RCaAz5GSIP2ClqQixuL4I0LxV4ctb4ymsR3SbT1nE+rMgugcI=
X-Google-Smtp-Source: AGHT+IFSDH+Kx4nFTO1p/Mgi17M1eo4iFNiAqnoTP2PGFKpeamxueHtLoiP1elV9Re0bzLbxiLZOEJw3X6kx1ZTxkY0Eqb3HK7Hg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2d8f:b0:922:6c20:45ef with SMTP id
 ca18e2360f4ac-93bd18cbaa4mr17149539f.7.1759859102832; Tue, 07 Oct 2025
 10:45:02 -0700 (PDT)
Date: Tue, 07 Oct 2025 10:45:02 -0700
In-Reply-To: <20251007171256.20884-1-ankitkhushwaha.linux@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e5519e.a00a0220.298cc0.0482.GAE@google.com>
Subject: Re: [syzbot] [trace?] WARNING in tracing_buffers_mmap_close
From: syzbot <syzbot+ddc001b92c083dbf2b97@syzkaller.appspotmail.com>
To: ankitkhushwaha.linux@gmail.com, david.hunter.linux@gmail.com, 
	linux-kernel-mentees@lists.linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, rostedt@goodmis.org, skhan@linuxfoundation.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ddc001b92c083dbf2b97@syzkaller.appspotmail.com
Tested-by: syzbot+ddc001b92c083dbf2b97@syzkaller.appspotmail.com

Tested on:

commit:         4ff71af0 Merge tag 'net-6.17-rc8' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17676892580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=595e5938a1dd5b4e
dashboard link: https://syzkaller.appspot.com/bug?extid=ddc001b92c083dbf2b97
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1249d1e2580000

Note: testing is done by a robot and is best-effort only.

