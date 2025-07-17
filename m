Return-Path: <linux-kernel+bounces-735553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D145B090E5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CA7118915F7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8B02F9495;
	Thu, 17 Jul 2025 15:49:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ED535963
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 15:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752767345; cv=none; b=YW2vKpJqOuEpCubdFNy7y3pDHhVuXQDE+cKhZrUqBpwmVJKtvI/sbRXKGEh6OzX2WPR1FuR0YBqdQ3PxUt/xq9S7vM+KIK1hzGTowMTRtLRvTQDXXraPh9g+2boWUt4zcPj1R9vmGe0xgRmT+aWvllKjqmY1TsePTrw0dWSGXPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752767345; c=relaxed/simple;
	bh=uwUycdhfPj6CaQoQpADVkvyXsmH6Btz4yJ0id2qySG0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lSG6qIZpkKs1XWtCM8kf/J235YFd19I8as40qp9oSKmBKS7yd1u0Z//y8b9HJWlI2xMxF9HkBX6eMtM86zXUnx0HGXHCNanFHD8OW24J619XbyEty9sXeJfQil1b3E9CXh3ZK1hnxHTAkb2QGYACM5BNMShUIAHPs6ggEC9QIrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-86d1218df67so109698239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 08:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752767343; x=1753372143;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8DkcvYYZYbeS9YyBNkSiQOuihRa5i8q/41A08t0STM0=;
        b=vYBXLcuW0Y1IjlVlNl3RXBFA4/MiQQzdchp24C1sedV0dxeMfL3O8G6k2Aee2/dGUb
         xufQbUKKzSALTx1nttb7Y5AEh0ExsFXU91C2PDrpTizGsn9mPIh2p+2cxNtuczJSz5Hy
         fVS6F/12Jlxo6fcHXTdOb8tmJcWJ6+wJLiW4pv9YNI1K3RMvZ6pdBh0WONj0AFMQ0z1+
         s6ACZv+vHIM4H0hIDQzuDWN5qgpH20VkgQkkVh6ABoiJtoBd1x78v4mmrQrBjPx/ILVW
         cXdvTCarxzzeY2ihG3312cls2e6PsfQRXtIX+A4mlK0J2sbFzoZZuA2flRYU6wvgq9xG
         4IiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPl92+b/ldKBrVv2wkUoC1EVN2vctX1J1mGf1sLi6FVJRSKzhrFTKcwEDS792Y9jyV4MaWzJ0qOZOm64k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7RJgyUomgC2IFEb6/lPN5jQB8g0hFxaKm4nIxVU0qNHDIbmVX
	b4rdb2cQbjcJm+LxUmHwHxZOCqybB0bS6k7eX7kQmzAF2E4x0lduNSDnNl/2CeEym46tgkjLY1o
	GNC0hoJomCT7J6AK8X9UnOq/jDGFVmfWRuZ/wx2s3i2vKUGlCxHKC8ckO1F8=
X-Google-Smtp-Source: AGHT+IEf4fyoxXity4Kr6+dzWapHEvcoVCaE3mpTKdMN7UYWTnoIPlTPex69DChCvZAIqhHVq3jwH0inF1qmM/cRIz94nhSUN0lN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5e:8801:0:b0:875:ba1e:4d7e with SMTP id
 ca18e2360f4ac-879c28a63bfmr745475839f.6.1752767343310; Thu, 17 Jul 2025
 08:49:03 -0700 (PDT)
Date: Thu, 17 Jul 2025 08:49:03 -0700
In-Reply-To: <15723551-960b-4257-bfbd-073e136deaa2@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68791b6f.a70a0220.693ce.004b.GAE@google.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=148b258c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ec692dfd475747ff
dashboard link: https://syzkaller.appspot.com/bug?extid=b63d677d63bcac06cf90
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14dd1382580000

Note: testing is done by a robot and is best-effort only.

