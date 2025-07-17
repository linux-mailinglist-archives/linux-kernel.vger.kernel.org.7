Return-Path: <linux-kernel+bounces-734864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A2CB08751
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA9693AB585
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 07:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9908F257AF8;
	Thu, 17 Jul 2025 07:47:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C1F253934
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 07:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752738425; cv=none; b=Ey8JNtrmNDwJFdu1PTZSO5Okv19Hu0ZukRh13v1KGKNf1lU6Qlktd8ngAYxeuPmM8aA/+vg5g+svshdqF3+eCSOM2529gEyb6A1izwZ8UUKFHjwnzaWZRFhXy/w/yVA28TYzdAaI5Q6TB3F1ur0aemgdvOAZVfhO/D2PhVvGCzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752738425; c=relaxed/simple;
	bh=oAushCkBvV9QVtlmVzcvZy/T7QeVNIgehZzoxP8tyJI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Z0mHPk4vJgmufb2LTjPyu9FRbQDQxnVOyhVZjoBSUwBB+tCC7wiqxVRj3o9br7hlnt9iTKfW7rbWlKLsWChlQZF4U6wP5Of/fe5lGrFkz7im6hmoZwHV7Xcu/fnHvKCb+VJ8kcPY3qbpAqBmdtIQ1ZMgHCTKOAWRj3xVgGUx8OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-86f4f032308so110458839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 00:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752738423; x=1753343223;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i4XNUZgAi+l283TvCsQpiUhvK+cuI7VeHcRlXxmM9i8=;
        b=EC/qDPVpGV7BASygdNdlWdigCybqe7t7YEImAgvjgvjLSlI2C5bwED5cp/lDI2S3Qg
         RW6GMbwMteSrg4K2XEffPP5aQlw/lzvVA59+BC7AdoF23ARr8rYXMK0E+oS18sYZvdcK
         zkJWsvt0M5aFlbP6+cNuKXt6V+Di67EIiYeu36XYgXtgN3aL+y6n6iNu6lcoIir3rHfM
         Nik8tm7tYvS+abevfwFvL5eB3L2KSwG2xECodOX/mYNjwKMdAsHlKFg0TWafohygrlE4
         VMeAkksqkT5YbRr9tM72ma5ohn3iRUqRU76jdSLZwPUBk+TO1atqVT2O/l9vsZEYeVph
         nUlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlZ2zz5/v47Zb2yATqhsDlRSXEVElJghGX7okdIkZyWP11rgC6lGC+KH5nSHEBqjfoJN+y5Xa/q7JvnpA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww62/0qDtlIXXbyotEe581GVQL+NNc85kwj+8Yfw0Ir1yzbC9m
	cnyPN7dhe4ezpaZVKzvpSMP+6ReU8SndiwaamNXkM5hB+bTchLf8kqmCDz9l/e/P99O0JFnk+pu
	OEAF3Tjk+d4b+lsU2mxCadADRdYh9LPMu1wRncNDBDsUsdFmmZSWuqNDvjN4=
X-Google-Smtp-Source: AGHT+IGz8aHEsyxj7rtahA3L5ydsmqjP1wxPohxhGBIyDbGW2LUyNzgIO3XefJSSds12HTndVIt9ieUIDcFlGhYdL3f9rFlmxmh/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6c0d:b0:86c:e686:ca29 with SMTP id
 ca18e2360f4ac-879c0892211mr769810239f.2.1752738423049; Thu, 17 Jul 2025
 00:47:03 -0700 (PDT)
Date: Thu, 17 Jul 2025 00:47:03 -0700
In-Reply-To: <6828591c.a00a0220.398d88.0248.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6878aa77.a70a0220.693ce.0040.GAE@google.com>
Subject: Re: [syzbot] [overlayfs?] WARNING in ovl_listxattr
From: syzbot <syzbot+4125590f2a9f5b3cdf43@syzkaller.appspotmail.com>
To: amir73il@gmail.com, brauner@kernel.org, eadavis@qq.com, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, lizhi.xu@windriver.com, miklos@szeredi.hu, 
	stephen.smalley.work@gmail.com, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 800d0b9b6a8b1b354637b4194cc167ad1ce2bdd3
Author: Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu Jun 5 16:51:16 2025 +0000

    fs/xattr.c: fix simple_xattr_list()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=173de382580000
start commit:   e9565e23cd89 Merge tag 'sched_ext-for-6.15-rc6-fixes' of g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=5929ac65be9baf3c
dashboard link: https://syzkaller.appspot.com/bug?extid=4125590f2a9f5b3cdf43
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12cb6af4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1301f670580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/xattr.c: fix simple_xattr_list()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

