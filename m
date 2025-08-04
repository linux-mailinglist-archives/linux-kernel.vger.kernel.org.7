Return-Path: <linux-kernel+bounces-754897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 150C8B19E2E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 11:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 248F51797DA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 09:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65968243370;
	Mon,  4 Aug 2025 09:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QWZVy0QX"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321142417D4
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 09:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754298244; cv=none; b=JbG38UuXa1sfjOQWp2+BDr+5/24L8KMQEImTtKlZCl4tOwYErd/cflemF+7+MlYxEDFYGlb4XMHEp/OUWtE1vvTE9an3BranA92V8hotb01vSYMZXQx2HA6P1SYMJ6h8aYZq7GxGLJUjZwl4OOq6iH/0WElIizXx9Z1u7bTdrcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754298244; c=relaxed/simple;
	bh=CdRSPzRZhrLXv9SkH2yFf0/+V2Tpe2TdwnPx5t3lia0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jmls0bF7bVVTBFmkkVlmfsGdVJwpyZBTkG2Zv8V+JCe3IZZwKDbZNW5ft3YmSMvGLz2e4yitDUSgweQCcOhYsj5GPP6DkvWVE4QbriTIQdLAX9ccDfN/TvYne30oeg8S4cRtyqp7lq7wrVOlDlGL32O90m+aNGEceMCW7hOf8I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QWZVy0QX; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61589705b08so9041998a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 02:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754298240; x=1754903040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VgC/fq0UWX7rdpZAzk3F1oBkRyQKH7WIGoqghZqLQ0U=;
        b=QWZVy0QXf1r+VWGu1uhuVo0G8RtoRz52NqonTThBjTkrmCYAWxTIj055AzCH73yuPY
         pBpcQUgXT/XG4Dr9LzBIrP3TwnfM4LQBhDVTtrD9u/o/TVfvdv8ybUlJTlu5NaVTj0EG
         4zybFr96K/h82g4QL+iaZv8VyPuTJd/f8F71c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754298240; x=1754903040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VgC/fq0UWX7rdpZAzk3F1oBkRyQKH7WIGoqghZqLQ0U=;
        b=GteVBv1bjBoilSmkj34+4R3Qe4xUtIS53F7etFU1m89gS/tR1cTiSrRNBLbC5XvTrj
         jbrwTQLgpxriva8WEo6g4p2Euul+wY3TKrh5+OEmEql+3iBFu9YCCZw4xt2M9dOI6cZQ
         2NCwnSs7tJdjky1j3a1HQN9pEffZ8M4rT43Kfx1tnwyvxwFHRMLk5fhCv/cNPrEfFmLZ
         ySyfkdWXLmGQoTUxBNMoP5EN8q5CR6ZM/2Ophbb20CvW4kjr+2+i+la78eXkP01ESe6K
         3DjmwVcX7hu8GebR43AjoeMUqcEee1LbVHOfLmw+RX34A/QgoJ2fUtQh6S528/bMGQ7F
         Lh3A==
X-Forwarded-Encrypted: i=1; AJvYcCWJ96uEK2bD898sT5IesMp5D/rc01PUfqhK3yJ6GEXnlRa+iIw+xysYqLW2RN0xzfHOBq+YFq7sKRGTG4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO7C/mnSIGwkze/yEAfloGbl6qUYysSsatAsqOC2fzCNPOtKc7
	43hVWRqGW2ckX/9dWgvmCxmoEANu2E90C2L/SZezSljxVPqAlAHMyLyDcDeyCPP9wQ==
X-Gm-Gg: ASbGncsRvpDy3fiCCXrmnk4itl5Rlwc+LzHE6Ay/K0HXJx6Y6s2Dsk58yn3JDt6vxW+
	nqe3VI30wwBsg5Ry+Tkf4Byho8Jqozrd5QasgA4qu0d68JQAzYhJv4od/OpvgKNAP4J+2nVlvdb
	6OZJolxCnuYZ1yz7wHC5Ikv/Ygvz/sipJiupuQAst5JADlw+Ej0XeBbe1zjNvTd2ti+ccLpqfKk
	R42gsUcR36vV9uJ24/iL3JHQ9UWiaqAZueJrh6tE1pOKD0dL4FcaZ+xYXvqMN13mzcN6xLtZGbj
	4QsAOZ9bbt8ZBtpI/aZDX/r5P0QiYHCiPtIcUx62r49cnYDLlEZGEWF62j/0Xx5MtDrsl8JSDZ6
	pMoSXnKFS6RfxcyIfosGyp8pmRHx0Y94sceGxEY1WAt9zT6lz4amBfi+Rr+Ja/khphCCa+guIWU
	+S/XOuBNzznxer4LNkiDh/F+35QQ==
