Return-Path: <linux-kernel+bounces-894366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA47AC49DA7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 01:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79B7B3A1622
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 00:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EF917DE36;
	Tue, 11 Nov 2025 00:22:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA5016132A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 00:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762820525; cv=none; b=eQEINZKEMTEcwRTIPM7w6sOBxFJaZ0iawtEv/yszyPJGEbB+hZhTV/dPusFeSG8CIfYLeX8J3IYpyhjpmHOZeo0hqJuXlyogigMs5CpqH0utCb4+QYrDczhK16JIwBahAxeuFNIuSswf4fLBleF3yL1hrho/394AA2tVFkB5I3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762820525; c=relaxed/simple;
	bh=Iz9mP0ENlYhS2Tp92Sc8VaRj0FtbZd49XUVrzCLzUrs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JPY2cOpsDPXtE2SO12f/kXNHJGFYkg86d45Txe3pyDHRrnC023vo0AMJ/vJLytI1NFPXuyi64/MlWj2leweenRq1MKTy+xg3p+6IyFnQ+hZfXZFTtGWQEkob/dcR69+ZJ92vn/XFPmPWVXV4YeufTutQy2AZakSBBjlmgtXoPjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4337b5c3388so69918595ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:22:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762820523; x=1763425323;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1jTaQo/Z88lb4ipSYNqXW5L2hKruWlKS8HEKlvLEFVI=;
        b=A7pjFOt52P/AzVbPYKs6ggkrAYrU37V5ywljaDuqPkbN8tBbU6+swp3AvN7aNx5+vB
         dSRzJZ78vxcVeAv8lgo70nfEgZGlpNRJXl4WfJnFs6h4lD1BdVJSx2xiPH8PTTVCe4Uf
         OtM2M4ln4L1vFBrT5LsoZ676RV3STtYIbJWSuM51ZjF8WEiJIiR9F8jNbKBkLUbTOP5O
         7oMNw2WH9dZY7Cz5zPGLsCovnZ4teEOpivFvzDKtf/JbAUOG6g7JW89RXoAKGVpV9Qrc
         PmOp9dhdMNWUiGpbUI9V601bqRI12ObSlFAgYU0WkwWhCXQGcSzcRgzvRZaVbUo1ArVh
         QePg==
X-Gm-Message-State: AOJu0YyFFaP+kfki6rieERmMhVtigy8muxIzpbUV8YqbRQp97fpIBbUE
	6FUzeBGu+gEDrVn12bDT+c2WunUgzekSX4yKDeh/25RVLuNUhmzn7JmjQLkLPofE3MWodV8QW0R
	qyA8pF/EXVgEpHKzkcL2VBAgpdI2/w8bqFm5R9TazAcwwHjolZi6xt0cWcJk=
X-Google-Smtp-Source: AGHT+IE4GSPCgJ9IY87Vk5t5aHBC3DnYa94fVr5HFtXXIDKg2ZH9AW9fG0EVlpBF867ThqlUiDjX7r9rnzgypkrwqvFXu+yDgL9H
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2581:b0:433:7a7c:e29f with SMTP id
 e9e14a558f8ab-4337a7d0856mr82158035ab.21.1762820523438; Mon, 10 Nov 2025
 16:22:03 -0800 (PST)
Date: Mon, 10 Nov 2025 16:22:03 -0800
In-Reply-To: <xgynmmyztqi2kkzhchyzgzd2clszohjy4vinzb2ij4qyvdz4mc@36tdk5l7bq5s>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691281ab.a70a0220.22f260.0115.GAE@google.com>
Subject: Re: [syzbot] [bpf?] KASAN: stack-out-of-bounds Write in __bpf_get_stack
From: syzbot <syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, listout@listout.xyz, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file kernel/bpf/stackmap.c
Hunk #1 FAILED at 480.
1 out of 1 hunk FAILED



Tested on:

commit:         f8c67d85 bpf: Use kmalloc_nolock() in range tree
git tree:       bpf-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=e46b8a1c645465a9
dashboard link: https://syzkaller.appspot.com/bug?extid=d1b7fa1092def3628bd7
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=114e7084580000


