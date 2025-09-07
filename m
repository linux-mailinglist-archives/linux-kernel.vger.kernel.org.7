Return-Path: <linux-kernel+bounces-804832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C70D1B48077
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 23:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C38A8189D3E2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 21:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B63F1FF1C4;
	Sun,  7 Sep 2025 21:48:12 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F011C6A3
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 21:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757281691; cv=none; b=Wzl818b1n1ZyPLcRw1yt/5vIPh3qlKrn/6/3ELJkn2Vr/s566/gUt6tIWRwn3Pi0VhFDItdiGGYiqkAkyqoDujPHgWCiEP7/LL+JX78wrLHFiaxLtqkaXGaUOBl9w/FE2mKLATBHFEdLIC9fYAcQ5ooAkw9aj9eMoBqcWs0s+FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757281691; c=relaxed/simple;
	bh=BWNbWpVZomaE1W8lB2IbONqfZyl6D2OoCnNdyH1vbSM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cOv22556LF/aUnwsGBO4hQIQPn2MCrbphbTgB1UXnsLsmo8kt+gnJaW+MJmp9jXezEHBCUa0kzEgsGNDT9sFosJsHJNEX5vCCg0A+Kbfgdd6hGDMiB5gJ0xFjBckUp/48KBXDxvt6DNMTQvjX3d6689lxao6A6xxZUlTrgs5gu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3f6665a4754so104258035ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 14:48:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757281689; x=1757886489;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hONt7RiRUU4jmuWawCVuWGBTIWAiXBc6UiDO7GKe0k4=;
        b=oYc6lAGdZpYP41xg433JLIgQi1z+jWSe/WE8GeqWnJMT/l978A2gR1SSXVFTJnNtkP
         bUdCVoXKyjd8xQIt/Tfrme1BWL54KVNpQJgN1qZ58hXOGWQJLMXTLYzko5JYTSHb/C26
         miKbUX8oFMC8hBOqrInGUUM2OyOzb9QNihpaMf7lL3FKauUXPnIbOBJD3c47XuthvUKp
         aQbrn5CAyKgpNlPmTVPeJSdcyTdPp+tr7FVTLFWlXIIN/kUoCAIFK/O5jduaX198bPCo
         EsVrDQBOjPukXNbyQFZNtfwBmtnG4lUil3M9NzZanOvvmDapfPf6Xo8DGYbM9INwvuXG
         meMA==
X-Gm-Message-State: AOJu0YxUPlAVHgB1n5sWRpE+KUWjKlp0nMWvO24Ksf0xQAEZurf5/aq0
	d1ZAFqnnKlPGvcRUChJ55XLaIqyE75XgVhMCFL4C6Fqvc+lWdhXTcqKe2Y30NBoZPaX9I9rZzab
	7+Vmefy7c/LljRHgZ4pmYDNlJ1dJ+nsDkhqimW93XSWJLghaLa5ci/CMSsho=
X-Google-Smtp-Source: AGHT+IEIS5zo4HRxVOPOJH/ufMSOQ2Qv+YOHV7jTNkd6EhVbpeSqy3GJNQc74VTW0GXW9hCscY9F6wLMThX46YoVTXH9ouH2D/ns
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4e:0:b0:3f0:f671:aca0 with SMTP id
 e9e14a558f8ab-3fd7e252fdbmr87901625ab.1.1757281689509; Sun, 07 Sep 2025
 14:48:09 -0700 (PDT)
Date: Sun, 07 Sep 2025 14:48:09 -0700
In-Reply-To: <68138dfa.050a0220.14dd7d.0016.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68bdfd99.050a0220.192772.01e2.GAE@google.com>
Subject: Forwarded: Re: RE: [syzbot] [net?] WARNING in nsim_fib_event_nb
From: syzbot <syzbot+a259a17220263c2d73fc@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: RE: [syzbot] [net?] WARNING in nsim_fib_event_nb
Author: maksimilijan.marosevic@proton.me

#syz test: https://github.com/mm51593/linux 2871306d95759d0e38f9ce636e1bef6aef431aa8


> 
> 
> > #syz test: https://github.com/mm51593/linux2871306d95759d0e38f9ce636e1bef6aef431aa8
> 
> 
> want either no args or 2 args (repo, branch), got 1

