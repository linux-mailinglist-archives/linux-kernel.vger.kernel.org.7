Return-Path: <linux-kernel+bounces-782227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 691A7B31D0C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4924F564691
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A623128D3;
	Fri, 22 Aug 2025 14:56:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50D4312802
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 14:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874565; cv=none; b=QlFW+Cg+mlgbb/wCdIu0j7yo+BqK8S1uSzH/qHTxvWIW6VCT0vZZ9QGBmDSkcpqdV4kp2Jl+7flY7/IAcBl2V745s0fkk5VZgeKWNpmL05SrqA+avzoRdRv987DslvOLyJJg8meCp28YHUcrnWFWLjZtI6CHK7Gck+OSmyMcLFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874565; c=relaxed/simple;
	bh=V4VhVXyvZ8Eo9fL6wXvJxbJy6OAVFi9AQLWlB/8O29E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gbKP02g/HPnmm2nYYpAPa9/0PzU27/KGCWaIevBqXQhZ/Ot2qgrcau+YRpy7MDxPrO54ob/npqIR2EOpTSFrxC5CFstEAjITXYdZfgi9X26kzUBn4tODidRlG9P+tQBfO/pyTL7708daSdhLSory8SllEMimySvNxgbSz7ItBsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-886b468c98cso434895239f.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 07:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755874563; x=1756479363;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AH09MnVdsed7jGPJzM4FkFA5e4/oQhv+2uODYKFhGaU=;
        b=j/5xItarZywc9XVXaTZpSQ9xojVQEiZZxnd9WNIqJ7LHv3/lqhuqiyuEu2YjBAFEPj
         gXTmnLy6K/IP5UznITcy6QTI4M+rUxpoMbmYZbrmPlgTEKKGvMi8dzFwYPLRY8f3j+P/
         E0ySSrmWy5sa9Ks2A+Z20y8sKprIxp9Dy/DcBzFnPaRDOUV0oaGIdISs5h7EiqnbMhHd
         LHpKYKUai9soGWuckFter1I+yZ7W/hLkWFAoi2SFnY2pGQ633J/ZaDmyC8B0vaDZgQFi
         Gzti7VCZE5kWNZkleU5SVf2gutS+UBHu/q9HApg2T6ols1cSJPcXn3/UYPBQHX7e3Kmn
         3biQ==
X-Gm-Message-State: AOJu0Ywt5k4MNbVsjTr5XTYyZ9hmJ3nM0DfdNTlPVBH0tCFy8gWlg9F7
	tAKXyfHjScwh9K/M37dsWL/EF/pUtkn+ulpoXuxq4K3ojqdSue6NOJsWzZaG9RvUAZ5xDDDf5bz
	1j80nZae3nZw+fo+ABlgG8/NF1kVSnoMxX90ar+FmdJFCeOrPZMjunxT/J7E=
X-Google-Smtp-Source: AGHT+IGICdDRZhOmfr7zgmYs5OKsorRCh7vt+i1Pa8grpRV6Vlnd/Iz8vQb/JJXUJpooPTXKXRdCG266iDMFpNAiN7G+a7/UftIR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:170f:b0:3e6:6730:34e4 with SMTP id
 e9e14a558f8ab-3e92158384bmr64692725ab.12.1755874562912; Fri, 22 Aug 2025
 07:56:02 -0700 (PDT)
Date: Fri, 22 Aug 2025 07:56:02 -0700
In-Reply-To: <20250822133148.199-1-yuichtsu@amazon.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a88502.a00a0220.33401d.025a.GAE@google.com>
Subject: Re: [syzbot] [v9fs?] UBSAN: shift-out-of-bounds in v9fs_get_tree
From: syzbot <syzbot+30c83da54e948f6e9436@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	yuichtsu@amazon.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/9p/vfs_super.c
patch: **** unexpected end of file in patch



Tested on:

commit:         0f4c93f7 Add linux-next specific files for 20250822
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d1acc6b9e1fca1b
dashboard link: https://syzkaller.appspot.com/bug?extid=30c83da54e948f6e9436
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15230062580000


