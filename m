Return-Path: <linux-kernel+bounces-814468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A35B55474
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 18:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C3B7AA80E5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0399031D396;
	Fri, 12 Sep 2025 16:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LvaX/p6i"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7990531A57E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 16:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757693220; cv=none; b=VvqVjxc9hfKXRzJHCH8rDoBlhpOQqzX8YVec76dr51YHzgMebW3rVCPuPu8q1o+BR2qdiWdVqzyMIyqQmYAD/8qikGFpv4PAnmBxIdQrKyYf7k0AWGuYkyoYBw9S89Ul9yb8eCyvIfOcjmTvEGQ5wwH9l/hmMm/JE+cmUDljmAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757693220; c=relaxed/simple;
	bh=wgqfUfWF7jEGgoJYsUs54G7JmNvVkPSVGZwCRcZx54o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TMvk5AmjxZvxNFELnUz6Ao+Kz36bXEJvtuWvosdZauuRA7HWXsDVTsIix4tQyrQ6ZniXM2pgcjLEQMsU/7Odr6xIWcF8trNicMVi6FVqGtZ155pCX3Fn9PVefQCs+rqenUmh/Pg5nqE5otVX38izcNKaCbslxPfAdvpEWHvGwEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LvaX/p6i; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-61da7b78978so1270944eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757693217; x=1758298017; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1a/egVhw1YA9XEPwEFf5c6wfXJhZB+PsLVwg4louqXc=;
        b=LvaX/p6imqq3ZDwgPoJHiS+4M29mejUGGJunL73CqYi/25ezuDW4SCC9h/nZWn9SWu
         /Jp7C9/equ4Rxz76iP0MsAH21qfFsG9TBP21uxEx9hJqSgN0qJyf7fr86hhxFE8bhOAe
         4co8yurEqOHeUEKrb1Z9BbIWCxaq/p2/HghM8JvyEDs+V1dtYQydO3D0KRWi4KImG4kB
         zCBTOTyFgYIPB4zXJkrBUSpZEktDpd17UUDjrV/Ve5kSvJJJg8Tw/nOK2Xd/8MkpOFEe
         Hbuaj9Qt1Qy9cCcvZ4iAt4Zl2oANFGdwH9YVuGeyF1Rv4WdCFHfydSvGRoU24d0oh6zo
         XtdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757693217; x=1758298017;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1a/egVhw1YA9XEPwEFf5c6wfXJhZB+PsLVwg4louqXc=;
        b=mOuMYZK8/A2UACFPrkxmZxkLnx45oqC4s/2Vh6KMpKsbPj1l++wWI5NcqiE5dDyyPj
         gOE/0zpIFfraESnvt4HSV30gVgYLUm5fScYr4+XoDoZnTZ5FH9cNyhAsA+64plfE7Ztx
         F1eyqZiAOjXAXr+6Wx0ap4v3nh8MgB9zu58+QgzmUYaAnnvHyG5yLFxDwNDlJkRoXab4
         a+6DffohmwnF3lRZwFAX0b9MlVJovE1BM8HLDUsmX3+g0vBYkSlaap9q0DuBa3LpVezL
         UgjTZMXzSa8oZzHKiDDBAuML+7uX+8C/iFq2CAvoKS+k7Vz58ppwRMJSICaEM8SFAYCd
         x9Mg==
X-Forwarded-Encrypted: i=1; AJvYcCUqyoQXOzG950OeWTe9cdjwSVT19yE8zvgPeg1Cvyh/BCVdOaDi7QScyUiVcPv/BqJSN1fRMV4paw6aQck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5ZpFGTE606tb1LP8wp2Wc0l2aWLM6HWM3rsY/mAWo6gWCSpkM
	s6sujokzruKrvirZXVMKQ4pLjfgSscedC2Y2+d/Y/1wpFJv8DwLq6iPdt7hz955lDY3B3XfDokt
	48WEzDQA=
