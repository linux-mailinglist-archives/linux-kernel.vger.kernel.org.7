Return-Path: <linux-kernel+bounces-797339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECADB40F03
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 23:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF4FE7B2C14
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 21:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81C734DCC9;
	Tue,  2 Sep 2025 21:06:37 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91D126D4E2
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 21:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756847197; cv=none; b=DKgwuFqR4y9UvwcX0jznyipLcQcibGVesa6I/T3J4tzUtJ8PZpxd5Na2+IgJCKZGXWSgwoeUcEXvAaDEEV9cKGPyaUTZdNCkUvdK7Xu65EhOINMSdjlL9rsgvmFR345/d52oN5TpU8QCM9H955SGBpxKlgJriAVXVWU7YjWjm+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756847197; c=relaxed/simple;
	bh=KEZ1QsY45N9abeRGl8TeSLjuOHGfY0trkjI/mDK64tU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aYJe5eGvqI/UkVajUeNEa/v4RTWUmgByr+xUm1AjCqLMNu71GBej+zynNHceLwanlQsDGVWUaoPZSn7Y4cfXxT/HOHAD6KxZPKIqIUO5OYrqde2tKKUb475S72JeIYPX9K/7FQzQs3W4qofWZ26jk+menqJh4wagMzTpm1hXvps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-88714e1fd48so451320039f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 14:06:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756847195; x=1757451995;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=41h/fxFrHHHSIpzeuXbrHJZ8l67QaC9sTUVvghmxRMI=;
        b=d7cEizWPloqb21w9YPNz2fwSdrGL59aOwxpD2mR8FWFCk97rSxn5HKTxqsJiK2qUm7
         /2Bck/OvOw1IVdxfFoGrGBogxoiEMb5GpypuOnK4rPiDopnh48QSysD72+JXg2eOGEGM
         35LMGz1PQV1x0uB+X0KXksLlqd/ERwv85hnY6aR4fU3NQPKohoIc9Rj5Y7e/C56PdmOr
         4l15bw5gknvhlwpidKSXH5xCgjFnonFRbv7wnnsKvBhFYWE2qpWKpIr6XDWSAOc6bYWV
         P7AAf7zl0ADUbyoYo3y6VX8PKwSI0ueUhYjhR6pmmNBCnHRlcfoJDZsUYqXwLpR0LVTE
         mEYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeHISas0UbsjZa53gxruLlF6StuKcrWpj4DAO/tqjwe/89PKoMMMFmDbowBLLsHzXCCBaEii5AMZfgjKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYgosUi9CIJQ8BXmY+tlrjlvad9exzE+V0AK9QU4Nu/wwqrbXp
	Ar1oKt+HpCg+U0FKMkmoxhq84SuG1cOhQAP1p8n/xJ+CstW+OQ2NFsxbiWw1SJc8UIbjBaxniZz
	E3LZ5mkGymQzokygLZ1YE3G7xKbbKzaiwPAd/F3PprHUmEhxwbo9GRRRuQEQ=
X-Google-Smtp-Source: AGHT+IEbesGwUbfY46T0C2ENb3b6VAKGOL0X4IVVvDeqsGJGY6wbBZzzfs9Ts02DBEYK2wuN3CEz5DEh4885f+pTlY9yCxdMw+PD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3fd1:b0:887:4f7d:b57a with SMTP id
 ca18e2360f4ac-8874f7db6b3mr180261039f.7.1756847194947; Tue, 02 Sep 2025
 14:06:34 -0700 (PDT)
Date: Tue, 02 Sep 2025 14:06:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b75c5a.050a0220.3db4df.01de.GAE@google.com>
Subject: [syzbot] Monthly integrity report (Sep 2025)
From: syzbot <syzbot+list41af652b77fe84ce1a91@syzkaller.appspotmail.com>
To: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello integrity maintainers/developers,

This is a 31-day syzbot report for the integrity subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/integrity

During the period, 0 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 9 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 39      Yes   INFO: task hung in process_measurement (3)
                  https://syzkaller.appspot.com/bug?extid=cb9e66807bcb882cd0c5
<2> 33      No    possible deadlock in process_measurement (5)
                  https://syzkaller.appspot.com/bug?extid=6529afa25091aee8536c
<3> 9       Yes   INFO: task hung in ima_file_free (4)
                  https://syzkaller.appspot.com/bug?extid=8036326eebe7d0140944

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

