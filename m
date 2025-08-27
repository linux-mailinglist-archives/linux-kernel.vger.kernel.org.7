Return-Path: <linux-kernel+bounces-788752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7A7B389D0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 20:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FFC97B4334
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 18:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F14C1E47A3;
	Wed, 27 Aug 2025 18:48:08 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1497A944
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 18:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756320488; cv=none; b=RKH42C4avyP/LxedeoiD6brHFM2gLczrujRDH+NuWeU6W3c5ZVmLjKlPVtVwMBn2OY7/QVG12t7Ay6QbmXMoXJygs9pSkSvUfNDDDWtGcAIYYhUA18JNBklOHDC+eNS7Hv8TPoifktMgfrFl4dGnJzM+Bt7EVX2GqJ81VY34KLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756320488; c=relaxed/simple;
	bh=ZKABwh8CPMiBrKVh8SSKQwWIe8IPvKJSfpJYNTT+9kI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uGmhfcJy+SzF7lxOEevpdf75HqQ+cpEG9rgZ0QC9om8kkOds5Vw7jc8PDvQ8SYPJZUq8X4kgcCQlOmKfAgoQHuxIeEAzOOy/kjJHqO5MJjh4my7hTIusMnFLysu3O/Kp7hHBowziLVyNiaARmr6W4iOU7Ed8DtFIYbcLWW35CK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3eee0110eb5so2786615ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 11:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756320486; x=1756925286;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZmRIpbQm+3yh9D0kp02qhNvxq2hCOcLzVcLSfknKG8=;
        b=umYMkGSzeBu8sJlcYyJ8XF4N06ZVBPq97U5YTD9E3IDTjVRqMQizA5u8iy671/fZ9s
         qtt8LSmM/oBhDfjD2Y4+MbLuIrB22Qp+Wn34D1xVGvRDg4T7zFJwPWnr0QRPSC1EZ34W
         U8bRVsAOSxARrNz/73o7iU05ZUZHG0nPaHv93HrOXGXWbqXzdWIurPIb3PKH7vHRhkdB
         VMYsNn3kvdhhvyDU0JXrWB623hnfTJpl1NmDpWtM+jsJaFeFqNj5pWnLRu0e9lmXq2+X
         AiB1dghX4qOnK2HcKyujbnRGpozlQRDPdhmCfhjPSSzkh4WifYa1RPxvjeiZA/N27IrW
         WMmw==
X-Forwarded-Encrypted: i=1; AJvYcCU53YV4q8kaECguamxY4FyuXzRDCI5W3tLAZzhQvQPIP7U43INjcPHOoLlnV0Wd2TxmfxEN9a5YpmfF/3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr8Asnolv5IbzuNMK3i5mQ417bYTyrw1yK1mbE49y4sCWfnKfb
	Kr49Em/FFuz1YRGC5jn/V0wHy1NpEmukNpVz4TnmkugeVOjPtkK/+ITXwCOAcme8Sg0a9LuSbrB
	ZjtzLNieAXtCPY15mB/p21R86XVMCVLxGK78RA1fkb8ppAeTlcfN9Trb5kh4=
X-Google-Smtp-Source: AGHT+IGxdf+5asFtx9Ejzpxtt7kfXutYSWZMjvbIUMS6RRXvb8DQ+zfYkl+ZHwyu6Q09DYlJekMtS2fu5XruHw0bFv+t5+JaKr0M
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b41:b0:3ed:4f7a:9065 with SMTP id
 e9e14a558f8ab-3ed4f7a9383mr140209645ab.28.1756320485955; Wed, 27 Aug 2025
 11:48:05 -0700 (PDT)
Date: Wed, 27 Aug 2025 11:48:05 -0700
In-Reply-To: <CAOQ4uxh_yrq76Rq9RoykGdANZNBWc16UgbSBRjDtXKeLdA7-3Q@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68af52e5.a70a0220.3cafd4.0030.GAE@google.com>
Subject: Re: [syzbot] [overlayfs?] WARNING in shmem_unlink
From: syzbot <syzbot+ec9fab8b7f0386b98a17@syzkaller.appspotmail.com>
To: amir73il@gmail.com, andrealmeid@igalia.com, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, miklos@szeredi.hu, neil@brown.name, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ec9fab8b7f0386b98a17@syzkaller.appspotmail.com
Tested-by: syzbot+ec9fab8b7f0386b98a17@syzkaller.appspotmail.com

Tested on:

commit:         5dfcd103 ovl: adapt ovl_parent_lock() to casefolded di..
git tree:       https://github.com/amir73il/linux ovl_casefold
console output: https://syzkaller.appspot.com/x/log.txt?x=1040fc62580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e1566c7726877e
dashboard link: https://syzkaller.appspot.com/bug?extid=ec9fab8b7f0386b98a17
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

