Return-Path: <linux-kernel+bounces-857906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F58BE83D2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A1486EA32C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8269321457;
	Fri, 17 Oct 2025 10:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQvPPquH"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BDA328B7C
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760698697; cv=none; b=ME1GByKEjuI0KXuyb800/ZLNudM3ThrfZgDgP3vxNCg4TAHVZUblUQFhL0OM1PG89HKm3GEDWxvmxMh6iFqde8bBVvKouC6M1EDFYdLfIhAJcJ+4F7LX2Hekgq++2EuVhplCPPGZ5wGbDvGvu7fciaAmOFl9rrqj4kx3rDZLVfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760698697; c=relaxed/simple;
	bh=jYLh1g0/g+YswT19wb8sGFf9meznkL5gtg/UsZXCKQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RFoYWV52xtnvJBb6CpQhzbyKcyfTeh1nF5HsOcXIA5m+BlmIvEaG+1sE4sfIigSP/LWCriRbhdQamKxghOvxRFejJyboA/JhrwG2K9zd8JTv+ZJnnUIP6O2BPNWVmHC/e6I8pqX5vGhRUpsD4VVCUG5FcqdVXdXbq0hCgEzJ6hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQvPPquH; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-781001e3846so1723536b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 03:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760698694; x=1761303494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5eRznc/oLGLRRb/vl90nQzjbWZjbdpkXCZdSvk3IxGA=;
        b=MQvPPquHetcTsZXKOgOgZDvfn79VR8+oaoGUGlKshsGPSw+HpHSISnRIX4ZDFVepA7
         EFrntiYNqWRunGfdlRio+/Li7+gKOKWqffi2kG6QTBMFCQ3k4TMRpQEaZ5kvGBQMt5BR
         brWXNiCNT9eq5sLI59Ta+1mHAAIbfnCf8g7GQL0e9vJqMwC77/RLW8eX7Qrp7mEql4kV
         gMG851XdJPB9bSpBZgH5UQhWL3gTnkSHrZ/dehhQDTk9Vnm/Lwu9tj5CBcXXk+5Wgf3z
         ujDGbxLwnI5JXSgdaFBD323fQ16o8vgX3RijRoWMAq8d/uFKj+NSU40tigU3Jx+jgLHn
         I8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760698694; x=1761303494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5eRznc/oLGLRRb/vl90nQzjbWZjbdpkXCZdSvk3IxGA=;
        b=XNMHAzAWhbXiDnfSfI256cUsmeCfd9jhkJxjZ6+Z6GORlv4CxAI4lLhisCPh8e5wEU
         SDmTQ+eJviMz6s+PeUOhq4xZI8nf7uuPTZrsAdzQfoG9UEjj+FHc1Afl+WS5ByXXLaor
         6xQOdFTOlmDKLRs2nYkm5VRuUX85rNdJMRk64VnlXjNJL6+euyQvXJh9OPPgpeKs7XoB
         5SJElim4l+sIlr6XjsxKxVf7vZ9k8gE56HJ6SaWp2IPN4lF9PTU7ztXxzz1AOF/wsCzD
         WEO7Kcj3RDm8+BCLKb1M3wXHFm+UjIcKo8W6uqfwlQqHsTajEm9qrzQ17g92geaeHn5Q
         k1BA==
X-Forwarded-Encrypted: i=1; AJvYcCWUyddcrzoroP+Mh/3hYROa2KbxyrCiaAWbOaTDjGKo0OR/lbdnyo+Zn7BUw6BR98gk1SraX/Whn5hGKvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YygUDhRS49jjt17i4flMcAQXpZUE2aAbslm4oG3ErTQd5pcQxFo
	IiRfq22X/cJ4CcDMKXLeKv0cwBzuZekMUYlgPBOlKfZso2aCPz42mmhXR65zuA==
