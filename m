Return-Path: <linux-kernel+bounces-806040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C68CB49138
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B99D41895A53
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C43330C621;
	Mon,  8 Sep 2025 14:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="RdbC8EDv"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A233309EF2
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 14:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757341248; cv=none; b=ZivN9msiuozTObOWYzNLWBMTnmFG++jDt/kZa/y8LolJrPBlypwlEyOeFj7kYNMvj00Q9lr7H5SDsMqnSkTi4BbnR4TVSPDttLmueaCrcpeQV+z8Mneakyl2EKRG2XPXGZr0clVNBRHF/946m1r8tyE5zzXzsU5BaKalv4B9AVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757341248; c=relaxed/simple;
	bh=a5MNQnhmk3mz6jWOs76pD/dm/NnFA+R8u3EEqxeCbPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dDlub8gZkPrggLO9Aw5lABJkXXEKSjtRfklpWpSBrDX8dKpC38vm6xoB5UXYMW2D2Xvio/lqL5uQhbytAXVeskNsLbJ3T15btlCBwvOWI3kPxBDJz3yJCmnMoeIa3SxusqxuRDlLhxc5dy9dd7YPRZwMd92rmk0Qz1yfCDzusWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=RdbC8EDv; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-251fc032d1fso21727605ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 07:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757341244; x=1757946044; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3jjuUuXK+WrOgi1W4/pTHpNwueN6b3LIrqzt6Nh5pAA=;
        b=RdbC8EDvkPMOap97VPvJ9MvX5s4oi4+AqQVW60cx59R/ynnPuflv9PS/DWu9ckjlk1
         eNLIB9okUjlVU09mi7mIgWug2DvMEgxHVkzzaaaiPU6F3vdLOvTrPQ+EMb4c1kx+St6b
         dJPWf5pBL0TmXFjitgFCrPlp43C4aCDgPFrsxlKSbfSZmGGT3REUyoHgMN42pDTBngR+
         BgPDJKd75WD1aLqAJwJSDVB5uA+v18ipQZHoEXHKg/cINwNiljNoFRYop95kb0Isw9WA
         3W3Nls3fP/j0Jg/vAn6vEXSyf+m4KFsh+XJXbnWt2v7YC7dg0wbMx/mA1M4n537UG2es
         xfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757341244; x=1757946044;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3jjuUuXK+WrOgi1W4/pTHpNwueN6b3LIrqzt6Nh5pAA=;
        b=w4J6J8Yg/JhVGa8ZKh55UU/BjKnl+QEPm/bvrwGo6/+Y9ufQvYtHbGy2FPQdZw8XMn
         irMhTXgrZ84RSQZw/gkaQsgfY/QbRk45/jkxN+PVAh1KA4ufC4HkctbSaSUDqTttoX/p
         pwB1n4347EwHsRBqzcZlF5Q+6pC1PvfmffAissQ+sj0rt1n/7DOk0lEdhH1SD2Ccvg/s
         iqbJZSQAuYEQ+5kyecOXgjXZ93Za4N2bjYfwo2mfrW5TPbA8QqtyijESejnMGrmzHFEd
         WBL4pKsPa9QawmfssslGiZBpzvFUmOcsVVI81m+95izZuUwJ+IccrcVjwepEMXTm+bha
         q2kg==
X-Forwarded-Encrypted: i=1; AJvYcCWZ+K1gchigEYXCJSiQS+j/evBQtoyNbo4CGvFh/+IlwRb7B1pNqH+HEm1s7qZRjqVkFDWpcHOGOpAysv8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/AWn72mCTxJEy/my14chxnLsSF4IevBq+uVngPToVrc7A4rl4
	j/1Q023yUvzltzKLeefBw/YZmh5QhmNKcSIwiSBrhbJPJgEbNPLdo/Ed/0gByy5V51B7T8mv07r
	IOUoj
X-Gm-Gg: ASbGncvLI7TrN3IzHyB19FFz0zjg9AsMMqy/9wwwJphdq8W069qOqkfBnutWfYHSO+l
	ROhC/Kytpfg0Dg3Zq9OziawtMhVZI6n5wJbSphaLTODdZOSG+UkEJTKNsGguSuqYEECNuVaXsla
	h0OI4I0Jbs36i2xAQJDZjaY3vAOrgo7SOrrHloysar418e0ilMLA1WdfcJoKkpjM+ukQ3MVWFrt
	cR0rVvqleb2lReCnXEKFNfEc3T5A6HCnmfcgwGaZkFqwcljrZaIr9NcexGLxbEDU3xoldgPiG7U
	4erP8l1qn5J5hMuRahSkNcilc+Yfk06wyXzevc787eJxYRrESPxwVR+EuRENcyWo7JkJbZsdO7P
	algMJMJI09FhtaOOeKEUU
X-Google-Smtp-Source: AGHT+IFhFVAhsFFQfNiBy8ngAoCW32BM2nFvfVL1ex17njJ+QLocbwAbePtZ7yFUeSXhlfB6beIDXA==
X-Received: by 2002:a17:902:f607:b0:24c:8d45:807a with SMTP id d9443c01a7336-25170e41444mr98195675ad.32.1757341243780;
        Mon, 08 Sep 2025 07:20:43 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32d5d6214f9sm5653595a91.26.2025.09.08.07.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 07:20:43 -0700 (PDT)
Message-ID: <71c05242-a522-4294-bfc5-d867bb154284@kernel.dk>
Date: Mon, 8 Sep 2025 08:20:42 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring/uring_cmd: add io_uring_cmd_tw_t type alias
To: Klara Modin <klarasmodin@gmail.com>,
 Caleb Sander Mateos <csander@purestorage.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250902160657.1726828-1-csander@purestorage.com>
 <3h5wdobeinxy7bbhvw3aztcns33cea3irxg4ckwvmds56ynyi4@45fy2e3uemz2>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <3h5wdobeinxy7bbhvw3aztcns33cea3irxg4ckwvmds56ynyi4@45fy2e3uemz2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/7/25 6:33 AM, Klara Modin wrote:
>> @@ -104,11 +107,11 @@ static inline int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
>>  static inline void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret,
>>  		u64 ret2, unsigned issue_flags)
>>  {
>>  }
>>  static inline void __io_uring_cmd_do_in_task(struct io_uring_cmd *ioucmd,
> 
>> -			    void (*task_work_cb)(struct io_uring_cmd *, unsigned),
>> +			    io_uring_tw_t task_work_cb,
> 
> There seems to have slipped in a typo for the !IO_URING stub here:
> s/io_uring_tw_t/io_uring_cmd_tw_t/

Indeed, that's my fault. I had to hand apply a few of those patches and
apparently butter fingered that hunk. I've queued up a fixup with a
Reported-by for you, thanks for catching that!

-- 
Jens Axboe

