Return-Path: <linux-kernel+bounces-817663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DF0B5851F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B273203E72
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98A4283145;
	Mon, 15 Sep 2025 19:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nrRwng/L"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA65628313B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757963179; cv=none; b=T9sHZhrlKs9NzA3HQxPWOxCHFnP0jJbpb90n6QcyQkjW/viXmFwpIlqALKt488fO+eRvQdctSnO1EoERPD+z+c6MvYupboAa1+9jbspjvtQlN4uG9j32CurMUublUOsCqSnJ8Juz75kiQunFpKsPxTJ29BMlNH1jALXVzC8NT/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757963179; c=relaxed/simple;
	bh=0iX5b+RQ4FVD35w9Laahyqwkc7xvtaE529Fi4r78dAg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Z3n4zLPrjzN047fkG9oB8pwho3xZgQw6KywfUgHoT7e9HvvrTs+nPct7aoSTf6ZsiYaatu8G4A3b3djzbj1cVOLDhvhw8xUnw/UlpCRlcgv6cDeuY2b7NLQ7+qmkqxfGqhgLkpy3FZuyPMqS5DkRxiEDFdtThbdz2BMK6G5HQ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nrRwng/L; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-88428b19ea9so149060139f.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757963177; x=1758567977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=605eAfcsvQtf5UG6Wl88Awayl0fUHXFSSCuYXHba67A=;
        b=nrRwng/L8Z2vSfiYeLSYJxBdR+wVkW/0oTqd/SyGoF83t8fa/way5PifEz429A4PLJ
         veqR2pmKasc/8HYrUs01AkHD/DPSt533K6zaKw3gw84t3CGSideqCgVH1MtYa9z2FkAr
         KXSj6/TNe59gxCsfRSFUhuHq8GDH5+ngyZnyLX9xR9eBcZ1v/wwOZQDSvoYRrQYC1tIg
         vnTMw28M75eKvKqweVS8vA9ck07CFo9Sma/DuQcdQ4N07jZHLZ2qiVaKNVOyXh2SEquw
         eRJyGTWPUPZQB1Ci8JUUjvFtEXzRTmJcgQeRJBNpB5GhheYVMPkXzmUz4OPu2kYh/+Ej
         voYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757963177; x=1758567977;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=605eAfcsvQtf5UG6Wl88Awayl0fUHXFSSCuYXHba67A=;
        b=UfYAaEpC/5irg6OVvcJTdBbQSDYBEwlH+eWFlVbDdAciA6iX/dqgW39jip44lyd2fv
         2KvgnJi5at3cUbspv3NaAG5B5n5oY1aEBffz5AtTcEFlsdyos7zgF35org0MWBCL/67H
         rXOvy4Nw4AXkqXEXiahCVZXWN/jjCcqau9blqn2UHJFWvKcksW1uPjmYuRINNVxB2tTA
         gQ+qdtUUZtp7NCATxr2DC0H4uFN+nT1OBeMOe91oGyKJkLSlFrVGz2UsdMnOrCGSvJo8
         XhS7GqKlj3JZIEAXJQL6mXYOhFH7WQxEQ0szY5LsJ5Wiqp3/Vd04ziWHKU1TzlRE/7Kd
         0C5A==
X-Gm-Message-State: AOJu0Yzs9J/p6gUNrerLKLVOd23H6sYjLa8FI/SmRy+iB4DtcxGg0aVt
	qOkLowu76QjNmth7695yle5s3TvRbEow1VmlctTaVgAU/KSUVdN2gFK3dJVhoImtXYwd0+jINlB
	DL8/f
X-Gm-Gg: ASbGncvzcClxq6p4JlQuvg1lfU3v3HBI807ta+nthFZ0eXSydmK+6ABxLKVyXU7B+NZ
	f0dZ0WVZd9wQKsWQTAQI510H5uanIv5hDoGn1aPpZVidTWNMgAp4Rb/yUi3fnGDaZ+sAgAFdvFX
	Q5cvZLokT8JUFpgjlf9lGKnAmUMld/jLSKqwzBK0aKMNMAejJ0UvBXJ5EU0SbpBX2YHR7hbBD9l
	5aUQMOk1SEYO0ZpcqJm03hWCy184yv+WbDbVPlUJq0eQ3KiA4yZ6bl5uM0QrFlE9Vd8Ny8z6SnB
	JJTJoCzPNHoALSv1N0xhgrhQjMlWplle1w+PPy0ar949rzkqvY/356PkFQRL5Bcfr26V2Ettao+
	uw0KETtXSqHg7Vw==
X-Google-Smtp-Source: AGHT+IEf1HsAMEBW077DlyavSFZ5TnC0Pthsp1POX7u07ToTT+gA1ImLyl8ajqpBQimicV7MfZVDzg==
X-Received: by 2002:a92:cd89:0:b0:424:86d:7bb9 with SMTP id e9e14a558f8ab-424086d7e93mr30986755ab.0.1757963176759;
        Mon, 15 Sep 2025 12:06:16 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-41deede6d15sm62947995ab.7.2025.09.15.12.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 12:06:16 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
 io-uring Mailing List <io-uring@vger.kernel.org>, 
 Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>, 
 Bart Van Assche <bvanassche@acm.org>, dr.xiaosa@gmail.com
In-Reply-To: <20250913162540.77167-1-ammarfaizi2@gnuweeb.org>
References: <20250913162540.77167-1-ammarfaizi2@gnuweeb.org>
Subject: Re: [PATCH liburing] liburing.h: Support C++20 module export
 feature
Message-Id: <175796317609.265653.2867794592544924823.b4-ty@kernel.dk>
Date: Mon, 15 Sep 2025 13:06:16 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Sat, 13 Sep 2025 23:25:40 +0700, Ammar Faizi wrote:
> Having "static inline" functions in liburing header file results in
> compilation errors when using the new C++20 module export feature:
> 
>   In file included from src/work.cpp:3:
>   ./include/liburing.h:343:20: error: \
>     ‘void io_uring_cq_advance(io_uring*, unsigned int)’ \
>     exposes TU-local entity ‘void io_uring_smp_store_release(T*, T) [with T = unsigned int]’
>     343 | IOURINGINLINE void io_uring_cq_advance(struct io_uring *ring, unsigned nr)
>         |                    ^~~~~~~~~~~~~~~~~~~
>   In file included from ./include/liburing.h:20:
>   ./include/liburing/barrier.h:42:20: note: \
>     ‘void io_uring_smp_store_release(T*, T) [with T = unsigned int]’ is a \
>     specialization of TU-local template \
>     ‘template<class T> void io_uring_smp_store_release(T*, T)’
>     42 | static inline void io_uring_smp_store_release(T *p, T v)
>        |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
>   ./include/liburing/barrier.h:42:20: note: \
>     ‘template<class T> void io_uring_smp_store_release(T*, T)’ declared with internal linkage
> 
> [...]

Applied, thanks!

[1/1] liburing.h: Support C++20 module export feature
      commit: 5503c2b545709e1cf8484670aa7088a827f4818d

Best regards,
-- 
Jens Axboe




