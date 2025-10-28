Return-Path: <linux-kernel+bounces-874542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D311C168AC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D77C935671E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1116334F487;
	Tue, 28 Oct 2025 18:52:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FEC34D4CB
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 18:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761677526; cv=none; b=JaIV+5632hA39rcc333ebNzF35S27DF9SPGMQ7zZmsPIvR6DgdP5XiCvqPOiu8pfNFJdYMBLRss+X8kJlmk/rkLqgMR6oc7M+E1iHLRN7b3VIfsuJXWc5o3QP5BLIf/EpVK7scKAXikLDRrLOIc1FWdTamlykhkv9Rv4lOPiOm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761677526; c=relaxed/simple;
	bh=xzbP9/SA0UDk44fHpO/FrUazuQR65K0M/FlD+E30GDA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IftrtDBFBjI9I2WyabhlOb7f+bN46MY3agZR+5TTnHvl3jlD0dmPE79Q/e17lBSOzV8ZWFnHJVz0wPnsYFya+pcazIvyUEgyKORV0TD1ShmzOB4lBQLQ2/Lv8096TnaaKcRhw7xjhXMlj1vLQPMPmJ47UOmYFw9JBajWSHv0NtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430d082fc3dso204241975ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761677523; x=1762282323;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zRkCo/7fbaBqDPUmgH1y7yWByX5Z9DIxLg+NvLrVULg=;
        b=ujUHj1zGAHW3e3hRSGtgEokrocKNS7kmiyrHrR5CrBrhomXTJA/nEBnaFCjbMuptAm
         g0/CIHZ5g2JWSjlV3bD1rxXsxCxVDykAZopC6eIx+pLKgC3dazr5sTISr13+UaXVAnYC
         cCgjB+WNy3huX1fpj1cDdYm5oprIj9l7yiwYaa7sSRt9H7PZ5GDRmi61kbudgCgcc16D
         D5OfV8+mcd/eZhHznS6Oyl7DeBCj5YFx5K1nBY7EscZ+7TyTuV3Vs/zUivtUXVpdDCPC
         NAxLxCYyQYKr+oZrx+8xNqe6pVJuC6UFZc3XKz7mFvtSMMxQra1SXNdaGbjgNZNCe5IQ
         9XjA==
X-Forwarded-Encrypted: i=1; AJvYcCXLa1NKvinKRWDF7x6l38Wyu7r+ToCL+xyZRxRvpjODTxvh8TkG9N9+S233Mbu0wI/OfgwRwGA5xi3Lxio=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMwwoT7LU9Z1h18UTTNtOqTc9+IeIY3a1j8IyknTw4dGoSyfwx
	sopPabUq3CFXEb/UFt9pd65IG/uPPExQUWn4i2JYyIyhCwEneLA5mGSnQkB+0mbdKzM8MpCFG74
	k3fj8fGMXzo6/gs9d6VoWfy+lgdaEXdb2Y5HS38BjAmoHL1zPy7OgIg/Xqp0=
X-Google-Smtp-Source: AGHT+IF7AodOefqTekYxVyEDriobOYRweU/LbO5oPCzhO4e0z97/MX/gx5GEBIAY5QB+/7iWvVnSF/n3VSz2T18QR7/I66KamzsJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:370a:b0:430:b290:b6c5 with SMTP id
 e9e14a558f8ab-432f9066e16mr3031305ab.30.1761677523372; Tue, 28 Oct 2025
 11:52:03 -0700 (PDT)
Date: Tue, 28 Oct 2025 11:52:03 -0700
In-Reply-To: <20251028182008.x51jP%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690110d3.050a0220.32483.01d6.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_dx_dir_lookup_rec
From: syzbot <syzbot+30b53487d00b4f7f0922@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/ocfs2/ocfs2_fs.h:472:40: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:487:40: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:500:43: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:644:26: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:657:16: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:805:37: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:941:43: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:1028:39: error: expected ';' at end of declaration list


Tested on:

commit:         8e6e2188 Linux 6.1.157
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.1.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf99f2510ef92ba5
dashboard link: https://syzkaller.appspot.com/bug?extid=30b53487d00b4f7f0922
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=156e6932580000


