Return-Path: <linux-kernel+bounces-778303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F10F0B2E3FF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 19:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B35BAA04DE1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC87334377;
	Wed, 20 Aug 2025 17:25:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8748F1B423B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 17:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755710706; cv=none; b=gc3Jx7kpZjvzWiVL06MBUrE88NIuWI+q+h17QOSW6JCU2VsBzohNye+RzPwIQ9GFbtgDpnbV8UreuAl3aY4bTct7J9sf5h3+dFkICuQdHLLzYf6G4qZ0yS68GM+8msX56ixWrZoxSZ1BOKGG/T1ffRMa340Kjg73qvEg44bDQgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755710706; c=relaxed/simple;
	bh=aDUMdWMRU4DxTbo4WOJts3/VxrpxQpqAchuZH4u5ATk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GQ1Axzs9vGspAZn81+A/ZVo555vuauzlzKFYDoIj+DyiKkpbDslXTCr7Qk7RaipZDccPiT1TJzA51+99oBibDNbXH7KAnZhfDcwx+34up3p6DezG75RNWa/kZlW/m/AwyJDVLR7qQ8+TosdeUlQqqx3pz4ReU5GrM06XTXlE5OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-88432e62d01so5203939f.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 10:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755710704; x=1756315504;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TyVgA7tHoc/pEZvZL4GEV9LwU8L5mvPzLIm9tu726+c=;
        b=gEi31VZ+Wqm2DhG5nKhVZRqlCMy8t7UcEgCVAE240ptpTB/7CPpd31dtEyuszzIwC+
         ZLvSs3VzPBp2/xxtk3uOeEDJpofAL+peAs20u4ESNzud+E9Sy6TpJ867sjfKLFUeCkmz
         0wj8ateAwOPPRYoI7AV7RseJWdueVu37izbASBBmCgJtqtJ1Zg6tPFquzgupIooLt1kY
         CZn6CWa3N3qiYQGB+Ftpcn0jlsOfvsygpOqAkFc8Soa90ZZdh/4gtpkk+TzIgGUypLpN
         6D/6BwAYiDdZCiaU8S0nCIUu/S0OfWJfXXLjEH7bVJZRTCUNoHTUSQ+9KFdArY11/HYL
         7KHQ==
X-Gm-Message-State: AOJu0YyVTBgHVE59Xf/Ip2IRSsWAq7K+ItUhFxMbUgvwFAqhD66FHpyO
	CfBYpGOnoiCe74dQNeelt8Lp+Hbr8X9YOIFqwRelPtaaIRrZeh3WKLqHJbS+iFZbZWVkITffWEo
	My3M3BLEYsyJEvfJmgEBU7+ghziqh4AyDoMbUSFEkPwZFxsf5gsEoOJoKICo=
X-Google-Smtp-Source: AGHT+IGalnh0JlSuAjA1QY7oTpOBGQ7OX/7D/JF5c4sAQTxL+1nCKDHC14Am/qP0NHp1ddl2r9OCLOWbnvSBzFbavtbX2fU+yh95
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1549:b0:86d:9ec7:267e with SMTP id
 ca18e2360f4ac-8847189df9dmr820767839f.4.1755710703627; Wed, 20 Aug 2025
 10:25:03 -0700 (PDT)
Date: Wed, 20 Aug 2025 10:25:03 -0700
In-Reply-To: <aKX7nTwVVk9dVAkn@kernel-devel>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a604ef.050a0220.3d78fd.0009.GAE@google.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in hsr_get_node (3)
From: syzbot <syzbot+a81f2759d022496b40ab@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syoshida@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+a81f2759d022496b40ab@syzkaller.appspotmail.com
Tested-by: syzbot+a81f2759d022496b40ab@syzkaller.appspotmail.com

Tested on:

commit:         b19a97d5 Merge tag 'pull-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=133633bc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eb938e97c43073ea
dashboard link: https://syzkaller.appspot.com/bug?extid=a81f2759d022496b40ab
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=107317a2580000

Note: testing is done by a robot and is best-effort only.

