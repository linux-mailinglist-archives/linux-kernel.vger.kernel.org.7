Return-Path: <linux-kernel+bounces-679003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A17AD312B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 11:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28E1D3B5FB4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 09:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE43280A5A;
	Tue, 10 Jun 2025 09:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WxskI7jB"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5715528A3E1
	for <linux-kernel@vger.kernel.org>; Tue, 10 Jun 2025 09:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749546312; cv=none; b=Ow3i0mxl65Kkcida4B8EWhW58GuUh0sZtARHQIXJEGlfN5/xiY3R0sE+wv3AQoYJRGnubhD7ap3x+DrxdWYZR4CdqZ5meNh5KdPRspY3N7Zlq7hHQ2TLpi7n6QlGRDhPQFfR3YSAzNJfGSfZ28hSAY74fbsnp5kRfLXLPwPxpyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749546312; c=relaxed/simple;
	bh=3GM1WRqVYQXAazSmtHqVXUifnN2sHGlrFP+6YGCoYhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GaxBa0rm5mciFmr3ky3QGHKxZR/gB0NytVXSaIMVJUs5A7zxH3CqdeT/tXNceKOjojSnh4zYi7DSI2kzPFONt5yYehb2xkos2YEvVu9bP48XoOhHMV/hB8Oj3oHcAVE+jD1CApBenqHqLiUKLsaEghhyF7mjAqIngEFj45IWRZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WxskI7jB; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-31332cff2d5so3915054a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jun 2025 02:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749546309; x=1750151109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MxpjoO2mYPkQZpQAdh6mmcVEOjQK1F3ewQIY1Y/f3Y4=;
        b=WxskI7jBlYVLJXQyulu04qcMectt4Trgg6Nk4LjbJt8g2h4vWZ2GRPeEbsmOrPi9JK
         YzpstdZ950QKrKYmEb6VAFH5/XcyWkq0D5hYAxGC+2N6UXouQqFZbh7exahs7xADUNo/
         H5AOZ/Uy+OtzFM/s3xyj3Wxj04nKze2tL5UyrltR1DgAmto64ZIIHYNOfqXQ1ayGthau
         VjO13WMzgd9v0SskStzsNi2JiKSzS0n0zBv+g0y9PnLNTM6M2yKDleYrtixyehpz6rFW
         vSCtNnVh7A2jdytMVmH/3xK44kzS7w52aPZpNi+4o40I+WhfQeeG0EyNZ0QyW+Ovdm0y
         vnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749546309; x=1750151109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxpjoO2mYPkQZpQAdh6mmcVEOjQK1F3ewQIY1Y/f3Y4=;
        b=jJnxAXAM/3E3xzhjMrdZgj20eXSWCLPi5Y8/JA0uMc0ndacpdu5Yhg8GdetoCm/MT2
         RQMY5odWf7E5Naq2Rbi0cpnzzQ4jSjWoEYfadBLZqeK/UvJlftI0woBxiQ8rq09OWol5
         Qu7EA64bTr+ngN6T08UnNys5sNOHuV7sXS8fwYgz+VbRN4MriY0iUxohwSWRxuNuCa8u
         RWv/cHob5X+8dh5bu6X2nvWt4zKeAcEeUJEzsEJlDlrcbz5XOPIchL8f7pRmT5YUzF3j
         4/qsw8ALFUqjBFNHIYEbe0Sk0XNmmwRXyMGNypZtxhAfyPjgEo40EPwmnV8Jvq85bDCs
         rXDw==
X-Forwarded-Encrypted: i=1; AJvYcCXbwYxTjd1FzoP8jF4dPRIjCjhXNldgZnyuqjMHhEC4Qtno9NyEogqJoqYS1rC4o8CCTkZbTPcZMf3/tvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaFkJ4hxjQ3H63j79E2d4V9b99CQW2C8GcuL+BDDPlSIf6va3g
	UDHJNBOaSw0pafTnBD5Cu/nS9E4dXo9wY8lHiDYUbbbkQEhMLy1/wbH27hfvP2b7j8g=
X-Gm-Gg: ASbGncvOE/OVmdckq1thNiStGgfZetzj5kuCvxeMYR6Y5xXbiKg0KpVnVrNETjO5YDO
	mE+Dz8lT+96gqw9Y4WfujhuKO0iraPbzTmFRSJmJW25kFN3vJa1x01o14Vci4wglomjO+ohKoCp
	A8ip6xsBmu7jt/SXli6RRDOyWCQ4+xJ2bftE3TkF7vn12XfufleripbD+Hk7vz1cEsxq8K2qCLO
	DNM1QzcM7/LrWe0PyXsZN21fq2aaCPmpS2rfctVA0IFYMhQTHjll2ytqCqgDRFnHqFVJuGAVnMW
	5E6HhlbYeHP3XRz5lgq01p6Qhlvf8b0teO1cjtzZOOW4b/evp+Z03oOsd5F4Xj8=
X-Google-Smtp-Source: AGHT+IHHYZrKaT/gzmS9tsVK3hFeYuSn3Ec8BLsyZRN7hNdemDEI/1VCu0avcGXTkJj/JdBACM9Kxg==
X-Received: by 2002:a17:90b:53c8:b0:311:d3a5:572a with SMTP id 98e67ed59e1d1-313a15739ecmr2416667a91.8.1749546308712;
        Tue, 10 Jun 2025 02:05:08 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31349fc373esm6863637a91.32.2025.06.10.02.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 02:05:08 -0700 (PDT)
Date: Tue, 10 Jun 2025 14:35:06 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Benno Lossin <lossin@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Yury Norov <yury.norov@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>, Nishanth Menon <nm@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] rust: Use consistent "# Examples" heading style in
 rustdoc
Message-ID: <20250610090506.24lmdltnqldsra6a@vireshk-i7>
References: <70994d1b172b998aa83c9a87b81858806ddfa1bb.1749530212.git.viresh.kumar@linaro.org>
 <DAIQ4GUF8JGO.2EL4XVGRV06R0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DAIQ4GUF8JGO.2EL4XVGRV06R0@kernel.org>

On 10-06-25, 10:51, Benno Lossin wrote:
> @Miguel, if you take this, then:
> 
> Acked-by: Benno Lossin <lossin@kernel.org>

Thanks Benno.

> For such a small change I don't mind upstreaming it myself, but if
> Viresh wants to have a merged GitHub PR in pin-init, then we can take it
> that route.

I am fine with anyone picking it up.

FWIW, I have sent a V2 now with your Ack.

-- 
viresh

