Return-Path: <linux-kernel+bounces-806644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B1BB499CE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 077A0166C77
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367F22749E4;
	Mon,  8 Sep 2025 19:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaDbZ97F"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CB526CE3F;
	Mon,  8 Sep 2025 19:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757359280; cv=none; b=cqVDTslw5sQAdPpuaybonaakKL8HLY3z9NtZV2wPS1Z32xqy4/VNPhmOf7RiUSyCfEK7RenCXnpE8CYGBTExsodWnO4S78q8W/1do0LmdNadeCsdwRldHI5sVt1VA9+vwrJ9yHOGJ/opbla/r3pB2WRVWiNiJ6cY0i2dXNTNojI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757359280; c=relaxed/simple;
	bh=DnsN3SiunjW30Pc7Ja1WNWuLjt0wV0mNNmfV3ffPysw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mopkfS9BIhFaGvFz8ZJaC1XDWu9mqpgW8wCfqueMj31o0QO9AsuGkrsWccvP1IZPQXAiLR2hSgvfs3WlowHloxNgnucrkaUw3X6PcpgrFiIPvw+yJlDGKV5TVAIPbELdefNB4SBBIbzLlY5mUgrm0yDDAZsakfnReanCeoT5zIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WaDbZ97F; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-77238cb3cbbso5022075b3a.0;
        Mon, 08 Sep 2025 12:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757359278; x=1757964078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wgg1at4wkwhreQI7T4ximNUyuokPLJmixYnE22ApgnE=;
        b=WaDbZ97FTn7EwZo4h4zkEEpc212V5ozCpqxY4Gv545NQn14WU/itydcZPeljPMP72Q
         ugE98EiYZrVPjQOtxMckB3isVQ1UANJ4QJt2gnW+nOrEc9c/4e9EoCNXFmuePis52tCH
         VTZaBYE/2bTRxC4p1UEhwbktaJEDloFwyoMUCan9f8YUQ2FQDHzwHCxeJV1+UjimlijA
         IMkIfdlWbKbztSWjiSSNWXng6L4GwEG4UUqIfUfOssIvMNBLZi3t+H1uLOlU0fy31Lfk
         ADEHr6GYKSfKSdkENYcwNJjzsBVF4w5z1oWRNRq2IMaf4UQJbUVN/2ksmp9J/1m/OfhS
         meHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757359278; x=1757964078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wgg1at4wkwhreQI7T4ximNUyuokPLJmixYnE22ApgnE=;
        b=B6V33VAx6kamSdbn7K6ZoEs2CBo2pT9rIj8sYsaqhniobtoe2NjdQVVoh2FDrVjR3T
         09CSrW73pZCdh+4ykXqcV5QLlxCNNokkHKl7mx0e14ohBnNpsKYLNjD8LE/KUP+Z3OHV
         CLF+qPIHfUEUeJxTrIo3u+tAOMT4LHCbxNe47HfcHlYCskdM9dUAzEyhjabgnStPbb8r
         PA4sgudYd0wS7jsrVusI+IpMgpVP0R3AtwUeZz1zG/DFrLxfiucIiqVWjg8t6rzfFouq
         DZv+g8uORrStE9w7B8li74tUQFeZcRyK0l+bNlqVXNYRgUuc6XaaLZeD7clEQnjHV81b
         WpYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRWBBPLfgJoN+7HFxmgXTFaEaC7nOvu6ql7Dg+BkQGO25q1i8MrjDMHYcbyn5YpV71kHpT5+pPga2p@vger.kernel.org, AJvYcCVT+kHWl/ox9i8fPswuwB4s7jpvKnM7fdQLCa8fiup9hLchTR7lolZ/AaT2yCjIyqJD6JXRlKnUoADO@vger.kernel.org, AJvYcCWx1o5rHO8IJomslBnTrIxwBr6VRPpFl79+F2u6YGDlqaD8KCTq3A27Es0aVz8cXWid8+jMCq12uSOs9x8=@vger.kernel.org, AJvYcCXeLEAIhg180UD6uzyUE54BugXpWVRNvXiojwlh6Vavg4GZDMzlVAkI6LH4aude3iKRWFoXZKtN2rEQ5EG2@vger.kernel.org
X-Gm-Message-State: AOJu0YyKoXk0fPemP86dMYbZigo4htldaOo8nL/L3wb7hHqmFikLH8jR
	oitmuS64KewOyCJhYOu2YfI/UZXyBJI7PUvNS5DikqRuMysLHMAbCS+e
X-Gm-Gg: ASbGncsqXTlyI8XDdjzInsbWZRuFdhug0/p5utlRB6FClTD8qB5rrFyXQ8ylGupx7GN
	zbcroPiF9BB1E5ZVL6wuS+Cy/tidzqYX2HNtG2zNs2e0TrxHGO4PDTfPU/aov9JhCrE7jxCtijq
	dcZ/Sc4D/5U6vHJQ28eK5S2rdrQeSKmAQlmWqmhv4Xp8U3lmUf6zoJGJdqX38KucR2B2L+BMUZP
	q3FBTUuw757XoAdkZP1rSHtZF/anOyqloMJQRSFVsGcEC8zYp5imtlZMQ61HuSmZtjKsMVTJ1zs
	ZyKoZSJX/1M1bfnvHPqBcz070jTdWJQDm4qrqQm+HSnwVc15c6oQkAWqM845akZsGU2Fz1aVVLk
	vinGAZv/KN4LkxHqAbessSxv+FfD5Qit4EG8=
X-Google-Smtp-Source: AGHT+IFlJrpMAAnyy7zodare26mRKWFXFZpuNf/04HtUbLbUJ+XjBGtLGQhhyMm8Tce/rYcmFHo6Vw==
X-Received: by 2002:a05:6a00:1598:b0:774:52b9:b17e with SMTP id d2e1a72fcca58-77452b9b3d0mr4075187b3a.30.1757359278050;
        Mon, 08 Sep 2025 12:21:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772409e1e65sm26446404b3a.101.2025.09.08.12.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 12:21:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 8 Sep 2025 12:21:16 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/4] hwmon: (sht21) Add support for SHT20, SHT25 chips
Message-ID: <5be8972f-0ae3-40d6-929c-d737608d898d@roeck-us.net>
References: <20250908-sht2x-v4-0-bc15f68af7de@gmail.com>
 <20250908-sht2x-v4-2-bc15f68af7de@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908-sht2x-v4-2-bc15f68af7de@gmail.com>

On Mon, Sep 08, 2025 at 10:54:50AM -0500, Kurt Borja wrote:
> All sht2x chips share the same communication protocol so add support for
> them.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>

Applied.
Guenter

