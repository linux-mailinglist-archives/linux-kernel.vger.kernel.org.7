Return-Path: <linux-kernel+bounces-860007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 158EEBEF209
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 04:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0414B4E8FCC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 02:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF5E29CB57;
	Mon, 20 Oct 2025 02:52:09 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604C623E346
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760928728; cv=none; b=gPvtX6cGxI7HjcuEQJK0cdAWgHugVAjbg2fY02Zi1ZRMCrlKyk2vBAnz9MwYsyk5qH7qHNaSOfv5V5xK6EmFxSU0A/CuLA3o9isSKlBUkXVXkxw/2r4xNAYecTBuSm5I4oGjiKBxdkoOxAHE25sGTL4Gm9B9iYfYoVd263SHyO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760928728; c=relaxed/simple;
	bh=cgL1OPGYQWyS42XhkvkPJLaPso86wW8QNMkLpnB+/tA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=O7FfQ0DUk2vLsYghqFSR5LLYeqDnDh8USmNowXue+8HIf9Pp5Ss0o+2FZYy/NQD3nSu0KgP4T7wnoRI6G7Nds0ycXu/SbWGSuX3550vXbU8bR6gQBv8FVRkk2e1BBC2vUnOwKekDlyrm+KmVcYDE1lQZZRxW15DGrAjEx4fdTfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-93e8e029e0cso411479839f.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 19:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760928724; x=1761533524;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A0MxZrYqBouYFSNH+6DGRRUzuaxEdiWXDdcw6vp+X0o=;
        b=mbzxWYxrY3Ti7lForPO5Quqt9BJH5chVtDePq9HCB+Y7x0PjkSbooMw/4nVkIKZLy+
         rMOqeuNUl8p1ZYqWhFEQl3/+/+PBw4xqQzkJzEcxvAd6rtutmjlwQxR+gDDGCYrQHZrI
         /snuUxh4r4fDnJCRQkSZVGYXbhmmaN9M1c3/KdGVXwkmflUgbK6iX/erQpTaIFIsuw8k
         gPhKeEVJbFuc813HrXPDa3v0erJ31t4rzvaTSMN9u1+ovIiC6YSVlRM7msPpX+gN1S9H
         rTU9Tt7FTf0Y5TnCZGWESRwwlID29LEwaF6DRstRZom+vveHLgHh5++RIF4bSXVBTDV4
         ZOFg==
X-Gm-Message-State: AOJu0YyoYXUr4plUsyrvMweWPFZz5mZhUS+t3tmvIcV2HvXU0gR+FGGQ
	y9ii9dfoUW7rF+mknjY0uJMJ50YpX8EHZd+Qd5FZKRB1z959XSJWA4f79fR095M7yBhn8EOonYt
	ppqad68toqapZtcGgDRRDNOlJQpYQtHZa3J8Q6eW36OS3kauoX0CPJ0kP3Ek=
X-Google-Smtp-Source: AGHT+IGedTH2QBuKvc3J4j2VcD1sXDTZmPkNAKOTJFCFhpdAuVp0IB8uceIkxdPI/HP8xg6ivDmGYdu/Z+BMC9gYXCmXBu/ezTdr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d1b:b0:93f:fca2:e548 with SMTP id
 ca18e2360f4ac-93ffca2eba6mr888267839f.8.1760928724506; Sun, 19 Oct 2025
 19:52:04 -0700 (PDT)
Date: Sun, 19 Oct 2025 19:52:04 -0700
In-Reply-To: <CANNWa05pX3ratdawb2A6AUBocUgYo+EKZeHBZohQWuBC6_W1AA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f5a3d4.050a0220.1be48.0007.GAE@google.com>
Subject: Re: [syzbot] [net?] kernel BUG in set_ipsecrequest
From: syzbot <syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	ssrane_b23@ee.vjti.ac.in, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/key/af_key.c
patch: **** unexpected end of file in patch



Tested on:

commit:         7361c864 selftests/bpf: Fix list_del() in arena list
git tree:       bpf-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ad7b090a18654a7
dashboard link: https://syzkaller.appspot.com/bug?extid=be97dd4da14ae88b6ba4
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11031492580000


