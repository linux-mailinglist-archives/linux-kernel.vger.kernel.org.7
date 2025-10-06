Return-Path: <linux-kernel+bounces-842564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C28BBD07C
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 06:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8FD813483CA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 04:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304311C3C1F;
	Mon,  6 Oct 2025 04:11:08 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFEB3595C
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 04:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759723867; cv=none; b=dA1IWGr9eN6oa+Mq8fRSYKP77d202NuGOQMKpXpiTwNdjD5At13OBCPCt52HbkHwV+OjA28AB0YswMwV23iIOIwnsKSHMU8m2YcIsz2MOW8m0JFB8nBZfWYBj8Em+W9+lOrdV+UONXL5yQk+8Q1r/w1ryfRFJOVy+TgogXiiSyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759723867; c=relaxed/simple;
	bh=VZyjs+3USMlWDqfZlsJk1lDMZQX6ofjl87/RS5R9Y4U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=q99uFAnXWzOgM/rwzaGNCzfWqAEK9Dh6hfhpxCfuJZI8MoEiPW0u6BuT8sQPhvQ0QwKRBVg+WVmbKeCsv47mrDsUT2vYHuYUHXTcf1WPr/WGPvU9YPMc/O6VvR5mpIP7BGJ2wjsh+Q5sqNky2mswmJlYH2TZtfr8DoF8VuTGLsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-88c2f1635e1so437443439f.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 21:11:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759723865; x=1760328665;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XDiw9WVl53v6BHLMc3f27WbmqoHZFSlIIbdmqdNv+0o=;
        b=mAuxlXYLhuitSZeVMLtI7w1EXlSLMtB8i9mgS758IQF/MwbwOJecXu8SjgWeBA1v1y
         JCaMx5IIvwY/reaRthutzGoL4QnxabAfRTWDLo08RfdQoWs+Hys7wDU7vX9gChq/YuWT
         7VFL9vW+BO8hJqH5OMSibO4PuWbuQWrVfkwVemtuMuKe+/gHHMleM8S0TmrPdm1ag0yX
         5UxjcjbOM26B8OoIvfThwtjHPmyTlfD4D4uQFUV3HvR9KlByNg+oTK0Yrw5zkFBTxi1N
         ZczGbQed2aEEaqqd/QO57apqOzOXrP1Z3R5oCuM5T0lCFBMA174hO/AOoQrNwD0c9+q7
         CM4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXEbvwHkAfEDoU275X3JNnCryGqzqGWLqWy37KHIIKRff5017l9/ncQVlkM9gUmPkf4gwY2IMLfOFn2qq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbUswtVBVZOARpRwIGwuzGaqrXJ4jdYbPy3heHevRjQ1ran/B9
	zybtNdk/0BaafZ4U8Yx87VCQ5WaW5BZH/PbM+WnA4uTJWSa+Ji5/clnfE/s7j4yMvGi9jcYWOb/
	ydX3OX/lRHU85gxhHiXdG3wxR0/sWiB1QryTy5TDj96srUn+AQ7vgz4gLFQY=
X-Google-Smtp-Source: AGHT+IE8Ls6IvJwjwYHxKCqdGX70VLaq+H9kF7MVUCjhkfwrI0I/XtLnL3QcAa4ZlNhTOQ1ixNeigkplXxUziSwmnmicaCmmt24/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:7407:b0:91c:fcd:88e6 with SMTP id
 ca18e2360f4ac-93b96937759mr1485881639f.1.1759723865475; Sun, 05 Oct 2025
 21:11:05 -0700 (PDT)
Date: Sun, 05 Oct 2025 21:11:05 -0700
In-Reply-To: <20251006032505.366466-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e34159.a00a0220.2ba410.0020.GAE@google.com>
Subject: Re: [syzbot] [exfat?] KASAN: stack-out-of-bounds Read in exfat_nls_to_utf16
From: syzbot <syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com
Tested-by: syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com

Tested on:

commit:         7a405dbb Merge tag 'mm-stable-2025-10-03-16-49' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1436d092580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2b03b8b7809165e
dashboard link: https://syzkaller.appspot.com/bug?extid=98cc76a76de46b3714d4
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12b67214580000

Note: testing is done by a robot and is best-effort only.

