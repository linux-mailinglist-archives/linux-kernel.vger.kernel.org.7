Return-Path: <linux-kernel+bounces-787754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDC0B37A9E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 08:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 969397A6930
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 06:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D968312828;
	Wed, 27 Aug 2025 06:44:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E32527A103
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 06:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756277046; cv=none; b=t7bRKGb+7K/UcY4kE7MA7NKXGmTWe7IwTMuaLnn2cCCP9YWFsUA19TdpzoxxGLTL0EMn8pw1BJW/wsrJ3sujrj4W+JNkaydzJ4kbJl3KDEmitW5oqPN0CCs5YaDuXOYKxs4qFaRan6Usk6vdr9EDejcGFRqMV7kgINfyyINO9rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756277046; c=relaxed/simple;
	bh=mUPIQALwMhL+KmHusnR/DHC/HiIn/YmkyaWiUIj6HdY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XLVpjTJ9cUKTPevP57Hoy7k0gpQAodtNYvpFKbPcztf6WvReXALg6X9u1qZeq8ogNTEHHVZ8DH1AyIKJvzErdMOBU+aAdIGoSBYA2F+kjH4woxWRQ/9OZLIxt3CtgTkiuAn2oj9N9ZKQOGkDRp55wfArVTRXlXgwFmckvX0hgek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3edfbb8d391so62494015ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 23:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756277044; x=1756881844;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=exlucQkYPIVwkZayXbNWXTCM4lZQKq63Ec3MVK9fgXg=;
        b=MXUCE5Uh+YuzVLOikZtNbaZ0OjaxSVbS7OhhZJpW8UR2JeE5wAw/YcuMYXYaX5WYbj
         55I5xvWPz9qIeO3EjWDmMpBqpthsHAXp7m4AOkueUUdCwit5uesBMVwLNRiOIGf3rDgE
         9Oqc8dWqyX8bcMI73AKPyQjlbbjM11Ys+Af47Y4R1QrH/hx6DtE0jpBepWLBDndVUN8u
         6INd6mqFMkbVdebKmBMKHLfZBYMpbtydKctTvGHQ2kjnhQNXyJl1JlfwH8jyriLQxjFC
         A3/i/sMTavWwGV0Z9LbspctW0/AjY48Odh1Anma9rOYy7w9TJWCC3p2fNEPp2JHM9/Ux
         SOKQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1MJf/xv62yp6nNYxMuPzg2D8L2JzpD0GPbS4X//cflDsTX92NfoWKkh3qSKB4xRiRfUF0nYgdJq6OuYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRy3nv5lbN2DrKCvqgVPhWE4uWUUVvYYdFeWYoq/zcE6DjYOZr
	q65WsGEHT/fQgV7ple4JwVx/9LY5HXqQOdP7OuAmUfWkMNwfv/U1MQ447rCn9SkKVdn7kg1WKgT
	dkhQjHT+rrPshBhFwGbxrRpkkKp8sy6Q5g/ovD4r0aytN6KJDATKrAfWOoiw=
X-Google-Smtp-Source: AGHT+IEyUA5nAMy1tYLMxRkgUBu6fyWapzhmqQLz71kpdn9vk71zoIuD0mY9OJQBVIvLzPwiRwFb9iNjQnOSlmaf3h+J8K1CKwNe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a05:b0:3ef:998d:9a24 with SMTP id
 e9e14a558f8ab-3ef998d9a4bmr41565905ab.16.1756277043823; Tue, 26 Aug 2025
 23:44:03 -0700 (PDT)
Date: Tue, 26 Aug 2025 23:44:03 -0700
In-Reply-To: <tencent_CFCFAA0DC325818D879200DDE3DD86193E07@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68aea933.a70a0220.3cafd4.000f.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in __xfrm_state_delete
From: syzbot <syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch after dry run:
patching file net/xfrm/xfrm_state.c
patching file net/xfrm/xfrm_state.c
Hunk #1 FAILED at 929.
Hunk #2 succeeded at 983 (offset 43 lines).
Hunk #3 succeeded at 1553 (offset -2 lines).
Hunk #4 succeeded at 1719 (offset -2 lines).
1 out of 4 hunks FAILED -- saving rejects to file net/xfrm/xfrm_state.c.rej



Tested on:

commit:         24204116 Merge branch 'ipv6-sr-simplify-and-optimize-h..
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=67b99ceb67d33475
dashboard link: https://syzkaller.appspot.com/bug?extid=a25ee9d20d31e483ba7b
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=177cc634580000


