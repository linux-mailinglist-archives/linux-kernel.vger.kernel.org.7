Return-Path: <linux-kernel+bounces-862259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2E4BF4CA7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97ED7189CF52
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130692690D1;
	Tue, 21 Oct 2025 07:03:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8627F26A08C
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761030185; cv=none; b=ePh17SZBGdW1pkI10k8/CQFoi/BceRN8sjMYWgva3FfMS6IajW0Uce4MofmpcmProX601/MeOqpotHGvNGGuo68aYVWjf2fcHJ+dw4JhDaZyPPAeovw4SZW/UUed7bQ426DAMDsJ6033TjbOICdu59zV2MPw375O7vUgRG5/BMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761030185; c=relaxed/simple;
	bh=3aygMRjpVjU4OFexbTmDo1P1UKqOwRzCu9xLb1bXlDg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OvBkpapN0WkZR8drmOnK1ObZOP3Lth6YUFkp3lPjRAULhk6EKb9vL105Q/gXzIwkUMGxD8ewfhqJ2E9AY2N0gOpaiGl25pA0DJCD3Q/b4SJ+YLTypxL5LKB0xDDqX0ngIrecPHJdnBAhM0xytxojZn0HTJHbZqs7RpIUPU7HOs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430c8321bc1so50762575ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 00:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761030182; x=1761634982;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bCH5pEc5GmPiDakP2DkOalUGty7px2zjGbK/qTkykqQ=;
        b=T/ARr9wP0O/n3llGHTsOMAoqN7xmz3hhL06iqeG/v0VCqwRzO+IanBDw3qs82TRa7K
         pdQShRkVmQm+OIH6CQvHDSg4fOPCDmM4w0/6m2zdTZkyWVY9pO7RiJ4EEpjCE4kRhFv4
         7dn8ZDdc86NGlN2eQ46lNuHhyyxYIFba10fDvUFZzZGdHTUiSndZrjAWlEraVpE9V/h1
         JeV6DGdAf7Fqm0A7wvGjaeVlBUcsDREBZsv9pR87wSP1sDhvP0EKB1ZNwCxFiI7MX+Yp
         GhyTLAuXQo8t3Emv9KTLZyh9DIm9oCZ3l3SaRPK0WVpXTIfmwTgEpKwFwfm2zCcvV3yA
         kuDA==
X-Forwarded-Encrypted: i=1; AJvYcCUpI2wt6QlvtvttOQifwdTHI59a3e0x+fwIeH13x4ZuAliiNFlbba2QSSl4FemzuwrDIKBBogVqeBgnaAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEfQm9r7TOUQ7vB4KprSLpJZ7NoHOwqAim4sXwmepC4pLUUZ8V
	lnzdP3Xh0NM9j0QEGFgZhj9WNhmWxcaTstO6IleDV0ZuiEiArc69Zl77IAHVSH2aH8Xpmy5RLVa
	OptuM398vttDbtwlr5RahCGn6+Rpx7GuQICU7b4xUcyLjL86Nc0RjUqXUh64=
X-Google-Smtp-Source: AGHT+IHIcKFAWCqT99iOD3QPOwEpcTogSDBokUSm9vDbEr0UBZzfBAWxGbgDKuy0b9rNZybdowgOdfaMyCOYfrv0K2qgLX5n5qmf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:380f:b0:42e:72ee:cde6 with SMTP id
 e9e14a558f8ab-430c525f609mr252306955ab.12.1761030182687; Tue, 21 Oct 2025
 00:03:02 -0700 (PDT)
Date: Tue, 21 Oct 2025 00:03:02 -0700
In-Reply-To: <aPcr6a85v8iuurqW@chandna.localdomain>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f73026.050a0220.346f24.0005.GAE@google.com>
Subject: Re: [syzbot] [bpf?] WARNING in bpf_bprintf_prepare (3)
From: syzbot <syzbot+b0cff308140f79a9c4cb@syzkaller.appspotmail.com>
To: chandna.sahil@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/core/flow_dissector.c
patch: **** unexpected end of file in patch



Tested on:

commit:         1c64efcb Merge tag 'rust-rustfmt' of git://git.kernel...
git tree:       bpf
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ad7b090a18654a7
dashboard link: https://syzkaller.appspot.com/bug?extid=b0cff308140f79a9c4cb
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=147743cd980000


