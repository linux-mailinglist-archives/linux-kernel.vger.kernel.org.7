Return-Path: <linux-kernel+bounces-784736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F35FB34085
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3CFF7A223D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81354270555;
	Mon, 25 Aug 2025 13:19:43 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F217611E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 13:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756127983; cv=none; b=jZuGTbBhItNsIZR0h9mFmSWtUK3HlA0MwTfn1uUiwXHiUsXqgWnZuFycjC3t1q7oGBQ+eBLwUEnN/KvmCBaYcecRUxlrT5pVp8TsG6hsHLMjPXOeSP36ACzSAraPJzhTNDod7J+pJRoNYjacLWLTbKvdXydzyCsq5TWbib0qE+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756127983; c=relaxed/simple;
	bh=PIjGhwZ09Ny8AS/eH4zJ7P6XZEHjFKoa9MEan83zgtg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gHImXGH8YxLtxw7ebwr1GBDSxiSrG+DHfZW65v6HtjOqifd2csN3TofnpNoF9RpQMFfnbeKtHb46dVYYY84iErLhs+Ip34J/tCTfpJzok3JYGghu+Dpdgtv1fawcoV4xONIxp50/qy2xBbDS/vu73g8ShQHct0ge8LoHRsKSBNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3e67df0ee00so110246495ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 06:19:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756127981; x=1756732781;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m2gUYnF69r+HwF1j7zvkXUbnBN61PAECmeVAxL5NQG8=;
        b=YLAhHojT2K4UN0iwl8xe98EreTD6HVp1DMwT0Ia+cXyW2fYWr2LkHXAXAqx8jiIE/D
         dQb8NKWws7WzBB5nmeMQm/rS819R4mtONpD6F68n4C/EmGll1pGJw87+a4p1mXcODxDr
         cNjreus6W5AfvUhi9vKwyD6bETysGJjQ+2WpK5HdjNlKmiIXu8uXmcR2koKsJNCi+xr3
         QrCEjUZbXW+2DR2gU8S8+EMc4yp0baxUFIkGZNsRa990VvLKzpVF/AZRKM2/XUj1gLus
         P/YZThXJkZz1LD6kx9qEtrg4m8vecmjb+hCjbdFLOTzjqjwZN0U7uSwIEwz9jXsQh0hQ
         Fc6A==
X-Forwarded-Encrypted: i=1; AJvYcCXFvibmaBN8Fj1urssr5QU6BGPS9PRWyvWIEMmHQhLyiNz5BymILkddm/M0jxDQ+GjsjNYOq6rVl7cy8k4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOdOj/oIYYZ4397C7LsSAVYxlZxI/Y5zr+D8nxe3NpbJwyfTEa
	5Vhl4Dsavma7EmyGepN1tOZV7qylf6ATS+PZHpwQVDrOWan9Q+KfJ4MpUDGD8HdoZacHwai8/v/
	9Q0wiJAjhalwJLjnyNpAR1WPYe3gx/7k4KLy3nSIXNdZ1P23eknBheA/bOVs=
X-Google-Smtp-Source: AGHT+IGgDEcST1ZgJguqZFdPe1mvb8+f7Lok+P7lCTrw7QAleIcAITPyguegeIYLapaJqpoang/aKvMl5si5pCdNCa2cRgU/Ft3I
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3c86:b0:3ee:1a2d:f73d with SMTP id
 e9e14a558f8ab-3ee1a2df976mr7223505ab.27.1756127980658; Mon, 25 Aug 2025
 06:19:40 -0700 (PDT)
Date: Mon, 25 Aug 2025 06:19:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ac62ec.050a0220.37038e.008e.GAE@google.com>
Subject: [syzbot] Monthly dri report (Aug 2025)
From: syzbot <syzbot+list64daf1ebe24085817f4d@syzkaller.appspotmail.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello dri maintainers/developers,

This is a 31-day syzbot report for the dri subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/dri

During the period, 1 new issues were detected and 1 were fixed.
In total, 18 issues are still open and 33 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1829    Yes   WARNING in drm_syncobj_array_find
                  https://syzkaller.appspot.com/bug?extid=95416f957d84e858b377
<2> 488     Yes   WARNING in vkms_get_vblank_timestamp (2)
                  https://syzkaller.appspot.com/bug?extid=93bd128a383695391534
<3> 72      Yes   WARNING in drm_mode_create_lease_ioctl
                  https://syzkaller.appspot.com/bug?extid=6754751ad05524dae739
<4> 15      No    upstream test error: WARNING in __ww_mutex_wound
                  https://syzkaller.appspot.com/bug?extid=c4f4e64f6ac2733325f9

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

