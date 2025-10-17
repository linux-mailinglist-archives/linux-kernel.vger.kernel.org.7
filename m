Return-Path: <linux-kernel+bounces-858471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C08BEAD2B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2AEFF35EF08
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2998B2C2345;
	Fri, 17 Oct 2025 16:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MGg/QERm"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D02929B777
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 16:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760719384; cv=none; b=CqEpdF9oOeiY1ORX6pST2Gt8byMAtJhx54bBLzvylMzgtZ1NxWXuvfi0wvGcLWTo37/z7OwlevTKl5UVclO2B6O4qhbYUVtDtMau3f7QlcipLaIDqTpPzOC3K7F4uElzLIYjb+2oIjI397OIkS7R4nQ8NBAXwC6KEFHXSwcAz58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760719384; c=relaxed/simple;
	bh=qydNSCeSQ+E2GOjHdtY78InKMYtkzGBtuz7sO0dEZ9I=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jmd7b868WGSkUIsmcF7rI2cfqWfKpDb1h8XSXzUsKNWbxLAkGMTXyUiMtKK15YMc/cF2cFrv6iPuUqwWc6Iw6CYVd+CHd3dIx1CWf36QN7n/Gli2o87aeq0jBaOrdXzf4lOVz4csWS6SVsuemmtW3cEzVIqzT/jwBT3GfWuLdQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MGg/QERm; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b64cdbb949cso223233566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760719380; x=1761324180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kjdz0rl5dcQU1vd/+CLrzz2F5z3RZpHi5RbDUNAW3S8=;
        b=MGg/QERmv2PF2p0psuS2vdcJ6iF3FPKJiXN7Eg7dvw/K88Nih1dkak4mtftN0v+5d/
         qOZEythEsIJh2bSkrL3Ax+4/dme3qarUlAmeK6HyAPdFuebtdA84wtqsoqGHKTo80UDq
         Vk+ydTUMwb9pjjPiMPXzdliZ+Ag8F+iW2afgYGO9BKTfLKEugFvkCKqwV78fzdrM5PGm
         CxZRCv2Ojw1iZ56LHEoiqkSb31LUc7FZ0ibOq3vHN8Sh+9Lp2Cl47D7Jqa5XneR7xqgF
         BhRJPPA3xPQOtrvfUqMcF3x4TzVPw7xruTduTPJ+RN1g0sicBxgOSpavg9Epzk6uQ/LF
         co7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760719380; x=1761324180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kjdz0rl5dcQU1vd/+CLrzz2F5z3RZpHi5RbDUNAW3S8=;
        b=KO+LrL+xzkeuygfnnHTWl6ONO5ZMxhLSTsLQj6x1Kyv5QVzPdkbkVRbG2VeHPSaT0K
         BbT8ffi3vRed49ZhrETcM8rd2k+hnO13/hJkmrVYbmVlz+0uhywllBALncNaaGvulLt/
         jYjr+uN8o4S7tITgG/fUrVSP71wo7ku3EYjSy/CZ6d9Lqj29N3+r0TiDhP5zKh6UEeWU
         yxXj6M0f7AUxZUUg8Oe9xRQQWxaBF8jmWEkA4DSr/gVKRS0V0+ybHr7L6sGS1EG8e54Y
         i50WDnTMoDofmSZqTyKZDT2SZJ0waR/xLSlArjPUhTWaIuPrfd81JQbUISUqL8iFziH/
         cxdw==
X-Forwarded-Encrypted: i=1; AJvYcCUhBl+PojARssQ1W+BKhSThCm6DDu3gZmC9iPwWL2TqFJV14gKUsDMCVRzl2It3gsdoog6K3Z9F+8zep9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcfxPHC091iiflopYItMszNA+o+LPSQXBhmlvf89++g28nVTSC
	U/bbVUycXA+DCyBUrWZEiHKK54B8H3Z4xSYgvaaZ1seiPozaMI1+hPH+U01Ez5SWTKY=
