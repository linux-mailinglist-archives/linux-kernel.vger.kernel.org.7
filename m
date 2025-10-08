Return-Path: <linux-kernel+bounces-844982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17539BC3328
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 05:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D82393C5B4A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 03:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDE329D294;
	Wed,  8 Oct 2025 03:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECwVSz9h"
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A11329ACF6
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 03:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759893483; cv=none; b=gL+jQwkdLO6loVjXp0rvXH5nL6u7P95Af89pdqT/fmJ8jTwWhawueLbz4/qUq+wldilp01ExKAjT1pDbVOPw43B9XtU0f4bCTcFfhuC5paiOZ93ZjFsLI95wvmL4iv6PuKrjrXir8otfzsCmEkd80/66WTzdrGs9NdgXk1UC7qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759893483; c=relaxed/simple;
	bh=fIWRrEbesPeIWiQ6eMVMhIFPJ5Vl3n8thvPxlDqtswg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TeNfVvNBmCcsM3QQJHAkS53tXOHso4ZndFjR4HupfJJykUYGjU9Orn5OZVd3bVIs2ItNVo0B0HuIiRkpqQWjgbpMCskVcOfN8ICOnXw1WMeHmACnkdNo54WX6OKWq6CQOz0cTaaAR/jwLLDBjQygKkTXpf1N0PhhfGkjtV+aDL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECwVSz9h; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-3306d3ab2e4so8110504a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 20:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759893481; x=1760498281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUBWpVB64KIAGGN3DNkFK9HbyeXvjuC9xFABF4qCWPQ=;
        b=ECwVSz9h7R1gjhTWodWJuE0a6WxTvdkHrRojgNN5p0BDI/ldTN8CoG7Yqxf9ICAps5
         2kdIIM3FENZVhk9Vy8YnSzGNvC6zrtm+wLsKaR/vHseBpSOmzKmFIJ9Tx2kZOFiLh9Sh
         I8ZG2mIf4VxireWcfo/hV/juJtAG9jUd4dcWk4fyxEJW4VsoLN2N0CO+AsePDNmv8KgA
         Ziwv2m74dH+17k0Ur2uBhvScAetxJ2ClShYoASbwemZzix3/igI1W7Bc3x/g3FpwtGvg
         sM0otcc29Ib7IMx50exLft9rSr4UAfC2fkcqzu2ZlAssU7uITEYL+LWXCV5KW3ANyb4G
         AVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759893481; x=1760498281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZUBWpVB64KIAGGN3DNkFK9HbyeXvjuC9xFABF4qCWPQ=;
        b=adGH3VVIixlnFmrzmKcUU5hp1gXTz3mNQp07TYJHHG8fIK5BeKvBmT4Gh/m+26ntk3
         UIp4SKaxwYxiMlrq8LYypcDszh/CUKf2lBUTYLZZUSrugC7Aazu0HjWKbttARtx20I3Q
         hrOPxbv0kjSlhGeyjJ1v9gLCQWpe2LQ/E8G0VRYqXo72tVxlA4lrPoy9Yb8hTl4pPB1/
         STfEW5VUTaGLXs/GvtUQj32amSRPC9PpwfTEYCj9sB4KwRad1BfYGBk6e+0N/IQoUGWz
         TF7OBFbf/M+7P8Z7E5jJG3oJfhc7an8psmrGrllbfjF1rIjpJd6z6rzSeXh1aqjbh6LH
         Q93g==
X-Forwarded-Encrypted: i=1; AJvYcCVQUpltygzHsThLJyirwPd5vEvGRXRShhWHJZKBUZNbWrcQZWKLsYy573VzH9IPuJjvh90X5+aBRgg+EIE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw48jdPe+phqTVMmazLy+KV2NknnfLLJpLgPdRHPI4h/wrvqKw3
	Et382mh4GpAS0tUNc7/O+QQPRrbtlq3HLZxQYBw11kp1hX1XvQZSgtZo
X-Gm-Gg: ASbGncvAleFW2MdEjWvSbvL96+8tiXnOT/RjMgFt9GN6x5wvaLQh3SK50X8iYRyJjgW
	jNah9mqvnIJ0mXslw1Nr7pouaxYjNFgduieNu9JJLFua79Pg/jDuXw7PFIzLrKczWDdhp4/3vve
	yWqc99vzzmydehhovVqMfsSZwdKAywbIMPV/x1tTPZIrD00ugnuRdMVSIVIcslBPEVSUkXgJXza
	/Zzef2kIO4apk43Ya10AKfIjQmuESjaDp37iT8tPsMAXsZabTzvDaBS1CLL0Z+SNi4Ayr3DZ2q9
	RoCLgk1OGU2MPKCj9V/Ds4/NNHvWQZO39BEzY5mn8X18aLkpmj7IBYVNv2VR1dSCjxO9fILdkaZ
	Gv8LWrpsGTSEk/1ty27pUeMgvsFOmuIk9nzPz8RVrz+nRx481MQ==
X-Google-Smtp-Source: AGHT+IFbdt9o4+B6JZ8AWtV8URWuFR7skbc+7Fl9EFjuHuykYyJ4lLgk47E5Wl6/dwG7ikfSKtGBqA==
X-Received: by 2002:a17:90b:1c81:b0:330:7a11:f111 with SMTP id 98e67ed59e1d1-33b513be2c9mr2208816a91.35.1759893480753;
        Tue, 07 Oct 2025 20:18:00 -0700 (PDT)
Received: from Ubuntu24.. ([103.187.64.31])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099f5990csm16527746a12.38.2025.10.07.20.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 20:18:00 -0700 (PDT)
From: Shrikant Raskar <raskar.shree97@gmail.com>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	matt@ranostay.sg,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Shrikant Raskar <raskar.shree97@gmail.com>
Subject: [PATCH v2 0/2] iio: health: max30100: Add DT pulse-width support
Date: Wed,  8 Oct 2025 08:47:35 +0530
Message-ID: <20251008031737.7321-1-raskar.shree97@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for configuring the LED pulse width of the
MAX30100 sensor via a device tree property.

v2 changes:
dt-bindings: iio: max30100: Add pulse-width property:
  Add unit suffix (-microseconds)
  Drop redundant description
iio: health: max30100: Add pulse-width configuration via DT:
  Improve default handling
  Used FIELD_PREP() for pulse width
  Use dev_err_probe() for error reporting
  Fix signedness issue

Tested on: Raspberry Pi 3B + MAX30100 breakout

Shrikant Raskar (2):
  dt-bindings: iio: max30100: Add pulse-width property
  iio: health: max30100: Add pulse-width configuration via DT

 .../bindings/iio/health/maxim,max30100.yaml   |  6 ++++
 drivers/iio/health/max30100.c                 | 35 +++++++++++++++++--
 2 files changed, 39 insertions(+), 2 deletions(-)

-- 
2.43.0


