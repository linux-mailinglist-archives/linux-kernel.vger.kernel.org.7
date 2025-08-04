Return-Path: <linux-kernel+bounces-755562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 643DDB1A86F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 19:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DC5E18A205F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8AE28B4F0;
	Mon,  4 Aug 2025 17:12:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39961E5B9A
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 17:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754327527; cv=none; b=dwfoFraFiMDnRJtXjvMH/ROgj8qzrwPcJwF1SYGkExw2iOc2dc/pAEbsH9CJMWz8gWQh34wqJNDlyFvNnovQ7xt70zgDXjCLpTel+c9X/CXQ8Pp4cCqPVP0ury7rN54xFtsHzdi+4EVHtmd+oNmVLy0n+OBO0Nj2vFZvMV61AS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754327527; c=relaxed/simple;
	bh=jDpBEoLfJLg9TqVGHMxqi8W/lOa5wlDa+Cxrc0dThmM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FnLoVi5gMiw8ZZ0teeDFbUuNJ9SzQR5ygrOuaSjqbseMtPYpJrwC6d6WZXvI7BORdkZqxHE5kX5ZYT6sqOWHQ6K0WkkXRCyZslKeVtQnksw/SUfjfaDxJ5WxJ9ZJkW/DXdpTkKPdtWh0xU9chvq3i/38YiXO76bDwHpfCVdE4QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3e3e69b2951so42400025ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 10:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754327525; x=1754932325;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hhBvl7iz+VJC4CiSokTX2+c4voXR8HDcpdVyTYId1Fc=;
        b=NG+1icixp1byBySpy9zRGhHIHV039qM4Ee+oWJuYGs977EWHnm369Hfjp055XdMCDy
         1CqWs0n4xPzCau1VcUVx421TFwZw8OP3u8/ljewnych44y5SC3zNMHLW9DNTaVNPj047
         hLOTKX3GYXcBujZnB35QxWT5DagA4K4Zsc7yHJ+wrbsKW5IlKavgNMcdwAna+BxiIA8Y
         xiBZq7hc62HxXR2Pg7zJvjd5yggPcT60zZuYQKScKUTmsuWNSHLRIvRqeJiUBR9GZ5AE
         l/EH8I97hS4DFVuT4GbTpNH3MM8yMeLFAoFLElBePUhubWa/SnWpBAA1fA5JM04nHZhf
         jkOw==
X-Forwarded-Encrypted: i=1; AJvYcCUrI8Cn4v5qz27LjLVL7g314b4afaK6O8278l91UQGzNFjGLHq/LUj0M+LJiTicFvtZGsCinrFhqRW+TRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YycsIdVr0PYrn2Ojf6sOdutUXZSqEW1MMcFfWVadH6sVXGmbQYC
	EozIU6Uw25ixPe3YLBkZExdslxYeYpM7uM7eSNwmc8TKFPpJYlxpsgECLGmbJyX10MeWaOAPXiB
	Gx0gVsFOA6R/gdYAk4qa6jmhJ0IZR6mrN9uw194XssoI1AAZR3txnBlJ13kY=
X-Google-Smtp-Source: AGHT+IE+SKpu/FvgBMpn8lo33FeTbVK/4xovIuT1L4gu42wiX5R6DCpseuD8a6Ely9yqVRdx8660/OJX9ocSrZq2PfpBNyc15cZC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c266:0:b0:3e2:9f5c:520f with SMTP id
 e9e14a558f8ab-3e51037e02dmr6379235ab.3.1754327524968; Mon, 04 Aug 2025
 10:12:04 -0700 (PDT)
Date: Mon, 04 Aug 2025 10:12:04 -0700
In-Reply-To: <CANn89iJusO-iDNtUYQKKy6mmrZVqkJ=20_w+RavDup8bmTJ=pw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6890e9e4.050a0220.7f033.000f.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: null-ptr-deref Write in rcuref_put (4)
From: syzbot <syzbot+27d7cfbc93457e472e00@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file drivers/net/ppp/pptp.c
patch: **** unexpected end of file in patch



Tested on:

commit:         5c5a10f0 Add linux-next specific files for 20250804
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4ccbd076877954b
dashboard link: https://syzkaller.appspot.com/bug?extid=27d7cfbc93457e472e00
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=151dc6a2580000


