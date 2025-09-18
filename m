Return-Path: <linux-kernel+bounces-822085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 657E9B82FBC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8EFD1C25353
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 05:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3572C285CB3;
	Thu, 18 Sep 2025 05:19:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF1F268C42
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758172744; cv=none; b=Me2bFhUMoY68H5kPtK1S3bDu+tJczu6Ptz4yf4rRES5I2Izo1lUprfM+GmwGKB1hnZHAD6RNBtd/sLjNz6aJLRkFUZjzf82jYDj7y2DbFjzXz+jAGkHCDFd5BAK3bcYSFacBOeffBeCrxct6uxAWkzovHa4BHM0K0i32E0nzyic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758172744; c=relaxed/simple;
	bh=p/xzT03gfJZLT5XZ9mGY07XBRK1Eyl2Cf8ZHGLCPBWc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EDPRuFq7Dbs8hGESRpv1Shad49pkDNO2nVl2fCwICI/nGXzE+dW9SvIIGhHQvcbGiNT0O9egX5LdB/j5AERZfrYyPCy5MTXONLfOzgrGJSQL94a5nFVhTvs2QcQdxOfRBAioXR3xKNfdMxuUIgbgaV91+K/g1YSmu53rdlazuzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4240a41d2caso6045225ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 22:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758172742; x=1758777542;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oiAEnw4vsAa8cspN3QwCvTS0bfvGW/xDJ/tKmYUAFcI=;
        b=kvCdIDc4RiHE75lW0AS8K9x3GSf4lrxXnXdQov1MIMn+jaCHgq1mfDT2MiNDoHOMau
         IHA5TTUP7nOYQAtgHvHgLEvSldzc8DmI58DlfdnE/leEDWnlS3H+BVt33Sn7FbNC7Oi6
         qZEPuuh7SDKmCDxUHxzdOoEK5x65kcvpAFaYyEgGlteY/y/TA91iIEP9odhwcCQd/V15
         YK7JCJfhchxY+a8Ra0RXQ5azcRWT/SeYIZjCrepdj9vDgIbjSAxZyHRlRdnbQc3x/hXS
         O3Ra44Q+JqInDBcEztzUe7b/5IJZ3fgB6VdO9AZ1pX0QYPtnKMoSM10BP/2xIHltKpYf
         M/RA==
X-Forwarded-Encrypted: i=1; AJvYcCWHkM2NqnJNvAUgp1CWx44DRqcFgYaImgD3UwO7lVbhxJt3cvAsYEOi7vA/AVBlzPmmJ7bCzFSFH/hZW24=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaGKyLORX+Oec2yzvEqUaXaeSjlHYv/OcUaqhsSQBueuO5rT6U
	6ife8io9QzDQOOamghLfzjua9PqGQ+bxTHvgvO7CzxMUKTpcbEIQMal3H31zLLULdYVhCTaltH2
	UceJTLlApGcxQC5taaMO3uBd8boYJ7TyezAdK7Ab3Je3pNu74VfQO4eb4ysY=
X-Google-Smtp-Source: AGHT+IEDIAhpQb5rfB6rDJ78OKWEV25I1M57kTGU3D0LNTUGgH3SP+Ha12fioGQpn74afH6OvCrQI2x+ayhRgvRjKfWE/UovPl+T
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1567:b0:407:dc0b:7ba2 with SMTP id
 e9e14a558f8ab-4241a4cf587mr71152345ab.3.1758172742285; Wed, 17 Sep 2025
 22:19:02 -0700 (PDT)
Date: Wed, 17 Sep 2025 22:19:02 -0700
In-Reply-To: <CADfthj3f-mmvvm3tAWLUmtZGTKw46+eqxZhPekLA_eKLgOUG2g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cb9646.050a0220.3c6139.0faf.GAE@google.com>
Subject: Re: [syzbot] [ext4?] WARNING in ext4_xattr_inode_update_ref
From: syzbot <syzbot+0be4f339a8218d2a5bb1@syzkaller.appspotmail.com>
To: albinbabuvarghese20@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+0be4f339a8218d2a5bb1@syzkaller.appspotmail.com
Tested-by: syzbot+0be4f339a8218d2a5bb1@syzkaller.appspotmail.com

Tested on:

commit:         592a93fe Merge tag '6.17-rc6-ksmbd-fixes' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16e6ae42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5b21423ca3f0a96
dashboard link: https://syzkaller.appspot.com/bug?extid=0be4f339a8218d2a5bb1
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15a95f62580000

Note: testing is done by a robot and is best-effort only.

