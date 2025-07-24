Return-Path: <linux-kernel+bounces-744586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF367B10ED0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26EC016A598
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42F92E9722;
	Thu, 24 Jul 2025 15:32:46 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3825C1509AB
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 15:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753371166; cv=none; b=RZSm+ItP3NTe+0SijVpcsSmyy4t1wjGvyrkOLM5Jv3C8eSCupTczfDFmGx4to0+Bisz5vImiNihP+wTIoK2QHjotWM11quWKNkYIOQgvhDCfI0AH0iIAFmLraxSUVWdsEBFzZGmVdH/vZRS2pMQHpzv3qfooJDT7ARtN8CcOHh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753371166; c=relaxed/simple;
	bh=nBpKhmlTj55NCyRKUYTxzst2NZLoJEkadcWsoTNO3h8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DzteNi/0uP9e8fCyu/okXVguyzzUBMvOt2MGtPd1mw9QXN2k3tAG7H8TpwTFLTujF5r+M49Kn20Fk8B577Z91gVlYHUxoO3KtTWqnmdbi3WUNVMjMrPKlahl3odw/32Zs6yTRKZPswCWhnkWFF7vtB0tHrpkNoZrKVxL9QJZzv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8649be94fa1so238743739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:32:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753371163; x=1753975963;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rxE+fhHPw2IB0bN2gcQV1kCCrTzim3RENUV6KzhP71E=;
        b=sAI2AoX+Yuzhe+HKG9vVA9iLSkYNCya5snjn+c/OWe7pm37SkPsgwpD5cEjSIIisat
         VRsjDuWn15Iv/qwAbAuDYpmFY66l1Gpe4CsJqSR6JT6ikHdVMn4PHaVNaKhbcTK6M8JW
         thYWGuHXcCJ3/q5YqpKueR1CKc5IPkqdH0AP+Qf+NyTQ0b5n3yIBLfgafwbrDwwNlk9r
         1II9FD6MttPTxw4oT2FDQvdvPEBlXG02XMI85t94JaRPJ5rkp/AvH1MTkSaroibTcqFr
         h90BrDokK0so8DU6yisbp5IAbo1mljewipF/Tjn30aCiLhYMeCg/BSavG/I3XKtfsBda
         E9iQ==
X-Gm-Message-State: AOJu0YybP2GCcTAwn+pqc2xf1qkeGwATk17syH5BnaL6cXtBku34LFj7
	6JCSVsHR/+uRH2+BZEvw3zUsJOxvo7G7pJeTQwO9cb6Yhb8VqSV2aAHknldsWzHhNFkZAhk2EYe
	XqkethcjzVm0DcD4U86mU1AhWHuSUINItMmVMO4Tq8DwC0Zq+mNGr9heVuoM=
X-Google-Smtp-Source: AGHT+IFhu1zuCOSy+tFwGcmSoFqP6N6Xya/0bOxDO8lAA5VN9ZlUNIFMlkRnm4zjFcyMVhU1S5LHD/A0Mlumi3sjcZoGLmExaeoo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1649:b0:87c:3b0a:8a90 with SMTP id
 ca18e2360f4ac-87c650436b7mr1315569739f.12.1753371163314; Thu, 24 Jul 2025
 08:32:43 -0700 (PDT)
Date: Thu, 24 Jul 2025 08:32:43 -0700
In-Reply-To: <67e9006d.050a0220.1547ec.0097.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6882521b.a00a0220.2f88df.002c.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+ab13429207fe1c8c92e8@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz set subsystems: afs

