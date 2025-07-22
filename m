Return-Path: <linux-kernel+bounces-740937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA80B0DBE7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4370A1881D54
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B579C2EA16C;
	Tue, 22 Jul 2025 13:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SrK6JIU7"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB492EA48B
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 13:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192439; cv=none; b=qZ8o1yrypTojir7aAvXkZsmbCPXqesxI0PKmsr8H2QY+20/iMaNz7wJnd7xiW22ZcYl5uvp1I6FFl6eC/+nnnsK1AmjjBoOC5HfzBlDBcRxtPtJ2HHPyLBI2d6fE2pKZ+mdgjXj5j7jhYARl74NK4zdcKADnteWQXXh4BG2vnWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192439; c=relaxed/simple;
	bh=X+6WKa37YeGdTpSsUgBPKRQ0ha4JuQYk7mXhrDyUA8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EN/socgOEMQRVi8cJo6UAWmG7EBs7gSWenrK1MhY5js1z4pSu07Jz1AqpE0q22yCbCnyyCv8fpVFK0/u0dwjtdEIaWdIkf8wtvowNO8zXWPnGJWPFiG2/KvdLn74KRE3Xh78hKhqk32fxyfZ335HOl6wdwOLSRpLQuaDEVJk8TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=SrK6JIU7; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3e059b14cb1so31915275ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 06:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1753192436; x=1753797236; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r80FNHbgGav8HfaJ0V6RkXNFNbTEZ+XI5znWw0crh2Q=;
        b=SrK6JIU72CATvAOgZIaEflk6YUo5oAfm1Lb/oR++puGKE9xJ4BhFfoOkSRenu5oRpc
         OBV9mtd6Mvujxe/0XAfvC9C5ZiB3XE+uT2EpJJDHqXzuilOJLtNpkub93/V1ThSvsVij
         52ynwwxrDKRWW6X1Bho5wXJns7ayOldJm3pchQTs5mLvnL9fLBVdWpBvYVCPLZuBJ9J5
         I+JRGWtrL5zrA8sZgaKYEIJoKp6r8NY0Y3bMTiPIAeK3VROyu3xCnnijDctGjIT/DhnS
         joVCCLOf9K7oTl7D8ZTp2Ofcg2CgVZT4tEbXk0qzcZWPeElyTcTIDUJY6ZXBV5b1PZP+
         W3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753192436; x=1753797236;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r80FNHbgGav8HfaJ0V6RkXNFNbTEZ+XI5znWw0crh2Q=;
        b=wvJysF6w+yAez6mOLEKQNb/aO3JKPla+motBOGjfixcpVGZ614bOQwA2oGH3Vcxb0z
         30jQzTzIT+G21NXfz34ZY5ML+8zE1wjmqZ3VkEjgXZObjHURbF7zzIZZO0GglkIvTlZY
         yZmIOySivLrltGcRM1hXHls27khNyhy5ePx0OM089pLag8XDxEjCr6ow1kijjKz/xWKv
         4+YxY7TcnylpaDdlCmin0bLioMCrSohuT/V2wGskr20JJcqonDOB3MKn2qewl0RGtxmR
         mK7P/EkBQaSLs1zCet1hIPHDREGo1Nf6v00JxDY8m6rqQDYQPZ9zAcRAsqbPDxHrFzBy
         ffMw==
X-Forwarded-Encrypted: i=1; AJvYcCWYiiPLBRa1vg3pX1Zu9DklR4f88lBSIIJhXy02vG89H1oP0gLpXXkbHJt5UbWGOBn/KUXbBMa6ZM3t8S4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEakEqyUUwRxjUlO2KYr5oM/FEXi9vXMObjYtQKdpnK+1NXJ7I
	1nY08Pg+zlDyAztkbTlKYhw7BQ1AoSM7Yxbp+gykvwK0nGZpofCmFmviRwqYPqAqYEM=
X-Gm-Gg: ASbGncuHbBCmnZJtdI1wMnkCGELB46BqysqG1NmB5+n4Z7M2JmJTpWakCoNbM6oz/ms
	gvDnhHpfaHAM06/OWWAQq61BjZxX0Gm0+xcKgmjZK1YX/Qu94jSRCKMGOpjWQ2reGa02D8VlSwo
	eZfKimPGJXwAa/DFzuio4aB1xAKOn7u0Q1zJD8pxocsm1HSjmrguNFmS2Qz/RykxmwHPO6fpK16
	qo7ZpNA6ArPUqRd5jC5Qzfo63pXDUlCrSnT8IPtSon2YFYsYuE9U0FxqddgZ1byM8uA9V/l10JS
	TI0Aq1kacjtjyeLFhj/gFt1X+oX3rEeZrM1VVTXk/wqgUmeS3gR1G4wPCwCIuhu1rvsJ+nzfyC+
	0BMclVvXZGaXWPP/vIJM=
X-Google-Smtp-Source: AGHT+IGFRfbNKh6jX1zH9KAk0DUbpXwcYXi40U/N+ZaBrRvAfIYWQkKSZlimYZGTE9iRtDWrW71sLg==
X-Received: by 2002:a05:6e02:4515:10b0:3e2:c21d:ea12 with SMTP id e9e14a558f8ab-3e2c21debf0mr20016665ab.7.1753192436556;
        Tue, 22 Jul 2025 06:53:56 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e298133d14sm31439775ab.10.2025.07.22.06.53.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 06:53:56 -0700 (PDT)
Message-ID: <8320bd2b-b6d2-4ed8-84c6-cb04999e9f53@kernel.dk>
Date: Tue, 22 Jul 2025 07:53:55 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] KASAN: slab-use-after-free Read in
 io_poll_remove_entries
To: Ian Abbott <abbotti@mev.co.uk>
Cc: syzbot <syzbot+01523a0ae5600aef5895@syzkaller.appspotmail.com>,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, hsweeten@visionengravers.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <687bd5fe.a70a0220.693ce.0091.GAE@google.com>
 <9385a1a6-8c10-4eb5-9ab9-87aaeb6a7766@kernel.dk>
 <ede52bb4-c418-45c0-b133-4b5fb6682b04@kernel.dk>
 <d407c9f1-e625-4153-930f-6e44d82b32b5@kernel.dk>
 <20250722134724.6671e45b@ian-deb>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250722134724.6671e45b@ian-deb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> Thanks for your investigation and initial fix. I think dev->attach_lock
> needs to be write-locked before calling is_device_busy() and released
> after comedi_device_detach() (although that also write-locks it, so we
> need to refactor that). Otherwise, someone could get added to the
> wait_head after is_device_busy() returns.

Looked at this one post coffee, and this looks good to me. If the
->cancel() part is all fine with attach_lock being held, this looks like
the simplest solution to the issue.

I still think the whole busy notion etc needs rethinking in comedi, it
should follow a more idiomatic approach rather than be special. But
that's really separate from this fix.

-- 
Jens Axboe

