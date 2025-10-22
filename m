Return-Path: <linux-kernel+bounces-865075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D57BFC27C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 536024FC8E4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFCA27B50C;
	Wed, 22 Oct 2025 13:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6CYPYac"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAAC26ED20
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761139355; cv=none; b=JjyHPLK+f4Tkf45mABT0aixFtdix1egme7lw7VgsGHewDfbSWduF24BIxGQdkZIddEH89gcqiBWyx/6471aBCJPAsih7y/IpKxfFh9kToZrf54bb26WTm3uzrz0x4Po2ZHUedalc4Ifp4bmxHNM3qSqH0TLxYzAF4q/RoJyBsvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761139355; c=relaxed/simple;
	bh=kIgAHNYvOFEuUkO4rNfbG2Xes9Yw1wwtK3/M1F3s6kg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c/Qnhflg5Vrhp75TXcpnshjnZgDqMn+5u8rh5XaBvObmjj7MxOP0lMTej7qR0/uG9Z8kRAgpERY+IZaFY2ZLL+3/OZ6WsU0wAjoRr5oSCoMg7q4G4gGqEzM/bckGOZFdJfP/B/Hhoi4dJ2ZoGtfp77EN9iwGg0C4x42+8+FrSzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6CYPYac; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5d980e08e06so1730824137.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761139353; x=1761744153; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kIgAHNYvOFEuUkO4rNfbG2Xes9Yw1wwtK3/M1F3s6kg=;
        b=i6CYPYacketJEN8ewnxIgtuOlv9M0ZPCQu9F2yWBeCYM2/wUS8gMZijQ47maa6efcG
         FuIxNW9NmwvXOXFp4kWjmA1IvMgLL0gj1wM+x+4KCG/MgFQmj7NiGrJ2UIfi6V8EWcC0
         A4Q/6yf5bddw0QRDqUipGzJY0qP37TESQC/0NBQm3+16j8dPwo2CzBB6DsJWNpzBfoDj
         pe0e31yuK4DfNVVP9ox1CmldmGawm5ix4PaZSJJrrlzJdaFwxDyIL2IKd/xdA9UPhfTf
         0uoJ0z7oPZbWxw0nZKfsat/IPYuSckhl6df0MLwk7mEjyB0OtoTrmK6dVs8QTKZt7U6B
         pwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761139353; x=1761744153;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kIgAHNYvOFEuUkO4rNfbG2Xes9Yw1wwtK3/M1F3s6kg=;
        b=VVFXzq7HCcfQwGw4BP6GprUvqHdqFQ5zVVu8NqBHLHYZVoEQa3olrdnnLAzJzFpm54
         c8wy7viDEcYXMWKPcjmWHwzRfYyCRT0pL8rVMZrddjb+OnWss5uVenizs7sKAW/7xI8O
         wLLz4tVu17Ztz3MN9xLLZmL7sRXUKgXSATX2Cmj3jrtittQUsTrOXkXXwN1JeYojrbbb
         HWNd76AerhTxXB2CRJMGDjiEbjWezbbPjZccDzLCDzJSRftkRONmCPKQjuOFLYJ/JGAa
         KeJFDJnVRbk7vnCK0Vh8hMeL3RumJUdgzxV4BMmPkgj96+Z29rkobW/6N7VxHOMmXym/
         zMTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAeoNODryX+jgrXV5ekAvUyusw5RRqnuEdiKZY5fZdsJ9qpmJZl6BbY2DoC0dNA3O3W21lWuZnpiVSy8M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz71GGSMKeWIS99+dZ5uj5wHlzs4Pleh9GMkT2cRI1k9xoL028
	TYtM74NzUI+pSNpzqBhnqvvij8zjx0EJdIdvbPOtKrH6bxPn2WUoHNbl
