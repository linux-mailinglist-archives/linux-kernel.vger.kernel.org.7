Return-Path: <linux-kernel+bounces-873591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 219A2C14324
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B857A35266A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3D130BB87;
	Tue, 28 Oct 2025 10:47:08 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C224A30BB91
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648428; cv=none; b=J51NQmruZAn1LZ5BVW6nfR4x64HYnYFEdp7E817mBlrFZhSpZu4tksRJAB/X1lBgQrlpdti57lST65hvJwtnlL/kvy8Dom3K0KjM2epZMV0LRH53tHb0Pt/olVkwwjsoo91JShkmTxa8hTQmKI+KuU235jyiA4nOeQxC2Q1pV94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648428; c=relaxed/simple;
	bh=Zf1w6gPly/LcPCdax/lgIiWZlfr/iMNxi7KnkS4d8ac=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KQrqUBD2o/jnuUEviFxQQu7rMCNEamcACDyq0ftoAVItqACVWwsSt5D3z9pcfKCfxGI3eQiWw/uDQ0lklZEXurrXjFMwP2LI1rUsZXyK4IUoFWOG78NHOuq6T1+rlxm5txLhWDuy53O/kCzAWEDzOxrImDtjscPbiUGyl0erKnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430ce62d138so70799265ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761648423; x=1762253223;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WUiv9yKlR31p3mqKRhjsAFO5+Lze6MoMeCahg16rvDo=;
        b=UZ5y7bTb/CIhdyqm3CU0tO0bCW5R1+RIJgJAdl2O1ManAPlTifmOmhyxFkQDYJ/3mi
         yC5FLX2W4uyG42llR7VbgNZVxpNo0bDqk2/56GdYtjEYusIEWxC2WbQac9QkdHbsv+Oh
         py4HMpCK6e2ZkdjAKE7m3MOdK1vTkciKB9OWRXFGEehZaE/7dGUHlUx17sYE48KdQsTd
         56Md4Xt4f9wyTgpEnBr0OF0GKKNIYpl/ux/gVZYkFi/nlNo9UY2fOGJWbPiep5Me15O7
         wUViTL19bZUauQh5qFBi5q2+Kq/rwWOUAgcE0stTiRJy+Shi3RMy+bohFbaT0P/b2oWb
         ifpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVYZsdOTjULwzddGEL6xg8qAi/tFC0xGw8zB2ESd6slo1nwyZ5lyAcpjLJCNzY0pt4CCBVeSzbQfqjrQY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3enM4WUwhWeF1bIi2k3g+5nAhZsYWYuWfSbNfQp0cfFOFSCZh
	Vzh0F7xmDRY07pkQBnxxtbimOclsvbvgcSvfV7zuzy5pR8JGaVGoKP8KcgaQwp1DswlrdngEufO
	UBafPQlrHOlecBoY0CHGlccSOl7C2ZzfRPu97f7VqjjBMV9tAMXJ9MoTi63o=
X-Google-Smtp-Source: AGHT+IEtP9o0NrQVk1VELQMRCaPpp04oLHdob3KOp2bCkELJ8lySFMA/sshrr7VJoD0CJ2Kgr/qOjej0IR+/V8F55KzMUOPVtBRx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:156c:b0:430:cad8:45fc with SMTP id
 e9e14a558f8ab-4320f86596fmr41796575ab.29.1761648422984; Tue, 28 Oct 2025
 03:47:02 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:47:02 -0700
In-Reply-To: <20251028104122.gAypg%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69009f26.050a0220.32483.0189.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: slab-use-after-free Read in ocfs2_fault
From: syzbot <syzbot+a49010a0e8fcdeea075f@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/linux-6.1.y: failed to run ["git" "fetch" "--force" "4d52a57a3858a6eee0d0b25cc3a0c9533f747d8f" "linux-6.1.y"]: exit status 128


Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux-6.1.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5b21423ca3f0a96
dashboard link: https://syzkaller.appspot.com/bug?extid=a49010a0e8fcdeea075f
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17c76258580000


