Return-Path: <linux-kernel+bounces-788958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62775B38E8C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 00:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78A131892442
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 22:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B922030F92F;
	Wed, 27 Aug 2025 22:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkioK8Uv"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43704438B;
	Wed, 27 Aug 2025 22:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756334437; cv=none; b=BFNHjK2hFCmraE2PT4WRyWId9lcWzxmiRBA+ek8zwEMrYW/CrWFnqH0U3NAdohfkPX7gjGz+3fnlfN53/ygPVQGoHmOEXMtAE7sfTrGRSu85J2pEVCE0DBM5BVKkY3UPHDvSZOEzTyQNofBMYMEtyBchc11lwppQWnQcphI805Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756334437; c=relaxed/simple;
	bh=ZURRfcRYgFsQtv89kZESAEWYeb8gpIk6x9g9l4FgzQI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lR0BuDhDtAGk+S+0AkUZEVDOSumwu1sa/nvt2S7fI1J9TlvW1SWgWVknxDFqBOgz/6/XmJtTbRZ2wcwdVnbJOCgdvL6nTcKlrPnhPtHAz21A2T+h0/O4F6lYz2phJpU8qmyI5YTr4MSpyNX/td4APK1Vzaa991cWKyzXMVCi/ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JkioK8Uv; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71ff2b20039so2745497b3.3;
        Wed, 27 Aug 2025 15:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756334435; x=1756939235; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QXrd8df4wtNv11hw/FqJByLBF9OE616o+lduhmz5nt0=;
        b=JkioK8Uvwf3Q3P4z74pAPFrQ1aVgAZJQF8j4aq2UapXAkNH4JmSZZA1HJHnCl/0iyr
         wD5mZ/AuQqZwI3vAeXVyEbynUW23yc0cSxeBWbGBMPA4w437wTHA+V6gJFer2zKJzQwJ
         ZXnHfD5u1oCxSSjbT6AiAuhb1WF0XMNI1zydYDz7mGx/BsQXwnc9WwZbkp4XtA7CaCCQ
         yH42T7xowaT3upFwxneAsBGy0Wt7GnH3Z1fAnK4KA/0acYsxjbRFDHURrVPPf1fwZgO3
         KXWo3UckNbogYwL4uwx2dW/YVxfr7QR/HDpDvFT86usCupNmC1icUncjd9nW7SNrvEQ7
         Wcdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756334435; x=1756939235;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QXrd8df4wtNv11hw/FqJByLBF9OE616o+lduhmz5nt0=;
        b=wvvoAgeGyRKEN7ggsZHUAdolEEpAL1xM6tF2jX1IJDqvuOpZnsOsXBpywUc8N58YTR
         7yLcOBuiJwe2TRl9Ur2aKsRPyryopP4s+ovHxqToJ1YSvCTlRyFYhB0SWR39empVz4dj
         ajKg7e9rLWbu1RaWjHGJzoSRsi+k/ej2pJUZmRncqsw2CkZsRuVhZuxlBVqDMJI2YjSc
         HguzZewV+O0OKYAAoBpBgYob33D1Doi7rvTBsvNnEOivBLrerQ5R3YqCoLGtdesmzm6d
         qdzZa/P2lQ01d8Xvvq/Jv/OM8Kz9EdPNSZFolxGkIZqgSNNmLZaR9Wu3m+1c4stUHnqU
         7JNQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2DiY9ESZ7ClAFXdkygLPU7j5r7Pm1JTd2dYb+6q4zRBLwtR6ew10Zsa0qlXE8b8nToGQ4KEo76n5naf9Y@vger.kernel.org, AJvYcCWsqdLayzej7eAqfII4ZeV95i+kLwfkUQNSfosOcb3Ez3oeSL6vR/WEuFZxKzYw5e3ycmpGZwRqQ1Sc@vger.kernel.org, AJvYcCXA1QXTRchxqipUawCBtqH45z1/mINwLLWZPAAcgfgrOhiTIrvJEJuOBMFrCXnPc51B7v5X/Y2w0D8NeO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTtyakHiKiHVzZssDRfjD0diKmJY5e2xU2nlkcY9z8b5Z3PNCz
	KvZIl/tOBNj/VaY9M2I2KxN6viGLS1FVS8jzcP0sV9/2LgJX58RaJL5t
X-Gm-Gg: ASbGncvg9zQMi6kHS0pBVSes14GpK2r2GPcqPXN9I8xPOKQZoisMgeHj5UgUCXBcHVE
	u9xfWL6CQO9I1eQZcoLbTPg7zI17IRVnXtUDXUwa8W1J8+K+s+SEdAzWv6CTtNNPylvQfDC4YlE
	fCfZSVhLpln1kmRZWg097ziVSwbFvBNLXxRjZib993ctxGkxeG/RbrV+gdVA3A/uoDcuqTa3JhP
	NKvBGl+oE8j6HzrksWIYN5dk27Evxi0cjF0IXYyyDDLAwM7vSS0WYMCdMC9e17Fv8oZanyGjKqQ
	HRmbM0LVT0xn7SG/r8lqDgKtYkC6t5qTcNxXT9bAniOx3GYp6U6Tl0ZRp+JinB9tBHl8yV5BN8r
	rXn3wT/A=
X-Google-Smtp-Source: AGHT+IHRztpk0yVGrsngNCAgBOHNf3fObYToyFfHmQGgO4/sQoO23177TbXsgJRAiCNm4ktg0g8Dcg==
X-Received: by 2002:a05:690c:fcc:b0:720:b6a:ff2d with SMTP id 00721157ae682-7200b6b83cfmr153596487b3.14.1756334434520;
        Wed, 27 Aug 2025 15:40:34 -0700 (PDT)
Received: from raspberrypi ([2600:1700:90:4c80::d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff1703e64sm34287997b3.14.2025.08.27.15.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 15:40:34 -0700 (PDT)
Date: Wed, 27 Aug 2025 17:40:32 -0500
From: Grant Peltier <grantpeltier93@gmail.com>
To: linux@roeck-us.net
Cc: grant.peltier.jg@renesas.com, robh@kernel.org, conor+dt@kernel.org,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Add support for RAA228244 and RAA228246
Message-ID: <cover.1756331945.git.grantpeltier93@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The RAA228244 and RAA228246 are both recently released dual-output
digital multiphase PWM controllers. Datasheets for both devices are not
publicly available but can be supplied by Renesas upon request and NDA.

Grant Peltier (3):
  hwmon: (pmbus/isl68137) add support for Renesas RAA228244 and
    RAA228246
  docs: hwmon: add RAA228244 and RAA228246 info to isl68137
    documentation
  dt-bindings: hwmon: (pmbus/isl68137) add RAA228244 and RAA228246
    support

 .../bindings/hwmon/pmbus/isil,isl68137.yaml   |  2 ++
 Documentation/hwmon/isl68137.rst              | 20 +++++++++++++++++++
 drivers/hwmon/pmbus/isl68137.c                |  6 ++++++
 3 files changed, 28 insertions(+)

-- 
2.39.5


