Return-Path: <linux-kernel+bounces-869942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 255E8C090D5
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 15:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 020DC3BC68B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 13:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73062DF6FF;
	Sat, 25 Oct 2025 13:29:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0C4242D70
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 13:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761398945; cv=none; b=mCePjpCtHlyTlNwxb7P8bfla0euyPsDcw5Phaihy2Ufz3rWXBgqKgUf19sOYBpDL/ze4RKJN9UK0AgvgvJ4h+2+BEv6vwUjJP3ye+6Soxn0cw69G5wa5hJ6d/KFvwp9iGkCAJFzDCoQo8DqXX1ocxO6UV2cmlVOULa+gD2y1Lyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761398945; c=relaxed/simple;
	bh=RP9Pt+BauBwNgSYpvCj58oVnpi/368V6wgiMWgdQkTY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=S213DcvwuSSwY0FTTi0IbHbECTMqHtt3tWuZBPMOSAU0uzXhOKa+u2vKw0RdMGeV2dxJrKEhYnfOrPDJM1Hw3F2z7GrpC5en7godOqoStC/iZbpsVIKZBz6xc4EWerMDvS0Jtm8WID0CR/DFEhuAHEBv1HCfzxqBlvBlbj3KF0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-940dc0d7a38so462488439f.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 06:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761398943; x=1762003743;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DbYZ6WDm74sbp+VcW5jO4pV+eBPk+8i/6WmBuNgclsk=;
        b=HGtYQFV8QpFlDByF3gKoI/nSaozVc/j2UFO0POCJ3JVdwJqRXbHlnc7OAbgiV4/qSA
         TUbf7fJeP7irn4srG8g3y6zF3FxWxuHwEZjTSm3hSGd+nFNGTgjrYVGV5kY+tzQlIG2G
         fzZ9qwzxybP5S+fxZt47CfvzQslDfMRvaV2eaSG+zZ7GRSZX5Y22KdZM9DycF9Gli5ve
         n0hj3emFstql/FQqyfvlk+nDzO0IuxAyLJoAwr2rVs43Zv2iPm4R6XO9qoVi/ZawhwVO
         KbVptla5JBZgwGybQZfxkLVippJ32uR33put1bA6iNdqFDri2ashjmXW13GNNU1Bz89o
         xrWw==
X-Forwarded-Encrypted: i=1; AJvYcCVVZg0SdqFzCMmVy+Op8Pk2oddbF5vSz1fr8KMdDFU7bAO4S+imZIYqWzYDretK9Kat2bCYEApQB1NK1Sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUdDhuLBIohPUQOCOSvEHKuGjvLApwF0u31mq/CbjclOQMPCyW
	2FiuhwToPCJeZ+pf+uf9EbJf9/kguGGmr/MP7Lr0tfdNuRIAUB3CAL8/Xb6LV3RaJMCekVeCOhY
	CDrk4K2tAg3JenboaOI9Qk1r14POSTsBpybJ+qJWI0alQvfnqQkF435Q5fFc=
X-Google-Smtp-Source: AGHT+IEG9FNaDeP2UFIyjK3kbzcSoVfRz+Iv7sLoxxZZniO1QKG6v0Da6WND3QnX4ALYHEemdnZ83SbSHvUGOHfu/3betk2JYWeM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2184:b0:431:d3d3:4771 with SMTP id
 e9e14a558f8ab-431eb623d7fmr91264515ab.7.1761398943060; Sat, 25 Oct 2025
 06:29:03 -0700 (PDT)
Date: Sat, 25 Oct 2025 06:29:03 -0700
In-Reply-To: <eycmv6nwd6yvi4y2xlvqsjfzzoq46tlmqhbdu3bxi7rxfyreov@m2liixvk4ugn>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fcd09f.050a0220.346f24.02b4.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in raw_ioctl
From: syzbot <syzbot+d8fd35fa6177afa8c92b@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, apopple@nvidia.com, byungchul@sk.com, 
	david@redhat.com, gourry@gourry.net, joshua.hahnjy@gmail.com, 
	krishnagopi487@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	matthew.brost@intel.com, rakie.kim@sk.com, syzkaller-bugs@googlegroups.com, 
	ying.huang@linux.alibaba.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file drivers/usb/gadget/legacy/raw_gadget.c
checking file include/uapi/linux/usb/raw_gadget.h
patch: **** unexpected end of file in patch



Tested on:

commit:         72fb0170 Add linux-next specific files for 20251024
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=e812d103f45aa955
dashboard link: https://syzkaller.appspot.com/bug?extid=d8fd35fa6177afa8c92b
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1386c258580000


