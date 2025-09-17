Return-Path: <linux-kernel+bounces-819871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C927EB7E90F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 485021C00D49
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 02:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7C12F3C16;
	Wed, 17 Sep 2025 02:13:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081C721D596
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 02:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758075186; cv=none; b=i/cgb/taFCDyKCj1JoCd1fYgogDQ17TqjmtLwrlg9agYAtZoJzqtSxKSOVtOd1YmEAvzEAOAAP7b/mVAOKeeDsVtXAP+spUDD/2YTHLx3f7RBXdsElPorX9ekvs41kgPRuwNH3Tcssv7NjHOjifQC4TVCnd1FEnFVcu4n6WQCi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758075186; c=relaxed/simple;
	bh=6g5R/CWMwYhd5/WdCqBRyVlAAiYoh903mjsN79+AlgQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=A0g5b51Zl1Y6pwbshnvdbDR2hD5PsrisKTHEV7Qo2jHznQrt9K4QYC6R78l/5uBAEt0ejJO/oUmfQe004rcgh0K6onFk57dqWDz+2bMPS03zvszJciVcq5e4HBnErOpKO/SQ5t6f2dRKCBjzq3ZMrJitGFCdvl418VyFLYp6wlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42404bb4284so38532635ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 19:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758075184; x=1758679984;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jx9KHdVtHZIgjGBqLS7wvJNBVbVLbHgFsIJKE5SzA2A=;
        b=C4wAnGjoJERYFShagEYXGgRQF7FhYnbhhgm1dRYAznb1q3XLI+uQcQRMWgUD+hVkCk
         Y8Jd+qtRrKZ5K7jbf0DnIqNe2i5kn+LTHRRVjCYoHIJL7LGLhHYUCyCqx2pOOJIPzqNF
         kVmtLSiG1lYraFK8zClC3KD8ngthUPd3Cmr81MDgCpZ78YR82a+xAcvuboF1YbS9eS7v
         7v8THbnI1lngqr2C67i6o0Iw9jyav4UD0M5gMhP7F1pjGU0HMOXEhwKAQID4JUM4y6AC
         wSvNgTRRrcg9AU/Q6zFmd+nD2z2YzA1n6tF6Sg5DeMtTHfTv56caV3qm4aZgUaTfaIeS
         dyjA==
X-Forwarded-Encrypted: i=1; AJvYcCWHOiaP1LAPk40LkZ1SvjpiXvL5UWmj0kq/1X751yFwsMSne7LJ0eUuCyzbCpfkQ6DjvaREYSqty6uZTFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFMKKEOAfs3FyPG9WU9W1JPRz5qQgdPN/5YYto/edLzlJvmhtF
	pEkN2VyAczsreWJcsn4vuS6WE4IuSbeB5b7d0ahEW3NTjWhhOCgW/t68Of6TbPXU73OyZv3uNVG
	Nbxj9H7+luDYoXqOwCpvzYyDnkezwqzQLWA7gIPq+LUMakiXGfNrQAnzcQtg=
X-Google-Smtp-Source: AGHT+IF+Xp7F2zdQBLS6SfovYyoE419pQjxvECuoP3lsjzjgdtWD70iDaZp39lRnVWoebUhj7MfmUrcBlwtX+cSlj+PwarwdY8fL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19ca:b0:3f2:a771:9fb3 with SMTP id
 e9e14a558f8ab-4241a56dbedmr6050635ab.27.1758075184290; Tue, 16 Sep 2025
 19:13:04 -0700 (PDT)
Date: Tue, 16 Sep 2025 19:13:04 -0700
In-Reply-To: <15d03ed6-4913-4498-a1d4-9f4f2e43d7f5@huawei.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ca1930.050a0220.2ff435.0498.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in napi_gro_frags (2)
From: syzbot <syzbot+64e24275ad95a915a313@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, hawk@kernel.org, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	lorenzo@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, toke@redhat.com, wangliang74@huawei.com, 
	yuehaibing@huawei.com, zhangchangzhong@huawei.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file drivers/net/tun.c
Hunk #1 FAILED at 1875.
1 out of 1 hunk FAILED



Tested on:

commit:         5e87fdc3 Merge tag 'batadv-next-pullrequest-20250916' ..
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=a6c33a7db07dbea2
dashboard link: https://syzkaller.appspot.com/bug?extid=64e24275ad95a915a313
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17600c7c580000


