Return-Path: <linux-kernel+bounces-738315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F6BB0B709
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 18:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 219F63BB77C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 16:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE11E220F36;
	Sun, 20 Jul 2025 16:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="TaLaf4Z1"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F571A08A3
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 16:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753030375; cv=none; b=pnX4VJDRtFECrV7M+Jyp4kA9vTMMOigp28TLj8R5lfxomkOjNYxOaD3JFXPtsjBFmcJIv5FfoZEz41xpkL0cEeVKRjmslcSh6cLc/pAMJfyX9XPNr7YEFYhaqeYKWhjLC9zTHjEk35+zKGFnDsSYSD1LFlauKQZPR8xrNW0+LUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753030375; c=relaxed/simple;
	bh=4PwpNKH8Q2DpW937AT1LxyRZt2KyM12kPBSFFyk4+9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUv8DGsTu0VNb+BFBhkP5Gyw5pM28vXlFyVyhe9PrG8J1EMUb5vfXLA0OAATYUzQocVv4Xu6/CwDp7NlTxleKSvLg2/e1ckvUJKV4tTojCszzH6NI2pnMGsUSqOXvBQa2jqCiaoGYGtZ9npIGbZUxCq41hA3pdGBPPpqBSNNrEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=TaLaf4Z1; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-235a3dd4f0dso21419315ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 09:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1753030373; x=1753635173; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5g9J6n730EaRvQ/cS6fHvI1K6/7KH11pjfrToDZxHXI=;
        b=TaLaf4Z1Yyy3Nz179AmU/WHhYuMVea/Xayf2GVu/tV9O500k0s3ZYa3WtFO+T8yVDO
         9R7FU5U2G6exsKfjazjdeM6tT6FITlrjO1XgPtTRo2aCH65rOhPIZvXd+mdkEwbKKVJk
         vOktQekDvi6ohROhn5lP/e33j7ZxG8WYCLUx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753030373; x=1753635173;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5g9J6n730EaRvQ/cS6fHvI1K6/7KH11pjfrToDZxHXI=;
        b=gu9xZAnNhUujvYm5j425x1Y6IkZjk4tJ+6Jk/AaX1kFS/vxBG9mIE+WtMtArBxMgkA
         5lslcAshaCixCe0kb1rPgKFPwNaEN7rwGIVcjcC0JtK2yJbOUjUx+ukeW7sXYO7fcj14
         49exB72N5+GE+X0JYM9qa/6xJwNwRc/teCDzAWtiuJFAcHGuU/0vUXnG6wcIijPNM8Wz
         RKS9SnyVeVXh6/nnhpRZbCkII3DtqG+5CVV/1hiqYH/iT8xhYzb6sJXi12MK8sQ02qaF
         rNucLzuFIrVSHsxpNAPU37eKigwEExGaMCdmurLmyh+1Ecf+mvucGb/vnwHQ5mU4G/JW
         ykeg==
X-Forwarded-Encrypted: i=1; AJvYcCW0ZOnMPZgV8GIxIEiiexCzRxuPw4SWYUfnF6nxC03/05tq7aC2Ls+fMlbtQLPxos+ElgJ7siFHzqi+HKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF0Umvt/cw/UJtfNCB2YIJijJHeN0c2Tkl2fy8JJS1fI+g0QQD
	YR8jFHrxVrXHODMtqAeqV6yPz1MKhl6pCl2zwbtGsSJonmuRv/0V4ITSZBpjDIQlN1k=
X-Gm-Gg: ASbGnct+Qi/nu0EYAiWmq0+yXimBggbovyx2+KiIZYCEGAmJ77HMV1/7aAD97aH2s0D
	SWk9cz7aYNMCDImsmMkcLCYlh1KsX4+SXFAsqJdunDRhLQ0TDqjncmZG35VdhC4Rl0+uwtknVpg
	irnKllW/sbstvbczf1m64Et90nlI078InHEPPYU6qPih+/Ays5ImESYDH5bb5wSjzGO04EFkQkJ
	HSRMxY+q2Rv4ALcGWDNqU8Rk3JLovBXL7IFoEnUAC7e+3+qn3h8drYJGPoTu0RGm8zr6yufzPjX
	x7llVY4SfFHxpJGH5LUvmxMoMgAvQyI7qePElYp634JtS+tuAWkrKp+YOY2rOJljnAKeKoRykof
	38YdE404VihRqXZ32TfLulZgQ/MjVJ13hOlqu0BhrCqw1FAeseqVc
X-Google-Smtp-Source: AGHT+IGu4j0mRiBMJYNMw/BPoiEqpd7qeKKASroav1OqR863hNB3giu6x7o/eqfqqXM0dWh+qfPxbA==
X-Received: by 2002:a17:902:f745:b0:22e:421b:49b1 with SMTP id d9443c01a7336-23e24f9477dmr272435395ad.48.1753030373376;
        Sun, 20 Jul 2025 09:52:53 -0700 (PDT)
Received: from sidongui-MacBookPro.local ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6d1ce0sm43778065ad.149.2025.07.20.09.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 09:52:52 -0700 (PDT)
Date: Mon, 21 Jul 2025 01:52:46 +0900
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
Message-ID: <aH0e3oyKvvOEkFCt@sidongui-MacBookPro.local>
References: <20250719143358.22363-1-sidong.yang@furiosa.ai>
 <CANiq72nWFW-5DFJA31ugMY7v0nRNk6Uyb1KuyJfp0RtxJh3ynQ@mail.gmail.com>
 <aH0UOiu4M3RjrPaO@sidongui-MacBookPro.local>
 <CANiq72kRQ5OF9oUvfbnj+cbXk+tPTmYpVxYofTuCY1a2bcJr3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kRQ5OF9oUvfbnj+cbXk+tPTmYpVxYofTuCY1a2bcJr3w@mail.gmail.com>

On Sun, Jul 20, 2025 at 06:41:06PM +0200, Miguel Ojeda wrote:
> On Sun, Jul 20, 2025 at 6:07 PM Sidong Yang <sidong.yang@furiosa.ai> wrote:
> >
> > Although some existing kernel modules already use uring_cmd, they aren’t
> > implemented in Rust. Currently, no Rust code leverages this abstraction,
> > but it will enable anyone who wants to write kernel drivers in Rust using
> > uring_cmd.
> 
> Do you have a concrete user in mind?

Sadly, there isn’t a concrete user yet. I understand that an abstraction by itself
won’t be merged without a real in-tree user.
I’ll identify a suitable kernel module to port to Rust and follow up once I have one.

Thanks,
Sidong

> 
> i.e. I am asking because the kernel, in general, requires a user (in
> mainline) for code to be merged. So maintainers normally don't merge
> code unless it is clear who will use a feature upstream -- please see
> the last bullet of:
> 
>     https://rust-for-linux.com/contributing#submitting-new-abstractions-and-modules
> 
> Thanks!
> 
> Cheers,
> Miguel

