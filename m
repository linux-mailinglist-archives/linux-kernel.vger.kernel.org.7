Return-Path: <linux-kernel+bounces-762690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E3FB209BE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D195D62041D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE762DEA75;
	Mon, 11 Aug 2025 13:11:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C02A2DCF4B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 13:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754917867; cv=none; b=eijlI7CvD778JbZIx9LQqkBseT5v7427Ij1Z9daKDz1GozwdsE9140e8rEn53NEcARIVg0gWtkdjrgLQyU5FjHwR9/wcwg0wgogssD8JtRihDfzUEhoGM3lMDD2Z+6cGbeQiIhkGuBoPHZ4Ulf3cct1jFeb4A54g+otGWVU0Cuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754917867; c=relaxed/simple;
	bh=xD0rhCCQDxyiCTCiqij42tudVaP/CESMLu3wSMvzdTM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oRdHXMLKjRlW+TqgZRYIYxd8j+vdGXjAgCO1aZPmU4R/gE37bybPHp9MfOq78DpIA0sIL/h44+Tp/ehOcJrApiav6eVOljztGy9ynrrw9dAuhSonRYE0NrY12RnP3DKCPBT3VlcQqOSTULYzg1xlLPARVv3i+ErC6SW8M888P7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-881878af906so869441939f.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 06:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754917864; x=1755522664;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n9dk/KXnfmnIr4tFpnYGM6Fy+h6Hay7E0LqrHRkUZ/Y=;
        b=NhbKyZuPHd46dHiWK4FQHyVMyD5oSsWzfwAq9asqNi9YXdEXyBI68BUXtWpgNXugr2
         PWi24myZbiA18OUyNUfenp9INCiPqlovPS9eGwUNN1aSB+8Inq9mkaHEx3r/Sf/Z888z
         KOj2Oh4uxYC4pPUUB+uKwkPVWTmZSUOWs8/Da6FaTaAR58WRHv8Vojog7deyVnrhqEdj
         5dUpCut+URvG92CVKSvyaj5AVeuPaFUj8TxQ4K5JqYCNII0GgaW4LN9d91EieWCbb1zL
         +aNnioPdGjoPPCmTr3xoPQYl5UwL+FPmlInbOMoSwkv5jKAMeLs4lkSoZY+faUPNMGvW
         Hkyw==
X-Forwarded-Encrypted: i=1; AJvYcCWdQeVNm2UrMvTO83DSX8buP/3hyn4ZOB79S1mS6ebwDMCGdz1ldtvgRhI4xH+HthhSwpIZ7R8tSmpKR8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuEQvi9hRseloVnlbp4igpw3ATVamSaqzxLHK22muqMA0fZTT/
	9K//DHovSbrUkRgo4AJxwnOzLx/AyHJP3ko1OkvVjCmNQB6ViN2BgmRd6pgiB/reIyJhE/2tL8t
	FMf0xlZOrk/Ou/B2I3u7EY0OeO1w39B2U+FEIq73Gi/l7isWNUYWbVUQuP9c=
X-Google-Smtp-Source: AGHT+IHp9kHMc1UpwKQ0Vk7zM8V/ayxaruCybpjEPHUNxmSMW53BtQydoWKdfjWT0CkXKjyVjb9CYlFLTTfcQDbsDeNWS2uKGzn4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1585:b0:882:a22d:c543 with SMTP id
 ca18e2360f4ac-883f1268d15mr2517820939f.12.1754917864223; Mon, 11 Aug 2025
 06:11:04 -0700 (PDT)
Date: Mon, 11 Aug 2025 06:11:04 -0700
In-Reply-To: <684c05ba.050a0220.be214.029e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6899ebe8.a70a0220.7865.003f.GAE@google.com>
Subject: Re: [syzbot] [hfs?] INFO: task hung in hfs_mdb_commit (3)
From: syzbot <syzbot+6bdbdd12cf8cdbc66466@syzkaller.appspotmail.com>
To: anders.roxell@linaro.org, arnd@arndb.de, brauner@kernel.org, 
	frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	slava@dubeyko.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 42b0ef01e6b5e9c77b383d32c25a0ec2a735d08a
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Fri Jul 11 08:46:51 2025 +0000

    block: fix FS_IOC_GETLBMD_CAP parsing in blkdev_common_ioctl()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=133fa9a2580000
start commit:   19272b37aa4f Linux 6.16-rc1
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=c07f08ee4bcfb276
dashboard link: https://syzkaller.appspot.com/bug?extid=6bdbdd12cf8cdbc66466
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e6ca0c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15d429d4580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: block: fix FS_IOC_GETLBMD_CAP parsing in blkdev_common_ioctl()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

