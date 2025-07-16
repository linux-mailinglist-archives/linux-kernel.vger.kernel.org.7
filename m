Return-Path: <linux-kernel+bounces-733766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E33F2B078B0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F1783A954E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC0126E16E;
	Wed, 16 Jul 2025 14:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3MpcbeT"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1E22C08A8;
	Wed, 16 Jul 2025 14:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677663; cv=none; b=UXXTpTbogcF9KRgBg1h4zI6MgsbMh92OcoiGdF0+SELxMuTbV4iko+K7u3HaEHyOvV2abpNMNje4RIBjKFu/ojjVIyPpvhF8Ka2IIXdtq5QInqppvEeyQNRPuV6vF1aJ5Cs4GwJq1V08adt4AekYzDFPFJsKKWbz7qtNCV2UPiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677663; c=relaxed/simple;
	bh=S+Nm4Uc+52FzBoRsPk5LfZE8sXub1rwxVE0zWAf36rU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZR+GBBnOMI+bZnLB/XemRIW2tp8lkijU2TwbmleUr8IqQnmmj1nma2Ucl4nLv1zWscS0f8PxhRif+DKjzNi0i/lsImQRlWtqsTMtfqz2qlBpJqGbbCBy2gtOf/yOmbDtq41z8aiJBvLE1YtNTBr6jtW8SQ0+/jW4qkGyVq9aZuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3MpcbeT; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7426c44e014so6560606b3a.3;
        Wed, 16 Jul 2025 07:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752677661; x=1753282461; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E/Yq6CIoDwh1nQNc/4kHr70yI5AJ468csxfq351kIsQ=;
        b=N3MpcbeTr6jUTWzNRRCilJ3Qj8p8eYppD1euDhVTJui1K1Td/d4Z5/pWm7ECmYHLXz
         E6b8EVR0e850uvPZJ7EMNGqMHBxAKULVXqs5Q9Z+oFr+LpB4Hn2bE8+pEDdPSwFDJx3e
         SrFHbG8CeyReXF9GZTV84EiNxXULt2zHWHvnHe5ICGYdUQzurT5W8RwlUfwWiAzBif7o
         LkUkHNqaeZlRIdffCfged2Ot7WbEfr9/3aqU5zT+RPcwfkA6vraJbNT9lFCvUbj+DNPC
         Av7+21RTNK5Up/3kUI0KXGtu1f2i+YGp5FjrWGXH3bZwUgESFjGIdtR2WMFrAgh4O696
         a/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752677661; x=1753282461;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E/Yq6CIoDwh1nQNc/4kHr70yI5AJ468csxfq351kIsQ=;
        b=MwVi9ZFVeJ6n0Vr0pwAlh4K7RZE6NjV/hRVVJ6P8Jl7nKjvncni5/zsk5VjzI4Ad9f
         ipECUKXh5nASljxiIfSAezqxLq3mvAO6NZuZDUzFRpYhg7CFRvbmuuATpMRird9eDwiB
         aPSFSqCgvVboyoQBhhwnlzqSIJ0NQuZkDdG3UmCZgFHXGWbWTsZL53MlMYSkBQzPrHsT
         a4ihQS2OjSXSnD/X2AncqTBfDID1ma1XTWhwLSlcB82LoCmGkxHLnTr5xH59p6Rt8VNJ
         OqfSXL4uSmSWIiwIBSocCKZzOePOfTxHYzVPZWy7r4mVSClVWHpeSJWl7NWcYs7WY9ND
         rEWA==
