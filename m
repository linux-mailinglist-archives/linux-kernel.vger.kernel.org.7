Return-Path: <linux-kernel+bounces-804214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80569B46CF4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 14:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9744A0180F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 12:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE8129E11C;
	Sat,  6 Sep 2025 12:41:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B25543147
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 12:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757162465; cv=none; b=TnUhgw8o1IaYQrtaNhsjxwdKkj97GBtIilEzFOwlQigzxw02SaPzkCqQtpyiVbrYEFF5CQUkRUHqdFBzgtS70HGpPBosluFCkR4nf+hM0tkiqNLbSto0NSEiZVEMJbzLvXUDzRk0BFNBOvPoQvXpdclompBmdnwreIE/P88ZtWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757162465; c=relaxed/simple;
	bh=U7G7G+aVkZB2v3V/zUCuzgGGvDKqhdtnY8WhOjRRook=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tAbCyjU++whlohI4/2GdLVXqSiU/fwlgVXK/HIVznl45JGfY5IUx6QTxvVjN6nJPjDx3g7AUw7qPZSK5uqPKeoFnQmz2RGcHNCCPIyCunqAwK6CRLPFoDVowMQQ1XyCYrtpsWEOBT1amT6s5nBqCmpNgeFKx9A4ilX+7YioRAJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3f761116867so61736815ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 05:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757162463; x=1757767263;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iEKjptd+e9tTMEG8g0kTtT0/no/OlP4s8sHfIK6Y4+Y=;
        b=w1+G9rI7cm4BSeAmfPztlm+KaawXRkfpWj0er22R8X3vkZLWpI9r+EVkgAo/w6yjsm
         kH/JptS1vrVRWM122Z9QB53L/0c8ou8Y+atJItfYfHYfQkBhCzrhV62iqi1d10csUjV/
         1+clw86AozBaIQsYWR3ccHmvAvDTq+FNcLD15WZkBi3bnDEsL8WhHsc9SySuDQKOW25v
         G8D1t3H6iJ8ospAlJO6yB076+B9K26VA+vxftEg6ZCVRNbWpAXZWyCSeV1+4pQkiifZa
         M1xSkEYsLoAuEFI6v27+5tUspbyzJVdmkx7DlVNwAYc8zxp1i7TZRVQ0rdvv7nHCYWSg
         FoPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVR93PyuHxM1AJsJN/w8+wvmPajgc4RbavXqV914bMuB+kNzPkmgbTWE0WLYrXLyIqRozIINZ78sQraHbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS9uluSGhXBCDxy4b7sVV6NG76SQUSeaDwWg0WHv0r3+X9PNjj
	LzEJJyfTwK3qvPRUhh6HQLNFBLWjiYW/NM5rp7zHsP4ATyZonsmTzVpgqULHNhS+xTpl1gI7CC3
	pXRYbypGDBi4S38TAzVta3ZfKd7MdSWdCktQNqZitFuUdmpkOB3I9KoeZwxs=
X-Google-Smtp-Source: AGHT+IHxNVzyRSZvKDEdGlmnC8rBo6tj0A527j9A7QqwnVmZRh2c1L2jvTp4bM80v+o6jg5YbDExuc8bKDS+cnBSnKi+t5QY9sHX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:451a:b0:3fe:f1f4:77b2 with SMTP id
 e9e14a558f8ab-3fef1f4788emr15491265ab.5.1757162463379; Sat, 06 Sep 2025
 05:41:03 -0700 (PDT)
Date: Sat, 06 Sep 2025 05:41:03 -0700
In-Reply-To: <683d677f.a00a0220.d8eae.004b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68bc2bdf.050a0220.192772.01ac.GAE@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in __netdev_update_features
From: syzbot <syzbot+7e0f89fb6cae5d002de0@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, andrew@lunn.ch, davem@davemloft.net, 
	ecree.xilinx@gmail.com, edumazet@google.com, gal@nvidia.com, horms@kernel.org, 
	jiri@resnulli.us, kuba@kernel.org, kuniyu@amazon.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, sdf@fomichev.me, shuah@kernel.org, 
	stfomichev@gmail.com, syzkaller-bugs@googlegroups.com, tariqt@nvidia.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit f792709e0baad67224180d73d51c2f090003adde
Author: Stanislav Fomichev <stfomichev@gmail.com>
Date:   Fri May 16 23:22:05 2025 +0000

    selftests: net: validate team flags propagation

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16a3ba42580000
start commit:   d69eb204c255 Merge tag 'net-6.17-rc5' of git://git.kernel...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15a3ba42580000
console output: https://syzkaller.appspot.com/x/log.txt?x=11a3ba42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c302bcfb26a48af
dashboard link: https://syzkaller.appspot.com/bug?extid=7e0f89fb6cae5d002de0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12942962580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16942962580000

Reported-by: syzbot+7e0f89fb6cae5d002de0@syzkaller.appspotmail.com
Fixes: f792709e0baa ("selftests: net: validate team flags propagation")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

