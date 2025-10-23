Return-Path: <linux-kernel+bounces-867473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9FAC02BCD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 19:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F2CA24E4E0A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655B21DE4CA;
	Thu, 23 Oct 2025 17:32:07 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9129824C692
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 17:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761240727; cv=none; b=CFBqB8cPNOW9IXGQBbrFgq+ExL4mRPi8bt+Cie86/132YyIxgVrNYjcNskizOROIACH1BWMr3PVRcnkrLlLm0ArIielyc5/z0IXDhCvJSSOxUSf/p4yHM0GBWgV/uyH5sqAC6Rj+FDHShAgxi/+a4RxOi6cRQyfo3OFoSDXdG8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761240727; c=relaxed/simple;
	bh=Ai3qU+t0E3oAcduiYEJabgEZE+pKPxk+xczz8o7nSd8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NWrZgjqQnPQvQsx68Ycxi7HGJUWkFBBzJKGFl8mtq9nIUGgNnNyrgiP6YdD96KuI4L2a5p3scHfTINgSu2NPT1Eq+V4/OX7S8OzaHn+bSeL1XeWjXFdZwVD965Ce+XxShH0nveOMMue3LJdvdjsaXD3DobhhDfxPSpl8kdp74r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-93e7d299abfso111701939f.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:32:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761240724; x=1761845524;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ai3qU+t0E3oAcduiYEJabgEZE+pKPxk+xczz8o7nSd8=;
        b=G+2/ocqkWhJEk3wNu9+x9dnrgx6QD8rZxYPtf6XOVxbeVMeSkqZM3f47DJW7SJipUP
         UZ23UweqvOVaKNfeV/iELPtWJMdZobUEx4U2OUtN/PAh1fPQSjgna7tyy7p1LS3/04D3
         Yr+w3S2xQdEfJhXobt88Ape9qPBDDyaAMgFY+k7yTaoZOsSV6qa5u3yT0jLwdaGTf/5d
         iLRNB1T60GC+fD58Le3+nYaEOCDF75qskGwRDD4cERQe2+whUf0E4YjaIOh+gQ3RRNZY
         Bv6Lv1ahkpNlqYUCTAuWgTAm8YCtUpm+EopFRTFWG86Qn/Eo+/Su52S7Cwx2iHPLWaiS
         i87w==
X-Gm-Message-State: AOJu0Yxoooxh+YIZ382O+Is8IG8hOyPq85jxfJeduing7sFJA4u+cr7f
	sMmt1Q07mNXTYW37//LDY2pi7617Wkb5W4A+y1L6fHlplH/rniOsO3Biw0OQKTgs4nTRaWL9WQ1
	FkFWwWpZlPuDaORMl5n7YNvxqsKEuqnx/mnfXug/QX6QDyF9dCZbGKVbEn24=
X-Google-Smtp-Source: AGHT+IGREdYZ4nQIohltZ/QuLeOGwjCSw/yVC80a5CE4K+3PKe39e/Sq2rykrgNSZfe8GXFsPp5wvWH0EwJk6On7Y0sbzLbhwQ84
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9d:b0:42f:95a1:2e8 with SMTP id
 e9e14a558f8ab-430c52d5786mr327963765ab.24.1761240724641; Thu, 23 Oct 2025
 10:32:04 -0700 (PDT)
Date: Thu, 23 Oct 2025 10:32:04 -0700
In-Reply-To: <68f6a48f.050a0220.91a22.0451.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fa6694.050a0220.346f24.007f.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [gfs2?] WARNING: ODEBUG bug in gfs2_fill_super
From: syzbot <syzbot+19e0be39cc25dfcb0858@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [gfs2?] WARNING: ODEBUG bug in gfs2_fill_super
Author: nirbhay.lkd@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
aaa9c355

