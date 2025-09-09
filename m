Return-Path: <linux-kernel+bounces-809007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AB3B50762
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E16517344F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC9935CEA7;
	Tue,  9 Sep 2025 20:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="E+N0KpHO"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3648D219ED
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 20:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757450801; cv=none; b=JapTZCFniR3MU6x6ZzlUYuYF/a/eC7HKWbObyh5HKMxdj6pMT8KoQ/m4qdLXZ94KhDsnuGDP89wlDFIG5p6qimbAzIezR+0RpJ7S5XpY2yzD1NM7xljqo+2xYEBl2OuzicYM7DrOQn6IKmG6joUtuwrr3z5qpL9l4+VOFNO73ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757450801; c=relaxed/simple;
	bh=Hq427kPS2miK442XFFBVzCy9wq640yhv53nvrsGnYkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eLZFJJ1RImPzsJppYE95Tf97Jwa8QCjjnlv9g63hTFFB0IOf8p/stXMG16iWDxf39iNmbqxoGtEIFzUnSlIGa/C68KQ+JCaCqmUqJVDnpP1jEXvSZD3pT6Qzh2rrJ0AtxM7HsAdFDptTHLficnU2aBai64Xt1Q4OsFA+QSNw7Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=E+N0KpHO; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3f66ad3fcf4so61749995ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 13:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757450797; x=1758055597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PA7xlsC4S+aw+b7TXAWYQzS0qsum/YXvD5BgIuU1u9Q=;
        b=E+N0KpHOfrmuBOQ1iUhkwiAkbMrniDcEbnpEPuxsZ3crv+KlqGs/bOSudVsu04mtuG
         fTr4aFk21ekLH0H4u2b8K4HsfCzpk2PUdKp5J8x+9QY+VJO4xP5RhtTJoC6YT2Ym7FwX
         wdBg+Lc5w4DIxBoXY4H048I4nJ1WjmjBtOTbfgLAfVmQK3CXZq+DAlX2ON0ZhowcH5/7
         rNYoU7X6sGpT05DO0DKlhxmHWhJpddLyxPL5bvCgfKDtTuGztW9WOzIjc8lfThDHYsq4
         dTnVKisXTAGZR1sKkLeTfSmawYYT+4jr/XAulLI0AX8BqOHRaaNRHpfxwIfIDuCRHSNz
         LBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757450797; x=1758055597;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PA7xlsC4S+aw+b7TXAWYQzS0qsum/YXvD5BgIuU1u9Q=;
        b=CVBjp+p+4RtRUj4hTnqMFXM8EvH46UN6hyeumKoGRV8KOywlWs68ycmyea+CXQuKzP
         aeONlQNBrCLG0itCUnXajUxDk7XZ+RY4LAVyySjFbHyCjYWMNxRKLE0QzpdpiGcjfwFC
         6V39u3Lih50wxCpa3Li90U22E3CiWcjAvTxqOZ4a8kSTUvuCf0O0jSL9gA4IDADoqS6+
         d95p9p1rYexQx2HwVb3+34N9NUGMj7Uo0fWtlM4OqB5kxNspeQArBS/H+jMI+KjrjcXm
         UchkmZax60faHtL8M8pVg4HHzSI2CFWgWojwtiNkaMaFM2EJHCIO4c1wlVUNsDQnMf6Z
         VraA==
X-Forwarded-Encrypted: i=1; AJvYcCVFiJJapjE+A6MX5bgk+BDq4usGuuU7PqF/q66OQpL0eT6AldnE4euUYIdTssLS4YK5YhmCvG2o/UqPVk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgKnEjBNq7717wM9nPYYTIjN0Of6hHB88RsWMtbDhTdTImYemb
	qA3uuHc975HTjpkaY1zun2Xt5TYH/Oq7JISY7cms8/L5RH4TRXF3XV36Tm5AUSYm/7Q=
X-Gm-Gg: ASbGncuAOv74Y+bkBEkTdirVPHaaC5LCfiQOyZCIt8WN7H0Xso/baDErFLuc1sg+IEO
	vLVpAliAKaf26kcyQfI6b8s89fxxtI84Uu/e7njsHQBx8S+ihRfZ54o+cXj1Jmu7Hs31mrqMbJP
	GWkK9O2k7jaWo/jRW3ckNyaOM72bCLmiJWX1bNQ0vGEV8Eg86mvzIbwAumPd4qqm5OFNwkcXpTv
	XJvfyhTv5izrMlwjeqWVUI2txu3o80fFITnf2n7XYeTOeersV1W6Rsd0qRgOpibwT/xZfqiJU8A
	x9M2fV4lI47HWGb9ju5qWjFt1Uuhw77/8bk0G19zbkV9ZQBICi+AAChtyS8VZc0il6QEqdQusbd
	TcE75bmsMYFor+d7iikrN0x0jKsHy7A==
X-Google-Smtp-Source: AGHT+IEorYLiIUcTOLOKhl7TmrPddwxBXnt7SwWoKYo51E6cnrr8fsOYZes8knHgAIcn7aa5spExLQ==
X-Received: by 2002:a05:6e02:3a04:b0:3f7:6111:6653 with SMTP id e9e14a558f8ab-3fd8811510cmr170961525ab.20.1757450796447;
        Tue, 09 Sep 2025 13:46:36 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3f65d1ef2c7sm86406095ab.5.2025.09.09.13.46.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 13:46:36 -0700 (PDT)
Message-ID: <81a70994-8195-44a5-9da4-473c01197fe5@kernel.dk>
Date: Tue, 9 Sep 2025 14:46:34 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [kernel?] general protection fault in try_to_wake_up (3)
To: Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>,
 syzbot <syzbot+034246a838a10d181e78@syzkaller.appspotmail.com>,
 andrealmeid@igalia.com, dave@stgolabs.net, dvhart@infradead.org,
 linux-kernel@vger.kernel.org, mingo@redhat.com,
 syzkaller-bugs@googlegroups.com
References: <68b75989.050a0220.3db4df.01dd.GAE@google.com>
 <20250902214628.GL4067720@noisy.programming.kicks-ass.net>
 <20250903130712.br0G6lOq@linutronix.de>
 <a1808501-559e-4762-b0ea-f1fffd2e7f19@kernel.dk>
 <20250904162820.NS1U-oZp@linutronix.de>
 <4918e983-9964-46a2-aee0-59c91a9c6b35@kernel.dk> <875xdruzl4.ffs@tglx>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <875xdruzl4.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/25 2:43 PM, Thomas Gleixner wrote:
> On Tue, Sep 09 2025 at 13:27, Jens Axboe wrote:
>> On 9/4/25 10:28 AM, Sebastian Andrzej Siewior wrote:
>> Was on the road, and now back at least for a day or two... So I took a
>> gander at this one too. One thing that puzzles me is the io_uring traces
>> in that syzbot log - if they are to be trusted, it only ever submits an
>> io_uring RECVMSG request? IOW, no futex usage on the io_uring side at
>> all?
>>
>> Going to try and download the disk image and kernel and see if I can
>> actually run this locally.
> 
> It has nothing to do with IO/URING. It reproduces cleanly with the
> provided repro.syz. It just takes ages. The bisect log, which contains
> the IO/URING muck is irrelevant.

OK thanks for confirming!

-- 
Jens Axboe


