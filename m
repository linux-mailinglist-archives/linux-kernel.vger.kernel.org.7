Return-Path: <linux-kernel+bounces-819615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64723B5A3AD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DFD71BC5C5E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7E82DE71E;
	Tue, 16 Sep 2025 21:09:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276DC2DE704
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 21:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758056946; cv=none; b=sQkAKZlIBKrO+MUgGqNdeWuPfEkktEBbr+qabyIcmW6NbN0xchNcdjuIJLsVlQNSrxUuCjO+AIQW+0iel1xoFn4VP5rJI7eHKbFvERceiK59SVBuAK3DkORzDsHg1CkMrm12PQvuqgZm8fSO//r9nWbCBisVwDJ0i7RQAW/GJso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758056946; c=relaxed/simple;
	bh=u9hWP0WFpjt51IzxkZwb2nK5JwFOhvstgM3/R7sfXEY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WpV3mjPyVpMRy4H+nI6D0gZfHjRfWKkkiaivYf1gaTaiU8o+F/Rah7rCSrrDZpcxQSNyrjeYDoSpT0fFjv+8I+0Qds2lnYqxDGlPdckaQejnjt6wf8qZFqYgFv6q6s+LQaaa5XTll0djukefRKcwKFIqjLMYL8neRc91B1EzMY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8877b84553dso633803039f.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758056944; x=1758661744;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GfG4lbmZkG7Qp0rRLo47N9r73C/n3Zu/iPEamvQhVUA=;
        b=flbiBmAm1f7NykfQm4Ym/zDEF07VKUwJVdHLrok+I62APl1QvaMSkVVCXtSLIIp+xc
         SwGze5rOWkRE+DLKrTjAK0tXZkM6xAZapuZwj1Cc2+sHOlPGoty5djRRKS5RhjPXJVLg
         tgs/9alqxCbYY6BrWu3WrlxaEpvA1jcGfwtJHb3sn1Z0w8V0MsxfESd86bxZNpTh3M9v
         UJwwR9+/q2P98+eU7oJgsWg4bir0FMVUJEPAd/uRJIPy3VdzDP+jzdd5hlXMjqVKl2+V
         NvsmXdsxj61bgfhRDy1M6Sk7/iF0JNZqKh4FjpSw9e1qJDdoU9WuY8NNrLXBtFkCUnDt
         xo9w==
X-Forwarded-Encrypted: i=1; AJvYcCW/enYv7bMtvEtNwj4uqLdmeOlp5yemezczfgjMQPq8vzF4JNiSFkPB5unl2YcwwgO29cs4aF5UpFaJSdw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2KjN+b3ZdlXS3AmvSFfj0fr2qoC0kKmkuYBJ/LQd/X2rIwslU
	CSlcMqUjd/UsG0Xbkc0kXc2dRKpdzTLIYCX5J6Tf1q7+QC2myvffndl22JsguOUrixuDl63uFxo
	LSYv9X3MAJRJP+E4HEO7yGqhneHFlFKefwKMahLYYJEmzW225csXV+4flDZ4=
X-Google-Smtp-Source: AGHT+IHyBV/tOO+HG8lGwz2Yl9K2PxBdMYf3PIdVmT2yCsYo7VP8yfY+OCO+Duy7DYABqCrH+3h5be8+URU03RPCH3Crq3XhxnqJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2506:b0:3fd:b143:a031 with SMTP id
 e9e14a558f8ab-420a53adb2emr165047255ab.31.1758056944308; Tue, 16 Sep 2025
 14:09:04 -0700 (PDT)
Date: Tue, 16 Sep 2025 14:09:04 -0700
In-Reply-To: <CAL4kbROsdpZx0V8p3imCd4s=PLQuxCg4wtDzte2Z7ik40rGgyg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c9d1f0.050a0220.3c6139.0e68.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] general protection fault in gfs2_print_dbg (3)
From: syzbot <syzbot+fa7122891ab9e0bbc6a7@syzkaller.appspotmail.com>
To: kriish.sharma2006@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+fa7122891ab9e0bbc6a7@syzkaller.appspotmail.com
Tested-by: syzbot+fa7122891ab9e0bbc6a7@syzkaller.appspotmail.com

Tested on:

commit:         05af7647 Add linux-next specific files for 20250916
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11cdfb12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e269dbc7717119a2
dashboard link: https://syzkaller.appspot.com/bug?extid=fa7122891ab9e0bbc6a7
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1218ce42580000

Note: testing is done by a robot and is best-effort only.

