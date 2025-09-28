Return-Path: <linux-kernel+bounces-835561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11389BA7751
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 21:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EB923B72C3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 19:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313A3265CCD;
	Sun, 28 Sep 2025 19:53:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4243A136658
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 19:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759089184; cv=none; b=bWBCtWYHFQy4pIWkgeZABCPeD0jvxARjjh7doLwQs3QPdsuoNkW34HJWDeCLPdS2au9oSLmxBCwz3tDBYyTLhoDYGPWyan+mh8YBw8vZHCAvREIGfgRioZuGvnv683SaBD97N4CHjGyveUdCY9KTh4M5dzFOuLIAhpCNlbkuPV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759089184; c=relaxed/simple;
	bh=b4aaSJlEl22GsrLSp01f5nQ/8CuThvfO52kH/2bPYsE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KIoTc4tbiwX8F1mVmk2BDsRHNdVZFU1N/dNR+rt5Jx3hAeCGsTW8dIVTu3TkOJiSu8WpiVoroo/kcIFN8E+tbSdIBNctgz0NIc/KXoCBzUhD7Q08m9+LOc0sdZsTXVOkbCTKpvh+/oP3begCKuJrJojNlhA1GGeoiuKcY8x881o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-90efeb58159so334528939f.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 12:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759089182; x=1759693982;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZyoGIzHdKaUzvzWENV+p7lW7UvFpLA5gupvEs4gtlXc=;
        b=ajs1ygG94K3PBwelhm9Um5+JAQMiwm2tGgC8ybamifgxLHelVAmru2S1z7mIOMqmcM
         GZlqqS3VWWl+ReO9JXYW4nK8KuITaXf1M4JPiNpMrlXeQ34YQJEupnSQV0iviO4U7+I6
         owcl8Kn+A0GnjL6gcxwGND7dFODKDlJJU98AaO9h3tXbi/cZLNy+hAGjy7ZsK4tQgqlP
         Xgk3oI3f83UjmKnn0tzfYaMxyVR6qTaGax0kaW9cl8XsZIUjKbiUh4To/nB1fktHxGRj
         BKH9F+EvBH7F8DDfnI8RSrwC5AyqXQC8PbgRfg79CG5PDdYrUY3CRkhVuV3iOvKSVi6+
         VFiw==
X-Gm-Message-State: AOJu0YwYNSYNKHEFv0AJM8kRm9YPbFXzShfyoPE/+o0a6JaEorRng75e
	XaB+gVPBLNZtUP4VOREGsXluf33v1A9ERlRVJ/viFcxWau2csn+lpf71N4Fk/tJYgFowTy0rSLO
	jLlc3tuVeP+sB4fzJzTHO0ciaO3enJoXx0tZ9h738uZzl9GBuBG7YNLfnMzg=
X-Google-Smtp-Source: AGHT+IFRZThteLiAhDHS9EbyI21xF2GqUL6p2B2cewHkSiVtIIuL9N80Lp3tvskGp+VSNLf7sfvieJV89YQm73V6FKgB4tG412lb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aae:b0:424:7ef5:aeb with SMTP id
 e9e14a558f8ab-4259563befbmr194484535ab.17.1759089182478; Sun, 28 Sep 2025
 12:53:02 -0700 (PDT)
Date: Sun, 28 Sep 2025 12:53:02 -0700
In-Reply-To: <87ecrq2xr2.fsf@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d9921e.a70a0220.10c4b.0025.GAE@google.com>
Subject: Re: [syzbot] [fs?] UBSAN: shift-out-of-bounds in befs_check_sb
From: syzbot <syzbot+fc26c366038b54261e53@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	xandfury@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

./include/linux/thread_info.h:244:4: error: call to '__bad_copy_from' decla=
red with 'error' attribute: copy source size is too small
drivers/nvme/target/fc.c:150:2: warning: 'counted_by' should not be applied=
 to an array with element of unknown size because 'struct nvmet_fc_fcp_iod'=
 is a struct type with a flexible array member. This will be an error in a =
future compiler version [-Wbounds-safety-counted-by-elt-type-unknown-size]


Tested on:

commit:         6f861765 fs: Block writes to mounted block devices
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df5b21423ca3f0a9=
6
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dfc26c366038b54261=
e53
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-=
1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.