X-Gm-Gg: ASbGncuKlpoMqUctF6AcjuVqKLiRbQ1+5y/k5m6crtoBbSpWNlAeOZGVtxxtSdHsDLA
	E01OewpgVxWFrHHO/wbulyVBbXBoBvFM5QEiubAdRzND87VdDmcNPvQRWCjxiMQzAep08JYnXfT
	uXnV+HNaB9e64SShP0b5mL309TaHQOjenzfRd9tJwEZt8B3DVODz0N2N3AKn+GLYOxaDGttDyJT
	eEGy2HUiWufTxvNTBOJEykhkVjEOH3VfKgfnOa6wXLSWfsYDPBKKgGBwGASzsuy8DSYkk5ANDLT
	0Jpvm6lawsq0u3U8SLg2+JOATXrtlBazD8kcDAvS9Sfv2oUjq9zr1tDXXlTseu/uq1JJO7D1asI
	8d+zCz+dKTbyK/Je9jLQ6CAB8WxEUENcipl8uGqqv8UsuIvFP+RfAsVlSu3NMr86QLtGyPD1R2g
	LvXSo+tsjv4zVb+KB+reWbWJE8Kw==
X-Google-Smtp-Source: AGHT+IHXqefH327sMsO9RX5OelhEq9jJaKmV2JPysRJpgJrDsL478SviiAp8QmNSVRFVf+//woDFpg==
X-Received: by 2002:a17:907:72d3:b0:b3b:4e6:46e6 with SMTP id a640c23a62f3a-b6472c6191dmr468392466b.1.1760719379781;
        Fri, 17 Oct 2025 09:42:59 -0700 (PDT)
Received: from localhost (mob-176-247-36-41.net.vodafone.it. [176.247.36.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c4949998csm122158a12.38.2025.10.17.09.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 09:42:59 -0700 (PDT)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] iio: imu: st_lsm6dsx: Fix measurement unit for odr struct member
Date: Fri, 17 Oct 2025 18:42:54 +0200
Message-Id: <20251017164255.1251060-2-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251017164255.1251060-1-flavra@baylibre.com>
References: <20251017164255.1251060-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1061; i=flavra@baylibre.com; h=from:subject; bh=qydNSCeSQ+E2GOjHdtY78InKMYtkzGBtuz7sO0dEZ9I=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBo8nH+ESF9IxfWckt3q+TUtO1/qrjD/S281k3pT uSxV0F68iqJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaPJx/gAKCRDt8TtzzpQ2 X4n1DACXgY5C3cCEjzrMv9fEF/HyhzozhvaLM0G9cIDvj4nRNGRHlvbMXo+Zw+m366YGNxBPg+K FkRAFj/NwyGpAwkML/i+Ao1WFmQ6USjzMdSub/Xkq386RIBQz3T5Zuo6GELTmGc0YQM541wHLYP Ram2OPPWGWDLPdrt2mxt6JHAN7HXFOUMOeNnHNZVNUs0aiHsbBfovfUz/h3bPMnJ5qqYc3PPcG6 vU3cpqmzeTNVwl06CKk6ETwYCR3QjoBHiu1a+eI7sJ9zsi0yWJ3wzt4pZSDDQWQ/V3dGzyrHzN1 I/Sgs5oJRQw3jgfPajdZNzzLI2b4UrzmAvWetEa8Ah1eRUZZ1gC7S4q6Uaf+C5pJ9RMZdQuMmyJ uGyd4reZ2lzHokcQGr/p6bJqZipoLvxjrAKnp5S/jNg8/oc0oyCiylSjujSEWRlIro+SqNnGmv1 QIOvzq0Sej3Wc7Ugx0w4lddeBj1RcRry5UsvdqJ6R2putQTzvscGK9DGG8NB94GadGm7U=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The `odr` field in struct st_lsm6dsx_sensor contains a data rate
value expressed in mHz, not in Hz.

Fixes: f8710f0357bc3 ("iio: imu: st_lsm6dsx: express odr in mHZ")
Signed-off-by: Francesco Lavra <flavra@baylibre.com>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index c225b246c8a5..bd366c6e282a 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -365,7 +365,7 @@ enum st_lsm6dsx_fifo_mode {
  * @id: Sensor identifier.
  * @hw: Pointer to instance of struct st_lsm6dsx_hw.
  * @gain: Configured sensor sensitivity.
- * @odr: Output data rate of the sensor [Hz].
+ * @odr: Output data rate of the sensor [mHz].
  * @samples_to_discard: Number of samples to discard for filters settling time.
  * @watermark: Sensor watermark level.
  * @decimator: Sensor decimation factor.
-- 
2.39.5


