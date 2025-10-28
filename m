Return-Path: <linux-kernel+bounces-873570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E919C14303
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECB4019C89EA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1633054C4;
	Tue, 28 Oct 2025 10:44:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96942BE65E
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648246; cv=none; b=ttRzWubd4bGPbhbzu7YZsg08FNV2tT4rTSkWJc01C0PbGtQEerFl2/nfrCBFQenPw2mPZyOIYz/p2ecULJbxocTwIlPexrbEVXJzJfisrqSaP05h0V15Ow+pU+rdiPgzqHAIlrOTrnsjR3l2S5NNrs2B450kV6fZXoIVUbO2HLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648246; c=relaxed/simple;
	bh=3AwxNWSeQ908ugFt0DAFqf9iLFhhorT5v7WAXrtu0Wg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=td1kGuQyGz0cD6NhNjCvRfpJXrGV7hztpSCy0UJP1/2BKoPqD0G0RpO7Mh5gM+ttiJlBKLr3MJb02DhbbqC99HH1F559eocaGVgG0HSLC1OitSUq3nY4R3MY6EYVs1rsGkwje+OtX/rrx+P1J/19XxDxg8vsklHA/2GjxOi/Hlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430e1a4a129so79054545ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761648244; x=1762253044;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CF9qohOjccaLnHtc6PhreiBDQqT/2OinTxSVrwBH6ro=;
        b=sHUDDknnZ5wk/rXLa82BN5TR6lKwr0bvYXi+NmH/zJeqOwfNeEteLlPNh5M2aPXyWj
         DleN9T9pAznYaUGntY39He01TO4A2Ot7bYvl5RjTlyjSZTT0XZOqkq3107BcSuEZstfe
         AkYlE7SwJyj22/vv3gZ1BpmYj+ES2lvULLCObdBFcBIlW6pPjSo2cwQTAV+85pKIVxXT
         5RGIj6UYOzVWYdEitbsWGt9+AstNaM7k8B5D29gjoAgvU0kPQP6iS7sN73nmmEuHIa0s
         lnN6GpaS147ImDCA0wnMewfFT4pNTdrZo4c5aGTT1qK6STQnu1VUzPONyvWAMTEd2LHo
         4ZZw==
X-Forwarded-Encrypted: i=1; AJvYcCU7rYQ76/qJl7qZfNbYbNpjytOqM/M1x+2dcWsRmTqXfR0VEteNE7lMkoquCMgVUq3h92ltBwUTPH8jZn4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7G/dYgDzIY7LAcFZoMMapNgBEA9Aiwgv4OEKAnRniouIQWY82
	Fj5fFLV1jQAWAavI822EwyF46BZNdm9+4dUMa+vwk5K5Qe+tH36m/YNi5wLgkJ8LQ+IfyTKQMgZ
	XXqtbPy2eFulyVep6x5jn66b2yX4cXZWBHgoAQRYYq1EodP6O1dUiqthYnOg=
X-Google-Smtp-Source: AGHT+IFdWjLHoreImPBO1OQkJwryBnvH8Zjq6MQFafKPTzAId6kSIjAY6t9FvZSGDLv1RYXjUJBL73MrPgacjmxVrJjrlyYWYVY4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174f:b0:42e:72ee:4164 with SMTP id
 e9e14a558f8ab-4320f841931mr40636345ab.23.1761648244037; Tue, 28 Oct 2025
 03:44:04 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:44:04 -0700
In-Reply-To: <20251028104004.rNf-c%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69009e74.050a0220.17b81f.000f.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_claim_suballoc_bits
From: syzbot <syzbot+5054473a31f78f735416@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/linux-5.10.y: failed to run ["git" "fetch" "--force" "4d52a57a3858a6eee0d0b25cc3a0c9533f747d8f" "linux-5.10.y"]: exit status 128


Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux-5.10.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=cae1291240e8962a
dashboard link: https://syzkaller.appspot.com/bug?extid=5054473a31f78f735416
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=157157e2580000