X-Gm-Gg: ASbGncuF+2zCbBzz6bXHP/aynBMa/eLJhOvsoKZnGWlMVPMnZ7dRjEn/mqtND+VDWUi
	KZ0Nxx0TKqxbhon99joEpbR0nS0mY3OvgLEPTXVBg30bBvk5u0WW4Q4NmvPhAagHHghMWIjCk8m
	W64cM4maEIMlTIaRFZ5id3IFU7G1EVJ+YwzPnebbSBIh+MzGd2gRGAh9pIxVucQhv/h1vEVw42P
	BQAKJdI+05OM21uuZWNdRDaLe79k1B8wNNbK1kYqVV9ywvbak8ySxvxcDS1yBVObtZWeOGdFH1J
	quk/SLj0e5A1CQlUB39u3JP5k0+vsPChExKrt5gkOuIv70mdwa/8oSLZ9YXOGg/1UTUtK57o3wX
	yCi2koH+2x21SZvn0F8p9GOYW1vVxkWcxO7iERKjquVopvaS+R1v+3H0iHKzHI7OkuULk2ocE6A
	0jJM5bow==
X-Google-Smtp-Source: AGHT+IFqhscQ7885gKuszm90YTf0KoEGYReUi6/2alYhWRhod7rmgZECRMNtrRBswwS4tMpqwgKgtg==
X-Received: by 2002:a05:6a20:7489:b0:32b:721e:ced1 with SMTP id adf61e73a8af0-334a8617237mr4808979637.36.1760698693905;
        Fri, 17 Oct 2025 03:58:13 -0700 (PDT)
Received: from tixy.nay.do ([2405:201:8000:a149:4670:c55c:fe13:754d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b639cc8sm25407571b3a.20.2025.10.17.03.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 03:58:13 -0700 (PDT)
From: Ankan Biswas <spyjetfayed@gmail.com>
To: linux@roeck-us.net,
	corbet@lwn.net
Cc: skhan@linuxfoundation.org,
	khalid@kernel.org,
	david.hunter.linux@gmail.com,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Ankan Biswas <spyjetfayed@gmail.com>
Subject: [PATCH 0/3] docs/hwmon: Fix broken and missing Maxim chip links
Date: Fri, 17 Oct 2025 16:27:15 +0530
Message-ID: <20251017105740.17646-1-spyjetfayed@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series fixes broken or missing links related to Maxim chips in several
hwmon documentation files. And updates a the links that get redirected to analog.com
to their analog.com links.

These changes remove several warnings generated by `make linkcheckdocs`.

Patches are independent and touch multiple hwmon documentation files.

Ankan Biswas (3):
  docs/hwmon: Fix broken maxim-ic.com links to analog.com
  docs/hwmon: Add missing datasheet links for Maxim chips
  docs/hwmon: Update maxim-ic.com links to analog.com

 Documentation/hwmon/ds1621.rst   | 20 ++++++++++++----
 Documentation/hwmon/jc42.rst     |  6 ++---
 Documentation/hwmon/lm75.rst     | 13 +++++++----
 Documentation/hwmon/max127.rst   |  4 +++-
 Documentation/hwmon/max15301.rst |  8 +++++--
 Documentation/hwmon/max16064.rst |  2 +-
 Documentation/hwmon/max16065.rst | 16 ++++++-------
 Documentation/hwmon/max1619.rst  |  4 ++--
 Documentation/hwmon/max16601.rst |  4 +++-
 Documentation/hwmon/max1668.rst  |  4 +++-
 Documentation/hwmon/max197.rst   |  8 +++++--
 Documentation/hwmon/max20730.rst | 16 +++++++++----
 Documentation/hwmon/max31722.rst |  8 +++++--
 Documentation/hwmon/max31730.rst |  4 +++-
 Documentation/hwmon/max31785.rst |  4 +++-
 Documentation/hwmon/max31790.rst |  4 +++-
 Documentation/hwmon/max31827.rst |  5 ++++
 Documentation/hwmon/max34440.rst | 24 ++++++++++++++-----
 Documentation/hwmon/max6620.rst  |  4 +++-
 Documentation/hwmon/max6639.rst  |  4 +++-
 Documentation/hwmon/max6650.rst  |  8 +++++--
 Documentation/hwmon/max6697.rst  | 40 ++++++++++++++++++++++++--------
 Documentation/hwmon/max77705.rst |  4 +++-
 Documentation/hwmon/max8688.rst  |  4 +++-
 Documentation/hwmon/pmbus.rst    |  4 ++--
 25 files changed, 158 insertions(+), 64 deletions(-)

-- 
2.51.0


