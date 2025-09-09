Return-Path: <linux-kernel+bounces-806956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A00C2B49E0A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 02:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36FC37A4895
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 00:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3870B1DDC2B;
	Tue,  9 Sep 2025 00:34:07 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F40214286
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 00:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757378046; cv=none; b=QHFXODSQtRuyQ2U7NpEENxA58cKISyF4sj51m6GPFU4LozDz6eGTUATKBlpd0x3FZYVYFIXHqHj0oZhgCBjwsE7ZGUN3o2YoXJgnXqbNagEFCJszOJbdrWNlpkEo0bZWCHTXMvvnYcecBqUQrpAWpHHV1ghlpcOBSVSbFWK9cnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757378046; c=relaxed/simple;
	bh=K3+lL9PqlDmEMzbUay2kC34xUshRy/GX1qHBB8iJdq8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eHU6VZmpUcDKcyyHQ86iamRT5QBvQwVNUvBtLINyeRxyGmUGT/IEjgdrlRt4FQxzKGbRLKLNXIKUsKBNm6Aon1Iji/OCjBLCSVTJ0vFIgwhmEXpUwz7r8DrNdBDBd0BiVttUH6pQzgcx3j38w/dhu4bmi/GpjQu5lzVfCUaotZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-88a930b80bdso27082239f.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 17:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757378044; x=1757982844;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u4I5RM6+E507Ql78W74jhu8G/RkWwhi1oNqPYDJ7lm8=;
        b=PfQFIKe2cYL66BczPDF+EIqU2mOkOUafTPjZOHVMQEQ1ku2NUX8tTV9mEZdWK6RAVE
         U4gGwm+TGr3e8WfGrB7Bm0XdoigiqyWHFItA25OUOWzfnvABqZsBfyJMqhS+A9/V73yB
         2139lrSVYviIWgDsVHlvbM9uO209gjzw5T6N7cvaacDDU/kcASmNqHhsQBYg08WDBsaj
         1xQKxq5q/ED8Nd3vFzjuz7uI+lVeCOWTT3xUFybp8poKn9rXjCzeDw/l2GdOIAp7xrtq
         6gv2ehD6jPbtvuLKHIbuDyYQnIuGoXHQc5UgDMCZeDpKPrSKHTFX1oJYtBQmERIRpeUC
         n72w==
X-Forwarded-Encrypted: i=1; AJvYcCUSajNsX9MIn1y0PHgoo0d6zPZMFDS7X0E2Xn8ROgEJ9PWym5jSVp5lmCHOHVcKwh9csSPQJy8+Ax8Vg7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL3vKOpzxXBwGMQwtEjUM8lliUnCqL9tnRkh4RvC2cRCP4o0rK
	0w/i+OBtOZN5gh5TYIkAOjHVdjoc7wX/YRuyZvX5XyWX6ZKGZdlPQqIBLIG0/d8bhCd08qpY3eu
	Wk+MxVfb6Gl/MU+B3wNhpqg172XoPrh3ChDgK7zCndxBNvi+yd2ODgSRaDLQ=
X-Google-Smtp-Source: AGHT+IFUG2Lbi2ZtCx+LhTwyId11/6fZ1A9ihMm4fmSLUzH7AvG6ggzSZHu5unzF37b3pjPOztBGstTNDEViV9pfBWVQveEM94Fl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:144a:b0:3f6:554f:f839 with SMTP id
 e9e14a558f8ab-3fd89ce42f0mr143617105ab.26.1757378044608; Mon, 08 Sep 2025
 17:34:04 -0700 (PDT)
Date: Mon, 08 Sep 2025 17:34:04 -0700
In-Reply-To: <tencent_31282D116C4C9408EAF6ED0ECC4478466E0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68bf75fc.a00a0220.eb3d.0037.GAE@google.com>
Subject: Re: [syzbot] [serial?] general protection fault in vc_deallocate
From: syzbot <syzbot+f6cb41c144427dc0796a@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f6cb41c144427dc0796a@syzkaller.appspotmail.com
Tested-by: syzbot+f6cb41c144427dc0796a@syzkaller.appspotmail.com

Tested on:

commit:         3e8e5822 Add linux-next specific files for 20250908
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14fdf562580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=69cfefa929ab96f7
dashboard link: https://syzkaller.appspot.com/bug?extid=f6cb41c144427dc0796a
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=170cd87c580000

Note: testing is done by a robot and is best-effort only.