X-Forwarded-Encrypted: i=1; AJvYcCU/BqknHkPbW0gIC8iDUMXqlsVvIv7hPKm+fZdFk9otzWGow7FQyBVT4ZEvfwI9tC6TtMRR7z3XWK3c@vger.kernel.org, AJvYcCWDVatt+9R0FNeyI1PDfrThhK2Ph2R56UmtlXfhEcOdjrAReXw5MUZlttnKukIV2aSb1Y+hzXTYOyQ2eocP@vger.kernel.org, AJvYcCWJw27KVRIAMZfvEGhrwLnrmYX/albi/9sJ80/A44A042UVSBd4g/M+XKUJBwI5yTdBoWx6XgsEZgv12Ug=@vger.kernel.org, AJvYcCWmNzMx+CQ5/EpQYA9IxJlPtXITvT7jo63iJcboK4J4K6VwsacS/sPU/Dwec6Kpf3qznMG6J5+nlYL4@vger.kernel.org
X-Gm-Message-State: AOJu0YxDeEj6rnZHDIX7cIo/SK3HjHurFE1fT8r+Y7e+VAMmEWqAg0sT
	B3r4aknoAoGKtLkXIL4LQqm343z3JfaTXp94yR2rJVpWJ/VI85ESnHmJ
X-Gm-Gg: ASbGncsBpOgugbDSipi/j9bvFNAMLPBc4L6N0gm1c7FkclRu0pPRyHQrtuQBr23c5fz
	PBFmzT5SuMG1iGSow9xmWpWon6lU/5G4z+GWnb7WnXqTcIDv078q3fikHfwtFrVDq5NU3/BeEoe
	4RoLsoLyKjaLuR8F3FVW+fOUKJZD9NhmXk0W4a+E/HCJBLeOPbxKO4/IEnkaet/CadQO3axhMMb
	tBWoMf7INYf8idKKT9UZP5EkhFJJKEPyhXoh9c35xJjQFaS+s2LyFUOmgcTaSSPMpTQce8O1Ofj
	V1BvNLqvpntkoA8zDOxWUF6pt8i9fCnbI8XqMHZzOMdS/5VPNnq7yUPOmBLzT6wm+1vVLN1lNA+
	QHY2aVqJLurz4NdnjkfG95ZJoKec0SFfug4WlJJdR03JjOQ==
X-Google-Smtp-Source: AGHT+IEGems0GBTgaygiJgVWSpwSKUA/bBsETeI7cEWe3246UyOq0sxM6wPyvbrUF9/Ddpz7pkAtwA==
X-Received: by 2002:a05:6a00:985:b0:74d:247f:faf1 with SMTP id d2e1a72fcca58-756e819fa32mr5075483b3a.6.1752677661371;
        Wed, 16 Jul 2025 07:54:21 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e069e3sm14814577b3a.53.2025.07.16.07.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:54:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 16 Jul 2025 07:54:19 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Cedric Encarnacion <cedricjustine.encarnacion@analog.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Radu Sabau <radu.sabau@analog.com>,
	Alexis Czezar Torreno <alexisczezar.torreno@analog.com>,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 2/3] hwmon: (pmbus/adp1050): Add support for adp1051,
 adp1055 and ltp8800
Message-ID: <9d98fa28-c8e7-44f3-a150-0ec4e4e970ca@roeck-us.net>
References: <20250709-adp1051-v5-0-539254692252@analog.com>
 <20250709-adp1051-v5-2-539254692252@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250709-adp1051-v5-2-539254692252@analog.com>

On Wed, Jul 09, 2025 at 01:43:26PM +0800, Cedric Encarnacion wrote:
> Introduce hardware monitoring support for the following devices:
> 
>     ADP1051: 6 PWM for I/O Voltage, I/O Current, Temperature
>     ADP1055: 6 PWM for I/O Voltage, I/O Current, Power, Temperature
>     LTP8800-1A/-2/-4A: 150A/135A/200A DC/DC µModule Regulator
> 
> The ADP1051 and ADP1055 are similar digital controllers for high
> efficiency DC-DC power conversion while the LTP8800 is a family of
> step-down μModule regulators that provides microprocessor core voltage
> from 54V power distribution architecture. All of the above components
> features telemetry monitoring of input/output voltage, input current,
> output power, and temperature over PMBus.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Co-developed-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
> Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
> Signed-off-by: Cedric Encarnacion <cedricjustine.encarnacion@analog.com>

Applied.

Thanks,
Guenter

