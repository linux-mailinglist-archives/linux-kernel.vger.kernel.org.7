Return-Path: <linux-kernel+bounces-738293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FE2B0B6D8
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 18:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 523733B97A1
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 16:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F073A21E0BB;
	Sun, 20 Jul 2025 16:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="RI63pXLi"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31886BA27
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 16:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753027660; cv=none; b=FsEWQtKLaNVR6D4uu2sRiPzKo1BFiqIJPKTuYfUklerboQ1v5x1ZNVBED9sKWg14FWuHpc/xwLNF/SqbfpnroXyG/vjp8qJU3GEnS3Se4XzWxNd+hXv830EiUM4Ds4HDv9c5LCOhCAqX5z26tQItxDy93SuO9VWmyp4oPN81MI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753027660; c=relaxed/simple;
	bh=MEAipS7tIqOOORhzOLxJEu3EMaurgTk3P3SmCmKRjYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVuptzazVyqcAM65eGP5eQxpqA/TiSVwewFbZquhekxuspgYFv5dbA+vTVqTC+I2AeHBSCuCHbhVn5mHGiR2wSUJn/kskvQkJ2Dhpv5p+8NsBIRZtLhaBh7+dAZzRcXVdMJM2TLSC0TjhGefUGmStZB4UxHZuopkt9tzfwgE4Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=RI63pXLi; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-23c8f179e1bso35307295ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 09:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1753027658; x=1753632458; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q8RUv7gDQVh9Xv400yvcTGdoBeNmRYOsZZ8FvZTzEiw=;
        b=RI63pXLiCCOy9Jw2OSad2RPSHhlSqt3JwtCVZRvcwQJmG5LOE7r4caeOyyGCfcz67g
         ARyTaKbDPzr2dgmr7abMvGU7OfYa8Tt3HstagpzXbHdlvg700GXSB8t/Dfm7n/MzINnL
         aPWySH7QpZQXQn/6r/PrxV0FJJFcfDP2rRG4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753027658; x=1753632458;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8RUv7gDQVh9Xv400yvcTGdoBeNmRYOsZZ8FvZTzEiw=;
        b=QabC8CX05IDOFhY3gX+6l0L/eHghcBp69bFJw4c5wtM77RiYcORBTNujKAtrAQI10p
         FyfqiifG4ESAbJRIus4q9wYNi4QfZunARBzTTDNAZuWSaauxFnUWs1zZZ7eZ+EmM+GWQ
         H3C3x3BIXCfASF81pKjrdQXK18b9E65AeB+iEygZ8WY5Nlevl0Zl5FDIpf/BlVQ/OWd9
         f+Ec3rVutba32ITzPP5saxmUzOeMobFITjmhKtOd0f6SVSdWxoOF8/NcvRaDfXTtPo2d
         AXw8yK4XytsGZrBD1HpBiv4ZXjtONzyU5Q1sIwMV9T6DTelMQ3fPnZGHSCEz57RXSERr
         u4HQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6I3cK8md9bDl2fWq1chg/2z9a21ZRjXCyC8yj7c5MYnYL8oAAlLJPadkVoWdvL1J5HgatuohKMfUpt0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTO4TxBPk9v7QmKQN1t0afzLyLQnqqMZYb1VL7gEfVDWIz3dUN
	99Fxm3XVs6/8V8liWx8uJnjNkKHXuiKQxWz4+cQPBg1gbiRFxKwAfZmzUdDcw1cjdLMPc253AoO
	RlYBM
X-Gm-Gg: ASbGncv6DbdUpAF/6NFpVtDcCm5nqB5KNCZg4DCf5Po/fW+C7I9ssk0olzv1+jwIPwv
	s4ALwY3UMXWgJlZEaG3olSrJMu/tby1VOGXVzhjKM3x0z0ZcXVfWMrge5B34qkpM32UuJrIeHSl
	qfi4S20OBMAyV5eyu6RPIULcZNstezSSvTBeno0Vvr8ic/5M60O+WGt1AVZ/SGY+LU3or6sot5i
	NZ4xlyhohKSwSzviUiy9GxDTuPrvpDoi4BdMXZY7SiA9NjHGakuemddvFqIRGeb71XOwX8zCirK
	nzQvkPOBVrUy5Y56YEOoNeq5iFErM+dONnddUDHp/TWYfXIiBCizil+hcKNOs1qI2buYmoLZZz6
	dutdCu4S8CikjuU7hMYgy3PDIvaWnTdxwm6mE9rBfMFnY7UrK/e0W
X-Google-Smtp-Source: AGHT+IGf/MnOq1vbpyuq47JBNkrTX3YVoxz/LvdQ9w+9MydBBoVrrzSdMf5GEBSblzU0JCHK+46alA==
X-Received: by 2002:a17:902:dac9:b0:23d:dd63:2cd9 with SMTP id d9443c01a7336-23e25780c52mr307048635ad.46.1753027658452;
        Sun, 20 Jul 2025 09:07:38 -0700 (PDT)
Received: from sidongui-MacBookPro.local ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b60eabasm43262175ad.54.2025.07.20.09.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 09:07:38 -0700 (PDT)
Date: Mon, 21 Jul 2025 01:07:22 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jens Axboe <axboe@kernel.dk>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH 0/4] rust: miscdevice: abstraction for uring-cmd
Message-ID: <aH0UOiu4M3RjrPaO@sidongui-MacBookPro.local>
References: <20250719143358.22363-1-sidong.yang@furiosa.ai>
 <CANiq72nWFW-5DFJA31ugMY7v0nRNk6Uyb1KuyJfp0RtxJh3ynQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72nWFW-5DFJA31ugMY7v0nRNk6Uyb1KuyJfp0RtxJh3ynQ@mail.gmail.com>

On Sat, Jul 19, 2025 at 06:34:49PM +0200, Miguel Ojeda wrote:
> On Sat, Jul 19, 2025 at 4:34 PM Sidong Yang <sidong.yang@furiosa.ai> wrote:
> >
> > This patch series implemens an abstraction for io-uring sqe and cmd and
> > adds uring_cmd callback for miscdevice. Also there is an example that use
> > uring_cmd in rust-miscdevice sample.
> 
> Who will be using these?

Hi, Miguel

Although some existing kernel modules already use uring_cmd, they aren’t 
implemented in Rust. Currently, no Rust code leverages this abstraction, 
but it will enable anyone who wants to write kernel drivers in Rust using 
uring_cmd.

Thanks,
Sidong

> 
> Thanks!
> 
> Cheers,
> Miguel

