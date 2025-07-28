Return-Path: <linux-kernel+bounces-748556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D847AB14299
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 21:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08C8217D0C9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 19:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543DB22A4F6;
	Mon, 28 Jul 2025 19:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfbVxT92"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EC71FC0E2;
	Mon, 28 Jul 2025 19:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753732235; cv=none; b=UHb8/6WzvUeDo/MXi8eZQcN3He7xLpnfHtNrRnvQhzodVCztl6iOVl4U/IapG6nyZC218PaF1Sxu12mzNG1OHBPn5u3gs/feA/RFyx2w5wOJxN8n/djhIanbf6Mw7H4oslbixdjnRM+yvC12F4A84bHHznvXZcjzooXep2PzLwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753732235; c=relaxed/simple;
	bh=rKLuiQlOyO2eI5akCz2SxHc2bsZA3ehB8Nm3+relrE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hOhnJZ7HdilxlrZ0ofDI+KOYJzM5aUwyYWxo+LoAj7Z4VhyfvvfHmyKeHP68rVssba9P8vrA5ndprtZtVJ3u8FRbj9yLVCO7FKzruTMb1RUfFQ3Fl3wOukuV5uPJJz0wlj7hx6LjAOkNRF1OrRx9CGp6/vGn1vkR16PuCjCOUXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfbVxT92; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b78ad900caso112214f8f.0;
        Mon, 28 Jul 2025 12:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753732232; x=1754337032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqzJyz+pvH5TqNJSVLtGvQbdY/33ZPWTHO1nDG9PVLo=;
        b=YfbVxT92X2aZ7YAOsbHcpBcnZ+WRnCvwR9PeA5kDt2z2RwwG26Vo9xjnHwvFoZ1suQ
         /hIejx6ypM68QMxKHsnReF0fPDs0Lp0P7RVnYQaSY6GDLOxzejvYx9/IFgO9OWlvPE67
         JogK8PoGvGXDGAUPDfX7hoHOxiQHqz11ZY4+pCyyD/4RJfPdBG/NCBlh498Xxe26zlQp
         XtjSs2yDwJFrB7T26Vpv6RF8MqkoThpOEtuGJh9K6jjpMGwFqUe875LeHXCmnYUf04kI
         OaX6VhPd5VKnRF5ba9g+Wu5pge+7OXJeGnhvvFozEvTAwLD/dx6iOrYZu4rWiAtsYsKI
         hyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753732232; x=1754337032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LqzJyz+pvH5TqNJSVLtGvQbdY/33ZPWTHO1nDG9PVLo=;
        b=YsWumQhz7MzwJq8UeRoB1QE+xVF/g8d8gywyWuUgsZU8/6Y//IVQ0MLrzejahnrNcF
         jHAztZkcG/klNUAg+MY6CJm+RjpgGE5WF8glPjpYIWaWPM66+hhGp2tKMWzFsUwcCFEX
         gzrkFECFdTHhKbRPwGmRowc/cpxXUrEB/Hdg3I7XR+HJhbSulPyeQ9XwLFqw/5YPWnnO
         jbPjSiQfg1cwT1rDsDJ8ehq8esl3+Dz1wBGem5HvS+6lQ90NSv+vEO95LopH2aQmjNU2
         gvjDvJMFpB8o/CtQsEhLCwvsJ3z+i4vTbnXBz5aaCgLjgH55Ip3jhBZ/vmvThUROVYnZ
         UD7Q==
X-Gm-Message-State: AOJu0YzuLnXvF1ptYZhyAllpB2uduIdzDjh9mBJM8UBe+qzVYgEJnVUX
	NxNNxqbsbfbo8bpVWkVL0pUpe0lo+yHRkmKE80J3rtrE7/XViXz+kiSuRYNQeaMXEKk=
X-Gm-Gg: ASbGncv01FnBhqjFWdKy3KPqvzqQ0sbJuhRAUpR0CSovBjBK6O9+58UmSTi7GBVacyA
	C91qHRt95fkbAKFZjJBO7Do1vtoPFg0ynPD1kHQdCzasiscaUCg7G/0AVdkEYTaTQfOzYC1Ur9y
	bSagxNt7G0/DJbO311/poC4NeJmYquSeiq/TLrEPttZWaQ4Dhhs9XmQjmug401VT4MmIUmZX0bX
	YwfpvPFM2+PXe7Wn4973ks1wpnc+ZigLBmdzptI6Eq39PB7I90ijOYU6D/MML8OvNGwcGgq8pXS
	l7p8Q8NriGnJJxKm6C5YTNM8DZbh6M/KWWCVFELmDytI4rat+fDdRb7KD82ZFPCUZltfovG+IeK
	qM7N/rPwqBm2pHJ1+oq2jRdn/XkiqQquMoQ6tMi2tNAunUlB7bc2BOqdWxERULrqeKE31QvT4jg
	==
X-Google-Smtp-Source: AGHT+IGouChMDfD+B2iX5sMvvtc+j6j8ymYQa65QiEinlp+r6aFoFRb6SAWMfXohlecp2THQJAe07A==
X-Received: by 2002:a05:600c:3507:b0:456:4bb5:c956 with SMTP id 5b1f17b1804b1-458766c1d21mr43523015e9.7.1753732231691;
        Mon, 28 Jul 2025 12:50:31 -0700 (PDT)
Received: from pop-os.localdomain (208.77.11.37.dynamic.jazztel.es. [37.11.77.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705ce685sm165444895e9.30.2025.07.28.12.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 12:50:31 -0700 (PDT)
From: =?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	krzk@kernel.org,
	=?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>
Subject: [PATCH v2] platform/x86: surfacepro3_button: replace deprecated strcpy() with strscpy()
Date: Mon, 28 Jul 2025 21:49:42 +0200
Message-Id: <20250728194942.558194-1-miguelgarciaroman8@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b925480c-231b-44e5-bf1c-1f18f8abe42d@kernel.org>
References: <b925480c-231b-44e5-bf1c-1f18f8abe42d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Miguel García <miguelgarciaroman8@gmail.com>
---
 drivers/platform/surface/surfacepro3_button.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/surface/surfacepro3_button.c b/drivers/platform/surface/surfacepro3_button.c
index 2755601f979c..772e107151f6 100644
--- a/drivers/platform/surface/surfacepro3_button.c
+++ b/drivers/platform/surface/surfacepro3_button.c
@@ -211,7 +211,7 @@ static int surface_button_add(struct acpi_device *device)
 	}
 
 	name = acpi_device_name(device);
-	strcpy(name, SURFACE_BUTTON_DEVICE_NAME);
+	strscpy(name, SURFACE_BUTTON_DEVICE_NAME, MAX_ACPI_DEVICE_NAME_LEN);
 	snprintf(button->phys, sizeof(button->phys), "%s/buttons", hid);
 
 	input->name = name;
-- 
2.34.1


