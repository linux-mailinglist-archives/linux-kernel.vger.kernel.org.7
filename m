Return-Path: <linux-kernel+bounces-866576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D38FC00231
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EBB61A640C3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1232F7453;
	Thu, 23 Oct 2025 09:09:43 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3293D2DF14B
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761210582; cv=none; b=N8f3QsRaAFPOaP+x9zcYFa/J3or36wBvbZpMM8n0iP+Oc2ATeOMaS33PjqYeKQff7uiLA1FJaymOYEIt0YwgA+6tdSHNgwry4jCRnfu8UJj4PuDjmsKP1Hgj///vP9M+EoS6KJ+mSl+rlLphjKI3fOMdHSKgYm92x6IAwLDU1y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761210582; c=relaxed/simple;
	bh=aembbJrZ/KLVaZOxaCYe2QJ9igM5qig4Wygk+wVnmE4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=d9FnDqxXPG3QKC7CGHELMJKBCdpryco6ojbuU4xuyhju/+RiMfSv88nzibjr9Gt7hftsN+0jW2Wxm2oZOouWIPmyLEUsrhA2tviWdRcIEAwKlP/3pd6X/o0F/rWDxR6Gv5UwvwrglNv3f8peD1KLAXlxybvgvRz7iHeMe24z7sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430d83d262fso24715705ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 02:09:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761210580; x=1761815380;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aembbJrZ/KLVaZOxaCYe2QJ9igM5qig4Wygk+wVnmE4=;
        b=KOal7O05UNxxjsruyjo+GMlXmd65g2XjntLbLNzFd0hwdOFOP5S9L1T65fcFuo5qaf
         wYRBBGSNsOeFtVGeO5QFCMLaZRcN7vEy9a2frsVrkABr4MZleWEAe2dc+ephW7FuZrPQ
         TsAb00/vrAgKfiGj4Pbt32YKa2X4nMaGZkY8KFH6PkevzS8TOKFpmJaCnunlRSt1TlJ3
         wnzYUpPcfePtkRiyAvTVBtvAALNj4DgSkKt6x6mBIMDbdxI2SXLTPE40hM2e97SKcpok
         qKNNJKjGoEj1ItYDVQnvtLEyulRe2NDaBScixDyDpyYr2Mjon0qlQwolMNiB5UeHFxYD
         liSg==
X-Gm-Message-State: AOJu0YxmiNoIvPFocizXoNGcrkJTlXyg3+3H4WXpdlY50UopZE0pIiJr
	RxQlWh7CFefmzMdUpdFgnDweaviZ8GCbKYPpXHkmeSPhGppbZqFPr8raCCu71eLdTJHJJeXFBhW
	WArw6lf0t//99IrWXDEjBRsD8pU99mnyVLOHEMXNctzNarbdwnrbbrkgr860=
X-Google-Smtp-Source: AGHT+IGXIMC9/5+iFnk7kqwvrhCYTg51Il6cM1VndLmtMr3mubCI8NVFTOiT47W+3LABU+nYg48hkuT3CKKGOgK0slWvHJkFj+BT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a82:b0:430:cf19:e682 with SMTP id
 e9e14a558f8ab-430cf19e837mr321981575ab.13.1761210580308; Thu, 23 Oct 2025
 02:09:40 -0700 (PDT)
Date: Thu, 23 Oct 2025 02:09:40 -0700
In-Reply-To: <00000000000097e14f0621951335@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f9f0d4.a70a0220.3bf6c6.0036.GAE@google.com>
Subject: Forwarded: Re: NTFS3 : KMSAN: uninit-value in sw842_compress
From: syzbot <syzbot+17cae3c0a5b0acdc327d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: NTFS3 : KMSAN: uninit-value in sw842_compress
Author: kubik.bartlomiej@gmail.com

#syz test

