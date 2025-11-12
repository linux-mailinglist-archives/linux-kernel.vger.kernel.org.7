Return-Path: <linux-kernel+bounces-897805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D32C539FC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 10121345BFC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA9A32825C;
	Wed, 12 Nov 2025 17:16:08 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B951199939
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762967768; cv=none; b=c8nJUPWmgWVh+hMzpRkjjrYeE1IfFbwYDanf7S7svAK7BiGLhsfttLDzL5EFPWgnUi8UoMa3jJ0A4hBB4UcEzidKnw/eHNwpOk1X7e5lSU9w1MA4sPdm0UuV8Py52hg65eYgNa4zp6lUKmP7nn89cDMDWAzYkkf8fWfLl6yja8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762967768; c=relaxed/simple;
	bh=LLRpqKf2OQual0Xd886KZPna4Rrlj4e6Cs+uISGSbqY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rWHzJpMYxmcbCNvXVz23wyIerZK3DZTBV4hyzJDt83ybREtSsIa9mSELQIc4yItQvXoCuYNNXLbgbxhFCnKz/b/n0ZHgJmgRvDzvM3uWAmI1wDtwfeOuBIm9dGUYcc69hTadunesgN3+KQ/HPORk8MWfB7rpobmaWSAB+FI+wJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-43376637642so11539955ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:16:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762967764; x=1763572564;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qIZagm7PY5Vqrf/AsqeZx+IteYacJLML22dt5R2/KV4=;
        b=o3njq1WqZmOyP2NWZjjX2WVCSwKMgAAdRL0alOpqVHKoJYDR44gST6857Sl9te48OY
         mAC9wk29AHQjjCF/ZnLinMPQ/bKfXZzIEv2eYHcKogcaUwmss20YDDqGIwzsdpJGsYym
         pLaxm+IbD3GMBjKNMKalunLAis/RvBfExnLgivtjqieOVv2XjEH50lfjTDgPddm/LEGI
         jPd02pQkPNQs+ZO4eQ/cg6+dSjGsQD/Bll8AxRwu3lECwqoa7t3/F8GL1vLWMU2IgI3b
         XivdAVCIc9P/qPNfisKccy/C6b1S5AIiD6Om8VNrscnmeqM1TysWsbx2peBNTdQJB4f5
         4ldQ==
X-Gm-Message-State: AOJu0Yw5p30x934IZy9Q/OaM4ETpGzhDn/+lCEDl2wXEaTODi1PkOlYa
	wOwz1sd+Hkp8fpnVVt8bArOeR+9JZBb63X0V37LKArqnb4SV0X+RW74Das98ENTXqu3LgtFouhN
	o0RddZJc0vyT6VRkog40I1dU0CNMpsLWN+ASYS82jVve9qVDLeiTWHDgJ8Lc=
X-Google-Smtp-Source: AGHT+IFBCXhPQ5+vvu5B/JgVSVdMWhHJtcT/+CoGdkX8huZH1zZQFoYqWply+RGD3nLQtX0EnZg//JZWsHHLqEF7X0iMH/Cwr1Gc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1909:b0:42e:72ee:cde6 with SMTP id
 e9e14a558f8ab-43473d11968mr53504465ab.12.1762967763604; Wed, 12 Nov 2025
 09:16:03 -0800 (PST)
Date: Wed, 12 Nov 2025 09:16:03 -0800
In-Reply-To: <aRS3-Fgb94VD7Msl@rpthibeault-XPS-13-9305>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6914c0d3.a70a0220.3124cb.0009.GAE@google.com>
Subject: Re: [syzbot] [xfs?] KASAN: slab-out-of-bounds Read in xlog_cksum
From: syzbot <syzbot+9f6d080dece587cfdd4c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, rpthibeault@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9f6d080dece587cfdd4c@syzkaller.appspotmail.com
Tested-by: syzbot+9f6d080dece587cfdd4c@syzkaller.appspotmail.com

Tested on:

commit:         24172e0d Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=123d8692580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f0fd60646ed018d
dashboard link: https://syzkaller.appspot.com/bug?extid=9f6d080dece587cfdd4c
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11524914580000

Note: testing is done by a robot and is best-effort only.

