Return-Path: <linux-kernel+bounces-757961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F25B1C8DA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1C1C188DFC9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 15:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C5B291C1B;
	Wed,  6 Aug 2025 15:38:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B21D2D7BF
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 15:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754494684; cv=none; b=dVvUvi3dn9lmrq6IF1hn1vJ6fhNZQuEiHjAVb/VA2EYGFUKzUJfsf8ylvzUhMCk56CnCgiwaNZUnFa7aOVWd2gEZRV0TgvG4W1ORse+MRtE/RxysIqxuunBQw+w4bzGYaVC1Vxpxs4FAIYhSJ80OUcdV4pnEmel1JP+giMkMMS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754494684; c=relaxed/simple;
	bh=9w3CsoIDqpflSvAOkK4eHImQ5p5KgT/rGzNBLmI5lLc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PWWa5OQOUzMKPofLsE3za2LgEbsTrjMyknzdcphCwPDKnxUk4ZYK5Hrh00Ph/SOUn0DCgL1xJvZIdu3lLrjDuyjGPxs43/sMiKnVvLcDjPzP1ugpLIIaZPFRloWT/Dc+K6dxdtP6ITSwlZXYYjwIY9CC5YLuHfLo/Lar/vP8GKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-881a214c747so70576839f.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 08:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754494682; x=1755099482;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZU8SzOXyIUfFyq4Qxk0Wl925G+LRHWU5sBfbKF6330Q=;
        b=o102sL1ECbzTM0i8kZZEQRFEc79LYgV4Q0BXOm83u+vUeTS/IKwhdYqQB/+3nmekgo
         OssNXR6NwsiZjyjtpCxeM/9V2aevpy/qu5Y1hYHQy9T0H1yKR22qgMqwzlinOCHV80fd
         Nc2aUiwguJZAZmyqCESMwbm5ADHBHU3HlQ9AJSH0cYaZJKAvR4DJys8Vrm2I7hCXZMab
         3ABhA2cXYDEqCNotIANBDFOucnpCeuJ+wGez7+ldROFAvURsvs6a+jFpGVIxvpHeKU98
         6uxvSyW6PzKxGQhrBGrm6MCmk2KRR7swbkL/zqrY12VDSM5YTf+82509UP8fpGBLI92S
         fxSw==
X-Forwarded-Encrypted: i=1; AJvYcCUpgkrckfsEWeG9yv9fnoTAN6nRp4RAwGUYKlTpKE4xOVBb+Yl6p+itlitd8YsjKuCiXt89JU5d+VUqRyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YycgivtuAXLCa8WaMUu7vMcT+S8dzUfWh/uoM21QjW0vK2k0E+N
	Oogh+C/Wogiv4vhvWhE9f3Yuj+PC6lVe1lU1v04umX5v1Ia1U15L6N7KcIXZdNFjyNecHUw+Uu1
	tKgqyUCowlGJD4flI8thxYiJ+sX2eet0PmhSSEMNAa1L+q1TiMKUvInPoDXk=
X-Google-Smtp-Source: AGHT+IHiiG/0LQTZx2F0nl0xTNKo/GBFT65Yn+8eQJyBD8YfIyE+qvAvb8al/uJdUXR++j2wENWZfhvbyNYfvh+KzO0P0gN1F8W3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a6b:fc0f:0:b0:876:a8dc:96cc with SMTP id
 ca18e2360f4ac-8819f087f95mr544535539f.6.1754494682510; Wed, 06 Aug 2025
 08:38:02 -0700 (PDT)
Date: Wed, 06 Aug 2025 08:38:02 -0700
In-Reply-To: <20250806111922.669-1-dev.jain@arm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689376da.050a0220.7f033.0040.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in follow_page_pte
From: syzbot <syzbot+57bcc752f0df8bb1365c@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, david@redhat.com, dev.jain@arm.com, 
	jgg@ziepe.ca, jhubbard@nvidia.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, peterx@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+57bcc752f0df8bb1365c@syzkaller.appspotmail.com
Tested-by: syzbot+57bcc752f0df8bb1365c@syzkaller.appspotmail.com

Tested on:

commit:         47905800 Merge tag 'ata-6.17-rc1-fixes' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=125da2f0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=75e522434dc68cb9
dashboard link: https://syzkaller.appspot.com/bug?extid=57bcc752f0df8bb1365c
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17c36042580000

Note: testing is done by a robot and is best-effort only.

