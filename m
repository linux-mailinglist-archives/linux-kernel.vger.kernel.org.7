Return-Path: <linux-kernel+bounces-830107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D380B98BCB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69F6718895BD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348CC280A2C;
	Wed, 24 Sep 2025 08:04:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A98B27FB1F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758701045; cv=none; b=YghJqACjSnc7ZCTf8VpeDOaMDf3dJaZvgAV7uwhkURoblbXCLMYwuLcJGvkmz1CKVloliM+QPdvyX47RCzAx9WpqHjwPeTqwMK044/hOO73vfy6o2KDi54Tz+4ORchV58XbZQJsq+QK9BT7fOIuuDcSSEetpJp4vhorvPxbeMh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758701045; c=relaxed/simple;
	bh=DVlQQZKCxLIN5/DWiFW30Gu1QHVkykPl+/dJYDaA4+Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ieNHjeShSpxDv8XZKRs1L5lLBL/TRfR7G4AvVa3OWOMVKiF4AdoCuIe0GcrRdNtvHyUZVDXyvDrJ7Pe90/jrnv7eEgtxmsWPVRKA3iOIYuWUCiYKrGNYPMJLoPuvB8DCO2bXjJf2Pxu9f/z12o8NpwnpfeU5ynGBZLfqKRIUV24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4256ea4e08bso103841415ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 01:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758701042; x=1759305842;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8dvbbs2wWCEqh8AZHHIYuQZ/K9GqbsDtk7oqeXqAtt8=;
        b=mmukZNCg+5dnoD9tmTNj+/w+ms4IwS8BNMSrJ9fu8AGB3WLY5a1CVhJp8uzKpZh8oN
         lX39rHrFp804qU2eR2s9wQFUDgZkQxGGIpVmvDJsxMvn2Ncgl6Kolvk1qVRKLWT1RGAH
         WSR5Yt/F6fr0vGprUEyOAVv0BwkOwLCRtZiygKC/fg9s6k+CW5K2HzMrcvqFdgqQC15S
         A1gsf6j8VOxRB1m4Tiy7auEv2W/It3fTr5VHM1gFURgU3mo+wO66+UA/gblkXG1Y+w5A
         6ulbzE61+A+0F/kYyWPqSclXY1rwTUZ5QJCGZycDV89ueZHVQqcnTpxqyGol7UAit7Or
         Qr/g==
X-Forwarded-Encrypted: i=1; AJvYcCXcRiTF+AN5VKMPtMTrsgriJGugiM7X5OMx1SpN5OmX7IED2+CwWv4wHlHoiTd+fJ69WSy2uvP5kvXAla8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLj0pC5FU4Qe7HylIiaK7gOF8IJZ7vCDd5HwEsKkgjYl9cSyyH
	40xm7FruSnhFQt167x2+mpp1ESIu5HJruxkW6ryseBQkUA6vQkw2lIDP10M8QXY3ZAFiUbL4vYn
	mzYDmVz67Q3lirkN4UMMcrAi3t1v+wZG1y8TiYb0uN/WhqkfxPw3GqLejRHs=
X-Google-Smtp-Source: AGHT+IHLNBd5cbKjKI69ETi4L3fRzuxsUKHsuKPnghMckz8NZX7yt1UeEOOWzTBRMdlugbqD7dQL00kcecuOU8KZOasPJSoU95WT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184a:b0:424:19c4:3000 with SMTP id
 e9e14a558f8ab-42581e3b984mr100002655ab.14.1758701042345; Wed, 24 Sep 2025
 01:04:02 -0700 (PDT)
Date: Wed, 24 Sep 2025 01:04:02 -0700
In-Reply-To: <tencent_D75AB77C177126CBB3776374097223A1E405@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d3a5f2.050a0220.139b6.002e.GAE@google.com>
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in bus_remove_driver
From: syzbot <syzbot+f6a9069da61d382bf085@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f6a9069da61d382bf085@syzkaller.appspotmail.com
Tested-by: syzbot+f6a9069da61d382bf085@syzkaller.appspotmail.com

Tested on:

commit:         ce7f1a98 Add linux-next specific files for 20250923
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14e594e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1be6fa3d47bce66e
dashboard link: https://syzkaller.appspot.com/bug?extid=f6a9069da61d382bf085
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14378d34580000

Note: testing is done by a robot and is best-effort only.

