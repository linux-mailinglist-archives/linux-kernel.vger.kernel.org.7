Return-Path: <linux-kernel+bounces-815539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC375B567E4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 13:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82A181731F5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 11:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504B2251791;
	Sun, 14 Sep 2025 11:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSMsimik"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6221FECD4
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 11:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757849389; cv=none; b=AH8QJqPzdhamRZJCvb/TTZNf6aPme5z+uUM9Q+vSakrZVOnw/AUomBxv1BAxNXfhTp/xQXbnex1ENFMtdxh8V3ssZR6+wKyDj15uIMjcmM6AkBnQZm54KLUPK/hs+qWYYJnd0f2Iy1LAL2qZzc88C3TEN8bZlZR2R43ix0lijlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757849389; c=relaxed/simple;
	bh=xuFUrF1BkPaf8V6YIQBV/bE6ge9X1wiG25AtdgcH77w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P3N2uzXxYjF6+wrb9HSH61jhUFntbhN+5p67emdVuqQoxbUljr+gp1kf1T0beuVbZGmRx1/30nFjO+MVEWPv6m7lyIOvF3hGzBVrr+Cfe9WkPJ/ghW1zVo2CwrNd47i/WNZXLXL4BBs960cwfYQg1Zv7ZBwseezva/Qi459lEV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSMsimik; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3c46686d1e6so2298086f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 04:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757849386; x=1758454186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xJlWH2NF0uAVXDd2hOjwwBf+YceXcdwvPtJB2tgstmQ=;
        b=MSMsimik3nAQbfJi3WCobT1zr7ptWR9ato7h0yPAy5yQQZuXiwAje9HtkIMbyVrebF
         LtSzDIOQFpB+LrIrxtQI3K9PsRKw9KfJJxI6jAspQjiDIOlCIGWAJXVo1nbgEFyMe1y6
         Ww4CUOJKJa/oCyixGsWfb9wr75yftsgtDr0oBzESdJeIDl5i4DhSGBVw2EPkp9+vcxR1
         hvyWfPdDrQb+pU5ppwaYSLJDQ9rn0fTajq82MpqSuL1qqG3KKKCUoBuYOQs103FhWadu
         y8w0JWMrB8Z/ao1mvMfmINZH4yF+OARw9TowkUX5njWkAVJlovTiD3T+CmSvYbwOLuj4
         y5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757849386; x=1758454186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xJlWH2NF0uAVXDd2hOjwwBf+YceXcdwvPtJB2tgstmQ=;
        b=SUaBznZs8M9nbBjGsOI6u65SVeZCkI2Yh1r5iIkdwBaPIv210KMoiNWNb0ay8Ugmhq
         Vyhday6vB0c1+OZS8Xn4JP3HfYMml2X0fCp6N3bLN/nsqWKut3e/q7+YlHnx04owcfLk
         G0P/BSqB7IBlzH+JZlSfpwk9rOkwjvzEZCD66KzeJX+3g3dhJObHDh7XzVH68hKumLJ+
         PXJ+cyijlOhtjpddh9wyAijYvF7hnreaR+sfpzfcMlaTHP5EIJ2FcT4wnHT0Db+0GqrO
         iWp+4mMt5MtkBxV8QyrxpMZJ/TFPUmhV++2vkhH2yMceIC0t/JMqE5QcXXf09agtqIzf
         8DcQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0AEXVnGKHPBBiwo5XaKlhzuNyZHc1LAgpGpt+6KFSQh4CvHDt1BLoVR9O39qGyBVndx5EGA6G1bbBE4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjLaISQrkZm4dVvD4zy332l0o3ZgnVN/K/22evbYBGdzLYcnTu
	U7r66rHxgx06ETEjZcnV1v9gNJwaYpdA1VcC8C4yOOij5w4tPjbVi1CL
X-Gm-Gg: ASbGncsftTZEoZ1hc69LdbMfYcSVK02vYiTQ6xJE8ixuJ1tmmzkCuFhpAblvIfNCtCe
	xA+AjFJHg3IXDDSNLAiKYFrsGomUojJtPl505z7ukeMEO65AOeI7wlznMGCRnNQsKIWEKz9tT4C
	GueSW2ZquMn/rMD6Ey0Gi20ei7VPsrD+rQBAm5RSpFg4aluaG74Sg6ev/dhbED4enYtDssl/LkL
	3EyVttJhXUK0qu5DcBt46AzDDkW8VWcpneGVbXrqcEEBPPhSk7j/K7ABjUg6xRy44O+LoPs1Tjb
	GZvPkOUxToWCahyCZgRBFjlOB4Ace74M6ikScg9unIW2e82XtXFxHL49yxYkSGdhEbXOuiSdy6L
	O8q0x9eT8kmTNObqYKr2cIpKy9W7YegA5i34ysKx5KKdPEVd0o0M5/SpOGluYJpRx8WKJmnIbzg
	==
X-Google-Smtp-Source: AGHT+IHKyE6+dfEzUKtwMYtSktS2t1k/dj5Sb6gy+vyqw/6+wKWpZmtEJ/3gYkOAFEAedDqhzO7M7g==
X-Received: by 2002:a05:6000:2210:b0:3c7:308e:4dff with SMTP id ffacd0b85a97d-3e765a3e492mr6682868f8f.57.1757849386158;
        Sun, 14 Sep 2025 04:29:46 -0700 (PDT)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e8346defd3sm6591268f8f.1.2025.09.14.04.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 04:29:45 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] soc: samsung: add chipid and pmu support for exynos8890
Date: Sun, 14 Sep 2025 14:29:39 +0300
Message-ID: <20250914112942.2604194-1-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey folks,

This patchset documents the pmu and chipid and adds support for chipid on
exynos8890.

Best regards,
Ivaylo

Ivaylo Ivanov (3):
  dt-bindings: soc: samsung: exynos-pmu: add exynos8890 compatible
  dt-bindings: hwinfo: samsung,exynos-chipid: add exynos8890-chipid
    compatible
  soc: samsung: exynos-chipid: add exynos8890 SoC support

 .../devicetree/bindings/hwinfo/samsung,exynos-chipid.yaml        | 1 +
 Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml    | 1 +
 drivers/soc/samsung/exynos-chipid.c                              | 1 +
 3 files changed, 3 insertions(+)

-- 
2.43.0


