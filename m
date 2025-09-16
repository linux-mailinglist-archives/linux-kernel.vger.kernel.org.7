Return-Path: <linux-kernel+bounces-819627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 453B3B5A3C2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D225807B5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C93283FF0;
	Tue, 16 Sep 2025 21:16:54 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E231419FA93
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 21:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758057414; cv=none; b=JK6yfmd/+unUH/FnYJ3T3nNdJ0oVuMQ95mFUTYTJmHVcdBdfftHfThn1fEMzapwZhgT6nA/lgs3G9zoqRx12ctzPbwWSf/LdHqmZDWG1Vc2SG+kMaoqzl0gM8eiA6VDQY7nsjHaXGeQUPV8ymB0y6cDaZvarFOHMkxlbO3/QoWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758057414; c=relaxed/simple;
	bh=Ieq1ck0qvm3ZmRsGLSRgTwo5ZTOdLuFi0WGVB/YIMwQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=laAyS4YAIluwUrCFiX8Rg69q1oDz/1rmoQuR7+U8TnMgMN+CW98Mo4TgQUe2jWHjNujHxMOwKJb0QhBwr1Vq18CIyiKtaLoz/HkQ8kebRMqmVGnwe0QAceBZDIT8fC+H4PSS5KPTLM58E9/kAmJs2kKqwsTopJ2YhhUJ+04Exbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-401eba8efecso4411835ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758057412; x=1758662212;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OV9FnEIMn3tAb3e2Fleb7GR+066UTYm6BepX40jlcc8=;
        b=qiuM9cC5ljrxsI68plCCSywlCDytAQUYuTvA3EFjPDCvFquuj7y+BOTtRNkkuQFSwG
         g0IUXKI/m6MkgNXFUQczyYImvDJHP+hsmxniRplLXJ455itLqpJitx9H03bN6v5Gkuxo
         HiFsrTCttPDb4m5q3WW1AU9EOgeuZZ5lSL5G5lC18l5upmvSYW5tYHp1sWNW9lZ4bRXH
         OXOntBkZlQdZpTIIZ4z7SQpoKcCx74iVkpBEsnCMtGWbxZi3uH3iM7Ay00lLXQ8/cfQ9
         e3f3XqMTdmlfcWTYgRVvVUErqBhhQPp99S+rr0PDBmnJbgw2ZV4OMbuPuKnUQuzcHKCn
         nVZA==
X-Gm-Message-State: AOJu0Yzyi9jTQ6GlkdkbD2R7WVlkQOEnLVIJ5PwKrX4nxDbLw7grD7pE
	b5Gk1kU5ABaefgxg62WCLpgsnljuyGOoT+bU3tCm39KSb8hQGqTuBAOyv6/0nOyx6CXFcdPA//p
	WmNza54yslCUnCRI/lvj1CqFrxiT+tBGTuvG31dlIe9LdHHDaB+979SIm62w=
X-Google-Smtp-Source: AGHT+IEQkoz9JlOolvEGnKG6K92hpbaqIz1+b7Hn/1+dY3TbD6MvdfZ5OtoOpKefXeMK74Kr79bJie6jlM2PU76ih1oAy997wfh1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1688:b0:424:f8c:5c71 with SMTP id
 e9e14a558f8ab-42411463ac9mr33501985ab.9.1758057411872; Tue, 16 Sep 2025
 14:16:51 -0700 (PDT)
Date: Tue, 16 Sep 2025 14:16:51 -0700
In-Reply-To: <68232e7b.050a0220.f2294.09f6.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c9d3c3.050a0220.3c6139.0e69.GAE@google.com>
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

