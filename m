Return-Path: <linux-kernel+bounces-763664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DCDB21863
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 00:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8232680383
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 22:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0543B1F948;
	Mon, 11 Aug 2025 22:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GdN07UCK"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B810C1862
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 22:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754951458; cv=none; b=azig53+5io5pLB8fd17okEK9qMCmTB4sJUznTAQvCbQpfoI04/L6BKBrR5Qp3tTAWAhAAmUXJPzrgXT+JNwyBfPlRlOLBztav45knv1TrixV/PkHq5vb01QtFi6ZeyBYGRelBW3ftWcNG5+Q8c4eLwBP3rxIj3xRVnPEm3bEx9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754951458; c=relaxed/simple;
	bh=GPqLNQYmGgldngVoz0uzCbZ4RuS5lu8mmuunEVAfXdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VJVToZIBLl+CdOimsNzXGuF7q1ooL8v//sfITR+H73JRtWhT2UZhJh9X/QPotXIbX2lZf3etwtkNP+D5G2CjIxL/pIrll3mHTG1kwhxDA/9hEpBNa0TQcuDTNdJrXbJ9u4Ms0pKZBQ4SClwvCc/+puiKtCSQvFurTilNTqaqNhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GdN07UCK; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-458b2d9dba5so31028565e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 15:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754951455; x=1755556255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HIChLFJXUTptU2roabulec0iIj7wIJeqA5HDjOWIy78=;
        b=GdN07UCKs+jXXdTnItRn6dtNuCLj03sezobXMVqUbrzlaeL66jPSQOBJIoLB/5WhKI
         vFTgekBPfqyXNd/2ANl1PtpbR3ys6RutwWV0/vezXm/Ss5ZCJ1AD/7vm/7tBsgeYPBde
         lagkV578Qe5M4NEYpfL4+qr0pfVv/ydpQbgcueY0j6UJfp31R7VNwoy17LJ+zhnVHOVq
         XlJtd65ExVMKcwB0juhF3CoGli/bd7XVZFn3ISkPr1EmnmNris59ZKFbB2BtLa1NqGmy
         fdOU5/9dMkEyfasrCKkOAqwey68xTrqoMAfXL0IJX3RbdEGjdCG5u7MgambqONXFndZ5
         p9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754951455; x=1755556255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HIChLFJXUTptU2roabulec0iIj7wIJeqA5HDjOWIy78=;
        b=Jmen+bUO/p1JS1xhwfaBhCNcoVDCcCoVb03a7aqAMTs+6TLaXFRZUtjrUjqEXZ5yGz
         ktHat3WuluFV8kqYamdZ4tsOe2JIeq89x6AgNapJhtTCaLE6mEK6ilHSCCpSTNvLWosR
         /gZFi+FCreYNFg6cQI5bCBpPrHb8y5eWmEfbyQfN5gg5decmJqCzOYXY9CGz+DJIj4G9
         9CZtxzeWrO0op6iGQxLgmCd5H9fi0zZH4KsXEvOCeHYD8x9pJ9DJrljdSVYaZBB1mzkV
         74MdBCrcMeCCVGb2maTSYO/teYbp0YROgMkZxCZIaIjfPKjSbvQJySgGODloCJHz5vP+
         leKA==
X-Forwarded-Encrypted: i=1; AJvYcCVluSXaAxOjUYuyu80bT6Iqo9l2Oqca8xZ27s/Ji+V6SVTJH80Eztr5el5SvFEW6UxHjdue+nJ4NCKAwC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTU5nE+Z9vNFGAof+zkJ0rYAGlRHEOXI6Gj9HpuYoyefCeHTEp
	A3DuJxOfe8XkHp1onmnyBpheoeyH2snLYVFXEUD0+i5JIPfHfMBKGV5RJS4XNsdP2HU=
X-Gm-Gg: ASbGncvoZhsahoyhTek/c26kzmKPWxQOz0MM1IiaEt6mxWgHTksdCijJfujRPq5D9t7
	qpcHRLRQL49GGGsRdmfhhadozSCZAb6uqwuWic2W7D+4o1Hzb9ug712+PMJoI1jWhEf8qWQIclu
	9wXY/5yCUwtYTnJqgdhNdesP4UoSM2/yauut1WUqQi4cRxEr0w3e0sxGcCxJriDZIYBclgCmArQ
	igS71Bs4QqCqiveCdy5uM25x1kR1q7fQV7Q0XwpLGDV66Io7kcA4M1ZZcPN7Fz2cNOmousX/LZe
	vVvQNCYomqG4dE0trFQxiwZuFmEmYHjq50bdmNr9UdUcW8HRaqUlPRzBJeGbHhDUuzA/1j84q1q
	Mj2mc76san+5o7V/wJofG7vBcJ0yEMINhz/Ql5sceDZt2gXjy
X-Google-Smtp-Source: AGHT+IE9a3RQjvUbfMWCMwyystXXfoGplC7a7Aahfwg+Kt8MTYEed70a5T7Hc5VGmEGnzR1qkVdu5g==
X-Received: by 2002:a05:600c:4f8f:b0:450:d4a6:799e with SMTP id 5b1f17b1804b1-45a10c005edmr8980105e9.20.1754951455077;
        Mon, 11 Aug 2025 15:30:55 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5853104sm271557715e9.8.2025.08.11.15.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 15:30:54 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com
Cc: linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ghennadi.Procopciuc@nxp.com,
	s32@nxp.com
Subject: [PATCH v2 0/2] Add the s32g2 and s32g3 FTM PWM support
Date: Tue, 12 Aug 2025 00:30:38 +0200
Message-ID: <20250811223044.3087090-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NXP Automotive platform s32g2 and s32g3 have on their board a
FlexTimer (FTM) dedicated for the PWM. The same IP is found on the
Freescale Vybrid Family and the i.MX8 SoCs. However, there is a small
difference with some registers not available on the s32g2/3 and 6
channels instead of 8.

These two patches provide the DT bindings for the s32g2/3 compatible
strings and the code to deal with the FTM difference.

Changelog:
	v2:
	 - Merged the two booleans for the regmap holes check
	 - Clarified why this is needed in the changelog
	v1:
	 - Initial post

Daniel Lezcano (1):
  dt: bindings: fsl,vf610-ftm-pwm: Add compatible for s32g2 and s32g3

Ghennadi Procopciuc (1):
  pwm: Add the S32G support in the Freescale FTM driver

 .../bindings/pwm/fsl,vf610-ftm-pwm.yaml       | 11 ++++--
 drivers/pwm/pwm-fsl-ftm.c                     | 35 +++++++++++++++++--
 2 files changed, 41 insertions(+), 5 deletions(-)

-- 
2.43.0


