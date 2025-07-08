Return-Path: <linux-kernel+bounces-721693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F956AFCCC3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24B511BC75AC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06592DECBF;
	Tue,  8 Jul 2025 13:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/BQcXjt"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB512DECA5;
	Tue,  8 Jul 2025 13:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751982883; cv=none; b=fVUmcpUHwQF3dSfxMVVkujA8RgxRcQbAbRkN3fz7zMFHjty7UXXHlUOIbzQy2NRYzeccMVr3vbaqbwepsh2uXM3dSnAxYVo+3uqRff1g1EBbKDEy4zhNFOB/2nvzjjD1DAcbtsUrMBbmDYPB8uP3w1g1g1yBwJcBIlH+e4JZjAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751982883; c=relaxed/simple;
	bh=+TcuFQ5JXfXnFqeAMBmM7+3WUpidAPgIKaNnz9SsEQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lGONJamCQYp+S3aKQI7DTlfa4bpQQAEQG7eY1BY1OIOvmLEL9QEpVkRmb2vCn6WSeZ6RQZB4OY4KLPkLx/acxVMUbEtJHNBq0ycpbH6MDf4/iKnABEk0S2KDPFk/i97/CesLn7uMQsSMO/3YDnwdHtLINAwPASlfEgaVicaLDHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/BQcXjt; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae04d3d63e6so734146966b.2;
        Tue, 08 Jul 2025 06:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751982880; x=1752587680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QuSzMUX3wHghxJbKlKNyZysFBPZJv5OM61rjXeShdRQ=;
        b=K/BQcXjtDIisNrI0gRMD42TcGjFl0Vl7jAsqAYPaqx5zIPPF0wktfK77XPqyHMrXA4
         RaXAujn0DbgTsZQ+m7U2X8G9Nn5firv0mdHZP74GSR7kdU35CTNLYYMFGccCpaMzq/5X
         idu1kem7HXwFrm1SkI8s24JgW3ffA9K+LInSyvzclm+44uJSm54kBcxosNkBhrf/gfzr
         1FVyZT3gPx47iksJwnoSORjT5HhfjMCP6IdAroQOHr+Fp7KLNWBOqaDRy1gYaki+uRc6
         AqIqgXMx5raHVWfH49PJV0/wPTWuu+oSraCVvWKF+oOeY3HjK/r2mtSBvwl2omcR/xZF
         eWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751982880; x=1752587680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QuSzMUX3wHghxJbKlKNyZysFBPZJv5OM61rjXeShdRQ=;
        b=cIkcrA1jz5KO8xqazI41thCYekj7ogG/NCFBQUEBTTksjIycgzgUWd/n66u0OzWzrL
         9QJ3Xo+ZDPsh2eFu0XrEgNlimtIqwZCjH07+4GZWK74s+zN7Y7dc4bs17aJQ0raHl96m
         Kj4bjbjH/K/1KUpC7NNQ5zvSBhCPBNCWTD7/gVrgC5Hj7iBWN0XbxF7GmTIjSKR28Jki
         fLyNvNSLm0OcyGx+Hw2gUNJXxfggxEpXQhjOj+861c2qYSvQ9oM29Y6+27I24ISkzy60
         IMQ+2t2CpKJtWaArN4IYLwcsuguZrPIn4O2FUYr1opBviMs/RGp36CeCKhvZszFJsXIi
         6JJw==
X-Forwarded-Encrypted: i=1; AJvYcCUmv153K55R0KctzBx8rKUAllD/11rrP5YLzQciTBV7IeV65trMT6QPYFv9RQsqEal6l3RShYVzZ3jUOuTr@vger.kernel.org, AJvYcCWP3WDELeP42hnM5SEfLm+pNQkE7no3OPObkUl3PkjqM6dZcbx794ByoJwWssPyT+7Nj6FrZWgjpmz0@vger.kernel.org
X-Gm-Message-State: AOJu0YyrX5TQQdczIAFmW1ZGV82l+iy+hKLr7tftwNf+whek3zvEWRRp
	gRSC4EM9BFzKqKV41qFP/RKiO5u93pDAMxfU+f/M/x/Tzw6vxUcT9BJS
X-Gm-Gg: ASbGncteGZ6NOPPyxoCu6Jh9NygqLH38jmwEyRiiBsgU8tmhnzCOkR7wQtJMvI6+kpk
	M4MaFhlvUf8aFEiHD2vKQkk7cKsyuYhDwEzVVhWHxGtIdmc7vngmpiebRjxPZj4+qEhJ30myK7B
	Qo3cLx3dfRdJReBGwninbjQ5VE51nSboq455L1trEun9ee7lRP/xojpRa3BtHSkPFzbyBGGM3WL
	atCizOhDIvPwVasYB6YAK2tZOB3XbnVZKSlSFv02Z1i+7DM+AYr63kS6KkYrpWiUKP/pkMP4l3J
	VaP4gsYFbvp75UGc4Y1y8Ol0gkWKxMxCB3JUcL82z2YF4HyAEoUY+OTY8Pfnl3UpZCJ6cY4lmW9
	hlbw3xo7X1qAIbqwHS97dCxzjUMnSkvioCCS6KhpG0sFFmrXE+riT7Rw7sR9si3D7
X-Google-Smtp-Source: AGHT+IEg8FYXr6keG6fLz0S3lPAROXenPPWH4ugJsZlSnOifah2zO//skjGha+hpIpCH4Ky47GCywA==
X-Received: by 2002:a17:907:2dab:b0:ae3:62cb:7654 with SMTP id a640c23a62f3a-ae3fbc54c72mr2019958866b.17.1751982879591;
        Tue, 08 Jul 2025 06:54:39 -0700 (PDT)
Received: from toolbox.int.toradex.com (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6ac6641sm910431066b.99.2025.07.08.06.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 06:54:39 -0700 (PDT)
From: max.oss.09@gmail.com
To: Max Krummenacher <max.krummenacher@toradex.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Fabio Estevam <festevam@gmail.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Vitor Soares <vitor.soares@toradex.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] arm64: dts: freescale: imx8mp-toradex-smarc: remove gpio-hog on lvds_dsi_sel
Date: Tue,  8 Jul 2025 15:51:40 +0200
Message-ID: <20250708135300.2855155-1-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Max Krummenacher <max.krummenacher@toradex.com>

The LVDS_DSI_SEL does not leave the SoM, so do its pinmuxing on the SoM dtsi and don't
leave that to a carrier board dts file.

Using a pull down on the LVDS_DSI_SEL signal is enough to have the signal not floating
and have the SoM in a defined state.
Thus remove the gpio-hog used on the line and leave this to carrier board dts files or
overlays to use the signal as needed.


Max Krummenacher (2):
  arm64: dts: freescale: imx8mp-toradex-smarc: fix lvds dsi mux gpio
  arm64: dts: freescale: imx8mp-toradex-smarc: remove gpio hog

 .../boot/dts/freescale/imx8mp-toradex-smarc-dev.dts    |  5 -----
 .../arm64/boot/dts/freescale/imx8mp-toradex-smarc.dtsi | 10 ++--------
 2 files changed, 2 insertions(+), 13 deletions(-)

-- 
2.42.0


