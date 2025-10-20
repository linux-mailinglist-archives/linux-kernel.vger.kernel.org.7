Return-Path: <linux-kernel+bounces-861043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05206BF1AB1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8ACFC4FA334
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6736321F2A;
	Mon, 20 Oct 2025 13:48:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8F6320CBC
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760968084; cv=none; b=fRaP52ciqfB7GPaJuC+/tF0acUcaa23JnnC3wr3vCpZcLlMGlfRWGaQbaQZrQZl3PCO0T3kQDDH/P/QnfIdzzvenvoSa0xBjxkdMK9oA7StCwKfBEhnwQDK6PVuNsX8fLMtN9wSdGL+09HYbwyjdmfg6b/XsoYl3v+wSGNmkqfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760968084; c=relaxed/simple;
	bh=GfpTFVcRcSVjCepTjqhIZEdxMK2PgZyCmcVVNIY5wOg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uiULuGRlToI9OjEhoxwu0oDDtmPzO2d61vYzEYoTdRFlh0KYoW7WuHn6ZqdTczwz7iXeaB7aPK1nMtU3v0t2SJoUcmcYoHs3iDHfFutRDkpf6zQDC5aSKomw5cDI0CX6mEp2TWg6S2ucqx1xMnmYzAnRhUrl+USqA2Frfx9uilg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430d4a4dec5so64668055ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 06:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760968082; x=1761572882;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+dcDvBELTD0Yqf3mHS24/ab3dOUXyg0eNh/yQnLhzZI=;
        b=jNxswtK+NTG8yMWBjacb88woW/mT9h+FKJZTe471HQST5SI+JNQlJsRCuIUMLnMJgO
         OUpz2NQma1T+riBxQxhdl6bxGz6X2aqOQhNRpOGnIihgVUQQz18K6ENdysHvkFZdM+PU
         n0U3xGs0L05E3Y/H8LIw0mCO+NDfLDgDLoi/3+oS5rYzE8rgrhrlbMgUoxcnhxK67/KF
         aeIsGX6Fc22lMWWTrDggO83RnifFNk6GZW11OpV1RhUqWsPsTJqa1WMBMlqtcmMPucSf
         9ujg1ISZCUSj+S7dpQVvNMZA3kAlZk1goJentV5q+bLTwBlDhhWXaxCztkHwi+8IiWDU
         PSbA==
X-Forwarded-Encrypted: i=1; AJvYcCVLyDWosZJgLzsHTWE8PNwnCFqCM+6/PjghMV+2x7AU/odJcETBfuDG5pe0VBlCYXDUkl2rMLewwxCBaWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmBvsYcwykPGlHq3nEnnU3JmxDjXR/lSWlJwm4P3i2/N8EjkZN
	wuM2Xo4V2qUCqMCBl6RnPTz//at2M1VgyHoSSTZQoAwBIcaiOaW1lxYcpePQ0GpEpJTJF7bT5M0
	niWVZq979y0k49ZZduIbu2okLjbiIa8xYP4Le0deHlbAJidMTxSrO300efA8=
X-Google-Smtp-Source: AGHT+IEZWYU+iTfcplmZkoUlNfwlf01ovVbTtaCFTMKivSr2GoU7oPhsfUvLS7IshPYoUk3YkXnJv8v68pw/ywvhEy7uIs9JyXOI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:156c:b0:430:a3b0:8458 with SMTP id
 e9e14a558f8ab-430c524e0dbmr190679565ab.3.1760968082025; Mon, 20 Oct 2025
 06:48:02 -0700 (PDT)
Date: Mon, 20 Oct 2025 06:48:02 -0700
In-Reply-To: <20251020111926.938354-1-1599101385@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f63d92.050a0220.1be48.000d.GAE@google.com>
Subject: Re: [syzbot] [net?] kernel BUG in set_ipsecrequest
From: syzbot <syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com>
To: clf700383@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com
Tested-by: syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com

Tested on:

commit:         7361c864 selftests/bpf: Fix list_del() in arena list
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1089f52f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ad7b090a18654a7
dashboard link: https://syzkaller.appspot.com/bug?extid=be97dd4da14ae88b6ba4
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12bf83cd980000

Note: testing is done by a robot and is best-effort only.

