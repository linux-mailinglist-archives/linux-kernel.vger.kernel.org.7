Return-Path: <linux-kernel+bounces-885470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7230CC33000
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 22:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DD543A3B68
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 21:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0612DF137;
	Tue,  4 Nov 2025 21:03:58 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D89D27E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 21:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762290238; cv=none; b=PXu3pm22pbGFpy7Ro/yP8scujUXprHfOQ5fgmxK1JWUZq3rCwOhdpGOEiSWtZIcm+jfsAvMmugulz0FNJN8ZLfUO0ZunUf5K1adkeqxyK2v1kMRFUb7u3CFRSoMUXMU9+QiJtw6vHWOGpMS+Y9b+GPNLtmce1FhBxOjdBKJMOMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762290238; c=relaxed/simple;
	bh=Ieq1ck0qvm3ZmRsGLSRgTwo5ZTOdLuFi0WGVB/YIMwQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TSX7pM7QOvUsoaKVWQDlqnbztNRzvmpz+IQteh0L5Cas/j7UUHVukqseXivSMYMtH5kiIG5ChMnFY+uQz6sY/GDk5DgA7ao89Q+tpXAUixnoQha8f7qfk6IUxaqDYLFBaXdbn1fVtIyj/lcEQmehWkRKN18f5PNQUomVPYmlaTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-9482041f14dso1535929839f.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 13:03:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762290235; x=1762895035;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OV9FnEIMn3tAb3e2Fleb7GR+066UTYm6BepX40jlcc8=;
        b=AycN3O01BPHqS7GVNqPxNcel9XK6vvL8asoEFC3COBX+Tv2tjETP0+PQmvQyHK4UFr
         7u4oDPiDNWiQWkMuPzoms7vCqpg5sbP34rjdahU9VZTuDBMJL7A1uCNLbtN0bJMJd8ya
         C6TmipnbqdBOClg8Wbwk/pekxfyP6QfL0IehnHjZu19iAF/WGQ6IBLSNABW2p2d+hy7U
         D1KslgoFwUYmV3zC1MMjSHUDwyuozMa3IxhRN8dL4vyOv4vGyctdkMYTK65dQE/j2hLE
         ZdqZFV9bV4lY+qdkxe9FcVheAUZxtTIyOeRDIyM8KpBYYGbx1W+uBE1l+BCWLMTTANNg
         wU4g==
X-Gm-Message-State: AOJu0YzEx1IOflhmM0lFDOEcBFoMFcqOidgp3xDxFsQntKh0v4/Nsp/M
	UGqEHPRVjp1Lo5qydjf+PNRmGX/BqepStibNKGKNRoPRyB0B8KZ/g+GJB1HDGbhkmybY8cnbZ7U
	EJD/iw08wp56io7uyv1nMp4MqV9wxjww1wPLvHcQFZ1ENMIz+XTp7cDKwAYs=
X-Google-Smtp-Source: AGHT+IGwme24az8yOOJlP3HuKRB4W/yB73sQT8utHyE24mprrnpqlT3ApXn/LdaR/+pRy4ghwdQf8n0CA3Mi2xeaPXUxdznYjfkm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3d84:b0:433:209d:feee with SMTP id
 e9e14a558f8ab-433407a1353mr14482955ab.13.1762290235604; Tue, 04 Nov 2025
 13:03:55 -0800 (PST)
Date: Tue, 04 Nov 2025 13:03:55 -0800
In-Reply-To: <68232e7b.050a0220.f2294.09f6.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690a6a3b.050a0220.98a6.00c1.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
From: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
Author: yanjun.zhu@linux.dev

#syz test: https://github.com/zhuyj/linux.git 
v6.17_fix_gid_table_release_one

