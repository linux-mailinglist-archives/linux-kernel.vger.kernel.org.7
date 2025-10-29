Return-Path: <linux-kernel+bounces-876183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 623F2C1AE06
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C07DC5A56A3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F272550AD;
	Wed, 29 Oct 2025 13:29:10 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED11253B64
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744550; cv=none; b=WQvZn0TUMFw3x10mcHc1qFNxJiPEjV3Bxr3iWv2UtFvk8VcB7RqXbiBnh6bH9wl6uBfAzAeMhzRNnjmR3zD+GR8vCmlQ32kWAwHfG0bKlTrn0h72UCVwaLNc7XNi5KCCCALyYLq20M/PMjUn37Xnq6KGuGLiasydw/1JjfQbgH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744550; c=relaxed/simple;
	bh=81kMjGLArao88i4yMFB2h+UQA8C54YW7d7vwMKjuS9c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WZNipQPI2FbvzYZmUB+OJ24ndz6p02Y317Vbt+W3PWxTHmRQGTkP13XxKv8oBjpA8gDlajUAFZ6ug8zjK/uUARgE/mtMwArceXmt93UvJ9OxF6UAA32/5x6UVm6ES5Ph8USrInXkKn6SPgGW4sdJcmLGSoyyTRJUlen3y9KpSFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430d1adb32aso74351455ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:29:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761744545; x=1762349345;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uh3ytkP61dKWtvixYr+BoeJrXuyexOa2f3lrltNsAN8=;
        b=bwVJGwpDbVJRmPo3LxGjPZlSx7o+kxga2AUtX9ziGXa15A4res6t4bgBm3WhqZ67xR
         mGI2yHzgvFAjeg9Pbk98LvE46sVhMbknjcCo3+fg5r/iljFxhslGEUfm2N/blEEDRMJ0
         JFtO3rjiHuKhta3Hv9/GjxZkVqd7ZAMrXk+mwtOdibW7KXtI73ZdM/hA63ienlmkb+7H
         eiDvdHLPaU98qT/mWGHFbIG5B2ORq/BRVXtGQNUta3gHtJxA45F4ttWk/xi8UrMrIa2o
         LOgIUna9X3lcrl1yHJcnHqijOmRKy8UcUXSY6NICQNkeWK9o+kw7Cff9CSQD7FKJsl2x
         z+SA==
X-Forwarded-Encrypted: i=1; AJvYcCU3/BKY6G+HeEmzhShqNsLJTrYz0sgrkT5Js3jYe85bXY2N7I85jR1r9n8+TR3iJKvtGUVnJXkPUtS8Jz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcsNgOXKDIBN+JvQjym9k8Ca1+hrieSPzRGqVETmV5nUMkbeiM
	isC+1OJdDdOM5yRTnPNP9F7yO7CinfQTOpUwOsAlzm0clD5Q6bpPD0bSolr6t+dyqikPK0RtksX
	Nfd86MeK5pzWtV+5e8NY2VPbEcQQImkqqCxhXRXRJnD3JBtwTJY4ddWzwRRo=
X-Google-Smtp-Source: AGHT+IHjgBgASx8S2gj8I/Nfqprjm36pv0Qcz7VA1XN/WqGi/nIHChNm16Yi1rjeX4tF4pRWZr3nAH4JxISfTOw4gbiuAD54KEfu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4503:b0:430:a5e3:fd70 with SMTP id
 e9e14a558f8ab-432f8fbe9damr30464485ab.9.1761744544924; Wed, 29 Oct 2025
 06:29:04 -0700 (PDT)
Date: Wed, 29 Oct 2025 06:29:04 -0700
In-Reply-To: <20251029062550.sAACz%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690216a0.050a0220.32483.020f.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: slab-use-after-free Read in ocfs2_fault
From: syzbot <syzbot+a49010a0e8fcdeea075f@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+a49010a0e8fcdeea075f@syzkaller.appspotmail.com
Tested-by: syzbot+a49010a0e8fcdeea075f@syzkaller.appspotmail.com

Tested on:

commit:         8e6e2188 Linux 6.1.157
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.1.y
console output: https://syzkaller.appspot.com/x/log.txt?x=1421bd42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3fff88b67220f824
dashboard link: https://syzkaller.appspot.com/bug?extid=a49010a0e8fcdeea075f
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12059f34580000

Note: testing is done by a robot and is best-effort only.

