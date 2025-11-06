Return-Path: <linux-kernel+bounces-888718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B021CC3BB8E
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5CC82350DA9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291E7345730;
	Thu,  6 Nov 2025 14:22:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3990B33C529
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762438924; cv=none; b=KWmp7DyOSZfrfgR8Jg44N7on9UjAWvK5hLbUaJ20TmgDlc+Mp0H9Au1QhrcY2Gnca9nP732Ee7+F8SE00CzPImNongx6ajdMpLezlT1RtNxrDmG3/E+AOfErPwEELqcGN4jbjrMEUjjrCa7uGRoadWFevXqeSzqP0v/cUIEr+Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762438924; c=relaxed/simple;
	bh=ZlAJ1Fxjzx2mgXOVW/VSUoL4/8qbs5U6HQhU/HeNmZs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RtCdXuam9uWxfQsbRsao5TwFOI95TjqSpjS5vPlUzC0c0NS0UA0tCIbJqlXThobWp8XXnN3u/XQ/yAe4auiBJE47iw8YKFvD0srkUXkpaoxxPJJwh0xlQujEV3jx8cTrENa5dwQ1/mK1AE/DiVe4F7d35ep+MlaBe3E/OgNFJYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-43333f50556so10213215ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:22:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762438922; x=1763043722;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/5CCGL9kmizTngSG/cTV1+QEwEMhTlcIpLgbiwj3ccg=;
        b=G7ep9Z9Nb1VbEpB82FQ9GAwMQDn2cJ8GZKyHmeDhtYhDJvwTU9mmSifGUtUbVrvSlS
         k24imGsl3jwHc9PGWvK6Tbkdc7V8C13A+tH1pjYHgnfM8g6WFYne21nFED9cD8ndYTg1
         b391Okq1ujSjipi1hKJmRZfp6RH3l4h6RKdERivk4jOvH90ylFK0Dc1sK5+mwYtjHScc
         xKPeDyoIbhhUgrnA1VdM65RVQ1RjZQ7X3aUM2IU5xXCk/v856P412gPBvlMilfYQCxtd
         4GhtQnWYR0XneGfm3H8z3IIZuFElcauPa6iV7XDpYMre5XRkRmMmvujvc/T0PGlycl3E
         0vng==
X-Forwarded-Encrypted: i=1; AJvYcCWcpHoY1iI27XR4O01YMwFoJLDGglB1hZ8eTqhBTtzOQ6sBiY04gJrRp62Wm4dxhFnIB+i2jGZ9oZeXoKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsHXMdMmtFjbFP0i73we+tB9ZUI1bLOjTIMyhZJOLvTUEE/2fg
	zPjObT+wXzW2/Ht8GxaR83GUT5l7n2JBqqoLRqfvhw6y9DLksadSaesIeE6vOsOQbRzfiw/L1ku
	fVWt9L5Yc3a5CT1JD2oI/c5wfUNTHn+odhOE/FcOu4ECz5lIDbg22L1ZmOFQ=
X-Google-Smtp-Source: AGHT+IHgVANv+IIbVs6kOqE0pft4cy18BhetSi/JO+BMCVp+iwgbnce1SlJD9uESBG22bvcJ9UrYSamenc/1Z2VTXWWFFl2klIRU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3712:b0:430:b999:49e7 with SMTP id
 e9e14a558f8ab-433407d4f9fmr101993465ab.27.1762438922463; Thu, 06 Nov 2025
 06:22:02 -0800 (PST)
Date: Thu, 06 Nov 2025 06:22:02 -0800
In-Reply-To: <20251106135658.866481-4-1599101385@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690caf0a.050a0220.3d0d33.0159.GAE@google.com>
Subject: Re: [syzbot] [net?] kernel BUG in set_ipsecrequest
From: syzbot <syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com>
To: clf700383@gmail.com, davem@davemloft.net, eadavis@qq.com, 
	edumazet@google.com, herbert@gondor.apana.org.au, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, ssrane_b23@ee.vjti.ac.in, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com
Tested-by: syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com

Tested on:

commit:         b54a8e13 Merge branch 'bpf-indirect-jumps'
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10dae114580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e46b8a1c645465a9
dashboard link: https://syzkaller.appspot.com/bug?extid=be97dd4da14ae88b6ba4
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=106ae114580000

Note: testing is done by a robot and is best-effort only.

