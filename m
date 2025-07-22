Return-Path: <linux-kernel+bounces-741621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CC9B0E6BE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 00:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B4557A4CC1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 22:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B143288C87;
	Tue, 22 Jul 2025 22:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="drxXt/qv"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6090451C5A
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 22:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753224859; cv=none; b=BOcLDICpJlQhwxaPA1iKCofRBc4GMX/M08mfb3AfxXqb0x/6Zqtb/YjPCFhobm7ktNCFxptkDktzAv+HBfAQZ2Ml2b23A08DM5X0qjDkvMC5qn/Y/u1D3zIKXUrPeDU17yD3NyB4DR45opegPMI1jkDL7qD5Rr21Bc0lSTdC9T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753224859; c=relaxed/simple;
	bh=umiHDM6LqWlzm/2yf1x3Sa2R2zd6r2fZNmO1DudLKx4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aqDjGDDNnKANHsuA3e+gklwQ491IBF/nSBYwJWK6fF00fZEvoHb74I/TszX/XExcMjbkvO1EKMdWICxnDY++GtcWEHty89obQ/fTbw2A7dzbq+zdy8hM3jkvykr0Y6WjZhDWOuuxKPfstKvty+2x31ZEHCMDgHX6j8x/rjtt7UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=drxXt/qv; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-73e810dbf5aso2934935a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 15:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753224855; x=1753829655; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/xtin9wcnf3aNIJ/EsYXL0FdapLNUSKbCP7OH0PGjYI=;
        b=drxXt/qvUdaBwhi7o6UAOES6YNoIQgh7SCsSGNHLAS+a/iC7YQnaex/toNEepUqsAH
         Rhe3pJB/h5+EIxn5VEbCWa2xmcc8qT6Ub0C5lVNTSuulIcbgSzR2IvGLCB05sjr0zpA6
         CW+cQhQo5R18/r/ReOoMkyGrFzdrLHd/zHjhA6EFTN3I5cAMZwG+XE7IvXaUO48VbDz1
         nqhLw/HqCN25J/aidcoilNVat2UkqSCjKg4eV/SnheSwPDxfh2THjceH0g5fBnVx5Vbk
         NpxxZVGL3Xsfafut2hf0jMIoYnvdQHJZ6aQYe8gBJC8wRlRLi2ZLf/lt+HVsAVfVTZHS
         SWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753224855; x=1753829655;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/xtin9wcnf3aNIJ/EsYXL0FdapLNUSKbCP7OH0PGjYI=;
        b=BVlwDQV8VA3TXY9SvPJYAhEbXdp1Ix7kfpdb6YlxSVS3BODvAIZgq4eABTYOhPW4+9
         XNJI7oybLuUnngd9x2pHd5St6TXiqxEi6hIRyXi3AC1vLNtTPXy2c342nNuO58iKugkY
         tI+GH7fTlk2bz3vXyMeAV4QyVTf0ilj1GzCqcDWdLgrAJOMMkqPHRpNPTWAhJ3kw8F9J
         OvKbRXR0voEnc55UjAMPUYPPdhQIyVhPx0kAsYQCiRx94SkLElj8w9RugsbBUrbo9+iV
         O45VeG9ldhMKbP01Os5eOkMKmDM1R5uOmKG9oQv9lgtKoVDHg847EXrZfdt3CGJvvJd8
         viYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXY8QTcWPxfY7WYpoy6a1b1QLIoc8TZQu3dy9kgD0R5uwZVaKUXDN2ONCMHEdoSzecCxceEA/gL3rrXCRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuFWY+UeBS+9qiUToDr0bI10UFL7CM1wXsnqbCAf0mLtm1x3RI
	8bIysyb6D1mYjHfAvTHiBaLFD/mS7eLp3Vu64Nk+D87Yqi7wJYMtD8AJ5x9AGk/GyZ0=
X-Gm-Gg: ASbGncurHjRUdAhtcvxjUPLSrkATAwZbL5aHfOXFeP9+vsg2Qm1fDxnoRGaIkg2JJJY
	/AFUAX6Rl9hIRZNfZmjhlSCgVI7nxmRk0HAg1m5cAN5DZqgUOoFNtQQa8deq6emWGUw1Lj/YpHa
	ir7CfoKjQsV7q3df8XK2u+rgoQVyrFGi4gi3lQy+ELZNG9KfM8W1Sak/QZOKp/aYE3nmCDf4EZm
	dDmXQ019fV7w8xwSHpzNA+rzRiBUdRFxA1xVmL9GGYFmhT+D9mSsWls0Nfz6ied6RGvH9h/MfEB
	0bhAxszglcYT4k/QRFyANOGSEPTQBLV9tsbigEr/rZ+0lL6amKVz/C1TcG26N3ZI2OmlC+V/YhM
	dgrkoBISQ5dY9SU2rZeiVLWSFL2c=
