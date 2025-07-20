Return-Path: <linux-kernel+bounces-738266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96334B0B683
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 16:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0342D3B8C7F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 14:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB8A1EC006;
	Sun, 20 Jul 2025 14:54:30 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F631758B
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753023270; cv=none; b=gGw6+f0R8m/eCofXCVIkgVTxoyMwnrKhufdfzx7exZgjoCXyH88AYGAd9t01b8QwHNyxNmZe2sKwGDxxc1iMVBp5DE990Asfvu7PQvHhLg7amnThvBkr/GPbDby7lgk/b1LWb/xdGTZylrWNt9Hyma6e2BY1ZAYquTB8gJsMO/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753023270; c=relaxed/simple;
	bh=5w+enorSqrTUVe5hlglaL1pX8RaC0uSKgm+fpFGl0iM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TMF/rwQFpzcwICWcjKzN5ibxTaChvz1wxAVVKjcerqr9sON+HhcNVFC0poNFKkJwi8QCSWzxZrzGYyW9JBvdYt8BeAI/wWZoqIX+glx7CKy80HBtUchozNune58Zm1JAEqyluzCg2m+M+mdvWqWq2dQoFqVCePd/JMPuoAEa0YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3e2a7bb1d9cso3741115ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 07:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753023268; x=1753628068;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4nFvvvLMTDjjCyIfgcu9w4PSjyqxVRP1u0VfJtfkPsk=;
        b=stXjvD5t/Q9ut4NWQcKDLXgqDNhEoUp5ZfmTFOgX+ixfd39UmgQP+jBh0JL3Mr/Q9T
         4WI66eQ3epZzCqX4z4KP4pOzktpy/LMwWAHMkYRAWEa2/IZG2Pk1rSRc55VxCxAXOjh4
         ei9YUqX3m7A/FF+L20tRxGUXLjQTQhG+B/mDPKhjLOPsMeHnuWEEaFx1YFMT+mnt/rmk
         ZoReRIeR3utJdMTkr8anQUia1CiN4wpNgAxsRParAJYub6/1AGYovllw7m2syDlxQ8IG
         ynsCaqfIS/od4nGQbnIIZAAkTKujkJjNG9P0qXH6ukO/JqMyn4W8SDh0iM93osbFNdVL
         jYpg==
X-Gm-Message-State: AOJu0Yz98uAnjF3mPU4EeJQIU3X+JiOGEZIXuItxKZA1ryKcbr1iEVt3
	jIA+NxfsSWxGvt6UBaYUalpKOkkmYlJ+ySe7akffNsUIYvp3ARaPsWaRA++YXPr7ch9dOEhKCWP
	ZmXwSGKhccIhYGQo7gGiZ/q5iiVoR+1G1qbzdpd1TiQEc3oYT8pRa9sE3eJU=
X-Google-Smtp-Source: AGHT+IFMaIZPOa1RmikbMBEy1rZKftScewf+7yMerS94FDWSoCUrti0nS0TgTsXYZoZ2NLzN0JUSFwQZ7JhXe/k2JztSvI+2FR6M
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:5e0a:b0:3e2:9835:3896 with SMTP id
 e9e14a558f8ab-3e298353c6bmr57059575ab.6.1753023268117; Sun, 20 Jul 2025
 07:54:28 -0700 (PDT)
Date: Sun, 20 Jul 2025 07:54:28 -0700
In-Reply-To: <67447b3c.050a0220.1cc393.0084.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687d0324.a70a0220.693ce.00ca.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+92e65e9b7a42d379f92e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: Move bset size check before csum check

