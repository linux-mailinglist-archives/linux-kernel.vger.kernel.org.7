Return-Path: <linux-kernel+bounces-885385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8150DC32C20
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 20:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E42EF189FE18
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 19:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BADA2C21F9;
	Tue,  4 Nov 2025 19:22:08 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557692D0617
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 19:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762284128; cv=none; b=q54qhvwKyntnGXTycrZkgxIqGDizK81FQhcEsGf7wE5Pu/fNkxg7gj3BXdLloaCeUVrMmqPIdieBsZ+QYHyPu/O7c0qpt3o2Lev8WFRsoraq24OSKRNIT/a8QcIf2j/3ZDO9/564Zp2CljxEImHEC6XzQVbWC9b1j/jo3hSH+a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762284128; c=relaxed/simple;
	bh=y8CETgN2e3NXKyFCJ6jwg8dfapPQ0vBem+h0l93QyFM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MGKV6qDmbwQOEPS/LqkyDbroPFTP7hCRYGJn46oxgPyOOSwm7n2vYKoW0ueSQERLhte6YEbvFoJhk8QbRLsbcIQkI3Ji8yJmwBzLPs/j/qQFkP/BbHQ/8Rf+7ZmGaie3ItVMJxjekLmL7A73JFuqM/LHy6neM+rcXkvvhLqcPi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-940f98b0d42so1781780739f.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 11:22:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762284125; x=1762888925;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y8CETgN2e3NXKyFCJ6jwg8dfapPQ0vBem+h0l93QyFM=;
        b=GZd/0Ppj293OQ4DFwRFcw/59tRXZQFTiq2ckaceCGuNZ/ISEqubozYyBmYdvLnPZt6
         m1KqMsWnfGCCYnzWVxf1gJyl6znXSf6rvONnbXU31btn34Ng835Z3s7z2uYu/lDw0APd
         1+KLkIT4KVeL1aGdWs1ql2jsDACscqM4wqbirYSNFmTdXVyYd3Rv+K+IBT8WYr42TfiR
         a7+HXqUl9Mw1ke4SgceFYKXU8xplHeKJf+tAJGuLnvqFHw6NgViPMi9HwT5aWIkJAm+j
         0b6vobQX8Tk3EQCpzvnUyEVYSDAXS4a4K0OKvRnPFz2B3QRRZmOsAHLYe4aLpRO+N9uW
         Be9Q==
X-Gm-Message-State: AOJu0YzwF+x3ZgX/PBcYj7pWYePmQ5T7Zp/+7lA4TlkAJ7g9z5MlXxJW
	mcsK3YXc2+AW2iLmbT56RpIKZe0P2BM0OIVl1/Bf+9PM8Uxto3791wlKhKOtO2bNdSJfiG5uyiO
	klGB5MDiGLsPoDSt9VMI8IqLFH7wnBAs18L4DrqJYd3dmDxZIZHFoEGKYck8=
X-Google-Smtp-Source: AGHT+IG+1pvRZ3fJ8L7cJ9I1DfaYnG2EQJDcIU7bznvPabPq0yrxpxgHglNzKoSC8LV7E1OTaNFXpLj8VyuR0TiqiafzzZp9SZEJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3429:b0:941:a80:7ae1 with SMTP id
 ca18e2360f4ac-94869eae904mr91601939f.14.1762284125410; Tue, 04 Nov 2025
 11:22:05 -0800 (PST)
Date: Tue, 04 Nov 2025 11:22:05 -0800
In-Reply-To: <000000000000a53ecf061f700fbf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690a525d.050a0220.98a6.00bb.GAE@google.com>
Subject: Forwarded: Re: KMSAN: uninit-value in bcmp (3)
From: syzbot <syzbot+0399100e525dd9696764@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: KMSAN: uninit-value in bcmp (3)
Author: kubik.bartlomiej@gmail.com

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
master

