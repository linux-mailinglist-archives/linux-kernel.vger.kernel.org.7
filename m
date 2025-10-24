Return-Path: <linux-kernel+bounces-868566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DA0C057C5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A29F635BCFF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8B930E0CD;
	Fri, 24 Oct 2025 10:07:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9012305065
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761300425; cv=none; b=E50Aj1Qhco50rZEgEb0Mkt3n2gV27zthdqjD6AaxS79yeepnOIrEg5NKyVTpGqOhU7WwLZpniWGHEaGVM9z5jT1FnykANvtO6u7gkCiKxGdWIf6T8V5EMY7WihefprxVAz9rcxUx/O0hCkZIhLMS86PxS/koDGeBgWsDigZtnCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761300425; c=relaxed/simple;
	bh=A0u1gdBVEqlexyaGLsNkxkc2ESY/wvnWkypSVwAwJH8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sc2Ed6V0YdSAmz9+JVn+dQQCYknMJsANQ9Db3BWQW/MDVrToXihZ2OzvqjD5v8DgCmg50G4w7Lz1WCHghbN9BMjX7WtHntprnu234D82Cj/hIeWERQEwu3+WM1YoeuIrl9UxUmB30nDzbjWxLdTxwgIma1RQLqYqvusBcl/2bVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430e1a4a129so25838015ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761300423; x=1761905223;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OlQSyaENlrmR7LLSxbKe8y5pt5vkHo3J3pHWdTyCYJw=;
        b=L5ssM0ThUtbnZtG3r8ua+tboJftH3ip5b6q6sluGMXMpGSl32yU+5tJ8REGoprryVe
         p/NOeVnbINtYL6gke4hzl0zR3trck7X4hz3ITaPpfomcJIMOE0F9xDlZv4sP//WUoUVv
         HhAUCWLwb/fzT+0cFOH8LAOLNCqNJxMqJXtaYmolWEES8i3RiYl9+NFhMRSy8o8eeoeg
         uWpbo/iGWaKmuJRszLmzZJdA5qY/hI4fY8XEydqb10KdzOmRtTc7a51EP9eliKbRpZpU
         kchBP+qFLY5ao8iKSNI+z2IRrX/eQSMbCU1zJpJxLMf0wTKhQHrC7r/EbPSyKfedTPCl
         vidA==
X-Forwarded-Encrypted: i=1; AJvYcCVf/TJltOVV4+VamfGpj87FdsdrSHp3i/1bLQdqIrJ18i/fHjCjgsfEqWThCgqsp2YnY5zPezLlzdicc9A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt7QXeaRcXXJgiOTZpa9UzxZeYkWxVRMJP30Uvt0WyqausAqDM
	bhlK8sgiqWoJGIswOb9EcxPRgSbLPeh2cUXpl9WmasGOy0+Ga18PZQXUx04Oo8Q81bjpl65iXAi
	RuMm0y6bvVS6VYAxn+o3D09ogtosYQT+kyh14mXdD5i3cVAONJfW8goCaB4E=
X-Google-Smtp-Source: AGHT+IF/KEo+wAquhsjNRv+8AqvrG32ct/q6guSDi7rv4+t941ezr+lPUaL6oDyv7WCCnhmEi2lSwXzHOAl2tMkMoh2mN2d/xO2A
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2610:b0:42f:880a:cff7 with SMTP id
 e9e14a558f8ab-431ebe0582bmr24941095ab.13.1761300422814; Fri, 24 Oct 2025
 03:07:02 -0700 (PDT)
Date: Fri, 24 Oct 2025 03:07:02 -0700
In-Reply-To: <20251024071520.ZEdh5%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fb4fc6.a70a0220.3bf6c6.018c.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] UBSAN: array-index-out-of-bounds in ocfs2_block_group_fill
From: syzbot <syzbot+77026564530dbc29b854@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+77026564530dbc29b854@syzkaller.appspotmail.com
Tested-by: syzbot+77026564530dbc29b854@syzkaller.appspotmail.com

Tested on:

commit:         8e6e2188 Linux 6.1.157
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.1.y
console output: https://syzkaller.appspot.com/x/log.txt?x=17bb6d42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ef8bef4a2b3407ea
dashboard link: https://syzkaller.appspot.com/bug?extid=77026564530dbc29b854
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=117a8c92580000

Note: testing is done by a robot and is best-effort only.