X-Gm-Gg: ASbGncvnqT1Xd7R0IlWMZjt3C6vOgXQZi2pyIxydmS5vwQP8OPybY7kZIN7D9+fllcO
	/oQq68wYj43fa0hQzLa8Iibn/Gf1N9cAN1mRbQ8OtCq49p0QlN50ag6IHCFoyE8SPbcKOLqfKKH
	Oy9sc1MraEzfk2zvWiXO9SoLywbuAk33j3bkOCKaR0z//axxmFovSEXzqI62QgNyzMqKVjYXFbK
	DsIxb2zn7tbRqxRssJ7lXe3DqFWWsq0DhhmKIS6VSkcN+IcE60NiyfEDlKeHwBk+Is53IsMKPa4
	5f5e74PeOW4Ry4+XfvBQFVZ9bi5fCLyJ1MGYVElnoSkoZoLD0sUzrAje3DmiLjFc68pnM/3EbuG
	vp+Paqh8ropE3hxOurN48eIuuDIONHGhcpPW/6r/HagLRleBm+qWeK6czsM61w9llot8GO/NWSD
	ZaNr0Xz5vG2AX3/MHy
X-Google-Smtp-Source: AGHT+IEm8L6FEpAdRSZbcd0wF9nqzm1wzgL/FJhZQKf70WgEl9kbX/Hyj0iCqdeQUn2qPBgEF/3rHg==
X-Received: by 2002:a05:6102:d8d:b0:5c3:d964:a689 with SMTP id ada2fe7eead31-5d7dd67f8a5mr6408266137.32.1761139352889;
        Wed, 22 Oct 2025 06:22:32 -0700 (PDT)
Received: from [192.168.1.145] ([104.203.11.126])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-932c3e32e11sm4680749241.12.2025.10.22.06.22.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 06:22:32 -0700 (PDT)
Message-ID: <9bb82a26-c0e7-4e3f-abce-0ef07e1cff66@gmail.com>
Date: Wed, 22 Oct 2025 09:22:28 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jfs: validate budmin to prevent shift-out-of-bounds in
 dbAllocAG()
To: sukrut heroorkar <hsukrut3@gmail.com>
Cc: Dave Kleikamp <shaggy@kernel.org>, Rand Deeb <rand.sec96@gmail.com>,
 Edward Adam Davis <eadavis@qq.com>,
 Ghanshyam Agrawal <ghanshyam1898@gmail.com>,
 Nihar Chaithanya <niharchaithanya@gmail.com>,
 Vasiliy Kovalev <kovalev@altlinux.org>,
 Arnaud Lecomte <contact@arnaud-lcm.com>,
 "open list:JFS FILESYSTEM" <jfs-discussion@lists.sourceforge.net>,
 open list <linux-kernel@vger.kernel.org>, skhan@linux.foundation.org,
 syzbot+4b717071f1eecb2972df@syzkaller.appspotmail.com
References: <20251018053029.226506-1-hsukrut3@gmail.com>
 <c2e85681-7ce8-43e3-ba08-63f8b854c8c7@gmail.com>
 <CAHCkknr6o_9zO+DYRaf-W7C46r17JUf2MFnPLm1dik=ei=LxcA@mail.gmail.com>
Content-Language: en-US
From: David Hunter <david.hunter.linux@gmail.com>
In-Reply-To: <CAHCkknr6o_9zO+DYRaf-W7C46r17JUf2MFnPLm1dik=ei=LxcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/19/25 05:42, sukrut heroorkar wrote:
> Hi David,
> On Sun, Oct 19, 2025 at 12:50 AM David Hunter
> <david.hunter.linux@gmail.com> wrote:
>>
>> On 10/18/25 01:30, Sukrut Heroorkar wrote:
>>> Tested-by: syzbot+4b717071f1eecb2972df@syzkaller.appspotmail.com
>>
>>
>> Hey Sukrut,
>>
>> Did you do any other testing other than syzbot testing?
> I also used the C reproducer to test my fix locally with QEMU and it
> no longer triggers error. Do you recommend any
> other tests? Please let me know.
> Thanks,
> Sukrut.
>> Thanks,
>> David Hunter


Hey Sukrut,

You always need to do testing to ensure that your code does not bring in
regressions into the kernel. If doing things to file systems, xfstests
is at least the basic testing that you should do. You can also search to
see if any other publicly tools are available and/or applicable, but
xfstests are the minimum.

Thanks,
David Hunter

