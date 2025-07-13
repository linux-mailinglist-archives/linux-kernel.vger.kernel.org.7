Return-Path: <linux-kernel+bounces-728871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F69FB02E49
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 02:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EABCD482F35
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 00:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0B78F6F;
	Sun, 13 Jul 2025 00:37:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D290C1876
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 00:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752367024; cv=none; b=gqXCteh+kiwnqQWC+WVTc3zIIwh3qH1liYUq8SQqKSpwy1vqoRvCp+ANArU+yvTeb5R63/u3mlLu61sqe4EdYyeCK5+HC9R1xuAlmcyZsPhXna3lfhx9IzxGL7suLcq+KbDOAEGiEN4gmaogSsANV9gdZmCdNBuTqqCgOOVFo1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752367024; c=relaxed/simple;
	bh=0JJIyFyewhhc0sQm/Q2XhlboeyEv7Nu6tBqzeWjwEGE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FXjW+KZmTxFJlpGAbHXoVbFFLjt5NbP+/Ll99jIlJc5z0SK8p7D0m7wzBCH7yKRKh7b3f54ZcGYBeKezE0lLYRLgA5xP4Zn4jUyFL189uHC6uuViFLTDpLA+iV+mWf2bnN1MTpfA4yYrf5V3L//H1KFUhAjCUyKC57ASU8AVBvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ddce213201so29002045ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 17:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752367022; x=1752971822;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WMogPNexqlT7P31mmiWFvnVJD/aSgz3mZhlEuaw9Tko=;
        b=gITkSmj3smrFruC8Iazn+VdcF7z+ZP2tg8rPycgzJMAk0+oaLCDO6ND9GqMSJd//yT
         c+zC5ySgOPRcb+9ArfUPPa7eXj9YaCoa46oUGsjFjTvCfu3ETyAvWMTAPojZi3IYZmNG
         IPDOsz8d6nfz6qRWiT2VgrMKMtKMNVbcQ7vLvVw2D4qEc0P8c9C2+VPusi8ljUKDset9
         YhF94XYUIVci2J2Kh+IeF236+07oh8Pw+hQNwWvTaxEWQyLgXU96yQcgCnLz2ZLQuRBN
         e8BikGonBgVX/nAzEq/Jj1YqeLUpbdEh/rlDCpKYObzRg8fDtrPL1MCpeL15YviWtdaS
         WMVg==
X-Forwarded-Encrypted: i=1; AJvYcCWzXEwxr2+xtft8IsM/+7dSMSM3b0Ha45cm1+pzvmxWWARWr67Qhsv0A3SyrkW4aV1s1y+ivbOgjhuLB1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKys8x0hdugwf0PGO1R/MdSLu2WRMlviDec6EprrQPq7xj8EoP
	d81yv+vVX0nMxV+WZrXiqp2hOrb0xu4LrMnoHPGW8acGf9/EnOBSllgRi+ZrmAWb4bU0ALGcdYI
	91qkXXA/tvWYAruAauO8z+aM79kJ6DOhXI03yXXS8Pn+lDAB/ksMkunuSez0=
X-Google-Smtp-Source: AGHT+IFMrNEBpNOR5q3kxYTsOT8BS/IVt035rDrVecytFygjFOsxMvd7CPcVnZ4pyo7Ar+SfZwqjtoo6qfc1SnXMrksgYCDUPMQ0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4516:10b0:3dd:bb43:1fc0 with SMTP id
 e9e14a558f8ab-3e24482786dmr83237585ab.11.1752367021914; Sat, 12 Jul 2025
 17:37:01 -0700 (PDT)
Date: Sat, 12 Jul 2025 17:37:01 -0700
In-Reply-To: <02e498ad-15a5-417c-afa2-54bcd55c0498n@googlegroups.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6872ffad.a70a0220.3b380f.0015.GAE@google.com>
Subject: Re: [syzbot] [kvmarm?] WARNING in pend_serror_exception
From: syzbot <syzbot+1f6f096afda6f4f8f565@syzkaller.appspotmail.com>
To: kapoorarnav43@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file arch/arm64/kvm/guest.c
Hunk #1 FAILED at 844.
1 out of 1 hunk FAILED



Tested on:

commit:         15724a98 Merge branch 'kvm-arm64/doublefault2' into kv..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git next
kernel config:  https://syzkaller.appspot.com/x/.config?x=82bd3cd421993314
dashboard link: https://syzkaller.appspot.com/bug?extid=1f6f096afda6f4f8f565
compiler:       
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10ebfe8c580000


