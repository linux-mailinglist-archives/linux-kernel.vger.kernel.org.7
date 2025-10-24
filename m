Return-Path: <linux-kernel+bounces-868832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F38EEC06430
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BBB4D4EFD6F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8BF3191CA;
	Fri, 24 Oct 2025 12:31:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341F230E0D0
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 12:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761309066; cv=none; b=T019hvA1pUTY5dOPvvMUJrTpt9s2DMLqyGXZTqrEcU9VH6zsNXh4VXE8V8rAdlp7Fp7vxHphGIm+0AIYd5uvDjr/ubbVSYDydIoFyoLMs4TizzArEMSyDb/mwXXdhK/PrToMxt/RIMKRW+F8A9u7jyfk/2j1d5o1WMwCkawJudo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761309066; c=relaxed/simple;
	bh=QyTFPsJkDI5GpoB+DJmqdR4TCywTQpDTTI/wtnCPc8g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=p76L6gMTllk7GDXIjxtNBzeUEPYgKmUgjSCeZ8nOehnsUY6NngM8bUEnXEz67wf+N6r5ypVlvJ9iIYruCEgr8AUVG8wkUpHYDwJ4WK2MPwJM9g1/AuiW348eC31OMjJ/ZgbDq5IMkcqbKQWnmYn5xkZqkM0LOwUn+wjPMlkm+zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-93eaaa7435bso177631039f.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 05:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761309062; x=1761913862;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fb9Wfq6QoHJKFSw9JBezoKHPd6ZFPkg51aOEjN6bte4=;
        b=pt+wwIQaU3hlCwLBBHI9dCBEULyzhVtZNcMzWEtmudTaemT5U6jabiuP+XIR9bBCcH
         AHQuoS89+iqdumjGSm4Ob7whqGYojU2scAIwidcMHIoyLgbUE1YThu82qO3QyYJEe9BM
         AiqNBWWdKsogJ1fvy62hmbt3f/xApF0FpaQAD6kv/zxb2FcdrQs2JMakRIjBTxUFuok9
         IPbkyMKg7XRksVPAqlqH110jNu26FNGKblTChcJyGyJI/j7qbrVQrDb+m4bTqYdDiSQw
         Io0hlVRPvGN4cuvw8rlYfQ5j1L4OoYhFnSLAqt6McQ7fAQukyEc/vJriBaOaAv7Rcu1r
         Qqlw==
X-Forwarded-Encrypted: i=1; AJvYcCVNdnV7EtQvr8PfDtUaLCiG5CK0Sw5z9kyToGPu8EkDWHzZmzn30ZsYX/Q+LdL37LtE8gF+GK+9pgbk6rs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiJw+WjqWPTSxW0Dq05bliYajeEgh5VmqWTdkGvozXIW1FG+MG
	Zokb3WCMLStiyVmqMlAKaCKwoDbvUZqI2HincecawrThMlMJNbex9WWOOV9931t/M+e3qDadnmj
	f/rv22IgVmNtR0qOqy/T5kowthUwfcJEuTIt8OKdvrZptOJAjAGyow/KmM4k=
X-Google-Smtp-Source: AGHT+IHLlm5v4l+lh22gZ/4F4BTwWgt1Y6JS7tTLewkbfln0+HkC4n8iHdyFkV8CLuVR/h/vAkYpry/EEjcOYMynWLmWZ1vleCLD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda3:0:b0:3f3:4562:ca92 with SMTP id
 e9e14a558f8ab-430c525f520mr199237815ab.10.1761309062222; Fri, 24 Oct 2025
 05:31:02 -0700 (PDT)
Date: Fri, 24 Oct 2025 05:31:02 -0700
In-Reply-To: <20251024071519.Hoge8%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fb7186.050a0220.346f24.00d6.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_claim_suballoc_bits
From: syzbot <syzbot+5054473a31f78f735416@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5054473a31f78f735416@syzkaller.appspotmail.com
Tested-by: syzbot+5054473a31f78f735416@syzkaller.appspotmail.com

Tested on:

commit:         8e6e2188 Linux 6.1.157
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.1.y
console output: https://syzkaller.appspot.com/x/log.txt?x=11e993e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3fff88b67220f824
dashboard link: https://syzkaller.appspot.com/bug?extid=5054473a31f78f735416
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=174e63cd980000

Note: testing is done by a robot and is best-effort only.

