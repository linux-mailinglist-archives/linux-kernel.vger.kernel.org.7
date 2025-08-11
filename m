Return-Path: <linux-kernel+bounces-762973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7F2B20D05
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 17:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 087AE189E2D7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DD62DEA7E;
	Mon, 11 Aug 2025 15:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="jL8L+J30"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6411A1DF27F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 15:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754924654; cv=none; b=LurjxGHzu69HKM+Lpv/WPd50xutvie+AEuP9hBoaEzwZ3+3EaCcjvBxmjOF5h4QXiaAyD1ymtFf+U9C9g9HJ80PO3hZYoj8BSazGhdHRgmc3YRUfTKqnbb3tFbXMH91ypUuKDmyebuoNJWshv+l/oXNELyrsEVQYgiomckqb2Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754924654; c=relaxed/simple;
	bh=go1LK2KwIv9bOBtJoPVqpan3/GxOSDQsRCCrqOTX41I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kavPTCve5fZYGNCpUEaEbSKhOCPTz+K7CkCi5eMWg4tKgaXcKU8cfuXJ2QMWGxnuXRUs8SHseu8dtAmT6mD+lwx0e7NAFYBXiENa2Q+rXcTfX5PJCcKMWvjFuUYHqPXC8cgMxuPTCVTWkzZGOCHxgdId7p1VX9hqycOhLdPH0F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=jL8L+J30; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b79bddd604so2597590f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 08:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1754924652; x=1755529452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5RlVEC+aTLY5+N9Mh6FGBCNE6f9ARS3XfPyHyJ93cc4=;
        b=jL8L+J30UIefYSD7OQpysfjUoXmu+NW6vsSl4+tQBD+Uz0OLVOmVa1/eYtAQ1ciyc2
         D/75x5tD4VP4MuRF3gSPtCArjhreVrNkkziUY5iAkHA+66TD6gnpb+UGWdHPCQnJFQWb
         BvoPDrRFnKU39JhJHA03vRf3TtfMd+6hyF0tiUBEFsBaN+LKpsszf2jF/708/YArooPG
         u2ce4kYMzXJrhuIQkPdW4bBoXjFjI6vcSkDtXcWvLXmLB4kL4Kl6l+DvwrQqKsMoVK94
         xmizRMU6r1FNVAbX6fSdfYfOmPtRrf8NGFD+tdzo0Qd0sO+8XFu5Fj6P+Ih76pk6Omez
         FSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754924652; x=1755529452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5RlVEC+aTLY5+N9Mh6FGBCNE6f9ARS3XfPyHyJ93cc4=;
        b=UgWvRDCGJWZWzhmJRgw6BTWizJOMCW2YRZfoec1a4R7PPL0SCDNchmAd4owuQxG4xQ
         Q9fjycVnnMBz3hONU0Pr1+WFDdehFcUxbFZL7/UGJhvQUdANA+dbD5wBbbhnwYoDjz2r
         jwuiBYNvLow9jT8HHkpeq5LzDt1+/57Dmsde7mTztjw3h5WH674IEr85tw4mXPbIM+m5
         kFP6V2tTPoUylBdzNvSy3ME/ClyQ/ePRcgdBwp8T/m09qHR7TLFp9HLJb7Jgv/aaWj2b
         rlaNTGHI3yOv6S1pWR87zvvSfuZO4sJsk72r1RUt5W0YzyO2UBcq5bdr+ohuJIyYeJSo
         1wIw==
X-Forwarded-Encrypted: i=1; AJvYcCWgCLPGrz4VWQqYKghqjSNn2L3wkOkWW+u97c9WySLGAPqajcaxccxkufK0ArGAaJFFMG3bWhnvwhxQ6nQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb7qnvlXX9GHXoGplgWqZzbyWeHYVui+eahiZkTkJd6EJo6bfC
	5XiRAdM0ed3Ec9rVUHewggWLxJi52nYkRVusiO3sqLeCY8Eh26WVjnNn+lwMefOHRi0=
X-Gm-Gg: ASbGncvkhzEnBmHV/qARIXq1CszhPpjOeFG5kAjE1L8uBaVkgMFjLePCp5UMxzxS65k
	dY5/k6Lq+7gKnkZq7sR9vRa5Aoznlqqan9UjzcYtCHVUzA2GqVlgVr1CqmBmEd/cQf13Pk0dmC2
	5pIGntywa4wR5iDMM2UrP0SDMyb8bjfDN/m+coaWXvecZNtExosuwawJHTYF5W/xpC7LIpE8hyn
	xtftjzgDfcbOw42suOYhk/UPHR1kpwNKlCwPbv4V0mp3awv40/IB65n34dQlymLaOOmKH2CYK5W
	Ih32wDWPKpO53v8/xwPKScdeCRsNHoNdPyS/PU9Y2xId5KD9PDanzUZS/K3Apx5zMdhFg9Woh4I
	h/JXjLk+TVt6D50UR9qADRIXO
X-Google-Smtp-Source: AGHT+IErrHO1m9HgaSb9y76gv3JeAANqPlGpoK5F8aU4R+7lrtTdLrB7aKC4QbEySQ2hh4TjE9oVHw==
X-Received: by 2002:a05:6000:4312:b0:3b7:97c8:daad with SMTP id ffacd0b85a97d-3b91101718fmr36718f8f.55.1754924651630;
        Mon, 11 Aug 2025 08:04:11 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:6841:8926:4410:c880])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3bf956sm41850591f8f.24.2025.08.11.08.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 08:04:11 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: Shuai Zhang <quic_shuaz@quicinc.com>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	linux-bluetooth@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: [RESEND PATCH] MAINTAINERS: add a sub-entry for the Qualcomm bluetooth driver
Date: Mon, 11 Aug 2025 17:04:00 +0200
Message-ID: <20250811150400.86926-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Patches modifying drivers/bluetooth/hci_qca.c should be Cc'ed to the
linux-arm-msm mailing list so that Qualcomm maintainers and reviewers
can get notified about proposed changes to it. Add a sub-entry that adds
the mailing list to the list of addresses returned by get_maintainer.pl.

Acked-by: Konrad Dybcio <konradybcio@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Resending as this never went anywhere. Rebased on top of v6.17-rc1.

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa45..4663146de10a0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20641,6 +20641,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
 F:	drivers/net/wwan/qcom_bam_dmux.c
 
+QUALCOMM BLUETOOTH DRIVER
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	drivers/bluetooth/btqca.[ch]
+F:	drivers/bluetooth/btqcomsmd.c
+F:	drivers/bluetooth/hci_qca.c
+
 QUALCOMM CAMERA SUBSYSTEM DRIVER
 M:	Robert Foss <rfoss@kernel.org>
 M:	Todor Tomov <todor.too@gmail.com>
-- 
2.48.1


