Return-Path: <linux-kernel+bounces-873613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A43A4C14394
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 066E15E513A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6272D5C74;
	Tue, 28 Oct 2025 10:56:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B04C25332E
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648965; cv=none; b=iL3JVIrOvPTTXRkySLL4vp/RtDS5hU5M5rDUi45LJViEAFIWoGJhukPFdb1n2VkxV0OYx5cJTWvO6Vmf36+ahGR0rKKxm61mkR3iF4b3uRaMK1r4pqjVJ9qcmCsFeMDwEjx5jGAgrfEJuOZzqxH3dw64KzoyxfRAeOiboBboqTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648965; c=relaxed/simple;
	bh=Lu7Jebiq6CGdccTEgSs1Bhh8JDdmdUAX418hdX0FgYI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eudqOQGcp4xODfUxKExTuO/KNwTJU8dJsm0N5WHJks/FQOh/esC7abuNoWJo9wyO9BPsaeovJTHXKTSEpemTLlq0ziSCpOHXEmov6Nx3i4Qi55QVdCImHC6Om1rG3uNcqnchf4NsSz6ysPe7Yr6ThRTQ/5KL0ZRhBfQQbZzzuq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-945ab8d3d0bso216142139f.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761648963; x=1762253763;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C76qUy+t2JKFZ42Ca5JcU8E3DeOfFihDnkhOSxSrRWk=;
        b=R/faJocN3u439WON3QHzT5X21TKsO9Uwxa7FXVB2ruRFGmk4MQaFnTrj82bNttQEX2
         ov9dA6R5CFyJ8lzZMtbpGv2Hy1IEGHgOs1agSZ0JtHkOZxuBD3wUDS1FE8FQhPKLLxlh
         EVK+EeC98U+VNdkXZbqUX7laamW0hLzankxBQaVlzSN/WomqufLhHxLO8ia/VpBNxzd8
         34udmmT/JslSldvZSLvik602PNBXLQ5/ete71bw6zGQxEGxhBLvaDhqLc8ao2/o8S7aF
         W9LcrCog+C5/BD/Tv59Ust29g+kD/AooeOLr9Am2JZ/vh+zxsCQixXMGkSgQu1zhWYbN
         Ajhg==
X-Forwarded-Encrypted: i=1; AJvYcCXM/I62Y6Xg8qZJ9YkStuxmHqw9ObJw2DeRxIBk9pLX92Ep1atdykT+1Yi7DkP3IGbY7GVA1WjqTEhFguA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+3a4FBvcr6EOHIxPJVqJJPnrjSZph3XEpijmxk4QrH61FsvDt
	GTWbqEkko1d4d78fkCSymIY6QOd+f2cLtwe8XMh3wVipLwqvaP9f1KQudAjVVsWr/EFMEdPWCuz
	od3H6rqoJG7eEi4Jhv0dSQQPqA9ViYNbwEzQxUOb0y6OMjADWvYld5ZkhDPg=
X-Google-Smtp-Source: AGHT+IEUxiQIno/2+fTOblzJgMiBh4ls1cN2RYPfj0c/kDs7fPvioW0W+MhfaZiD3FYNjdrV/PKJskWlxkm2L7O6A5r7BZ44hOP0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:330e:b0:430:a5fa:5e05 with SMTP id
 e9e14a558f8ab-4320f7a5ecamr41310085ab.2.1761648963247; Tue, 28 Oct 2025
 03:56:03 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:56:03 -0700
In-Reply-To: <20251028104158.qdBzD%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6900a143.050a0220.17b81f.001b.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] UBSAN: array-index-out-of-bounds in ocfs2_block_group_fill
From: syzbot <syzbot+77026564530dbc29b854@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/linux-6.12.y: failed to run ["git" "fetch" "--force" "4d52a57a3858a6eee0d0b25cc3a0c9533f747d8f" "linux-6.12.y"]: exit status 128


Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux-6.12.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=99cb6b007a8889ef
dashboard link: https://syzkaller.appspot.com/bug?extid=77026564530dbc29b854
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=156d8704580000