X-Google-Smtp-Source: AGHT+IEWZlH6viZQ6slELtEy7DIQ1R5yHsUK/PokBkKf2bvVo1I7/RrcEV59t0yajt4CFWb2bWNEBw==
X-Received: by 2002:a05:6402:1ec8:b0:617:4a59:c5da with SMTP id 4fb4d7f45d1cf-6174a59c6bbmr3476589a12.23.1754298240446;
        Mon, 04 Aug 2025 02:04:00 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (150.230.32.34.bc.googleusercontent.com. [34.32.230.150])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8fe7995sm6412790a12.36.2025.08.04.02.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 02:03:59 -0700 (PDT)
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
Subject: [PATCH v3 00/10] USB Type-C mode selection
Date: Mon,  4 Aug 2025 09:03:29 +0000
Message-ID: <20250804090340.3062182-1-akuchynski@chromium.org>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces a flexible mechanism for USB Type-C mode
selection, enabling into USB4 mode, Thunderbolt alternate mode, or
DisplayPort alternate mode.

New sysfs attributes are exposed to provide user control over mode
selection:
`priority`, `usb4_priority`: Allows users to define their preferred order
for attempting mode entry.
`mode_priorities`: Lists the modes supported by the port, ordered by
priority.
`mode_selection`: Lists modes supported by the partner and triggers an
automatic mode negotiation.
`entry_result`, `usb4_entry_result`: Reports the status of the last mode
selection attempt.

The mode selection logic attempts to enter prioritized modes sequentially.
A mode is considered successfully negotiated only when its alternate mode
driver explicitly reports a positive status. Alternate mode drivers are
required to report their mode entry status (either successful or failed).
If the driver does not report its status within a defined timeout period,
the system automatically proceeds to attempt entry into the next preferred
mode.

This series was tested on a ChromeOS Brya device running kernel 6.6, and on
an Android OS device with kernel 6.16.

Changes in v3:
- The mode_priorities sysfs attribute has been made read-only.
- The mode_selection attribute now exclusively lists partner-supported
modes, with mode entry results reported via separate attributes.
- The driver returns mode entry results instead of error codes.
- Constant values are used in place of module parameters.

Andrei Kuchynski (10):
  usb: typec: Add alt_mode_override field to port property
  platform/chrome: cros_ec_typec: Set alt_mode_override flag
  usb: typec: ucsi: Set alt_mode_override flag
  usb: typec: Expose mode priorities via sysfs
  usb: typec: Implement automated mode selection
  usb: typec: Report altmode entry status via callback
  usb: typec: ucsi: displayport: Propagate DP altmode entry result
  platform/chrome: cros_ec_typec: Propagate altmode entry result
  platform/chrome: cros_ec_typec: Report USB4 entry status via callback
  platform/chrome: cros_ec_typec: Add default_usb_mode_set support

 Documentation/ABI/testing/sysfs-class-typec  |  72 +++
 drivers/platform/chrome/cros_ec_typec.c      |  17 +
 drivers/platform/chrome/cros_typec_altmode.c |  32 +-
 drivers/platform/chrome/cros_typec_altmode.h |   6 +
 drivers/usb/typec/Makefile                   |   2 +-
 drivers/usb/typec/altmodes/displayport.c     |  17 +-
 drivers/usb/typec/altmodes/thunderbolt.c     |   8 +
 drivers/usb/typec/class.c                    | 212 ++++++-
 drivers/usb/typec/class.h                    |  15 +
 drivers/usb/typec/mode_selection.c           | 575 +++++++++++++++++++
 drivers/usb/typec/mode_selection.h           |  54 ++
 drivers/usb/typec/ucsi/displayport.c         |  10 +-
 drivers/usb/typec/ucsi/ucsi.c                |   2 +
 include/linux/usb/pd_vdo.h                   |   2 +
 include/linux/usb/typec.h                    |   1 +
 include/linux/usb/typec_altmode.h            |  12 +
 include/linux/usb/typec_dp.h                 |   2 +
 include/linux/usb/typec_tbt.h                |   3 +
 18 files changed, 1024 insertions(+), 18 deletions(-)
 create mode 100644 drivers/usb/typec/mode_selection.c
 create mode 100644 drivers/usb/typec/mode_selection.h

-- 
2.50.1.565.gc32cd1483b-goog


