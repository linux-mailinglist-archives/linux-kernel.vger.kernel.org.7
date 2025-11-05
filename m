Return-Path: <linux-kernel+bounces-886165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8765CC34E52
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 10:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5FBA24FCBFA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 09:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3213081A0;
	Wed,  5 Nov 2025 09:32:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F067F2FF643
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 09:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762335126; cv=none; b=Sp+thM6KBgnwwlMyo4xUM0hu6FdqH0fO97Q66Syb5CwT/JqbP6oaWPbOOPppDJ9cRGKoNys1nm+Qva7B3Jg0stUeW7Oqxj1/xmZKfNxNw2bOTvVs8/UNRvcSqUl7y2xwf2l/Eij6Sm06vrTJGkpclrQk3aXyN/S91jPPZPjVwkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762335126; c=relaxed/simple;
	bh=5GUCxWMs8ggsTmafk7RzBPsAuxFl8wSXisT78lx79Qc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DaDpFjIxkWCFeLrPIXebYqBzbuBj+ZcaYcUThuu/gvYtti0Xm8UBMgyJTJ+dXvOXv0l1WwFYGJHkKwdxEkt3f6C9U/6cVWBwY2KoARDPG9uXLvnXLaR/+fyKPtFhKpo1R5mOB4VS26qVeMuj+ZiC37BVdbbyZ7Vxszl0/85G4Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-945aa9e086eso78215239f.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 01:32:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762335124; x=1762939924;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bf3n4dqOaw3injLMRin3evDiPo8nQpXlJOO5M+SovMI=;
        b=aVbKPy6DXcNs4sXtlMqBNqsQEvYk+eA7X5g6Nl/kNvrkOvZyKsfa966EcWv4aixEQi
         hSHYTt6es1l6F2oh06C/SQKVMvqtqexKkASNyUWaWQIHXfSIGzoe02rKHjkGcWyyb2k/
         RoQw1wSgqmaNHmLAA8fjy2QfAxbEqXvN/l6o20qJ/XwpZ/iB5BEKKmK/CWPbbE6d2O18
         dg262vUcdEHO8r7THkGluiMS5JHyYCb01JvjqmJJSZ5HWzXTrCqexCDPA8IpkE1XV69u
         q7Nwz6pQfPtLkQOa8iJIU+K0E5azt+5O0NBZaY6BiLF4aWri24h++fCt1orYvP0m4v86
         zgEQ==
X-Gm-Message-State: AOJu0Yy7HDEmEp1rzCYpupfSjp819kRtV6Xf+uOEwPQx/pD/0BXcGCgz
	NfU+VaOpvkA4piEKU7Iw98Qn2/VG6FwvOZROBsxtr6PYIHbCF2H4gVAgsfmS2oLFymZhfg3lG0F
	P/g8RVTNe80sSKmrv75OFoYm+1TZ6O9LmDpDBiMlnfBv+kXBOPDJZIdF3TO4=
X-Google-Smtp-Source: AGHT+IFVoIxSOGGG9H4LMu05/rSFSVbUC6jTYzJQ5lH03AfS2fNvDx2y3mSTDXzn00HIoqSENGbp+OCdAOH+40MGO2chccRc8Zdl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:7518:b0:945:a834:5951 with SMTP id
 ca18e2360f4ac-9486935325amr453037439f.6.1762335124057; Wed, 05 Nov 2025
 01:32:04 -0800 (PST)
Date: Wed, 05 Nov 2025 01:32:04 -0800
In-Reply-To: <CAMz+-CPLgSojr8wHHY1Wdef+UUHBpVB9xWTYwZ-c0tQ41Trh2g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690b1994.050a0220.baf87.0010.GAE@google.com>
Subject: Re: [syzbot] [net?] KMSAN: kernel-infoleak in __skb_datagram_iter (4)
From: syzbot <syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	vnranganath.20@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
Tested-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com

Tested on:

commit:         284922f4 x86: uaccess: don't use runtime-const rewriti..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17b93012580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ac9909540ee4e359
dashboard link: https://syzkaller.appspot.com/bug?extid=0c85cae3350b7d486aee
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=107e8a92580000

Note: testing is done by a robot and is best-effort only.

