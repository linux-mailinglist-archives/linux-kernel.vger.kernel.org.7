Return-Path: <linux-kernel+bounces-743580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF180B10073
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28BCB4E8222
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 06:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6559F1DED4A;
	Thu, 24 Jul 2025 06:17:53 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866CD1E501C
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 06:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753337873; cv=none; b=ZXrp+mO8ZFcfdvjiltFYdx1Pl9YCkwwwoOQHA4uPeLSckBb8bALiBJJDMjVpmsI3hv2Wn6OFBV2ivJOndE5j5pr5fv+zjAjUvbVUYiliHOfLyqhgMGBkW/I5lAXEHvew85CgIFqiqsgRR+5Ae+CZr9rroBnyEfrnUkBoeuJwnDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753337873; c=relaxed/simple;
	bh=OFKTeQQR7Ob25FU2x0QQRypoM5GpQNimii57zsifmLU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=cN8mXPYF9FEdfdVZQDoFuEDU78KEl0yk67dpITw63vEX5OlRLb8lkkPUgAKC89U6/HAixISecE+tY67zuDd3sqXZ9ah3fnJ8DuoJR7sa3xg+1JS1pkgwyvvsfBCiFT3Ju+jQkOVKsQLGMCrBUIwyi3d6gvd4Zqo8BRhw5hivLAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3e29aabc9cbso6729075ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 23:17:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753337870; x=1753942670;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OFKTeQQR7Ob25FU2x0QQRypoM5GpQNimii57zsifmLU=;
        b=hbp/gZPy+yOpp/uhFMnsZQDHcNrVIMgTKqiyXjyeoN378ncza8CfFnZkZFW7FFG/gY
         VC3ZBe+TipB/gVslwnQVYmAuE4xtwhi58B2xbj2H4uCVRPEDQb3oW4loSqYzPfuopwBr
         rX+H8QmmgiaHWh1jhqbKalnk5dSZk5U5UqCSn34fJ1vK5yo1hPyYVqK3XjOdpo1OfLPn
         XBA/GmGPyz7KALXO7nn9CTa/HXrTiiBXaV9hSxW+WTRfDouAoXsBkSnzxojSCO5DFUTQ
         2YTq9cqyEw+wxXRJyJ81K443KI6emDNmCe/hCqH/IZX4jIckbh7VqLVfOMw65gZQIMs2
         9xjw==
X-Gm-Message-State: AOJu0YyV2Bf25BQtB3GLS5GmZax4as9N467bO5zU49zMAU9rmZ5s0h63
	xbrny8IXryf309tMs44qEyYjPxf6lLBxfUTH+HkZguGsluKX6/ZHNrRE9gZ3yzihQKXBZoGlhhx
	N3agDJxiEhaKU72hJ9o41uJQW4QP7HCHingDHsFe72PwqM+MW7f4qPOIZ/Z0=
X-Google-Smtp-Source: AGHT+IGxMV80PmOK0um+QbU2Rb3ZwUPbgMDGEBPKyk5oyHcOAEzfX61/KUc+70r0i6xi5r8lh7dB7aXq6X61N+G3Rd0q/SqgLzCC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:168e:b0:3df:34b4:1db8 with SMTP id
 e9e14a558f8ab-3e32fbb5820mr92766455ab.4.1753337870611; Wed, 23 Jul 2025
 23:17:50 -0700 (PDT)
Date: Wed, 23 Jul 2025 23:17:50 -0700
In-Reply-To: <CAF3JpA50PVavHnV3e6hPpQ0xRKPY95K9K6Q40k7Hhi9vmzp7PQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6881d00e.a00a0220.2f88df.0012.GAE@google.com>
Subject: Re: [syzbot] [fs?] [wireless?] general protection fault in
 simple_recursive_removal (5)
From: syzbot <syzbot+d6ccd49ae046542a0641@syzkaller.appspotmail.com>
To: moonhee.lee.ca@gmail.com
Cc: linux-kernel@vger.kernel.org, moonhee.lee.ca@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git

want either no args or 2 args (repo, branch), got 1

> main

