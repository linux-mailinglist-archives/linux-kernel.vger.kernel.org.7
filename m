Return-Path: <linux-kernel+bounces-730973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8A5B04D1E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 02:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DF4F3AB982
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 00:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F881917FB;
	Tue, 15 Jul 2025 00:49:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3B5BE4A
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 00:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752540546; cv=none; b=PVUBdgGi5YNTop0/Yvn7K+6ug/Fk4Ci2mWQTMFaYSB///ac7vyYZYPaY2sARy5719ZJF6THEu62YPh3HqjUuyJDeHtXpd7G4dyOpgT+8B4oJtShe7l75dVHXphCL5FWTOCl0601+0CSFqvhGNNUeZ1bIDzHerzU8CzsVYTAG70Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752540546; c=relaxed/simple;
	bh=lOFVnTljWoAIwBl5fC91Gh2Kf8rLSQJL/TEQ2JT5CKY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jchyp8EvfPaa3qKmOR+Fk92kRSZF6sZQWGyRuMVDAHCwWVkieaJCpnC0iO+SuCHQbOI4BD+pC7kQIdgwRXj2AMGEYuRk3K9ohsWbZ52kOkNUshBxawaebKr4fW5xRZHkJLLcsaSmpAJuUE+9IjQ1c96mT69bW9II0Cw70e2jJ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8760733a107so551814139f.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 17:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752540543; x=1753145343;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sctRln4nhT6lqF/oLVmLlHGu2sRYeyXihQIqrgosm0M=;
        b=f9dodYwuNBlJX9f0zTcRTvCn+3kxos7NA18fu2v6R6qq+j6fwCSPHR6oLCfT9whZmi
         bFMfresZg8VUHuUyBcDjq+sm/wZlH8N09ZP+IcFMSWNiWVPsV7m6ypRINthXi/TAJxjm
         lY0UH9xlBink1Qv4zOGO1qQKO733yOkDwRqUAXSiHXr8f4N/wNX+ydrjpSEkZC+HRLB0
         QyRI9Cewx9S+mTJUa0C3l14TrQrqcu+dmxE0Vr08HAA+JQdgieYxovTo9mLo3hjBPIuZ
         b1Oo6L14G2W3AIds3M8PO/eO7LT++bqnKQQJmwLITqEZyBTW1OyQ8ZcnecloAhbvSjwR
         0LfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHT77KcY3ywWykf1SOoDxjxPWrxDnxHaCxnkT8rS2Rfi3pdxLcp5zoVFkociEWca9om3W+KQ/l5XWKrHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhLk+FWDWtKI65WjLcOq7+01sfFzjj+H9Rt5M1JKJE/ETRCbCx
	su+HnHLxhxRPVmTYMSIGNGpyhKi8eacWrAM9q2dFsIUJxropsxMjYJoUv4rL7b2A7oXSr/mMJ7f
	39/wUELlxencgQ7bY+twsDsJgkIGf0EiZxx3TfKlkDJBAYKjFEorLXafWUGU=
X-Google-Smtp-Source: AGHT+IGXNt3KySORmj792YpuWsUczqvX0lIozPCEFIZEVzgYkrOjMqIwPE9VSd+Ruf4CT2WeA99ZLbd3bm/aSOc3/3KftBlwJihb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:13c4:b0:864:9cc7:b847 with SMTP id
 ca18e2360f4ac-87977fe5c3bmr1947032439f.14.1752540543514; Mon, 14 Jul 2025
 17:49:03 -0700 (PDT)
Date: Mon, 14 Jul 2025 17:49:03 -0700
In-Reply-To: <20250715002143.4033-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6875a57f.a70a0220.5f69f.0004.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING: bad unlock balance in query_matching_vma
From: syzbot <syzbot+d4316c39e84f412115c9@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+d4316c39e84f412115c9@syzkaller.appspotmail.com
Tested-by: syzbot+d4316c39e84f412115c9@syzkaller.appspotmail.com

Tested on:

commit:         0be23810 Add linux-next specific files for 20250714
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=131ffd82580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=be9e2082003f81ff
dashboard link: https://syzkaller.appspot.com/bug?extid=d4316c39e84f412115c9
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11c370f0580000

Note: testing is done by a robot and is best-effort only.

