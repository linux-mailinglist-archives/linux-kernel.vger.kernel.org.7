Return-Path: <linux-kernel+bounces-748532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B98CB14254
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 21:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E8C53BA708
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 19:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F8C26D4E4;
	Mon, 28 Jul 2025 19:01:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCB617C220
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 19:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753729264; cv=none; b=R5YbL7AZyCJ7oajY8ZSSLDnOah969nJ++ST43f8bg4EsDcoFxYxhqLzXQsvSzyhZumkRTjndEpxOiQOfAzW8jdG1cAmjvIIQzLuo14Hw5WkxbyoJxctv3c0mBXgOMa+IkwPMbbj9WMUMcPfJbE2CtTf5k00QyLxG3m5juV1qRqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753729264; c=relaxed/simple;
	bh=G9ZdGkQb0xLlf/XKFpA4NdyNdQwV8G1w1i56xfBDvfE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BEB5JGJAeKfNGup0sKVu7PsziCDBz+mGD4/miOaU5vlk5siVUo5qgBz53wrEiIHWJA+Gv8WyXVLj7i0ZjJuWaxk2wnT+WeGd3iG8SyyWHSr3VGQNGVsF9umWaabiYyZmu34Qta3gYGkBPdJIWJmKBr6UyGS39XaAePuXFa3kOOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-87b2a58a4c0so496373839f.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 12:01:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753729262; x=1754334062;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mb1gZWJdkGf3y2eFPdnwXfrEh1yIpTRd+H/igOQjIjc=;
        b=p0a+mNGEwjANG3NQChA+Zq1VSB4PGel6naokIKGSubkBCUYaB+SPt+HOaiC1SSJHKH
         SGqtqHBSt7f7AAdEfNvwq6QCtPBmed2ATtCVKw7Acto5RkHMYaHSnEYARHw+PXBKDV2U
         45JQBJRGXEQwzFrj/3WbFrPLgRwvVPIrFQeAgDew8CCcbUyAlUcPo8bQgpJoGiEN4FzQ
         V3EhA2W4ky3jeeb7dHnfTpni4PmDWre2eSYY73/exYuqOq2MTeHz/h8VDiicxLpqqUl4
         DTCEex1M5XmzSQ1BzFYTfVStNTTKpZ3l9VPcCdVboRDj7uXCG2j4HvNcV5TlepzPm7u6
         B8RQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVsXB38VxQZN9dHn57J4gvMf5b+DWr6tMIPm/whKez3KMgwD7dAlPZSwjt6r5ClGvuldKkspH11tUnnIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGSNLLgjDrqJuk9GnkRS497KjwUH5TmauqaKu/853E2E47FJyp
	4ee4kSu/IzGUnyMvXcgVslQTnWdWNsB48E1V5eC0vUwQlKrTrmuAr8nOhqkeMzb7wIqOggFKqbe
	hHTctQDe8mwzV55qE9EoLmEYYOAnG/jbMmXBfzc+ro43UtvHm3zLp3SkiIVg=
X-Google-Smtp-Source: AGHT+IHc9PfKehhMu5u3yMfjpyiDWJJWnaVowc2Mf8/R/KCTu9HRuhtRwr915JUI2ecelW2U+kXFN3qzM+sxVGnbNzJsRrhKPcIA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e07:b0:3e2:9715:df3e with SMTP id
 e9e14a558f8ab-3e3c530b511mr290248345ab.18.1753729261880; Mon, 28 Jul 2025
 12:01:01 -0700 (PDT)
Date: Mon, 28 Jul 2025 12:01:01 -0700
In-Reply-To: <20250728131216.479387-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6887c8ed.050a0220.3cc461.000d.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] BUG: sleeping function called from invalid
 context in lock_sock_nested (3)
From: syzbot <syzbot+55cd5225f71c5cff7f6f@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+55cd5225f71c5cff7f6f@syzkaller.appspotmail.com
Tested-by: syzbot+55cd5225f71c5cff7f6f@syzkaller.appspotmail.com

Tested on:

commit:         038d61fd Linux 6.16
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11391034580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=86767f92daadf3ef
dashboard link: https://syzkaller.appspot.com/bug?extid=55cd5225f71c5cff7f6f
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

