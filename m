Return-Path: <linux-kernel+bounces-785022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48135B344D3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CF847A3757
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6492FD1BF;
	Mon, 25 Aug 2025 14:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ATS9n6QI"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFB72FF155
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133883; cv=none; b=l3qrkBBRHuQBXIBnvTNs5lpyWZltA5e3qxOyRnC5zREc+aAxRPreofMD9yaFGbnalLsIrJQ2Tca08KFY9KZtgO2Ajg9fhEB3ToNtmsQhjxjWz0ogbI2r5OuQ9L7V/HgSrg8+olN5AyPwRbsOy9CalDhayOoUQ4l9MoeU2RlfIJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133883; c=relaxed/simple;
	bh=oUpwIKailPzvywGQy1+pcev8O18sL6J2IAoIiRpAS9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FBSzzOOn2MVB7tOnmXoVq0tiEKMGavmfQKgMB5MV0bhZ6Hl5KAcDAF7+gAl9Y/bhls8dVSoaflVUiJ2DSesMMx6L0IJFmnWlyB75x6BfD8vHSe4hN8ykGcUb6JDzfV7XDXVQ3Sc/L/MlHkTUoxKkhpV5VpdmNHm/iecwpdmee54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ATS9n6QI; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afcb78d5e74so863165166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756133879; x=1756738679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JlAw1YUtoUP+479H9eosmlH+nUKupTZr0DxeKyHdVeQ=;
        b=ATS9n6QIB37hoWaYOrACfe/JViX6ykap8Yqu1g+7mzuY4vPs6K6lZ7OPDqexRkX+Ia
         KXz2x36+jV22K825inyNY0+cK4ERzJUiZgwK9b0UOiMMIjbocFWj2gDTpHRJfE08ipYx
         Uw+Px/gRWLJghHxt+YIj1piWFtgsH18B2cF/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756133879; x=1756738679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JlAw1YUtoUP+479H9eosmlH+nUKupTZr0DxeKyHdVeQ=;
        b=pdtw0NUs1xboSCBqMScJeNSrqVXtrJSQcDzriLrYv5XhyqpJ/HPQ/bpG5HUvL/2Ext
         y6iqfiSxc+uCRGIs8ARm6nz7/RBEj9Kni8MEV1TUF4VsmWmDfwowopVPOaDUXj7EVWtZ
         QmOxK5jJ5tqpyoZiAWuwhDSegWa10km/jM9BhPAcklDKGd5sxeIVq8IaLlAmFibAbns6
         OGE2/VHH3aqjyt2XYHc5cGSUJsRIr4+PDnsMOOs265jqAVKY6/g+3reUe82xuN7itouk
         WiziyJmv7wXigW4gmXi5abH0vEMM6hwPSnNL7M/peu/RHReN27ENlIOdQJxZmlXiE1WR
         wc1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXbZE2oqeRDEOOWPsP2q1O+e+BqjRWVXZMMUz+2ENQfa1dfy69sxnOpllrCFre0lZQZV3QaWuf48qwdee4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIiVu6cKN3OkOjLmsZxkHr5cEbQ9dK9gcLmY1mdpMk+Q7pYuyk
	rJdGBqAg5q2o6SYRSB5Lo1g4G+jizXHuP1DZTJGZXvGBhqrqDL9VoezrtLuPuwbjSg==
X-Gm-Gg: ASbGnctgCKww0UFDeQ0azj1m/cYf6PW5rFA6oKJ5uvQ53sb3F0yEjiPWdCpZuoUdgBI
	b+ln2iPtTDmEeYioFqIW1W8cC4g5DIWTa7UEHLg0RmdSJoBjcd0DPyvyl57ytbEDMuRUjnhinxk
	zFEz17/IrNrYt8jWVN9IfguycelrKCwut2CDkuife8VbidTnOFCmVqGa3M7j9ci1i94Veo+DqrL
	9aUqQnG5I5ZBkeCM97oLmfYk876XDyAwWnejgK1RhrFsADCWjVlS8LvMlpG4oD5yxnArkdOl58t
	u6zO9I2QGVQh62i690UZj2zA+fHHa9z3eeJyXeBArtVPmJ6dSQooJPqCWSnsSSDUnP3L7jpakv7
	ercZbfAY6KhA10tYk9IRfwRaSq6PK94mGoaZAOC9tE0Jqt/1IJKbttc+1Ku1Pn/haJQMk5FePVx
	pnoyihcih6goM5
X-Google-Smtp-Source: AGHT+IH4w3C3vXXmPRoJuMQE6RNKQ6r79mYIPhLpoSiofHkFSKhUxFwChIxE4MrLgFEz7TLiFmk4ug==
X-Received: by 2002:a17:907:7f0c:b0:ae0:d8f2:9065 with SMTP id a640c23a62f3a-afe294d99bfmr1196751766b.39.1756133879320;
        Mon, 25 Aug 2025 07:57:59 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (168.23.91.34.bc.googleusercontent.com. [34.91.23.168])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe8d03f981sm117294166b.60.2025.08.25.07.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 07:57:58 -0700 (PDT)
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
Subject: [PATCH v2 0/5] USB Type-C alternate mode priorities
Date: Mon, 25 Aug 2025 14:57:45 +0000
Message-ID: <20250825145750.58820-1-akuchynski@chromium.org>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
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

Changes in v2:
- The priority variable is now a member of the typec_altmode struct
- typec_altmode2port is used to obtain the typec_port struct pointer
- Default priorities are now set based on the order of registration
- The mode_control capability is enabled by default
- The mode_selection_state struct will be introduced in a separate series
- svid will be used instead of the typec_mode_type enum

Andrei Kuchynski (5):
  usb: typec: Add alt_mode_override field to port property
  platform/chrome: cros_ec_typec: Set alt_mode_override flag
  usb: typec: ucsi: Set alt_mode_override flag
  usb: typec: Implement alternate mode priority handling
  usb: typec: Expose alternate mode priority via sysfs

 Documentation/ABI/testing/sysfs-class-typec | 11 ++++++
 drivers/platform/chrome/cros_ec_typec.c     |  1 +
 drivers/usb/typec/Makefile                  |  2 +-
 drivers/usb/typec/class.c                   | 41 +++++++++++++++++++--
 drivers/usb/typec/class.h                   |  2 +
 drivers/usb/typec/mode_selection.c          | 38 +++++++++++++++++++
 drivers/usb/typec/mode_selection.h          |  6 +++
 drivers/usb/typec/ucsi/ucsi.c               |  2 +
 include/linux/usb/typec.h                   |  1 +
 include/linux/usb/typec_altmode.h           |  1 +
 10 files changed, 100 insertions(+), 5 deletions(-)
 create mode 100644 drivers/usb/typec/mode_selection.c
 create mode 100644 drivers/usb/typec/mode_selection.h

-- 
2.51.0.rc2.233.g662b1ed5c5-goog


