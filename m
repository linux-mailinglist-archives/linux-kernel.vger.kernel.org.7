Return-Path: <linux-kernel+bounces-873561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18439C142DC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B8225E3FCE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5E03112B4;
	Tue, 28 Oct 2025 10:42:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB882307AE4
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648125; cv=none; b=a8f+KtcLWYi17ie9zjYu0uu4qtGMx+FiAupocaviHMVHHDnBIzXokKaC6i1G/2YOukDG11mvGEHiCLbUnCVEGYyeyr92ntIaZvVED4DVZgPDlkSRY+Iq7tACSPSudJBfEVTQfyv19tPpS5sgkea6+Uk7IcW0xCoOP7UVi5axvxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648125; c=relaxed/simple;
	bh=8Nx+mcduxa3sf5cWnXWVIFC/q85m3Ms8MjVfPaM7jw0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TATGd9g1p1WP3pDEMX8wIBr8lieCqlYRU9O6ESCu4A7qqArj9IRH2b0LuSmKYxKSkIL5aEicOaRjlHZSmYPYV9lMB1qsH1hdKTNa2gABBoA72i5K66YsC7C2vIeUl1wvQQgLkcP0kRnGiyOjSav4KXRlvZ7XLTZWsA7cj4Jhdh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-945a4849260so859829039f.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761648122; x=1762252922;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dNjFUJz/UkjxeOhyzvnm6OAdK+rGSGToEPjpqTdCzco=;
        b=PbivIAvziKoGQ5uXTFL5fQGP+1S2ljTo/vxUPAFn5xZfzDaCRMBHCFlYOjXD84o7AK
         v9JPeL+FNmCUFJ8SI6u81srIRrB/tU4dcvumM4R/j+ofHQOEGW28BHN2Rbv0pyALJmaM
         Zc1/HEnxfsdq3oI5g8uOP2zPmhbkmMZdmAQf6TR1JnSbLmwU5C264ETUPp66eCKCVUE6
         p+ocu4HLIZASg5O26ZchoqaJqDYqmbvZ5B4B1qIYEZf2CR5fwRYay4Y+YWvT8YACq+Xw
         2T5hW9c1cHrPWc4huPjaTmCIDMg3C69dOE00aX6551eP/7LeebW4KFU7NnI8xw+eLGU9
         iXrg==
X-Forwarded-Encrypted: i=1; AJvYcCWv5DsY3NVNmHO0ApSjlaAyxEzcw+Ul/eOovxncfrbKn9dxMD9zDIDNI/S3td8JSZfgaA3RVb8taz5B8T8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmV3tTQid87MYbC9EDoeLkUAKMY+gXNKkoXxFeXg0jTJWPY8pW
	/oyn0tD/71AVlsX3D61KOxGadFfAmq/pQAi3LtT1AWCfnITp1rcHiOecqbV4Fs33b+Rj1fKUkDK
	ogAvQSuaxyXIWkYpoYWMZVF0ZvUUQtVa/ytDgF6JE853z1fQHBIefLzoTf10=
X-Google-Smtp-Source: AGHT+IFst9DGhDGeazb9qSo2Jcch/GvcO7UoD2buVDYHnq0jdRLrfPU/OFx3R0SAgt3wcxIrsKyn2vwsy+Qlk/ICbfPZDIVlQglX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c249:0:b0:430:b7c4:6617 with SMTP id
 e9e14a558f8ab-4320f833c77mr43751725ab.15.1761648122688; Tue, 28 Oct 2025
 03:42:02 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:42:02 -0700
In-Reply-To: <20251028104005.KTUK2%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69009dfa.050a0220.32483.017e.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in __ocfs2_move_extent
From: syzbot <syzbot+727d161855d11d81e411@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/linux-5.10.y: failed to run ["git" "fetch" "--force" "4d52a57a3858a6eee0d0b25cc3a0c9533f747d8f" "linux-5.10.y"]: exit status 128


Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux-5.10.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=84e81c4d0c0e900a
dashboard link: https://syzkaller.appspot.com/bug?extid=727d161855d11d81e411
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=137157e2580000


