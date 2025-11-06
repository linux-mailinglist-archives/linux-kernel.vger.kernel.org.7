Return-Path: <linux-kernel+bounces-888732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEEDC3BC61
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FA411889D8E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D1033E36E;
	Thu,  6 Nov 2025 14:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="wEbv9Sss"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC4D326D61
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 14:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762439568; cv=none; b=QctVCtalbZxL7SjAsUSv9mqWl9ksTwIsd6xysSoH9B9ZD5vL6LtDD8ZduhYmLowdEi+4uux3NVdVo9a5FfNMLeoSY2AqSf/wSSDBdnqS962ohP86ar/FdUbUxpWxt5d0DQe4WgNj0xE4PVZsTgi8/M1WFWBfy9wt19eWAP3/A54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762439568; c=relaxed/simple;
	bh=r9cDw/aJYsPjA+g3Iqusl0ZJO5kkF5Y1AkYeG2Ln6YI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cI+6zjP04I0vGYDx2InadkHGfn7AxDD3+0O+qrUXOyM7Kp7Ie+aqrI0eedEr5Rb+/SRntt9SU0eu/TUomS5m0ogS2ekvFDczUpJM6yueDhBMsaa8QxmIADxZGmLMvVVzJKB9bSxzb1nEOaacpEvMGRZrTyWRfJMQ8RftbWSroOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=wEbv9Sss; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so6193505e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762439565; x=1763044365; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fTmt0EBBpoH00wEC41/FLfqCbZ/Fh2wyVTiBtA0d/dY=;
        b=wEbv9Ssswvtm30UpHS53z7KetLOWSduDCzPXV2JSFKqNukJeY8HTmwneNHAOx7hmCr
         GixilcmNIVwQ34Vd3n69+hXax6f3aDbEi2NuAAkfOmg0WrixDMRwDJ/TRO+eU4sdJxxb
         VgI8Nqe7w76Dzp/smAloa4fD4gP9LaBef0aC/5iN11YonjgxRqmMtq9zw0KcbnVOM7yt
         +wYyXhHlgWKjheSzn/KQajBsX3VUg9iGSUcviMKmLshiLW0jQGYx+km0OW+AS2JHqmIM
         jLSl/fwC3kW5arEUS5ceEGNcEDVreCiRdHqdrv6NhKYmkXq81t2nxDqWPtGQXqdwSz70
         0ONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762439565; x=1763044365;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fTmt0EBBpoH00wEC41/FLfqCbZ/Fh2wyVTiBtA0d/dY=;
        b=CekAU33X4qgXlr2K0S5pTeWyNMSMYouG9R3knZnfs0ev/eK+nZ8/rm6S2d1UIu9kJO
         GgdkV12drnl979OHEegicH6i72sT8NuEp19T+uOveCcf8BVnjXcoYq7GN01C13wkRClu
         AhYcTnQrG8ALn9LkQVDtO2NZMkwbrFYpSxBlZrDsSBRhsP6Pyp61XUtQkDYGEOWLn84N
         4OWFwbSS0VMaW0KBLhgXPmYUScuEdcQ3RGCjbeMI17yjAil9avRHQSD2c+/sUivuD5nD
         Kya00++SJquTP/Fy94oFzTkRV+LR8iWdGV7DrrO5hCaFVguxsU6Ywv0bm7LDDecvZ8eI
         G8Zg==
X-Forwarded-Encrypted: i=1; AJvYcCXx9OyZj8UxBGhMtrvc+xsiJys0Gjx0wvycwN7IOFdWpRcor/jyv42VvV8GvNDIGqt4S7vzbe/lUCoEQE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAR7btkY3yUOlYk6v2P6lPOez4RhATzdAeVXi1N1yr1osMe2QQ
	X4KUg+N/rL7r8AGWbfIFs5SzGlhQ2+A21aAFbU1II8iieTTM/Wi7a/KozTpUApeyL/k=
