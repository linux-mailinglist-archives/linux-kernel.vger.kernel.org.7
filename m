Return-Path: <linux-kernel+bounces-873587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCB6C14351
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 974F11A27AB4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C203128B7;
	Tue, 28 Oct 2025 10:46:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52BA308F18
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648366; cv=none; b=uFIxHWI+LnzogsNzRkHnd9LFm1yDnXUmNi3u9GRw11KaL1zjRmFnIRiFAUuuGk28OU+fdz91PbhLqO0a2vGoN2fjY+RzmDW9uxdOuOGLb+W6x2AJev2WVH0QliC2wY3M98kU0MK67XxpDVe1UqFeVUZD3xYUsallMNBuVs1Hgs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648366; c=relaxed/simple;
	bh=zYAKxXdlEg2ITHJzpQK7fcaYiYNA9a6065SjM9QZiJ0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZD2xrXbqAgj/qqyWO0jtusARXzxswDSXOwcepgYTnYQ+NxEeafcYsNi66g2bKD29trJPLi/h4q2BQXPIu5BQJNB3wpxHoTLcFqs8cevdpNAF9sRmZrZWOTzeUMbJd9ioKLeS5T/VQTYlNccYbuvNfHVOc9NSwtcEG3XZHvU3LD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430d4a4dec5so220870065ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761648363; x=1762253163;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T+DDtPXKouFB24QVr6yBA6MWh+6KkzU0nF/NJGO0wvc=;
        b=npfo1ODVPga/SSXX1wigD+pBJ2SJcQr5NVK79UgaS9Hgm58MxsbfSBzufKCQf2fFsN
         v8pUrd9uC2H9EvaFLNLWRkSgbyEg+ykF16oonjiexMODuhHIrztXnDJ6Ly3zsKsClj2d
         EZAOtX+2Imcga4prOzYD0iV1tLNdi3w/pVQ0W62nOszIyrG1eC+j1LXI2DoEKkrDlGdn
         ld31lO5VqJ42grzlOAONOd14vqz638gceR5IsPQGc/T7ykS2m7mcchfZpxurXn4BgZKJ
         +ipt7GQ6dQFHc7/Qzn/i6R3y/AtecrYGEZfjt9t9AGbKH0vss0Mt1nA4kykZBplmpgvU
         d3bQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9pklrQdGI++/a9+el37EGBgGA/W3/n+R2LsTbf7qfHLOO7YqgXyg7LaHSXfwDuusmy60sSFRgB7AqwyU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7GBDxa1+8iIbYLs43/+6mSZBEi2lQl8aI4okMV7Fo9ke/Arvd
	4yVHLqq/TGmf6L8NjgRyPOe/EzjkOXaYRE9xRH+m8RRKjCZaKNyJ23oAFB5jS77ktwjRqX7zjUM
	n8vlVlINd4k7ARJbXarpyvBRUX+6J1NSHoRweE7EHCIpqwl+tz6QK9ynhKh8=
X-Google-Smtp-Source: AGHT+IGuHpzsxTOhCU4f1iEe0bjQT2+NeGrLveK/GtqRXZ9PXDOdPgWa/l1vFUONLW5rYP2jt1RXjMYnYsOV99ixARPa/GUk88Ve
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16c6:b0:42d:8c07:70d2 with SMTP id
 e9e14a558f8ab-4320f7cb417mr45020015ab.11.1761648363408; Tue, 28 Oct 2025
 03:46:03 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:46:03 -0700
In-Reply-To: <20251028104120.GnIG9%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69009eeb.050a0220.32483.0185.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_set_new_buffer_uptodate (2)
From: syzbot <syzbot+7aef76bdb53b83d62a9e@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/linux-6.1.y: failed to run ["git" "fetch" "--force" "4d52a57a3858a6eee0d0b25cc3a0c9533f747d8f" "linux-6.1.y"]: exit status 128


Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux-6.1.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5b21423ca3f0a96
dashboard link: https://syzkaller.appspot.com/bug?extid=7aef76bdb53b83d62a9e
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=112a6c92580000


