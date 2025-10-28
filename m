Return-Path: <linux-kernel+bounces-874018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03730C1553E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC181188DEF1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A512750E6;
	Tue, 28 Oct 2025 15:04:08 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5112690EC
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761663847; cv=none; b=dLr/hdI+kWMlgkk7ISwKtpwr2h0PHXlQ084NaW50qVmQeBCzKBorub3xjeLmdKPM9eTb11ZpboMNc4LE0hicVx7/9Sh7TvekJoMbzK4W4jsIl0dhIfUKpKBLiYt3s6T+IcN2Qh0jdbRnEb8zwj0Nv4cFhrXwSJ9VMliwf0yVGGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761663847; c=relaxed/simple;
	bh=YHNJ3+2Bl0kXz1AE7uKw8z2pj21d9oEcl/qcI/UkoCc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GEQkEpzoUo91vcW3xeMrDj3H9kltlFUi5m2wnWwb4x/vj8dg+hLRC/rA/TxKa2uEqcC5emn4LCeCYiCF0LWW/MqaGmsamW81GHZOgkGJOAtgqEj0DBYP0SF2b0n84x2m7TvXtMc5MocLGRxBRak6dzqewy1oZm+v8c9HI+AKExQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-431d8643856so248919235ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761663843; x=1762268643;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2WbENtpIuxc4z77nqKLhall3y31i7mXKp7vtElyIPCA=;
        b=B59FEB6FKnke7Z0Ha0EifeIoCDUTsRdoHpDXDv+qo7gEgaNnOq0wKEYOkH6J37Yp0q
         iyYm16gsWZg2DVHYceSLW42EoP9z1DVQK+70DPccy38LqbpnULmmsiZ1ZfDwzgUXSEze
         e2e0rnpuQArHV1slXjgCqJ1WlL75V5DHGZtW/kh3AEXRGHjsajasJyZPwrXaYyKGXcqT
         967ywvDLu0G1zdIN54D3fDR+7FmRypKYQpyg3t/NQirnwhXCToQ4KXLY/JJNndhpFiyi
         /vjUZ6Blcwdi/LIJm2FnAmT2wTG724Gg/Om8vUnCuYT5Z3KGVB5JSqtGZlN/xSl0DTbr
         INqw==
X-Forwarded-Encrypted: i=1; AJvYcCXAg3cidVAPEUpiliUVNE7E+RzmN6j8f2K8VjdSkeV3rWp8kpmcQ4DDmNHQ+lF22nfsNgFwCkzyhWbcnok=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB9qBH9Cgv2pYi9YhlxJ+xDs5mwqN0dk4g4OOhobgz7uhWy5Ji
	XVALYBaiF7G7+6+rKo8UdxI0cZm73M/gzcapKv8UmZW+ZpZ1naJbX6PWu6cubucLtjb3EYPMPbf
	cwt83sJrsUd9SfMphieJI2Duyzz8xXVQAa+sDrjZAf9GRLeXgvZwiXF+/H88=
X-Google-Smtp-Source: AGHT+IF+EohZbBrSDQXXa4N4mZZlU7T6UimJk72y+wdqPoE4ji9fLb3tKUW2m3rfuTPzLylKbckQOUKWRw9X7p6OZ45VrZPr0uoA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4f:b0:431:d763:193a with SMTP id
 e9e14a558f8ab-4320f8388e4mr49779265ab.21.1761663843270; Tue, 28 Oct 2025
 08:04:03 -0700 (PDT)
Date: Tue, 28 Oct 2025 08:04:03 -0700
In-Reply-To: <6890f71a.050a0220.7f033.0010.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6900db63.050a0220.17b81f.0026.GAE@google.com>
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_remove
From: syzbot <syzbot+2d7d0fbb5fb979113ff3@syzkaller.appspotmail.com>
To: axboe@kernel.dk, eadavis@qq.com, gregkh@linuxfoundation.org, 
	hdanton@sina.com, linux-kernel@vger.kernel.org, ming.lei@redhat.com, 
	netdev@vger.kernel.org, nilay@linux.ibm.com, sunjunchao2870@gmail.com, 
	sunjunchao@bytedance.com, syzkaller-bugs@googlegroups.com, tj@kernel.org, 
	yukuai3@huawei.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 8f5845e0743bf3512b71b3cb8afe06c192d6acc4
Author: Julian Sun <sunjunchao2870@gmail.com>
Date:   Tue Aug 12 15:42:57 2025 +0000

    block: restore default wbt enablement

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13b977e2580000
start commit:   759dfc7d04ba netlink: avoid infinite retry looping in netl..
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=ac0888b9ad46cd69
dashboard link: https://syzkaller.appspot.com/bug?extid=2d7d0fbb5fb979113ff3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1136d9bc580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1536d9bc580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: block: restore default wbt enablement

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

