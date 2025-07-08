Return-Path: <linux-kernel+bounces-720752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D47A2AFC007
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 03:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28B6F16A6D6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 01:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C445C1E521D;
	Tue,  8 Jul 2025 01:32:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75942BAF9
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 01:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751938326; cv=none; b=SJrsccrlfaycMY9G9/matPywQNyPEO1ah2IU3THnI7JMlZ/uewvQXyeptiEdVNcGtSvOAwR/AtEl67hh2AE4O5DJpWey8ljUnYA95+mMxGYaFqzK7qIxhRHzEGuzR0t1R7TrJs+HfDlnDoMNIHxJsB7HF6uGiSDBq2QP/lT8k0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751938326; c=relaxed/simple;
	bh=frVDOwOWJdwlqoK8B2tKFj0Uv2xMhu5gYIpwjOFWYMo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=N95jnpmSq8+rS+izIaFhasRZsh65BDBI6pjKvTXA0BRbZoliuDw9bSGTC0m8hP2yHXI1Q5zUs3efD5WZ1FsdGNNqnoDhWiEmqXdWaKTX50VknAh4HNvmCucPMpKglF8sGVaVFdXnuSNRbGdb4Kb95QcsmgzG+fddBwosBd2t6Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3de3b5b7703so20536495ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 18:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751938324; x=1752543124;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=toF6CS4S1Ahy0FKTOByu+Nh8IeE3r7A5Ves4DOihvzg=;
        b=BYGQLIKBckbPY/PUMpw7lDIFdYpVc8j3YkQ3oMuL+aG6CmVZQlap2R/2RhuB9sOOgR
         cEt5saiSEVzh6XGRbtdKLBPKQj3/eNoTAa1Hy5edJFSHlblZINeNN3SKQxuHTypYvICh
         JfNAgDl2q4trIqTOpPlNhcY31cpGzxWhNrvnBxqoPzZma4gkCSHaDeM8WRbNAMOW1QlY
         j0f/B+Ha2S8AMFBWR5Uk7EYvBqCzlm/Hf5lSflVUYWrrj4Uog4hPjtTCV8qxEe2kl93O
         AW4NP+eJR493vWvcqhlO9Ymm2+jEBYep3k7yhqZaf+gzPBz+1tvN2PwDVLCuXLgZ5MHJ
         6toQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJZ4Zg3bwETfBxlw1RZlWM0KJpX95l6CiB7PIugSMtd0aYAA01PHXxsFmEQ3NDHDu2qj2fpdxljZlTQ/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT+n4f4zY4DOUt6aR53Qx959aho/65IgubJlXDg7+s8QRVBJNM
	i1xHjKkiNkSBs5iz7gQtSBn/n1QR7eSQrk6lJ5PyoTK5UkpCXiBCJO1pXvN+/y2tlQVL6wkjBFw
	8SN2k3PTi++EujmdYX1TTtBFmQ4U2DUgYujog6eaoanjtztP4tWOzMsr/7YE=
X-Google-Smtp-Source: AGHT+IHGmBGsEfEqsZhYHpIYYj2m6cpIuKxktIX4M73rwPcOp+y0CF6goYvbhwmz8WD9ngcCSqY8lz1hA4zC4rQnOnaHFAwQtK53
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1949:b0:3df:2cd5:80c1 with SMTP id
 e9e14a558f8ab-3e136ea27b2mr138368055ab.4.1751938323851; Mon, 07 Jul 2025
 18:32:03 -0700 (PDT)
Date: Mon, 07 Jul 2025 18:32:03 -0700
In-Reply-To: <20250708011144.2840-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686c7513.050a0220.20334d.0001.GAE@google.com>
Subject: Re: [syzbot] [kernel?] INFO: trying to register non-static key in waveform_detach
From: syzbot <syzbot+eec47f88bae8951c6afd@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+eec47f88bae8951c6afd@syzkaller.appspotmail.com
Tested-by: syzbot+eec47f88bae8951c6afd@syzkaller.appspotmail.com

Tested on:

commit:         d7b8f8e2 Linux 6.16-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14292bd4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f6cfc97245100778
dashboard link: https://syzkaller.appspot.com/bug?extid=eec47f88bae8951c6afd
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13279582580000

Note: testing is done by a robot and is best-effort only.

