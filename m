Return-Path: <linux-kernel+bounces-740088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 419AFB0CF94
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 04:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9313B5420BF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 02:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891BB1B95B;
	Tue, 22 Jul 2025 02:15:26 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BFF14B96E
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 02:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753150526; cv=none; b=c7vYVxu5PGnAm0xM7AQOGCLajyafCLvWtkg/rpn/ZqlhBgKtWrNKpS7Jr3LYyiM6FJyFrSI1qQKhvTCjhdrxW6uOe34wIZSEUU3Me8zRvww1puoNaOP0fzQbjdSTGokSLeaiD3dnn45QS58AXLIljqoNNZTfh7OjCc6AhnFQgXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753150526; c=relaxed/simple;
	bh=IBz5yWgspgvTDpdFgnMtSGA7VasyhQ5CMK1wJ9uig1w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LJ4kCl+LfR8RN2bbLMRFAI2oHE1A6QsvVpy+jMFnwblNcmbs8n9hAYst8LzKKn6nZ1sCodhs4Yb/nQLkcXb/u2L28v+EDQXB9hOGYa6jqVpG3F8N7r8IyRjlMOnbXv73XFp2SJ/MihHo5ZTBiqyehbsogk4HWpxfq5Q1PlHQxcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8760733a107so562804439f.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 19:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753150524; x=1753755324;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oC+tMWLf7s0QarSMYeWUJ/jfewKO0Yol/AWciU7ZdVs=;
        b=P1UdHITp7SH8l3xu8UuqPnJA6MOulomEUwOqfpsOgaVfnrT428xtCxrxqnmahVgCjm
         kzY07bFH2t+ZYQwImcpKXoQagOJ6FWXu1SA1ZEmA15R7nnkrL/115OIi5AbEwsdKVQ/K
         TYWf3eF1LtBZyTgTzeezhFKtyYkuooL4r6stK/gECApvULPieyLzaeCf8aNmRkKeFqwX
         2skHLyYwMKRrcvWLstnP1OE2v4osPhrvHksO/fzQi14Qvrt/2yZwlJ4A78opK+FyEOJk
         iVa+yxJrD/OmzKJYvMEKxo7mJNf0x9MgHBb73dpwxMHIhVN8foCoOuWF7q/mPYMIhLff
         NdNQ==
X-Gm-Message-State: AOJu0YwomGK1LCkGEONXoiwW6WbnhIQv+0LWyJuO6KfIrPievfsUzUkb
	oKJEOXTOkIpLCooEMWpnbGtj2sPEh9C3HAw8HlIQwjBDM7PYfj0vq2rZ+r3ZVp5f8wEGXZ6PuqS
	a/GovFAOJDYj+FoKAcOfmQEtrCY8H+pkh1ZJ2Ry1dYP266UsWzxEGCdHK8Uw=
X-Google-Smtp-Source: AGHT+IFVi+TrxxLrGqMtl3hZkRku6cTTKDBU5xUwfMIjXt1WHLTLeBjZT3Tt+f6fvk4FqjTzGv7O0AQbPAX7iWhBSddQKNDdGMPd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:751b:b0:864:9cc7:b847 with SMTP id
 ca18e2360f4ac-87c0f409cb4mr2197413139f.14.1753150523945; Mon, 21 Jul 2025
 19:15:23 -0700 (PDT)
Date: Mon, 21 Jul 2025 19:15:23 -0700
In-Reply-To: <67389a73.050a0220.bb738.000a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687ef43b.a70a0220.31ebea.071c.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [bluetooth?] KMSAN: uninit-value in hci_cmd_complete_evt
From: syzbot <syzbot+a9a4bedfca6aa9d7fa24@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [bluetooth?] KMSAN: uninit-value in hci_cmd_complete_evt
Author: ipravdin.official@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
	Ivan Pravdin

