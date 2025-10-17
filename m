Return-Path: <linux-kernel+bounces-857825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9630BBE8056
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2CB7456567E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0083126DE;
	Fri, 17 Oct 2025 10:13:32 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE7E3126A7
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760696012; cv=none; b=ug/bNahX4BAmMV+sT8D05gJbnj/g6cLQDgJiPr+FYFQSUWY8hpOq+23oco0kzpVjhgKJtpdrnviN5BU/BBus8j6AtSnm38szVAhdLI8j/Z4xJWb4oJU939lLUb3BzTorg0r3gK0rFqo5/CnmJ6wcsebtxCXbPZfPDGGMcaCwbmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760696012; c=relaxed/simple;
	bh=j/ttDE8qYsz38zgQPSGWuX95NGbGI1HPRQHwv/F96no=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=huwRtCXuEM5aW4qbO+/CbM/TfMsDGi7lvvACiLcGUDn8JUdAoUWA/tQpiz6BrzczskNdMDyfECc1DmEJ15AE0/m5+xtYfTo38aQY2xn/bWw9shmBbdWrQR2+HK5Gk0J1/0vssAPWJ4hO07ZXjA+xjJc5Pqnhcm8Z30hSVkD22pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42955823202so36187625ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 03:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760696009; x=1761300809;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j/ttDE8qYsz38zgQPSGWuX95NGbGI1HPRQHwv/F96no=;
        b=b4pzVA7ah6epUBI5qLHkOVm1p0ZQT0xda+CkRaW+6pDhiFEpwPUwm9cMIjCDmPD+0q
         F5V0bsA5XMVEwq6W3AAg73K7SUato5/WdGgEWargb4YSWslkl+e1d8aoUgemDXAqa5gV
         jgsRGnBZraN1Ti89YYb84Z15Zw+qS8s1grWcxwSRS/5eKaokje378wxsbJkjOVFHIZQc
         un7+inL2ejFgUs8sRKBoWCpjhRE0U1WOTVz/4MkORVjxEoLpPSAcudD03AKzkaDeKIwv
         hC5r9H0vsEzTVs4uMMLEYbaZdJr2ulpdVDRgrwie72D7xOlJDJJrBxquJ3NTInSie3MZ
         Rmdg==
X-Gm-Message-State: AOJu0YzIgKFmb99Yx/Qoh3q51OBSF/+hl9gd266yXmzMNr9MVg7DCxwG
	vHTJc347Yxu2j+9NBlE8urO+llQ33H8tw9grLVpoU289c1kDMXk/1wqNlhguqYsTyDwABK+ROZY
	UDZwSu+wraVNVJ4SwbDVF11qiB60lUEjfXW5vHut4TwjcL+XfujFw1rIJGbk=
X-Google-Smtp-Source: AGHT+IE46tlGlmSsIXZFs/RMWyUc7NdFiEIksyAQgTJlPjRqkqJm8qlJzE94YDhwnzDvxTRqpj1zDuH4vFPinnOHwg0W8lOwrupB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1563:b0:42f:a72e:e179 with SMTP id
 e9e14a558f8ab-430b43675e3mr89310455ab.11.1760696009686; Fri, 17 Oct 2025
 03:13:29 -0700 (PDT)
Date: Fri, 17 Oct 2025 03:13:29 -0700
In-Reply-To: <00000000000052138306204134f2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f216c9.a70a0220.b3ac9.002a.GAE@google.com>
Subject: Forwarded: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
 98ac9cc4b4452ed7e714eddc8c90ac4ae5da1a09
From: syzbot <syzbot+5054473a31f78f735416@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 98ac9cc4b4452ed7e714eddc8c90ac4ae5da1a09
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 98ac9cc4b4452ed7e714eddc8c90ac4ae5da1a09

