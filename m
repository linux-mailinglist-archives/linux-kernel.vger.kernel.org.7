Return-Path: <linux-kernel+bounces-820540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E356CB7C581
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB0BC1B25E7C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 11:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EC62EA483;
	Wed, 17 Sep 2025 11:15:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3354B2EC093
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 11:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758107704; cv=none; b=DBFgZmwlkAgpX2JG9lcmeKorGKuCF4PB1buFi7C3IncZc6sPx6QMUAw2kI04O4P03xP25g31rXiwdwuYVGcWVJwxc9W0GdJnTPaZ0sB1Otfma3wiAG3K6NulbnjcTgtNWhS36NxB54VXBuN7dfXB8JlBJrLkoGfIrleXN89sjsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758107704; c=relaxed/simple;
	bh=U+p7Isrq3McmPyqfduHOueGdlsy1Pc5poZERRmM6Yl4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lMGs9zC5ED+5v/xbhEO5Y4s4awSY4AqlJ0+Ceu0LkPJbMdFr7P4nYiJfjLzXA0kIOhg+UDbXSMsonC77WUe4TCKgwE72tNJAOF9lIfY6PU+Ko2fff7sjonh+/2p72kd+UCt5Uw6XfJ7rYHXSRq+Lebtclw+XQrUWc4RYkVwfXKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-4241c41110eso9117965ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 04:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758107702; x=1758712502;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HR7BlwgVVdBSVih+ruTVLgW7mijzJPDteGad5tsKlV4=;
        b=i3xQ/plYbTQEXPcmbxJIFCN60yCaaSEFJGSn1gNmHmGemq+rQHVbywviP0cAY7Zr+X
         NBxLyd5b/Ft/j1LBzdfxB8PtqgqGZbG+VTW62W+K0ALN3O/BY7WIrCBz2k6QRBNCn69t
         slrt/fzfk/6jh6j+1IdeQJDw9+ccgiccxPkVCjVzBidJTwuWZLhHOIDDpSn5TAHa9lu5
         lC5nXj3/z7ExILsVz8x92yliNRZPtmIQSRlwrmhLEX5kuIZ31knIpOsVRw28qhYo+TpB
         C+hNH3AZ1vKNvZFD4+Fa+uMEIXpbNLPi+AHIPSJS+C30sS/+zaCeQFl7U9unt7NkrmvN
         1O5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUKEjOAP1GNre9L1YpDBu0ofaXMAFN2F62B+pYE/nFWpv1HjhUvgSb2gLSFbOs19ahm5NSAJWHGzaLjbOE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1fD4fJ2GLhwpKxqKJjFpe3wb+GwyBs9kOGAehmpEMrEsRB7Qe
	r8Z+QEc8oiJqL1yi2qQyD5/CV9fM5OA7CLKgERagXTFtl0CXqYxgD62akCfY5dCOQ4Areja0sy5
	SN0Ybec4PEmB6c8PkGgY+qB5iBTfHy6VlF2SP7og1dI+ZXXqy/VhvWIKiYVQ=
X-Google-Smtp-Source: AGHT+IEZdPVaFerRbKBwLPJzKPrEbZZzci6XuuMPiiDuRY2iFTeAdk/8HfX4+YCa3Dq/oMhTlKU1OIp8PcGsx4IdHg8QG6u/TvLT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2195:b0:415:adad:fa19 with SMTP id
 e9e14a558f8ab-4241a4bde31mr21197225ab.2.1758107702483; Wed, 17 Sep 2025
 04:15:02 -0700 (PDT)
Date: Wed, 17 Sep 2025 04:15:02 -0700
In-Reply-To: <CAC_ur0qzBK7KZCrme4RyZj=efQ1uaBgLNvs=28Dinj8VDBkbFA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ca9836.050a0220.2ff435.0537.GAE@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KMSAN: uninit-value in nci_dev_up (2)
From: syzbot <syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com>
To: deepak.takumi.120@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com
Tested-by: syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com

Tested on:

commit:         5aca7966 Merge tag 'perf-tools-fixes-for-v6.17-2025-09..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10130f62580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b093ccee5a9e08c
dashboard link: https://syzkaller.appspot.com/bug?extid=740e04c2a93467a0f8c8
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15bd0f62580000

Note: testing is done by a robot and is best-effort only.

