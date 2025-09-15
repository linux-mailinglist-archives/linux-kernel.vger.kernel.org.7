Return-Path: <linux-kernel+bounces-817812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4085B586D4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 23:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AD3F487F92
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150DC29AB05;
	Mon, 15 Sep 2025 21:34:29 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F890EACE
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 21:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757972068; cv=none; b=gZVLV1Agx0KXZ7yNkommk8hGx3cBaaYipH3tuuaHBVVQJAUsCCRQnKNT6BYG9nrm6nBCg2uwgY/NjSLolQDoulZOe6n3+mDZbZYSjMb3Bekd8SxCIehyLcIT6/yWIwKd2MElNJ/B0HBQkRuPScMdSSNUFlhLoOk/LdcYMiqLf/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757972068; c=relaxed/simple;
	bh=Ieq1ck0qvm3ZmRsGLSRgTwo5ZTOdLuFi0WGVB/YIMwQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YFSgW+WsEmzFu9ta8XeapAT/I+n/ge5o4J7aPcR+9+99Hn8dPWrYT2VswvFcSKb/K4QiXn2KreOH+q114ho6tH8igpCdHmiZSP1ZTKcHYxFMTWx0+3KDqRPk9qP/WizOBWyixkiLHyOCsOuB6g0cQFKD51F3jgp/KYTe+2xkKAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42404bb4284so20479935ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:34:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757972066; x=1758576866;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OV9FnEIMn3tAb3e2Fleb7GR+066UTYm6BepX40jlcc8=;
        b=PrVKtbPkNt5EE06sm4iJaOqxp5c0tA0Vj0s92L5CCk/ryA5IcL0g/5ilK8NBstfEym
         MYdrgKueiC44Oz/HSWGwtCQ3rGbK6PyTyHbxtqdQHCr436AtevmHukHXdb22eP88FU6G
         5oC+EMufniLRYnnGNhDjkes1w/tOo3sAQ5AlpQw5O4NzuBabbYHhg+lskVB8f683nrzp
         lfNp1lL/6JWH5nyVWFDCn0Ef67Gjb8i2VzlMz+BVNvVVgXMw6/4rHajCLIkLf1dbb4ka
         8m5PIk+idS6G8W10wtWl6cU0derXC0/pUWLOUfAKMMbpYkQkpPtUBzERkpsEFuKG3zNX
         cBQA==
X-Gm-Message-State: AOJu0YyWKZW+kpYvAEqThSO0HrCYm/neZUDM5tiyN7jt+WqqjszehPPX
	E9xxBl7cxdgMAAtH+2sxgT64wiHlAI8gMMUzq9BKplY1zkzbyHuODRvAQAwY1izgY+/x9Z5NXo9
	88zgk6iHG/VXy0/3ZaAE86IXA5t/RynGw1MOmlhBgYRHEufadJBW4l1PqDLg=
X-Google-Smtp-Source: AGHT+IHlpq67WALk3VZVfnehuCIvpDiDMTmr2kMceybIPgD9ehyAd80HnWYtuqSgz+LqGLF1VYUtUz+qokFFfYFpRD2/NALQXiWa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a49:b0:424:cf7:7d04 with SMTP id
 e9e14a558f8ab-4240cf77ec3mr20724055ab.4.1757972066314; Mon, 15 Sep 2025
 14:34:26 -0700 (PDT)
Date: Mon, 15 Sep 2025 14:34:26 -0700
In-Reply-To: <68232e7b.050a0220.f2294.09f6.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c88662.050a0220.2ff435.03b1.GAE@google.com>
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

