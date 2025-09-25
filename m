Return-Path: <linux-kernel+bounces-832594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C692B9FDA9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E0B34A1651
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD7D285C8A;
	Thu, 25 Sep 2025 14:05:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133B61624D5
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758809105; cv=none; b=Te7EQZKn1StInFyFucSLH4L14MeRCOIEm2F/2wo6YTF+xTFamzWB3oMCKvM0Yvz/RJDNs+1umfo5yxRowW0qx7YlqNNSAOgUtLiPoNq3GLx67D9r7GHzXtdASfamwsT+b/lz55gyMnfr/McaKu3cD93lxEhdfZxWFCuuNAvEe2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758809105; c=relaxed/simple;
	bh=HKg9upNcnCL1amMzv2y+x9bf3ls2oMVgy24N1UBby34=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dOp6U7LfnloG/4AtetuuGvTfC9NDT34dCFFBr4q+QTbB7jG9fcz6SFh3Qh/iEHnbOPSNiZ5f8AGebuQq+/FSkHrAYRnqXoEhcrNFJ9J0lXKd0OCKuDkayvb12zo4aossiumny4HdCU4PgaMg5jdU27A29WfwVhd/RiKGwfPtSUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42640cbf7f2so12959785ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758809103; x=1759413903;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A4V2Ec4VZmuKgjGoIiuMDPrRQCHKno/939bahIo0cRo=;
        b=oyX5KJGDsyJaVBIA1buCxybOWDgMxkH2Z1K6Kj/icc8iXsKeCWOG0bCADmJStbqvEr
         EsEME0Ui8rHV6jZGkcwDPUNcdK5XrCbLT0IfDRY7zMTpzpfioMH7FlaTNrUHCM/TEoEL
         4EFXk0dy0iz58tekH/eMNOfeAtnQyAC27wqcnaiJXCtF+0Ngp/z2KHCOAckKeG9XRM6S
         g5ph9Ay2LeQuWHPmBRBMADN7xoqUmWi4KoDw4Gi8rBTQgINJ4W1KQk05SLKzXX0EAJdX
         XsiVIo8rgZ2J3HiLz886yLR2w+m3nr1//XkH0TBnYmCMS4XukIpbJ2lGhahMGOYYHrOe
         kOwA==
X-Forwarded-Encrypted: i=1; AJvYcCXNISczNIVL/CU95115YSQ1CvTXtFQGTAArBBsP9OoQJyWKgSg3YaJ1ZF4y2b5fK6d5vzoMOOwRj3cipMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJBXnxHEoM6ayKC4s+3Tb7QAWMz6CXt0dTTgenv0/k5SAa0CUy
	egfE7P27xzmg+cOzjf+h+XEoEn3GyCrD6ZwjIZWFATJy64kPBESI9yM0FhC/IhUOkCSxctbFln3
	RjDLGX1BJM++RLVwH21qf/rvF2uMJusKIMt/r2Ef96J/vVicgpDiU0ZTBIRs=
X-Google-Smtp-Source: AGHT+IHGippsnIcR2RCIQrGE9ODes82942a+ZRAP2etQzY366n81iyN7azmK9T9Q8s9hW+7UHuQBxL4m9I9gL0XVIogV1CPIG9ka
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26b:0:b0:410:cae9:a089 with SMTP id
 e9e14a558f8ab-425955ca5e7mr47844125ab.2.1758809103107; Thu, 25 Sep 2025
 07:05:03 -0700 (PDT)
Date: Thu, 25 Sep 2025 07:05:03 -0700
In-Reply-To: <CADfthj1pNb0LhZy9dTMAavNXNdJxMnNdWj2LQiaAf-iO4Dn7Mw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d54c0f.a00a0220.303701.0011.GAE@google.com>
Subject: Re: [syzbot] [fbdev?] KASAN: vmalloc-out-of-bounds Write in imageblit (5)
From: syzbot <syzbot+48b0652a95834717f190@syzkaller.appspotmail.com>
To: albinbabuvarghese20@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

drivers/video/fbdev/core/fb_imageblit.h:499:115: error: expected ';' before ')' token
drivers/video/fbdev/core/fb_imageblit.h:499:115: error: expected statement before ')' token


Tested on:

commit:         bf40f4b8 Merge tag 'probes-fixes-v6.17-rc7' of git://g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f01d8629880e620
dashboard link: https://syzkaller.appspot.com/bug?extid=48b0652a95834717f190
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15f1e142580000


