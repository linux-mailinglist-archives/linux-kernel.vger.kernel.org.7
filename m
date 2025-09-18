Return-Path: <linux-kernel+bounces-822023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 433BCB82E1A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 06:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E57476202D7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 04:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FA02580CB;
	Thu, 18 Sep 2025 04:27:45 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7F32582
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 04:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758169665; cv=none; b=LAH7Mk1K1hzZgv/fYklfTGxRd5bdthYMLD3fxP3gIAb6F+HR+pmnapxGHS3x8EfZlUdrPXT7M7/DXpOoKo+qF6bSWIlX0j6g8L8Spcmh2Y3j9O1v4f3CAZMpT8XXH4dQY7sDTi0j+MRRwXoxg1INt50AZ7vn6vkguA75pmjxD64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758169665; c=relaxed/simple;
	bh=Ieq1ck0qvm3ZmRsGLSRgTwo5ZTOdLuFi0WGVB/YIMwQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=C/tJMC5+Mj6uT9C/uvherA0couxofSxEGdd+lX2nmVQXxz3uGPUivatzLhVU8w0qg9uzCH+GiZ1DJ0NchGbX9bHAZAH8Ze+PQH4lK2gwbPLKhC5JEpDLriYTqcwD+2zMMoyEXOlrdKOnvpOY42UtfoQX/k3IyTDGrrT5RRvMKZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-42403886eacso5890445ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 21:27:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758169663; x=1758774463;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OV9FnEIMn3tAb3e2Fleb7GR+066UTYm6BepX40jlcc8=;
        b=Kal7SwL6TvymhQpEAYj67CprGj7TjSsRuGjiNDsIhgf0hTn+iDOVe6QsM8K6olW9uQ
         Mj5U2vM8qDAJPmyypCOafnmQONP7ZlytOEEj0ke22ll+zkH2eLw1MO/SbhwIrbAJcR/S
         KB8RQ0S1kf+bMeWDEc+5YoeyddFJZvVL5df80iOinljDvLMvSqCj3sCDDW7KTdr/3enq
         28dBfaO3GovyJJu9vwO9XpN6huyyUxKJE57fL+4iADRbgDES4iUHBUX96aG/ImDBkAEQ
         WnxUTYGQW325AZUU173XuI7T9WKP0VelWohzl7aRZsIwil4wXZ0qMH17z8HWMtArR0N8
         bXAg==
X-Gm-Message-State: AOJu0YzWdS0gC9fSsyV6u/fPrfsM+8o0C/01p6zQ7LynVkoPE75Vlxkz
	DlCoyJDzSP3hayAUHAepIpjUe8cMcuwiU5J/hBNivc4nwm5md4tqFxZtHrWs+iuG+nAp87uQSKy
	GRpt28jWM9TdsToZH6Dzb6uK8/df8dKD0PoJPtxzUrAKIPqJupBzM8hXZmyU=
X-Google-Smtp-Source: AGHT+IHtDsPbuA/DrhFUz73YZ/avUBq/9PV0Ig8Jp6Y2s4lRwxD83hRTeWz5zcLBVQ/owfhAHJAZHB4Ju/lo75lR3hlIcOcYtCfW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9c:b0:423:5293:5739 with SMTP id
 e9e14a558f8ab-4241a5285admr52239145ab.19.1758169663088; Wed, 17 Sep 2025
 21:27:43 -0700 (PDT)
Date: Wed, 17 Sep 2025 21:27:43 -0700
In-Reply-To: <68232e7b.050a0220.f2294.09f6.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cb8a3f.050a0220.2ff435.05a3.GAE@google.com>
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

