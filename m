Return-Path: <linux-kernel+bounces-813289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 966DAB5432A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 531FB561555
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 06:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AAB29992E;
	Fri, 12 Sep 2025 06:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V5fzUMxt"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9376428C87D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 06:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757659680; cv=none; b=osbZpbMSRmf+X81YDlzimM/eUA2eocarxnoKI+qhuXancT9XFwEECqWQfMM0SuttqROiKy80QwbYM7RT3VFjqkV/Y+Q8qo/7FVJ7y2lCXkxCGxzt+umhnrb9eNFgVgtWMqnvK10h+Pe5jHUki1kXyzLgiuYoJV+JPqWS6cyH8Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757659680; c=relaxed/simple;
	bh=LV7vwXyBrLIZBgstDxs5zq4DLuMoG96MyweJz0IMeMA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WvWJoao3C4wGmu6SGGOGBwP/R2Pbiq1K5vBU8NaaIElIXjieS1pUOBwWu9IMcy4o1U8XjQaOhjHPdoOZZeFmpEHlZhqL1St/JDh5wjLhsny/aKVEBMS9QIytvJrk0kZNZZrnaIHDtIpyw2iT75KJpq1eUodDV31WktqXbqKWu7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=V5fzUMxt; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-62ee438dc1bso322538a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 23:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757659677; x=1758264477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TG8DSB2/f+S8lGYTIHFJItZooYK8UItQSp8Clzf2WH8=;
        b=V5fzUMxtfBVvA6djGWwJwJCA/UHRSfRddDuFaWZy6C3e6hyCdETakTZfh9StwKPcVi
         GB3ECUCuzidF5jWpFQYcfqoMpThGJy/yxkVJgbZqABWMHc5cT2kvXtkJKh/y+12mFEmq
         kOL1ddTpsm89fkOzmUeOuY8JOETM1mpEUzfvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757659677; x=1758264477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TG8DSB2/f+S8lGYTIHFJItZooYK8UItQSp8Clzf2WH8=;
        b=lyzgon7sZt2YxGNy7UtJjAOZ+cihulUaP+f/3P6u/Klr7lsMQGoOn1f5cA2lDA8Gwo
         0oaHLmT3FASeQ6sit4c5al4A7wvCojSzPUCt3sLfO0GVyKun25fNWslUM4XfANmmwiCn
         8ZL3iBf1SmPAwJZSIctWXjTKEkcEpVfSueAGgIcfy0ETdn9wBYqfLQ1kKsfyZ5B58KRg
         l7NpTDgUvlk4wUAQPTBOWM2K4cWPucXhCG0m1l1DKG77ytoDVd106ioFU7EDzkwr+p7n
         zCg+2VlRM1FGK9oBXjERXt+iuUq3Bnt5V96bS8MIJhy0BElyw+DACD6d23FHFCmy4p2K
         AW7A==
X-Forwarded-Encrypted: i=1; AJvYcCWhF7q9maUSrLgTaRUkv9qB+rEqz3jPuG8tUUimTKgm5lotXaux9gCo88JKU7HrQ+PlRG67SIamScqP+CE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy97hm1e9/PdoDeqGVB8nufskvFbQE6RuF4gYlH8gBL7j1G059K
	vyr22oVeVg+E/hAygziHMhKbM4UWE5nuf4iesYswNyYifObsXMz3EnOCimW2tR9m6gZ8ztIdHRX
	83rc=
X-Gm-Gg: ASbGncv04t4FBIuVdxXYsDxk/WqtoUfZcM+AxDiVRAWwT7YP5QACuG884gz6MDJmEYz
	OAgTA/q4c7Qny38qEN4k/b92HyVrW2EUo0d8fLDT6f1pauHTGPPHSOYU/gQ6tadkST9KBoRwfEK
	uAwN2FBuGnZldcDiMklX1oA5xwk/vTW5oG52TKLEzDSHMtlByBe+4S2y1wWP06zidl8KJJ+D0Fs
	2YG/I1tTMRogz6dhEG7CbRFSO3NRyEy7FTSKecKE1s1GO54XuULorEK4fDQCBuJRaic8BI5hcwf
	2jb8ZoN43Qe+kIk6KS0FBsE3XkbTsREX9dMYWaPX5L34EzlSRnIJ5ynb9eXchGbuPhRhOQSVgV1
	4qm4jNqcPt1s+a+hernB22GNs1azUEjuc+oQ0jcRwLnKWN7Q/OhXjO+vSg0t3XuZQlXmjf+JSGf
	swWEvfrdLbVKwd2+pCJFVv+GhNDw==
X-Google-Smtp-Source: AGHT+IHAsNuWRWXVS8F39M4Ez7vI9awJWnYUKY3l+nueilNqWU85goauwFdZbCUk64fIqas7l1J5Aw==
X-Received: by 2002:a17:907:96a4:b0:b04:25e6:2dc2 with SMTP id a640c23a62f3a-b07c254393cmr187747966b.22.1757659676933;
        Thu, 11 Sep 2025 23:47:56 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (240.225.32.34.bc.googleusercontent.com. [34.32.225.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b3128a1esm295465366b.29.2025.09.11.23.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 23:47:56 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	Andrei Kuchynski <akuchynski@chromium.org>
Subject: [PATCH v4 0/4] USB Type-C alternate mode priorities
Date: Fri, 12 Sep 2025 06:47:47 +0000
Message-ID: <20250912064751.1987850-1-akuchynski@chromium.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces a mechanism for setting USB Type-C alternate
mode priorities. It allows the user to specify their preferred order for
mode selection, such as USB4, Thunderbolt, or DisplayPort.

A new sysfs attribute named 'priority' is exposed to provide user-space
control over the mode selection process.

This series was tested on a Android OS device running kernel 6.16.

Changes in v4:
- replaced sprintf with sysfs_emit
- changed priority to u8
- added an overflow check to typec_mode_set_priority(), now returning
-EOVERFLOW on failure

Andrei Kuchynski (4):
  usb: typec: Add mode_control field to port property
  platform/chrome: cros_ec_typec: Set no_mode_control flag
  usb: typec: Implement alternate mode priority handling
  usb: typec: Expose alternate mode priority via sysfs

 Documentation/ABI/testing/sysfs-class-typec | 11 ++++
 drivers/platform/chrome/cros_ec_typec.c     |  1 +
 drivers/usb/typec/Makefile                  |  2 +-
 drivers/usb/typec/class.c                   | 46 +++++++++++++--
 drivers/usb/typec/class.h                   |  1 +
 drivers/usb/typec/mode_selection.c          | 62 +++++++++++++++++++++
 drivers/usb/typec/mode_selection.h          |  5 ++
 include/linux/usb/typec.h                   |  2 +
 include/linux/usb/typec_altmode.h           |  1 +
 9 files changed, 126 insertions(+), 5 deletions(-)
 create mode 100644 drivers/usb/typec/mode_selection.c
 create mode 100644 drivers/usb/typec/mode_selection.h

-- 
2.51.0.384.g4c02a37b29-goog


