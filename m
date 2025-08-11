Return-Path: <linux-kernel+bounces-763293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32121B212D7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 19:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7200620898
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 17:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9E82D47E6;
	Mon, 11 Aug 2025 17:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hx5jxZ6k"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566F729BDB5
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 17:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754932032; cv=none; b=lUz4mky0NaNcXbRwe5dLVv4azCpi5OhN39Ux06t3+rfevx0olE/hpn51d7jl0B0ibdxWvC1e7bAPJRvuxS0AonJ3DLnlUiysO8CYWgTWuX4NJn4UYv9q7hFYsgb/OmSpsm3GovjMv0f0WyrWMsjD4FzutL68DOt9pbhdjUDHl1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754932032; c=relaxed/simple;
	bh=ero7dqEd2L68k0qTaixH5BImBh18D8SQtMNdTCT/vZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mB0Dcyvx/1ftkg8H6P7oS2vIVbuqbjxPn54H85qkwBpWCQL0a384mLP5hkFw+rPtT7DI704qO7vTfMVOEysh7WLVdfwtbVyCdHee7iTK9lRUlOulR4fWdjJmX/WaGWEHmeoeCkOsy9oji5BSwfi8Kk8fwiFH44Gwsb6dUobHHys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hx5jxZ6k; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76bde897110so3691696b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754932030; x=1755536830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S69QPamIXLtkMBYpOoBfBZTo6wmvCznnyAmXGWp0EzA=;
        b=hx5jxZ6k51cfxiGPYE4Wh/khBrYahJLdJh7dP/dQGFRq6tuIrCzEpMdrq6KpWl+msc
         ks0LT4ttMrQe+1oS5JFgUUIxakqwcg4QKuAM3FZMh5auzeaUeNhJTuPgoC1KcyfwDYJ2
         JV4k1AxbACe3x7qmuCPH6yEcao+xMudSNOXyzeBvOBs97j1meMEOn5d5oeCzhqFI/XtZ
         rdXLVGeadKTxielhz0sHyD2znnKyiePuwijkLdo8zELou9iVQyjqdHNIoioey3hPfdyZ
         24WKBlutKB3rqg+cvnskkQVnO+NZYQwo3xBwlzmGE/UlNVIqMhxE/mnjqPf+MpkD6Elg
         pT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754932030; x=1755536830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S69QPamIXLtkMBYpOoBfBZTo6wmvCznnyAmXGWp0EzA=;
        b=JMT07x9Y3GucfUpQHdCPb6nqTW1mPJRN48e9jgBFzVbe8RZRNCtKWJ3rauN5pIJ74X
         27RjEV3lF42kzBQqo1dxchrYgHA+UaBlHtceo2kRHY+W0Ob6vwqq/n3zB+8XFUcX8NM1
         4+TiokfwBKkoXVHyvHhqUb7nLkdpxUciWnGP5KVb89ZcT1o9uPLEfxvfGvpQ0QtTests
         oZMCPl1WDxyylmWcmheBPRGhf9JM7g42NruPZs3R/zDEjP4Al7xSWJhQFtvuFTTZdukW
         Fkswibhy5MFhNLTdDI32Uatlp9WmSv/zE8Dbf2scueuiJ6of4goqtqaNlU/jaiwzaqrH
         APFA==
X-Forwarded-Encrypted: i=1; AJvYcCUA100MbzgOwylogKctdJsH13FERNmO5rNZDQB0xuzjrKM9d+zOKYvG3eEJlnjM0U9cNQiiX4KIig0JF3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAIZoRaqx/+KbaQvQ+9rV6/D3VQTddebnnvLkycxYK51p4wVkX
	6l8Ls7hZXARBnjojPZJbi9q7IN7fRd2U/mWynl1MHFuFs1XQU4agv0yB
X-Gm-Gg: ASbGnctbow3YHi43DOfv5tgSvZct2VVSU7LzGhCwpK2EvO50MF7KvE7iA0TQLlwStd1
	1Kx5g5j6SUlXR0qpIJMRwChYnulQTbznBw8NUz5L2K1FvhYbaJaerXNtQX8TEhKD1wl5pMmkn1m
	aR9sSW32ia5BOcL0vRBY705mLKvLuGWhyoH1VuW22EEjW7maGwFMlcV0x6f1TfTAjTZ/+Usn6L0
	4srLGsejkCz/o0wanrb8f3D30izRzxmAI/eVSHr9h34INZ2Xy12LjKrBu5NPSJBEWRYQiA4iOT0
	4YNuzlCUoqCldQLUTE/eeXrJN+FbArUps4xxDRejH53vyMx/lzEjWNH023scjJ/J1r39jOy6uie
	+Kna4KPLEvN3jBoRBDHd8K/XGUUZX5ZRUqHCyQHm+/F11TpIf4Dx2h1M0iieXmRfxlzrmxnWX52
	yF
X-Google-Smtp-Source: AGHT+IEqcNdqHJSsF3iz71GBi7tMXwu/Q35YPRIyWtZopJfWBSkD2UYMrhhd+Ud83W8mJL5Uy7g7Sw==
X-Received: by 2002:a05:6a00:1491:b0:740:aa31:fe66 with SMTP id d2e1a72fcca58-76c460d2c66mr17856310b3a.4.1754932030378;
        Mon, 11 Aug 2025 10:07:10 -0700 (PDT)
Received: from localhost.localdomain (wf122-104.ust.hk. [175.159.122.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c09adf8efsm18836986b3a.68.2025.08.11.10.07.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 11 Aug 2025 10:07:09 -0700 (PDT)
From: Haoyang LIU <tttturtleruss@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Yanteng Si <si.yanteng@linux.dev>,
	Dongliang Mu <dzm91@hust.edu.cn>
Cc: hust-os-kernel-patches@googlegroups.com,
	Haoyang LIU <tttturtleruss@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/checktransupdate.py: fix missing f prefix in f-string
Date: Tue, 12 Aug 2025 01:07:04 +0800
Message-ID: <20250811170704.99420-1-tttturtleruss@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

add a f prefix for f-string

Fixes: 63e96ce050e5 ("scripts: fix all issues reported by pylint")
Signed-off-by: Haoyang LIU <tttturtleruss@gmail.com>
---
 scripts/checktransupdate.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checktransupdate.py b/scripts/checktransupdate.py
index e39529e46c3d..b57fb9139f5f 100755
--- a/scripts/checktransupdate.py
+++ b/scripts/checktransupdate.py
@@ -131,7 +131,7 @@ def check_per_file(file_path):
     opath = get_origin_path(file_path)
 
     if not os.path.isfile(opath):
-        logging.error("Cannot find the origin path for {file_path}")
+        logging.error(f"Cannot find the origin path for {file_path}")
         return
 
     o_from_head = get_latest_commit_from(opath, "HEAD")
-- 
2.50.1


