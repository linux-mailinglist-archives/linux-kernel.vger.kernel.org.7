Return-Path: <linux-kernel+bounces-724300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C484AFF0EE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D833C1769EB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620B521B8FE;
	Wed,  9 Jul 2025 18:31:54 +0000 (UTC)
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE0618A6AE
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 18:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752085914; cv=none; b=ke06Z9w0HPDNA7wIKCC68Z1UrGYiBI8tWDiZne+Yf83h6vx0eJLR3di+ysFozDan+2wTpoAAuQtuMU1fyhacoU1AOmNvtz1m1dycEmkKvTJXehPt7Z0kgdOafDkdxu65udgjeQKZw+gsJbyXHi4P74xtBiAET6gupj+Q8b6N5N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752085914; c=relaxed/simple;
	bh=zCe6trQPg9Z29gRnwSIX6zG/1tL57PNheb9PLv+vpeA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Lt5zc9dyHssMkLzbQhYRFr8FRt3rivCei0KuwB7t+dg13lAliGQJyGlr/JtyvfUWqf5ZoPKu1X83M+rphxqtjnKY4DHZoo3wahhACpqbHqJZB5qfTn1fgiwBGUxZEYeGe66dwyjmQupZdG75MBV2TPC/oHfQu5ZImgntIqOzhWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-735a5ec8f40so1050456a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 11:31:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752085911; x=1752690711;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zCe6trQPg9Z29gRnwSIX6zG/1tL57PNheb9PLv+vpeA=;
        b=uhjmywbZdAQ93VHUSV9NWkAds+G4u8JPEWWER6X/f1KvRNRjj8g1VsEakoNR3GBkzj
         KfNSCeLWQDn+/cWSgmnm0olLpfohsMF8VoHSxtnIwzcsVC+V+3QRSBmVoO3co0IzaJBc
         fldKebQ5lk0lHdRvW1HEwfBS3gg7SqGD2xLId/LrGx2s7PLaD8bscei/0yTTumR7Hrp8
         eLZznnbxOJnr8O0W1Che69nYJon4+yvHhe6xCfdPyXoyuKAiRDM4gZ1ACWmZB1hR5L4G
         zBtkgkAVG05uu85hLhKaHRdyMjVmWgm+d7C8SAmjP/f7/+MIxWsIctccwPuSXrzVFhyy
         GoDg==
X-Gm-Message-State: AOJu0YyC6GAXfx5xfgYaM4Hwh+PsqQ/WE5XWJbXrmtZDNkrW9idzJgx1
	/OrkvOo5BhlKjf5MDQQkTnQgoLYpxnOTClxBmttiszYBiZVrny7B4cOM7AhTUKbeNvWmE4lb/DL
	b2V6GpiG4Oa73dPCszwFqTrS1/tGoAJ1Bl99ae3lonJxgJh60w1ZN2MZdehc=
X-Google-Smtp-Source: AGHT+IFMDU0Y6tVlY07u2IvpNwK2kUmRRnc7JPP95wJ8p/oDr9Roeqnz6kNAsgsVj8S2DGj895ChrWqWsf/rc4EVSQLAKg4JNtSW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6830:2b29:b0:734:e177:b402 with SMTP id
 46e09a7af769-73ceeb16341mr349158a34.13.1752085911726; Wed, 09 Jul 2025
 11:31:51 -0700 (PDT)
Date: Wed, 09 Jul 2025 11:31:51 -0700
In-Reply-To: <686e4c4a.a00a0220.296254.03c1.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686eb597.050a0220.385921.001b.GAE@google.com>
Subject: Re: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
 733923397fd95405a48f165c9b1fbc8c4b0a4681
From: syzbot <syzbot+2de68371153f0da8af8c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 733923397fd95405a48f165c9b1fbc8c4b0a4681
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 733923397fd95405a48f165c9b1fbc8c4b0a4681

