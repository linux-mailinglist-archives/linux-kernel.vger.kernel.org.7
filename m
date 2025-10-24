Return-Path: <linux-kernel+bounces-868630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA1DC05A97
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75D5D4FADF4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547CE311C15;
	Fri, 24 Oct 2025 10:49:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3C63115A1
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761302946; cv=none; b=meTVifa3+Mqb2wUnEnI6o1h3CcDTaedZWkwVXxe45uRWwDnMm/17JK7H7t69SjTknpPvF+9UW57bdN0Fq288/zvu752/7ISiloAggCPKqYfJ70GrRCPOUZiykoNmdNjQ1JG+5Lg8TV7eQpgweClQsigyzZjFFeePbTet91qn5F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761302946; c=relaxed/simple;
	bh=9fngBIQe3OpsV47v8Y0BqVZBxS4b6qTRcX+0B1cBQ48=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eVwmK+4mT+8IO97U99KLy6117hVFOno20tm33T+8S2jKueLi7nZjXYZXBL9IXVZiCev9m15X1bzQ+CccLgyCXuuQkH/QjQo+jB+JElpN6iyJbLwRc5jsWFd3PBW2qrjblQX6z6hcmNDRh3a/Sk1NNfQK1yGJ6lnVgmVc+AsK8+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430c3232caeso24254525ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761302944; x=1761907744;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WxuV7ZrBtoLq7TPCj/t4AiQxV1AR/uLspKAVkWl+hMs=;
        b=ERObzd60Ea5M6k2Fq+oEymGCEvLq8hoOiuTZSML5pv4WoCglbV8vayridsPn1IqKDP
         N92tp7pJC0VUKbZWrCv5VNtPlSEqqCOryYYxUnLhb8py45OO7lk+B5CckkqIk9wm0ilX
         I4vgkFOTICDT1fKcGp7gNrwZDhAUJw2ChII+ZlFnktjLkbH512Gu4bwn4VEAcVc8JNBw
         WgHIgYP7kulFJAYtcwj2DWO7rnAmhqqy6uyMJ6c4r35H4UKb6b67j0BAqPFQg3ELRXPL
         QT6e+4bYo/Xa0WKfTMSwcFJIHfuhPSOyq5svazrhwRhhlJe1qFej8micq5CELkvxsns4
         Ba6w==
X-Forwarded-Encrypted: i=1; AJvYcCW6H3Bq/QILx/nzmPiTkgj00h+bJv6Q/GEhlKqKYE8YJbly85sUzKTMgL3sNKDfR3tQfezldHVF7KzfFcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQHWqpeDzCBLfNuXntTzNQ0UZWczllP26gESbvE79GXQ/mT48m
	D3O/4n9mb8Xwb8DMEsI/w//2SaaWSXAdEj23KWin7OzZCtQASr12/6nLwWoZlmvK+BQnx7rAr+V
	xeleJCnI0fA79BdCfzpTwViXiS5QBkJsYESs/mMKIjQ3m7fiBy/kiRTaNB3o=
X-Google-Smtp-Source: AGHT+IHSWJ5xtfU9Cpb0K8WrQA8SCLUF0UO7Q6hToqG1i0xl4Pa5/uA9TDWUjLg/e3iYqFJ18ojil8Y8Li7gG3TaRt2O+ysQ2mZm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3086:b0:431:d83a:9a8 with SMTP id
 e9e14a558f8ab-431d83a0c8cmr109385125ab.25.1761302944469; Fri, 24 Oct 2025
 03:49:04 -0700 (PDT)
Date: Fri, 24 Oct 2025 03:49:04 -0700
In-Reply-To: <20251024071531.TCWyW%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fb59a0.050a0220.346f24.00c0.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] UBSAN: array-index-out-of-bounds in ocfs2_block_group_fill
From: syzbot <syzbot+77026564530dbc29b854@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+77026564530dbc29b854@syzkaller.appspotmail.com
Tested-by: syzbot+77026564530dbc29b854@syzkaller.appspotmail.com

Tested on:

commit:         4fc43deb Linux 6.12.55
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.12.y
console output: https://syzkaller.appspot.com/x/log.txt?x=16c99be2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d75e2b3488f52930
dashboard link: https://syzkaller.appspot.com/bug?extid=77026564530dbc29b854
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10fc7734580000

Note: testing is done by a robot and is best-effort only.

