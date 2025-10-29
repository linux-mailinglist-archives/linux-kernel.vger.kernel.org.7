Return-Path: <linux-kernel+bounces-877072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BE0C1D1F5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 429614E121A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04A7311950;
	Wed, 29 Oct 2025 20:03:50 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BA51DFCB
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 20:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761768230; cv=none; b=hQ5ZWI72L1jPdTlHrn/3EajKgvUEngQrehbXLAB1vglkzcqFPSbWPrZVYs8Xj2b7ucBo2aF3srpLbDzXYi+WVNiOVof+R070mw3yiwX1gIVVXsw2BPzQTS/7jkjCeh89ri8DIJvZpF55ifMRJx0r+JK0ddOQWguOp4Ydc6YQoqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761768230; c=relaxed/simple;
	bh=Cj9ZqGVITijp6hbSuLcE2zYvoLJ+R52KwcH6XBCbf2c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gJ3bn2b+WoVxWnC282sFsFKhorTSBxVJXuKC8e+rVk1Gw85OePD29CoRDvB8kJ95y2A1DJz0KMDj3/M75ILefdfxf0L1DOxgCzXYod9A/R/JQo8eOy+lDXi+i1eSGcZOWH7IrDsR8++gpuXD+KEqbFnIXPQrncKlHpQsj4D/utw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-945a94ceab8so37253339f.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:03:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761768228; x=1762373028;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cj9ZqGVITijp6hbSuLcE2zYvoLJ+R52KwcH6XBCbf2c=;
        b=nDSopaOeWJX0Nkz092MuwyYoRa1xHoL4ZYep5Frl3mRnyiMveGcH78Anx+CjO22y6h
         QrQcxnsYTX2xDf/9OwQq5/GjWG/isWMZFchAq3jSo8/RPBEFbaVgwG9gBPosB0QRY//2
         7HWqiqQB+l5pVm8+M87QVVT+V9yEiHXmxU0AMBPvPjOVZdo3Oj7wd7Ru4JdD/dyi6G14
         Qecmo7e4/SS0BNlREh1kQeJfuU/8uAXHA3pPbVcAajyxqCbADhJrpBlbkjCRDQokq5z0
         VM6uwdY396IYpwdA+dkypWTqejMUgQkVWySWhEwi4btjjpd4pipxCGD+pBOURoxXAHgW
         1BMg==
X-Gm-Message-State: AOJu0YzHo51wRi1uBcC0RAUReXciI+hSXcuXZl/TEKasxl9XzPT/M8RA
	LvvAN1c8gOiMd1qobqd2a8d4t3V4DYZTLpmhiVPBBKtyi1I4Rxa9gFsBuD09yBIYZeJKvsX1IV7
	CL7akM4Rh8GTuepmiSnqRLifGZFeM53tovSw/xxLg5OVAg4Y9yFuL9Glc/Mo=
X-Google-Smtp-Source: AGHT+IFdvmy92gWisuZvmqF6Wv4AxUoSojfd9LePwSbhua3VXMRAE6Xnfz5Kxtg4oolheY8rzg15/aYKDskeVwa5JW6pAKxeD6Lx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2183:b0:42e:7ab6:ec89 with SMTP id
 e9e14a558f8ab-4330156ea21mr9426815ab.32.1761768227985; Wed, 29 Oct 2025
 13:03:47 -0700 (PDT)
Date: Wed, 29 Oct 2025 13:03:47 -0700
In-Reply-To: <68cb3c62.050a0220.50883.002b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69027323.050a0220.32483.021d.GAE@google.com>
Subject: Forwarded: Re: KMSAN: uninit-value in ntfs_read_hdr (3)
From: syzbot <syzbot+332bd4e9d148f11a87dc@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: KMSAN: uninit-value in ntfs_read_hdr (3)
Author: kubik.bartlomiej@gmail.com

#syz test

