Return-Path: <linux-kernel+bounces-894181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6BEC496D3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C10D34E996A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 21:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A9232C94C;
	Mon, 10 Nov 2025 21:36:21 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF462BFC73
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 21:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762810581; cv=none; b=H/cYj0bnAUgAvuEZSQK41+h473fxpxaU50RvoMDnhMgQs0Qwb/KRQyPErpqYw166x1gNXv08yu0pdqO7yKQoMAYcDN8lgoRGAPQzHhNmxM/z5z4+dHXeKgycVPopBKUZvqvuUWwnMlFiImhAEB1bEqMhqkmnPKgEMvUxnMHzqHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762810581; c=relaxed/simple;
	bh=0wQTgGrNNDVt2uFqYthktj/TJEnRI7WLaEb/wyTxack=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Xd7MG4E51mKoisLMlbCuHYNkbEu616ZX8D320lPothTUibtB8qb4OGPL/WN+c2uzoX6Cwz/ccb4D6F1SOvWVlgc1pzKZ73posDY37nIaTYbgpnKSgx2+QYSapNar6vlEzhQbljo3EMufSPis5eP5eQDi2T62WZNd6GM1cyHsNo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-948a2f950fcso169833439f.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:36:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762810579; x=1763415379;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0wQTgGrNNDVt2uFqYthktj/TJEnRI7WLaEb/wyTxack=;
        b=O1sCM9MyoxLYZIndrHanfYX7YZu6Zaqt35lkBoVuhHFPsCFO2tKJQraJHFNHZMjJmr
         eZld3T1gLOwQ0Sab5lCvrwEGlk4l51tc4Cyn9dpGKyr8TKpqj2ddzOv66uT++EZD5wCs
         CynXh6aNGmKAS7chd92/eevw4kp4E9hcodqHqyj5QB/uWiQX/O2YBYr4fiQCSOlFQHo3
         xbTcRLB4cuUIXNW3jwzkCSurFcT9dKZ+N7Yy0qqx/CFuSmlHtp2UdTEjjce50zY463fz
         w1HSSkuyXVka8ukUk6TX/3nCAfCCcsp0c/mNQThn2445C5maHqDUaFCcJHUeK2adaytX
         1QOQ==
X-Gm-Message-State: AOJu0YxUyyNBXN1RCa8dbmCSJZbUpLR5d1pwY4Zbnc2BgHj6gnuueayK
	jPFSXXcULCvAoN8OpHl5CDQ2rxqfjPMl3VndTKz3OWwFhYn/aH+zMh8aNMpSKhH6JYTNZS8KFfL
	yp7cPU2k+KZ8B35koBuo3+L1F5ra8PixVCX0cvPVW+uUqR0lcQxg73rv61Kg=
X-Google-Smtp-Source: AGHT+IEyZaRyfhp2japiFG5idUQyGGV5eABQ1KfjSYtskTDRazkD09VXo1QDBWkmgn0lW2r2EBzPwVfI9R01dJQhyVbk3v8LAFe3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2708:b0:433:2844:111e with SMTP id
 e9e14a558f8ab-43367df3aa2mr143698675ab.14.1762810579249; Mon, 10 Nov 2025
 13:36:19 -0800 (PST)
Date: Mon, 10 Nov 2025 13:36:19 -0800
In-Reply-To: <68c58bfa.050a0220.3c6139.04d2.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69125ad3.a70a0220.22f260.010d.GAE@google.com>
Subject: Forwarded: Re: kernel BUG in ext4_write_inline_data (3)
From: syzbot <syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: kernel BUG in ext4_write_inline_data (3)
Author: albinbabuvarghese20@gmail.com

#syz test

