Return-Path: <linux-kernel+bounces-729365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EC7B03576
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 07:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFB32189A978
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 05:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A667C1F4297;
	Mon, 14 Jul 2025 05:08:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41033D81
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 05:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752469685; cv=none; b=LnGyU5O5SIlUQCkvzt7P3ZTJ5fd72H8QUuQOwLmPwCfOQ4pTb24X/p4gzJVj+DaXc/Yh9ePd28xGW1sRhaI687/NKjCq0ig86jTuBMLTtM4vTG92a2/Yy02W31wcXvD/V7E20JoDrIj2EOTXybRObvbAHAcFvn8Zx9f8dqVMjOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752469685; c=relaxed/simple;
	bh=WlPI/wFJPEXMGS0nmls4LXyAqoJRNQ80VI40A1RMeP8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nt91Jl5F6BMyYDgLPeqMO0tFGNBJl3Wmz6WXkdWPydQLlHjIhvKcN/2WKn8PW7QnNCJaILvZdARTqsncR8VhPe0qZuAVoTX1HUHSe4QJm5oiHJoh4teZ5sH+JsRjOYR1KtF7Z3/PINw/ndL1eSUzkHK8qR/gUv/N3Fr9gvPSYqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-86cfff5669bso383607039f.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 22:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752469683; x=1753074483;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gIsNucXB6Px03mWQ5TC1KHiSeVFF2WgYavWzXtnawWw=;
        b=QhUMEUQNpMKBVpXtRYmt86dpBrSX92wCY1/o6ws4DUSYNt0sD4ZIAe1fLQTPuZR4ON
         5UPZm7qbOXcXyO+7he4Eh3bKBLmXdebfnTXvgRXVPT7hGXOMrIFkeO9yQYSKmBaJGEhW
         6q27F3rci1If4NeehdRxBv2Gq79x5XKeymbk2Kg0K3G88AcVd3PMPIeF0bxmT0XDC5ob
         7LbXpjIu8xY5a78iREYmmjiqyAfElmvNGgEhInIQUMbsQRHOcPqzCnnors4cf/g7l3B+
         Minhma7YMwXYwdEKJtGSPlsQGZ3z7plwCm/OF2QsGfVpNIeBCUNFjlYmYrMhcGSjQnwA
         A+bg==
X-Forwarded-Encrypted: i=1; AJvYcCXpyLvSU1gWT9qTgiOVkK/vRbRZ1jTqswyVBbFommDTLFERRo21uAtTestk48yEJeVLFNkHgbsJvOXUBaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdEu+uHkqZXnT1+6KJKSAy3S4jqTrUffRIBbXB0CitEUW8CoJA
	w5daToYj4JpL1CRgby/3ClYoNNTwAPlu1K9ndXGqCyPX1WTc6nQgh8l9/ncELDX95Sfe0HPRQbr
	oU3o3TSuYZT6ciQ/xsHHyCQE1Knzc/Q8wFXxeDC81rc6dgxW63lhabcKg6zI=
X-Google-Smtp-Source: AGHT+IEpB5Rn6xJgA/DDklQnbk0r4Z3QBxG23xYQiRZo41BEGItwFGYXO0J4JcTEAhZ+4QpfV6TqHI2SbFxXzzrd/5fDbrDmHwWh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d8e:b0:876:e10b:9763 with SMTP id
 ca18e2360f4ac-87978296516mr1051400039f.5.1752469683020; Sun, 13 Jul 2025
 22:08:03 -0700 (PDT)
Date: Sun, 13 Jul 2025 22:08:03 -0700
In-Reply-To: <20250714024903.3965-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687490b3.a70a0220.3b380f.0048.GAE@google.com>
Subject: Re: [syzbot] [usb?] KMSAN: kernel-usb-infoleak in usbhid_raw_request
From: syzbot <syzbot+fbe9fff1374eefadffb9@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, hdanton@sina.com, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, stern@rowland.harvard.edu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+fbe9fff1374eefadffb9@syzkaller.appspotmail.com
Tested-by: syzbot+fbe9fff1374eefadffb9@syzkaller.appspotmail.com

Tested on:

commit:         c2ca42f1 HID: core: do not bypass hid_hw_raw_request
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git
console output: https://syzkaller.appspot.com/x/log.txt?x=138330f0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7367e34c3d60253b
dashboard link: https://syzkaller.appspot.com/bug?extid=fbe9fff1374eefadffb9
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

