Return-Path: <linux-kernel+bounces-880262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F95CC2541B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BFA44202F1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510EE34B187;
	Fri, 31 Oct 2025 13:25:52 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B0932AAD1
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 13:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761917151; cv=none; b=Ngcakaf0aZGCrp5pAOzkC2Ce+QnYLpDhbuANGCHqk4MJf/wpjK1h0XodBX8K+Zglfxq/87l6KTp7zOgKRooTzrpdeRw4A7UPfR7HPN7H8OojK4jyIZuUUc2nPxNUO+vev/eLyEdWGjDV1jrRvtFeT68CWyvrhI3GZCUlgkKFJA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761917151; c=relaxed/simple;
	bh=pE8wmq8bULXpVfXNeVtqtkI05jrh4XrKSUyVstTlMKI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JzWQ9lADJ3JuAtAEHJn00R726f8lkTs5N64O87lr9TTMHQYDaNSljnGGVAT0KZOIjhUpQEA94eHeq8KdVF3E8mZY6tt3NYoQrhnkeN1JSgtFW+SK9Pz1HK03bJu6leid3/uE8B8mMgEOhtz1kYRasA9ut/NB5axFQ45SjuPJR7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-43300f41682so23258985ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 06:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761917149; x=1762521949;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pE8wmq8bULXpVfXNeVtqtkI05jrh4XrKSUyVstTlMKI=;
        b=g4rjeIa9Ed6s4i1z0SjcDekCMVfDJJ2zvvxE2ziFoWWgflnF0UrhFr8HGeXiuANsmJ
         UjLQHvCYuBXDOOtKFeT+DnuEzOubP4d7al4zRib9e1+ROohmT4iFk78rbFQ6KFEBDBEG
         lWLqfYADzg/vc5oWXlV95mBcRAgGw/FRoID5aQYYDxHM9i0u+YDwT8GzWUXjvBt1DZP3
         4cPDgoB3MnOtgG32KMiZTBmtFHSu/gcaRALhmPwZ2IBlWYtxdBuU7PvX/5PH+N+0ovwS
         Rhhwfx0qFbNU9oNsFAyR3qsOeQa093o0R0X9Y5iZ+17Esfa5Yw8c3InhHVVGAlQPbi78
         IZUw==
X-Gm-Message-State: AOJu0Yy3J9GQYszUn0oKdChw887jSAlWfGZJpZRgx8Vkbf33KYY34Gih
	OffumCx/rKGYdtmgPIO9c5FUtQ8mwL1fbj5DSvM2mQdonPLvqpK1SKyutfwno2Ek22j8oPts1EK
	SOMO3zkpAsnmf7Fd/uYZeISAFGeBOKLMUk9hETCrTln8dWvY+rdEGKlzUm1w=
X-Google-Smtp-Source: AGHT+IGgDTNFvqce1iJ2oXB9g0SkY9LJUUDqvIUhmvBxuNoSPbWm4ihDTopcUarKjZM653er4mg+ptbLrESBuL8KGRjhRSL4TVtI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:168d:b0:431:da5b:9ef3 with SMTP id
 e9e14a558f8ab-4330d1cf1a5mr60382885ab.27.1761917149660; Fri, 31 Oct 2025
 06:25:49 -0700 (PDT)
Date: Fri, 31 Oct 2025 06:25:49 -0700
In-Reply-To: <68cb3c25.050a0220.50883.002a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6904b8dd.050a0220.e9cb8.000f.GAE@google.com>
Subject: Forwarded: INFO: task hung in bfs_lookup (6)
From: syzbot <syzbot+e7be6bf3e45b7b463bfa@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: INFO: task hung in bfs_lookup (6)
Author: zlatistiv@gmail.com

#syz test

