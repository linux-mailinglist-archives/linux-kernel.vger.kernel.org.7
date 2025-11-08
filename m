Return-Path: <linux-kernel+bounces-891665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F34C43337
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 19:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9CAF64E851A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 18:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EF526F467;
	Sat,  8 Nov 2025 18:16:13 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE744317D
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 18:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762625773; cv=none; b=qXhVoiIY2ErRk5w3UYTiCK75+dFjpI9zpqq0xG6EBAsnrsVqEO4kK5WK9zs3zE67OaXTZKywxgbpGHeAymD9cKAMoB+bULYw/wfppxxfYKH7hoerFwE+LHldBfJ2yAB6k2EwCyC49QvPqBUxqbJ1+UIP+YIefsvJc29sk0DlVbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762625773; c=relaxed/simple;
	bh=LGZdQF6OwXW8rqmk7YSNdkrepXa0p9aAmiJyI2Znu9Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qTkNUGvSIcf1HJ3yIQgBUU/a3GqiQXtfli5OnxId/g+Ck3EIfxQJfhPNaAkm8YtdwOv+yXAgxiZZCQh1Qm54QCqKXysmFabBLyLkbqO6nmdXTCXmGScpPPmwGsfZ1f2zx0f7VcL3l68w5C1tpNpswBGFTL4mNJ1XCP2EVWCMQ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-94880a46eaeso562675839f.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 10:16:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762625763; x=1763230563;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Esg6ee1UutUsWaExCFrXMPWt5bhcLtPu4tsvCCrPPmI=;
        b=PdkeoCmKg1Fi+NWrti9x8RKk0173bdQfrEIG2P49e05hAb1ncITxsPQoT2oCOk9lQS
         e8Q338yt0/+3keiG/nLalL4pp3vYJt1+OnLP4ETQUpRjR+5RNll77T8LUGVTcTrklMi+
         pjAJ5iMCmoC80nna+SdGnFMzdJKZjCcgKhUHd9UpihL+MXIoKIdCT//Be8faOYNeFxfa
         MJbr2qjbF/O7VI5FHqHXCQrADbCuECiuyd6xHtXHFw/HzzpxjrrntnUq8G307l//TPbB
         +NezkCq2qBhXtHk4BIgWfTkYsK62MAanHxu38D4JWN2OzOYkuGjUcY4JmfXv7UIM8ecB
         sVUg==
X-Gm-Message-State: AOJu0YwQ3XEDqgPYX9izXyxbnp32MbjwsBX74CvmCwVoU2SNhvhlStvK
	O8AxVDCo7ifoIs1wU1Geepb+FxJEw5Yoz0CrHIh5J4BMhiHBwhnBkiUQZgf2B/ijvD88e1Pb4lj
	+0fAS0LQ2ZHjY2r+Z6w0bCGISyZQdWLfIuDsVV1DvHEol9jRMATRsURpLxQg=
X-Google-Smtp-Source: AGHT+IFdy527tpTKpEUXUc+/bYvcGWXH20FB0GkWKMwTC0nLwOS/vfi98nCBvijT3b5jSDq6sdJymdDsbn1Y1xIvoT+WFEXqaqcI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16cf:b0:433:79a7:8158 with SMTP id
 e9e14a558f8ab-43379a7844bmr3796105ab.27.1762625763622; Sat, 08 Nov 2025
 10:16:03 -0800 (PST)
Date: Sat, 08 Nov 2025 10:16:03 -0800
In-Reply-To: <aQ-D6qQkBA6XUgyD@rpthibeault-XPS-13-9305>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690f88e3.a70a0220.22f260.008a.GAE@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: slab-out-of-bounds Read in ext4_search_dir
From: syzbot <syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, rpthibeault@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com
Tested-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com

Tested on:

commit:         0d7bee10 Merge tag 'x86-urgent-2025-11-08' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1791c412580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=486aa0235ebabcac
dashboard link: https://syzkaller.appspot.com/bug?extid=3ee481e21fd75e14c397
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1721c412580000

Note: testing is done by a robot and is best-effort only.

