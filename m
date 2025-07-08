Return-Path: <linux-kernel+bounces-721533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEE3AFCA7E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 787BA3B0C7C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756D42DC321;
	Tue,  8 Jul 2025 12:37:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACBD207E1D
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 12:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751978226; cv=none; b=YRfUXV7BpXh2nFrhPgWbMOcQXrjzo/8GS9IWwKN1R+hWUcdXsMZqGRQzQMb63VuAi4P6C+51JKc0nqMdnMWM/hdy5kqbQGvO36tNn+GpCt88X5CI3m+gS5gGUpG34sA9e18cg+yQDA8mmlKcltk1paSCHeFwOm8FZjYMhdA9uIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751978226; c=relaxed/simple;
	bh=NiaLC1kOzQSajVbgOiFMfYT2M9+rsOYhNzsoKTi6aP8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KF5c5l3AX2rz49ev8+sKAP6FQUGrb+fCAN/jCsNwxDwtANVjpqTKK8tZh3TKnhWQdDp32+vPWYTnKA9QD6pZD69tlAcjEL/RfF9fEKT/U8TKHegSGuT+nPzO16EXpOTUwVsMoW5GufliIGAAwmjBbXVTOX2WafhYbvVVXRqGxSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3df2d0b7c50so45288225ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 05:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751978223; x=1752583023;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KqwVKDZBWUDeSaVShZCn74Jn+leR/3Vqmynug4SaDs8=;
        b=B1bHFID8fb6gw2qYPy+jMkiTYVb+Fw703YsYprj5te9Ubn/6pRgWH4CqzZb3/YxPn+
         i+jrvKR98CTCPgmkfv/42+SubNEY1GBH+pI1LJboQ/WnSQPdBLSccpcfEQgFs+G3OCSj
         WjdpwLcotKehSJS/e6nPY9GLLzGIidtX1n9slvi8MQwuYXQSYkoOSE5jnIH4RGhjcixg
         /DaPu0j75lbut7xpV5/vtvuOy7ThM1b0dIfoa71xuWKXw9ffauuQ8loOAPrYWxM5Nhjj
         +Y5fV7zAXe3DdmdOmjrtEHfDIzg2X7VQfzDaxS4poz54zE8Oca6kyYMRxjopwQRM2Whf
         xiCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAI/oKZgMQew2X06gCnUBqoqOI7nG5woA6TIOkYJ738wx/N86+LKdv7zrB6EDJu5QEIYZREObBrtqsYW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzteT55i3GkiqwuO8dYKjw26tYDmeAuPDAADDM9BxGslTjIBQSz
	9oPWCs+t8moEliQsy6cvFn+lZ4QVlHq+z2R37OybiFKi4YtNbisumeDN7Et1QQ50eCWJFCOFgj7
	5GvP7dQnWzc2aMzEbCmytNKAiSrsA5/dS+T/eV1whW8urSD5Vwev7+mokKm4=
X-Google-Smtp-Source: AGHT+IG0NbL6ufL8z2VwDwUeRsvs1buYEGE0+VaNN2h9ng3jiat07g8+cscfNZOGOcUFRL/7JOQb1H7/SQghvBR2FsYDtqFHPglq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aae:b0:3df:3828:17a0 with SMTP id
 e9e14a558f8ab-3e1371e51d2mr154085425ab.18.1751978223646; Tue, 08 Jul 2025
 05:37:03 -0700 (PDT)
Date: Tue, 08 Jul 2025 05:37:03 -0700
In-Reply-To: <tencent_210D8125898DA092485D96DDC8991CCF9307@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686d10ef.050a0220.1ffab7.0008.GAE@google.com>
Subject: Re: [syzbot] [kernel?] UBSAN: shift-out-of-bounds in aio_iiro_16_attach
From: syzbot <syzbot+f1bb7e4ea47ea12b535c@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f1bb7e4ea47ea12b535c@syzkaller.appspotmail.com
Tested-by: syzbot+f1bb7e4ea47ea12b535c@syzkaller.appspotmail.com

Tested on:

commit:         d7b8f8e2 Linux 6.16-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=121eabd4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a09d8660a55f005f
dashboard link: https://syzkaller.appspot.com/bug?extid=f1bb7e4ea47ea12b535c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12734a8c580000

Note: testing is done by a robot and is best-effort only.

