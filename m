Return-Path: <linux-kernel+bounces-817695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0478AB58578
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 083391B23F5F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DBC1E3DE5;
	Mon, 15 Sep 2025 19:49:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C969158545
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757965745; cv=none; b=Jx4vhBe62+hXwtmYF5pJ3WbOkw2FfNi8r2HYcpOLP2ituhDM2XoBnH8Izr5K1BFiaGZEKQU4w0/tbbnSA2xt7O5XH5rid9s+A50wTR68DzpqIERIoJaAq7BcOp3qIstMBW2yReAiQIn9Bvt87wmDSmLaJbuL7/m/40J1JADXSz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757965745; c=relaxed/simple;
	bh=f6zu3u6AKKDVqKA/FRFj8zpZWc8NPsKpbstitaM4Fg8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FM7dnzNfGeQVTxA3xptzViKLnqSSPMiDDq1IfwuQvQK28YCXTG7cZvvawgwPAiUo8OwbePjqcytXShz3tUS9dtCT2BZQM+mmXhau1GyEqJTCegX2dSibkBLzN9uINlpCrImKKhDLQNwjWPJ+moQAAXdVNG2uh7vTmbQSNWGUo/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4190d8f16c3so56441665ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757965743; x=1758570543;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IosY3bhx4HipbhSmbW3xLk1XBkxIk7K0w9FZW+fGVoU=;
        b=hNSBWWcX9Bcuj6uzNUrY4GixvsvcdVJiDjeKYrpxMYN22ptW+8gAyfbCGH/ARFdnl3
         qkBrqaL19YI32rkabU8+P/WeRQH/KMt2uZydMgAVNv84dEtgtkj6EXKuUP4tIEVyQcak
         x/KLMo7Jd5Z5d6OO27Xl27enbMOwpwubCGQBU/lxYVOXbfhRQEsvJ2IGtqwkAecwNGX4
         Nh77fBWTsm08HAK7Smys2vTTLWDbj3BudsyaZ2H0ab09sY4W8Oc0vfD4/XGFAz6zrbCg
         xE1fryPJqjPjP+D/jCXoepazVJ9nwJApS4cOm5JMQbgaj4YJ96rBFKPICGHTshEEkE+e
         leXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxqZyZJjYLZSNiil0w89rHUXUS0+mWL8W4sjdwdYup8GaBMqv1DTCNX2GbUwIlE8m7Y9D7wo9ZPY20fhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVxGY6O+SXkR0xM3J5Tp8Y5go1hnv+XwshvBvD4gqvX9+G1BLq
	h07PMdLkDm1f5STPuiVixCCvf3b1ZO58eEiDX2lWNm4sVArnKAJQltx8CO50TLCEv9x0dRp3gIP
	73/9gd61xMvJ+RTyIk3fWGGW/lM8OtPHoyswQkQMirhljN7brWpZwuo82/kU=
X-Google-Smtp-Source: AGHT+IFbzV0kRBFRfqn11T9L1HNb7flz0DBVcJu0EUat0bbuChI33iHHtH3teOCinXR0zP7lAFMVSRSQY8FbYYgFnKG5nYdpl0by
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a43:b0:424:9a5:8590 with SMTP id
 e9e14a558f8ab-42409a586bamr28080535ab.29.1757965742765; Mon, 15 Sep 2025
 12:49:02 -0700 (PDT)
Date: Mon, 15 Sep 2025 12:49:02 -0700
In-Reply-To: <CAC_ur0pQbB4xPaSj9qy2Bb4yc3LD6hxU8aY41LsHjuPurkUbBg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c86dae.050a0220.2ff435.03aa.GAE@google.com>
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
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1498d762580000


