Return-Path: <linux-kernel+bounces-860853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE30BF1266
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E9BE34F45FA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E434F3126DF;
	Mon, 20 Oct 2025 12:26:17 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7D430F53E
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760963172; cv=none; b=cRVo0aDtf1DXkuelKY3zxgyg2/w/Ci7/N+cZuGjcf1ZdR0g7ePf/Culrjyeq8m3Nk3zG7fhSOO7mM3VNxd2lzMXQEl2VMTqFQXsPHxLjr0GSMwd2Ra1FJhYmu9EttsYpndp8Ol6stjkr3aIiSdVWRH3PxkRMKi1kJqD9QFpWEDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760963172; c=relaxed/simple;
	bh=phGJj3RgceRPqvLEhmuHYt6Xs/IlhcLpo7DLHPfSHTU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iz5vMOAM6lwn7VJlitsO/nuxZhzXEDnTgJrUnKFbpPIiobQ+z/4Bc39kNTQctPvQ3i2xma+8p+Y2Eae+dFk/62+Bwk52CxapCaRs7liFspp9z1T+ePy31sCptfgYDcxh/Mq36HHc4aAQuRhl4F8JrY43lp8CTB54Dk4pAYzUPG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430da49fcbbso14313415ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 05:26:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760963163; x=1761567963;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2RPwyJ6zNa+Ilffcb2jxcjrBpiDHQo/NJyrIQpPWyVc=;
        b=ake0JuD13NSE7NL5NcvpLv0LkZsOV/eroaGytHdOd8wKPic1H2FP327MRYMyrClC0H
         E92PM+rBW5W4EP9q4jS7iXukAfsPbuNjEP+u7D+vfocjyYHrBiDikDsPXhr40q7ZhT7F
         gMIsllSBEMS+kzUoH2/l4Fqp0SmAKio1JM0NMv7lb7B0NPLDe8nnBpqp8WggvYdXUi7+
         cU3sxia/wsOKsN6SiyWprnjiSL6SVyfaH9jHj7bLzhRV77EdCCdzIJ5JdXXtekFHHhXy
         5wV8ZvvQY4VIOpHeY0MkZEEhfdYpVO1Zzj6xqykQaIrIJianaE9h3oqKD11pkP/gkdCj
         LJwg==
X-Forwarded-Encrypted: i=1; AJvYcCVl3jfF9nO/ILzXLjxBA2tSG91WiRgvXDl4wRlZuUqlU71f2Q9GZSsFD28H26Piq4/VrJ0tvGJiGBa0G/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwedqsSenj6dQ9+MLs+WKoRLZTe1isF555V4dc1Qavo0TnnuUc8
	TYevtIhpRAAezzCipwikUJDe8TC0HvaqUoIfNpLFqK4F46rxooes+ZDT6/JdFRQVKaHaOnsWQfP
	x/kccOq066bG+nxZ4T7vaR6HQ2prUsShnM83vO3xrBsz1o83ugtPbDhDkOTY=
X-Google-Smtp-Source: AGHT+IFhXiAIcAqfy99ebruXdCEa/SBzSACo6L2+82Ibn7dHTxDMg6NCkkB444vB6/ZJc5vtm3ClNG5w24iLSEnx/iS4Vl5BUBSb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c22:b0:430:adcd:37df with SMTP id
 e9e14a558f8ab-430c52b5b37mr199573665ab.18.1760963163149; Mon, 20 Oct 2025
 05:26:03 -0700 (PDT)
Date: Mon, 20 Oct 2025 05:26:03 -0700
In-Reply-To: <20251020112553.2345296-1-wangliang74@huawei.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f62a5b.050a0220.91a22.0447.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in xfrm_state_fini (4)
From: syzbot <syzbot+999eb23467f83f9bf9bf@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, herbert@gondor.apana.org.au, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com, wangliang74@huawei.com, 
	yuehaibing@huawei.com, zhangchangzhong@huawei.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+999eb23467f83f9bf9bf@syzkaller.appspotmail.com
Tested-by: syzbot+999eb23467f83f9bf9bf@syzkaller.appspotmail.com

Tested on:

commit:         ffff5c8f net: phy: realtek: fix rtl8221b-vm-cg name
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=11573c58580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ad7b090a18654a7
dashboard link: https://syzkaller.appspot.com/bug?extid=999eb23467f83f9bf9bf
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15159734580000

Note: testing is done by a robot and is best-effort only.

