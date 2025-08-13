Return-Path: <linux-kernel+bounces-766740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B36DB24A88
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 559B3721781
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4542E9723;
	Wed, 13 Aug 2025 13:23:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8728F2E8E0E
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 13:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755091386; cv=none; b=YAzbGh3ZxypahJbiOFAMSxzlHH3K8aFIKKgbfvwQmgbNnVbGBA2zkbMt5SFUMvX0C1YBGN57/10eR0zfGmDYHIJxnxjzGMMAkH0zX3DWbrcyzIl1qVDW87pgiZ3JuA0F6k9ykn4K+ZrFBS1PYXoASxggMn6JIsIMQUw/pXh/+WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755091386; c=relaxed/simple;
	bh=A2VpAySktvLQriopxdsNxDscBXUGGRoH1xVH1LLYWkU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UQWCZPGTZxTrxIHGsLBsW6/RfqD1Mseloj5xhUdgmY5geFPSB3YDfwwN6hnoSMJk15q8soNwiWbK9c2/Vn5fijWpnPd9Z1x1qnS0CjZammp0C09K7W6CT7MVwFNJIVS5S9O9EWUisk715GH0QaoCZa5ylQkh6jyeA8PRR8lQcxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-88193bc4b09so1392844739f.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 06:23:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755091383; x=1755696183;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zqlWQM2cM/l+eAFvSIecCVUMTGZ0fGIRs+PGRx61+h0=;
        b=iuNpBXXiNqeKwb0FT3hmGdhkAkn5DV60kJeL7+JB1MFPGhs4vO7PzCMGJZ2HSE9oBD
         befPkJrXoXX9DKotzMpvHXlOK/JWFQcqAfkJ30kbzHoqKqiAnvasyTb4Cp7kPlTOQI1O
         Wg84RfYMls5qrQd6+RU/gXTxanGOln/wwtfkiQteiD+8ml3vX85gX86CGCOvBhwa30t2
         Wfz0eohEODuRsrhIj8S9jo6nrfXn9MqyqjcIa4bn64OruSHhIS2qQ66Ve+ZAPZqLj+d5
         6PCs9vRKUoCEFJ/32QzEdlny3A43Qg1BnRrnW9iYRoi9I/wqy7VUlFWgVh57esnbyRFj
         +pEA==
X-Forwarded-Encrypted: i=1; AJvYcCXQD5b7DiLb9ccSDq++gWfMH/8ymPjnYqjQynSs5eI1jz9zFmoju+raDb7FcfOknoYkCPdtGyDLbyr0MBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcS75OYoBSfg1Y6p0ehO3aYKt8rZunSfIaDLxJ0882qSFluMWu
	yq7gTzWaQTI6TE1Jqu+JRhH6Jg4JJ2KIrgERug8aNMGiHRjsv7UNgBQEXMZRkqsc7Ayffn1zJUi
	scXP/wxC8fRYNNIEJ856I2uZocLm+uHr4ir/fxJOPqtlOgXScXmYge9tgDvA=
X-Google-Smtp-Source: AGHT+IFoBTJMKvELjeLw0jiWfeWXgg5a5yAZe7m7Y4t8cHfSxkiubljDtJ8k1wSRCNVb0Tu/tXUsozkwuvN/gynv/FPxniyuB2eP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1553:b0:881:7e3a:4a37 with SMTP id
 ca18e2360f4ac-8842963bc0fmr564713539f.6.1755091381921; Wed, 13 Aug 2025
 06:23:01 -0700 (PDT)
Date: Wed, 13 Aug 2025 06:23:01 -0700
In-Reply-To: <20250813131449.4491-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689c91b5.050a0220.51d73.00bb.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in move_page_tables
From: syzbot <syzbot+4d9a13f0797c46a29e42@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

mm/mremap.c:595:28: error: invalid use of void expression


Tested on:

commit:         8742b2d8 Merge tag 'pull-fixes' of git://git.kernel.or..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f9319a42cfb3bf57
dashboard link: https://syzkaller.appspot.com/bug?extid=4d9a13f0797c46a29e42
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=176d4da2580000


