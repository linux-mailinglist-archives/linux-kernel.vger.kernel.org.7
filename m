Return-Path: <linux-kernel+bounces-809626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 155B4B51018
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C829917C83C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 07:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF062D24AC;
	Wed, 10 Sep 2025 07:58:07 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FEF30DD03
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 07:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491087; cv=none; b=FnojxO1Ql00QY7GLmK+0sQ+/DAg3WijE/XU/3BtpbuBx7s/TdVZE3BNMX9U4r8uPyeuYRRI5UlVg0hFz1uBTYveQsw7pYPOc4C21r21Od36rkzEAtbWsc3pmaxDaLfv5yjlHMYYB2tE8Mk5Z5IaxeaLB4MPbVGiU5HoSqccfqhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491087; c=relaxed/simple;
	bh=YPTelKc/fHdiEACPB6+iEdvYqo126hYyR0iawk5xgAM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mg4fY7F+ruo9vHgofns3vMH6JCMG7IAUVr6fTv+eaHl4NkTwqo3gYjWkb2aeDcs1jPQkMPGUrxwTBBLZYSUSAQA9j8Cj5NSP87T/Fv8UktCDSYpHa5mfCroCSwpEMKwRIwNOdrIoK2xUuY08UmYdtDLF+Q4b2Q/E16fhRVnesq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8876712ea4bso1574183039f.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 00:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757491084; x=1758095884;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b+bbRBcaCzjk+Nw8lse9LDBiDhyeMETBKDuUNk3pn/Y=;
        b=nBIy5gUnXKyouXNP78FXGVyjnAntggqVy3jLg+spaglNeO/zivwjeDM0BnztOtYqGf
         uDiHD9kaQx06+ZpjGByCeqa52p6qpjL/REuADbcaga7WuwegJa9FpluXmT9zY101x/0z
         6hpv3wmAl2ehtv+u8UrNWMgrkWlcx790bZ61sQDvtCwUoz9ieh8wlygYJUf8xN/50oJq
         xpOVagA5Kn29WLhRTLQ77KQl+nIOiLVTdJLh2UVBWa/eYr08q8DClWHTVEACmGVxSKFN
         FTIXDAy5KlPjcGUVNoRY/EnZVBFiGLQW4jcdp0dowjjyvd6KBKIPwfw5YIHi8AccNP/S
         vQ/w==
X-Forwarded-Encrypted: i=1; AJvYcCVcpULmbpljtbgOFz4XRBNfou699fxiOPUhbayQWRbJ0tqdi1ml8gndpOf3+d+uN+43mnKDXSP88K2KDHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4i6ib0KgwXmYhtisN0JTrtUUDlYqrdbvKQZOvMA2nQ/CRfih3
	n9nPzNOcwOVNV2csNA4Er8ZbfFNhnSMyyNwvJF8MBrqffnLN3Q/FWWDZzZEFgF0PKMDAa8pSq8s
	egMcmmFim412WcCgwcs0xwrNfA0lczPQkv1oHxYNn3yjg95wfGF2ieIeXhio=
X-Google-Smtp-Source: AGHT+IFZRfJxmgq7njwaPkfAnUWFwWG3HDpMwhRiiZgHWuju4IgcOO0om/65FbdB1POnrD5bty0JReR7g59QocbPZslYvT8bkANf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:180b:b0:418:aefa:bb83 with SMTP id
 e9e14a558f8ab-418aefabfc2mr7221185ab.5.1757491084402; Wed, 10 Sep 2025
 00:58:04 -0700 (PDT)
Date: Wed, 10 Sep 2025 00:58:04 -0700
In-Reply-To: <tencent_4CCA0CABE7C1C6EC12C0064989A0AEEF6E06@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c12f8c.050a0220.3c6139.001c.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in sysfs_emit_at
From: syzbot <syzbot+b6445765657b5855e869@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b6445765657b5855e869@syzkaller.appspotmail.com
Tested-by: syzbot+b6445765657b5855e869@syzkaller.appspotmail.com

Tested on:

commit:         9dd1835e Merge tag 'dma-mapping-6.17-2025-09-09' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=160a7562580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0bea6c0b97a2002
dashboard link: https://syzkaller.appspot.com/bug?extid=b6445765657b5855e869
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11d5a642580000

Note: testing is done by a robot and is best-effort only.

