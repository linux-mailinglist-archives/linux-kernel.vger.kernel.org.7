Return-Path: <linux-kernel+bounces-771713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50705B28AA0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 07:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45F3D567879
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 05:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E32A146585;
	Sat, 16 Aug 2025 05:18:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76E933EC
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 05:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755321486; cv=none; b=QrYBW6a7Bkf8vCDq2aXmiyw8PJMLm35IZj4akB56ri7cdyIgko1/ruU2nMXqARzvGpYQf7+MO9gHik5PPptpbIegVVlDq5Dk8hETF/SlWHjB5kHw5I4KhMAF3j3AmhP1ROaxT6b99EZ5VLsheiU9rxvBmwxwbKKwTr0fGs4hu8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755321486; c=relaxed/simple;
	bh=io3Hv8vW2GfkruYoxKJG0pxpEnhKt2XcCVRWWlBAK4U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=D+1KRdzyr/hjgimQCu1NZKA4c9vXXlheeXOltqPLnVNtNZ0rmkGEYma0aC2yxLO7lBRt/KliyhtuaIIV/5bpHfdSSPfHCHtth8jVlh5EROX7Ng+YPhAY8paWTTfES1CPK54n+zcCRSa2LBeakNFBdYCuhlEo1DIMvON0j9oNzQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3e56ffe6c5cso27943105ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 22:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755321484; x=1755926284;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8BJJtu8Te7V4CRTaYfbVKikWDYbHP7MOTlXeWB7H7hg=;
        b=gJew0tDPcqQriyhHZADBvjfAkFXLh5DiTOznOz6mmqy/p9clGOAhzlTBtoY3CI6gzU
         Ik9STw1PE+flVADXrknCL0wBdisZ5EaZtXJ3HP0bBgfFgG+ZunWy67fqKQYwrk3EGzw9
         a7jXkLEdwcTB7NKY1Xc5q/23BmrcGFyDWLam+WVcTIGKF2/Q4rAjJ5AJV/t6to/Jmitc
         XMkMWM6XdomgmMNzCyLeJhIQ0SbDjCHExxtBu837ErXFk5re/2o6varqMsdI5G50YqfK
         LJivGzfEYQjwUDqknRVPVJTN224JseqyqxaaaKWxxcbal8V2cGtvCZGpiOUvw5v3pii8
         QJFw==
X-Forwarded-Encrypted: i=1; AJvYcCUGBRp2nls4NcnpcS9YG6WV2sILxbUDdJNrOCWRhqC7pJXGcMhnS1f4BxEHn1E5QCm7yC9cqfSiDBQZ5yA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYg6OT/I+FcHsncLSF2kZj+lXPlYUmsy/y70WJL2OOhZjr2kZt
	EMwBb0+zVMPYZexXt2IdB0Y2NyWq/VwaxN+6TkvGs7DHPY7GCYRLAtzaQgV57nZ3MY3NwNdtsVE
	WMJqHdvNYbctFAvCdazpJGyMuxWd7eaETT5Lvh2wDfRN8q2y4s7o+GBrY/KU=
X-Google-Smtp-Source: AGHT+IHc959CPSE5C79a8u28PKibxaO6zI8wEtZYBd/ufjjcHQfbGyXWcx32NcbQYE5wkhRsmMSzZ4KaYIqaHWBcaCVbLs0s5qEB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18c6:b0:3e5:3d13:5d80 with SMTP id
 e9e14a558f8ab-3e57e86aa7amr93915845ab.6.1755321483896; Fri, 15 Aug 2025
 22:18:03 -0700 (PDT)
Date: Fri, 15 Aug 2025 22:18:03 -0700
In-Reply-To: <20250816042357.4704-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a0148b.050a0220.e29e5.003a.GAE@google.com>
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in mremap
From: syzbot <syzbot+4e221abf50259362f4f4@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/smb/server/transport_rdma.h:64:61: error: expected expression


Tested on:

commit:         1357b264 Add linux-next specific files for 20250815
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=bb7fbecfa2364d1c
dashboard link: https://syzkaller.appspot.com/bug?extid=4e221abf50259362f4f4
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1760daf0580000


