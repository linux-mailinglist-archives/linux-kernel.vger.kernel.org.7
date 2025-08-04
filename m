Return-Path: <linux-kernel+bounces-754900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A1DB19E33
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 11:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB86E1890876
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 09:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0075A2459D7;
	Mon,  4 Aug 2025 09:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ImkirbJN"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB33A242D9E
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 09:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754298266; cv=none; b=Y0t49uT1gFFVuOuhp3M2ZUy2R6wfWFfVO5xYi0rGCVqhFGrwL+M5b0tejEzTsj/IibHNxN3/T9VAV4P9n6aSAvQr5JYFu05iOPdctpOD7dnq1o8h3piMDy1tm2qphwifRiB1xe/bPwJH7EqOhLSvGdCI+qa65gkDRe21+uplW5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754298266; c=relaxed/simple;
	bh=ud242vZvLJrH6xopdOSJSplgPyMO56QkORuiEVdjqaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k3lLIeNoCaWBO5y0SRb6VQ6lI3AHkzkyqAWwBosTyDj7sfGwupQwByk2mcx0HGx+SVZhXgolErBC8sfQZonMo2pfbJorsme/Qq6X7y1l/FCiC3kha0EU1edQSUwCxY3G9xrCTfnySZ3PgrfhEg5WrrCatqkUJvfqv1onRCXrgMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ImkirbJN; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6156a162537so6219995a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 02:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754298263; x=1754903063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHnJVEZKYStNja74J0DOKbp6uiLWBK5/zflpDmAO16o=;
        b=ImkirbJN92IMT6tsK54LdlfJu4E6tts24A0lLR1npks2fTb6EQZjPy21ZZC1mg2igv
         qeUPlw8b3Q4X+5Z8+l9DkDzOxb91UkBuMNCx+2SYTEPLD1nD20udcDSoVnZgVd+Hkork
         dgwmEx9DzcMsZqByOwReefJD/K01Dey/FkhMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754298263; x=1754903063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tHnJVEZKYStNja74J0DOKbp6uiLWBK5/zflpDmAO16o=;
        b=OewM/pQztj12SlZVzTBJm1imK98CT2Rszh8oUafu1xwMRYM0XrLidW1JCsKMLtdjFI
         6HRVOYY7vpLyPToBrj+3qzOhHPVtrYvwXwqd0usWz7ZX8N/6WkxhcQFhwTuG8QUIi5U9
         Cajn2n4JDZUKxeOdAOWeXGvLQBy2zG5YN0DA7epVdWsT/Ztqj1a3h8eJKjHO93llGBOX
         Tk+4KMM1JTv7g+6B4MpS9qd0MEe0S+3Ttu5I840DpEytUhTAfWj9fRZqnS8+WyyAU+IA
         LLgZBy2svqRHnoVTpmxA9rqcZvHb9wyKL5JfxyJK0VdpE5XORtWyqtpBI2t6wALjWX+6
         gWBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvl6n25I4jJZ6jjnFMSCDWARsjjoAHze3qUI1aScVrie7Ka2hyISOkZT5tnLL0V/QuNFUIErrOOMf9lFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ61zbVIn3bkRLl/k2PJYxBWxtgUG0xPkSx7Cbel0aT6aw2cgp
	k51WJ6sP5+ZnAPPYOCIo1EWmmxht51gxyaENt3NxSkXCJ34z68bi9gt0AZ7WYhanMw==
X-Gm-Gg: ASbGncuGnDDLeQh4/rQEl0L8CGLZ98CoC7x2+ggjE9CP31aYRih9KnKbPE0o18whR3D
	hXV/f68F7P+0oJBIgDc3ODYen61IjGwh/jGfCWN/HB5IQSMj1yayLK0HHdN4z+uJf/iFnRHZxJy
	lo0pro5V+0JCRnmST85qZ9pqVZO649QSQTec1A7KB00amptA+2Y6Po9vsfM3bK/BiR8EJN7FOKp
	hnSD8kD0rlxInKzj6pmYDOIBt7t3zz3QLqqvyPDqNLox0LhqWpBMOvbCqZ1kAT47Yej7dEvHm+q
	CTK2fOeaF4clshP+JY+1exxf8q70cHTNanrNuzVYcbZMS0gx0HTKl+ZXLNaVFs7O17IBH2L1RiW
	t7QoRR7VTJnePsoFW/CkPPoqdC0SPQScwBgezUrnnn5NOxfdtLhRANzbPr7AcE/UL0lgy/I4st7
	LVSDgXVnw/r3Kf21K/6x8sI5cNIg==
X-Google-Smtp-Source: AGHT+IGlP1mTwXR2PA9n8SopXtLR0QRbnOxjHuzCPP04R6m/RhGzUKKa90WwYf+waVhclx/pDtB5+A==
X-Received: by 2002:a05:6402:90c:b0:615:6fae:d766 with SMTP id 4fb4d7f45d1cf-615e73889a3mr7449193a12.26.1754298263208;
        Mon, 04 Aug 2025 02:04:23 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (150.230.32.34.bc.googleusercontent.com. [34.32.230.150])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8fe7995sm6412790a12.36.2025.08.04.02.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 02:04:22 -0700 (PDT)
From: Andrei Kuchynski <akuchynski@chromium.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev
Cc: Guenter Roeck <groeck@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	Venkat Jayaraman <venkat.jayaraman@intel.com>,
	linux-kernel@vger.kernel.org,
	Andrei Kuchynski <akuchynski@chromium.org>
Subject: [PATCH v3 02/10] platform/chrome: cros_ec_typec: Set alt_mode_override flag
Date: Mon,  4 Aug 2025 09:03:31 +0000
Message-ID: <20250804090340.3062182-3-akuchynski@chromium.org>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
In-Reply-To: <20250804090340.3062182-1-akuchynski@chromium.org>
References: <20250804090340.3062182-1-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This flag specifies that the Embedded Controller (EC) must receive explicit
approval from the Application Processor (AP) before initiating Type-C
alternate modes or USB4 mode.

Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index b712bcff6fb2..99f549263c37 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -491,6 +491,7 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
 
 		cap->driver_data = cros_port;
 		cap->ops = &cros_typec_usb_mode_ops;
+		cap->alt_mode_override = typec->ap_driven_altmode;
 
 		cros_port->port = typec_register_port(dev, cap);
 		if (IS_ERR(cros_port->port)) {
-- 
2.50.1.565.gc32cd1483b-goog