X-Gm-Gg: ASbGncsk3lgFcghgZuy44VHZxo5qZE6KgDwU4XvryyuA6NT/6i7My8i5xtlCoQmMU04
	gZu2OS+kO9D4NaxlC4U2RKyPOgIgoeeU1zIPH09FB4l9cMYT2m+sAuORJey7Paibpqb73GKfW2K
	fWrN+cw76Xj5gI/ajXCQo5JxAkOE4nVRY+Sa6ahfl68eSBjNxMKCzn3n2UnbOiITXZ1rEnh8laz
	+YoPhU/dQIkO9G7/E6yiR4xHUU/WHNVDkG7KvqXmVk9nYW2k+zAOJbYBkzmhKE7kSXBKLq8bmEv
	Z4CiHX4XBQXRpsHcnsvqOT0Arf7vCK/1ALCV6ACUK33ONLdvizgerAfoAb1Jn5WlFlYEqb5tsQA
	Ssoos64fp/oIRmSv8fvEt7ZdFaNnXyJPL5Gck8ICD7PEuoJfsbqm+TeGkZt1iGajQfwbSYE1AxC
	/VjDo=
X-Google-Smtp-Source: AGHT+IFhkWZTruVv1KVnkMn6Da0iRScGHxJI2FkysYx9T/xa/YLkWepHynbGqxvTul+SYZGDVHSdqg==
X-Received: by 2002:a05:600c:528d:b0:46f:b32e:5094 with SMTP id 5b1f17b1804b1-4775ce15009mr86580575e9.32.1762439563549;
        Thu, 06 Nov 2025 06:32:43 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:d9de:4038:a78:acab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47763de4fb5sm18871515e9.2.2025.11.06.06.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 06:32:43 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 06 Nov 2025 15:32:30 +0100
Subject: [PATCH v6 1/8] software node: read the reference args via the
 fwnode API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-reset-gpios-swnodes-v6-1-69aa852de9e4@linaro.org>
References: <20251106-reset-gpios-swnodes-v6-0-69aa852de9e4@linaro.org>
In-Reply-To: <20251106-reset-gpios-swnodes-v6-0-69aa852de9e4@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1086;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=URxmTnl0JV1lV+vabMO/0fnz/R+E+W6aKsco0eYVKD8=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpDLGHHrzJIusI4JXnxY86OBpevmi97a7q3/R4I
 Umf7gMWwwGJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQyxhwAKCRARpy6gFHHX
 cl+XD/93nrVvksz9PnWr70SbhGfmgwHvJcgFbahMtNX8oKqiuvbH0qAXkO+xYV1xh9IoMZ4KL8H
 mvxJCSXdD5JNI8C1dm5i6r0a/axUKXfKcEllT8+c0UGUlT35eYKBJLMcLbheYjgXg1PPrpCQa97
 G0D2xZdabvf63tZYnAAF6ZyNJgj9NGw8Pzw5EdjyuC+WlkUd3nGaUaDRzvUDqxlRetUDxb15BIi
 x+6EQ9f83hQiCQyh6ncnfI+sovqPGh95CsqAjqh7JogOLDxmZL9NZ1LvQOYoZQR2r3vVqJMYNdJ
 F0ZHQssIGCk4bsMuTTWsxwC6qPApfN5fTtiWIVVRlSdPnngrNxDKxmcLZ6mSbSMLBMoAEGsg9ux
 4c1cvlYSH//FESEp+uPH4D/FQvEEvA+x+3eJVm1+t1tYQvTnYBVpKsOOFWCn4FwI4HdixLKNOTR
 sn/NjPEReJx2nWxkOkmCLr4SRasxW5cN/IgceNZyTSxb5f2y2CGxVVuZTMtSvaeVBuVKTW7jepg
 wQM+cLOOxWsc6e8LkUCErcndyd8huuy9udHr7vn3hTAHttej+RQn07Q8uxdpb9ak8RGNwaFDjOF
 235qrtmZoQqsj/7j4b0rsAiWKC3SCcqCGTZ70Zd6GI1phbcKeKbKcYh5tzmcCx49rdBZOv6fSsn
 JX7Wk07CWN3FZ3g==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Once we allow software nodes to reference all kinds of firmware nodes,
the refnode here will no longer necessarily be a software node so read
its proprties going through its fwnode implementation.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/base/swnode.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index be1e9e61a7bf4d1301a3e109628517cfd9214704..016a6fd12864f2c81d4dfb021957f0c4efce4011 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -540,9 +540,7 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 		return -ENOENT;
 
 	if (nargs_prop) {
-		error = property_entry_read_int_array(ref->node->properties,
-						      nargs_prop, sizeof(u32),
-						      &nargs_prop_val, 1);
+		error = fwnode_property_read_u32(refnode, nargs_prop, &nargs_prop_val);
 		if (error)
 			return error;
 

-- 
2.51.0


