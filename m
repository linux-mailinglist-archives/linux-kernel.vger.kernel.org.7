Return-Path: <linux-kernel+bounces-876755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4A5C1C38D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E028188A651
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F25A34BA33;
	Wed, 29 Oct 2025 16:40:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936E034A3AA
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761756005; cv=none; b=K/FhRXN27XWKA28vhXwYMZcS6IxcLkJJLVqO1DuOi/lrFaxUOukoAuatNeU2Dwrw/dZQxJUZksAiIHOZTC/fOZpnruiLnFGz/PaxerUjukC5atQcbg6edGICgeZxV/o5+AdT1S34ZzVS9V8P0XbrYKSn5Ko2JKaeqRZpLlaizhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761756005; c=relaxed/simple;
	bh=j+kBxBGNIZzz/ZRCR/3gal2Ck5gzeioeOg3Qcis9Y+o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KzVoesLo7I7/BdB3SlUR9mNL9BZmNciRLSNHrKeZdP0l9VxUraqfSowwrP3oNRiuEbhhkuaidZirdhdnxNkHbdqolSXSHz1kiIdJpsEyn5Z4WZYYxwrME8ZLwdn0nrLKLntrSpZhJ03d6y50gUwiz41DsTyqH+B5SH8k7gPjnNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430c684035eso15407085ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761756003; x=1762360803;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=13VHryrqgsN0l/1Mu3YXbAnYwpPSUwl7+JcNBYSBQIg=;
        b=N4ErSbIPg+K0rA1c6AagbvvEEhezgynUHmoMSixmaLyE8MyJo+HUUvuzsPRB4doDXt
         JTyjtKV4cfv0+DoSy5W/hKtssfavTkIr9HyXdtF7saJjxszfjc9SRzGLat+CNrvBYF7s
         XxIzCXdZQRXYodrBDxIsxlHFeQG0eMTzPnOczcntPWa75CCYawlZZm8rD42swAgL/TjQ
         tvBGVPYRrylehHz02M6EfyxSSE4DoPsqMqR2x8UGaK3d+y8rk04pRhquK7ha8cNI/QAO
         N13SBeW7vRP3oAwFUtiLzUkWd7jkmy0UOQFgnfmkkDz5m1Mvntxj+olWSxSiBwNg9Bz0
         4x9g==
X-Forwarded-Encrypted: i=1; AJvYcCW+XlZwNlD8xgXTD5CBvszln7AHQWsliDokxjPtEVdAaDkhbOsaS5bmlZdROGx+ZlrfasIjPQMytB6MSxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYK4kVnV1YOwTSHL1JJpZxOgKlabWxrfqEDILzbV9dq0aQc04p
	49n9tN19AiXa0PdLSDXXlq6B0GrtInwBfL8OL/aQyjbtBaAahGozSb+V7Ps/xnXIvx+iTeYBN2y
	KhuWbb1UCod86QL/ckH0b5gNrVlxRpboZWdiOt8Pou/IAIjkFN9IiyLKKLHw=
X-Google-Smtp-Source: AGHT+IFRyVR3M0aLBygFRdvwaXbjuKVckdM1d4bIMysgZR+UxhHxMleIgxx554uxVoLpkfCg8OZga5vAfmFUeyEAQTvgtcdKrC5K
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c951:0:b0:430:ce63:4180 with SMTP id
 e9e14a558f8ab-433011f1636mr3287465ab.8.1761756002735; Wed, 29 Oct 2025
 09:40:02 -0700 (PDT)
Date: Wed, 29 Oct 2025 09:40:02 -0700
In-Reply-To: <20251029062744.Dt_0Z%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69024362.050a0220.3344a1.0429.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_commit_truncate
From: syzbot <syzbot+c16daba279a1161acfb0@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c16daba279a1161acfb0@syzkaller.appspotmail.com
Tested-by: syzbot+c16daba279a1161acfb0@syzkaller.appspotmail.com

Tested on:

commit:         4408a3d6 Linux 6.12.56
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.12.y
console output: https://syzkaller.appspot.com/x/log.txt?x=10adbd42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c2405120cc7eb82
dashboard link: https://syzkaller.appspot.com/bug?extid=c16daba279a1161acfb0
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16059f34580000

Note: testing is done by a robot and is best-effort only.

