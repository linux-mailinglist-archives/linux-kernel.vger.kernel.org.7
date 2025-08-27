Return-Path: <linux-kernel+bounces-788462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E93EB384F3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3739A1BA60E5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DD835A280;
	Wed, 27 Aug 2025 14:29:28 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4909F1D5150
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 14:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756304967; cv=none; b=Pds09ykQESyatpAPLvx55kzYhGy0v3xipw1uVVcTbTD4wnKqlZiO+o1gOcM+TDbFLpsnrxNI4Hpm17zz4r9CzEH2pNxM5V1RmMRz/WbJaVrIyZNcQOXCtZtPNJimb2zcOri6/W0osivTtdNXnDCXkKnFc64u9rQFUXWN7YI9dO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756304967; c=relaxed/simple;
	bh=kIJR7cGADyM6kTN8AEDpaIlr1i/X6urH+r5wzhvbbtM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EojhntuaBBZ24OdeNmAA2cIB8DPch6XSWg/76k6MF3LTeMWGhbV+DBGWGfmT1vklET6k81dz4mOypsevSpJlgxuUBcUG1cFTe4zTKlaX/hHRpZglVyx2x77XMi6TgwzELk4xVsWnGprU7x28ekmJNx8Rk4Sq++fr4ud6bU8Lj0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ea6a44ffd8so53019835ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 07:29:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756304965; x=1756909765;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FXSbQ6VH10E/o/YNj8FDVjkkh//FO7asf5QkENMSHQA=;
        b=G8TYoPJwg6aEP5JGn+sA9TjVY0svvDzokdNA0qNZ99ZR8+0r/KtYhjc6QjVmAJq22O
         KVF88Zh8O6FElyVcH2cgFCxHYJcfsBP/2nBpPuLWOaPO84r9JRwb6UIWw9n5JHuLlq3j
         DKWZGTkbD04boCILv3jFZmsFCMQDduOMn6uvhLUrHO2pyyWrhQBo/Phk16LtZYCztHWC
         X7k0/KvFMePDvyqZ2qsW9l515U77OUKPd7/x2hD52xyFsv6hxwHy+OyVQ6kD6658OAgj
         n50WmQvAMvdLaQgjIWF1B+hUNMGYKgh29uvh6uX/aZC5e79xJw8eOFEdUjefYTXghaTs
         ghWg==
X-Gm-Message-State: AOJu0YwH3aG3kms39E7aHWOmfjGzaD+oJhwNQ0BucP4HCuchCvB3aQRj
	P4xNQscNlj6cJuzdgjkN/7etVLsSvzKzuysF7lxhT6Y2/K/si+SrM577DfJIn/3IiKlkP4FqstJ
	ZA8htAZjIPLY55+VSshGWuDzwfJY09wN1ga+yUqpQmp39HJtG3ss9opCFCbU=
X-Google-Smtp-Source: AGHT+IF7EIVj9lw7NZSh0Osjqy8XM6ZYf7orYvsCCT2LHUMhSpTeuHvD0gS6VfFxW19eWFUYyZ92VlWlqisJKDj8+qjIsv5XN/cy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3c03:b0:3e6:7b31:bd71 with SMTP id
 e9e14a558f8ab-3e9223163cdmr319656645ab.19.1756304965253; Wed, 27 Aug 2025
 07:29:25 -0700 (PDT)
Date: Wed, 27 Aug 2025 07:29:25 -0700
In-Reply-To: <67b0cc5b.050a0220.6f0b7.0014.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68af1645.a70a0220.3cafd4.0023.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [bluetooth?] general protection fault in bcsp_recv
From: syzbot <syzbot+4ed6852d4da4606c93da@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [bluetooth?] general protection fault in bcsp_recv
Author: ipravdin.official@gmail.com

#syz test

	Ivan Pravdin

