Return-Path: <linux-kernel+bounces-731003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC54B04D66
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 03:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA24E1AA0D92
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 01:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882D31B4231;
	Tue, 15 Jul 2025 01:27:07 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26112CCC5
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 01:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752542827; cv=none; b=aFthQYoEqn/SdeqiRvovGJGI+ve9lq08xOcX5cQogh2nZrV3Frs9secUS6c+m2KH9/g1L8aSx+eCBOxADxDb+yvVnnX3dKTvWOs18QSerdZ3aCSiAhsEQbpObjIZFLHoxf5iZ8TJ/LcXPXQ6aSrTCygURzeW0Hz0sFPET/3VdcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752542827; c=relaxed/simple;
	bh=o4ynSAGx3+TTcBXiUL2Rxh4BKd+kJlEP+kAE4q3Ea14=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Y6ymeF9Q40CjzsjRAFon732bRyWcwr2QL3+kPrG6AxSaGdKDqRvgykXGwH078fBAA+zlM02Va6T3KDvI2y1UWwRorYf/5SKc4SgSefqeB1i0329biT+GCnS3ZasrnFzyDOb4reuzfuXB6BDiy5vaQ14w3kuAF9UiA5nQvUzWTiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-873fd6e896bso519782639f.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 18:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752542825; x=1753147625;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BoH4lg9vmmUdD5h4nj7VuM+JBKpdp1mdWhKXqK4cfQo=;
        b=Pfe7Bqwykq7l6kfq2mvQVz8JweJCOCsep3KM44WBZe2kI/FskT+LiHNBF2JXlsoV88
         Iq3UMfFOKvQzs0vNClY3yQwbbMVR0baY6SXTypRQHdBGj5jGZXSE0pjUa1OaN1KBGpGZ
         cXx5c/PZkr/zuJVX3ykzpJ2h3UXmr0Xy1xcVsAuyypaVcx0x9KwyitUMcAoFBLw2AJQx
         ZJIWa4BsKb4Y941JoPfQ2ujI86u4y6PcWlxOUySeIEZCiwFHNQfsVx8KGlfOY7ejcV35
         X+hRACg6cgdTYDyaFQow/gxnJ4ZqvFFy8/HxngPcCCcj4EZ0r/k404eiazXW6f3PwrPf
         TYaw==
X-Forwarded-Encrypted: i=1; AJvYcCWOeJ660bdK2/vQpra/+m5S7NWIF5dBIN/qgVzoQHA2xmzBXcswjvYHohDINFZPwL5QePKjnQxhmNxwR1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoRZMje5SmgbQ8xLoIPXpxkaLfp24fIgrYOaFKRZqWS0QNWr7m
	z0NhmEUwh4jt9uNeY5BQubVKRNUjZs6LJ+FG5Aw3cdXSvwuAFTJCIHsTP9jvImg044dED6ZE7EK
	ZiQd3sNJuKkaQjJS1fw04TBcbrGHWDI2u3uU+LYOjKnebqH6pM2Zox7T5p+8=
X-Google-Smtp-Source: AGHT+IGKTOLuJOVlRv5UaPjainSyWmIZZsr625vMyc3G9RqrxZrlKxujZjM2/vVurFaUVJdOgFLVKf/Kn94gU6kWDpZIl+0xBqVU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c85:b0:862:ba37:eb0e with SMTP id
 ca18e2360f4ac-87977fedcdbmr1760914239f.12.1752542825042; Mon, 14 Jul 2025
 18:27:05 -0700 (PDT)
Date: Mon, 14 Jul 2025 18:27:05 -0700
In-Reply-To: <2b10ba94-7113-4b27-80bb-fd4ef7508fda@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6875ae69.a70a0220.18f9d4.0016.GAE@google.com>
Subject: Re: [syzbot] [cgroups?] WARNING in css_rstat_exit
From: syzbot <syzbot+8d052e8b99e40bc625ed@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, hannes@cmpxchg.org, inwardvessel@gmail.com, 
	linux-kernel@vger.kernel.org, mkoutny@suse.com, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+8d052e8b99e40bc625ed@syzkaller.appspotmail.com
Tested-by: syzbot+8d052e8b99e40bc625ed@syzkaller.appspotmail.com

Tested on:

commit:         347e9f50 Linux 6.16-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16a80382580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=693e2f5eea496864
dashboard link: https://syzkaller.appspot.com/bug?extid=8d052e8b99e40bc625ed
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1025718c580000

Note: testing is done by a robot and is best-effort only.

