Return-Path: <linux-kernel+bounces-758669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C7DB1D25D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 08:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10B1518A47B1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 06:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630E21CBA18;
	Thu,  7 Aug 2025 06:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="XFurapCN"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D5F1A76BB
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 06:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754547433; cv=none; b=gP7lLJ4FpDSY6vSZuLIFjfGFVbM3nHONDrxGA0XFCuraBhofZXedT4iGyjDoudkKKNMbWZ2V36o/ONR3kgh2X+4oBWDyq7NYB57Jeh/m6OdW9av7B326M3s8H4TiZJQzSHDDEYL6b7p1WMZo8PQ2pCY2yHdRp2mdjeuX3U4K+/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754547433; c=relaxed/simple;
	bh=aTI7KRMb+mTuV/VHOg0lvKzCQkP79foiGNftYWWJCNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BcK+J3iPSmD8asu3CUZKkgVDPm5wfTDB4htdobwlakOpRu86IHaJewl3qO8Gd7wz+E4aNKXhZduhsIeKfctcNTMFPrmTJ+N8j0Nub2D14rx0KqCUS5WmDvXNdAjyytVDWgsKmBuZKmYkeRm8c0ib5labjKfp/p/fZ2j8x5RFTeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=XFurapCN; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-23636167afeso5276215ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 23:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1754547432; x=1755152232; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ce659OtSUkmpdV6NFKc1K9485Iy6jSsKTUwN0rRmfcw=;
        b=XFurapCNEZTdArLKizqI2uckQ6MwjfbfXjKuUmaP/r4ksrCj+Cnn9kITcGjGMrv47r
         noueJKpFrIGCynhLQFB4GsS1ncTSRcbHpQcfwP5mfk1pDjCFBJDoS2nkPH6VowtU+phj
         WJ+57AduyykJpShz3Hp2uMOrlwE960sRX5sXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754547432; x=1755152232;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ce659OtSUkmpdV6NFKc1K9485Iy6jSsKTUwN0rRmfcw=;
        b=J1FSMLH0uB7/N9rlRyj62xtdv2n2eFghy6HhDOLE5p6q0nXNpYQmnEivgHRA/uN36+
         c3FX1RHFgHYDFQIym2oc6dzX6lN+IbjNbwhq8oUI5DXWeMrDLYDeHzuk9RX+lFqwgHnr
         NRkw9BPVhaGHSe1ujW1nhYsshbDW975uaBqqseZYc7X5qHk+mWGdowjNsSxqwaw5uH7V
         5CUBYBQ5BiiezkOa+JJKXp2KHKKxa+KwJLxjXrKCFiPxYUQx0qJDgHUsdWqkvyQvwool
         h38YW868eaaS1Kuo/FfsfiSV9gDLdWCZL9M8lf158zXnwD6uCA4CM7P553B3eQ+xeziF
         rqhA==
X-Forwarded-Encrypted: i=1; AJvYcCWArKLStZAq5CAGDoOB7I8Po939HWcywoRoZ+RuamAJuX5YKEp4g8GB2ly++HUDnyF2PDgd9995OScfj8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YydgDyd89HNUIX42tGqEbTu1gSQumhH+9laztU1PgXDu3/IB0j5
	UPDPSl59lk8nKD6+AlT6yBtFxp0B/KcBcJBMWW3ub61WV4fR89PJNNQrTVpRucthIX1pcmtI548
	ojpIt
X-Gm-Gg: ASbGncudrgZPOZrHMvBaW3Bd+xnTfX6feXmXvU/kjC46lbx8R3xn2dQyZXZEb0T7Sba
	a9iqOz9c55uddq5YlUYEpl8CY6YwMEQVcbv552Aq4hYd2nWcKZX2yAt/WcPnTHNO3/gtmaO+Yc7
	jbSzg2ET16SbF758YH0bG/+X2vHyJjto2M1xOaiFxxn8F7uC6I54/lmijBFNduABhZOcKtQ2QnF
	mSf25wo1S/OLp3cgzpIrcre7B7KXV34wi6Q3WChzCSNtIFMzfAPHJpiaJDJrxs6ej2HsvudBCdE
	BnLVR/w9r2Jq2bjAlMHLnYMz1VIUiaYMA7TxLE/RL1JvKJSlV0nYYKqI6CEL0dGu5y6kDQyl/Dy
	bV9qtPn8OBxYQRMdZwMta+BfodiUu1FWCTjVchZK1KX0BSrT2+Yc710Xd
X-Google-Smtp-Source: AGHT+IH0frrBX/8KPXvenJx9gfme9Uust8UCZ54LaxAoHIwgcXp84/Tzc+gQadT1iW0DZKCuiadR2Q==
X-Received: by 2002:a17:902:d551:b0:240:5523:6658 with SMTP id d9443c01a7336-242a0b874b6mr70085135ad.29.1754547431644;
        Wed, 06 Aug 2025 23:17:11 -0700 (PDT)
Received: from sidongui-MacBookPro.local ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0f76bsm175262285ad.59.2025.08.06.23.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 23:17:11 -0700 (PDT)
Date: Thu, 7 Aug 2025 15:17:02 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/4] rust: miscdevice: abstraction for uring-cmd
Message-ID: <aJRE2CouQ4bSvCOf@sidongui-MacBookPro.local>
References: <20250727150329.27433-1-sidong.yang@furiosa.ai>
 <60A6421A-813F-4A93-88AF-4AE3027E1FA3@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60A6421A-813F-4A93-88AF-4AE3027E1FA3@collabora.com>

On Fri, Aug 01, 2025 at 11:13:29AM -0300, Daniel Almeida wrote:
> Hi Sidong,
> 
> > On 27 Jul 2025, at 12:03, Sidong Yang <sidong.yang@furiosa.ai> wrote:
> > 
> > This patch series implemens an abstraction for io-uring sqe and cmd and
> > adds uring_cmd callback for miscdevice. Also there is an example that use
> > uring_cmd in rust-miscdevice sample.
> > 
> > I received a email from kernel bot that `io_tw_state` is not FFI-safe.
> > It seems that the struct has no field how can I fix this?
> > 
> > Changelog:
> > v2:
> > * use pinned &mut for IoUringCmd
> > * add missing safety comments
> > * use write_volatile for read uring_cmd in sample
> 
> Why is v2 an RFC when v1 wasn´t? Can you mention it on the changelog?

It was just miss. v1 should be also RFC. I'll mention it for next v3.

Thanks,
Sidong
> 
> > 
> > Sidong Yang (4):
> >  rust: bindings: add io_uring headers in bindings_helper.h
> >  rust: io_uring: introduce rust abstraction for io-uring cmd
> >  rust: miscdevice: add uring_cmd() for MiscDevice trait
> >  samples: rust: rust_misc_device: add uring_cmd example
> > 
> > rust/bindings/bindings_helper.h  |   2 +
> > rust/kernel/io_uring.rs          | 183 +++++++++++++++++++++++++++++++
> > rust/kernel/lib.rs               |   1 +
> > rust/kernel/miscdevice.rs        |  41 +++++++
> > samples/rust/rust_misc_device.rs |  34 ++++++
> > 5 files changed, 261 insertions(+)
> > create mode 100644 rust/kernel/io_uring.rs
> > 
> > -- 
> > 2.43.0
> > 
> > 
> 
> - Daniel

