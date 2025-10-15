Return-Path: <linux-kernel+bounces-853788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B96BDC99B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 07:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A260F192105E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 05:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0AF302754;
	Wed, 15 Oct 2025 05:28:59 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780AF4438B
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 05:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760506138; cv=none; b=rYAqDecSVYYGSEkWHqdMFTJ/y3KKGV8fUx77HCzfRdgRjAhUEC2dgcIxKmEvOtqOYbxZyWx0l7geI0YzMgdB/JY/KRdR3PbXXKiEPHTyYjF8R5Q1JwsT/DKSRbBsfDqEYwdbuxPx8Su95evKd8M440rq0rJ+g7c5rjtr2RWK/Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760506138; c=relaxed/simple;
	bh=K9jn/tdgaOgAEWu4MWi7o8T7BeMBKQLB+aUtdKsT6nU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=g2XvwQaiG+eGuPHCJ24O9pV2sxw6ggN901yzNMnrkMFYdwcYoUrWJWhnoS13EtzlzrAyzMneQNj4USP9/x0Hpvgb5LmSXIdhLLV6l/LIKds5gt2e+OyJVFiFSUefj3y8V3FZh6lkur1uhkBfhe5YV4y0bXO01OKpptoaQPpaMIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-42f9eb73b34so124496565ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 22:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760506136; x=1761110936;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K9jn/tdgaOgAEWu4MWi7o8T7BeMBKQLB+aUtdKsT6nU=;
        b=bPMEXmKbqsqXGsiXxA5647OIrqeGfxRr1SeHODF69V0fHCA1+JTFORd0Yd1KWcfZGy
         GMzLgqss0033TuDtCQ/0I1/C1dJkpNVcBW1jc6elpEOc5uGN1eYWYVdHfbSXlfsyxVCi
         6fl5N2UtddjGSoP1FRpVWv6yseZk27qLyOKqvdt6OWYEdZMeI4qAJhc7M52GbTadWsD+
         TlIzIHl2Pte2a+ILUpUomNjg/qZts4YMZVO8dx1bDSSp0WTz7Js+pGsPWYDpyhpoNt2a
         7aWT/jACVQD9olLtEksPBrazj+USdO3SzpbvEFp7bCP0qjj0sMFBRbPD01/dIgYsmqu6
         /Tkg==
X-Gm-Message-State: AOJu0Yzdob5z4j8Ut6imPfW8L/dLqUeY6lTVFhbHgMpeaUkD6bT6NuEK
	oDbpumRQiDaV+3fV5g44lGzEL6hT7UUJ1bwdawrjYeYnR3O/x76VyQt1mx97+A1sG4UG0dweg/A
	a8x/PqlWUNQzHfdpeS5CqSdBFP17Tmuhfk/1Zva2S8bysYIOdzLZosSo43+c=
X-Google-Smtp-Source: AGHT+IGaMqv3VoUHGhxdG0A+OxdOioKvAeO/MWhSkIECCckgPv/jUhx2CGo630cJFLFmoQ3Ia0+xiJMuUaAyjW/eY5HerjncyE4V
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160d:b0:42f:991f:60a9 with SMTP id
 e9e14a558f8ab-42f991f6190mr192192765ab.7.1760506136515; Tue, 14 Oct 2025
 22:28:56 -0700 (PDT)
Date: Tue, 14 Oct 2025 22:28:56 -0700
In-Reply-To: <68ef030a.050a0220.91a22.022b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ef3118.050a0220.91a22.022f.GAE@google.com>
Subject: Forwarded: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
 13863a59e410cab46d26751941980dc8f088b9b3
From: syzbot <syzbot+77026564530dbc29b854@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git 13863a59e410cab46d26751941980dc8f088b9b3
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git 13863a59e410cab46d26751941980dc8f088b9b3

