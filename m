Return-Path: <linux-kernel+bounces-783541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7290BB32ED0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 11:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 531F017E4C4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 09:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE393269811;
	Sun, 24 Aug 2025 09:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEfZVdCM"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1033264614;
	Sun, 24 Aug 2025 09:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756027662; cv=none; b=pH3NRk3cqF/WDB5CMALq13Gt7lBEgLWxEquo7o0fAauNVN07Li5MMXMiu3lPbdypzoqzYgX5krqN0xh+wtZ2oTJY2OFbNWADj57/iBn79dqyMNsHN/vl336kM79b7dg8QNgxYaeKzQIOwj3fPu4AUZ/VBsBVhjU9rR5oHzOQS2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756027662; c=relaxed/simple;
	bh=rZikCDv8fD+Rzkk4RfVp7aDtd/aBZpILIsTNbD23F+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oe9/AnZeoaca8uAwO8/lBfibhW5DZ27o0d8Nb6enE5oP/dc0j891BU0stIWYY5xkoZuo8S1+Dk/eJMV3K9tjF3zwyksAt93hqWwkJxorU9VWCDXW57vWBoNqGrVCPnoA5mBIc70H7Qj88LRb58YgyhOQrYktUYpxHInqNvQ6ACA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEfZVdCM; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6188b7550c0so4748437a12.2;
        Sun, 24 Aug 2025 02:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756027659; x=1756632459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q34w3RqR0dtKEGKyYXofcB2jlNCM2LrnhrF1NCKpgfo=;
        b=cEfZVdCM+xunRXklfkOjIKzT9I0ztbLqN5rANX14oOqjWyykS5N46urbSJ4Ob4i9cy
         LtKgTtUEab7ghNplKgPPQKRHh60tj0pjnqDF8hDu9RsCEmqy1pQ+cYgbkcyIwQjSzxS7
         pDWxcGdme8bvruhU68x8RlYPklnoKESj6fQEerkpjWlwf2bHFk6nkQNva28inLEEuZ6W
         e/OPdPf11IouZxJ53gHDBMQc88ND9DlPAUJcKbReFwiQ8OcvJ3KzZnhjNT9ynq8p4oq1
         r7HBNNXF/i1dNQpLwMMvvKT9AC0vj+Hrz96rsNA2iqdz99u5mCL2c2FIenYTevDbZb3a
         MA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756027659; x=1756632459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q34w3RqR0dtKEGKyYXofcB2jlNCM2LrnhrF1NCKpgfo=;
        b=oVKCCN1Bxjewkq6u822nKw4vQzXtOQOr2bxOeHjrcwzFw94icxRuhoHXvMCvnx8YYV
         fknfS1qbTP/bzme2HDeBWwLerzyio7KQRotwmZvgBRjQ6WeAaHzRjTlueG/67ek7debI
         01wgYElzhmXZsatJfEl9+ibw0bANCkIVSDG3BV7UOn9Kd6mvM0zN87xkyks1AAbKlGmW
         ojH+VxLTmpTYCPm+MyXj9534LYvNGOryNWBncWcdK3C9xOlUCm2wR6UHWBSbK/SNAP2X
         RFVCCj6dJZiasqJoutlZ1cOom0Xo9rPUDRCQIkQc9JZ9ZStVtYewUkphVWzFwKo1CRVC
         5gTA==
X-Forwarded-Encrypted: i=1; AJvYcCUD1awB1u+cl5UAfr6qvnO3QZnOcZNI2OXq1K3h9/Ul+luGDkGil/FIOWSo/LNqxpF2gu74NjPg+i5/LGFo@vger.kernel.org, AJvYcCVpqENc/9mthyydOhrirXTrQC/MaZ1NNARYUSmwu9fYoA0VjwUXx22JhNsTCk6r084wWpIfeWzC23yj@vger.kernel.org
X-Gm-Message-State: AOJu0YzzccjxDy9WWPlNi9H1/a7EzH5vUuR5pnqPzlEhPfcIBNYqYeje
	LoWLPDPwnwibSKmjkLQP1o2uFXgsujEPcSB5BXY0WzxJGK3OUDYmRpF8
X-Gm-Gg: ASbGncuiaZBS937JSf3ZPLpgJyud1zPxdJMofFL/HzKwf4jlD4LVcFNkfJC9xdN9EjT
	WgqcfFQrBQQhr0Oxoz3e2f7Thk+55FkfRct8+IP15OhgPC0EsFKdxB7XaDbPMPTUmXSmunY9B4X
	eO4gUQIjb7uYLo9LsD3wPOsoGnPGNY2g4b4rBlZ0js/Rd2l1Pyc2sQj22mwJrOpFYL8fsDnEGL4
	wNsNrRpqbJ3dxw2q3mRxP1WaDMk9Qcb9KXPdtPh54C24fQpZORhoxbPFpR68ifvNYku64jQLMIu
	yPZh+x7tNIiemJMwCCG6GuMrFDMbiSS2u6llNTei2OXI7GJ42s4JrzsrSOYHUFUWDU66guPFA1/
	W33+4mDXAAjiNYA==
X-Google-Smtp-Source: AGHT+IEtU39wyFdDkeRjcyNyLkECG54sATB6vqhBS2RcZn463KIIzRxKiLbn+3GO5grAttRSfyZoLw==
X-Received: by 2002:a05:6402:13d5:b0:617:b2aa:576a with SMTP id 4fb4d7f45d1cf-61c1b3b66ecmr7576651a12.3.1756027658807;
        Sun, 24 Aug 2025 02:27:38 -0700 (PDT)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61c316f503dsm3035391a12.31.2025.08.24.02.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 02:27:38 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Maxim Schwalm <maxim.schwalm@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3 RESEND] dt-bindings: display: extend the simple bridge with MStar TSUMU88ADT3-LF-1
Date: Sun, 24 Aug 2025 12:27:27 +0300
Message-ID: <20250824092728.105643-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250824092728.105643-1-clamor95@gmail.com>
References: <20250824092728.105643-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A simple bridge used in ASUS Transformer AiO P1801-T.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Robert Foss <rfoss@kernel.org>
---
 .../devicetree/bindings/display/bridge/simple-bridge.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml b/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
index 43cf4df9811a..441e5e5b27c8 100644
--- a/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
@@ -28,6 +28,7 @@ properties:
       - enum:
           - adi,adv7123
           - dumb-vga-dac
+          - mstar,tsumu88adt3-lf-1
           - ti,opa362
           - ti,ths8134
           - ti,ths8135
-- 
2.43.0


