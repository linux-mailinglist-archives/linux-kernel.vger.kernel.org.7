Return-Path: <linux-kernel+bounces-817497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86062B582ED
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41B1F3B2629
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C582C28505C;
	Mon, 15 Sep 2025 17:09:19 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC46129B205
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 17:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757956159; cv=none; b=XUuVwJWzG6xOGgim2OhPDJTrH4xARNKt3txd066mJay93nYzmbz0LFbuUD6NJuPgJZ9yEBvyGjeCT6jD4LeNr3Oknt4ZwpwrI6d7lbyvfqegqxOpIr6tNFodVY7pubuwLqIC3tRSszUlWqkBBql5fwGSEzBoI+nf6RwuGHERfVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757956159; c=relaxed/simple;
	bh=fHqiXY9F30VvMHnjpTF1syx8dF7v4pfl9pdm2FAfsNM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=c4jqI0L3gafWl/V3liW68dbX+25JC6+wzjGZYT0Ww0m0AWbHDwWb/2sOFBg1LUsdOj4pkK2uqKygphsTkxHjBBFVRDk1djazKI+1K3a6qHW2cJwsggBkHI6jpM6sln1Y8PKHB0++PR1YJ7TwaiflJmiZjLBsQKeRYbSvTgFS6AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4155725a305so60275095ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:09:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757956157; x=1758560957;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fHqiXY9F30VvMHnjpTF1syx8dF7v4pfl9pdm2FAfsNM=;
        b=LDxvasTxebZ6sQPz8DCMunb8CtPGzmwVbfcx80O83zEJgZALeoKh7QvxVkKxaBUkPX
         3JVobWPyR6447gp57RNp2b8h2O+YADEFcKGUuUy0GU5YS/NA2/K0e2Gs7NPU9FBKljnl
         H4jrUZSCBgzXIcu3Jz30M3Ex0AJCa/XprQ/j4HfV0G4qnmeNIZZ9SCKRnVP/Ra1hLSES
         wOv4MHUZPMbDrjgh3d7jid+sedc6G6ane4HnRV87dm/3iglAUEqGpCea0a85WUzkLEVS
         9+U4kiJa4J4ED0ptNV32wCdsKdqh0793xnwxWiCDjbzmfUwhGV7ovfLIEy7OZwhgZWYF
         zKEQ==
X-Gm-Message-State: AOJu0YytMkIHnMblm4jULdHU4qylX3G28yTpnfv3DF44wRseUONKaTtP
	F1coMKW8LZn6jNU4xyayOToX602tdgiok1MZ3BOqrBmiy8ZCnpMnk5A15fpkZxpitT8Xlo9YHxK
	ST/P2HMeUIj3kAb9H51i52QBqZrTwwjwK2HHq41rahifMxqO2JpVQDtlL/K0=
X-Google-Smtp-Source: AGHT+IGLFSvx3tQfkAtBbZaWFqt4TxtRD5lloArKtHE6LYk8W4Sas5pdfDoEZHdApoImPzhp1GOt1jC1m//ySA+7PqTJUZEIE0jS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2f:b0:423:f9af:b8c9 with SMTP id
 e9e14a558f8ab-423f9afbb98mr64715085ab.18.1757956156869; Mon, 15 Sep 2025
 10:09:16 -0700 (PDT)
Date: Mon, 15 Sep 2025 10:09:16 -0700
In-Reply-To: <68b1f3ab.a70a0220.f8cc2.00ef.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c8483c.050a0220.3c6139.0d1a.GAE@google.com>
Subject: Forwarded: WARNING in rtl8150_start_xmit/usb_submit_urb
From: syzbot <syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: WARNING in rtl8150_start_xmit/usb_submit_urb
Author: viswanathiyyappan@gmail.com

#syz test

