Return-Path: <linux-kernel+bounces-857563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A309BE723D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B02C44F5202
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B1428469B;
	Fri, 17 Oct 2025 08:24:39 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7127627FD5B
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760689478; cv=none; b=Rtea+7V1NL04vgBNZILrZy7jd8va4HnyBExRljOHJFbpU4GTjCZDtFbZ7mA3RRukNtm2Isn7kKZfjrGAuZO3FKStCcgN1grW3FVbThM2SkAVFd+ycDG9ZasrWrUu3+dexbtfUB29628eA+qMI04kGG+sZMdzX8oVqNbP8UtAlU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760689478; c=relaxed/simple;
	bh=FoxcUfw2fmbWuleHbAfGYIRUxqjBk146WLkBMeSKEJM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aKKI3vjS24WKQfflyl73DpKtOTBRnjyTQGrWBudIfqbbM7kOLZlfmsb9TiPMxsi1x+Dd3FAEyDOK89zGzwN2Zf77wFqtUVyhPLwruogbHxjMXzSK9owxAiUTM/3zB1Nm5xL6z9zbVsq7w1iiAyje/wpvRmYdHhrZShEKg3CZjbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430c684035eso11199745ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 01:24:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760689476; x=1761294276;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FoxcUfw2fmbWuleHbAfGYIRUxqjBk146WLkBMeSKEJM=;
        b=ac/Ms1qvResjVQS/t2TqvLUmZGsoPYvR5NLqYZHS+cxDL7S5iGipD/JmoplXPf9SA9
         0jRH61mGtX7yKr4dCy8QujDNfFSRebYcRDUqlQAvGaK28QX7LuMigmx/YRo0Tu88S+Ca
         nCAcEvSBvHF4Kce/Ba6qy81zJuMGv6ISPaC/ex+43t0+aJ3SpD0DnD8Al70ud2QGr0Xd
         iAjOad7Cws7BIxkJAqKtmNDddRXDsZcYVQISediluDT8REB3ZNXOgCEmoAVbDoThzFNm
         45TNGRKIxUFfRu9/N8CW18POQbOhwfCEZHbYu0sgpR1gt8Uf9xim2MA2Ph2QRZKMt2Vw
         E2uA==
X-Gm-Message-State: AOJu0Yy5VCwolmv0/8ZoeWkhSnvPIV8WBxA1CXtRjSi1rPawU5j/6947
	rv2LPztiwloV53SvFt3DtCVuxBza+tDz0tzcATWjeIUUTmxB3VQ76FQFGmURQTc8Vdx3DdnxffH
	3m8VH0NHw46BoLgBU0MjDSY2sJpLex18qXC2nwZdSEAtQiGv+puNZ7qO9+Ec=
X-Google-Smtp-Source: AGHT+IG6YNxqoq3DfChWKNBgIdcC9C0LQnr+hBpsvNl+m8rEokZgJ0klA8rt7qM6B80WP7VyVLaWhGm5WTaiyOlIpGSy4bzPQZri
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c03:b0:430:b004:3d5c with SMTP id
 e9e14a558f8ab-430b4366fc0mr90885685ab.9.1760689476657; Fri, 17 Oct 2025
 01:24:36 -0700 (PDT)
Date: Fri, 17 Oct 2025 01:24:36 -0700
In-Reply-To: <000000000000e39b37061e898704@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f1fd44.a70a0220.b3ac9.0028.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [fbdev?] KASAN: global-out-of-bounds Read in
 bit_putcs (3)
From: syzbot <syzbot+793cf822d213be1a74f2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [fbdev?] KASAN: global-out-of-bounds Read in bit_putcs (3)
Author: junjie.cao@intel.com

#syz test: https://github.com/Junjie650/linux.git fix/fbdev-bit_putcs-gobounds-v2

