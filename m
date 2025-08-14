Return-Path: <linux-kernel+bounces-769476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3DAB26F37
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 20:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0B5B188CEAD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC82523957D;
	Thu, 14 Aug 2025 18:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kxGgJ7U4"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7628C23506A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 18:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755197104; cv=none; b=KLqE9lCfPitfX3f+rxn2SrzrTYlLi9q82LRPlCMZ4AaEZBoTzc7N5kRr7jgIGE1wRVnEZziWN1m/scHvG5YkWFQBiRw7DYnNHb4k+Rs/jI/E2gsxR9BhyYWyYaBqPxdvDbyWV2HLKGsfZI0hB2+kAHd7DJYrtH00NViXj/fFXMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755197104; c=relaxed/simple;
	bh=9P7e+IQ8LG/P0atlVUdJXVTqMbr9yIy6QOCAwSCjxNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lBU7ZP+WhK42DDM59XeVfeoqza8YpRHgIZdowYM8LlkMLLbrTTdlKvo4DmBnomWtXG9vxMsAvNjSBJgoENCKya+5ugrTLJHtO5r7RxMe//9cpe12ZlWRmKN/YE9cdCvPEUgcwSt8FzeU5ZGhBWNj+m5WHFSmEdUk91xhh/qKGPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kxGgJ7U4; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb78e70c5so206276566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 11:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755197101; x=1755801901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1qBBuA2TErOLVDapmymnO1MTH+fFI4U6eOj26qi4Hg4=;
        b=kxGgJ7U4NZahHQtCS/xFQBx93AovK6nZv0nTBWdy77a/YaTJCTVHNzrh2l0yezIhVN
         9tGaqBR0srImFJMn3HLp9u5VkmWEBExFJpcuboqXv69JzGq6zvyYgHATKTTFHPWQXBXc
         Yc2Yx3IzKiec4Ca/WIEAi7HV0izvTdkSDhrp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755197101; x=1755801901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1qBBuA2TErOLVDapmymnO1MTH+fFI4U6eOj26qi4Hg4=;
        b=KCn6p2O8sRllfEJfUMGH9YQXDfmBQ5sFRGwAL646aOyJcLckFPwxHvtbKzwZkFIRiw
         M7Ekp1S08bSk0HTwfYM+YiOrLnNA6IKFcB1QhDkZqmGFea1hMqMqP+LDVxGgp178gsSU
         WyeTS8Xq7JE48cM1TL+mDpeh1lFHshu8kq8sGTmGCHiJ0wJNGM4CE+mxn1POYpSJUHMN
         n73RZTdZpsFr9xU2kBUrIFygp8rkc+gHwQvih/Mo2vgH3VqdlBTEO0fOTQFCaCVF+cD7
         /N0kXudF6ufPpo1qQXCxrAMk1flfYSEsFkASNZg2YluXx5Bznj9jvTbuwxbVP3esagZX
         VUtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaL+P6EASODl4YB3hgi4uEUdIa665GbrdYwiBDQN6TdOjaBY3+HMgrVK3ftcQH47HcY/5Nx8gh1oMcXL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlhvzpSyAUU6W3eZpkyI3W5zAANrq0qpmZl4RT4UxdWS0PLGoB
	HKISEg7LfHofAr/hRFrTQxza3vnnUEANpKIDDCvOMpbfNYninAr3sXmy1DdA0N57fg==
X-Gm-Gg: ASbGncuFWAsyQ9yMfUqdG0P92AoFkYXFOf9fGaxXegpCpiuVuws5bGxR2tPNhWwG0YX
	0VrFcXj71nbdPcdT7c5l9QnciNlzP6MHDYypkfasRULSiN0zmo/o0dVHOA58kVDdtK+BrhnBu9t
	5XRxhZycgQf1AEvX8cHUQ5p2DeE4P0+cLsHVlrk+jkL/YAOvxxTJRSHp7md4szFCHvgbG03PLjK
	CbOYhMtTBBxpyxDP1wqSjCxINrYaC/e4ZApOZT9suOTB7+HGLEBj0NYQKe7gSI8qDF3MU2/yLO0
	CKZgr9QByWPFa9JRVG7/h20RY4qkdAbqTJgDWahXzLvSjlI+zO4FRLKarASVEGJvzH+sluyyom1
	4sRySs3N+4rgB3ftJAYoFxei60EzXn/VdMr7D+mVwb6MQei4MAuj7ZMdFnmmFn/fO+3z31TMNRu
	mzw602jc4AeBAqewQWPzrMUcQ=
X-Google-Smtp-Source: AGHT+IHefuGAAIAMEMqANOVYlKEH5+LAdTor4fxHNBiEz6a78unbBVFdrI8XeGRL3W3ATolBgKIenA==
X-Received: by 2002:a17:907:1b0e:b0:af9:6f04:8dd0 with SMTP id a640c23a62f3a-afcb992ca27mr396658866b.55.1755197100634;
        Thu, 14 Aug 2025 11:45:00 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (37.247.91.34.bc.googleusercontent.com. [34.91.247.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c0f4sm2614772466b.106.2025.08.14.11.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 11:45:00 -0700 (PDT)
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
Subject: [PATCH v1 0/5] USB Type-C alternate mode priorities
Date: Thu, 14 Aug 2025 18:44:50 +0000
Message-ID: <20250814184455.723170-1-akuchynski@chromium.org>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
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

Andrei Kuchynski (5):
  usb: typec: Add alt_mode_override field to port property
  platform/chrome: cros_ec_typec: Set alt_mode_override flag
  usb: typec: ucsi: Set alt_mode_override flag
  usb: typec: Implement alternate mode priority handling
  usb: typec: Expose alternate mode priority via sysfs

 Documentation/ABI/testing/sysfs-class-typec |  12 ++
 drivers/platform/chrome/cros_ec_typec.c     |   1 +
 drivers/usb/typec/Makefile                  |   2 +-
 drivers/usb/typec/class.c                   |  61 +++++++++-
 drivers/usb/typec/class.h                   |   3 +
 drivers/usb/typec/mode_selection.c          | 127 ++++++++++++++++++++
 drivers/usb/typec/mode_selection.h          |   8 ++
 drivers/usb/typec/ucsi/ucsi.c               |   2 +
 include/linux/usb/typec.h                   |   1 +
 include/linux/usb/typec_altmode.h           |   9 ++
 10 files changed, 221 insertions(+), 5 deletions(-)
 create mode 100644 drivers/usb/typec/mode_selection.c
 create mode 100644 drivers/usb/typec/mode_selection.h

-- 
2.51.0.rc0.215.g125493bb4a-goog


