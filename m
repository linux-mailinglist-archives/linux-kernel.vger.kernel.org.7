Return-Path: <linux-kernel+bounces-746663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F13B129C3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 10:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 006307B18D1
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 08:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A36220F24;
	Sat, 26 Jul 2025 08:56:43 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D38621D3EC
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 08:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753520203; cv=none; b=jivYGS3QZUzjgGdXc56AmXbe+jk3TOGJoMt9PmsblvzVqnc1g5CmWM1j5394D1G+OEePJSUhB8XDtV3LtKfjAZgEILMLmhwdBg8Za316GSeBIFE5MFsUcHLAi1V0xfCfCCO33RpZAT+qfZsMDmGulzd6cKgTbcRZMH0vqyiH9RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753520203; c=relaxed/simple;
	bh=WxyAHfqMa0TidQihQRz/fsw4kLrAPPv01ZSpwf1Ruyg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mI0Em/yhLaiEamFQUTynkHAWHakHnc5YJA7A/sQDDCEsYLRUU3a1VFqx+VT75sF/G9VfshOcwe6notnJzV3Gl5O9IJ2EJtwd0bVufkNA3/Pt3Rl+Z0nel6UsC2YtQcW6efgTLzC/hQo6wWxo9NrIfmHr2DOTGZ/u3rdcmNfO2Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-87c752fb0f7so412354639f.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 01:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753520201; x=1754125001;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2iqLiR1u0VxMcoX4EPcYCbCEhjF4vPdzd8KB0iaemA0=;
        b=dAAGQi8dwQxHZrKew40YDYJuZJ+VXq+syXmkgW2xOWoykD4lGGk8QozCE6phrlt0WW
         nm5yJKERYq5A4ZBCaE/mwOW4Mx03RqNq3ZFSdA52K9O5wRcUzjYdH1r7C7QqSxCnJ26Z
         PXWeIM1RY1WD+WnTbyrfL8vXQJAjERb+YAdr7aYp1fv3SjuTpr509QBOyRM/+vsXjH5a
         HjRxRyO8ZsgFr409o44Qj0TKBgROtZcDyObi0bJjXsDkC0XCWhBp7zn2K8uKYXtAcUtW
         NLfA0BOcbv4AtLdXFLzhgjqNjicC5wS19aA3jUo/+Vm1vftHglJoiyl1Zl8XXKlVzU7W
         wzQA==
X-Forwarded-Encrypted: i=1; AJvYcCVBZDN9tdaqjqhGE/FErTsPGM1PEHs9w778EG20i2WkB41VnraB8FlB9yB4VVkmaFgIazvqnYFbaaWJnD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3AJHKvEPCqsdejwKAc759ZwaqiLQzqiDH4G/8fykk4XDHt/as
	lIsfxcHyPiya8mGLUmCfLL3AKhKXfElJ4F0CIkpQ+LQ+JrBrlTFDZCwS81y3cBR9IfOUzcSbYLQ
	VuivUyOW9O2g/IA6+F5pIT1zvOBUPVTfIqYR2CDo5UsnK9uVu52MfMaLrrew=
X-Google-Smtp-Source: AGHT+IFkl50Hsuu1sfNG5LgyMa6MXBFfKmkAArB9GXnU4YCFUP6oQsqf0KLCjTCFdqUQ90El+HVpOc+LjcTc/fe8VbB533Hw6u9q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1515:b0:87c:2e82:5a6a with SMTP id
 ca18e2360f4ac-88022977049mr980524939f.4.1753520201332; Sat, 26 Jul 2025
 01:56:41 -0700 (PDT)
Date: Sat, 26 Jul 2025 01:56:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68849849.a00a0220.b12ec.0013.GAE@google.com>
Subject: [syzbot] Monthly hfs report (Jul 2025)
From: syzbot <syzbot+list23f95ff4a4eec7a61ad2@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hfs maintainers/developers,

This is a 31-day syzbot report for the hfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hfs

During the period, 1 new issues were detected and 0 were fixed.
In total, 44 issues are still open and 23 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  13491   Yes   possible deadlock in hfsplus_get_block
                   https://syzkaller.appspot.com/bug?extid=b7ef7c0c8d8098686ae2
<2>  8835    Yes   KMSAN: uninit-value in hfsplus_cat_case_cmp_key
                   https://syzkaller.appspot.com/bug?extid=50d8672fea106e5387bb
<3>  4533    Yes   possible deadlock in hfs_find_init (2)
                   https://syzkaller.appspot.com/bug?extid=e390d66dda462b51fde1
<4>  4396    Yes   KMSAN: uninit-value in hfsplus_delete_cat
                   https://syzkaller.appspot.com/bug?extid=fdedff847a0e5e84c39f
<5>  4202    Yes   KMSAN: uninit-value in hfsplus_attr_bin_cmp_key
                   https://syzkaller.appspot.com/bug?extid=c6d8e1bffb0970780d5c
<6>  4164    Yes   KMSAN: uninit-value in hfs_find_set_zero_bits
                   https://syzkaller.appspot.com/bug?extid=773fa9d79b29bd8b6831
<7>  3235    Yes   KASAN: slab-out-of-bounds Read in hfsplus_uni2asc
                   https://syzkaller.appspot.com/bug?extid=076d963e115823c4b9be
<8>  2961    Yes   KMSAN: uninit-value in hfsplus_lookup
                   https://syzkaller.appspot.com/bug?extid=91db973302e7b18c7653
<9>  2325    Yes   KMSAN: uninit-value in __hfsplus_ext_cache_extent
                   https://syzkaller.appspot.com/bug?extid=55ad87f38795d6787521
<10> 2283    Yes   WARNING in hfs_bnode_create
                   https://syzkaller.appspot.com/bug?extid=a19ca73b21fe8bc69101

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

