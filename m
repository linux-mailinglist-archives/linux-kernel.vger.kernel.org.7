Return-Path: <linux-kernel+bounces-887623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E243FC38BB1
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 02:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FC583B46EA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 01:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50E318C031;
	Thu,  6 Nov 2025 01:45:50 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188C617993
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 01:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762393550; cv=none; b=h95oYaZ2CVExDM3vxl8Yosgiyu39d3Klg6U/agueTfext+d+I0b/ZFsFOFi+dh4wqW2I8PMxikWlTHFfTgUQGdXKGjc0VOTfkXN7bpmgO41bg6sU1Oi+/hjJlZyuu3T4/xPFXd3WxkVamfaCGX3hgWa9uEqydqs08dE2UTkrBos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762393550; c=relaxed/simple;
	bh=Ieq1ck0qvm3ZmRsGLSRgTwo5ZTOdLuFi0WGVB/YIMwQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MvyzVMYvniHduk7MLIGeqYM6sy11PHIAfuVKlNapQLM/B9AMzZqWwkGbufRNEAGpcBTkFDnL0i+52H6l7cbcrfe1POh1Svcz6+Q0JngSDv5+CT0jRqP+ZboFfwOnNgo2PKQ72kbDrh3W8I4e9FZGiWzifM7tXe1QIb3TNKqp8CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-940f5d522efso92744139f.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 17:45:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762393548; x=1762998348;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OV9FnEIMn3tAb3e2Fleb7GR+066UTYm6BepX40jlcc8=;
        b=ihDGuPjQ97Zv+lf2SfhnjO/TctPa5fhZFWNMLyP3LySaFaX/btA8PZ54a4/2CsrAWh
         XjNuUMXKjRirDzQrv5GfxNBydLJ4TZ7jyYxwb3X9+YYU0t2faeUlwmf1znI1H7t4Miih
         wOvG1u4iNCFLE8NDEPWIOjl6Uy9Hqu5rL547FV0RI1u0Ggy3ftjOk5SmPDqUxDgbvAsj
         O8UPMD1mxJPy8xAxMc1I83LnFq4MnbxbxlNB5bF+boa7QpxBQsYO2WLeoMxnJhyODuWd
         9lTT4Vyu2H+H4VdcRyHrH5lgU7EBhoUTvjfS51ax4vgVcfOUvvGJbrFBiKB326YjCUWv
         c4jg==
X-Gm-Message-State: AOJu0Yy/jGYBanJLdlluOTf40z4X7y+V7Lcfk057LkziixYxtyYXDJpk
	Mdzk5k7WTgR5lhU2l8xaVHj8Yi28JmSaxlNBQuy3vtttu3OJh1gW3sG12GLLQee914J0eo9jn0E
	Bd+mq70Hf3HQAT386hPT+WOrJfkAr0XMYgrc5PyCj9nvMTTTzY3PdVr04rYo=
X-Google-Smtp-Source: AGHT+IE4xTTWoLizs32RaUaGaSVo7VovVDpYuVlFRJNaZop9suMEP3WvVGSrLQRlTerFvPMB9rYjC7A+940cyyc9Tzrw4A6zn/vs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:240b:b0:433:23f0:1ebf with SMTP id
 e9e14a558f8ab-43340779d13mr89284635ab.9.1762393548319; Wed, 05 Nov 2025
 17:45:48 -0800 (PST)
Date: Wed, 05 Nov 2025 17:45:48 -0800
In-Reply-To: <68232e7b.050a0220.f2294.09f6.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690bfdcc.050a0220.3d0d33.00c4.GAE@google.com>
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

