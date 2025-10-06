Return-Path: <linux-kernel+bounces-843263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6440EBBEC97
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 19:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E3973BE518
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 17:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816F9225A23;
	Mon,  6 Oct 2025 17:15:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F863A1D2
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 17:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759770907; cv=none; b=d37fpaIqeZNEvbxqdMU9Y7EDSk6T0XW0Tb1hNEKgYB7b/z8b8+2QrADymcS37bZmRsVAjQjvtGC34GRMnszyQ0PvpSsTrrNUpP7U/3WRcPI7zz7IjrfRBqeKjECMVkw6WBp6+HHM2EhOdDCmRrB+QphGs7pXIQgHqFlxwcA32bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759770907; c=relaxed/simple;
	bh=kIiocCWDuZEge4/WeGNxYQCbUP2gKOvTTKOB4wOfiho=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=txJlvvdM8T+vKX1T3vfRNi0fZG7ajZTpv7OzQO/i8WXteno6d9IbwfswrueoRdPR1BpnSHdSasGZ/lTOSZyPqgVfIyPFBMHJ8hwf4KH2bVKhNsvzgC2rl63hTCQ/35UVCCfbpnzitdYaUl/jZvUwg7ayVoHElnKqFBtJ0qURZbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-429278a11f7so57401325ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 10:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759770903; x=1760375703;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IP9LmEjGqUz/5uZG0l4S5ZsNDaaeDapHXZjfQ1ZY5J8=;
        b=Ua656xWTtgj8eR9QwMzENq0J2wHc+bv0dqgwBxMAez7wqyBidkwMD1OB6emF71t3CC
         +FwXIQYK6PSegfQNm1+D/fzoOIHMNm6BVOfJlaSI5fe+plya6Rk1BMx4UL/MOxEopLtb
         bLxXRoBvnoN87Qc7DjL/2TLigmEBA3tQvQajIdrmipGbd02LIzXQmb5X53z0HRGhEOXE
         rhAGiBKgw7YHPSK17Xfdlk5hqHGudlsBIO3NzcLIH56M7M1mJe3UYbOP78pIRkqh9vam
         aG90Kc0lbb5vUodYe7VpiDf4spFQj+uTdIIy2qAbIkK3gQJF+m2N1ASJ0Bls/QqsEmhB
         BR6Q==
X-Gm-Message-State: AOJu0YzRuOFvEzx+4MvCW+JlGxRHzz6Vzw0vB3Uc7vVHhOkVlbCW3fjr
	yQAJ4PeMV/akRJDZSxwjO+6/c7IO+OJrhzmCCxzu0OZvUu00clvk4lNXwV5PCVpzKjYiowco4BN
	us1pZ88Sxq1A2WAjhIgXO6YHrG9gI5Cs5kmiWPYp7Nh1AL9hCJ3s2/Ws8hgw=
X-Google-Smtp-Source: AGHT+IER48yb9ULFKT0ZMDQtDtcqAUgLWogksPs1EIyWYa3fya8zcVAiBLIwglrSpWtNpLzR1btlnbWDio10bVvsCvoo8vXsB7Hk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16ce:b0:423:84d0:7f7e with SMTP id
 e9e14a558f8ab-42e7ad04b8emr188076155ab.6.1759770903548; Mon, 06 Oct 2025
 10:15:03 -0700 (PDT)
Date: Mon, 06 Oct 2025 10:15:03 -0700
In-Reply-To: <CABGqKE03duCVamFHSXsyCrWj_esqHswu4vfb3v8uEGrUTDep2Q@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e3f917.a00a0220.2a5ca.000d.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] KMSAN: uninit-value in attr_set_size
From: syzbot <syzbot+83c9dd5c0dcf6184fdbf@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, nirbhay.lkd@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+83c9dd5c0dcf6184fdbf@syzkaller.appspotmail.com
Tested-by: syzbot+83c9dd5c0dcf6184fdbf@syzkaller.appspotmail.com

Tested on:

commit:         9b0d551b Merge tag 'pull-misc' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15492304580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50fb29d81ff5a3df
dashboard link: https://syzkaller.appspot.com/bug?extid=83c9dd5c0dcf6184fdbf
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17eab334580000

Note: testing is done by a robot and is best-effort only.

