Return-Path: <linux-kernel+bounces-819898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B6BB7CE5C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4BBDB4E069D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 02:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B992F616F;
	Wed, 17 Sep 2025 02:46:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA2918BBB9
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 02:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758077166; cv=none; b=Z0ibNuPTp7kxAwe23omNxu/wkn6ymMMZTUDDolfBvTP2vuqdXScQsmaJegrQ0+sINOvGUVZII4xA7HjvZYt5jVy3LoaqfEXMln3ZQp1DpDkQQ39NNIM+KqO3nvSxspqols9ohXY7JdwAOev7s6e88+aMMmvrN4hcVT89fy8gL/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758077166; c=relaxed/simple;
	bh=ajMBj6W+ciqqQBnUackz3l2ePoV67IEOqT90PQWj854=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cmQ1m4IhlQZbeTJ8jSf8NpxJPpl+VQrmbuEOuxmPyffqUIjYgvVozXNImAbt1dog+xQ7DaPgvyb0swm83Wb+JQRAVdQhiSOQLCv+dKZvA5sxkK5LZ9BVttz+O6fahHPOxdU5O9dOOREYNNpmHN5TsjsxqHsqHGKXXgvH3SXsjYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-88d4b38d080so608400839f.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 19:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758077164; x=1758681964;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pXr93dir4iArTuEqabwmLHhqxFVOiWIYvzd2a7vrolw=;
        b=QCb6rUf0cbT2rmoSnDyuldyP1LVcDZPUR1NdYs+4I53J4GTtuZzJtC3SJ3Bgq5F7jx
         +dovkUae6WanJH1jpzPE1UzAZKgsScuRklL8rwlaMr4gnOq3UizmB2diiGM9Ll5oqOZB
         wBsJphp/Foj60iqdqhCHurp10SH163//L1xq8MxOYL0X1B+MVIW66qw4ZUslXWLEcLwc
         iB2R47NiSnte45toRKluRSs5epUQA1/X/M6VB8raK6PouSM3YWMfFcrL3KDn8et7bOEY
         rPN7R3MuI8XEQnYANpBLRYhEFY9yJOArrJSx3+xeXCR9SPggPVIzZWFWKfHI227bPhlp
         KPZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWme/gzolkPh8Gs82pLxd/caAXal5GsVxBFIg6eIcA5mhERcuTFo485WNNQJPlm9zqGGYyOQIsNldOi5cA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0qNvUI4GdOmjsPKvhQ1Vt7+Arr2RT/sHFD4KPpFLEu/pbbYjF
	/TDMSzI6OuCVylw6lJ77l3/Bz/QFnJM/MhaRbpX0cUZQPJkp++7ffCpomGzjjIbPVu6n83Ts8Yq
	HytumfRROOT+7QLJET/slEN8eyT8UXYa61OXHe16QL8kog/Huq2PWFUDS7KI=
X-Google-Smtp-Source: AGHT+IFT5F3SOVBYBfpTEN1r6Ryn4zXzRSfOjTM0hOyB/W7+O9YdgM3mtKGVFhjZgYGArN1kEvCJtF1uI8n1FOmdeBD4UX7+lmya
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1355:b0:88d:3818:afe9 with SMTP id
 ca18e2360f4ac-89d224fb995mr110124039f.1.1758077163875; Tue, 16 Sep 2025
 19:46:03 -0700 (PDT)
Date: Tue, 16 Sep 2025 19:46:03 -0700
In-Reply-To: <00ce3ed1-f2a6-4366-b01c-34cd6a45ae87@huawei.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ca20eb.050a0220.2ff435.04ad.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in napi_gro_frags (2)
From: syzbot <syzbot+64e24275ad95a915a313@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, hawk@kernel.org, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	lorenzo@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, toke@redhat.com, wangliang74@huawei.com, 
	yuehaibing@huawei.com
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
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14240c7c580000


