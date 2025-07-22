Return-Path: <linux-kernel+bounces-741606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19583B0E688
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 00:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48F15AC2D68
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 22:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E9D10F2;
	Tue, 22 Jul 2025 22:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="W4eDQqlN"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709512857F1
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 22:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753223971; cv=none; b=N1ZgslbZ8lY0H5V43BSA9LKd3q4B5rggXqz7ywvkSewQiZl1aLx1dbxwMhNXI5sKS9fpw3XYc2r9/DSXw70KvPtjrwDtx6jFrqbx4t6UU/uXb1KDcL4Rr7AaDLc3MYrn85pcR9kzyyYSBx8hTLiF7ZbymoYv9/KelbbTgTbSBdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753223971; c=relaxed/simple;
	bh=px0O9Pn7/IDM6rL1cM+ZhTrs/NnSbTwFY6d85nxa624=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bCR0/QmO7pI2MVIZ56vrHI5WuYSLhB16jRTP6YpRL3/RKBwnVdozdnQtbwLPQ8jmECilYndWgPW03hzbqMpQ/E8GihCmA7QvNnfN7012f3PVN2HqIL2rX83XMZiQjd7nab/wpr1gMDRVo5pCGt8wQEmNTm/RV7y9erspAepGW/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=W4eDQqlN; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-73e7e4432f5so3481950a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 15:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753223967; x=1753828767; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/KSQKZiETtG8L8jenInH7UizjmYY7WMCuQ5b0SZD+UI=;
        b=W4eDQqlNEohfRQHtqHq7JADhDhme6ExCADpPPJNw090mgVgNhDBWlKYybZ5J9iQCWd
         jguk7QQFiEnMb27qc3gRAWf6gtgO+yCJm206kCwwjsc9VFNeM0LJzAnVqZTQasTjfbx3
         VPvanOU8xU07PcdU4N4UO4mWqvdJGD/6hbvJHy4niI3YZSVITXTCKeoygWiVWYs6rqGz
         t9iU1dMNSID1FGjYdMvyIMKIxV5p+gYJgFUXymdfCMPJG/saWQsiewTtaUcWufzqpw28
         dDT2UbI1hbeYibp1/tRMVsaSgqW9hWaSFdpoCVEpOO5l51oos9/BIN8Q2L0U64Cl+x7A
         Fjjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753223967; x=1753828767;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/KSQKZiETtG8L8jenInH7UizjmYY7WMCuQ5b0SZD+UI=;
        b=Tx23Eofgryts+MNo1XkoHgeCLTxQ5CU/bio1vr7rs7CxCWw34kNn2T66pVqgNHG0ey
         kl3ckhTcya3zQtB/LYk+eOVBxBXYS22AbajS2VSlvP0472I6q2SPQwzdMYIWzHewJ+ur
         uph/OGq3AT/tOAc16Yio06mdPE/m3ac/iP286AqHP7lkKdtiUHA+wD8sqT62+TtLR53G
         PhBcM/Qh05dk+p0PrZZrkfpJBUIxsruzp/ZOd/LJLXSfUESZapmGr6qi5jXqtP8EnH7j
         fTpbH2fCv//xE67l/1c/WvdEC6qLycPfpGA1U8F7HszCd2UvAfFOddpjDUTOqXBJoOpF
         RxvA==
X-Forwarded-Encrypted: i=1; AJvYcCWeHmHOFy+zLWkcU7y8P1DUiodUvVqm56op0ItX0fOHS5ZonisAG70YgjAWhy4usl3wW7X2a1lYRRHnlrk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi1WTkvIVISdQT4QjSzKOVh2AP7tgVjQcyvA2UVt+DQ/THuOHy
	2od5unOUvKrWPPaP/6kO209BbrvVCFkUGnsukIOhC8Ozth1d5CIPMLdG6gqJ390540W8TwVONog
	dqYTK
X-Gm-Gg: ASbGnctZ5XP08ZKtAUrJt98lt4XrT3kAwmhMpmu5Kx6CFKHky0CL4SvnDhIYyYqpCUV
	ooxGNg/TWPYKLf2kCz8M6F1czc/cgRjVep0zbi93PQUSJ8QR26nwevmsmtyecvF+Am7puVIMdYr
	ysRHLUSa3VMTw0LpCWoPTtlU8O5sioRwGvhS+/npk/+0kFq/K0/2loyp56WiLdQK288LC2dIuyN
	6Wj7AGAL6PhAoKKopozcyWXtgpdEtsACg8xt+DAxQeWbX5xaVit5KykI1TMJKuiVssQhTMHXOZg
	088ge4mlNaTiaT/4NNpnpnDqBAnCQ5Cc6UYJc+ZLM6PztlUOCQR/OJbKoa4lRhNkH6mB+STGHG3
	+ko3ibLRHnJQHc9UyJ8jvrgBs2+s=
