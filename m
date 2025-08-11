Return-Path: <linux-kernel+bounces-763522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4C8B215F7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 21:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94CFC463E98
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 19:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2636025A655;
	Mon, 11 Aug 2025 19:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nK/tQIUx"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F8027F724
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 19:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754941971; cv=none; b=OuXbQORd5lWOmEVZ6Wco3pXIMaYKi/pSX36G3rb/zLdpDG2IJYiCw4Vd0LBcSB46ca/ZnVckHLOgEAn8Cm2p5rbGedJosR/wJuEU3ie6MONsUIunLn71v9Ww08VYSgfClEES29wOeJ5BCa7kOz/IJoqNLkJqHKGrUlHkXoTGxdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754941971; c=relaxed/simple;
	bh=3J4hf39N9WkZYQ3OuHg7B9EnwWtZ4jUWaILAPmt/Mmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ECcqKeww1MOsxjhWdreKNF3AividnkLxc5EcQI8PGN76NXxsYnq3UBmAkMK8yPl+Ldj4nKh2pjiiU3/OHgdNS42Qeb0NfEFjHgbmaFySR57V7U7vP5QB6Q7Px7/HbHe1lagYIyMDPeb77CaAL+ICEgKE3M4ppfr2wS8GNZc7CM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nK/tQIUx; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-8819076dcc6so174267339f.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1754941968; x=1755546768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1m66q0fM0VeMd58sXC/PkiRndt2PM+bpxiTzs05zqa8=;
        b=nK/tQIUxXdHRLoQz8HmXUgXe+u6Kmt41a8f1eJQFC8GmMw/vWlUydL0vVSp1+9EwEO
         MIa4X15TDCH0TShxpaJHFmMe6SYUlZ5mijxGtryemZiPlIHWQOOHUhTmvNpouPdqhUe+
         vyuRQUUXnMn94e/zk0z6ik2A5lYLFcUw3SZDe61EBwwDyHg4u8lOUsfo7f/i2L0blIYm
         btr+XQxjbBPpZSjLYohH6LW1YwPex5t1rCKfplomqro+fNkzJKQH+fe3pgCb+EwuGIJj
         XrOZp57jrmUAAA+KuKXIdyNRYfWdZsS/lW5dIx1nhZy1KF2i3QW84ASG0PiMSTQhURQJ
         igJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754941968; x=1755546768;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1m66q0fM0VeMd58sXC/PkiRndt2PM+bpxiTzs05zqa8=;
        b=ZUnAzeBp9gwUEPFp3Y42QYezqhf3j7BuPtI2iUKB/aDbXSEQmeaWDCrg1yuYzewxr+
         QLPSoVcyr2wmgX11/GOMQK0cx19XzEfN8FAVGMTtA+htv47ZlZh5BtbBB+kKzHWg4G7f
         fxopkxVRawqVaNLz6vcz/FYVxbDsSF174XZ2+HGYVUR6RdPP2WRJ54HrCuYsi6G2CcBa
         vIPZQJedAaYtbans9TMDTpIaBpgd2arIi86+XubzKfDG2eN6SxF6M11BP2FB75EsbpEe
         ngwC7yesS13Ka9fXX60V68VtQhg7i16qxCj+9kysDynrMidR/OpnIM1f5gsXARMXkgUg
         kqSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUu2Zqes2t7pBLqYr5zXrDITkESfzDbj7fFqrvr5UtZ2+DeXhuvTTioVHMemT5qweSWokhtXbWli+boDww=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM2kvaU48UDgy86jQjbUxGJcHsVQCgdE7sosDFIablCHzYF5rs
	NnluzM7F4lswwmnMqtLCwYQdmzFKTmlngm/BF0ORPGAtZweknG94ZoHZ03PstZIaGoprRMvfk1B
	QWj3h
X-Gm-Gg: ASbGncv63amCllR6ostgEH0GVU5F8IR4nbSucXgwIhy5+2pRv1SkPJSBIGA9d3Cbbyi
	znaUCu3GiBrQd5AgpobzFhbyWn6QOUWEG1cmt04U40mfH4xUZT5SztgGBFclptPc3Vt03+MqmyU
	Uosq+ZRcqGCQmcWE101Wm9YYqSsw1DwjeCzUGKKcxsxuZGU6UhVEY6AJLmf8WaI6u/UtObEVPJ2
	5g1pN1ce36x8byTnIftpZPKFvKHjvoN2Z4UdvU7C7p6DTC9oLuHGIgBcFz9Lhdb4/9lBY30XltY
	MXDR9MCYkXWHCV70K5whiO03bS1vl52YKCUcDQrhvhFvwyzh1kMOo5MyMDm/t5OkPrhxs8Sd1QZ
	r4m23l93g/3+twSDp31M=
X-Google-Smtp-Source: AGHT+IHs0PmXKqLJy0GDWXaGD+BPqU2PH316ln49ZM8SzRwDdhor0dknz4aDGdM4QOlVwpmF3gNAmA==
X-Received: by 2002:a05:6e02:2143:b0:3e3:d44d:4d12 with SMTP id e9e14a558f8ab-3e55ae32ef3mr12016415ab.0.1754941968095;
        Mon, 11 Aug 2025 12:52:48 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50ae997b3acsm2586440173.13.2025.08.11.12.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 12:52:47 -0700 (PDT)
Message-ID: <62f9321b-9ab5-4982-85f5-bc386d863a2b@kernel.dk>
Date: Mon, 11 Aug 2025 13:52:46 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] WARNING in vmap_small_pages_range_noflush
To: syzbot <syzbot+7f04e5b3fea8b6c33d39@syzkaller.appspotmail.com>
Cc: asml.silence@gmail.com, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <689a4635.050a0220.7f033.0101.GAE@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <689a4635.050a0220.7f033.0101.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/11/25 1:36 PM, syzbot wrote:
>> #syz dup "[syzbot] [io-uring?] WARNING in __vmap_pages_range_noflush"
> 
> can't find the dup bug

Huh, did I mess that up? It's literally right here:

https://lore.kernel.org/io-uring/6895f766.050a0220.7f033.0064.GAE@google.com/T/#t

with that very subject line.

#syz dup [syzbot] [io-uring?] WARNING in __vmap_pages_range_noflush

-- 
Jens Axboe

