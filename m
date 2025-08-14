Return-Path: <linux-kernel+bounces-767912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E255EB25A6E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 06:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6BC516B84D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 04:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489661EB195;
	Thu, 14 Aug 2025 04:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WbbMssSk"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C1E2FF660
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 04:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755144947; cv=none; b=Va7fiePLvZzNi0jhxZS/7UhZ8fQpcULaifm/qXRdN4vOHCiNue5zdc6atM1Cu/gAK3OgwY0tKGqRShhtMrVVLz+Fjum+Rj8gmxkfPgaoGHQVyfEXzPGdMeptaK4O3Us0+JTPrzdyiNKfk3okyqh+2W4aePyZrPHTLsWpuW2/eZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755144947; c=relaxed/simple;
	bh=aINf4JQIOzGrbC8KNPOs49EQ27ER0B2fAmdlIOg6AJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukVKkP1IDBmlMqFQQRjA5FuEkXWckaqW2m/rpyOEI6/DaQHYfXSp2xl6XO+EcJTIyUu8mxD2bU6gFFNHzEP8+1/pU8mhj0bK1RcR4qcDLfpkLN+h67PWLo+3SLYYx4grZMMo1HU1hDkdZ8g/Svtzk1Ika6C0X5JFnzm42CkEcLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WbbMssSk; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b4717553041so355746a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 21:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755144945; x=1755749745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=34KWmLyAieUzqtSrdM5jM6hi2YW8C3abPtgGolrQZzs=;
        b=WbbMssSk6CC+POVataUcqsbb8ZIm6yeu0qcamUNRNS7FqPjSjSQlntqmNGL8qJrEcj
         TIu0vbE4svPNYwfyPYqaIx6A3amFzrVRNqN+vknO7M4KwTkSo4SSiVkEm7EedWdEs4b1
         QoQathfyn7dkILQFMDqkYqgF/IrwLpIJx+PE9WwWfg61h9tjILG/nNWMGsvOa+1jHjr9
         x0XlomJhooKDYcSNKzBk//9ifT5WpTyBBIRaUFLXmZAyIxSvxKCozNTyVIFGrHRmsNB2
         5hCETs3jZqDnGPOBHPIZVWSGUFFwMkXtfG1gBbkqEsis9OZz3mG+zKnhWD/cAdcuTEfE
         r4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755144945; x=1755749745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34KWmLyAieUzqtSrdM5jM6hi2YW8C3abPtgGolrQZzs=;
        b=JQuzkjXCOTGzcmgIMyzBoJITOqiYkgNrQPmwXsH0wI+jGkVqd8zJq+KQr487cLyQAU
         nS+Qr0+DYKzvXEY1WnnuwxHa0hh7+lK+W07jsR95qVbR1RqZzC6giOfoex3PHjc6/UUV
         MLI1vugkE/u0APChyPshxh/TwWynnYtpz5e1Ym79ZHNoKtGbDf5FTQaksDX1JGwyDgZO
         IEa2AVngMcTz3U7FyJkKog/waW0JC3fy88Ir5bCtI4NQ6FHtOJWfeCalSc8caSG7UUyw
         DHA+rJUW7hmaFbq3TR9VHenh0Pui1EyVuKsRHVBK2kTVVrX3j93IltGatfhEx9W46Rb7
         UU6g==
X-Forwarded-Encrypted: i=1; AJvYcCUJHftILMJ8nTP58Q4yVZno3Yq1M5wmdh5SBLlYnFGWVH9JLPxLoTDcbHqQA/10tCuTAczpfkK2sj0yYg8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4ehmjpem8WrTK1LYkbR4pJWyzwGAIPpoyiEt4UCTMwvcBGbem
	OFGUusRVAwAoKlE73TUYxxWJvqf3zJ06cQDJZ4gK0SaDsUBn6eQEizaCIlLtTiX5Kf8=
X-Gm-Gg: ASbGncvIGKYnNgFpOR+Kw1ofq0HThJ7FRelFgOM8/jnw/e/fTZ7P6HWMPRhom8F6yy/
	YZCZlilx+vWyUdnOTRCyG0Y3d+xKiN3/aViT56/mhmi+qX9MoH5JVPx2z9LRbXNaw9KMQuUzV87
	dz0ZPBY2rny5GGlAf9LsufdLWsMqakwXv5dR+AiMPY7OnxYWl62a4xO1pOe7K3zWI14GKBb59f4
	+dnE0qe5wv3KIuCO9P6ynSjsWiNXAKZ06rFPoYEVJr78UsfWbrrX55D2d5Aal8KO7zuE/8wP7lq
	9gvbhjoaXxgLOAjn0J9yEiTtETvVt/5J1TQZ9sYzlAXSqw9CcNUalnQTUUPthaM743nFoa4Ez72
	55Q7PD1hzOjxfGWEJf0ipdH6Lje4Xr4wp9Wo=
X-Google-Smtp-Source: AGHT+IFKmQVKtrRTGaZ8hTWhd7nE8H1E8AgUXml21TmSiOXRMbfiiTxpX/j+26/xYc1Zfc3ne6Vv/g==
X-Received: by 2002:a05:6a20:7d8b:b0:240:1204:dd5 with SMTP id adf61e73a8af0-240bcfbba85mr2301691637.8.1755144938050;
        Wed, 13 Aug 2025 21:15:38 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bd9795200sm31652911b3a.114.2025.08.13.21.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 21:15:37 -0700 (PDT)
Date: Thu, 14 Aug 2025 09:45:35 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Breno Leitao <leitao@debian.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Jens Axboe <axboe@kernel.dk>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 04/19] rust: clk: replace `kernel::c_str!` with
 C-Strings
Message-ID: <20250814041535.l7yj2wm4ae3l4k7p@vireshk-i7>
References: <20250813-core-cstr-cstrings-v2-0-00be80fc541b@gmail.com>
 <20250813-core-cstr-cstrings-v2-4-00be80fc541b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813-core-cstr-cstrings-v2-4-00be80fc541b@gmail.com>

On 13-08-25, 11:59, Tamir Duberstein wrote:
> C-String literals were added in Rust 1.77. Replace instances of
> `kernel::c_str!` with C-String literals where possible.
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  rust/kernel/clk.rs | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

