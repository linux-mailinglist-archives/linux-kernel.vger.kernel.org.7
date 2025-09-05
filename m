Return-Path: <linux-kernel+bounces-803074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E496B45A3A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26DD017BA0F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7CF36CE0C;
	Fri,  5 Sep 2025 14:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FZfJVvqE"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9219936CDE8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 14:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757082136; cv=none; b=sIBA0wjXs1RhX4Fh3G7E6xl/sqRADbC2MJNwY5hayibxd8qfFHPSCTaMFHneXNnlSTthcxExWh3OaHStNDdRGCJl7vWqW+vhO5O0mmjgMsq3oezXBU2mQnmYluk9jVHV4/25uYwGGL3zkNpZDWujoJoeu2cOBoMAyZJp8KUsj3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757082136; c=relaxed/simple;
	bh=dQJtx4Q2JUyqNMwcbEs3oXSjlN1XB+uw8hAQFiczs/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GA3gX5xJNtSfYQ2T95crE6LRYSVFcXGHFD8lcEh/krya0BCqAtxy99UHOh0ykUTJhsLsRleKDyiwwEI0I3+w+jNivv91o6c0jQZqUeS4GMYcwNRl2vh7KWf44JvVGFfg/Br1u7en4KkIlKC1bQcki4oy1UBo8HTSdRkhmdjHJs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FZfJVvqE; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b0428b537e5so383107766b.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 07:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757082133; x=1757686933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nGF9orEjre2K9KjUIRS6u93YNSWcj3hSYdLRvughM9A=;
        b=FZfJVvqEHLumcOHI2CZokbKuyUXgC6N1tVrnSgRtbbzbi0P9h0Sive5rRg7nW0IfSX
         mJcOIx3j0sLfizrklE6VcD7JB1NDD3uLPhRMJnQ544yQaALrwySMdIS6j92GZZDyuCTA
         RItizXH88p+pK0lQmBWkh5bLEMSKd/RWDzM5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757082133; x=1757686933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nGF9orEjre2K9KjUIRS6u93YNSWcj3hSYdLRvughM9A=;
        b=TA9L8ewHvFmPWE65n/ib3cA23txrwTpM/3rRl/4euI4OA4yIOdoHnKDkkQjWe/IMhw
         +lQM49iDlwiUP4ePyku3HpNGKSjn9qqvhy6542QNSp77Nh8FEU7zk22ttagIux7fskrV
         LclpP4cR3Q4LEuIPRz8x9D2xvt0Mmea/APcm0xF+pwO75WX6SUOHO1ojHbZUyyP4NE+N
         6naDQHREhHEfTrnlMRfjMYOeX81+2Pgam2KHISniM9S5AiS8bIjA58MJ/yuipc7Ld014
         PsrNAHmQ6DezlUe0a6TkrWWarY+EHqW7kiAeDhpkkE8Tb5unA62zBi+QMlgR38IwqB1I
         S1xw==
X-Forwarded-Encrypted: i=1; AJvYcCVkR77ANDifK2lZ/wgfNlhL3t8OkpxwoM2Rsb4Ik+uHIx/5qa9lIuJ4HOr7rPGvYgm35YraUJm68sbLrsY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycc6QI0OGed8lv2HyZDgk2hSxR6R9mB9lGQIBUB/2NHl9idkor
	1TsCWY4idjSZ6vP6lOb42wDShDgUcTfiZry7wP0iXDSh302LNxJMDniEqR9SOmE98A==
X-Gm-Gg: ASbGncsrdwIFqU5yTEw8uol0I4+DLDnM0X+Lo6e0n4OfWCF8zkv5S9WEFfibmNWEWDA
	7VE0+pkMI4dB3g1zgjLm3gbSgaP34gy6hu0Ugd/Et2h6NUt6O7a8+KyNeqX6nSsz1WO87Ud3Dlh
	fFNpgzHH9CF4q0f+xjei7/YxIsJYn+f++c56j7XVqd9wpYhUHWux7Z/ge2z9njY7PLtgVfxEqIN
	4RzgYtXgtvWmfswbeXEex7N9n2pX4qkdROfFh75rlAttSVzEjXHdTl0vtyqk6xm9sP7q8hNMUWO
	yjHZW+7dh1b5oGg3rtB0Ze3waRlt0b4Z+pTT96wi1cVkKcJfCF5iVIr5rbabjCALD2OOEBzXT68
	H+IQXpnsE2GI3eyjKJXOAUPypbNKMgt/01DQjZb7R+FXJ3BjcB8ZUfsxVs5W2zWgQ/y4PAZkBSi
	8fPh+DLB0p0r1faQ4=
X-Google-Smtp-Source: AGHT+IFl2mgGV4P7dgOmJwsBFf/zdptfBe4eibQa6wFZqzQSCjDkYJsW2x4P8b1GwYro1fca0TgUXA==
X-Received: by 2002:a17:907:3f21:b0:b04:76b5:739f with SMTP id a640c23a62f3a-b0476b57484mr827180166b.23.1757082131682;
        Fri, 05 Sep 2025 07:22:11 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (240.225.32.34.bc.googleusercontent.com. [34.32.225.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0476e0d61esm502141066b.53.2025.09.05.07.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 07:22:11 -0700 (PDT)
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
Subject: [PATCH v3 0/5] USB Type-C alternate mode priorities
Date: Fri,  5 Sep 2025 14:22:01 +0000
Message-ID: <20250905142206.4105351-1-akuchynski@chromium.org>
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
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

Changes in v3:
- minor changes related to code style and documentation

Andrei Kuchynski (5):
  usb: typec: Add mode_control field to port property
  platform/chrome: cros_ec_typec: Set no_mode_control flag
  usb: typec: ucsi: Set no_mode_control flag
  usb: typec: Implement alternate mode priority handling
  usb: typec: Expose alternate mode priority via sysfs

 Documentation/ABI/testing/sysfs-class-typec | 11 ++++++
 drivers/platform/chrome/cros_ec_typec.c     |  1 +
 drivers/usb/typec/Makefile                  |  2 +-
 drivers/usb/typec/class.c                   | 41 +++++++++++++++++++--
 drivers/usb/typec/class.h                   |  2 +
 drivers/usb/typec/mode_selection.c          | 38 +++++++++++++++++++
 drivers/usb/typec/mode_selection.h          |  6 +++
 drivers/usb/typec/ucsi/ucsi.c               |  1 +
 include/linux/usb/typec.h                   |  2 +
 include/linux/usb/typec_altmode.h           |  1 +
 10 files changed, 100 insertions(+), 5 deletions(-)
 create mode 100644 drivers/usb/typec/mode_selection.c
 create mode 100644 drivers/usb/typec/mode_selection.h

-- 
2.51.0.355.g5224444f11-goog


