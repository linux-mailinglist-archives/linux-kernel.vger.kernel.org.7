Return-Path: <linux-kernel+bounces-869770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D01C08B23
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 06:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2910A3BCF7C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 04:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC852BE622;
	Sat, 25 Oct 2025 04:55:04 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2998E13B7A3
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 04:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761368104; cv=none; b=EKDyBmw6DdLkP+rgEBodZOhAQxkJJVLPs7d2Zm4crh95zSs/FIAavKwd9uP3Bx75et1FZTwMOusmjepL3LMHkiCDkBHOrLn/tQkaqdqNA06bW9qxrjtLUYF9621MWsZUfbc02EkE9HsCNiHe4uwkUzZxJm9iwrR4iVWbYfpO44I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761368104; c=relaxed/simple;
	bh=iktKT3WSsX5Eh5WpbJhRG4yNuP8WNCWNH5X4PESRAnc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aaWMUG9t4K8buSkA5xzZS/59g5Rw4uEP2oCbM/OYhtUhJhYqffKam/OMAgisfqd8zKnCrlyoD2eBEBaK7ZUKB/cKeoHlonFVAu6+wu83OF5UXHrlwnNyqwk2CiqkQDhRYyuJswe6jNy6uq2IFhLhZIQIs5FzTY4FP7CTb/Rf1DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-94389ae547cso14268139f.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 21:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761368102; x=1761972902;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sfohFdAczWF1WzY/GrEVTuUSveF/6y4Geu8fq13XWG0=;
        b=gxh6fRy5MfADbLL7+o/lkdsP7qQ5Tn1amaHiMEv1znMe5298+OaMOXdmb7iHvBIDFB
         fVHRMgoTsO44MnTqYMtzA/PQjPIfPbLSde/TtN5P1rsZTaxaE5aXfxUjnDUdYbj4WZNY
         jBaeJta6J3nqtdmSnTwLxdXHGd3b5MPP63ZxLhN11hKsX8veO1ao2n3lzx2Dj8AmNT2+
         sdhyC0VzIz7PMr6g0O8mfCXCS3ItO7AJ4y3bwCdoVQT4lkYAzHS3QEoQVyYOIapWfrTG
         dYZ5ocFAI73iQs5KUP74BCaWFJrWpGrF/uwvmc5qfID4nDi18Pk/7Gb2x/SKNZz5gWNu
         mWvQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6HqBP5uV9j4AMKPS8VfxLy6S131ZO/idkGLNzmeDrjnWDt8qLDOpt1ja/vOqRRYHkmQK68It/kAoEzcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF/aqMh/2Q0MoDJO+bk7KDnwPjelFgEG6nhP1EBXPwKr9UiFbs
	q/hNKw9hQ1hdkkyLxWEQlJqbyiaO2t3KpKscXcY9Aoo2qRhEbHsWNWv9uriv9MsMrYAwjYwhyba
	DU+mx1j5m0Ml15Ks51KPsNw4aNiXnK5NCzxtKLwOglySULF0oD2FVxzibbKQ=
X-Google-Smtp-Source: AGHT+IGmzN3hj7nTSLkXk9l23ogDW9Jk3lYuOUnF/SmoXNtxlLUT1tNfps/Ib9eNuMT9GWLVCiL6ZSXIMp0XiubP6Fz4W3ASkXvN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1414:b0:940:d395:fb53 with SMTP id
 ca18e2360f4ac-940d395fcbemr3180777839f.12.1761368102301; Fri, 24 Oct 2025
 21:55:02 -0700 (PDT)
Date: Fri, 24 Oct 2025 21:55:02 -0700
In-Reply-To: <68ec1f21.050a0220.ac43.0010.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fc5826.050a0220.346f24.01f5.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in xfrm6_tunnel_net_exit (4)
From: syzbot <syzbot+3df59a64502c71cab3d5@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	herbert@gondor.apana.org.au, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	sd@queasysnail.net, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com, wangliang74@huawei.com, 
	yuehaibing@huawei.com, zhangchangzhong@huawei.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit b441cf3f8c4b8576639d20c8eb4aa32917602ecd
Author: Sabrina Dubroca <sd@queasysnail.net>
Date:   Fri Jul 4 14:54:33 2025 +0000

    xfrm: delete x->tunnel as we delete x

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=160c5d2f980000
start commit:   cf1ea8854e4f Merge tag 'mmc-v6.18-rc1' of git://git.kernel..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=150c5d2f980000
console output: https://syzkaller.appspot.com/x/log.txt?x=110c5d2f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af9170887d81dea1
dashboard link: https://syzkaller.appspot.com/bug?extid=3df59a64502c71cab3d5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=162c3de2580000

Reported-by: syzbot+3df59a64502c71cab3d5@syzkaller.appspotmail.com
Fixes: b441cf3f8c4b ("xfrm: delete x->tunnel as we delete x")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

