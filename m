Return-Path: <linux-kernel+bounces-772471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE0BB2931C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 14:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7108248388E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 12:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AC1235BEE;
	Sun, 17 Aug 2025 12:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRUmC9Os"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59A83FE4
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 12:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755435018; cv=none; b=rFWablSAqTrNfyorFnr5Q8RzWWjFMAnRNGXV0Y5uarHvI9Xq8zf8a63apbvU43/CYQKaLTtSx0eyKpVVR0mq1Ro9RZS585OgiJedQgwnuKXKrOQxZslESvI6MgJO+vlg8PkeejR7w87c/4K6oqFLS9s0DmMJAXTKD9rkYwrFN+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755435018; c=relaxed/simple;
	bh=buIEKbGBqfPPwvooJc5NgpXPikvbfS73dIWMFhgGRV4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BkM4p5qGcdfP4sYwgX4T9My8XRopfsFmAz/j+wCeMIknAtc6O7CpeehMflAJtluTJ8H435U1Vdh4tFvCJSZ/yR4watmjiR+2CB1moPHJQRwmoWz68A6g2LSE0o2qFpj6M6o16eO1N5CAEVilLFQoZmdNIl8qJadHla43g01+yww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRUmC9Os; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b9d41c1149so2510705f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 05:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755435015; x=1756039815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6e2m4SV6ELwt3fvhquFPk3uPwUzCBMTsp0ab+bGkLC0=;
        b=nRUmC9OsXL9Yfs3r4RIJy1TVV1XIYUIsw6wL87VP/piTXEn3Dy5QFJUMtV5tG0GjD8
         yvdemh+jKLBBHpJD9xgRMVx2ErIwe0siYdapEmmGG8Yy9SpvsOFjXp7WF7fNePBGLGoT
         iTRYth0KDUpH3laqRwXeJGNd2WKlOMrq6Y2KQUhH07EZmVSNkVKTM0hEwe9A9s8XmhEE
         pKEMDXzH3kkNUqlUv+btQ9HkYx7o1bCtTsZy1PMhUezNuSChMDXI2W9tgcOgIdyY1lSH
         AhQuDlAwx4DiNkECHh8A4PgKs/EySw6V45isnK1Ba9ENCE/kr1OUgMn+hYpFm33mt/o1
         k8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755435015; x=1756039815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6e2m4SV6ELwt3fvhquFPk3uPwUzCBMTsp0ab+bGkLC0=;
        b=bou+Vmni7M/knv7QvhECJvPtWL0Jp5qSbHvTR6OVDBOjv5M7WJZ34VceuEMRbHaR8e
         u6iggiWC82rWS5UjfgFqqErIF8IbCUb5Ihm/qmSoMT3D+EbdN9G4RMc+qGnd8xkcFYvV
         fALVpP7Aupahn4NQAOwWilLXJGCeIzJq+HBHVxXXOyja83R0SejvbrX1xVnpz0rRvp1i
         7jQvZN+CJ9EuSRxXMbawpowWrqrc7jdImI/u4A3PQtDo/nzb/MvyBrtbZuk7AUNLVTV6
         YVB2fMNyxdtUiraQUaCm4qTJgHTjv7c9BHK8T/daaltVH/UIhg3kDWzdd+9jHAj5io+o
         bWDw==
X-Forwarded-Encrypted: i=1; AJvYcCXYun32nWaMptdUOPMiyqRQQy3ykmwDQM0gv0dRMRF9izfCIY9HtZG/eDBNdjD1Z/bTIpUWx6TTw27QDWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRC9qipeETqPWBh2+BUAT9ip+5/516SwsvkrEX1ETOclS6ygwT
	5s7/FroeTK1c0/mYErt24WKg2ESU/aMnfHJZscqmZHBfFL4YfePOf2as
X-Gm-Gg: ASbGncsBS051ZzmhO9sfI+SpURj81XaE4q2QAM4E50X6HkEEBZJdM+UftE4wy6WrO2R
	HN5LKTqHoz3tot7B5qioQAaU+tgSRz/bU+IIpqe+t3mzdaFLz2DD1XqfiIP95iYquty2HFZvnYN
	EzsQjHODXv8X8fNmxBl4JuZNTSWqvFjkoxW8WGGzuX9O5HAxU51WcErneOEVBrALFbQe+4xfWab
	j70QoSIXWTbiPATdYPN0iyWxANAGhKmkiiqMfFmkf7hp/HkxRQiXpzTWe/rXsy7h4fU1Olid4A4
	LaMM2bzxJO7zjmDflmXDS3OI3K4/R3nW89u6ArQhOevioJb5TInIYVi/Hh9UvdhWnJ1KfeWSpaQ
	2PaWtIXrbdtwsKArJgI8MeITROwaevqqx8J9Qt14vpP83lCZBSGwRVxgOHMa8
X-Google-Smtp-Source: AGHT+IET+v4zKOEdpQ9PBgBJMq2WYMwA938JzgR3LOj01FvVSQX2TZmhhc31D4xr63+Layimzkiqew==
X-Received: by 2002:a05:6000:1883:b0:3b8:893f:a184 with SMTP id ffacd0b85a97d-3bb695a4946mr6344653f8f.52.1755435014968;
        Sun, 17 Aug 2025 05:50:14 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb67d86755sm9130047f8f.48.2025.08.17.05.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 05:50:14 -0700 (PDT)
Date: Sun, 17 Aug 2025 13:50:13 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo
 Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Li RongQing <lirongqing@baidu.com>, Yu Kuai
 <yukuai3@huawei.com>, Khazhismel Kumykov <khazhy@chromium.org>, Jens Axboe
 <axboe@kernel.dk>, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v3 2/2] blk-throttle: kill the no longer needed overflow
 check in calculate_bytes_allowed()
Message-ID: <20250817135013.7567dd13@pumpkin>
In-Reply-To: <20250815164102.GA13658@redhat.com>
References: <20250815164009.GA11676@redhat.com>
	<20250815164102.GA13658@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Aug 2025 18:41:02 +0200
Oleg Nesterov <oleg@redhat.com> wrote:

> Now that mul_u64_u64_div_u64() can't crash there is no need to check for
> possible overflow in calculate_bytes_allowed().
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  block/blk-throttle.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 397b6a410f9e..66339e22cc85 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -601,12 +601,6 @@ static unsigned int calculate_io_allowed(u32 iops_limit,
>  
>  static u64 calculate_bytes_allowed(u64 bps_limit, unsigned long jiffy_elapsed)
>  {
> -	/*
> -	 * Can result be wider than 64 bits?
> -	 * We check against 62, not 64, due to ilog2 truncation.
> -	 */
> -	if (ilog2(bps_limit) + ilog2(jiffy_elapsed) - ilog2(HZ) > 62)
> -		return U64_MAX;
>  	return mul_u64_u64_div_u64(bps_limit, (u64)jiffy_elapsed, (u64)HZ);

Not directly related, but the two (u64) casts are pointless and can be removed.

	David

>  }
>  


