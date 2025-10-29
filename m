Return-Path: <linux-kernel+bounces-875704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36312C19A3D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D065B3467EB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BEC2F0C68;
	Wed, 29 Oct 2025 10:18:10 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6682F2E6CCB
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733089; cv=none; b=HG+Asuy1kdHtiiSaNoFamNddczjlF4awK/nv5kppA8g51fcgsTrZokio0VIUa2q7Ai45Z3w3euICeCa72GpsySz9hx6k/vvfGQWy/+GSCqxfYaKsxPlJo3ycHmfeK1/IxqZtRhnKqru5AaREz+3EH4EbVeNxCNCNzO40peIGW84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733089; c=relaxed/simple;
	bh=JihaqNtA83GsUIap/80u3i+G9mvtuyZOAkQik1moCSs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gZ1hKXuXVW7FZnrp26w8QE/lkaQ+U4vuNLbdpL7BHWrNGf9U5zimQI3mtftFCz3vaOpyOufX1qz+zOo4IRDAd5yfAM4FjVJWDCPD+PLaIUnUW1CO7n2sfO3LIuWPE+j89jBU+LYYkDz/yhRHRXyhqGvnrx7KbGyb/tTDNOdCaWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430d4a4dea3so10759035ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 03:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761733083; x=1762337883;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r2Tf211E/LsbejxYlj0q7EHB0R8qTqzOQ8qeeqLZvL0=;
        b=vYA/2FS/WI2mz42OwbU/SUOwCiM6lcL3J8tj+vJikDAXn/g/8RNykSLmQzTWtxlnl5
         1t6bZ+s1MurM4MmFmWw/jBL2e1YsW0GG9o/o/ADBGBujYvl1b67vRkmKgk3cGt0FPIiq
         qNTJfPrgROO17UbSRCnRqi+FKpGaqZlKudM/kGcFLk3+tuuLFgCo0jYbBezRbnTlFxm0
         BzsTs25SqzNf2zAS2IAxMBPIb5n2f5ToLGgjvXBYs6+QIy3jOsUwi5BJxIizRf8x5oii
         FwpqsQmLdb28X2hVpC3xEDCC0okN9vH7AhFQx11lC+HIPuz8h03oSOzrtHOQLI/EEKlv
         vceg==
X-Forwarded-Encrypted: i=1; AJvYcCUyW6gDWLqLR/2OGE2S1KPmX4m+9CCaZJtDcphA2MrZU/LejpTHmOpWTZYX2wA/S4+RUxhYQlX0OtSgnKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIUTjZWeoI8jtyGLrhMRrTXvBsanP4d4jb3TS6/JkxLCVMyVb3
	Dj6AVzECZ60KHprZfjwUUsieP/8TI2XfYue6rtVOyhW2DwbrgO5HTEUWxaEXWt8MvCoiXZgzeSo
	9aGqIiChL7kFlrcbcIsfeQU6zvnryZRO0Jcui77Sq68lF8z2mgUsuJaGehzI=
X-Google-Smtp-Source: AGHT+IFu1t/UTtLHhdQUwGtyPVnkPWgKWI4T8BReyYIW20PGeETJqSQgmLT13LbWcxR6Tx77GRZo3qq1WvIxtuy4Au8T4P9c3Nan
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2148:b0:431:d83a:9ca with SMTP id
 e9e14a558f8ab-432f8e4967bmr31380775ab.12.1761733083493; Wed, 29 Oct 2025
 03:18:03 -0700 (PDT)
Date: Wed, 29 Oct 2025 03:18:03 -0700
In-Reply-To: <20251029062745.ABm5W%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6901e9db.050a0220.32483.020a.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] divide error in ocfs2_block_group_fill (3)
From: syzbot <syzbot+fd8af97c7227fe605d95@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+fd8af97c7227fe605d95@syzkaller.appspotmail.com
Tested-by: syzbot+fd8af97c7227fe605d95@syzkaller.appspotmail.com

Tested on:

commit:         4fc43deb Linux 6.12.55
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.12.y
console output: https://syzkaller.appspot.com/x/log.txt?x=1060efe2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bbfc2b03b5c0151b
dashboard link: https://syzkaller.appspot.com/bug?extid=fd8af97c7227fe605d95
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11ff8bcd980000

Note: testing is done by a robot and is best-effort only.

