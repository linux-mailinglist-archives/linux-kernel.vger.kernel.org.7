Return-Path: <linux-kernel+bounces-823865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60525B87994
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 03:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 109137A6CBB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 01:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2790238C36;
	Fri, 19 Sep 2025 01:29:25 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C367722069A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 01:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758245365; cv=none; b=R4uL4K4tdXiLPBeugbAhq77PBUWX6JPBfb6wu/SYDqgAdWdkE3I0T/a+GdndxQhLgyTd3SiWlNc26UhePAbbeO2Yb+9v0rBoEt7lUk66V3zc21qwj90OnSgY4qqfQcA9nPXRA8/yu1BEJqjUK9Nlv8QRQCZdYwXfUdy3bITWMrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758245365; c=relaxed/simple;
	bh=A09M7zGJ5poDd1VXV/aQuZzqoopz8Cvjgvey8UKJhAk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Zuotol3CAgmHCCwtywHAYTGM1qIcWfdhm6guBMtJNAdWebAo4wbUUiSWfGjqnCz1k2YkmYx0/JelLIM8qSPXO5+hBsQ3mFSCCFkRo3xsvecre02LXaUDhNIneoVrwSa38u3YynTnrBoPslJpt7kDPmRMXgoTN44Yb62Pl6QwJ+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4240a41d2caso19349485ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 18:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758245363; x=1758850163;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zoSzpzm+OAkYWS2IRLuWR34e51fxY8fGfADcgfdZygk=;
        b=ERB205gkzszAi9xAzP2jTA9DtinMrj3xylIFpUukVEQcWM5jonMZKW5jOQXdnJKQYS
         Y3Dqu0LoRFXf9A7IVnRnnZ8iRtiVh0vQNdIpZBs32iNBG2gJcc0qXDz1BLChnn3806OZ
         CtdYIQ0VBLaaM7Cc1SEeDysyIOS6dTM/0vr0FIbRRpLudyc9UMe9P4/zmB+EKRnS2EzK
         uowcg4BeQYRNb2KhfCb83UVmmhn2XZr6SOZOm5F6PULkJA6AvuKmaHe1L90dsXQiWwVf
         tJwOGTys6z51QCQ9bfXazkoGGBfhO7KPlmNAw3GtFLPQe12ePJ1Jcq61vbmVQy7bxCuA
         p9Lg==
X-Gm-Message-State: AOJu0Yy4ugjSgJP/TRdl/mOvFNk3vLtLs4ux603iywPXAtVHerCN4euu
	bO35YNr5hTORWqHgaebinWqC7CPN4imhwf3bDG5uyom/TeLdvqOLCY1umYnoYO0CQYU6c7k9A3Y
	z7eMezr25KnM9j8ZBrl2I3D5wsTP+tZN2SUcZS9TRAdm8009Qwg8eZ8SmK1Y=
X-Google-Smtp-Source: AGHT+IGQxHliYcG+W+QP14hPNGkQMMhTNAbPJVhr9oOLXIChmVG0R0mcNKa955HTv2f7qDfvWq9CGkfD5WXLUD7UWPDDuzuJjOUE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1746:b0:424:6fe:43c1 with SMTP id
 e9e14a558f8ab-42481968974mr26152925ab.19.1758245362953; Thu, 18 Sep 2025
 18:29:22 -0700 (PDT)
Date: Thu, 18 Sep 2025 18:29:22 -0700
In-Reply-To: <68cb3c24.050a0220.50883.0028.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ccb1f2.a00a0220.37dadf.0010.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [netfs?] INFO: task hung in vfs_utimes (3)
From: syzbot <syzbot+3815dce0acab6c55984e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [netfs?] INFO: task hung in vfs_utimes (3)
Author: lizhi.xu@windriver.com

#syz test

diff --git a/fs/pipe.c b/fs/pipe.c
index 731622d0738d..ca7a6746f8ef 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -356,8 +356,8 @@ anon_pipe_read(struct kiocb *iocb, struct iov_iter *to)
 				buf->len = 0;
 			}
 
+			wake_writer |= pipe_full(head, tail, pipe->max_usage);
 			if (!buf->len) {
-				wake_writer |= pipe_full(head, tail, pipe->max_usage);
 				tail = pipe_update_tail(pipe, buf, tail);
 			}
 			total_len -= chars;

