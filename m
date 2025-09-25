Return-Path: <linux-kernel+bounces-832619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C052B9FEF4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 531F3188E039
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2AE29BDB0;
	Thu, 25 Sep 2025 14:10:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12A829B239
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758809405; cv=none; b=sD5FMxnEPjFn7Um/NFXyHuYbn3T81nLGgW3xylgI3xmSJccgVUWrCmicrjHrfNuaJSbiPbxCmKFRa2PyHR6zZEnpUIO5zuov+gGV4vNcR8/tFf0Ih59fGI6iGDzsFWWE3Nqga8NqR5GVnotCknRgs5kjnlB68gem79S8ZghAGx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758809405; c=relaxed/simple;
	bh=6vsI9UNotaKtUnvOaVscttU9ukU3BjkN7qor9/OFAaU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BrV8NTR++dO+a6JEzT1dDTraYID4keQXoxyqALD87XP2/jHnSpgk+odPzWiI3/QrC/RvfYik+F4AcAH+gMKPRyl4rqg7ZtFD20gkLR2twlGM6EO2rX3iB7O7Ckt80juzfZOEVJTQKBuzKs6UfjfRPhJ3MCkDavdAnR+LLDb8z3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42664e749d3so6240475ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758809403; x=1759414203;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l2fTpSxsebyO3CFuIwqF10P/v0XUZzBUa8qHAG26Njc=;
        b=B173kqMFi5MhjQSbtMgeSU/Ab3FANTgVveihbCS9YupTG1g59Fah2NzcRy8PPhHQpa
         U5fami0hz0hLY56M0U21f4oYemsnuNpAtt/FSfj1S97aq6ZSKUxGzCK07Fdd8XyrYQU+
         +7xcqhJH6FISndK4SNEOqd7Is+c39G1NF9zAwfJHuFwZO8JBE+W2Cf1EVJar6zOH8yVX
         a3MlU2tCOgjA1NFGl1yDVIAgXfczmsGCr9lrRnCJhbVocfRCL0czsazsXCivq6sMgkzT
         FqpzAL4AtomDcrA0YBKApKK60M9aEyLYG4qrB6wxWblkyEndRIRm+TCZoVo6udm9Sdeu
         xLzw==
X-Forwarded-Encrypted: i=1; AJvYcCUE7sHAAvIK927Xw2nT1KkHBq5p7npBQgGU2RN5RATbiwDztImhJWI+hVuRF4haA36au8pIBUBCIXrAtuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCSyEzMd5PMQKMIRTJ19niQrfsqVMONNkOs7J0U8sOB9QlfD3e
	VoFyDE+bwF05IZeAnJJePKrxLjI3j98OW4qisGTti1dRXs5JfDwsKpzVtt+HrMijFI2IApWsF2Z
	g3Ej1D2QBTo7lNzhy7DPrJCQlCccp45/ZRHC+1mzefR2GQboxYFFBvDgw+sM=
X-Google-Smtp-Source: AGHT+IEKCJ/PLKzQGNASDzNHrdUNgbH39swovb/CJ7XXoSYQ4mkyd1h4iO9VlyTjTr5nuljckVJP0CtnQyJe2jnTTCa0RuUbvY0U
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:b704:0:b0:420:f97:7446 with SMTP id
 e9e14a558f8ab-4259567c94emr38509115ab.22.1758809403034; Thu, 25 Sep 2025
 07:10:03 -0700 (PDT)
Date: Thu, 25 Sep 2025 07:10:03 -0700
In-Reply-To: <20250925134312.148341-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d54d3b.a00a0220.303701.0012.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in hugetlb_vma_assert_locked
From: syzbot <syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
Tested-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com

Tested on:

commit:         b5a4da2c Add linux-next specific files for 20250924
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13e0b4e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=841973c5ab4f4157
dashboard link: https://syzkaller.appspot.com/bug?extid=f26d7c75c26ec19790e7
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14362f12580000

Note: testing is done by a robot and is best-effort only.

