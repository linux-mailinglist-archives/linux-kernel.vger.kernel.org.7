Return-Path: <linux-kernel+bounces-845007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FDFBC3451
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 06:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D6B1189A2D5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 04:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A90E2BD024;
	Wed,  8 Oct 2025 04:08:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D48B14A60C
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 04:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759896486; cv=none; b=Ngw+bQD65+7OCKZFa2BMqlchA5fB7N94/q6v/JaIYvAtrJzqbcDG2+wwW0LOOAukr6pxwDeApGkYRVeaIgsKb10jiLkBdNPUBGaqUK0nVEMSZxbHjfjxXWRxE2bIAAlVClSQHdLyhWGahLmyYeKfw02UdBWm+chXGsnvn5dZcLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759896486; c=relaxed/simple;
	bh=ljVuYzqF384wM/rHgkXoofg8A3pTXzMOaTPkd7iLWQI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Fd2QQXP2Chp0ENUUF67dwigv8emZyZkWdgP2yxrM5ZOjz3MgcD2Hw/OwjN871ddOedZZM6YNojYUvlLFDXKBgZSM1cCn2SfpslzGFEHz+O5pI3Y7ATEJgNwjb9mgUDddplRH5uxAOOXgdHMX0d8HprrCso+kfitOqsXEA6dgVV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-9201572ebfbso1846343139f.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 21:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759896484; x=1760501284;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H6jfBnn3c+ObqjyxOE6dRZeQA/XWiU8ZD6ZSpyfuYDY=;
        b=jtT7ZYy70zYcjTW4x9zKohnFGdNYtApwMs+XjJQbknIjlq/lkRbAP1obM588Rbz30w
         h3TGrtA8BVu+IYYlYtSpH8PbF3kZrQCIaMelaMixdEYtCkx8R6XSiCUYZ0Fda7ls+LnT
         UEli6uAsnJu+rWAXJeudMI1lFYzteIoBhXXdW6M6DXrzVMcgZROa69mag5Kf7Cz4O40D
         9ZW03oSIn9x4vf6+iWqQUzdAdJqAmiwzMWI9RqGQxMWxyUPba4juG06CPhcqiduWA7z6
         n5RO42WDBhzdwHXSes+U68jCbrHVvmBgVvtNj1q5WqILoOwol/kXRFJcsPrj8pqG84Yy
         xvhQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9sVP/IVK04IsX+GC0xNrfkExabF0BIWt/+HuUzAhoyG6OzQ8S4NZtabAhc8Wd4iHKqg33K8dTkH/2StM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPB0oXdqyjAksT9aAzg4j0IJfbc1uFON4T5rEzqF+KttIIUtGp
	gqt4SjJCjJgD0OG8cf3TwyNP7BrLFn49d2vKVpwd/YCkL/4ciZq5ImBAxVFZTMRb9moS2ShaP7w
	/FNqAiVRBiVIMiJDbZofVNRY3jb3D10rsSpA6Z5epYQ1GYyd6uXxr/h3d3IQ=
X-Google-Smtp-Source: AGHT+IEmU7YqYLynST3ys/oJzR5ysovvNAwJl5hk/8OAX4XMyhbez1TKH60xxPaveyOVyrljjcS/e34oWDOwazDcZOmwFbqI46gM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3a04:b0:42d:7dea:1e2b with SMTP id
 e9e14a558f8ab-42f874010b9mr15760415ab.24.1759896484272; Tue, 07 Oct 2025
 21:08:04 -0700 (PDT)
Date: Tue, 07 Oct 2025 21:08:04 -0700
In-Reply-To: <20251008034738.467897-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e5e3a4.050a0220.256323.0034.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_refcount_cal_cow_clusters
From: syzbot <syzbot+6fdd8fa3380730a4b22c@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+6fdd8fa3380730a4b22c@syzkaller.appspotmail.com
Tested-by: syzbot+6fdd8fa3380730a4b22c@syzkaller.appspotmail.com

Tested on:

commit:         0d97f206 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11d6da7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d6fcded704acad42
dashboard link: https://syzkaller.appspot.com/bug?extid=6fdd8fa3380730a4b22c
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16948542580000

Note: testing is done by a robot and is best-effort only.

