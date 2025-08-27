Return-Path: <linux-kernel+bounces-788475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA99B3851B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7631B60FA2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418651E5B88;
	Wed, 27 Aug 2025 14:36:03 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7085E1B4F1F
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 14:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756305362; cv=none; b=acxWvmU88DyS6n+e4BYtNIivQCgrcmV9STcqLRdZtOJRzWyxDLDzlRr8Drx8PeOSqriuTyrye1f/HH12pxtzUBVchTpfO+ReiBV28d+iMuxAopDyROnWD76VX056ZSpo/684hQYbWrR6FqFYr6fqmfZXdjnI9gLh+96hhiTjk8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756305362; c=relaxed/simple;
	bh=bhBefCK/8DuICk2PJzDU6fEV3r/atpJIBmzyyovZGs8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XpLmDUS122k/V5t5KG4qoYFhob8C0uWOOOdQAtjQ73ZHNQCFT/xCURnCe6T7am9WoCuvebB+c2yk2tBq/cJVP+MyhkMVU8ZK4OLI85RdlM8ZbbtBsXxh1ymYbmMy4L+0D3hkRTOLlrtwaNZJhd2OFmIlwjwqxTwRbmjHofT7zdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-886e3612570so234329139f.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 07:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756305360; x=1756910160;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=62lNS6Q0LsPFImArYDgIYT+wc1F68ZGXpdwyxCQlRP4=;
        b=RhroF+u0z4ZgGo+dsKlpfIAPvtFVeLP/WTDWwJJEd0BlYOZVCi21WXGiEizPTtLOsg
         vLfGUB/1cI5J90v9dMDPp+SIx7npDMLsZEG5JSLN7QQ3JwFjzD9k/7XqEmWA4auP8N78
         H+/B9XjCKMNYUAbbYTKjYYp4F/Ew30iXd6BY3Jt2agLIjEgE53Ays86pjJAUbQuFoJA7
         JGtq3Iwdby2dLybTlbZhhdRspn3FNyGWmB0vr1RL88UMn+CW5j22tfRQuqFWtYCTGxzX
         aeBiWGaD/AlWCWAC0/MOneDJ9mQWoZnfWQcZAma6cqxus5bRoy/ehKcg2BkPUnKE99l5
         yPNw==
X-Gm-Message-State: AOJu0YxdyTsbOq1lWEjZbs6x9NpvF6Ys4JPOlTcKl2ht1lPTLFJbs5Ua
	JmG3EH/q9KAE84seKn6asQ4udLqKFxGIkYnh34tHbNaYICQhdE3vE0oF7hn4Ge+3NTaEYptrSHY
	SBZB4oJkvkdQ4CQf3nHNY9/Wi0OVPZEqInfI6Cj/v8tZP0jIiNYPUkOt7mV8=
X-Google-Smtp-Source: AGHT+IGzNjMEG8jGP4xXLNNM0UWxjj0aiOPlO8aMM2Zv8FBIW0GeKXxwlb0FR1Rg5vk7J/jOxcOy7r8hK2t/82mu5aU0Em/MtO0N
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184c:b0:3ec:2c8a:f33 with SMTP id
 e9e14a558f8ab-3ec2c8a121dmr150917145ab.4.1756305360632; Wed, 27 Aug 2025
 07:36:00 -0700 (PDT)
Date: Wed, 27 Aug 2025 07:36:00 -0700
In-Reply-To: <67b0cc5b.050a0220.6f0b7.0014.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68af17d0.a70a0220.3cafd4.0024.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [bluetooth?] general protection fault in bcsp_recv
From: syzbot <syzbot+4ed6852d4da4606c93da@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [bluetooth?] general protection fault in bcsp_recv
Author: ipravdin.official@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master

	Ivan Pravdin

