Return-Path: <linux-kernel+bounces-817678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0504FB58547
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC9ED4C2E15
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5122E280A5B;
	Mon, 15 Sep 2025 19:29:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2AB27E7FC
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757964545; cv=none; b=Ka7c8nIalQx5QY6PJJSgzZV2rPkqdEuNCnYcnuxhNu4+gTMzyvPp9YNc/P7Tx/6SaLsvRuuL4DeKU/6yxCIsF0tt8c3KtFqcXnDG2OK8xjbGhP/ZAszqg7ip/ok3c1BWaxaHz4aWcvrczYOGq0gclmJ3Ds/tcIQfwBDnEulTCFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757964545; c=relaxed/simple;
	bh=o5PnzUDO2hbkAa26BvIW7FDoae0vmaQYSJ414trvH+0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=P1/RiIoZvMOtQFP/xTRgajb7N9u4yU9gsasZezhgemuhLoGhqfyT7M/OIL9SpmoCzotwqQ/WuYw7ofIX7LlVKTXZrU2UpjrgTQbzwAG0Upzs5SjsSY3zQE8BqVgA7/+JyWRDw6l1oKDHjDhVRD4RLqN0vB9wZRluLGxiajRnf6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42400428184so46664555ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757964543; x=1758569343;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=32xZN/eVIFLWXL0f53tgJbBygjYmk31kmKuC8cvPkZw=;
        b=BR/yD4QyF/VPTcaEwzfLHKZXOGhqTaeufhji2Ih2EY4pY9ktgmUkOodHnjzo2hN7lh
         X7YXKK2YE6fdyXkxk+JAKqL+c7Mv74v8s9sX67jQzuxLtky3FAt0gytec+AlJDd2rsLO
         0/7X94+0i2IoE+ha6e8L67bMwTkMtW1wK6l3ExOu1E6kBUNcwufm9S8Gq+BFQNVmzW7e
         gozsBeNtsUOy2YWQ8jYr8PB3KSczli+sZzC890AVk0WbhMf0EZXFM6nGi7Wec/JojFjn
         14snJzFR3bSOk3vHgo44HEi+QlWBYqdd6gqEIErLK3gmWCFMz5HNb3EmcSOTfrAV/RF9
         q2hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBgxOIIK2eilDvij6Rt1At9fDFkVnzlDRCPC7aUB7s1dwFUkTlzbzcyeBew0E0DcN+dbO+GfBA+ZIW8UQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/OLD58UFHc8CFB5kbflPT6hELCBuhMtZ/Sa23bcHg7m2WHgZH
	+5bFh3F3bqNFJrRYYvvF3bvlxWQEjEBAu9ZvZppi+1gljrkP7wOKo0TBzRbi81AtEaUue/1AZC9
	WA02vjbVFyiz6av7oPSMAobT+MF/1CTOtLj0QJbvBj7rBZmjHnJ5bzLkPnfM=
X-Google-Smtp-Source: AGHT+IHXNoVDq4DqrpUkIh0scWsr/ZwjdEvvuQOp7t6C0QH6z5HCdTRQOpklwmHV5Dla15i59fwL08KJ6id7enrboHjnLNqKCIHR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1908:b0:424:9a5:855b with SMTP id
 e9e14a558f8ab-42409a58679mr27743815ab.16.1757964543689; Mon, 15 Sep 2025
 12:29:03 -0700 (PDT)
Date: Mon, 15 Sep 2025 12:29:03 -0700
In-Reply-To: <CAC_ur0rdn0s6AV2+pC-oUE7FsFm8xXfgcd3kWzvUAG94W6OdSQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c868ff.050a0220.3c6139.0d20.GAE@google.com>
Subject: Re: [syzbot] [input?] KASAN: stack-out-of-bounds Read in cp2112_xfer
From: syzbot <syzbot+7617e19c8a59edfbd879@syzkaller.appspotmail.com>
To: deepak.takumi.120@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file drivers/hid/hid-cp2112.c
patch: **** unexpected end of file in patch



Tested on:

commit:         f83ec76b Linux 6.17-rc6
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d8792ecb6308d0f
dashboard link: https://syzkaller.appspot.com/bug?extid=7617e19c8a59edfbd879
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15b7f934580000


