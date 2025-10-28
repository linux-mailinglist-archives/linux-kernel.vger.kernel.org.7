Return-Path: <linux-kernel+bounces-873568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCABC14300
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 435693ABA47
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EBF30DD31;
	Tue, 28 Oct 2025 10:43:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CA930B527
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648185; cv=none; b=nncoOr6/abj9YgLjOXWMQfCCDVrVDP+sJZwNoGZkgZkjJHClRl9tKK6xkRio5GY8/UX8lqbC1e0ZYx3V3N19lH/vylRYWuh2WhuJj2f/RLLzVDS2bpO43z7BxvPHdgsARz7fyH9uDhrUQQUlesUQBfpjrpjtNNNhk2a+X+oT0oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648185; c=relaxed/simple;
	bh=ZPLGEKivZLhHk+fdIEGGbiy4V0l8isA5mbuEpUFc7Sw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mee/R//qz9JBPdJBi2NMqYlKCo9x6TodVJXqQBUK99x3633accnNkdTY5t4ChXJ1xFtEwWHAzInfpOhFb8Z207UNd7FJRfuqAP5c/YeNNccmSsx3afZEzpzTrzI95QUQrTSQNOJpPu8/ja4wNZTZTSfIe887ggsqYKgBdlh9cBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430d83d262fso227550925ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761648182; x=1762252982;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IRFgQG1kDazxK8TD+8VJBW7KCzeWBI37o3dtCsBsXhs=;
        b=q1nT0oT6KXnDIOYLel7PdZ2f9y+6Gll7CJyl9KtEAS9z7VV3uJFybnXTMoxz8ajnTF
         EJmrAkEpn5gTyGulBM/6ikw6DDVTazHKpBJApnz2kK1TRU2KP0Et6xSMxy1nJcYLWg01
         03xPiy8PZkzDT2dZuI7TX0x1ykISbbakeoV7H9wCJOJ1+jCbIqrp3zAgKx0c81RR5pWt
         DKq6WQEqXRWjsAOiwpHJZ6DSYVxyc+tqtz/u0RL69/roqVjuq5/cBaoiC+SRMreT/SVY
         yGgcA3AHX/qlnnfNNE00nf3OOeT5F1l4WoGCqB7q6wDaHpSa0odwO0HKveuOrUz1WplW
         ri9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUIBwfzwhnAJKf2FjKp0ZKW00nc8XjZ2ADwahwWG/XaTcWpsRB37rhBjrjDkXhCnQMXGMTmxLyGFTM19wU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbIwQFzC+QOaj81GZjrqURNH39Sf6jR6KlqbvhXsJ7eeAHyZwa
	3H4vzTJH7dLgp1IWmpSrBC+Bn30S8hcvAiZqfJsBYOZGMlZ9vz2LTzN0G13+xGcYbxdTuu/9cnm
	THmTbMeUehFV87j2bPZ91hSaIaI6Ahu+EA4BOro2E57cKPi+BoM0tcPmGVaI=
X-Google-Smtp-Source: AGHT+IEyYIfYC6076PUQMOyYteQRTg84E0PxeG0/trLVjx1tfplQTrFxSc9hnaInChgGsuwrkfrZ9Bm238PuSz9Q8c9CUe2xg/XI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e06:b0:430:bcef:e0a8 with SMTP id
 e9e14a558f8ab-4320f86661fmr41234485ab.28.1761648182138; Tue, 28 Oct 2025
 03:43:02 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:43:02 -0700
In-Reply-To: <20251028104007.TY91n%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69009e36.050a0220.32483.0180.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] general protection fault in ocfs2_prepare_dir_for_insert
 (2)
From: syzbot <syzbot+ded9116588a7b73c34bc@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/linux-5.10.y: failed to run ["git" "fetch" "--force" "4d52a57a3858a6eee0d0b25cc3a0c9533f747d8f" "linux-5.10.y"]: exit status 128


Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux-5.10.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=73696606574e3967
dashboard link: https://syzkaller.appspot.com/bug?extid=ded9116588a7b73c34bc
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1422dd42580000


