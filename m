Return-Path: <linux-kernel+bounces-754238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AAFB19059
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 00:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2E4C3BE364
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 22:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39C027A935;
	Sat,  2 Aug 2025 22:44:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F1C1E489
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 22:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754174645; cv=none; b=ZU1jxWOy+BJC5kCtWdb6/b1jupxnaz1UTRNVHdeGI6g/4O285c8YcPoF6napcsWWQ+I5eBkDmdrfjLs47epwgsTnhres0493bNQq1HbAEtbbABSs4psDcOylsr5IL8ifPJxGhCCZiyMx04QF6qxHira5ym2pPWHO5pz2g/zl26Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754174645; c=relaxed/simple;
	bh=Sdsw9E1XRGAvWF3elsZbtdS81z4vwi0idLl+UXzLOAQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lAZ0HeOr+Uj0SSIjNORzwbuMrvunbCb5v6UObAaB4jC01PAqwTRk/lgsYcGf/7wD5ndlWEviNkpCBtZZR2ttn1/nlaEQ5VvMebaK799ZEYV+VwWW85BX6Fsad3DMk7G3ZDMbjwjMQoJj15bmvdNMuHsyyvTte5cyAuCkVkemF3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-88174f2d224so36670639f.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 15:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754174643; x=1754779443;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d48amM9oxd1O1snYXoj/VGL39FSgtfsTYsEq5Eum/3U=;
        b=i8PT9f9iB/M5fZjX8kVu12Y3Ic0liO3oke6zPyB393dj3UwlDA/IYPAtVVvQhgexBk
         GaM+dSNdOKXmXnfHqNXNH6fu1KMHVIVXi+EeTtK4hhg6bVTZryJdZ9dCB6hofY6Wn/tg
         kim9akZB7UKyEgk3gOreP1c4GugZ31tHty6ZII63yUAu30USdsSIj7an8UkKPp/q0Dyn
         UbOMl7yMowkyexlNC/uITxzzN38085kWXqsY5GrZA14lQntehSHsVqHY15FuAVtn52OL
         J2RtCQ2jEkc7SjkEWMRSdyiKe5/tzwARqEH6rkKXFXjjddwuvAc/KkMSMH4Af9KwXNUh
         lc5g==
X-Gm-Message-State: AOJu0YzQG9umLJZFIY8VXTZ0gFAYQxIJ74GXcV7EdjdBAHrUyfUxzhRv
	JXTzfjIlPiW3O4s+Z30qCNs8r0AfKsN3B8sqx5yevaA3MfocdAZeZZrYW+fuktq+IRvw89B7Ba0
	Aug539TFa9pa0cDXVo/9SMQrKrS9SjTDPS1mOixCA4+jj29x9igaBFjxeU7Y=
X-Google-Smtp-Source: AGHT+IFhMcyhS2wSFLXd6JJekXTOi/ahyC7dOBv6+vynWwJG/xvHmet1si6ciKDDfFwS7HmizFN2FW/OQwwvSwjNQwPi++NneurB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1f0d:b0:3e3:f1db:d352 with SMTP id
 e9e14a558f8ab-3e41616f18amr87745165ab.15.1754174643091; Sat, 02 Aug 2025
 15:44:03 -0700 (PDT)
Date: Sat, 02 Aug 2025 15:44:03 -0700
In-Reply-To: <CALkFLL+WiKWCw1zOPhBJZ=wLQjZPYvhUhEoxDOmeO8F_w7Vmng@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688e94b3.050a0220.f0410.0146.GAE@google.com>
Subject: Re: [syzbot] [block?] possible deadlock in __del_gendisk
From: syzbot <syzbot+2e9e529ac0b319316453@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	ujwal.kundur@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

block/genhd.c:743:19: error: use of undeclared identifier 'set'
block/genhd.c:745:17: error: use of undeclared identifier 'set'


Tested on:

commit:         186f3edf Merge tag 'pinctrl-v6.17-1' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=921f306d77438390
dashboard link: https://syzkaller.appspot.com/bug?extid=2e9e529ac0b319316453
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10b2a2a2580000


