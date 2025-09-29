Return-Path: <linux-kernel+bounces-836343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC559BA9641
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 555CC1921045
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AB43081B1;
	Mon, 29 Sep 2025 13:44:11 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F8524339D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 13:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759153450; cv=none; b=QoVZtxsEr7LnVndrGHYmlDcFMjo0UkoSbBbuJ7KiOYIJFzKkZC2hHhlmKlfX1XRcGPi5sa5mQERctj5zwcGXCXomqy7qC1Lfpl2AgOIVZq8V82ON+USB5ugSfjAb0li/7dHsaBl44b7AMwbAR13PODZmH/5lPvLS16sJeVK25vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759153450; c=relaxed/simple;
	bh=FLqM7iWaQcub2D5MyfUbim2m2rS6q9ZYL8W0cVDZs5A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=U/m0qvLmX9ZpxaQr+Dq8Yx0VKonwSymzA2LeP38IZl2ETBhuIv+62A4zM7+C7XcgwGRJzixhFPzdy6MYAVnSxiZ0VPgxLh3W5+GuWrwuqNRYHuEXr28vcSmKHX8SspEyE/7x4vZwrVf8VrvICGAtrwA4Cm5dTT5jVz+funvE7ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-4257626a814so65651255ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:44:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759153448; x=1759758248;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FLqM7iWaQcub2D5MyfUbim2m2rS6q9ZYL8W0cVDZs5A=;
        b=PEpQ+HBI2YxqlJcgt4IPGYRN3F936j/Hd0eHLRebjWwgaIQ6bWq+wxBCTpnO5TcE9F
         cT46Diruxc6LaR1ZtZeyVTqwHzg+UPEFdi4Kx+kMG5vkmMCbAPGkHqu9yixf88i1ZSDD
         mksxUHNaUFMbFp+HLx10E50jHIen+UvKNfHnVLg+Qae644WqFKkq9Ocx5J6qCXA4pqwC
         5/zJRSRgGag9TSc+HAzo0ULe/zCrr1akS4MFJZygmdK7JPxgMFtjWFOmfGX8p7dE6VNG
         /4rWvaPQK3+bUysAwEUAGF3KzIdluVaXHuHpofKAmbZ3BQ0TVaybBrn2MnT8xwsBI+or
         xv/Q==
X-Gm-Message-State: AOJu0YwuGnDoRIoH0jyOBudRdKhqzT+ImoboEnukJmWV3efk2dy5fsHe
	LzdgTZRrmFmwGHyhlQwI4JUkSuPIc34fVEVIEZH3TwLSE52ByWdA8H0p7W1GO/hxMnr45WT5goq
	OshMEa4riGK3pTJ/ptAj7yryoNrmMI5fX2yWLA4HxHBNCm9D3v4dJiNzkDzw=
X-Google-Smtp-Source: AGHT+IEvHN18JEpJmN+E7BVCdmMfx+fIBFUnP9uknjnwDG8fMwLrztP/YyKqg/onqsWRAzwDgYFwaC1RexWhpVn1kneOzG7pBzKP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26a:0:b0:425:744b:52d3 with SMTP id
 e9e14a558f8ab-4259560aa29mr247966195ab.11.1759153448337; Mon, 29 Sep 2025
 06:44:08 -0700 (PDT)
Date: Mon, 29 Sep 2025 06:44:08 -0700
In-Reply-To: <68d913e1.050a0220.1696c6.0003.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68da8d28.a00a0220.102ee.003a.GAE@google.com>
Subject: Forwarded: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
 e5f0a698b34ed76002dc5cff3804a61c80233a7a
From: syzbot <syzbot+30b53487d00b4f7f0922@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git e5f0a698b34ed76002dc5cff3804a61c80233a7a
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git e5f0a698b34ed76002dc5cff3804a61c80233a7a

