Return-Path: <linux-kernel+bounces-763505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE589B2156C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 21:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9385623BEA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 19:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42732D8785;
	Mon, 11 Aug 2025 19:36:23 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CFE207A22
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 19:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754940983; cv=none; b=dluVqA/XhUkTdcFiTw7wZ6VJvyf+sgdq5BWLrD5+I0ggZDQTxVnH5ag6F1Ook3RsM/VYmcGLZl8bKnGSmKtxQsKPNMTJ8jdOPB76yyWQ+KVG6LUXF8pJ+cp/tokIVKr8Aziri36tr/GPTF/HmyZP/BeuHKkaOv9EB7XPLjioP4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754940983; c=relaxed/simple;
	bh=1TLvhGrEqksH/UsYpqq4yDhYrl1D1YIi1hWb/jIBItA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=mwjP6IJwiWWHjZf4v27T7c0/ZxKLFj+aP2L6/vrTxt9bLmf962UdSokx9ZKgHE04IAjFvGvXrxM3tA5Pus2KRfOqzTO7e+5IfdhYt5mlUUtnpTwBKlKl4lssI7JLacna+zsDIiAVJ0Ylsp8ksPcAUtAjB66zQ9X4Nxj4WktdlKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-88193bc4b09so1000465239f.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:36:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754940981; x=1755545781;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gwj8H++rTYzvGmBnPIFeuu7bmVUxwOSowdnBwzyw9w4=;
        b=pVeSbSW7v8n18c3f4QRWrzQ18CfziA6sv8FHwgNBiacoELgjx9QkvgylM6oK8msdZ9
         c9+huMcI6I/qA/Pd6IsxdLXP9ONhcJsmKu9EBBprtQvvlPbXKvEkcxObb3NgU9dfKblY
         43WE127o9vh+2HR/NtGAuQ4plfvDzq8Pvx12SuWeY8vbJ/p5NhpYp7mQ+vJN577FQzKx
         d1ULfxlqA6O5EZr62z2Uij3SXxsuRsfVuYiteTkMIQRYhodlfKMUBlvLIXs5EZUn0Vtd
         +3muuqnMjPtty27RjIfz6xduQY6fGK+VZgZaWBGtpG/UaHqwfPGn4U3WzZ7XpRP0/KiF
         nDjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6C2daJb+xeLLkMe3Tvi1+0btu67LgawdoVwQlV0jxy22rOFTLW2ZXrbl+/0AAlsLH4q3K9MujRehlob4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuiK5gMhVdqDZr2xppju8HJuVJEScewnagD5UejWEJqlrI2bLs
	83gvAMClMynfLIEP8VXCGuIKpoMwnf9Q/ToJMB9Hk7M2zJz/1VOnlFpzItto2sPGRk6lksLHYcq
	XFYrAOlIw2re4k9gd+rBa5V6VeEFWJx9L7Wk0WxvlHJDIwVHfL3ZzBY8tMN8=
X-Google-Smtp-Source: AGHT+IF2rNoHzYu1qOPjSM4Zo17v2AtJ2LE8d2Y7jKsSO5Ahs9hXZcL0HWIjS1oOtG9ys/aoivl8Zd0UAR1r4M/S6QazhswzMm6u
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:29cf:b0:881:6d77:6d81 with SMTP id
 ca18e2360f4ac-8841be902fbmr169955139f.8.1754940981224; Mon, 11 Aug 2025
 12:36:21 -0700 (PDT)
Date: Mon, 11 Aug 2025 12:36:21 -0700
In-Reply-To: <8cdcb529-54a9-427f-afd6-108207bbbe0e@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689a4635.050a0220.7f033.0101.GAE@google.com>
Subject: Re: [syzbot] [io-uring?] WARNING in vmap_small_pages_range_noflush
From: syzbot <syzbot+7f04e5b3fea8b6c33d39@syzkaller.appspotmail.com>
To: axboe@kernel.dk
Cc: asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz dup "[syzbot] [io-uring?] WARNING in __vmap_pages_range_noflush"

can't find the dup bug

>
> This is the same issue reported last week, a fix already went into the
> current upstream tree (and is in 6.17-rc1).
>
> -- 
> Jens Axboe
>