X-Gm-Gg: ASbGncvLZxpXarkszGRd1I3dgD3t5YPPcN0czIsSGuB6sALWG6uGgILixpRr3Y0S6Kb
	3CuA9zoekEtTAa21GfDhDV5n5wdu4ECSPWnoLcBJLJUBmdPqH3GtLIuz7Z/f6gKatCAIxPETU9Z
	MMfHdZd6aRRrpbmx/3YDs79yTTacjuyzgycsZOWTR1KMeP5w7XMMkW4HoFnBVG7NXRcy6dhStUC
	1Iei5FPf/DPT0JtHZ1vVZfHdMTXVoWB0BSf4yf2Z0kWewqwjLgo/v/tt0z1HasiHyFCFakg8MzU
	VHhlbG1HxnjSCibEkWDFrPVd9bD/QmyU2GqbhJLCa/aMHOhzobsftKWKI3St011SzXcokgcwAP3
	k1x6fVYNITqLjYNJ0lEp++9LcmYwZsm/M6CirfU0=
X-Google-Smtp-Source: AGHT+IHigd2jjiy4hIvztLr85kYtqjWmnThzZQBiyBS9hZeg+84NFfEdIUIItNgkQz2LBZS0KYVvTg==
X-Received: by 2002:a05:6871:2312:b0:30b:cc6d:bcfc with SMTP id 586e51a60fabf-32e56bc0ab4mr1873512fac.27.1757693217545;
        Fri, 12 Sep 2025 09:06:57 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:fdf1:f11e:e330:d3c1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524b8a39ecsm1073863a34.23.2025.09.12.09.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 09:06:57 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 12 Sep 2025 11:05:54 -0500
Subject: [PATCH 3/7] iio: buffer: document iio_push_to_buffers_with_ts()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-iio-doc-push-to-buffers-context-v1-3-c4aad013d96e@baylibre.com>
References: <20250912-iio-doc-push-to-buffers-context-v1-0-c4aad013d96e@baylibre.com>
In-Reply-To: <20250912-iio-doc-push-to-buffers-context-v1-0-c4aad013d96e@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1601; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=wgqfUfWF7jEGgoJYsUs54G7JmNvVkPSVGZwCRcZx54o=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoxET3BjmASvGErf8MKEJBIgySZjWdbsbmXN8y0
 Mj+P8CTE+OJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMRE9wAKCRDCzCAB/wGP
 wOhVB/9Q/L9T108CUfDCseEhbVd7ZmY7QY9ZmTcGxaeKddl+EVmf5rzJ6EY5rO3mYJNR6gMcRPI
 G5YXtif7CtnF9VqhLkwsnNEgiOSZxcB6SbQqNF783dlscQVauoNMzk665CVflu+PwagURjShhIh
 yT0r69u5psFfp3XJbXW6TGzRgXs4FKxW0IH0IAAy+4b3cBZzHLj6kjB9nFzZ4TlywqXpnMveYuY
 Y70IUMNaZ6UcqlNf+KTYzFg8RAshpcf+65lMHPXmnzgKPHcvrrmGegc07F6FHLlEw+DXFSKcqjO
 f2iR5DlVjY6EAB5bDY7vrQbdC7baG6EDoarU1NchwnTilqmF
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Document the iio_push_to_buffers_with_ts() function.

This is copied and slightly cleaned up from
iio_push_to_buffers_with_timestamp().

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 include/linux/iio/buffer.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index 5c84ec4a981001dfba3b369f811368bab70a3117..47f23bc0470eaf308fc3a739faaf9b56cac0ef67 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -45,6 +45,22 @@ static inline int iio_push_to_buffers_with_timestamp(struct iio_dev *indio_dev,
 	return iio_push_to_buffers(indio_dev, data);
 }
 
+/**
+ * iio_push_to_buffers_with_ts() - push data and timestamp to buffers
+ * @indio_dev:		iio_dev structure for device.
+ * @data:		Pointer to sample data buffer.
+ * @data_total_len:	The size of @data in bytes.
+ * @timestamp:		Timestamp for the sample data.
+ *
+ * Pushes data to the IIO device's buffers. If timestamps are enabled for the
+ * device the function will store the supplied timestamp as the last element in
+ * the sample data buffer before pushing it to the device buffers. The sample
+ * data buffer needs to be large enough to hold the additional timestamp
+ * (usually the buffer should be indio->scan_bytes bytes large).
+ *
+ * Context: Any context.
+ * Return: 0 on success, a negative error code otherwise.
+ */
 static inline int iio_push_to_buffers_with_ts(struct iio_dev *indio_dev,
 					      void *data, size_t data_total_len,
 					      s64 timestamp)

-- 
2.43.0


