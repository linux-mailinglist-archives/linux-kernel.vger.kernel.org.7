Return-Path: <linux-kernel+bounces-864720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8835BBFB676
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C38EE34E5DB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3898432252E;
	Wed, 22 Oct 2025 10:28:10 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B626F350A3F
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761128889; cv=none; b=FC6Xh+1KL56YA/2j9xLcGNRGk+mDkNsyhJjtuOdKg4jH4vF7oLobUPCiDRspd6T1+Etn4Pfsicg0krruzdBydwHGOgU8/IlR6ulj3hJqNOG7DpWuT/RFhefO16A1Q5cyuw7BtDmlDGNPtr37TIpl3qtHiDkujq1tNtpfMyFx1pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761128889; c=relaxed/simple;
	bh=kdSRc2n+zbf34pa4XAwNzC2gPjF4Pjl/j6NHxK3mEDw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pJS4YOk8JTcy3LLVoCLvJ/M7/zaI0bSCR8VaiHvFCmfTrjnlEH1WSN3vIOqGl5lL7fi375Zsk39KMUmzenDoQXIVirAnFDFTiNEJxHk9u8di14RdE4RrzgBGOMP0Bm81eLMpwOUw8+lbErfNc7ENiVleVprtTCDpvBaeU6gefW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-93e8d8d227bso1245898439f.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761128885; x=1761733685;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kdSRc2n+zbf34pa4XAwNzC2gPjF4Pjl/j6NHxK3mEDw=;
        b=pxDx4F9VFA0SyOj/jNuH5TA3dNM4Aw+eRNrBoVYtx21SgQchpFL1TBe93ryEPHPfuX
         KjYu3DQXAKCu59atTo00nbeps327m9C8wiPeli9sS5GQFZxcvA4JilE1U5/afW9K6Hyh
         OsnTmy4S4ku2aJvUDZyoJHWIzuzVkBC8qzgPqyseIRDsUUwMs3ny4MZtT0SXVjJZTtfE
         jeocV8G6F3Fx7GBo2k6qdpZCctHpHNELHuiV6mB4lxIKEv/6gi2M+SiVFzh1wSxsppzY
         Cj5rKjkF6IKTotIOCsfAQZsnOh5Em+JFxmUzgUMa72GrBfP7KVJ4/i6Cojq7XTDRK6hg
         YLKQ==
X-Gm-Message-State: AOJu0Yw/u+GDXKoxdRTQc1zcJSDt/q8VbEkkSyYgrtSxOIb18pcFs6k9
	CuXLHw6+2Ua9eu78sC8KEG76Oe/16jBV3mRxOCnp7LMDu+wkYzCH+i4jOKR9xnSc3mXJx0xAzFL
	W0hfrhCr5EqjziZ3jE6intUT4dUEgxJ631w77kUERGfh3VCgRuUrYSvhyMWU=
X-Google-Smtp-Source: AGHT+IH0/Mxrrle46D2hwDplpOjOEMMtM5TyHvwn3ysiJSc30GrMowMq17b4G9AGgkHlCYJbWSkD+cPWwOyXrgHe+iIOZboT9wIL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c266:0:b0:430:a5e3:fd69 with SMTP id
 e9e14a558f8ab-430c523046emr320126515ab.12.1761128884873; Wed, 22 Oct 2025
 03:28:04 -0700 (PDT)
Date: Wed, 22 Oct 2025 03:28:04 -0700
In-Reply-To: <66f86aaa.050a0220.4a974.000e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f8b1b4.050a0220.346f24.003f.GAE@google.com>
Subject: Forwarded: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
 552c50713f273b494ac6c77052032a49bc9255e2
From: syzbot <syzbot+4d55dad3a9e8e9f7d2b5@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 552c50713f273b494ac6c77052032a49bc9255e2
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 552c50713f273b494ac6c77052032a49bc9255e2

