Return-Path: <linux-kernel+bounces-886019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8C8C34859
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 09:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00C253AADF7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 08:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B6B2652B2;
	Wed,  5 Nov 2025 08:42:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9F22D837C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 08:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762332124; cv=none; b=I9QzlRAxv19Kks8SLfD3mz2elLD85114cwFQ76z7Flwe9f9jqIccf62dIt1KuA2UylD0uq0a19FCqwC2jthP1/py/6DbMWZnbqrECX2uf/4AvRYcrBZWcLRnNQfeA0hHzQBN9lRgZnQys6v1/5g9paIEuaX0phJIG4Us3tu92y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762332124; c=relaxed/simple;
	bh=ePzZxdoEQ4MSlsO8jZ5nVaUKnRj+vGl1Dv+XdLuICqk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=H0/1atvT8ywjUPx9CcQiFKcoNWkOTe14BLG1s4mQHaQAjAUaUj890XNeypqHGdwbrmYhg/hVRPOfrqK3xkbdt5hUfdJUGDKkW6LE0ZJONlOwh9ijzJJtWXPfqTsCzFO0ds5aib9mCOeiwUe9y2k1fnGr/wEpoJ05V/Dd75XaMrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-43323ffc26bso26234775ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 00:42:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762332122; x=1762936922;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dyM3cOm+VdmpHMfHR12n65P+vMQ7A1WfaZjjKZ8hFcE=;
        b=mLVN4lE3LY/zN83WvTwbhFUNdXqbkDnxIlfrjNd6c4si4O/BIRgNnvGEDCKtXwBrgG
         RE/AoMrF+lgcNRor0yhmBld5+yPqkszMGJ9wnSjjbQCruQUIcTuqMh0S3CwLORq0dQYh
         hBSZMX4JTFyqMnev6+I4311dimrrU45Yjv2ifaZHmq24MjDm3qExOwA1cOoAkyGciFFU
         RHfqTSQir+CcmeLBsqUZHVT360+PBPSfY6pmqZEdcoyKDNphqm5c2FQTeTtTVlXpcB//
         wFbxGQ+0Oy11nsVtPA1TMwDgid5f9gHdIJsrmCWOvjJGzNBUG5t3dznbcZtfNnRLKGfq
         5EUg==
X-Forwarded-Encrypted: i=1; AJvYcCVsDIvp2/Nxd465ZMTcb0ZkdrMCuEwRgBhaBsYtHNnX/CnjHy8IpRVyhNGBBmFUyk4O5SRrQFDg8reW5mA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRElm0WFAszRNVdvGL8/gngsBTKz23w7UCnKG6kh6TQDaPBWfv
	kdBIAtZersL/ORaVV+ZPQVJ0v1iVkfsGMYtj93bhqBoRyfRdQONm8yrHUPtoEa0W7WLAz7DUGtC
	ayImnF+H5fhCmngk4vl46cV0Z82yDRxuEGGbGtWPJjS4AjSmcgUPwukND1Yk=
X-Google-Smtp-Source: AGHT+IF2CcPIZOQMPzkAU4aGFq7+QhYfX0iQP/wp6BW8K1b0Fhsi6zmchiYfie1kTDNkZKOKwogsvoaQ6WGPeVOrmpWA0iEvj5Xi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c23:b0:433:2cca:f004 with SMTP id
 e9e14a558f8ab-433407eafb1mr30592955ab.23.1762332122448; Wed, 05 Nov 2025
 00:42:02 -0800 (PST)
Date: Wed, 05 Nov 2025 00:42:02 -0800
In-Reply-To: <CAPqLRf36qEgmaLxkGfURAQ549Em_==asxBSuy6PcoKYpXi05ag@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690b0dda.050a0220.2e3c35.0002.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] KMSAN: uninit-value in ntfs_read_hdr (3)
From: syzbot <syzbot+332bd4e9d148f11a87dc@syzkaller.appspotmail.com>
To: kubik.bartlomiej@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+332bd4e9d148f11a87dc@syzkaller.appspotmail.com
Tested-by: syzbot+332bd4e9d148f11a87dc@syzkaller.appspotmail.com

Tested on:

commit:         84d39fb9 Add linux-next specific files for 20251105
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1782a114580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d1fcb9bd985db1e7
dashboard link: https://syzkaller.appspot.com/bug?extid=332bd4e9d148f11a87dc
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10d8a532580000

Note: testing is done by a robot and is best-effort only.

