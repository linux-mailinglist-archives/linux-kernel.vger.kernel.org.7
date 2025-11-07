Return-Path: <linux-kernel+bounces-890976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4A0C41815
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 21:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 968841881515
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 20:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0FA2FCC10;
	Fri,  7 Nov 2025 20:06:29 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AEA2E2DF2
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 20:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762545988; cv=none; b=MrDvXgYw713QN09VhNJNBtGKxEWh8t4lT4lbgCajY6fh1YjA5iK6x+Zoe22UH+oUiWAKAd08NUyyIBhfZSV/Tj3HQzt19VLol3cp3PnhgMvHlWNTM6MAYSSwu1g0aeEAaeVEJ5z6VlbIlIK/HI9S22ImaHo+D4+ZdrattrcDZk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762545988; c=relaxed/simple;
	bh=hhrDtgI9cR8wggHF4FiuSGSZU1jgsZ717HlG9zDrSwQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uhi97Xdc/CnTL6VrkarqznW0x9/TnydyNfz8snM/piYwQqldUQi9KZ+t4ZMtYj2bxweWVF9M8tx9VnmvlIYUWqwnk1QLUVdZyln3VUUbUu8hW4d4B6HjztrLEGwky3DVDPsZ+p1oIDmegU1f8S/hxv9JL8sq16m/jc8a1Bfa6sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4330ead8432so12365575ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 12:06:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762545986; x=1763150786;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zOiOQqNBEl6Jnrendj9y0bQJW7i0gr4vRbN1xeJU2t0=;
        b=Fc47/uJqrbBmNX3z+duYSt62/6KiktFOfzXCBkOTFLutqPE9CimevamZKq1ALh9piP
         DeBvz5KrZfv306gwx3wwF4Xe+PySuyQ8mHOGLTpkRAKgUIuO7iy5EFdvaid2Kvup5CWD
         WoJ1EL1M8M001FOh7ik6mtPqGg5SmnHqnsWHZ+93yDZJw9BddbxEohiBMvO68yeNLx+b
         yI7TrECDtiy6p1nga2LiX4++lGnpFmP5RtWvbu6CjO7HJndKp+IdZS+H/q72FdzjTup+
         6tac8MdYUiM1AafbpGLfw83ltimwoYZdkw4B4vOcWigZVoI16fKYDwkDRXLLIBI4g8z+
         G/Hw==
X-Gm-Message-State: AOJu0YwC1V6rRWOvU37oChCLGNHo1djPcwmO6QQ64eiBtTuhdd44IVAz
	mcYaDcxNmmP1NSaVKeq6ODXqW4JNSF4BU0zgzSjazIVgBte6ck0Art3MmuPg/uQU6Ddezk4DcmP
	IJO7yx1GmZXgCgpswFlCSa3iQFIK6Bmxuvn1wKo5vt9zW0su5KwuoGYWsubI=
X-Google-Smtp-Source: AGHT+IEKWn+RJJ7jQrf5ruSBJ3mUrY5DVRSFUDPXYzHohwm450eIxqKwTpXxOuQHYPyANd8MZthoHyaiS5IZX8zORQRN6RqaR29k
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3708:b0:426:c373:25f5 with SMTP id
 e9e14a558f8ab-43367e48b25mr10849885ab.17.1762545986478; Fri, 07 Nov 2025
 12:06:26 -0800 (PST)
Date: Fri, 07 Nov 2025 12:06:26 -0800
In-Reply-To: <68dc3dac.a00a0220.102ee.004f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690e5142.a70a0220.22f260.005e.GAE@google.com>
Subject: Forwarded: syz test
From: syzbot <syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: syz test
Author: kriish.sharma2006@gmail.com

#syz test


 drivers/infiniband/core/addr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index 61596cda2b65..f33d8040bbd5 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -93,13 +93,16 @@ static inline bool ib_nl_is_good_ip_resp(const
struct nlmsghdr *nlh)
  if (ret)
  return false;

+ if (!tb[LS_NLA_TYPE_DGID])
+ return -EINVAL;;
+
  return true;
 }

 static void ib_nl_process_good_ip_rsep(const struct nlmsghdr *nlh)
 {
  const struct nlattr *head, *curr;
- union ib_gid gid;
+ union ib_gid gid = {};
  struct addr_req *req;
  int len, rem;
  int found = 0;

