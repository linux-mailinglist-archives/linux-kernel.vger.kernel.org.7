Return-Path: <linux-kernel+bounces-738387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 563F5B0B7C5
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 20:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90AC917886F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 18:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119332236E3;
	Sun, 20 Jul 2025 18:45:02 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498871459FA
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 18:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753037101; cv=none; b=YR+rnfVp97cf3EdkYEyRbkBakTY+eokLyR6Eev7d8EJqJFGV9z87NIDbbFteB3lwfTCOBA44Cek5XsYxYoNmk4+/f1YcURRRI4EHsC7AlQeOyMwxTVB4pv4on2Unuy+kpuCoUb8Y2sW7DR28tYvZFH2ODV3yaCURxYWKdGy4Ra4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753037101; c=relaxed/simple;
	bh=DQ0NEENPCBTpZyaTtoU8GfUVkF/Uqo9WC+e+NQwgaOI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=T9sTVW8ltZb8MHIsA5gxeZcaCbfxLXLfkQMCUgLM2HLtRGBvde4r0GDgnKQteYJD6j4R//gqxJxjx3sYxvqedWSTwM4fuiHyR4tAncM7E4gkSevryrQjnMi4cSjnwmoNEpL13b1TQ1jpMCuduLZ7+26C803XyEQ5mFNP8H7SdqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8760733a107so415432739f.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 11:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753037099; x=1753641899;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S4EYITGGZi2gqLZESnxNwV6iotiFGvIBVJDWGQzkip8=;
        b=qAgif78+vb7PX1IKruyRKo6m7fk/PNq3duSlbe7S/eAbfnIYMLVT+2swKTj14hQhZw
         790TUmZZvGWlEKLOMLb50MhqxccBKCS8CQIyDJDhZYzkicps+L+N3JJ8eaExCOl0N3Vz
         AYJ0GjfOImBDDlkssF+coEKTohRtfBFeMKtWUeLpEZAGLf1PVrmg9VFMOMsaq7DghCrh
         nKletZgZSqgttmusmdNlCm8EMwmAJTiSFr7mj70BKFy2+KLyGi4+UkB9B///EzAuNYvK
         Ghwf4v310ibia+FKfMVIwHxHCSc8J2a1VwZJuZEy/wtU18f65Ee3cdunJOyP5CHC6w/E
         034Q==
X-Gm-Message-State: AOJu0YwOoUse1hL63Ersg6e+aJpTMb3ppmGH80Q1NlZwDH3lYmSpBTwR
	solx9MNJqplnddOgmQhnBnjduHErwKLS3G8XyjfdMV7Xb6c8Bmy299FXCFbmiZdKJ438F4c6zUU
	9WHM6XaEyXI8l1853UC31DgDhGCFkeLf3Dx6D6iP0i0VGkMKZeIMvOoFf6ac=
X-Google-Smtp-Source: AGHT+IH3vwZMhiiVpJZucGxFH2lhk5nK+K7/fg2JX+7n1+Y9oEIcMS811GR3JsuKq81Wmxj/i20o0xcLiBDKkbvK8zD1JIgjYtWy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:5e87:b0:3e2:a3b9:fe36 with SMTP id
 e9e14a558f8ab-3e2a3ba47d7mr36423025ab.10.1753037099427; Sun, 20 Jul 2025
 11:44:59 -0700 (PDT)
Date: Sun, 20 Jul 2025 11:44:59 -0700
In-Reply-To: <687bd5fe.a70a0220.693ce.0091.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687d392b.a70a0220.693ce.00d3.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [io-uring?] KASAN: slab-use-after-free Read
 in io_poll_remove_entries
From: syzbot <syzbot+01523a0ae5600aef5895@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [io-uring?] KASAN: slab-use-after-free Read in io_poll_remove_entries
Author: axboe@kernel.dk

#syz set subsystems: kernel

As per other replies, definitely not an io_uring issue and no comedi
subsystem exists.

-- 
Jens Axboe


