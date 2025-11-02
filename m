Return-Path: <linux-kernel+bounces-881837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 807E0C2908B
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 15:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 127DF4E62A8
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 14:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D381B2248AF;
	Sun,  2 Nov 2025 14:52:04 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB318248C
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 14:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762095124; cv=none; b=RWS6pUBbeKYz8FCMIJ2XG8TH4xmn3E25E8rsS36zSZnOgrs4LNcYP0eC6p1T8eTs2/4W0c/qRXFUC5uBZ+vi5kGhRkWDZpx5dQ7xRD6fRL85M7j9xBRcThw7T8GtifmeGSNH0mZFrBIJeky3Lxc7zNCCvnPzqgoKg1+UWX41NxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762095124; c=relaxed/simple;
	bh=t6e+68OJi84B16/sMBj1xt8bNe3d1gPBOVF6HnDOcGo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jRSDuMLrihImxb+jHhz+PmjLvKDKZ5V4NfkOLoUF1uVhYnWz5lJHSZSGgPi5YDYg/EDNqaq5U4zOVgwNLoshknO2+fl0JN8Uf7NUIQsencTGBBmzZ8M0ZOxPg4Y1x/DVZ4y/65oSvPqvIwWH6A6i0dx9gwaCMviXGposMSFtaxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-94840e58f1cso65794839f.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 06:52:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762095122; x=1762699922;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5sxHI5MmccRRExjvQ82+EJE8EzjhnD6bq9lWk4fw/4=;
        b=od+dYLex/hN6TCszWJre0Gqdil3pPfVl3EDfv4iYqqDbFpNNA7I7ZFGcmCW8eA5NO5
         lQwY/U3my9aFnfJLBCLp1/dJ+GK6nyIYEXve0As9QvfG6IGoTycxR2K/w3HqB3yq8KDS
         fvzGj7z9XuVU6028avcGEKNIPvWksxg5Cqrd3htM9bG4ONIwzCybsaslxaGIG0bRekjO
         jVVxEfnhCRkuFQYbgb6z/n1Uhps3l6dd4a1lw0YUten/lV0h4x603PcJGHYEkUW+s+w1
         1CK/mLXMq3WFA7hhSOXvhKzUMJexIN7M8hoWNjcg3oyrtxR7Iz3cjm/U8okz5iSQ0RaF
         k7mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgR2NVjJ2adkRKDKaJUVai/YKCt64hzajH4rI3ceEFRVKfI6y1cHdheSk9SXPLWdOeJB+oXWL64vW9V80=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfcCALlBUbJ/CvniuBkHfmJrUjubCehX9iQTVMFxUd3wuBRucr
	aF3aXoTI6D7cj13qLueDUH3l4rIDm/lOV27Xv2F4LeAvW7vurQiba2DwGPDcCIiLmFq3W4TPW1m
	8Oxilu4d+1EM8f4IchmXBf9Z7NL9DVXM134I/2EyXDx4wkfzAO8vnLhTycKk=
X-Google-Smtp-Source: AGHT+IFIAElTII4pbjFoA1kkQYAJFKBtdubd9D0yvqQnXyPjziQLuPg2x8TY8qjlLCh7qTFywPsaqyF/5vh9PiMPYo+iHCJX7RyW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:23c9:b0:433:2aad:9882 with SMTP id
 e9e14a558f8ab-4332aad9b53mr21312235ab.23.1762095121930; Sun, 02 Nov 2025
 06:52:01 -0800 (PST)
Date: Sun, 02 Nov 2025 06:52:01 -0800
In-Reply-To: <75345955.3491850.1762094510741@kpc.webmail.kpnmail.nl>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69077011.a70a0220.eb9ff.0353.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in minix_rename
From: syzbot <syzbot+a65e824272c5f741247d@syzkaller.appspotmail.com>
To: jkoolstra@xs4all.nl, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/minix/namei.c:211:23: error: use of undeclared identifier 'EFSCORRUPTED'


Tested on:

commit:         691d401c Merge tag 'spi-fix-v6.18-rc3' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=28cc6f051378bb16
dashboard link: https://syzkaller.appspot.com/bug?extid=a65e824272c5f741247d
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1180132f980000


