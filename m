Return-Path: <linux-kernel+bounces-848176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDA4BCCCF4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 13:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04EAA189E4DA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 11:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3A9283CB8;
	Fri, 10 Oct 2025 11:51:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1070F1494CC
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 11:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760097067; cv=none; b=n2czKgNOVDqdiRzjfPlm7ARQaqrGD/c0UfGfmEvT34jcC89HMCsqKJo2+UUhRg1ki0M0DGlEZc3bb7931HVP9Lk4ZPpfFBwE/LqZhWdC4gr1NOfSW2CVSJumRQiboD/FCxv+v6J6Upyvlswx/EA+iBCa/oov4cB15EH/vxHj4No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760097067; c=relaxed/simple;
	bh=PspXwmKZ9Ui3ZzOIWRtueUlrn4JfsG5KAcJg9b9tFcA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MvsbL7eQcpXcChMw4kGhGDN9M6I/AoDuwp48+iLg/mhlpeEVMW3+kwKTYAvdM3aVqMaAlKJwc0rqhgA4i53d3NUdAojoxTRXwvFmvl/nJS0SZYettcsQPuka+tvR9OzLH9go+2ag/tGACBxWvg4BkXb/fs0I7o5YiHxwOmLML1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-426d38c1e8fso37656995ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 04:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760097064; x=1760701864;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BPu4xB67zUy0FGph5Vvn0Y1CjCAuCthLNZ0TGJv5458=;
        b=rz/e2UUA80Q6Qpv8pcZSOGQC2+8Z/UmTYYcB3SPYiREviJiBD5j17NFl4go0sF4QBg
         pknV8r+B0LqIU1UpYK/CAGN7ob0A5U5O1i6y8Mg4L3qJNbDlmEK5a5LtPC3qC07pA5Xc
         v88CoQ5GkBNYB3O+7bpPOWeWjifKN1iB6EuB3dG1DB8zG1A3+CYacarBqw0JdohefQFQ
         rWS4REKStWBJuUWzQYz5/e27x1g4wW2DcxQqbc3ap2p9X8AhWE5xX0kjbIl4gJazGLEW
         hfBOV7occNLhshjeB1OWejiDS6695u1qdsOh1ZNQwcPCkuy7W4Q4mlqJ6836PKg2/A0o
         A0Mg==
X-Forwarded-Encrypted: i=1; AJvYcCVHmeqycS0cxAw5307T5Zx2D3b6mEf+ZWOvXlGaIxm/HatXs66mSri6946OXwON6dzaTJX7DNBU1obF9QQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YympDIxcO/K0pZPVy5izfgzYGevie9P+uLwkYafqMIUGGMYXHqb
	Tk67kBFoF9TZHQoJlSmhfvtMsviAvTnjMd0Ml2PsbtKAR8KBg8Faaqo5jwGdEy3vPQfk87nrSsD
	Ioh0S50/lxTaXkMzBqDXDk010usbks5Ek85uMit4sLF85QVowHSVGtEh+O6A=
X-Google-Smtp-Source: AGHT+IGEX0S1kGfU955e2zLAYz60qHb702Q/SI7L3WbvNOuFgb2tWeFfO5J8bybYeHaDhJVXlRrbdpv82sme5qFcvnGp8lUA3pq4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1849:b0:429:6c5a:61f3 with SMTP id
 e9e14a558f8ab-42f87373153mr97370145ab.8.1760097064193; Fri, 10 Oct 2025
 04:51:04 -0700 (PDT)
Date: Fri, 10 Oct 2025 04:51:04 -0700
In-Reply-To: <CAJ9gUkG=mei=vpbw11vK_UA6yor20N17x2syzCvtpQc9rCVa5Q@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e8f328.050a0220.1186a4.0008.GAE@google.com>
Subject: Re: [syzbot] [scsi?] UBSAN: shift-out-of-bounds in sg_build_indirect
From: syzbot <syzbot+270f1c719ee7baab9941@syzkaller.appspotmail.com>
To: kshitijvparanjape@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

./include/linux/moduleparam.h:293:27: error: redefinition of '__param_str_scatter_elem_sz'
./include/linux/moduleparam.h:294:56: error: redefinition of '__param_scatter_elem_sz'


Tested on:

commit:         5472d60c Merge tag 'trace-v6.18-2' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=40c8b8384bc47ab0
dashboard link: https://syzkaller.appspot.com/bug?extid=270f1c719ee7baab9941
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=168c8dcd980000


