Return-Path: <linux-kernel+bounces-874528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A830C16837
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45B341B28C45
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFF234E75A;
	Tue, 28 Oct 2025 18:39:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F391418C31
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 18:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761676746; cv=none; b=r6+/bjBZOH/xzA44zqQn0itFXFkur9wlAcQrNVFjjqtqS3dw1uNpp5ehvtfeds+xcsRDdYGeNp1Tezf2e7TFgYNSGRAyQA48n5t+L2BatlpPsr+3VQtResmSd2VLv+RxjYMzUDVhPbfkV5epif17/vO6/kqFZXY7nh+TSc2r5OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761676746; c=relaxed/simple;
	bh=eQTpfE+bt8iV5LlxSAileX7P/aLJWE6CI1VkBfgCpaQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=L333To1PAdgx9cEb2iXcVQw5SIRlImaPwvBYq7lFhORo3khP9WD7ItemNKex9dfpERmaWhRBI6nt/xeREeOo2bH32Qc6H9whZAZ6pC4jK8SBtZ4H0HWclZsK90BPN7ImzJa96lHM0jspwyNRj3NmAE2bdU4n4KnJCpe1x/if6c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430ce62d138so79010845ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761676744; x=1762281544;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6AjENQ9WSBFUQetSq5NxMlv9nLRMzU0A4v7pFRwVXCA=;
        b=W4Z2kxJtQUjFaR+V3JoriRLm+UORIGPhtGp4CZwxD0fCE8HpVrq55uqtvrfAPjMnAh
         ZpNv3Oks6Zmq2JlseNngVvK/cjNcOtJsuIgaJC+8HZZyV1yAQC8b/F5qBYa8t7WdbYhg
         SfpoK7+pBNmn5w118NFCyatg3KQMgDcWVc9JtNMwgdNTzt9CgcclgN+/DN2tziKOKWNd
         Fzq2fdrrunv6Vh2B7WG6PlQbmm/50HBgdLXUSuPGhduffw3mwBsQ13deWk6L7jMMFNUb
         gylndx+b0vonFJU3kWQ1y1DPgboD8mvWBG/+G2p1RK0dp7z8Xp/TgsYSTers6SRN7ldt
         2w4g==
X-Forwarded-Encrypted: i=1; AJvYcCWsm9RVKQBUc3MVMHpbXIhjSV8jORn9L8B7PUsLUr31qfRcnmZdmiYVIbxQAKpyKh1NkqIDEAGP33xK1wc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN54QRQqsHC10UKb0/85zzFlZQRgMPvuhsJ48QxMXuvLCB4s1k
	jqut/BC3KUJO/w6Ygurjuzpt6mYzAEDnjj9FvQm0TjSeaTvq05Tf3j4BAh761RP4FKWmKS7w/Mq
	H5H4EegRKFV8v7U8EPtApTb61+DikIMmoeh29S0obIFYb00zVB1bUqOBekHY=
X-Google-Smtp-Source: AGHT+IH0EC4VfYmgggYkbbrjRfbmPiz3HRB4eoXg+8dvf+L20seeMlzLVSNdlK1cWJGVIDe4qTXE3YOmpQl5Qh0H+X5mlDUXze8F
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3181:b0:42f:9353:c7bc with SMTP id
 e9e14a558f8ab-432f8f81ba3mr3462185ab.6.1761676744122; Tue, 28 Oct 2025
 11:39:04 -0700 (PDT)
Date: Tue, 28 Oct 2025 11:39:04 -0700
In-Reply-To: <20251028181939.4hTbT%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69010dc8.050a0220.3344a1.03d8.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_truncate_log_needs_flush (2)
From: syzbot <syzbot+c24237f0eee59c0c2abb@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/ocfs2/ocfs2_fs.h:474:40: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:489:40: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:502:43: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:646:26: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:659:16: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:807:37: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:943:43: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:1030:39: error: expected ';' at end of declaration list


Tested on:

commit:         d3d0b4e2 Linux 5.10.245
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-5.10.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=b309c907eaab29da
dashboard link: https://syzkaller.appspot.com/bug?extid=c24237f0eee59c0c2abb
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1289dd42580000


