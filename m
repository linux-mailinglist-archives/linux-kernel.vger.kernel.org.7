Return-Path: <linux-kernel+bounces-885950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9F5C345C9
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 08:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F388426FB1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 07:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B792C21C5;
	Wed,  5 Nov 2025 07:52:57 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8023A287511
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 07:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762329177; cv=none; b=uCAQnb5L1lwUZ7gBowMD+U441e7jM9Ey5lrSDXqCv2JRMTEP3iOPfjTepWY6h4NXX5ylmxoii3si/+MRP0D5BYEf95KHord8PcFYNthDpuEUkXk825X/M0pOhs73V4LPQw/anA4X/0mMIPLpzb4m3h5g8DeRdEM3EDTF5E7b0iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762329177; c=relaxed/simple;
	bh=ilcDjMeTyH7bjuKeONAALDN5iqNbuFVbOeQR5KWcy9U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=greg3Ci76dm/hpESGE56sAQ8cb5KCKwCotXRLZEhzG39ursiqoIdkJ8031zAj+RO44ZEmor8N7XLJ6CrkPsbr/zIlOT4qC1YleaYHK1Zca6dAqm01Nk7vIo6WukVrOBSnyer/aMxMdB4LglAjFNa/VxTOd/gvU8XwnUvEcgf2zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-43321627eabso140625125ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 23:52:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762329174; x=1762933974;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ilcDjMeTyH7bjuKeONAALDN5iqNbuFVbOeQR5KWcy9U=;
        b=p2dwIJxlAzhnWMYoEzU0pxmo7phqkdW75VIOVOeP9eMvefD1rjoqDLxY01esOEyFGX
         I/fnGOerQS/nl6kAxbx3PUr42a1yKjDqtaUVGOYfAUm+9ANcQXsBEyky/l+MSfjw0m90
         T/APODEa6m7svAJqAoNpQ6ac9eQsKgebqUsXhJssWN4q+oem9lKv28IFlS6DTi39M37w
         KvKBQ4y3W54W3QTKR2TZzVP43OKbQPnb9r/dvHpjXHdP4X2RtBvcjQQ53qAvqy/l9uvE
         MN5EqrUCLxNLJjkYlU429/Tlz2NU1PYJhIaYw8d9qOwTx8SOx02hhwS9VVbwFKwj9qt3
         SRhA==
X-Gm-Message-State: AOJu0Yy2IrcJlqk2T4DBEWNOjMhsvBPjvoUsUzJHy03osehae+DAeWdm
	nfq+QQ6TP1dmvy53+qgPr4tHM+9RWYRNDxUd8yieoagGEEXVU1znOucr/sEPRZm0+4lb53M204R
	XNeTBl81d8y+7rnL+FznkU0KPk6K9AQuHaPeXKpE8fSEwOz+GNtUEQ3+oAlo=
X-Google-Smtp-Source: AGHT+IEoAQ+y099xXij4iDH8ATLJZvd18szcqmWD3hu1f28j/xoBD242l+vlcBcED5BfmvIdzEzc65Gf9f1yfwyJw74a08twmSWW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3712:b0:430:b999:49e7 with SMTP id
 e9e14a558f8ab-433407d4f9fmr32070035ab.27.1762329174564; Tue, 04 Nov 2025
 23:52:54 -0800 (PST)
Date: Tue, 04 Nov 2025 23:52:54 -0800
In-Reply-To: <68cb3c62.050a0220.50883.002b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690b0256.050a0220.3d0d33.0022.GAE@google.com>
Subject: Forwarded: Re: KMSAN: uninit-value in ntfs_read_hdr (3)
From: syzbot <syzbot+332bd4e9d148f11a87dc@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: KMSAN: uninit-value in ntfs_read_hdr (3)
Author: kubik.bartlomiej@gmail.com

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
master

