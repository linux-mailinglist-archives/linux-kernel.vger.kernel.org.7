Return-Path: <linux-kernel+bounces-897346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BCCC52B6A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3ACA3B9A33
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B9A26ED3A;
	Wed, 12 Nov 2025 14:02:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE2D1F9F70
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762956124; cv=none; b=UTG/uMKhB0OotcUgBicGx46+piC3OWughb/qCg/LdGNzL9OyaPg2eIvLSCok9g8LuJTDB9D/+XyApa5USR4Zh2WpYpMUoaErSTc+EaLxguKCIOo3WV3CSz0yQdHvE7VFk4uNKphAtI5ZYQXabaUxO9yGMgzvt1OicqNcjBRqqAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762956124; c=relaxed/simple;
	bh=snbivZtrvaG1Giymju1SmwAwKT9bcoBTBPPqMbO5G74=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QBQuDvmUassgSHnU1BaAtiKesOT6aqkQO5iS1He1a/K9Y8KNY6JHQ4Uh7R5TLkwveCP93rWoGzjZQEv+kmod1AEOrj07hlrhSyK/0GPfeFqhA/t5IVxxOrPtU3plnPn0hFjpJ3OPTqzUg+WdxDxgYuM4EEc4Qh385HVuLvS/IEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4330f62ef60so8224775ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:02:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762956122; x=1763560922;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7zTASHaSa73grV7J3VFhGuf76I4PDhxdb2kchYRB9Gc=;
        b=fZcPU3dW+KZEmCAXRDOyCfIrvo4qePoDra1mEdtQkUnIdCkYxB9N4XvDJsbs6XDQl4
         oRrVqtsMieGAu9E9r+2dHOuHA0HBwjfhsXRMEh5nHT9qq7GsDi34wO+E8MMjiYFTioZZ
         h+1/DzHrZn5KLy/MO/wcYn7RWjOgSwshdM41RfoVG5+tSN65G06M6z+BcpNQ8ITtokLH
         kSSsQuxM8LvNZiGEz5G+srl3cliJleeI/V5SxAasSioClNGPUq3V24n5vy92eyYNRwti
         2bG3dxrcaYvSYS1epmI+jqRCOLpSoPQTMc9D+kXPhbweE4ECMb9oTk16r48SuL18KdfG
         1EsQ==
X-Gm-Message-State: AOJu0Yzb9yTNLiLdQf749jPq+r+58lCOqBYgvyLKH+JPtN+F1wyA3Aws
	4gDclmTSdClDPJ75r0QTwmoLRCPQ2mXpg42iwzeD31Z0kLKY51JUw7uiX4Zgy/7yupuao6M79P8
	TFQKmT41tU7PN8hdckzP2WnFyA2ymzjb4BPBek50tXaLmmt+Hpfh8F0IfzaI=
X-Google-Smtp-Source: AGHT+IG9cOPw5jBpeg6yMG/9LXOx9CPTegSMh/2ADyolc4taRKjgBrp3vtyrJktHnbdUU0ZTiKxZ5aYZJez3QiZY4EKE8CE66vbX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:350f:b0:433:2754:9468 with SMTP id
 e9e14a558f8ab-43473dbc620mr39117735ab.16.1762956121913; Wed, 12 Nov 2025
 06:02:01 -0800 (PST)
Date: Wed, 12 Nov 2025 06:02:01 -0800
In-Reply-To: <CAMz+-CPAeuET_d_2b_tNEdNiVT1R7mzLYWih+nKa8=Dp0WjqHA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69149359.050a0220.3565dc.0001.GAE@google.com>
Subject: Re: [syzbot] [wireless?] KMSAN: uninit-value in cfg80211_classify8021d
From: syzbot <syzbot+878ddc3962f792e9af59@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	vnranganath.20@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/wireless/util.c
Hunk #1 FAILED at 963.
1 out of 1 hunk FAILED



Tested on:

commit:         24172e0d Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=bbd3e7f3c2e28265
dashboard link: https://syzkaller.appspot.com/bug?extid=878ddc3962f792e9af59
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17cfe532580000


