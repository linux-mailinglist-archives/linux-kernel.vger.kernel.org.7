Return-Path: <linux-kernel+bounces-812476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E186B538A1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A9213B349F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE1C350D6D;
	Thu, 11 Sep 2025 16:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOKFZT33"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D617934F497
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757606619; cv=none; b=HTagwg2cHWJgodHw/FFVmdlbJmiAWS0s1Hmmt2yY/PqKBh41q+gTHQdht+uyk13WrJc5/+s7AUm7EcBWrsCT7Gj1Mzg9UE8wiQThEoi/EpaelYrLXZWS6th+hJ8vjp4tCvFi2jKYJNyT19Krj2AMFubFwKBfm4O+yOBVnLjfZS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757606619; c=relaxed/simple;
	bh=Py8tEk0Ei0y/z+n+ilOScm0a5cfD6f4JKLzbyJg3JSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jumys7Gfd/ReEZgMhkq2RmAHSDFlf81gcCLC3fxHr0AHALjo6LHtaos22d13a+FLP6UTGVKHk6HqZnlvIm4LEEJH1hEmx2sb8pnCrfAt7ordxGnqXTkvB+L7JqxrVR8W1sZF5MCTMdtTQ4obdFaLig/fqZ543wZW5+CxijGuUIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOKFZT33; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45cb5492350so7104015e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757606616; x=1758211416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=juu37p0WD4XpFBvsQ98g7XcnhD1Q0GfDFr2izWwlv3E=;
        b=hOKFZT33G5qwUdS2bCdUveD7GF71FSAQlw1KjHOQCIvwLPgsjxR/RRFDS0thplWyHD
         puu6zfKlwzB3DJfXj0HBjhVOF+1uq36WYFDI1HB8es1CJ30FR+5OfSksFmtgqqtrFcbN
         Lrl1xViQ8qno31TnG8wsu/sQ1E0Bi2c6lCSO86rZRllp89kw5vmHUZvEHdsW2LyqB/vX
         xEFrSrDQ2jDgzF6yWHSGCFmR+mEhQSBoaQY136QULQsX+iRCKVDUJ6j5gZ++OhJzVTlS
         6oMG3mRYU5R86Cc0BqvMbu7pfcvDDuzO2WJzbSfNt7b+9kVlIGabXdgu9+WOOZweUj9V
         R1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757606616; x=1758211416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=juu37p0WD4XpFBvsQ98g7XcnhD1Q0GfDFr2izWwlv3E=;
        b=t95xZtzuc03ARGQMo/BpiCuF+GBp9N5uH6IcEEGnEinWb4uYKnIch+gEQm6h71KP6d
         rcv90B7xDGMgVhBtZp3cVrlyr72+Le+abWqNCn3dYa3cQn+9pJb4Ha6C6JeZ2HSZ+bR/
         WQfDGV6qOhgVTvzgwacBMFQQVWiNPGzm9Wj/4ZI9KlxPIo4VGLXZX+YFIjleSJbJA2yw
         0Tv4jQhiVJ7roD4p5Ji+Wro2FJD77YwC2s6z+tpc9wCLuHdYlVuMNYvKHWGubaJ4svoE
         TWc9UFox9A43V3ndU2j+i28ds66Tzk9N3isau6m2nzzUar9td/xaG18XzgEr1z+8j15d
         xM7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXrWFM5sOPyPxp32gZcLwHmj6OwPIITT+sKIrDLu85EpkVBagy3gV7ewN6dFLn2hSAR+AWoTismA7QV+3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN74YBOwUINL+jLOc0oE88l7t/Bf5wpRtFvQGM6N+YBIPGvyFt
	BJOAtGSaEKN96a94EI3GoqB2uIDWqnWAdeCrJWusdoQ3clzAA43iUir6
X-Gm-Gg: ASbGncuaCXdjqU6c2r1mtjgqtqrTeG4NqozTtv+Z5b9l74epC+/iVFOL+Ano1mRcmcZ
	Ydge+KXjbhvklIMyia4ORQ6lhYUufCX11LkcXCj9dBoOl3+oxvR1vvpZutcxcm+uFVOtRPXP6ZI
	T2tLqWt6QG9P/lIzFtqQ23hgSCj8ecSWtRO8o2Q8jYR5ltBIFrCmHswCloRWRe6fccxUDOysy40
	5j9c+XzRfNU5qeqK38KSEQual30WdluM9RKn12NoCZIpz/5AC/tE6Qslid26UJyqKUjfNP31AEi
	epbuHQW6Cc3HUPH4VxUjBH3Wx0su2auxThz/H9wA7kh+qEjxwzPBDXnog5hEpVZEAsFFTmxRZHy
	UM+nUOz7keO9G0IVfz0UgKJdb5DJ1Zr6xZOl4gzZSFiZPnwKYdSB60YhIF7KMTibURPiji8az+1
	abpeJjk00zIxfN/CeGRdVVoo0s
X-Google-Smtp-Source: AGHT+IEZsAWaysBc+OQ7PsOUMO9De4gX+5mEaMPhifkhw2MfJOEeCsTWH6E3dD6f9tamKPLvBQt5VA==
X-Received: by 2002:a05:600c:1387:b0:45b:9c93:d237 with SMTP id 5b1f17b1804b1-45dddeb93f1mr166508065e9.14.1757606616075;
        Thu, 11 Sep 2025 09:03:36 -0700 (PDT)
Received: from localhost (p200300e41f1c4d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:4d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45e01baa70dsm31874215e9.15.2025.09.11.09.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 09:03:34 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	=?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: Re: (subset) [PATCH v1 0/2] input: rmi4: fix RMI_2D clipping
Date: Thu, 11 Sep 2025 18:03:29 +0200
Message-ID: <175760648466.2794963.11623532624737227996.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250903161947.109328-1-clamor95@gmail.com>
References: <20250903161947.109328-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>


On Wed, 03 Sep 2025 19:19:44 +0300, Svyatoslav Ryhel wrote:
> The physical max_y value was overridden with a clip_y_max value. This
> caused problems when inverting/flipping the screen. Further it messed up
> calculation of resolution.
> 
> Jonas Schwöbel (2):
>   input: rmi4: fix RMI_2D clipping
>   ARM: tegra: p880: set correct touchscreen clipping
> 
> [...]

Applied, thanks!

[2/2] ARM: tegra: p880: set correct touchscreen clipping
      commit: 2fa1118387295b9fa6d70a48011b30184348abd0

Best regards,
-- 
Thierry Reding <treding@nvidia.com>

