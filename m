Return-Path: <linux-kernel+bounces-864140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 438AABFA042
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22C9B1A02032
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 05:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10B82DF147;
	Wed, 22 Oct 2025 05:01:09 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B312DF12C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 05:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761109269; cv=none; b=CDd2gKExvvVlIcfeez/oaBMp6nO7hLXblfdfA/gRGUcWUwAgypn0xmLUedr41c9BF/+S/vTl0a7QRiD0jh9kfa+KjE+YZkT1GHul6b/s43+3FPfT8z7P4AvAUmE1pWojmNxhjjNRp1g4qzOfD36QQYRphxS5PWn0vQ6LZARfFoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761109269; c=relaxed/simple;
	bh=T6nnlrWc4GhW7a8hNbpbTn/eUMCWxgGgCL6I51103mQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KKZ+LRKI+La4cGRsWisT3Iw+driDH26yxLP7PQwP2nbM7wQ336gkm5cLAaiKOp1EYzxWkS1trgLGdDb7dnrqA/7DVJffTUK7eRXsI/5FRFixWGBfs4JP4nBYs+1V989aXJ/BI1SkEFsx2AXc4quSL5dmDZJKHBuQ+BDIWZ6vGS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430d7ace0ddso43588475ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 22:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761109265; x=1761714065;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IfbTVengEQvFXKUMhry3dnz0dwnDQCQgGMaDbQn1af0=;
        b=fnbVlIceHVyjkyXXwucjG8q4QKvoeh3m+iZu2jqLOI7xxdx/4FKUIgda4jBrzilEuu
         O9Tb9B6m2Y5VMc3UuLoCfFBShExo+g38fNlrYCTavbPZiUsChnMpLYY0/xx/tEA0lUaD
         O47YX5URnhEwe1Bfwdr/d8cTcaKQpelQg1kLWPqDZ2O1bJ5GcZpZZUOVbbcXpNAk9hSn
         aYAQ1Nxq9LzlQ8DxZfFQDZVHLDnPMZslIRnXMIfCLmBm7cFOmMMArNwsc672Su9FQkNV
         +UHBu9TsofU7+G/d/tBiRmH1KsxUXro/hwJ85jPRQhtQOu+s2Bcc+H+RXWsJ/oxKfS9d
         dRcw==
X-Gm-Message-State: AOJu0Yyfoyg1VGReyiuXJzIdRal27LV5u4tqzcKhbciLeuO3qhlDQWqN
	2t7B04UjlQL+xHMeV14LEcxDIvjQd0pDV410Sn1GBrE+rr6dRDdOsj2/E3ejECpv2LXdEP/NbOG
	OCpovAJ/q6WogOkPocFpuRMcO4Y5+IWNjsMyaACGf0bbTwyYM49S69j0cJh4=
X-Google-Smtp-Source: AGHT+IFnGbJel0ufOeRfNCUGISyYA+Ps/iV6tbcSOI0pK7em+PYx6wW3qr9aUW9N4l8d870rDajL923ZRlGDl3O1v7CAySr9fbRH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:190c:b0:430:bf84:e941 with SMTP id
 e9e14a558f8ab-430c51ecf81mr288078645ab.3.1761109265203; Tue, 21 Oct 2025
 22:01:05 -0700 (PDT)
Date: Tue, 21 Oct 2025 22:01:05 -0700
In-Reply-To: <541945e3-c836-42d6-a3ed-64714167186a@I-love.SAKURA.ne.jp>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f86511.050a0220.346f24.0033.GAE@google.com>
Subject: Re: [syzbot] [ext4?] [ocfs2?] possible deadlock in dqget
From: syzbot <syzbot+6e493c165d26d6fcbf72@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+6e493c165d26d6fcbf72@syzkaller.appspotmail.com
Tested-by: syzbot+6e493c165d26d6fcbf72@syzkaller.appspotmail.com

Tested on:

commit:         552c5071 Merge tag 'vfio-v6.18-rc3' of https://github...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13b74e7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=568e69ca0c2fa75
dashboard link: https://syzkaller.appspot.com/bug?extid=6e493c165d26d6fcbf72
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13a94e7c580000

Note: testing is done by a robot and is best-effort only.

