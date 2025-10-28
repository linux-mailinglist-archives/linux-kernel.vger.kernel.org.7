Return-Path: <linux-kernel+bounces-873584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D63E1C1434B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E4E01A26CA4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEF03126C0;
	Tue, 28 Oct 2025 10:46:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27AB2FFDD4
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648365; cv=none; b=tq0ixKuOFrtQ4Mx7RPrILkzmFeFnQOgbcQYBI15Kt2spr8Mgn93tFAbG4drmx5PuSzZ9wr5CU9V3I+RrUVSA72Cfoja5On+WzlEMBO91A+3uKGosAxURXoCCycZhHdM09K68GnrYIQiqpNHFUNe4R82JDjqTI7BHY8JCMSZz6Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648365; c=relaxed/simple;
	bh=mSK68i+1G+5pSBP76d1fue0zITg3Pa2Wy0FmeSDsE/k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=M5JZ7pmnZqxXAvHJgspUeOIPTQImsz5At+NfCjEnyCotO2ekQIkxhv8oUPYdPz8NlJQ7bv8CmhhWhtyacYSrCoTUayEQsW1IAr1X9B0VQTWvMJrPQLbJzYD56CQ9qdCP/j6GpRWszXI5nXG20Y93ysTkMdnPNtcJOVdWggjKyGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-925332ba890so1654112539f.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761648363; x=1762253163;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=94gXcPKA015piMFsAGWQwb2DxUAVOYg4g9vmFns6XGs=;
        b=f/Bx8/5+JqXLZNJG+MtZpK+x499H9JO7Yy0Yjqsvm+utcpKdFWj8OQxTUu7tAoBoi/
         IOA7/vWr+reE/rpNoaGS2NTKQF7DD/a/4uYib2NPcjxxktxbOoorH4hxOk78KB5otHQG
         NWpCuDq6iwW4edGXL7INbSZtHEPKwlkiVnfW6RfzfVT1QDxevUq2DSAk7c95b3caJ/bN
         AurbdotEl3f9a7m9snOtyjG77DTH4vKMqTXAhlS+qFRMfWnlU4FVLsvHx/emRKanW8zT
         9fIk8EbGhed3RbjydAk5Bzc5WWutXZm5PoPZp4smZAwHob0a/PxIu9DGl4PFQ9Pw/clc
         EfCA==
X-Forwarded-Encrypted: i=1; AJvYcCW9JiWRdb5yoLNkZikvICOsn4XfDkQ7ZuWdmOH3WNqSSmfRDpIT9s2GvaWkhLv+1roK7HnOyxltMST4b/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5COEX2s0FJIjA1h10wxb0rRuQdRTtJiP2UfT4ZhO1LkjOLGPW
	XoU6sSt9j9k97YLAt65s8Lev1WK33oaVqIp47A9saYBrfCNTbCB9FiRCl+7xVjjoh+DyStuxKId
	5+2teHIo9m/Hp+8fGpkrtEtToNJ7lXgb6k0qvb7gYx/PJN3FXuHn1HuQ9GBg=
X-Google-Smtp-Source: AGHT+IHVdOzXsMpPTx3OxgrZICTt83+aIzfxQ/osKk1zX2ih6NJmnKf2ElVK4PRlbSg9n+n0KcoVBOuZuZoTNvbJWnF/KVHchi4Q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:190c:b0:430:a013:b523 with SMTP id
 e9e14a558f8ab-4320f79b5femr43146335ab.25.1761648363288; Tue, 28 Oct 2025
 03:46:03 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:46:03 -0700
In-Reply-To: <20251028104159.RvAnX%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69009eeb.050a0220.32483.0184.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_truncate_log_needs_flush (2)
From: syzbot <syzbot+c24237f0eee59c0c2abb@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/linux-6.12.y: failed to run ["git" "fetch" "--force" "4d52a57a3858a6eee0d0b25cc3a0c9533f747d8f" "linux-6.12.y"]: exit status 128


Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux-6.12.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=b309c907eaab29da
dashboard link: https://syzkaller.appspot.com/bug?extid=c24237f0eee59c0c2abb
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=126b832f980000


