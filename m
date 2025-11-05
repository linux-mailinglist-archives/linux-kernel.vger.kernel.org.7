Return-Path: <linux-kernel+bounces-886330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D69BFC35465
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 12:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE6CA625FB9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 10:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF1F3081AF;
	Wed,  5 Nov 2025 10:52:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8302E30ACE4
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 10:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762339925; cv=none; b=mG5O6NF0nEsgXPPF6FL/7MZn44g/9BEkygPCU3gteaxpB7FJ/e5QHXaUx+chg5gqoELyeMBGj3rbyg0c5IjM/FAq20GglRYZZewYFsVzwSasl8azCLhLbzch+/u7NeDosYm9F6vKywSBPOpDBrsVHnyUhSI/m6xprkQzb2bIfGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762339925; c=relaxed/simple;
	bh=MZIUTDUlLfJirMX9evaXHDyNYsjcHZ9WEC/P7k9Odow=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EDwpgpwGYjZky7KPFugPghG+v2sEoyxh0n6NRZRrnI/H8z24/zT2Z0lFBbPGB4u5nS4HDps4XLfcTWhOlr6Q/7H5FjtON4q+DoGJDuicS3xygqCl5tBy7h0z9pbabKpBWy1T+FSK/cx0HJDKazZ9LCdtm2nQyLngrOG45rdmgr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-43329b607e0so90639055ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 02:52:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762339922; x=1762944722;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MZIUTDUlLfJirMX9evaXHDyNYsjcHZ9WEC/P7k9Odow=;
        b=vuNWB76t4XfUf2mYR0VNynmybkkxFoYkYLtcon/dlsYyxfYNMkXX1a0uizaI9z4j1P
         KmamYgktG5VFBGwoXauPkGhOiyXSyF4w8xTSA8vRLxKKbQ0iq5AfiRJLQ3X3DGVJHeUc
         4udInf4gzsr6uOyaKEYDsiER2eLxrez0k89j26ppzdACuDin6+Uj68MBMq4y+/SCGIwo
         GQymwARjHpLlwwqdY8ZE+jJsjz0OCJgwtUQhGznuyeXvruZ/ryC9D6gJsjFO0NMm6kV7
         NFd3FudW0Z7zbbvN4TtNayAwV8BbBU6wh8aAeWKo++N+myFdvKhND0kM2TCF71IATPdQ
         ORBA==
X-Gm-Message-State: AOJu0YxUDidh+WUdepIzcntl+8nQ7dZRIbrXAtcVYWpF5e1H8r7Io5cl
	Y7joX9iWXP87neWffNnhMuj53p070nQnbcMbLlW3k94NEUOmG73CUI9mL8bNXSPgh2dzcJafQNi
	zqsxYEjObLkHlfLXNgrN39357Huu8mrZMZWTNgWeQujUfNr3ycxIwcb3L868=
X-Google-Smtp-Source: AGHT+IHXpKu/xj/EplpMateagf13cSjHnUoJcRIwmtKIOAsSjHNrAwCtt+pWby5yghk9juuc5LimwMZgeV3Y+xkodRoWcGtoQwGx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:440e:10b0:433:46fa:6a7a with SMTP id
 e9e14a558f8ab-43346fa6ba4mr9310585ab.25.1762339922589; Wed, 05 Nov 2025
 02:52:02 -0800 (PST)
Date: Wed, 05 Nov 2025 02:52:02 -0800
In-Reply-To: <68dadf0e.050a0220.1696c6.001d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690b2c52.050a0220.3d0d33.002c.GAE@google.com>
Subject: Forwarded: WARNING in f2fs_delete_entry (2)
From: syzbot <syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: WARNING in f2fs_delete_entry (2)
Author: zlatistiv@gmail.com

#syz test

