Return-Path: <linux-kernel+bounces-761895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7037DB1FFB7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A898A189A39F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BFA2D8DD9;
	Mon, 11 Aug 2025 07:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fQQg6CUU"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F74C2D8DA9
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 06:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754895600; cv=none; b=u8CHHOE4/E/viv1jJIg9GId5hn0xLWqZ88dWTeUdnyX/cqavtI61dZv4uXB20AjVxrzikNhcEYQslJ8Z7bzu7sXnRTNAO/W5HFYzzuUO49KYvC7r0RjrUo3y1D1y36lQIYxMLobSiNSZaUXhEPkAtWKnDRHQ70Ovw84m8gc9kGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754895600; c=relaxed/simple;
	bh=6/Hc1lQyX/sBEffGDpxh2lWdftgec07LrQEgXgC9lnU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BJJ6Djx14spU25fia7SCzH6l/oqr9Vu6MyXwgNPjveoZ5SVsI7/hpXy/8DB4q5UhksFUQAhBkkb6KNE3KiqLsKzp4+lxnMdkVYB1j2pL4eKJMvj+4M5bAz+EvSuvbAPXTxdtsRWAaDvk+z4JOz4YVC69erl/T4gZIcjHBQnVaTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fQQg6CUU; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-615398dc162so6357874a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 23:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754895597; x=1755500397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C82Arh4xTYMeHCG/1/1Zlt/WYkQ5vluhkK9Oc1vfKQM=;
        b=fQQg6CUUAyrTEU7hbxQJ7YC7iz3lycxKNLO2wEJbsz4QUN7qX2rZm+Mf2lhKUbWA7/
         1xYHrW6MfDNOC+18GMvq3vokS99Wo8dv90Kx21+uaQvTx7yY0fy/CS9U9fBWQG8bcGrH
         VeeipZVFxz78HZ6dC3AG4HkdXWToErhujK3KlyB3c5em+2gbwsHj5PSUMMKPxGglftRb
         ADZXVZOwSLQRIO2yfSTjELdLfEWKxvTFbqc/MKIJJhfc6U2tHxVFna+6g2PZWrceMbQS
         TEWQYfai85/34//ZOahvby7c2vWTUSjupt46b8x6Vfgt5bT0wn+BBItMOmHF9l3Uammx
         sLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754895597; x=1755500397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C82Arh4xTYMeHCG/1/1Zlt/WYkQ5vluhkK9Oc1vfKQM=;
        b=p+ITjI2j2wMG/Z1SCgfmobbi+07Pai6zft9O+ptKyxhe17sZdGLNkGSY1uYXj3IGOO
         jFcXNh9PK6yK7laPpWHIQgrlJsIEUvOtEFDNBOhvOLpWXt4CoM4k0rHqgqtnoYYLBZgA
         hmlNc0pByI5J4xDjO3DG0brFFtEYdflGcvPIlJ0VYJzobCOeWNl/XoB6bvYmrSFaHdeU
         UY1e5JF//ZWGEuBmZMF1S7MgH8kymzjiseqpf8rttd36BQNxIO4ETg50nA4rhkxM4Adt
         tIYFjdGjvPmtFhENi2FG6XyQkgYl3erZZEQSVqGU/TcjdCYXQS6ySdfL6JHjBVioHVd0
         QZ9A==
X-Gm-Message-State: AOJu0YxKf9Az9sKG/tFopvgppD4QbkIXKkhvBTQYPGtH+kqNdHLVBAUo
	3vEqpP6zhItPku5daJ1/toawD66AllkLxbOk03rj7fFHZk9WdZfk+1tFCFe4+eJ+PhCa6rMoG49
	xREjwt2i5xw==
X-Gm-Gg: ASbGncvIkydVPWLZSXDA6z/AUM8m3RXrwKANHN8P6xeBm0qYFYoahQa06uzx6TFZ/SW
	/lpRUNKIRG3qk7sIJLrIrufo+yEdHYJ+0axsd0fBi2zoHwNMLIJvXrrFWzG1CeLZqwJwCq2gDd5
	aGAw+PiQPQbhbAUKR2O6QRp8NvcTLI5ZTUunVb1mP6Ip3qARO/aTFVsHlqVrL9e+1nhhGEiKEVA
	u6QywPD8QM6FilR2teyBlrhbot/T56Kg1OeAS1rHNYj+RdMiPE6DrH0rVSdPtaXh59llrgExkcx
	blIx+EnU/370GVkKQ6thJDtfvbekaI5sviFgLUgiVYNU/NLgUYNG/aK0OOQGjQ/epxuOSrfPvb4
	ZHLL0XD2296ATaBSS6UdQGaOn92fMcxtFyicCaSCXgQ==
X-Google-Smtp-Source: AGHT+IGqqRfA+YAuUWVO9oMWB79V9bGdz76SAHGkSbTas9+S9/PzMkjIQu0HGns+DPg11457PNpGTA==
X-Received: by 2002:a17:907:9490:b0:af9:34d0:836f with SMTP id a640c23a62f3a-af9c6484551mr1072512366b.27.1754895596477;
        Sun, 10 Aug 2025 23:59:56 -0700 (PDT)
Received: from eugen-station.. ([82.79.215.22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af99604e648sm971793266b.6.2025.08.10.23.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 23:59:55 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [PATCH 0/6] tools/thermal: Build fixes
Date: Mon, 11 Aug 2025 09:59:09 +0300
Message-ID: <20250811065915.3333142-1-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some assorted fixes for thermal tools Makefiles to aid in building/cross
building.

Eugen Hristev (6):
  tools/Makefile: Add dependency on thermal for thermal-engine
  tools/lib/thermal: Fix dependency to host libnl
  tools/thermal/lib: Fix header file installation
  tools/thermal/lib: Fix dependency to host libnl
  tools/thermal: Fix thermometer/thermal-engine thermal tools dependency
  tools/thermal/thermal-engine: Add cross compile support

 tools/Makefile                        | 10 ++++-
 tools/lib/thermal/Makefile            |  7 +++-
 tools/thermal/lib/Makefile            |  9 +++-
 tools/thermal/thermal-engine/Makefile | 60 ++++++++++++++++++++-------
 4 files changed, 66 insertions(+), 20 deletions(-)

-- 
2.43.0


