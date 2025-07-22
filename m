Return-Path: <linux-kernel+bounces-741400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15748B0E39F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 20:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E3293AC562
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9323F281526;
	Tue, 22 Jul 2025 18:44:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7272797AC
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 18:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753209845; cv=none; b=g1AEnIgzWWY0OKJ1VEvoQYMK94IwZGSpJWGgdrXmwlU0cLRsrECsaRS68nHW5KGyljGws8iyAAjoNfbdl0KAWl4Q7d/czEOQGgB1gXDuzdKXVcDR/79eylGXeletwl0ZNefqc/tA7QUO+/3RkZ4Usffhh9Cz6HTr6UGq2XoKkXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753209845; c=relaxed/simple;
	bh=E5vg3Ya7hPJn6Bdyu6ITjxjWS0dSZI2OZEdim89RXEs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=f8K/YixgICNFt0P61f9buOfh2kNjqmir5LEVKY+qle2TP35/Z0Li7iDD3jOYSsuHbjeUc1u9yAc0dEs7ffEfzMIOC0uNAV92Z9UveDBdt91hnblcG5eo5KzwZvwpM+vYKqNdvBVSDTqo+KT39qIyMmWBzNHTF3uVe6O8mtmuzmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-87c33c0b62eso271766439f.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753209843; x=1753814643;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4KfxIUheXLmXa0cAeGQ5PVJy109+sSEd/p8wEEDCi7g=;
        b=aL0pBZWh+HXbI/wjF5RFT3iJcsN1mRKSfc9uIgfF14DyRp8kDVdXJTTlvQS5phG/kQ
         JrgNSfnVuWtpEhjQeCRi3Gl+2iyt8T+1CNiwJJSZQLPIsDs2W78zDu1jlvMSFzyBEuDS
         hlVxZ3jVRszyX69+rN6QQpMZmMRpPh3kS5sp1uAo++cBUEfa9U1RxyTOMJvtOp46z3Sx
         ljinpQTJs1ZTSgF2XU82WJb5t+TOXgqUfxlY1b0b8AjNHGU9ngJR9hCnHpZn62ghNPNj
         eGII1Htdp4hbjaIdfx1R0SBBNFv8UADrP2760nF9N70zfj/izk5Ugn1EkWUPghGgIUmG
         1hiA==
X-Forwarded-Encrypted: i=1; AJvYcCUdPFMHIyUEFEqCIuQ1FU6Ha89AcdvMeurX0FpDtsjp+ANEgxgqSaDt7DorXuRonGfXlUc7Tk6W0ZRLXJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6GogfLF1xkEv58Drkaw59UamXROziyT4TqNz+j1T3fLaFuPTq
	4l1eGGlj1fzuP98A1o0nprMJ1ONk771Sb/hCWb3X7Bc8d0tKMhRqor/VMBrw+pDq7204mSUVG4o
	41Asyfh38bTgRt6c7DssTJbeaSdXkGvEiECQLqnZqhPXJoIamPH8x0fZhupM=
X-Google-Smtp-Source: AGHT+IEzuOahJA8GqCFONc6C7CxajVgGpS1Cwaq2T6kTILt6Gd+KhpIHD41mfKG1EKTERtxW6jdO4qZ4uraXCuCwuT/f1IlBY8Du
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:164d:b0:876:c5ff:24d4 with SMTP id
 ca18e2360f4ac-87c64f4e041mr38281639f.4.1753209843011; Tue, 22 Jul 2025
 11:44:03 -0700 (PDT)
Date: Tue, 22 Jul 2025 11:44:02 -0700
In-Reply-To: <i5jizyac6siolrwgsd6dtj4shebjophbf6mk6itete7rusmrxn@hbebk47xym6v>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687fdbf2.a70a0220.693ce.010a.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in do_bch2_trans_commit_to_journal_replay
From: syzbot <syzbot+e3f91c76099a777cbf16@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+e3f91c76099a777cbf16@syzkaller.appspotmail.com
Tested-by: syzbot+e3f91c76099a777cbf16@syzkaller.appspotmail.com

Tested on:

commit:         9f0bcbdb bcachefs: Add missing snapshots_seen_add_inor..
git tree:       git://evilpiepirate.org/bcachefs.git for-next
console output: https://syzkaller.appspot.com/x/log.txt?x=130cdf22580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37de60b3108b6d8f
dashboard link: https://syzkaller.appspot.com/bug?extid=e3f91c76099a777cbf16
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

