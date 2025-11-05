Return-Path: <linux-kernel+bounces-887161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 965A9C376D4
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 20:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCF533BC19E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 19:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2A232C951;
	Wed,  5 Nov 2025 19:05:18 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADA12C08DA
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 19:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762369518; cv=none; b=Kc8TGyA8MsnNGfkgnq/zyn1/+DWFRjJRP4izW9hVg80xArtMEbIp9YihB/z/5iNi58P064RYgbJxpp2WQsZWjDo0XiVFeUHzIvNNCaciHWvtQk/UDWyG8tFmdK8x0htcb0up7zWSBpnKnwMIH4JVK+Ux7mk2JN12jS4masv6H8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762369518; c=relaxed/simple;
	bh=foAD3VAp5D7YieYlBATJtz5KKRvnEtO8TJhnZDOQw0E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=KciEVr+g2TaTx8NiO0EoHhp7KS8PnZb91Q0Uc9veR8aSf+fsA2vSJIAcL0+Wm7X2o9HiompHdRzsdB80vWZSfhZib2IaP0EczhpYwR0YJvwD486caRRhh0ZkVs9yrpfLyRR2sVX3ADJuPlNrlqLnF1ZNna/uFj/77zvw9IFDDnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-940d88b8c15so9282939f.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 11:05:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762369516; x=1762974316;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yRRzlP2SUfiESziI9LEaCdshMF/xNXFnIzUbHvATzWQ=;
        b=sDq6Rg/UlLSoajrNC2QWq3c6xcNyjHQ6bPylDwscf4d2FTZct0HDcTXMXdnbHiezyX
         lVHTlfGAatlqKOiFHt8HVhN1Aca9A/hPC7EC47DothSfip+SYQmniFyPHmBK5N+SV0cf
         s2gbrgawHR0qpX/HkWOKfaIJCLp84uqMhYnl75CXWiIBVnVeOWYBwHYIA3YamBIbLEos
         2LA4CeuO3x/EncIp+1FBgelYmzTfhasHmeTPZfMgB6UgORjwDS3jP4fHNIRX4M+/Akuj
         cet83cu/hNvjECGWCdreiqqDhjqO0wK1FUZtgVk7yq/a28L4EEWqFAn8h8kvcwfKlM2d
         fCOA==
X-Forwarded-Encrypted: i=1; AJvYcCWZD4/Wi7X36Pr1h+yzuAdVhyEz1uyBdOrVWglCUMevtd6giHixMOMi6tg1/OlkNSDL0Ick2G5VX6XTolM=@vger.kernel.org
X-Gm-Message-State: AOJu0YweeWtAvdX25rrBC2nMM5vq3tw3kOpyXa9YE7X0roHrrcHmVf11
	qipNZjqR04g63Bs0WsVgTudbXqx03rsoob/V+gjXy/vo/+KIDa2hb70ko8rVaUSz4jITI9nurq2
	7GtBGWPrZWK5sd+/5blHJP+cxC+tRuBteRo4S2NBsDEUEad8J/cZMiiCjKsg=
X-Google-Smtp-Source: AGHT+IEJ7BOY6DuWAxm6vOrKe6KftA2tlCq5b20CZ9M+xK3VVjzMwMfxmhm+W0tgbeQxCc9Incv51aecgJHT8WRUqCE4Zv2lITeh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3c82:b0:433:2844:111e with SMTP id
 e9e14a558f8ab-4334079a241mr65949175ab.14.1762369516287; Wed, 05 Nov 2025
 11:05:16 -0800 (PST)
Date: Wed, 05 Nov 2025 11:05:16 -0800
In-Reply-To: <4981d33f-c45a-46d1-b091-e3d5989c8516@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690b9fec.050a0220.baf87.005a.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_unregister_user
From: syzbot <syzbot+14b6d57fb728e27ce23c@syzkaller.appspotmail.com>
To: ssranevjti@gmail.com
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ssranevjti@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test: 

I've failed to parse your command.
Did you perhaps forget to provide the branch name, or added an extra ':'?
Please use one of the two supported formats:
1. #syz test
2. #syz test: repo branch-or-commit-hash
Note the lack of ':' in option 1.

> https://lore.kernel.org/all/20251105142251.101852-1-ssranevjti@gmail.com/T/
>

