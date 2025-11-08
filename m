Return-Path: <linux-kernel+bounces-891345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 71746C427BF
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 06:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2BBC94E3988
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 05:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A1C24EF76;
	Sat,  8 Nov 2025 05:34:59 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079AE4A07
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 05:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762580099; cv=none; b=mMOq6jsjlUWnOTehUVuyy7C3vy+YTWLdLvZ9K+w/1Iz7UI8nykKgiLZOp89O1cV14PfmWlWgR7PHipLPu5wZk7FswwHRarbp9mpk7tZtYg3cafm+TaX14LVY0htk6/V0YCQfuPRZGlHgQ8keWcQXQPqjsVX32Wn9jRMCMNvldIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762580099; c=relaxed/simple;
	bh=o0CsnMI055zTLsjgnelr65ANP393KdjtTq9Jyi0FKWw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TOeyW5LWFFHvN/ZYoQIUpyXqGOBK5TIr/yWzkt72celOWGcuG9r3zFRyhuWXvxIKoo5KhVrZ1XBQw7Q+R9Oe29aXaRu/AFar7k4qncZmSR/uhlEsPQs5ECxF3T/IPfccUbvckwgnFyL3/nCri+JGJkFDRz1auhonvYMsDKNDs2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-433154d39abso55657185ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 21:34:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762580097; x=1763184897;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o0CsnMI055zTLsjgnelr65ANP393KdjtTq9Jyi0FKWw=;
        b=GsVpy4E8pLOCIC8wTddqoQXn7/hNkyCKZ9ETO1p9toBSDm9qNnMBiI6DexxaZL6hBP
         IymNZIDxaHI7SIIiiIl4EdTGRBUCpjfarjgUUxj7zDBN9lwGm8l2iQsH86M0HAKuHcFZ
         LTW4zJ33Y/P3Bvrh3KBDFJaxPmp6Pbj4yILYva7RL+FDeKYo/IVMT7vRW1p9w5S5L7ys
         MGWmWTLKP33XcpLKhm617CJqvK9Bk+zYDjPoUCSMkSLLLKsB+KQ+dYTd1eTRcHbTXboK
         zfT/fUrHEA0/PxIcmWnliKRbPEfW25dc9iL4ABxP0jk23RWnbhsMwarXARoFMnvZS+CU
         u2eA==
X-Gm-Message-State: AOJu0YwlahWR1eo9oRuREqK+to1DnnE+wiKf1oyURgUvWez4TOhBFFXw
	swyYUElI0MY3c3gpadD5IF3SdZmfDZWenT3PqTtkbjjPUkWhgqP4kv3O7TSWiYmHKC+nW8OJ9JF
	VwQJkCwvSUfDT6sJuKXcsAR7ADyLSmsF98tggXKUOhZcZw3Z7ryT9K/F7vvw=
X-Google-Smtp-Source: AGHT+IGOA4YpYC3YrDJkRcOTGB+9d8dP4XGr2jBtReGq9pLEK4GvsLafrSJLT7x/reTs/iikav3iRb/H7xowlLk7B2CT5zZL214m
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:32c3:b0:433:2b27:b6d1 with SMTP id
 e9e14a558f8ab-43367e8eecdmr28407375ab.23.1762580097151; Fri, 07 Nov 2025
 21:34:57 -0800 (PST)
Date: Fri, 07 Nov 2025 21:34:57 -0800
In-Reply-To: <68ddc2f9.a00a0220.102ee.006d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690ed681.a70a0220.22f260.0073.GAE@google.com>
Subject: Forwarded: potential fix
From: syzbot <syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: potential fix
Author: rpthibeault@gmail.com

#syz test

