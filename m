Return-Path: <linux-kernel+bounces-843242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30431BBEBCE
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 18:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13C85188D0D9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 16:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863702248AE;
	Mon,  6 Oct 2025 16:49:15 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942A521C9FD
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 16:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759769355; cv=none; b=SAxfdYbFKOfqADo4YmiT/BlKA0TTvs0u/g+xc0GIOw0btRs5vRKo6lFJVijpEw4bOtzP94c2oiT9twZjGVjZuoeIvIm/xtwC83Bw4GeTHZEwtZ3JgPG85a/sUBybxO0YjYjpK85Jq5BfaO0D/S4ZUrq2FETSV0I0T5V1BhMz0rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759769355; c=relaxed/simple;
	bh=7u9VHF28LycVAbcuImNfG1gQan93jxHEE5qMR0VSmrc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KP40J1e863PCYTnh0dcAxSoGEbFZC2lq5EJ3zPvqMvQpPhrU3tIExmHxPxebhFGHt7raQDaLAKgQjhbM1ORF+yinGABvk/S6x8TLKdYSl33xC170LCWGPOGeleQpHfRSY7OYsXHdiHolKVqMmFdCT2xtp5pLCIBmLF6gaUcB1Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-90efeb58159so585970739f.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 09:49:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759769352; x=1760374152;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7u9VHF28LycVAbcuImNfG1gQan93jxHEE5qMR0VSmrc=;
        b=w0HthDn+bARWXm4yGAMVEyJQN1ezbBwRxG2+8QTBupCmiDsNiI5ANuwh0xAptr3o6W
         t00Y0v0OMd8ehOPXBFyetRZ9OIIn6CPoOaRvz4yGHt6OhohhiEgSh2hjjy5Mxf+g+rZg
         87PUME9r0rx6r/hT5MclLGyFlYv9lip0rTM5KolDLcTajuXi6HHVQ12UPImHK/SfliBr
         ohevezwfnWNztDaMStQ27vFpyY0fGu8XfuRpRapK4I7zVajxQOAC3BpM5sa0vSOpYANh
         VgPhFOMYDKegVOfVzA+kZ/j8fZbGJhEtDmvzxjakG9wa9Mqryi06zOMcMeEpL21V3+ta
         7dNg==
X-Gm-Message-State: AOJu0YyUZEEA6zXpkv/CPru8OF/yyPbUD4e+Sw0qIzkhRvKF3x1uScEg
	KjlMxgniOpgvSTi5r1tQmbe8kgYhksDDoWAFkN6XmO+FoE0ANCrRlRi4bknZg1eUh3Wz28Fgut+
	8kvJut1lEPpYgdm+wf2Fh/yqwD65cupDstjqQKcO/jsrZfHgcyHCmIhCAo5A=
X-Google-Smtp-Source: AGHT+IEIHEsVjw9IHaS3ApdTdywLbc6I1EAn8S1qBtJuXBUYMIpXxjmnjiuWQ7jqVhfb6kwKPoTHodV8PwsZ/bUAN6D6nhF7TId9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1406:b0:8fa:23a2:cc36 with SMTP id
 ca18e2360f4ac-93b96b242c4mr1799497139f.15.1759769352699; Mon, 06 Oct 2025
 09:49:12 -0700 (PDT)
Date: Mon, 06 Oct 2025 09:49:12 -0700
In-Reply-To: <68de0b21.050a0220.25d7ab.077d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e3f308.a00a0220.298cc0.0465.GAE@google.com>
Subject: Forwarded: Test: cgroup
From: syzbot <syzbot+27a2519eb4dad86d0156@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Test: cgroup
Author: nirbhay.lkd@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
master

