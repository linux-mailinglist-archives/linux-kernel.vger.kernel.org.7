Return-Path: <linux-kernel+bounces-739531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3556DB0C775
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26B2F7A8150
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E254C2DECC5;
	Mon, 21 Jul 2025 15:23:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975F52D836F
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 15:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753111385; cv=none; b=Ui+EUYzZ2ebw3nw0fEij3MQleA1uuGv37C8LM4KP1CPbqrL0yESyknKPsRH1WMRgfSZfl+1IFdGAmQ1l02DfBI3OKPbELipzDaMzbX3/fj2kMJ5Sl1syOVxBZzq7nJ8sDBMHrh29LSkjMcbA265p+oqoYyh2ZnHbjmFdD6lCqAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753111385; c=relaxed/simple;
	bh=vgfQRhOfNJrtc92tlhGLleVrfKnZFO6SQWjGR5M+Lqs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HaiZZrwVBQQ4LwK2JHFCvEbaaqhMEgaal+2BhxhUr2AFW99X/J3jQGPsVulCAkqFuHKq+soBiScS1TPQPW/mZGLsyVQBM6wuC9U53UuQBPGDd2Zz83r8ZYhO61cr7ho2LdvM4iHSIqKjHDNr1JosnaZRpFBstO1YYdaJ0q4145M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-86cf753423cso422107839f.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 08:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753111383; x=1753716183;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JnnNzxl9T4wc5fvQhb3X2ZvzvD3sDYfo1Lw48SOD28s=;
        b=M+VbRe1gPM5wdWat8AuzDu9O1cI2rSgiEsME+7gp4BZsMIFMjBehWodmdTu+f5WbAr
         GkIJu5WgTEuzRJ+tBB9ZIgZ52EEMklDapY49D0cF87id/VgX03eKoSgx1d9DUI2R38qV
         KKsyXG1CltBziPA/j+QZEePFhTm7t22ywYPPNqAp6NaL2b0BAvuYfcxaVslFDDrEOlMm
         b/48Y2QN1K2CbfZJU7SuWUnyaUllAGSdIcp9GIXmr9NimKbvlyzEqc3hZ7E/AouVg5Ki
         efHmLQPq69f7LCvbZyh5nLAy5d6lP0D6KYRS3qqP+xc0WrWbXjLPrgfzbimLqSE/GyCX
         2Zgg==
X-Forwarded-Encrypted: i=1; AJvYcCUjDgeAuAdLfo6dtKB2+Z8M0EAjwYcOClvGf9nkjbdVDMrqfXsU/O3u/pZYSzSMeXSKVXszoE8rdesoadk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx10hBpL6+xilrt978lf/ppnC9q9tyat46zwojm+tRr5xwdb0Pl
	Ts8RxlvR+n+D+uujgcz1rknuJBvjdr8twj0FLZN1pQIhTIqfa4OE17R0NmjViIEL2FL266jcfy6
	p2joNSU8Zbmvl7qJEwkIdPu57dfI/28ULF0+QjyPDxDlCHhfFM7mIe6LCD2c=
X-Google-Smtp-Source: AGHT+IEXJhlHzdW25N89aTvgF9cgYyQhljvPvgMzdWEjwvMjmJsRZj/gTeEpluzGFnZtI6hYi+7Bqbib6cRYF2V5JqkqAMLadrRR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1490:b0:87c:1237:cef7 with SMTP id
 ca18e2360f4ac-87c1237d278mr1777230639f.13.1753111382796; Mon, 21 Jul 2025
 08:23:02 -0700 (PDT)
Date: Mon, 21 Jul 2025 08:23:02 -0700
In-Reply-To: <cd6d1bff-7912-4c55-b2fc-ea2032658ca9@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687e5b56.a70a0220.4e1c.002a.GAE@google.com>
Subject: Re: [syzbot] [input?] [usb?] UBSAN: shift-out-of-bounds in s32ton (2)
From: syzbot <syzbot+b63d677d63bcac06cf90@syzkaller.appspotmail.com>
To: bentiss@kernel.org, jikos@kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b63d677d63bcac06cf90@syzkaller.appspotmail.com
Tested-by: syzbot+b63d677d63bcac06cf90@syzkaller.appspotmail.com

Tested on:

commit:         c2ca42f1 HID: core: do not bypass hid_hw_raw_request
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16f4cf22580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ec692dfd475747ff
dashboard link: https://syzkaller.appspot.com/bug?extid=b63d677d63bcac06cf90
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=142bef22580000

Note: testing is done by a robot and is best-effort only.

