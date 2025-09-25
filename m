Return-Path: <linux-kernel+bounces-833027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0829BA104F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14B361C224AB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A923315D5C;
	Thu, 25 Sep 2025 18:29:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61A025F988
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 18:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758824945; cv=none; b=kZ1YOkSSehUNKQSBUZQuqqkoQJk11YjWceAW/6JBuUo2V4xY5hEoIFGewmKLbmAsYdypz+2T30slWDoVz1EL578PBrjTCOJ6PDXLC4fx20qPlKp0FFlB07qJXnmvsea7R8cjvlLFtbbU/jsqUWUhnr4qpBwg3r1LiVYPI/KjrLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758824945; c=relaxed/simple;
	bh=joYjc5ryYtnwmQbiBR8DCM1cRH2762pB7nEDgcp4hE4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NYSYZCLVFrA3b24d9ADGNrlMmgnV583fggcOITlQZw76fl35iU4X/GdGeSDJ5M3PlSTddI7vxiox450MQwCpkUxIyyHETu32m89iMcZo/zw7aZCAXEm0TzRntgPi7ZgWtNaZfOBnjP0k9h6E6qxwMRP/z7GH2vSE1qGdZyuWVfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-4257e203f14so36064135ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758824943; x=1759429743;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wdhlki/wYADXSECXZps/KuGGWZ5PE+hDU9NtPpjrsLo=;
        b=qBSCxwzmpJEF4G0U9gof90l8+8xSY/fL6zleKH+eMBfAPx4DBar8OHKQl02+pjsn5z
         AYcCIVx2Hd0wM8ufdZJrHY9h+IDRKVcfBEHPsyLs3I6miQZYYpJ+zAlqgmVXwCwqnE9/
         lm1zm06S2qTzOkb/eoG4jxbsvXW6dxHupviiwLkOb56wqi8U1xfR6c22C+PzI3JEGoPc
         UAJEqNYUL0Lw1dnWUqpfYGEiJbWGAr54skt66jBdJewplXlNF5YhQBFG8g3v0yPeeFCS
         b3PttArx/j0QKSBmtFY13bPScS8d4RO27uBwLCPo52kr+fLa8FjDeoLzJXEOfTB8OUOo
         CZyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWh0f54vH+wvyeZrnHh/CRMtCzL7mQymZisu9k5bJEInnP+Y0FkWzOmgGHAMp3ODwMdahn19cfKYmT4rjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfKAeL/IZ1LEAzfF/QO/wU6uIGhzNDUiay4yLrw322qze/vlec
	AKbOsfvCkSlAdqwlv2QzpHVi9aePZd5Va/p/vhOMl6WCITRol/VCMsSsu1KiH1neDVfMoCchTVJ
	jAo9J45aZKZKTRaM0kdFGuPQQ52ej1e0/6WpsZQtvVgMVgQ6V+wuCm32SX6Y=
X-Google-Smtp-Source: AGHT+IEz6OAPQZ8CNPnX7Hyf2M/lKE4KlpMLFRz9E8JRh/U44Nao6xFiXBZL6qbP4qo09JVHW6v1Mft/ovjh0HPfnWgRNGQumpo1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24a:0:b0:426:3ab1:74b9 with SMTP id
 e9e14a558f8ab-4263ab17a2fmr1736035ab.25.1758824942930; Thu, 25 Sep 2025
 11:29:02 -0700 (PDT)
Date: Thu, 25 Sep 2025 11:29:02 -0700
In-Reply-To: <CABFDxMGo8YMhTyQcPRb64u8Mxhvug986qAVpnvf=Pe-xVeHRUw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d589ee.050a0220.25d7ab.005a.GAE@google.com>
Subject: Re: [syzbot] [exfat?] general protection fault in exfat_utf16_to_nls
From: syzbot <syzbot+3e9cb93e3c5f90d28e19@syzkaller.appspotmail.com>
To: ekffu200098@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3e9cb93e3c5f90d28e19@syzkaller.appspotmail.com
Tested-by: syzbot+3e9cb93e3c5f90d28e19@syzkaller.appspotmail.com

Tested on:

commit:         8e2755d7 Add linux-next specific files for 20250925
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=130face2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=30329cd7f7188983
dashboard link: https://syzkaller.appspot.com/bug?extid=3e9cb93e3c5f90d28e19
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14bdace2580000

Note: testing is done by a robot and is best-effort only.

