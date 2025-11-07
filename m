Return-Path: <linux-kernel+bounces-890299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE59C3FBD4
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 12:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AC203AAB2A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 11:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA0E21CC58;
	Fri,  7 Nov 2025 11:31:07 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA231DED4C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 11:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762515067; cv=none; b=QL1gzaEn8SSUD1RPpF2qbBV8g6wLrPmvoiJo3Z3gGJogjKF1UQWfq7kT+cQB1W2FHjMxpOKLOAVCDYxsvv6XhkfQCTAq9OVdJAm550LwFZ9TWcEkmay7jP68u0Wc5EMIDw2ntIYULbRBE8A0aRc5F2iBSD3h0xmhGHlidWxtJOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762515067; c=relaxed/simple;
	bh=eKxVo6NezcKDET9QSkGOnF8w4Ciylkw0a6iF0CGzSUA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=vD9GOAhs5YWKRvcebzO9/CUPWmRJUaTucnDqN4MZgwwvh01KyfLcXsnGKBFdJjF/P1MMp9gsosFNLFZsZtj7TEqttUuaQYvTjBzFLzSClfIkMNpML7sCHDD6ohOhFKFSO/zC7E6FDjTWf0t8c+/R+gt7SjX3Sd3ardxv/ECNf4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-945a94ceab8so55169739f.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 03:31:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762515063; x=1763119863;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LWBe8qaRWJQPyl70+c9V6YvsBWAlbk19NM1mJVLV/hk=;
        b=gTiRzfAM7APhc1tjuJhO/VUiIv4ihzkA3jZWDr53dUdqecEezcJZ8vxI3vpld3h5G1
         S21qh42DZDZ+jqC7OwyBAO8+avmJZNoYxwb+7qe6to9KQ8ZmG/EkTilhihXPvA4von9A
         Rq5R3o4zfDOhyEQ0n6G3q+7PbtUdJPAXq8XwWb9ouP6t/xfvF4UWSAMVGZE2PKmuKW5v
         F5jam1HIGHvBDt+ZiG7y836aK3v5GGo7IpGVbvkFkY5KzsdKin5DGxb81CEnzPy1mNtH
         SpcPfm6OXnvzGsjBu2ZE+KkCl9w1SdOgqAVaW8AhTtIQTZUTrf/lVRX0smr9w72NAKsC
         tpVA==
X-Gm-Message-State: AOJu0Yz9N+zSWJg2/lWQYnvGCHJQ81NvIzls/8g3y6Oe30cn9eeGJ+wR
	XWo3xMaZ1TKRTPZ8yIWcBMvStaDEaUcZVSR2y0yPOUnEP5AR9K3zEJdxLt1haY/g7BYU2wYpmR3
	mLDP3eSnc2o4vZDI2PkxCEl5/Fr+vaKWIHc/lFELIzc9A++wWsYomtxVI1NI=
X-Google-Smtp-Source: AGHT+IGJpqa/dadVcX8jxvGROXNkC+a7VS2lL6ZyGEfUzf68JGvZEUBVunWZGLXdRLWhIW7XHh61zH4OIbWUec0ITs47rHu3eX44
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19cf:b0:433:2d5b:96ce with SMTP id
 e9e14a558f8ab-4335f3ee280mr38409875ab.14.1762515063324; Fri, 07 Nov 2025
 03:31:03 -0800 (PST)
Date: Fri, 07 Nov 2025 03:31:03 -0800
In-Reply-To: <690d9fd4.a70a0220.22f260.0022.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690dd877.a70a0220.22f260.0041.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [jfs?] BUG: unable to handle kernel paging
 request in diUpdatePMap
From: syzbot <syzbot+7fc112f7a4a0546731c5@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [jfs?] BUG: unable to handle kernel paging request in diUpdatePMap
Author: yun.zhou@windriver.com

#syz test

-- 
You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
To view this discussion visit https://groups.google.com/d/msgid/syzkaller-bugs/11a7108a-5fc2-40ee-b1b2-37a76f7284a2%40windriver.com.

