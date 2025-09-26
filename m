Return-Path: <linux-kernel+bounces-834736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6ECBA5642
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 01:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CA42744E45
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 23:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA282BE04F;
	Fri, 26 Sep 2025 23:35:04 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC770202976
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 23:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758929704; cv=none; b=BzENyYq+UybTmUJVqN2cQ12Ga57jp+syQwKG/5au6RP1MPmmDrSHAc1Ug2xPy0HyPAVhPiGcIE4ogrLQA+XW1gqdPxpvt8Xj9Dd4Ktev6wRSC09kwR7kcQnsTLnitkljgN5oFmqXKEd/twfk9ywhwJ2+rDlrZjXQcZERxYIhb9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758929704; c=relaxed/simple;
	bh=RIwMDKe4b3ClyCr0zyxwjzr18MH1SWCTeuGn3iJASzE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Yu9Eds7RrpL6bQLj7VGPtYdNCEv6KW3r8Z7gNlfkAgxHwgegSUmd25vRJ0L1RV9eDSlM6oYFh7ufZ+LroeS9qQonb8cVLQh/uMYlZYHJrMLJhEWcBdoOMM4etwtuQc2jgA8xUBuiXJ+9731t3kIUeSlH5lztHbVNK2G5iFEvX2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42594b7f2ddso39885445ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 16:35:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758929702; x=1759534502;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xQ9Ss8poGjUXhNKpKqN3UHSHnCrswINqDIW1ayTw5iI=;
        b=uDdwsUZ5aQrNYhEXFyOOEsbPHDBg+V35aebBlkyoRAJIxV+50eNHGTg4myCjShJhT0
         8SR5KgUwTFpXTKcRVD5Bg6tcvGYDBvC0rMT7fAFBpYc99FoQHnSSe3nTW39G1TTw0tcv
         2brrVpX4Hh952Lj8O9jI/epo3CMywVgNXMedAgYwu2E/YrVW81xscK9hXFM/BOnh3BNe
         26nVwvLBIrKcKbzfozLUzcbK2pmo4QmvV19tQ2Jf/jsvQZUpv1BhuGPILoOiXpA+5ehc
         xjnt7Fph9D7h8YeGDCGmRT7d/Of4MQbNtawnFAk52KUDMDpPp8g4rm7FLYx4GDeAc+Hd
         bO2A==
X-Gm-Message-State: AOJu0YwGRS0RcKXEGPwwug7SXEY9H++mClaWl8/HNilB8aP87iaDT2Yt
	Jr3Xfzo+ft8DVLIwfYVaCO2G5EIQmSc7oQ52NWnay+E4fJRQWyTZkFSGef0QtlBBn1pamolf8fG
	FWM7fQNSYNuWQnOW29QkWIDAkNzAcM6eC2mNcKc1qnUIq1JBWApdUQ34YxIE=
X-Google-Smtp-Source: AGHT+IGvtK7mM6x5HsCMFFyXBnL3tvVGaDYAPmf4gOc6g+OZJL8F8tqUzE9jJg9Mx3OGDgmfesdufaKhjwtr93xVHDFWQ+UFTsZY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:378b:b0:425:9500:ec46 with SMTP id
 e9e14a558f8ab-425955fb24emr133187475ab.14.1758929701910; Fri, 26 Sep 2025
 16:35:01 -0700 (PDT)
Date: Fri, 26 Sep 2025 16:35:01 -0700
In-Reply-To: <CABPJ0vj-PpMGn1B1--Z1FT8o6hofwHg2LYs=7bu_WL2v1G6z9g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d72325.a00a0220.102ee.000a.GAE@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfsplus_strcasecmp
From: syzbot <syzbot+e126b819d8187b282d44@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, rampxxxx@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/hfsplus/bfind.c
patch: **** unexpected end of file in patch



Tested on:

commit:         fec734e8 Merge tag 'riscv-for-linus-v6.17-rc8' of git:..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e4580d62ee1893a5
dashboard link: https://syzkaller.appspot.com/bug?extid=e126b819d8187b282d44
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=176bd142580000


