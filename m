Return-Path: <linux-kernel+bounces-733538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC9BB075F2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D5623AD9CC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD91C2F546D;
	Wed, 16 Jul 2025 12:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="uxbc5z6d"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AB82F546F
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 12:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752669675; cv=none; b=KPxokiuSOkr+wsEgktpt2m7zfw5Kd2xPnE2l1vxfvy/WYXx9kjMpIbJZ+Qb1hxjf+gJS09xG1ToP6Yj+za4VhiWL+QqeB+nQH9aU+nS9zQakSVlJy4pcjrv9p/s4acp5U5EwCmyBaVy8f+My5JPrstKPdEvWWgxs26mqN3tl+4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752669675; c=relaxed/simple;
	bh=cga2vmTkzUhL4ZVMLscasBhMNW0iy5jkUZxhXYAfMeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E94kSvq8atfTVVhxUOc4+HKTIbtsnd8OP4UjxtlYu1rjx+9hgYY8iNgt6HXdjABDmlOQ9Xu6HzrargRp8/IeDlPqDcC4Iv8IQJh1/Xp3hLIpnhShXxdY4dm09AbGRaV7ND3+RkghT7qc4t3o/l5Q/RQ/mYM6rvTkPcsji4oVsFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=uxbc5z6d; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-8731c3473c3so43041239f.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 05:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752669672; x=1753274472; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5IyO6wUl//owvi+Xi5g+hOG+WKmfJL+fQ0DzM68WhPQ=;
        b=uxbc5z6d1D1qLOq+D/kU7ZCHjjiSgy+EdypBiqrxs7UbkxwqqH1Rkja/WX+hyyaMVe
         nHxYAivWhIhmh0qRG9Yl8kkUF9jNznWTTXDpvPrBU7Ww0NgLtzNwRsIbhdBT5oF0FOoh
         k/3G1OrrIgrukfTIfo2nd+JWhI+t71rMKj8NgscCi6/j9I2kl2J1KbeQ8FldZHymHOfo
         vZ9YGG5ezLzH0EcLDP0a3Ko2kNmj21exmDKIRsbQx8W3xE8SeaXncamaJzcDv/u7jHUH
         hvbZ0lx+POXSBX1Ocm+6PCeJQQ4AqhORLmERrQc9y3cdnA+q+MIcNMNvvYZgY/2rLWJ2
         wLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752669672; x=1753274472;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5IyO6wUl//owvi+Xi5g+hOG+WKmfJL+fQ0DzM68WhPQ=;
        b=FP1+QtSg//h+CEQXhPI7C1doct5wm0D7yDMH332AVwxKnTQOhL1PL/F7sbr/cquCw5
         OFsVh2wGjKfHo2FcUp5P7aYX+kZml1KYVDzY2byspHcL6ENIyv7iuJ/lKUUJ1/M6WtV+
         Bhdh5xnIceU1pYV6JRBh8Q0eiCyxgYrxM78pt5Kkm/M5qhgZwICtgG+QnrnUuJBExO1x
         xLA7UyCwbJeCjW39JFv/6fwM/y1tzsKca3VZjPnO0Zp0E7DVpmc7JQU0Wr4IgkMewX9h
         7qrPcrekz18vW+s1XgdCl5oWCZs1yILhCsXNDAJ1K5K7wLEiGf/KD+yO2/hqeoi3ytj1
         VJXA==
X-Forwarded-Encrypted: i=1; AJvYcCU2qpi5ab98ANkFKe6yxxTv/NyKnQkevKyGJUBXLt+BqBUPNe19ZA3W2ETiAvT4SGJKiKMJD2Q/KslxAYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQAodZoRAbSuk/2lWolj56YRgmXV1E0hH9Wag9lx/XhgnO+5Jk
	qTk43sqcdLyCSgLYSnqnFebwt4uSdnr4b8lEsin82WC60qVB4at/8C6p3XP31Cb2xoYBAHqrgzj
	D6a2F
X-Gm-Gg: ASbGncuF3MHqtZRL52dBOIE4bpIZAe/oXZw7YduZ//UcrcPUiSmcY8GyIV9pNhVMAF2
	cdU1FbPFqO1S2cLwVXmpBqbsI0bV9DcHUWB6P8OeM/qiZT7N6gQz6p3OUWP/48xMCWW3GPxjFRE
	IVcglPvd/bcqbWU+flAwFqQEUnHbE2RQgKjFwLKnlmrgJG8q1J5O3uoFT+i8YngnXhTiUINddJu
	gAjheXrQTMShFNzDhkwbot7SJ99Ps3LN7lL1bvYmTDKbrAqpEKwjEjOXUQkHsTBVtM9pOslev0M
	afH+oDtK/zaYyw8VYF0rwW9j8sw9i8MLfIuHqMtAjH2VCMDRBYrLXs75C8MMfBMxtYMK2GmwJ9S
	MZ1kP9AAkipV7UOLGXGw=
X-Google-Smtp-Source: AGHT+IEaXkz1qDW6FctDCit+gCLbqFb/TZneYPdal+/fxuNQLUjjm3E8xB2iDIfQRJdJclhXIeMwNw==
X-Received: by 2002:a05:6602:641e:b0:861:d71f:33e3 with SMTP id ca18e2360f4ac-879c2877178mr253394639f.5.1752669672141;
        Wed, 16 Jul 2025 05:41:12 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50556973045sm3044134173.83.2025.07.16.05.41.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 05:41:11 -0700 (PDT)
Message-ID: <3b28fddb-2171-4f2f-9729-0c0ed14d20cc@kernel.dk>
Date: Wed, 16 Jul 2025 06:41:10 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH liburing v2 0/3] Bring back `CONFIG_HAVE_MEMFD_CREATE` to
 fix Android build error
To: Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>,
 GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 io-uring Mailing List <io-uring@vger.kernel.org>
References: <20250716004402.3902648-1-alviro.iskandar@gnuweeb.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250716004402.3902648-1-alviro.iskandar@gnuweeb.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/15/25 6:43 PM, Alviro Iskandar Setiawan wrote:
> Hello,
> 
> This is the v2 revision of the patch series to address the Android
> build error related to `memfd_create()`. The series consists of three
> patches:

Took a closer look at this. A few comments:

For patch 1, maybe just bring back the configure test and not bother
with a revert style commit? There is nothing in test/ that uses
memfd_create, so there's no point bringing it back in there.

IOW, patch 2 can be dropped, as it's really just dropping bits
that patch 1 re-added for some reason.

All that's needed is to add it to the examples/ helpers. If it's
needed for test/ later, then it can get added at that time.

All of that to say, I'd just add the configure bit and the examples/
helper in a single patch and not worry about test/ at all.

-- 
Jens Axboe


