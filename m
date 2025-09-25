Return-Path: <linux-kernel+bounces-831720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 045C0B9D642
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A786E422E00
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640822E0927;
	Thu, 25 Sep 2025 04:36:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B7C26D4E8
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 04:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758774966; cv=none; b=qoyQa6DnUtv5GoQzK24a7bESsIVlDW2cBxdDcbGKW+tYabE26YV8oaM8NFDNUV9wewPik6dch+QSeGqLuFlHIZTMb5BI+afcPCEpZKypvb9xRZOusnnAdy88Qu+1120mqCQmgvq2KEE8G60hAheHvYf6aESG7MNplGkmDbrioWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758774966; c=relaxed/simple;
	bh=2IW5nx6xyunIj0beEntFwZygNIIedYjXeMzP7HEFE9M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QIEFwNpY8X8sxWr0wyc1p6e7gxIigap0ykGXh6gIAVrQHYP8gSCvoA3jX2VUgfnVlftkoB5adkpQpkRkKBKRqjthL1hEYHevTz4P9wz5a379xhch7Xi0bcSff9MY21tVsua7U6jt8OZWWGfXBpCnKSc6/xUJXjT/tMUF0IDFvU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-893620de179so118055039f.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 21:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758774963; x=1759379763;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TTz9nWqgx0LOjbVYlwkTEWAPm2qCLxIQaZX0OyZe+Ys=;
        b=pUVTC8Tm1CdhXQSwJO75yi8mEohcOAawC9tX/may9aQw1Bqiw+Qzl08uL5ytPBHLDi
         UK0b5ZBjIGJivT8VAj1JKXZXbrOJnqyH0NqnXakozP7XNtI+6LaBbq2niZ0iYkDZWYSX
         86VK48B7YMzhyz+a2uPa/mkEyG6WKdOsz5HxqOUe+CkvGI31/L+qX9jaLTocPdM6+49T
         sG0By1Yx55iinDHOvP2JcSeb9GfKU7vYmuNB1wORK3c9HnuP/Pf/ldGYxxRTxOJ3s/Uv
         +GLWHOxuDZayPrxO7hPkquKaYo9/cL+F+Ke1l7yx7JCeQadE6BV5bv3AuZANY0L/cBZa
         sK6A==
X-Forwarded-Encrypted: i=1; AJvYcCW47TGigdn6K5wa+egR4KmMKaF+uhU2hLCxKnJ+byPThq1mvjqAOW9GDCQBZq+9ixMQL8v4zeb1Jx21ano=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9lovCB1hJtSP00Bfz79rCOaY6arrdD2WwmmkcHTArJ6lvVsb4
	h4nKnNCY+3QGaIMuCbqaIeO8ZqcvWH0xczLhT2qii7BMsiElYmizoOmhzf5Rl9dljqzhQeNalEp
	HrFB9SNiM/Uk84UNmjQ332dMaDRQWr9QwhtdDV11nwSrrYlX0a6FYOVTZKRw=
X-Google-Smtp-Source: AGHT+IFy+0eZYAgtXq5YqQ41E+tPjGDVcLb2vYO7goGrdHTVXkIR7vERHLXAJ8r2Okr7BhCjIdyIQ3R0utgJBJNFajf6JUspZSrh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218f:b0:424:805a:be8c with SMTP id
 e9e14a558f8ab-425955ed522mr32500715ab.8.1758774962809; Wed, 24 Sep 2025
 21:36:02 -0700 (PDT)
Date: Wed, 24 Sep 2025 21:36:02 -0700
In-Reply-To: <CABFDxMEvAdSyAPhyNo0YWWwA7C4=KFm2qKS9DS7ExPwFvDLjDA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d4c6b2.a00a0220.303701.0000.GAE@google.com>
Subject: Re: [syzbot] [exfat?] general protection fault in exfat_utf16_to_nls
From: syzbot <syzbot+3e9cb93e3c5f90d28e19@syzkaller.appspotmail.com>
To: ekffu200098@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/exfat/super.c
patch: **** unexpected end of file in patch



Tested on:

commit:         b5a4da2c Add linux-next specific files for 20250924
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc64d939cce41d2
dashboard link: https://syzkaller.appspot.com/bug?extid=3e9cb93e3c5f90d28e19
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=106bd4e2580000


