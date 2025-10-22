Return-Path: <linux-kernel+bounces-865069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B41ABBFC13B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 61E54357CBC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9765828CF49;
	Wed, 22 Oct 2025 13:15:08 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A1733FE30
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761138908; cv=none; b=UwX3BJNxjXkQGgjBCP9Y19Zct2CY7MyZhUNZHiFY0vYEO3QBgGX225dNeTULKV2saMvECKX5rj8GACsh3HkdxTYVHG8AqshPTqILk+wI4nTdN8M1iZh7z0Y4pVPBOPm+LrkH2Fy1DAe4xXmN3qUiyudLcGemvjzej7hfR01SSKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761138908; c=relaxed/simple;
	bh=fZfUQ8mGby/qPCv5ol6DhoS3kbqMG/LznTiq6BCV0xQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aRVnlJ7AOl38PRpjCaILx0FghG4RUiBTev9p4zej+7NKqW0zLJIcaw6v+KsL1+CJUc5ofRt0O8UDH5JMfXUqa5lufQ3pOCKWWJrNi9HASp8+mrSBqyzm5hs+WkfmkIj/Ah4J61ivdWSPbK4H9G5d2f79fFWf3XNXEGrvr64UC9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430c8321bc1so69837355ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:15:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761138905; x=1761743705;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1lXEEnRogE8GY22kgORhnxfquPyna6Pc3LdoN1g7bsc=;
        b=s0fUy3OmqnQnlKUQnuYdseu7WZHMPvC6vUVBhdvL1is63WkXZ43Oa8uH1qNT81IEef
         dzQJdntkPALhy+sE+MAGanejO/DOeAZ+UwyNO9HFrlbqB0fpYOedcYDN7e2/ML+9fnpi
         FNZqTlN264W6GnDs/m91kJY+hjdnpz2v1nLQCxWQVk78q7baldWb0NQon59cQjPSNmyK
         EqHQ2AzMr9lq7MJHaFeTXTj32YAO3LXgTgNYiAa3w1cguy7gd3aWo2T97w2/WnOSKTXC
         c/F0aEot6l8kYXdrtzMY1IschJJ5DK1pvaafycxVCctyufz57wbWvafIwkQ5lqmfqcNS
         JJzQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+MEb7q/wtMl5r6Y9yxj40xyhJmodMGMqPFha5eRRQgGfKIcmZ5E4JBDQsC/l7olEM26NZf6AygYwVk4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV/tyiCF3VhGyUID+DDAWXaMt/a3r0vOBwCybgzR7vw/dkmT0J
	LkwHVXArME+Oz/hnQimgUyyrc1gPbbMl4dPYNjCgkTadpeRNOWbBYTOZuy1Kbni7aPqXvThCvkC
	9A4Tnyf6T/f5bNlJLQ0mzZCN0o9tKfTpSQg3GFrIIA21UJ/L/e3naSZ4QIpA=
X-Google-Smtp-Source: AGHT+IENzlrsL3EMEDZ9arKVf1I0zbrCPyd3JIviXgsi5/bl7OxJv6CXdiPOdzHi/dY2L7k8DgQIGrDw+sXaXxJSUXIGhvMDClKY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3785:b0:42e:d74:7252 with SMTP id
 e9e14a558f8ab-430c531e3bamr303541495ab.31.1761138905492; Wed, 22 Oct 2025
 06:15:05 -0700 (PDT)
Date: Wed, 22 Oct 2025 06:15:05 -0700
In-Reply-To: <20251022121259.KFyNC%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f8d8d9.a70a0220.3bf6c6.0019.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] general protection fault in ocfs2_prepare_dir_for_insert
 (2)
From: syzbot <syzbot+ded9116588a7b73c34bc@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ded9116588a7b73c34bc@syzkaller.appspotmail.com
Tested-by: syzbot+ded9116588a7b73c34bc@syzkaller.appspotmail.com

Tested on:

commit:         552c5071 Merge tag 'vfio-v6.18-rc3' of https://github...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15a2e3e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5bb1f39a1998d400
dashboard link: https://syzkaller.appspot.com/bug?extid=ded9116588a7b73c34bc
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15244614580000

Note: testing is done by a robot and is best-effort only.

