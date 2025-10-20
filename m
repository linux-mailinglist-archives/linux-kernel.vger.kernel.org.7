Return-Path: <linux-kernel+bounces-861937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E330BF4132
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 01:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D6B64E3EA2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F0D2F7ADC;
	Mon, 20 Oct 2025 23:53:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE019238C1F
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 23:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761004385; cv=none; b=kdv1Aj4vRqgxmhwH0eK5a062xpZgEhYWf0xhGOEyqT5m8k3kJqfcBBH2z4N68qQf3/L9OdKdENKpaVKB/I3/2xuQBDZLcWWDGRyC9IAr0IeqZUJguBibImx+d50L/T1KQaNLUE5sXUg3is9JspOUls8cRubHg05b5T7bUUY/Jug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761004385; c=relaxed/simple;
	bh=o6E/PDxUqTbyQ8oFvUo9A8SxFgYkdTiA+e6PItlU6Pg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VOH745CCMVySW26Lv6ZdbAlFYQNrvs5Z31JiyaFOA7kKxvt49BwbgDBwPhxwhuvan7RZBDx0QijvvrombRJd0NHTVtRdw5B4K3aH6TIjuXFBwYhR3pBByu5/ChmvtAqMAm/Ds7LI8cn4/uj2vXyhjCMgyg2dTQA1B0XAqqA3wko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-92c122eb2bdso348655139f.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761004383; x=1761609183;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2rll5S9uNTpd7B49EM9aMSMtKPwQ9wuj8Db5L4/1HG4=;
        b=HnV5Q3t2WKwcCrRA93im33liNfuusNjWCFUVLQ4SWaejK5vD58H4BMHf+264Ffxdxr
         DklpFsWRmwvWibu/Iq69DKAwT6G2qQr7TY4/Qiip61LmQqp5irc1JWkuISYY7ugwNy95
         rkSID3WkNaGiAkX7jEpG02MsSLw44lEeRhe1hMssR8OvcxLkYktmYdcXNg3salIU8SC4
         U74KIzzYfkSkhifLn+t7fuiDETvXfDl2lJytBxEsKj0hrYLnQ2bjgwt7Fo63p5UgbUth
         ZSDXQD4oI9SI7xUNS6UZl4PclW3WN5E63ido9fjGcBgWPkHQiE9VxRjGHYrjlt3ndRAZ
         mRew==
X-Gm-Message-State: AOJu0Yzxu8xldamVoe2MHzIixKtnwhDR7pJWqYN3OLltJIYVb5UaZfVX
	Oegtf18GC4u3AAda8IaRcidJlERYF3fjFgMREpXDUI8Rn+cFHAeViL1ek/9vEh6w0yaLL2SiDvd
	6psONKxmCMTuWtYBDRyRa71tjniAfnIq9BwqsayZ37OPZ7sphf33YdLEk1C8=
X-Google-Smtp-Source: AGHT+IEIBt2avuLcSJ4ofUnhnitbYxiCC/hcARz9aKl1S5bw/bRxr+/2uzLl7Yh4GY8RVQSSkc8jpuwBJmA2I+c1YibBBR3lN8LY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6410:b0:940:d3df:39c2 with SMTP id
 ca18e2360f4ac-940d3df3ccdmr1190812939f.4.1761004382900; Mon, 20 Oct 2025
 16:53:02 -0700 (PDT)
Date: Mon, 20 Oct 2025 16:53:02 -0700
In-Reply-To: <20251020175911.150815-1-n.zhandarovich@fintech.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f6cb5e.050a0220.1be48.0014.GAE@google.com>
Subject: Re: [syzbot] [comedi?] INFO: task hung in comedi_open
From: syzbot <syzbot+7811bb68a317954a0347@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, n.zhandarovich@fintech.ru, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7811bb68a317954a0347@syzkaller.appspotmail.com
Tested-by: syzbot+7811bb68a317954a0347@syzkaller.appspotmail.com

Tested on:

commit:         606da5bb Add linux-next specific files for 20251020
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=112943cd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=be983e1d3d00440c
dashboard link: https://syzkaller.appspot.com/bug?extid=7811bb68a317954a0347
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14df9734580000

Note: testing is done by a robot and is best-effort only.

