Return-Path: <linux-kernel+bounces-891736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFCBC4359D
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 23:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 185DA34880D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 22:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0028B253B58;
	Sat,  8 Nov 2025 22:43:13 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA5219F137
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 22:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762641792; cv=none; b=GRdRjylaylArv7karaezmR5wm2IycjLJ82YvaM09Z920IE1KVFFXpnxSXzmJnFDOy138oJrHEPejEaqAWhEt/BIkBxZJPkAtAXvkaqyb2Di+kNwt7WiQoVkYK/GUVTcvzTN9u1GFBLvHTDecb3e3Q95QUvr4+M5ONNrCeDY3PZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762641792; c=relaxed/simple;
	bh=xXnClfWmoANVW/YPv7VYGj2LhqtPDXTB1KIVyhsieAo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jGLf69Zq/tDWr2XhEhaB2cpGSamzJO+icw9aUzqaFBJ5Q5SLeuTlknbXZw00Z3Mc0z2MkN74f/n0jQXmxnxuTv+zXjeDAkCrZ1ufPiPxWECph85MHss67iiJuQNQzltNfT5NnVH4vuooY9qF3Wov8a1eguOc/4fESNgUoF9N2YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-433770ba913so3628455ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 14:43:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762641789; x=1763246589;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xXnClfWmoANVW/YPv7VYGj2LhqtPDXTB1KIVyhsieAo=;
        b=B0ewIHrFZm9rxIkiICbNopiAwWX4kpwHXc8QoGd7AWwC+pRRpG6FZ9zo8L09Nx9Wjn
         uvCdpC8l+MNMF2GkuGjpX9WTuDhHnR/nhd/q32yVe4uopZp3p9hMc0zIBlIjyT3xrLOu
         jgRTiddsy0D0Ls6cTkmju2odN9JDFvT2LstIhIlatzGqthqRZPMDTWcltkC+Eg2YGF/S
         fUWlHuHzIsZ5yjsHJZywJdOK0PTGptIuInCLkCtMwGPmyCCqoXTKB6UmIAOmPBoFGUFa
         SsEgq4okXHWaEZUXI8BgNv9009utggm8nYz+0s59kNbo/7D+9ZFx+Z2cQeihAsTF2VJo
         oTOw==
X-Gm-Message-State: AOJu0YwRhucpNa4vnozRiY8/ryk9vg7viefeQY+wiUNt7BwMPVk1G2ZI
	LzkxwLNV5y9VFP+qZZeYaFtNuXe9DRZ3fVTOaQzEaYigwMAFkRmE/DvQPYl5brMIlmTqYlMM1pT
	GCp75HT/Nxc3ML3BheSJzGrIYFqfNZIh91ULh7g9HQ10Je0Syp7ZmSaoHIeM=
X-Google-Smtp-Source: AGHT+IEVr455meKSMWE9LTLnPIcc5rVHzdye4vfEkqq04mBcP0j1YlPaMbA9barsBxyXCYfnr3n+eCzaGAWLrIqUg5ePIShwNfw1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2286:b0:433:58b2:65f1 with SMTP id
 e9e14a558f8ab-43367e38c20mr53275725ab.15.1762641789287; Sat, 08 Nov 2025
 14:43:09 -0800 (PST)
Date: Sat, 08 Nov 2025 14:43:09 -0800
In-Reply-To: <690da013.a70a0220.22f260.0025.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690fc77d.a70a0220.22f260.008d.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [gfs2?] memory leak in gfs2_trans_begin (2)
From: syzbot <syzbot+63ba84f14f62e61a5fd0@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [gfs2?] memory leak in gfs2_trans_begin (2)
Author: agruenba@redhat.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
withdraw