X-Google-Smtp-Source: AGHT+IFt0eMC9lpbrwQBy1X8Nze4Ja02fxZ8WxoeYNwsSL59pC+TyZUdtRdsdwb6/DZlETM2k5S0Ug==
X-Received: by 2002:a05:6830:60cc:10b0:72b:782a:56d7 with SMTP id 46e09a7af769-74088ac7397mr434415a34.23.1753223967525;
        Tue, 22 Jul 2025 15:39:27 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:11dd:c0f5:968d:e96])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73e83b0a51dsm3820409a34.36.2025.07.22.15.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 15:39:26 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 22 Jul 2025 17:39:17 -0500
Subject: [PATCH] iio: proximity: mb1232: use stack allocated scan struct
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-iio-proximity-mb1232-use-stack-allocated-scan-struct-v1-1-b4ef77e9ddea@baylibre.com>
X-B4-Tracking: v=1; b=H4sIABQTgGgC/x2NQQrCMBAAv1L27EKyEkS/Ih7SZKOLbVKyqVRK/
 27wOHOY2UG5Civchh0qf0Sl5A72NEB4+fxklNgZyJAzFyIUKbjUssks7YvzaOlMuCqjNh/e6Ke
 pBN84ogafu6xraMgmGWfd1cXE0NNL5STbf3t/HMcPQe8z94YAAAA=
X-Change-ID: 20250722-iio-proximity-mb1232-use-stack-allocated-scan-struct-e0f051595dfe
To: Andreas Klinger <ak@it-klinger.de>, Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1783; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=px0O9Pn7/IDM6rL1cM+ZhTrs/NnSbTwFY6d85nxa624=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBogBMWhIkLlPgrXT7txt4Rtj1/2J21HqU0YuyoU
 7r1oXLMtcGJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaIATFgAKCRDCzCAB/wGP
 wO0LB/4zuX3lwLnM2FRJ5nxuRET4255Dv/wc7QQ4+uTHvevK5v45hkvbNS0bgNP6qHRZewtpcXg
 518uuGd0GUuCDAx2gVMWC3qgtajgqQtuLw0OHNfx5iQcDCpiuZFyPLkErHfTSlMy/svWsd4V6ll
 CfbpJmlZEUyWM984aSqOltwwox8wbiRctop2dLxTmNZMwkZ8vnpkZHjXbNHp6KchxIo4hv3dCla
 TrFSYDhWAPLBnVEZUE0uMiC1QXD2RrzDqmTSrd1Z7ZJ298PL2ws0xznK3y4YDHYxCZavtVaERlL
 MgMPnYMtR3VaWebiJ+94xqcOp0qsLeJg+nt40BGm+r0dbKcI
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use a stack allocated struct for the scan data instead of using the
driver state to store the struct. The scan data is not used outside of
the interrupt handler function so the struct does not need to exist
outside of that scope.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/proximity/mb1232.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/proximity/mb1232.c b/drivers/iio/proximity/mb1232.c
index 01783486bc7df34ec3b38b1d0ad5f52e3eae6c92..34b49c54e68b0a11bac0287c65cb368c9e956da4 100644
--- a/drivers/iio/proximity/mb1232.c
+++ b/drivers/iio/proximity/mb1232.c
@@ -42,11 +42,6 @@ struct mb1232_data {
 	 */
 	struct completion	ranging;
 	int			irqnr;
-	/* Ensure correct alignment of data to push to IIO buffer */
-	struct {
-		s16 distance;
-		aligned_s64 ts;
-	} scan;
 };
 
 static irqreturn_t mb1232_handle_irq(int irq, void *dev_id)
@@ -120,12 +115,16 @@ static irqreturn_t mb1232_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct mb1232_data *data = iio_priv(indio_dev);
+	struct {
+		s16 distance;
+		aligned_s64 ts;
+	} scan = { };
 
-	data->scan.distance = mb1232_read_distance(data);
-	if (data->scan.distance < 0)
+	scan.distance = mb1232_read_distance(data);
+	if (scan.distance < 0)
 		goto err;
 
-	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan),
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
 				    pf->timestamp);
 
 err:

---
base-commit: cd2731444ee4e35db76f4fb587f12d327eec5446
change-id: 20250722-iio-proximity-mb1232-use-stack-allocated-scan-struct-e0f051595dfe

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


