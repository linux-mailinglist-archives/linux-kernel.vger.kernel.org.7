Return-Path: <linux-kernel+bounces-897727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 053C5C5375C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C84EC354BE3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C6A33F39B;
	Wed, 12 Nov 2025 16:22:08 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425E235CBC9
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762964527; cv=none; b=jHG426Fdw9494gVn0M0GTUs9ZAKNSmgA4NxU59Gvy6Ny77RF7NT7czgUoKK4ggrvwbTj2SPc4IpCccRfO5Dmd3jPYVmG2JdYd5/2dguYFDa8/ng2PmObgk3RPn1nquk0wxOqZud+nMgzcR56RkFK1Pek0exBw5BfYvejSmSxfZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762964527; c=relaxed/simple;
	bh=cixU1GbZlj5fxeZn90un8LIQ/VdA+wLtFm6SXUM+BiA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CQ9RQlDGnfHb13+cxkcX0It0V6YlP3SptjOJR0IZcPI8wtvpjRg8wDQZIuOl6cPvOijF1CWpSu+118qpUNqpgc08WyGrjnlPmUiuSBmTYWw7ckZWGB36+2R4wviEDaxSCrQ0LplAr6buSQAOIbCU4jxnFUUblRvSPo/PbsD2w7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-43321627eabso31683065ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:22:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762964525; x=1763569325;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DoyjQ3YIO63MeyLg77TJT0KQfu7ZCTmPmUtZi5iqY+g=;
        b=T52tCzpZb5C6eE7CjExoWVJzy1Zjh/FISDmCoXzX5KIpzi54SR4zT+3kRbkLE4njjs
         PrKkcHT5aYD3xI30AyB4xeQoY0yOH7vBV7qrThB/AwccjI4fYFUPFcoEx8BIZtFgH9ta
         VQT4sj1/HoRamU0x6fHozhyGiFc2zGVsvRsMd5AlTNLDtAH0xB/KkRz5S2uYEGpG8A7W
         s0qnLlIOHBv7j49u03Rp8SFKFJu/q8/zNC5oJ5l8FEhuwsM75wCzLEPT90fZTOxQbcfO
         3zWWRdCSyQ3Ty3o9r9dYGGxORSXzr8PLJfWZdR96tvzlAFoaJUchaOPM4g8JSC+W9t1o
         Azyg==
X-Gm-Message-State: AOJu0YxuaNe+/ZSaM9PhZvHQUPqbNaHDDm+BkkjlxfzlSrReP0Z0FFhY
	FXL2YT6aiNo1sIexkW4zuYvIfe2wCH4SKW6WPYrXBR7iTyDOHPrF/X2QALQ46Wrxv3aITiXnFxX
	JaZLPt/y+E6dKqx6MkEDws5Ck5TCso03aosm5xXomCMoHF//XQEk4zg55oE8=
X-Google-Smtp-Source: AGHT+IElD77UAh2wb0RhnzPn8tSTNgjajZv4IZsgpvd6WDc/AQpZFKI6vXZh3n6gsbIuOVW0a2RFcqVYOl8ZWeJe2M2y75kNisEt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8d:b0:433:2aad:9873 with SMTP id
 e9e14a558f8ab-43473db2117mr44294795ab.29.1762964525406; Wed, 12 Nov 2025
 08:22:05 -0800 (PST)
Date: Wed, 12 Nov 2025 08:22:05 -0800
In-Reply-To: <CAMz+-CPeLokTi6gfV-tX8Eb4DEaYJ6fW+8swtB+y2VY3SEKwqw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6914b42d.a70a0220.3124cb.0008.GAE@google.com>
Subject: Re: [syzbot] [wireless?] KMSAN: uninit-value in cfg80211_classify8021d
From: syzbot <syzbot+878ddc3962f792e9af59@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	vnranganath.20@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/wireless/util.c
Hunk #1 FAILED at 963.
1 out of 1 hunk FAILED



Tested on:

commit:         24172e0d Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=bbd3e7f3c2e28265
dashboard link: https://syzkaller.appspot.com/bug?extid=878ddc3962f792e9af59
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15358692580000


