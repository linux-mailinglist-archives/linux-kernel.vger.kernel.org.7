Return-Path: <linux-kernel+bounces-873602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E92C14366
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6DD66216D1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B226930FC15;
	Tue, 28 Oct 2025 10:51:10 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A913081CD
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648670; cv=none; b=UzO+m1ZVE9f8SWL6zjapPxSQg6zWhEsGZ2svBnLm+Qr+QTvlZVe1zu8an6DMJWlY89YhQdaeVnUNru2lofYn85EOHlvt2mJxaTCDPKxILt+lNs/B6QNCC966NNhh3lC1GUhQn5T56ix5CkjuEoNL2Y3Xwesqou0cnSzsEXPvjwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648670; c=relaxed/simple;
	bh=GTWYOVRwJPnDqyU7mS62hUzbTIpoc5t93ZcC53iaVaY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=N12vYl7uqHRO7eM2av1UQLFRxrxpwUXVIeRDQbbRT8f85Vy0CvB6yzi+Hnpcgw5oHDSrB69FMllTwfUgKckGdyVRlDFskE2WGzfkwaa9KMe0TK9PED0tRHqKhSIDG8nPe+Qr8gnSsGAD7ag/gzLl/7zjpU+tjhFYjsAVZ+jZHmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-93e7b0584c9so553003639f.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761648666; x=1762253466;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ymwFMmUNxZQEfCJXDi0bmrbTj1zYT0siWUUDTRYBPU=;
        b=o4pyHiNDjMGA3ia33NF4rimqrUPsq3wd804J+ERECCtRwie1NP52Sode9l/KdULux4
         LWfMMbqJ0JHbVgvtxOpPeb40IkODEXZ7lq5f/cPhp0C7Yr6fx+MRMl8NWFX7hUePjk0+
         NPAxvMBBzDwgpIvQXdHwX7Qn4ICMG8qNiyK1xxFXvJW6wAaCT03bBaU8hT8VHSWSs/0T
         RpKOQ7WBc9ta1uULr7wNJtYB5GbT0PQ5tfEn+soZSedwec0j5Y54nWafauTBxsnIskk7
         pD9dt0/iIEZmMZej0JD/J8wqSn98KKMxYmtmFwbTa94wME4FMpOV+sxV5f3302Mq9Oh5
         grHg==
X-Forwarded-Encrypted: i=1; AJvYcCXBrrt27D+hUDd6Z30RpBxWIEJ/wASBCbwGwmOW7vWnTJJWrCEc2CwZs3sRq4SP3hIS3loqeaIbYeU9aTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzORuvR42+ZHxyAuVONl9Vtrhdqnq4OlTmTD2MvkGhstvCze9BS
	mw/1VNHwnlfYXXAyIQ+WNCvvr1XuRJEIaqSjg0bsxtPwFX1TjMq0QoaJ+WXpCboyNJummKuFwB5
	1bE90Re67ldiH/zRbYDqupJu4OfgCynfBm1KEeeJfV5MO/3jpNc3J39zO9I4=
X-Google-Smtp-Source: AGHT+IF4EAZIiJ4JRF9g2e1vQB/KxQMC7yat1Wlc8HS56hg+E1V0+S8QAsZ9RsS/D7HVjd7Nj9TzjGWMeBGpfSlnsITcsxQ+X6Y6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19c7:b0:431:d726:9ef5 with SMTP id
 e9e14a558f8ab-4320f7af3c3mr40303915ab.28.1761648666121; Tue, 28 Oct 2025
 03:51:06 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:51:06 -0700
In-Reply-To: <20251028104201.w8D7a%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6900a01a.050a0220.32483.0191.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: slab-use-after-free Read in ocfs2_fault
From: syzbot <syzbot+a49010a0e8fcdeea075f@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/linux-6.12.y: failed to run ["git" "fetch" "--force" "4d52a57a3858a6eee0d0b25cc3a0c9533f747d8f" "linux-6.12.y"]: exit status 128


Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux-6.12.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5b21423ca3f0a96
dashboard link: https://syzkaller.appspot.com/bug?extid=a49010a0e8fcdeea075f
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14463614580000


