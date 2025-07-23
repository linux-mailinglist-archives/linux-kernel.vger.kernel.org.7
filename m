Return-Path: <linux-kernel+bounces-742359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F621B0F0A3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 056B1188FED1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7132BE624;
	Wed, 23 Jul 2025 10:59:42 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516332BE047
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753268381; cv=none; b=ZYp2F770UyyoJYb4M2NDhINaM7tX22vi6O3HZsXJmDufMMJXcbE88orZyVH9xOvxc4QCnsG5lp98ITtvGniorJh1HLaG1Fx2zC2beiv4b93f3LvxZzWJ021vt8g68HFYL5wTisAxHIbBGezlQry4KLK6NCLnWWlzeaUe19Ex0pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753268381; c=relaxed/simple;
	bh=TpQGc2XIwjr68wodS7SBprnIh8phOYtU9i89plQaOeE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eF78rLSeqmGLpJM/jbXqTBnTk0xqDeozDCtkXionlPywpCv1oq0Tz04H2IWkRYUAa+ONLXV9TlFM6fUbt5+nGt8yniZYN1tkAbPGCTxEQ6Pb1+NdXiAWl7924fkA8VLoKZdxL19wMV/JSZPuebHw6IQhNy5IouyKSO1/fYhGm1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3df2cc5104bso125795525ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 03:59:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753268379; x=1753873179;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uhlid39bQhtH12F8Pp7Wftgz612oFWnEnWsenDzk7y0=;
        b=IMEkzE3lnAkvoAGrwm6P7mQHRKeCxS/YbtSL+BXAtWoKeDntWavRSH9HpshXjirQfh
         zSXV3yEYElesg9QtyOrXYnfzHWO5R421uG/KZZVXOWXmSrEQbf0t1qpCTpJ060xtTKrY
         AwZvDSkEXVPrSPe8LpxjsoQlitaBsorYOctuOXhDqrZ5vDbYGB9ZsoWftqjZYPje6pNz
         9phTnFwhGUUhR+7SF2rGY8TVKMacbCainb3PX1y93ulYs2wQ7g4fl5Sy+Vb4Uz1TxZel
         YAi6VgP2kb1v974jPnO0oHMPHp4o/asxECA7PhcTY5IIcTjtdKNR3ycn2+zrY2JpjovQ
         7kBQ==
X-Gm-Message-State: AOJu0YwT9pVUGwIdvaoOnTrwci7o/ewWTVxo3fqpmi2pu/z6Sn94xr2R
	xs4XrVklm/PtUfI7HtMFpmBhMDiSTZbFVievm4kKXWMM0D3i5yRak4nOFJTkVFRGCUdeJm0egJa
	e8SpI7JZQvXBA3GbhdDfXYSIpGnxyXhjWXaCB1l7nHlBMQi+gO30zH4Crvf0=
X-Google-Smtp-Source: AGHT+IEsrmqKhwH6jnJge7oMNoNW/G2yHlx1vpJ/ZpaHuaU3QKzLbedeqsHyvB0WA3hTnoq7dPRlwZIiIv91xdZ2vKJvYmGMMTYY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c1:b0:3e2:c5a5:ffac with SMTP id
 e9e14a558f8ab-3e33557fe2bmr37268335ab.10.1753268379445; Wed, 23 Jul 2025
 03:59:39 -0700 (PDT)
Date: Wed, 23 Jul 2025 03:59:39 -0700
In-Reply-To: <67ffed34.050a0220.5cdb3.0007.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6880c09b.050a0220.40ccf.0006.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+2caec1f3fc52004d4f3c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix:  bcachefs: Add missing ei_last_dirtied update

