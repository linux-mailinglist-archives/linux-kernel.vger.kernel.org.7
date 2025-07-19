Return-Path: <linux-kernel+bounces-737937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEA8B0B238
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 00:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 502E3561EE4
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 22:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B58422FF2D;
	Sat, 19 Jul 2025 22:04:40 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5CF2185A8
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 22:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752962679; cv=none; b=ShPo7/uIoOt8ahu7ESEa0jmuL0Tm9kjNj52P2Hcun5KC9wPFlD7omK5icGZBr+6ehEL97Ri4iNoP94URJkzC8DCQHnNHvWQp38FIc/totdeKZmYDnD54o6xH+eYpX5ldKuejMWBfz3/+EH2fAPRV/AN8pS/VmpuL4E7akbCumKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752962679; c=relaxed/simple;
	bh=uJk5TX/W5ZJf0a5jGYEdXjoydHSqlbm6r5BKS8i75mQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hdAORZ8G4nWJ+lIPLackGPaXHnwj5nUfMnSl4XdslShtEDMRDLi61ZNtHs9dXgF6zQZ9fmFk8mA/l6Sa0epV6oZqNrN5tg4mOTiCZti9JTHTL3uhdR7qKBXGZup4xEgsl7eU3UftNoAtFYE+wGJ+JipvWjWbUucQh9jaMUlOod8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-87c13b0a7ffso318133339f.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 15:04:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752962677; x=1753567477;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nRHmqvo5dfR+skvPTA01LexDjsE1mtW5TcaVf9MazxA=;
        b=MSjFbmrdBPgsxVIN3wsPFQSetmGbh7gso30JLg2DmMoyvyT1byo1RlCGTRQ7r1rcn2
         CbFLr5jXyX7+0mxqsp/N0jpo+h8uuvLcWXUdXN3Q+LGpxW9PYOlp9VWwK2kdfZhbhqi3
         1WvQuh8Yql4484rN+IkyUhZLxjdEhxW3fQS8XcQM4Nb8AHF43VoCk8oETHHpjqWFwAxE
         +Fio+gRUEDGD10l6JpkGzMLI2M50rRBef4V+v9Pb+txr/Fnx93VyxmCP4hE1pKTxYr0o
         1k3cfwfw6LgsRjwMXPrYS0+VSo0C7VaP2ZQLnlq9rgAV1+0goKJWD6B6x5ogh/ZROU1z
         xaOA==
X-Gm-Message-State: AOJu0YxEE8ONjf0k3EyPjukTlWEVIe09UvhVPn8rCfCnCnnESOuLHKXq
	Vf95K0ScsGLLxrw3ZcgR5kEwceIhxuGXAnKksoZo1iRVm28JuV32bAfwPu3/DJNuJfF+SFK+K82
	g0ntx7moBka6u8xjhULTgV8kxFpjVsZZLmkDVsFn3kbLAcC6+In1io2I4CD4=
X-Google-Smtp-Source: AGHT+IHEEWiEgEJlauJwCa5ObdR5qh6m69IXC3VpXgyTDY5ImNtkP7aIE7K5Rz2iaCxaH/YhnqpJLRfcyctoFycJNPwCgraCm4Ou
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:641c:b0:86c:ec82:c7d7 with SMTP id
 ca18e2360f4ac-879c088fe15mr1608075439f.1.1752962677584; Sat, 19 Jul 2025
 15:04:37 -0700 (PDT)
Date: Sat, 19 Jul 2025 15:04:37 -0700
In-Reply-To: <686aeaf0.a00a0220.c7b3.0065.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687c1675.a70a0220.693ce.009c.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+487dd8c670b175dd59ed@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: Fix __bch2_alloc_to_v4 copy