X-Google-Smtp-Source: AGHT+IGMl/P7C+Yb65FSncTl6kop01dbj/+uCsHsd15nNFA9M90KweCXGirOaoekowckzpFXrCmB0A==
X-Received: by 2002:a05:6830:700b:b0:73e:a023:63b0 with SMTP id 46e09a7af769-740805ced70mr688539a34.1.1753224855419;
        Tue, 22 Jul 2025 15:54:15 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:11dd:c0f5:968d:e96])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7411f5e7752sm31768a34.56.2025.07.22.15.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 15:54:15 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 22 Jul 2025 17:54:07 -0500
Subject: [PATCH] iio: proximity: hx9023s: use IIO_DECLARE_BUFFER_WITH_TS()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-iio-use-more-iio_declare_buffer_with_ts-8-v1-1-36188a3f214f@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAI4WgGgC/x3NQQqDMBBG4avIrDugKaLtVUoJMflTB1pTJtoWx
 Lsbu/w2762UoYJM12olxUeypKmgOVXkRzc9wBKKydSmrTtjWCTxksGvpDhgA/zTKeywxAi1X5l
 HO2fuue0whLPvXWwuVHpvRZTf/3W7b9sOdgNhl3sAAAA=
X-Change-ID: 20250722-iio-use-more-iio_declare_buffer_with_ts-8-57ebd3c8af19
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2417; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=umiHDM6LqWlzm/2yf1x3Sa2R2zd6r2fZNmO1DudLKx4=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBogBaPIbbPl5N+qYRPVSNUkAQFQ+EfzzKYTcOk/
 gNC3+/ZPUqJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaIAWjwAKCRDCzCAB/wGP
 wIF0CACT5OemwSfbOLQJJRKbMO1vnA5RvTruX+DJpieV8SUKGHRVgWGX+PokjVY6gDQSPUswjcx
 jJG4AS6VvEHfNErPTtuuNXSYirXgeFv/oIGEteOqYiZrkzplbaKa4PBPtC/W8tyNo5qg+0LuatC
 uVM0ck2IRnzqwpcmtBw4YoTslFJBgcyRzoq4agksyw0OgFOK9pwwZWLF8STD8EXmcvHC8GYwyV5
 jZAPJOBPD/dQ7dK2nOZLDg8ePiUxifdaOU/GKGz/3SvqIDslYsE6kIz998obz2j5rvtTHg+FBWZ
 shjuY49pskmeG3Lg2BS7M+/VSOfey1yxeCJg4SAmwmDlFLKM
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use stack-allocated IIO_DECLARE_BUFFER_WITH_TS() to declare the buffer
that gets used with iio_push_to_buffers_with_ts().

We change from a struct to IIO_DECLARE_BUFFER_WITH_TS() since
HX9023S_CH_NUM is 5 making channels[] larger than 8 bytes and therefore
the timestamp is not always as the same position depending on the number
of channels enabled in the scan.

And since the data structure is not used outside of the scope of the
interrupt handler, the array does not need to be in the driver state
struct and can just be stack-allocated.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/proximity/hx9023s.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index 33781c3147286fb3e2f022201ccf7e908d0b6b12..1203fa4bc7512ea85b55d537e2459104b52407b9 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -143,12 +143,6 @@ struct hx9023s_data {
 	unsigned long chan_in_use;
 	unsigned int prox_state_reg;
 	bool trigger_enabled;
-
-	struct {
-		__le16 channels[HX9023S_CH_NUM];
-		aligned_s64 ts;
-	} buffer;
-
 	/*
 	 * Serialize access to registers below:
 	 * HX9023S_PROX_INT_LOW_CFG,
@@ -928,6 +922,7 @@ static const struct iio_trigger_ops hx9023s_trigger_ops = {
 
 static irqreturn_t hx9023s_trigger_handler(int irq, void *private)
 {
+	IIO_DECLARE_BUFFER_WITH_TS(__le16, channels, HX9023S_CH_NUM);
 	struct iio_poll_func *pf = private;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct hx9023s_data *data = iio_priv(indio_dev);
@@ -950,11 +945,11 @@ static irqreturn_t hx9023s_trigger_handler(int irq, void *private)
 
 	iio_for_each_active_channel(indio_dev, bit) {
 		index = indio_dev->channels[bit].channel;
-		data->buffer.channels[i++] = cpu_to_le16(data->ch_data[index].diff);
+		channels[i++] = cpu_to_le16(data->ch_data[index].diff);
 	}
 
-	iio_push_to_buffers_with_ts(indio_dev, &data->buffer,
-				    sizeof(data->buffer), pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, channels, sizeof(channels),
+				    pf->timestamp);
 
 out:
 	iio_trigger_notify_done(indio_dev->trig);

---
base-commit: cd2731444ee4e35db76f4fb587f12d327eec5446
change-id: 20250722-iio-use-more-iio_declare_buffer_with_ts-8-57ebd3c8af19

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


