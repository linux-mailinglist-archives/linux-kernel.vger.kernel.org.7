Return-Path: <linux-kernel+bounces-791227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 705BCB3B3AC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96FDC1C84664
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 06:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8E4226CF7;
	Fri, 29 Aug 2025 06:53:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1961B2253A0
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 06:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756450385; cv=none; b=RxR6DiOXdrLaJTU/0T57w4EEv8OF+NrLOgj0TwtjuGrM7xva32Hwl1Cj8A2T8cD6dXUGqHOFwgIz2HzBsjiEU79VjPq0L8neAG5B4G4Dw/Pm7aYbb+6YRrzV9FhBkcdEyvxX0OHw+jBkvE4rVXqFTVXeEtnhP/rIi+SLqeyQP0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756450385; c=relaxed/simple;
	bh=515v1XVWw9Gx3Elg9gOugbk3ZtW2xlgnlHrw8troDfc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=S522oVJFAyquXbDsX1VUYNEG2KIlzfY4sixfLZ24VmhG5MmezeElSrYLAiv0G+hnDyRJPGH8AwTZkle4zLf9xk2qVcsm3zp9qayKQZHWyTQtQ1htFwP4Rtlm12i7u+tt26kXU6YXa3nYKTcK0enmvZA/CMIkg7n47QHmmKaoe8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3f0d4ad1c3aso24357755ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 23:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756450383; x=1757055183;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PbZ2TTyQvIjbFD78j5eXpHav+1/7SVT9tTZrs5+tgvw=;
        b=VgnZodpUySyAnZGJl/xYZLNQ531T+z5Cm20KGZ1EeJ4uwAX+26ulsepZWP6pGHmLgA
         f7qf0Bb6pIk423IcYNWxgbzopK+UROXfMpOOL+2yaksnKCClrf1Nc771wVyZOc6g9p8y
         ybf8IYKes0UukvZaZvev74WW3amE58nmKSxzKDECADOiGBn2LdASq3IhJR4uaXxHZ6nc
         DyfdwaV61bMkXs2AI4jSThFz9t/nUuQ2OGT+ZFmfAoTpKjuArtBbx4zi/xl/yefay7x6
         KEhiNK013tZkvg03TWA3bFySLdML7F1Kf9jFGaBBI9D47YrYIA2TR4Oo3aMLO2EqJXTF
         1dCg==
X-Forwarded-Encrypted: i=1; AJvYcCXTsRFuKBl1/lqscDIRE0IqX3PW5T2z3cdSZG4g3qKvCaLhOOL/0UYYiSComQCTXtcjHkSPGNtpyq/ViSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfGjTLAZ8ymWrwlvdUB6E3A4sSpw6uX89AZs4BYTXZYR/CfXRJ
	gie2Esm7b4I3GsMSiRQ6OwNHgYk56IZ4KP2PPVI8P+G82t0/MOLDCf0lETy7WvTSkMBV5X5+JAR
	3LuwUJdK68fcaWRx3uieEjOnNQvsBeVJ6+zwLzGlOm709J58nm/AumbpTUS4=
X-Google-Smtp-Source: AGHT+IEiNboYxt65F2g9X9DArjfAWKS4IpTbIPiaMRP69qh4h0hmvviSQggi4E76fn4qQgxdzN8fH2M2ELiQCeOhOeJHIHiy0K8Q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148f:b0:3f0:78c3:8fc5 with SMTP id
 e9e14a558f8ab-3f078c392cdmr120467105ab.5.1756450383255; Thu, 28 Aug 2025
 23:53:03 -0700 (PDT)
Date: Thu, 28 Aug 2025 23:53:03 -0700
In-Reply-To: <20250829063046.514229-1-yang.chenzhi@vivo.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b14e4f.a00a0220.1337b0.0013.GAE@google.com>
Subject: Re: [syzbot] [hfs?] kernel BUG in hfsplus_bnode_put
From: syzbot <syzbot+005d2a9ecd9fbf525f6a@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, yang.chenzhi@vivo.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+005d2a9ecd9fbf525f6a@syzkaller.appspotmail.com
Tested-by: syzbot+005d2a9ecd9fbf525f6a@syzkaller.appspotmail.com

Tested on:

commit:         07d9df80 Merge tag 'perf-tools-fixes-for-v6.17-2025-08..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17b97ef0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd9738e00c1bbfb4
dashboard link: https://syzkaller.appspot.com/bug?extid=005d2a9ecd9fbf525f6a
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13897ef0580000

Note: testing is done by a robot and is best-effort only.

