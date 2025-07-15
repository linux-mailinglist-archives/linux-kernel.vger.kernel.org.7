Return-Path: <linux-kernel+bounces-731035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1170B04DC5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 04:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0A5F189BA69
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 02:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FC62C3272;
	Tue, 15 Jul 2025 02:18:07 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C312E2C3277
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 02:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752545887; cv=none; b=u5EJH1jvKOw9ibGH6Aad+2j+OcyBP5JALhZGoB8e0C93KemhflWFqHe43xWWFJEnC3YvUJtcAIss34wa9+ymEf5HoEqDUvoem2Kh4rtqfYdolPuczA9GyqjF5ydZ9yTW84pIDMmKtssGZcBe0xkON+ieriAEfVnpmR+cVnFran4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752545887; c=relaxed/simple;
	bh=fEh3WP5QeImMY6/FL/A8fKVIWyqcBJhg0PlQB2hHKiY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ejIZAcG+JlRNx/MnISbGBitx/Xu8nqvGACxuSKG+PDRMeGWnz22MTG0Rx3p+ogF9S5iQmJC1ZfiGUIOI9hBDWeIxPdQinyvjfGRG4EyEYQ1Z1fgs+R72UjmVoU1uR4hvd12lRKlebmS7DcwAgMUueLVSUXOVvE9n3Lfs7owr0sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8649be94fa1so985167139f.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 19:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752545885; x=1753150685;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5zGzJot9ZoJ9LCQ4bdTAjgJk0iCBYX6Y4Ln/LD+n6wQ=;
        b=jG6lgCTuhYelTza42WpaIaSyUCZ5pUlsg5S+0jMeD2o2rwulke7nLXySCWKUVIo/Eq
         63VXkeMRmGGUG+KjltZPNZbLkVAx1/AACiV/1BHuMSLLf9IyaUHKp/3F0prNU3xHlqxr
         Tpv6ny/DIrM73KwX4eELh7kC/OI16GyqJ8sfCm7V8xhGT8pItE4CmC2R3pQZu3+Patnl
         Iz5YbtcloYHZ3UW0YOjtvPyx5XaXAMLnln6Y/lttVWcHecaMKql7Dy3mKzQVGxValAb8
         QQI3cB3hIODT3F7fvSKrHHvYa1XNqFvECWzMc9aOPHf0rHwTb/HJzwWoKZk6ibaJ1HEM
         7NYg==
X-Forwarded-Encrypted: i=1; AJvYcCUoqJ3ADDXRano1xhcM+LJJPiWwK5SmZXziSpJ1sW/19Le1POgZSGyY8quh2vFrIhpcs9ebZgeqhLSPFrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrZEEPyahXOg3S/iPt/AbVXkqkamJhBkh+APW7F3IK+xWKbqQu
	YDmMCqfkzgiK0LXJycdlgsY42VX1BZ2Srr4aJK3zc0hTEkwCe6mPKSuFgxFXmNY/0J8gp+NweJl
	HDIYQ8E5K9xXaBsJm9+OtcPOZuzr0dNlMGr9XNLNs82md+odPbK7HUEwm15s=
X-Google-Smtp-Source: AGHT+IFgfxKqmVlqrU0JeROgt3j2KEXj5k//41UdEGSXOGIRAVFyVH0BDB2VGAD5p1G4sEm7vKQ4410Rnr7rN56iCfkgbMZPGxba
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1506:b0:864:48d3:a5cf with SMTP id
 ca18e2360f4ac-879b0b59641mr125630739f.12.1752545884877; Mon, 14 Jul 2025
 19:18:04 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:18:04 -0700
In-Reply-To: <20250715012717.4112-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6875ba5c.a70a0220.18f9d4.0019.GAE@google.com>
Subject: Re: [syzbot] [mm?] possible deadlock in lock_next_vma
From: syzbot <syzbot+159a3ef1894076a6a6e9@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+159a3ef1894076a6a6e9@syzkaller.appspotmail.com
Tested-by: syzbot+159a3ef1894076a6a6e9@syzkaller.appspotmail.com

Tested on:

commit:         0be23810 Add linux-next specific files for 20250714
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1123718c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=be9e2082003f81ff
dashboard link: https://syzkaller.appspot.com/bug?extid=159a3ef1894076a6a6e9
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14e80382580000

Note: testing is done by a robot and is best-effort only.

