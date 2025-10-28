Return-Path: <linux-kernel+bounces-873614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B5FC143A3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 004E85E79F9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAD53054E1;
	Tue, 28 Oct 2025 10:56:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F1927FB2B
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648966; cv=none; b=schBie5f38HmszsUshfcPhKNOjb7cyiVIr0fkvrFzvLvSi9nMKASD4rKOrFwD7KPo0nZ9KLjlHFYZvkq3TvTmHupt+mJQ8n7WcsSTCpVDNjrchu9ZOGK5TDWlOQpbuDSCxFlf+1QDx0EGP+3n47onqSNM7E5XPQJg7kRCiLaQRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648966; c=relaxed/simple;
	bh=pB8CQ1keid2Z4az3Xdfr2MaBVcMsjOrWKRmF3Tg+0Xw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Wlz2akoOTqpWInBDovj9oF3OIUvPTkWHogiT2IbnTHiEP7xmr5vj5lMdMM1HJWP8SC1Of7Jg/6R6ZnyspMg0FoJziVU5XlCE5kFKpTIf3edJQY1fsnFv+GugKTSZCtco972zLYc/VRk2NGff5Apm1DHKbcFPXd5RnT5mQkW2h2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430c1cbd1f2so68412815ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761648963; x=1762253763;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYvQcFnBEo8o6SYxKRHBXxN+5bMgxnGfgcWtHdRwQgo=;
        b=DudeKVsMH+AKsL4HiirGSdmruT6LGl1CzUNIgmYUMdL+OvL6yBIiw1torBvYbW7C/p
         SpTX7bld/4jptulX8OnE/bRr8BaIl0vxmf82adepFsUskdt6xIvWpsmhsG+sUIfEpnvj
         ZkhLy/lCQTacCMN1JambxPkTMedyQyaINkk6wbWWmMHZhHZPfO6Ivr3tcHcbfLyoixvE
         AR4ET7twqe9u7NansXFM+Bv9A6xnAVyzml3JioiZXlv1mnznHrmBlACYK1HyGo6niayF
         hzsSLGMHfz+F10Yrlj+anBcdslQiQtzPiMsuULcbXyVLNqlh0uAgOz2e5hoFeCVP+YId
         d+6g==
X-Forwarded-Encrypted: i=1; AJvYcCV1b87MBbkrMrerqYcPa1ICYfgB7xnoljCTZlbPJN0VVRCtqrPRVhA/b80MA03B1+fQrhlQvbD8E9iApHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXgcdLj7ox6TgLRMWiqiBE8L1Pcx1mw2zX5lXHJeE5xg1lC+jZ
	x1WK7VodgaeaZ1UPgY91J6y2eNpl3wvgprcycYm9qM1NomqFOrFoRVCZyuF2wCikO23wcFsKJZ2
	VXfwzO51u4uPp1R9EAGwlJW1JS/uVzSgkV5DNgK70W3JmWXE6cW/g3UyZqFs=
X-Google-Smtp-Source: AGHT+IHvikJ99+4sBLWuOE4opQRxMCiNyLe3x/zCGTj9JqJtjhqjeRG52ezrluGehIiEMJ0g+3rhnV3PT0UAdTzYzJJObICeGjTq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:34a1:b0:42f:9b7b:bb7e with SMTP id
 e9e14a558f8ab-4320f79d75amr42401055ab.25.1761648963061; Tue, 28 Oct 2025
 03:56:03 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:56:03 -0700
In-Reply-To: <20251028104119.eKN8w%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6900a143.050a0220.17b81f.001a.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] UBSAN: array-index-out-of-bounds in ocfs2_block_group_fill
From: syzbot <syzbot+77026564530dbc29b854@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/linux-6.1.y: failed to run ["git" "fetch" "--force" "4d52a57a3858a6eee0d0b25cc3a0c9533f747d8f" "linux-6.1.y"]: exit status 128


Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux-6.1.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=99cb6b007a8889ef
dashboard link: https://syzkaller.appspot.com/bug?extid=77026564530dbc29b854
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15746932580000


