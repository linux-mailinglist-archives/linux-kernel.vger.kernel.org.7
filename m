Return-Path: <linux-kernel+bounces-854598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B76BDED32
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BAEF400E1B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93A020E029;
	Wed, 15 Oct 2025 13:47:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97AB2629C
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760536026; cv=none; b=dKEbBx4uU5uPHIQXgfHYDYWzXlk7rP1b7yAVdouDkGhDPfSwMdAxqUJ1dT1k/ES1DFcOsaPH7vwbhwTxfzBzxLcaolpUGVJeXIEpSIU0PRX4KINiM3bqGtXQHs0pPpQ8VrQsEC74Rpb9iWhFylpnF1cWOhfnWLK1mj7mGJDLU3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760536026; c=relaxed/simple;
	bh=SzkGglACk2ecMvMJD1k84GoJTdSAjj2YDmu8jCQyZOo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dVrY8jbv9u7Ia6vb4skNT+F5MEAzRDsKrihpAbj4TC9Fg7uw0v7q0xxrRtoXFUB70aKeyu9hw5BOWgbCuOOhmlBTNJGnx8paN0BWX5DMJTX0YK96lQTZDg2MINSWfPpNxboI8fh+OAjyLdhP1NhB36LZu9Btn5UstQpwwubth6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42f86e96381so160821275ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760536024; x=1761140824;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ljo9OuErlLM00XsMZf/51X/x1BYGThyE9CnwvE2p/rE=;
        b=FwfAArbNmCGq3bPDKXnDiW9UvMft/LgmGgfZgVYois4LgP2BAONMIwiFm8HyI/bbY8
         1wCEyIl21sIOSS2TEqaj64T5LSaBG6EtSkaC6HmNU6CJxb1XWRCMNDqRSY0C7ceq71Cp
         ysDdTt8TXPu1AN3NBzKuL+X202Ed+6bwFtn2xqdX33Fqeh10QCKboalEyCnK/vcnCXYd
         lBf+TKgXWw/qQdUa0LzF7qCUsU6+BAmRjCjbYWcrJlNyPZZECV9DgqUelVnFamfOioBA
         1q4g44ZuErTcHb3wHfcE6bzoRCmV2urETiEHeDSOJQPiDCQYrxrl9aujZ1Ew9wyMadSs
         u0Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUbRvw2IktnqyiapchnSir4OvkVmPDjGMUzfsxarDsk8xIN/5sKE5FWs/e/jW8/+wKGEqxM3koPD0XzTcI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynn7vg7oB0+xejuaFgt7Ed9TsM1STsV4fO2yr3NMKniiwruzcx
	mYvmJXrS3C5rFM5JxvjZ2q6LuFdjV/my8DTBDgJhfz3MtXYlToGZf0KWzLv72IECrcCRRslC5GK
	BrrbiayDuykggkqqguCKLjXQWhvGZzpFWgPe9xaiSRwLi4Av+eZHOSvSAOjg=
X-Google-Smtp-Source: AGHT+IFv0XfRI1sNhOVh1lWVY/8eYketaW7CTv2ixqDDMHd1FEX1C8Zunr75lmJtxs40lenVaQwDcM2mnunernofDpyQyZTlr/JS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3790:b0:430:ab48:cccb with SMTP id
 e9e14a558f8ab-430ab48cd17mr43775895ab.31.1760536024119; Wed, 15 Oct 2025
 06:47:04 -0700 (PDT)
Date: Wed, 15 Oct 2025 06:47:04 -0700
In-Reply-To: <68ef030a.050a0220.91a22.022a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68efa5d8.050a0220.91a22.0263.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] general protection fault in gfs2_log_is_empty
From: syzbot <syzbot+6b156e132970e550194c@syzkaller.appspotmail.com>
To: agruenba@redhat.com, eadavis@qq.com, gfs2@lists.linux.dev, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 578194d38a129a7b60ddd90d226ea517605db30d
Author: Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu Jul 31 21:49:37 2025 +0000

    Revert "gfs2: Force withdraw to replay journals and wait for it to finish" (6/6)

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10df95e2580000
start commit:   52ba76324a9d Add linux-next specific files for 20251013
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12df95e2580000
console output: https://syzkaller.appspot.com/x/log.txt?x=14df95e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=99cb6b007a8889ef
dashboard link: https://syzkaller.appspot.com/bug?extid=6b156e132970e550194c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=132af304580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12cd7892580000

Reported-by: syzbot+6b156e132970e550194c@syzkaller.appspotmail.com
Fixes: 578194d38a12 ("Revert "gfs2: Force withdraw to replay journals and wait for it to finish" (6/6)")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

