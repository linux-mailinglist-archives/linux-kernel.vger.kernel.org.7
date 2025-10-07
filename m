Return-Path: <linux-kernel+bounces-844822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADF9BC2DAA
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 00:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C08A14E6B71
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 22:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83888221FBB;
	Tue,  7 Oct 2025 22:19:57 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01392745E
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 22:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759875597; cv=none; b=YHFfc89uvgp6yE4HFMbatDpQIb9O00knD0FAjb9Zx/Yl94i+2wv8pbGwMxVLfdcDTxzmo4mG6gh1IiYn4oDWiADm32nfwUXHvy/i2+E+TTVWrom8AFyLnU7d6v6EIGLCK6YpYYTAAjlHmE16mNWn9I50Av48i2xQP2uNvUptdaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759875597; c=relaxed/simple;
	bh=T0OMHUQed6KSEdn+x3mQlYhzyWL9U6kVcjOF24s/Btw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=a7V+FLrCmWtsdP1I4kGBsvhhTBXUh0XkeiRwpFlcKRMnocz2wKZy3TCl4t+WJn+IDe72+KQLSr2VOPbHyUPvDf+jx3sW2c40PT99HCX9PMkRduHdVhVuiL1Q7qRN5bWObbkT454JzC9Bo/rVHz4R++0l/1wZ2hBl5yP0oCthbIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4257e203f14so217879575ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 15:19:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759875595; x=1760480395;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T0OMHUQed6KSEdn+x3mQlYhzyWL9U6kVcjOF24s/Btw=;
        b=DhIs24rVm990+8YMVtEbjk5c0idThRx4qHxCdIclOQroZwQviJclA03sWQoBY4F9Vb
         1+dGVqxgiyAKyxWzKTkjBUxDLy30V/UjUtzGMyJT9scI9QllZqG2TcEBZvwPKHnWOSoR
         sDDGesxpyE+qIQ53l0Q/2n8A7vroY91eWqizrvkBpjWEnvKlX7wAxwe+YFd0qOKQWxaR
         KrZycOGoekPMqDNwuOdbRAEKYyobFCijmVWV6/fS/byik5100ycHvVEIwYDlsBvxu7lv
         CUXqh26wIB4/Up0ErjZx7X8fhSZqK84jscdxL6KrkkWyee8Q2fX5Fasqa9sBMD+DSa0f
         BLtQ==
X-Gm-Message-State: AOJu0YxAjLr5kqPqq/7+s/+XwcORkacj65t8+KrrTxJFfi41SVi3Lf2s
	7GTHmhKpuQS1RN2p2B8570SizeFNkOFJe7G+TIO9iCkDiHYTc1WYDMDx5seHzyV9wv6wiRYCUoW
	eR1vVYqgXAj5z/2aPHOHV3I1ID5ApEcOXvTo+DWsnayGOpLIk0QEnSc0vOiQ=
X-Google-Smtp-Source: AGHT+IFx3Aa9SWYztgfKWJPB2KRAOz3FToY0OuXhMlpYGjzeXFt7SEj+sH5g7mPLHQ7ez5CwL+I45k2YGpKRz4RntXZcDP9EWRoo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1987:b0:428:e543:1b2 with SMTP id
 e9e14a558f8ab-42f8734708emr9387635ab.1.1759875594699; Tue, 07 Oct 2025
 15:19:54 -0700 (PDT)
Date: Tue, 07 Oct 2025 15:19:54 -0700
In-Reply-To: <68c58bfa.050a0220.3c6139.04d2.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e5920a.050a0220.256323.0029.GAE@google.com>
Subject: Forwarded: kernel BUG in ext4_write_inline_data
From: syzbot <syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: kernel BUG in ext4_write_inline_data
Author: eraykrdg1@gmail.com

#syz test

