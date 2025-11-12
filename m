Return-Path: <linux-kernel+bounces-897883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B269C53DDE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8C5C4342E62
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38442347FCA;
	Wed, 12 Nov 2025 18:13:08 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5238F3446D7
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 18:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762971187; cv=none; b=e8ltypDNrF/Mu9ZnjgBKLHP4SOCY8mGaSTiXv/6RetHNoNSx148jzFP7CP+v684Kx/aouNifOwRD8Fbef27G+NNSODfNXhmEsGK5HcWOgnN1SsKyWHCw7tpX1PkgyP52zunEQ+F5Zl2c9CNoPXwFd33nVdp7HhSoG4CWpbMp79Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762971187; c=relaxed/simple;
	bh=dmTa8DgMalTHSPG6uQDMMuVrD6hoo0vZszOjPtTKdrw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iSwXFkmKYbDwFGabNqdd7DTnTWXpj+KRAitTelrqvep1Ylpfz7DYUWobjWC/dU5BdfXedxsFrwR34TmgulyKiZb3cK7sadvzq6uT2rzNIRf3ZHOa0n+959sLasVOLW45jvbKxBxs/DA8mfGyIC1k2yz6KWhrKzOPjbn0CZbethE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-433770ba913so12118345ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:13:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762971182; x=1763575982;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6cI5tAKSczZf9g3HvdUl77xAsXhseO22zbPgWSzokiU=;
        b=ljq7bWeU+xe+f7AF52UFHz0ajIsHHA8DN1ZeW45KbcaXAPZrqnN4urz87l7exreNun
         P0YhpqapXlp4TDw8NFrgaxAxiE/oLFwqxmNYG5eHKRG+XzqddfMWh98o/WFlllvyL+ap
         0zGmum9Ko+rbWdKnqWfpzoe2vLslsine+1R/HIbeeYsr/q3kLrI1th+suvpIWhwjRAEo
         BrbTy4to0Y5RVLmvGa4QVCKeMHp1/v6ufEyhfljSzjc5HC7vLlQRhOihansqm/Hj/3w5
         E1w3wQ/By8eBbLcYYYq9JaKcpJ/aAXJHvLKNyCTTqlMNOYDy7y8dYRzoWEvWGdVoTdxn
         Z9iA==
X-Gm-Message-State: AOJu0YxAl/txr+wldRZ5awFuWpby5rwPwd6kPqjb6WfYZJ+jZG0EIasT
	lAHta5FX9eVx4L8ZCMYpiHPsLUUgYsjSodKJF+aaO2SzfVSZWFinakFJUlJ/1BftUocwuKK2F4A
	LMYjIQzeQj1Nuj/b1LNETMh9SSsgtAY/TbFAMhTUBRJvXlw0twS37FeyjgeI=
X-Google-Smtp-Source: AGHT+IGJ/DfiJcLtU9uiK1wNUU/LskefIA0yur3zKMAr0+H9F175WVQv15RqW9eDgWl7wV2OuVDttnHkD/39h9WnALYmWHtBYXPj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1489:b0:433:258e:5a92 with SMTP id
 e9e14a558f8ab-43473dddf19mr52959885ab.32.1762971182432; Wed, 12 Nov 2025
 10:13:02 -0800 (PST)
Date: Wed, 12 Nov 2025 10:13:02 -0800
In-Reply-To: <aRTDbeqyL7YhIyKf@rpthibeault-XPS-13-9305>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6914ce2e.a70a0220.3124cb.000c.GAE@google.com>
Subject: Re: [syzbot] [xfs?] KASAN: slab-out-of-bounds Read in xlog_cksum
From: syzbot <syzbot+9f6d080dece587cfdd4c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, rpthibeault@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9f6d080dece587cfdd4c@syzkaller.appspotmail.com
Tested-by: syzbot+9f6d080dece587cfdd4c@syzkaller.appspotmail.com

Tested on:

commit:         24172e0d Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16e81c12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f0fd60646ed018d
dashboard link: https://syzkaller.appspot.com/bug?extid=9f6d080dece587cfdd4c
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13482884580000

Note: testing is done by a robot and is best-effort only.

