Return-Path: <linux-kernel+bounces-892977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1727C4645C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 84E7B4EED7E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD72C30AABC;
	Mon, 10 Nov 2025 11:28:16 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32CD307ADE
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762774096; cv=none; b=eRxCLwdBrb0qsO6XBWhLjtSQvQwlwHeDgqd+oT7iiaa8foaxihNWXE0lHArVfDP/Nj6APzH1fM3V6xL3kQRoxgZRI5fQX5qU5Xu+OApHPi1CISZ7a2vdp8dPNih3pEv+uwsnTpvvg8DNtVS1JIVVSHgRkBYKezRem6hRCgvKx6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762774096; c=relaxed/simple;
	bh=D02B9vh4EQBvDnoUn9ydkwnV9KXWAUCaQDgm7JSUu0Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=CAGaWSRcGgt3Eq8uIGRFC6VngNLJyvskY3P6afyj97z07Hk1dmqa/1tCG2gSvQRi1IgqP3DHn3KSWXWVEYUCkHEyzkf9VyZivNWgJfyFNP0QaLBj2reez7gCEDcoYHeOZhWy2ALQMw/fh1BNa1iSQmCUyrrtOlkdI9Ga6jlL9ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-43321627eabso99555795ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 03:28:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762774093; x=1763378893;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D02B9vh4EQBvDnoUn9ydkwnV9KXWAUCaQDgm7JSUu0Q=;
        b=oTCgDoJoFP/hnNWwyU0iJbqoeYwUKT4z4eZyOa2nC3P3AEudHx421RZCTH0bU/wCww
         urDwJeIE4CVVSXYy9ul2O/AemsZZS59XnCP3AYq2os+EBx4KUQfgP7A58CqBI0Pmt+3T
         0JDeDBEw4E0StqgSWZaT8TlI14D98K0ZhOXJJS8gx0iLSGaB4WPeoYoYW9jSYJcQB0CY
         CSsXu4CkJua4eFMYynYIqgMaKtSYQLHhh/TLmBv5pbKcT/cjDCSuOHQJCuvkfbLMJzGS
         SYX3boAHQz9UOIUzQBATNqKEySwPd1EpDRvjL7sK8P7gdkxZJCb6bpssVAdviZ964xw0
         8/bg==
X-Forwarded-Encrypted: i=1; AJvYcCU/kLtgH9lXf7t4iCgpuiqlinrcu8UV0q9RVLbsob//h0TGQjPlsot5CsguAPlyG99OTAZqzLxKcKh6TYs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycg43vQu0fSO3vaaS9gRMSRXoN1ALmSWc5jCLMC5IecRDStIem
	9hHs38PM8FlgxhdgoJe9n3orzCv546DceswQBk19QCr/DzLxE8jvECUS4v28ioYWGYX/S3TKTAF
	J/bAUmreB4Qb8rVDAdfeCh99HqdO06QPrIwD2GsoDnqPwCq1l5hgZVg0Nvew=
X-Google-Smtp-Source: AGHT+IFV1GAHGXyLD1gqSGqj6klbNi9AMahK1oHfwg7DLJShMypMPP/cZaFmNZtrkBCgJAuokPryF8ctpXk7xCkBcY1qzLyEmS4F
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1449:b0:433:7db6:6000 with SMTP id
 e9e14a558f8ab-4337db6622fmr45549375ab.21.1762774093138; Mon, 10 Nov 2025
 03:28:13 -0800 (PST)
Date: Mon, 10 Nov 2025 03:28:13 -0800
In-Reply-To: <acdedd74-2cdf-4305-880c-1fe4c5da53ba@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6911cc4d.a70a0220.22f260.00e5.GAE@google.com>
Subject: Re: Duplicate bugs
From: syzbot <syzbot+e87be72c9a6fe69996f5@syzkaller.appspotmail.com>
To: yun.zhou@windriver.com
Cc: yun.zhou@windriver.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz hup: BUG: corrupted list in dbUpdatePMap

unknown command "hup:"


