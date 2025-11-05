Return-Path: <linux-kernel+bounces-886949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF67FC36CB9
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 165B61897937
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A815335554;
	Wed,  5 Nov 2025 16:44:49 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4DE26CE3B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762361089; cv=none; b=MXDjT/mve+v1sVS9nrE5tGCb6McflmkXGrbga2loPDi8ofjnOFhYUbM6TxqrNxcOXDW4m6dO2Grr0IM/L7yh5lqVZ/4dLe3FWO4SnwzQ0TdtNDV0pXLrxOHKXxZqmw+1hlvvNKqA4e+ZcR1c3y5Z/uzPAwX27iqxJDc3GMIXzqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762361089; c=relaxed/simple;
	bh=Ieq1ck0qvm3ZmRsGLSRgTwo5ZTOdLuFi0WGVB/YIMwQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hVqKQ6uLazZ+om6CGLx7zhw8DpqSVV7Gga5kGZj3iBj9bADifGVXRPEekmfD5RlCBaUqR0bFvDUpY0XpnkaVY5IwD7WscBoqoghi8z6051L4t3z1eHgMLMCo+9CqnVIgNGxXkQVkmq8jUq5CrDW82YSD4DcfHupjOF9z9EgllPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-4334c9649d2so5330205ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 08:44:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762361087; x=1762965887;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OV9FnEIMn3tAb3e2Fleb7GR+066UTYm6BepX40jlcc8=;
        b=RkRw2oNupuqZJH9lY1zE3yQ9GkszENeIgdoIlX12W8zDgVmy4yywPYQPglseWYTtsU
         GBYA2UpZ8TjvSMIPK5VK5uGSCR2Fp9dKnhDoYF7OIm0metM6D6ku8M9c6UCIaDtA9FI4
         +LGrzd4t98YNMQRmZl6RsFtUDKbWBa3x4MEvN8EGiFHuT8Wo5Ox7yYdSoAdiEEODflxe
         JiwlQcJ9tnytq+4Zhk4LA72ZpLBGW24PVicQj7p/7vufgJFYWQMz+ZGKBfeAZp9Prrxm
         T+i++1I1m9iupt6QlgOduti72nWmXbXX9lckBazB8dtUHa9OJp4a7SEvoEart3Hw/8b+
         4QuQ==
X-Gm-Message-State: AOJu0YwCL41nuDH3KC+o7FTLOMLC8ua9FlSBHQmk01b4PYh6VJpjcVBn
	phMHTy9cyj7XNyNB+MoP7ZHRorr+QaYKhSxhwOUEsLWVLwcsI4/241409+afQGIDwL96LJDJ2Ga
	1X9IvkOsX+Kca/5bWol0VuCSsqW0M/fO/cE9rAl2ZOv5AoRRywoPW3roCrK0=
X-Google-Smtp-Source: AGHT+IEU0W1TQuzCDiYuegdXS4+aXPq+LXVqi8bZRV9iWMhDPi3lEJJKGRxU5aqEbi8Mx9cNxXXnnJLd6lbPip8V1ySNbmS60mYn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3303:b0:433:3498:6906 with SMTP id
 e9e14a558f8ab-433407d51b1mr54780215ab.32.1762361086932; Wed, 05 Nov 2025
 08:44:46 -0800 (PST)
Date: Wed, 05 Nov 2025 08:44:46 -0800
In-Reply-To: <68232e7b.050a0220.f2294.09f6.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690b7efe.050a0220.3d0d33.0066.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
From: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
Author: yanjun.zhu@linux.dev

#syz test: https://github.com/zhuyj/linux.git 
v6.17_fix_gid_table_release_one

