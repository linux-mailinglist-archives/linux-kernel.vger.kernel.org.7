Return-Path: <linux-kernel+bounces-828876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD40B95B7F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 579827A37EC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D371C322549;
	Tue, 23 Sep 2025 11:44:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198342F6184
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758627845; cv=none; b=fuoanB50AQ0T/eODaTdvpo2zm/PAudLvJ4mHzEiv+ivhbr0Q1jHB4E1kAx2PNutNlwfkiTjunBMiti5nWVbWH13w9e6XzkTgf7u0F5nv4wfydWmJYA13Eu1Up7e1epDD3jG+3vlXpEWLyjmxCHsv9BdShdY3HSghuz8vI9xaJIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758627845; c=relaxed/simple;
	bh=MjgUiv1hiBVmGYAWbKukWHwYzxXC3U5WUKEUQFe8mHw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Lb1VGSOsolRLamNV+Oo12eSfPNvQB3DRTkLm2iBTYO8qnWcYPF8wEh7ji9EXBogaFU9jTOeb4lWfUorD5SxkIraLJmEMjhnDdRVi3ecoF8Iio6ZBymYNMGNGpgpMjzQ+lLeDyy6zERNbDxfS8hU9WfBXIxvo0snHX7jU2/vRtGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-4257e203f14so40774215ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 04:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758627843; x=1759232643;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WQVvBj5uZq6uuQ1nu4UWRVsR/gDk+9EG2enfLEYGBRo=;
        b=g88eZlVKOM6l3gh3cCBSGkZiGK4q9T41bKiQX7RQ8gEZjtDR67bmBBszKRowMrsIsk
         9tkMlVUihGfhi3IQmhuCeqhKj1kTMKmC+VVWdEgEQYqOkl4IF1/BYHiv7ZTWKNCCoIr+
         XwoulEsduASBQhtohwbyJZDJxBJJ3Df4mQ3/1FTAqUranN2lZAbfBei1dMZGks5peN9n
         jGWKLTHwEZLjKt81Je3wHZh32sg7PAqzOD5HKuA/1vfh5oVxkhshZw/+vXuQOBECUj2c
         6YyDet2aYTfNlqGHdhLdH67s4gPPt/mE/+ouhVzdP9cNfvoBAZWZtFxtK+sUePmgcSgo
         KQ2w==
X-Forwarded-Encrypted: i=1; AJvYcCWHKjzwjGsnldH6NHDk0qU1NF50cSIpDs5Samm+LXeY6FiFV+P0dFIZ4WlWj42SoUsvEjgsGcBmtgeQrJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxajzYcbaccr4wgHuLh6HXPd4XpmKqz+x7k2kDtqrHdkwNFQMLH
	aqPdbjIyKjgKPwK2wnsrNCoyQdYqjhBvAAE2lzFzZQMBXc1d4pj6zWc1evdysk9Xt5CPghJuRXH
	SwwkE6WlPiUA/wloWmBFPrBYYIJ3d1HdgiKUAeEnhfQCu9jFoZ8xXb5+2EWA=
X-Google-Smtp-Source: AGHT+IFvOJRcG5WosHB0HMKe1uFAe6PQYbdY3i4QCDRSAtKAc7Sh8RXeNxUbnOUCvmi0umdlPKZnG7LEi2yQoCd/aYVeiM8/3Lnq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c23:b0:424:7d35:bce8 with SMTP id
 e9e14a558f8ab-42581eae244mr39857525ab.25.1758627843063; Tue, 23 Sep 2025
 04:44:03 -0700 (PDT)
Date: Tue, 23 Sep 2025 04:44:03 -0700
In-Reply-To: <67d30ef2.050a0220.14e108.003a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d28803.a70a0220.4f78.0006.GAE@google.com>
Subject: Re: [syzbot] [usb?] [input?] WARNING in hanwang_open/usb_submit_urb
From: syzbot <syzbot+9fe8f6caeb5661802ca2@syzkaller.appspotmail.com>
To: dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, oneukum@suse.com, stern@rowland.harvard.edu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 503bbde34cc3dd2acd231f277ba70c3f9ed22e59
Author: Oliver Neukum <oneukum@suse.com>
Date:   Thu Jun 12 12:20:25 2025 +0000

    usb: core: usb_submit_urb: downgrade type check

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1066627c580000
start commit:   038d61fd6422 Linux 6.16
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=515ec0b49771bcd1
dashboard link: https://syzkaller.appspot.com/bug?extid=9fe8f6caeb5661802ca2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=109ab1a2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=136cf2f0580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: usb: core: usb_submit_urb: downgrade type check

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

