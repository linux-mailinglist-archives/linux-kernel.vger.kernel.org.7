Return-Path: <linux-kernel+bounces-765746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 054C5B23DBE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 03:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF6653B031A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 01:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C0019A288;
	Wed, 13 Aug 2025 01:38:09 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F099A2C0F8F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 01:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755049088; cv=none; b=Jpa0YHQIgrg0YJ+cbVhqd/Yzh1bT5scqIl6IlsOIhDEfDAZSr6yE+AKG+FWh3PepHx1E3Gg+LT4UD5I2jMrah9qxWjYjTgv3dZxW0dTYDWcbbOY+GK6eLksG7WeAMgOpvB0DEB9jhhdLS8WT3J9ogy0XTs5ApYteAn2BjqB1XQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755049088; c=relaxed/simple;
	bh=ma/OueERVVqw1jzCU4wwldhPfctP6EFCZcnrThT0A8Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AWNmJ8KwlbpDjG0TfdRvngAoprJF9iwDrSxoopFC9PqcZg+SyS7mC68tsPEA7gtw6jjM68JQS3QWeu2nJKy9ILuScGbLmzjNyXz4p1AT1pkgULCOfCRBThj2eef7wgM791wF474V+upwAmPp7Zs+hmeViEF8tVsvgFk4EDmad9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-88177d99827so610078139f.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 18:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755049086; x=1755653886;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lx7Sx74rL4Ch4LYCkNYRpvTNJXX/yBxUTNBMNxC9ouc=;
        b=tJ0EO+bj9Jfh/L7X1IimomdRv5q9Razg2l+i3UPJDR/3GK+BHzECiwEK+8Gr1qBRsZ
         P/blB2BlEF/4KiQdhe5OmQ9XvYandmOXB7EUN9F3+jXvf1yzm5938KIeh6Hr0FiVLgwY
         NN9MuKIp/DROUxAidl1tB2eHDLvGy2MsF33/MD1QMHomavfmGT/Vh6fVT7om3cHz4q8F
         ZbUw0vocZaTShOgT1KBTR5Yq/MaMlTt4upJ+3Dd2/Fui49X1tu76LD1maKMn4cYGcrur
         BL1feOlzSgotsJxl1nvrzsMIrIiPEidsoZGbfDg3L8c13etIpqsGIgl8sztVp17Q77v5
         sNUg==
X-Forwarded-Encrypted: i=1; AJvYcCW6kuivEcsuPa5C5RtqmCtuFUXcFM9cEIBgxX7ECTy0BLD1sz3R3oMFk+8QDUlpO1EAj08FB1V/P/ls6SY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6YTfAazZUQQJXk52YP1J8++6NoIgiteWR1ilSjbjw9eODZmEH
	fR4JLmA5CtB7VDXtgHG+EZVDROKWSz1DrOqkd1sR5K7BJ/JfyvM3Pxm95RXUOQjzUOv1ZZlOfaL
	IZzkoa9NL/YnnM8qT8oYry3pFSjpDrH0SFEzxAobM0mbixU3tD7R8U5YHLjQ=
X-Google-Smtp-Source: AGHT+IEwWSzs/3RiH/V2xLrQ9l4Opa3cTzDjfl5mZbUsImerhP+zFNIKD4aBvROJ5QRTuy+biU9kQteA7ah7kR5Mpv6lV7JC3WLt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c0e:b0:879:674e:2c73 with SMTP id
 ca18e2360f4ac-8842963a8f9mr238344439f.4.1755049086075; Tue, 12 Aug 2025
 18:38:06 -0700 (PDT)
Date: Tue, 12 Aug 2025 18:38:06 -0700
In-Reply-To: <20250813011023.4357-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689bec7e.050a0220.7f033.013f.GAE@google.com>
Subject: Re: [syzbot] [net?] BUG: unable to handle kernel paging request in nsim_queue_free
From: syzbot <syzbot+8aa80c6232008f7b957d@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+8aa80c6232008f7b957d@syzkaller.appspotmail.com
Tested-by: syzbot+8aa80c6232008f7b957d@syzkaller.appspotmail.com

Tested on:

commit:         8742b2d8 Merge tag 'pull-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1235caf0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d67d3af29f50297e
dashboard link: https://syzkaller.appspot.com/bug?extid=8aa80c6232008f7b957d
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1083f5bc580000

Note: testing is done by a robot and is best-effort only.

