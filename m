Return-Path: <linux-kernel+bounces-754207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F77DB18FBC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 21:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 298AC4E0221
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 19:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8761DB377;
	Sat,  2 Aug 2025 19:00:46 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B0428E0F
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 19:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754161246; cv=none; b=K/fxN+rGUfssNXzL2CfeDACLZF+pcm2L++++bTKuJwcOBhWqJutv1P9sFeMDJaqb1o6XFJQBtxGxjkNdd5KfAwjudR2hyTgwwNmVredVkWfnfrOqGy9IaLk2/O2CpCEeXue2//Vd+Rkqp9Wm6j4NX1i6YS8VmVUKN5TKOcZiPZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754161246; c=relaxed/simple;
	bh=seZIdjhEqK761PCns8qafAjkaYmK058tk1d0tISUzi4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sO01fnDv/1ZJyt9Le8vr2IVHtzISmtiIijA+sqAU/wAb5nDPHLWB2dig5UGl/Y8pAo3QOd2gEd/TzKFpHP020oMxiFl0oBymG7OQZ0yqPWcVD9llctudB3z48QG5tEG+VQs7uGoKwcQW/7lk/NP+oWttP9I4knpTQ25cploFi/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3e40c0ffb1bso19576525ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 12:00:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754161244; x=1754766044;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=seZIdjhEqK761PCns8qafAjkaYmK058tk1d0tISUzi4=;
        b=lguaqI4mKaDc79QVbtIzhaAqWew9+yAOaXAFPP53y4gwaJbPaZ4As6g1pzLCJNLCkU
         mPfql9o2fUlVGfyi0aD4ic5xEhOe0wFY/pa0kXFndWbvr3nwnP+amwwAoFHI2TiNCLLq
         VwyibHbG44DUv/Cs/pCnYyERwLSTYGSSPqCa55V19edoKNOxC3rA03ViklhLGcCOBPvd
         3OLKAOEPSpdm81vB9d5rE6SOACneXJhL6ngwAs+gz+sOFyNj77QLARx+G63nV/X/lJaL
         Oqf23SB5VYF+aBmoIbLeZrrdw73hxcH9Ywg3h6Yoavkj92RsoL1fTUZGh1fZbD5EumEO
         +E1Q==
X-Gm-Message-State: AOJu0YzXgahHrDxUDsnIoOAc246308l4F9BC8sPmn3sIsifY19pys/7o
	6eJ7cwRdv2TzY8H4q6MYZZRmmGu/PYUJ33wtQY0rLI6E3Sp3RSvyuUyRbFxBJ4hWknFXJxp8mYN
	+uETIzPviKnlfzuyX+oQH/qtdOWMjNVoXVyVrogNvD+GLSZ3cTObYSHnSZMA=
X-Google-Smtp-Source: AGHT+IEPkhoqWs25uFnOVZTo8UcI10GsHPAoUrFzWr4Eew2q4/hXpjAwqia1Fej/S5EJXubaChJPa6Kg+m1fF4azdX77gCdgx9ug
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2194:b0:3d9:65b6:d4db with SMTP id
 e9e14a558f8ab-3e416191d1dmr76344535ab.12.1754161243822; Sat, 02 Aug 2025
 12:00:43 -0700 (PDT)
Date: Sat, 02 Aug 2025 12:00:43 -0700
In-Reply-To: <6834671a.a70a0220.253bc2.0098.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688e605b.a70a0220.249f57.0009.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [block?] possible deadlock in __del_gendisk
From: syzbot <syzbot+2e9e529ac0b319316453@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [block?] possible deadlock in __del_gendisk
Author: ujwal.kundur@gmail.com

#syz test

