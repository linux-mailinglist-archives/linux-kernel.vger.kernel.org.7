Return-Path: <linux-kernel+bounces-836675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41413BAA47D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 20:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 467D53C7C2A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 18:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC02E233D7B;
	Mon, 29 Sep 2025 18:23:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0872F2264AB
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 18:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759170185; cv=none; b=ueLhVx/co3bkbr8W7haZJWcXufQl5sSAwGUE33p/6WcC23jj8g8mOYLbg6gV1fX6UbwZm/A21E0TZhMVQLjZmzVr5/Acb7agkTRdDPv6zrzo6HruZSZjfC1/GUESo5aLakBdibT69Pilbd3PtLUIbdeaqTajH7Wl35gTAzPJSxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759170185; c=relaxed/simple;
	bh=3KZAsrzTTWqi+8dHxXx0RD7GNMeEQiSWFagohsu82wU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nqK8wiN92ZYOnPHYnCWyKc8WNfqQDREe6bT9plnJfQS39tVwdhjz71eurhdryXYdDsosQ5ZZeQxUL2vsbqQIrU+HCILF9Ntj8Q5en4NlhXFdLoWl1NmS14ZMRFhFUcj4D/zfr7FtC2nE03zgNOUlhr0XzEC1m4BupQ4ddXXLy04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8874f33d067so598719439f.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 11:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759170183; x=1759774983;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aHGfRCy971BidLIGKmXNRjtiMIrtdrzx8FQpVLEgzT8=;
        b=ihGDZ9g9YjSIXusQZWfLdqYoeqDMoBoZshBFCo1oSYcIdgXrMz7dcYfl6GWq4cbx0A
         rqhiWI9YIz4Aj8/v4y4QuZenkDEsfeq7uhSiAHQuuFXjzuS5uWBs+xQQDiZASkcHS3wY
         HKbBX6+RCKctr6DiKOYn3LcGd2ImzNN7tt+APxxGtDabH3x38Cp7rqUtTSzes/GdJMl8
         k8WzgcXQ7CTQLoCb17W48t7NzQ8iXcBM95IUTiIcyoDFApilEKXaxiRN9TS1wpwUSRZz
         baCFl9a0mYenp/KwnvuNqakLrp9JPeE/zgAGsb6zzl7l0TXG2LuNRZ0EHD3YcHWK3Taq
         o/6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVXKnX28thQW69RRdL68HD+UAdAHoB6wedS7fa4Q172UhdLiJom8AioBpqLXAc0G9g5xo2Gc/SDRuS8Bqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIHScb4PtKXN0rGQ8eWuJRMNEd/ziwZab0YkVvVLGLgBxttd7g
	YJmnvhHShkjGBVRLIvqH1Vzok6CnXA1CQlPkDIJU/vMmw3/wOSuUi83NcN+ZGwM6AaIE8i+KK8L
	ZMpXES1GfnailRXTnJZNIjCpyP/Vbt/3o8Yf9607+FlrkUGvOB5iLIZpYwog=
X-Google-Smtp-Source: AGHT+IEI6GWyUAY++Re/Hf+5q7A+r6rFLnMX/8VZGzS5V/xgJ4OyHU70zkpChbDOVPRp20zNQIUuDHydsiMlfe724N2/IC9up05N
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184e:b0:425:8857:6e3c with SMTP id
 e9e14a558f8ab-425955f47f9mr264351775ab.11.1759170183211; Mon, 29 Sep 2025
 11:23:03 -0700 (PDT)
Date: Mon, 29 Sep 2025 11:23:03 -0700
In-Reply-To: <68d26227.a70a0220.1b52b.02a4.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dace87.050a0220.1696c6.001b.GAE@google.com>
Subject: Re: [syzbot] [bpf?] general protection fault in print_reg_state
From: syzbot <syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com>
To: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kafai.wan@hotmail.com, kafai.wan@linux.dev, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, listout@listout.xyz, martin.lau@linux.dev, 
	netdev@vger.kernel.org, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit aced132599b3c8884c050218d4c48eef203678f6
Author: Song Liu <song@kernel.org>
Date:   Wed Jun 25 16:40:24 2025 +0000

    bpf: Add range tracking for BPF_NEG

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13931ae2580000
start commit:   bf40f4b87761 Merge tag 'probes-fixes-v6.17-rc7' of git://g..
git tree:       bpf
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10531ae2580000
console output: https://syzkaller.appspot.com/x/log.txt?x=17931ae2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d8792ecb6308d0f
dashboard link: https://syzkaller.appspot.com/bug?extid=d36d5ae81e1b0a53ef58
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16010942580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12caeae2580000

Reported-by: syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com
Fixes: aced132599b3 ("bpf: Add range tracking for BPF_NEG")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

