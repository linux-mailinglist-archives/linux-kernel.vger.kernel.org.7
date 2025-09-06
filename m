Return-Path: <linux-kernel+bounces-804002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1C8B46895
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 05:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67FF27BD5F0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 03:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB53222A808;
	Sat,  6 Sep 2025 03:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTtwvtYK"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC8822D4F6
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 03:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757128821; cv=none; b=auQonPXBNKn4o7FQFBl19oawm4nNlvOh3G5PmUCjO15li+AxdGDl1za9a3HPK5qrTs9ZNcUtljdpFk5oEVrKzcCnjbaZGLnaAMxWM8pvzrEllyCDaG0iLHSg5Wh2KD7CqET2mjSXgky/4Xcydk9aHLtTlJs8nDORvGai1hT+oA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757128821; c=relaxed/simple;
	bh=o+FaEWcsuObUNv07NnL2n6St+0yeCtdSIOD17oMGGwY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CwkMPyrxImOO+brgABz5Ypb/Uk+BxHGKcOi2QZd6+05PI/b6vpjXzChbsaB0S+aJngf4JZXm3MzmFNarI7ZNIK3QdPsLJc6+Cj7XD/030KOlk+F89fSWxzh+jP9aVxjrxsPdSZnIGGn5oCTHBx7licAoG7nlNeZ6ZZa+L+zemwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTtwvtYK; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77264a94031so1998163b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 20:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757128818; x=1757733618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NyCEsVkz56P0H6XVc95lmqF2qsvWh4kZKhuPs1kvLI8=;
        b=JTtwvtYKIWMwGWEzxzNYj+ACFysPegWEtXi2lHGY0dB5/mTCFnOwkuWDKm7nYQA50c
         rmPyaXdSZbPYjV2/V2LsPhXVfdBJIqnQ2aT39BNAZZ1TwcUa9SZ9M7r4Z2G9Km9cnKTI
         WFJvqm10j4GUGiewtY6cY8o5DkTN+lPn18Soe4lAqUX8y7H9mqohC1srfSKQb2zXzSQq
         GjZaq9jK7e3Vc5CsEgoGkZUDTO5zr67aWigHL0fz0iviliEvB5/ijjDcZ1Z7w8f/D9P1
         2RLzcStapaTvvfmdsw+NvUYnYGIt+oM4JjS7EchQQAeobmoJ3vxdMsPSztHlx8efqkhP
         QfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757128818; x=1757733618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NyCEsVkz56P0H6XVc95lmqF2qsvWh4kZKhuPs1kvLI8=;
        b=S37+0RUfS2YwJBa6oIrp5a+Poq4INP3aoVFmLvLXkoMCrPPDANZ/YMAwM+mbiYG5p1
         YBkX+4vxItIxwFM0nS9UzOks5OSfAAn6RnGoja8yQDgjC0gqP/OO3RpGZ1VRxFEHUmse
         qEwRANXFNLQSCCQ/mPa+k7sVjUZbkQki16xo10EqPNC7S4Hiu5/tqc8eGlpgfaauN3hi
         4cTE8TpiRvNAUPGOmR+lBcQMAeHi7fOEj2jlVbjJMAEdYSnla0I/z7FnOF6PIjMOUAcp
         oOu4LLPXZ4S7wvV1Y5fOzxCKXR7IHF6CkxyRDUeQPmsf2bDL3u/YTkdYyDGqVGOD7ErJ
         1qjQ==
X-Gm-Message-State: AOJu0YxvbH/D6+NFShwzYyL1GpnszHIRt+OHxrlISPNqxe05KQMX0pmZ
	Ap4dDgajKY4CLFWaSsrp76yZaDTU2LHrGjQWaF63Nx9OUzBGN3iTxNynwXQxyA==
X-Gm-Gg: ASbGncu7vyUoJkG5w7lDr6PmrU6u6h9hhYr/b/+5hjZ0hIw4mTwAi7esdKX9oytI+Do
	4s+CeOKFQpgHWCdyZSmAC+rpYXHk0UwYkFUFOhM9x/LhQdOA3tw66O++fPGbInbQ32CwZPI4tUx
	ubn+xGysc5H6DUtU0mgOwjuCp63mFkCxjcU8H9WkG0/12Ku7EaQrO2dpqJL76Pp0jXItSCOGxTr
	XlottmbPogWX9hrC9ZhSfXCOeiQsqRtU2SIoyMIc7VgLf8tfAcvxc1lottkMybAnS+rjXBkW8Z0
	rN8YhPObK2p7N81R9lsy2KoLPBREWyNfDdkGUFVodredWxe0ZstRK+N/sNe4HW+hmuga7aCDodo
	FAbMFKTwc2x1xZA71BSjVEx1wIS6c3lJNFI6+k1a+WRPv0qEr2nSV99CeqlrSRygJId+D
X-Google-Smtp-Source: AGHT+IF/RDngzxXkjSK94S7JBeGkTna2YQP5pN85s7QePL+iMyK6SRsIeto2VFNdqv2uwrHy7nNvpQ==
X-Received: by 2002:a05:6a00:852:b0:771:e10d:813d with SMTP id d2e1a72fcca58-7742dde560amr1173722b3a.21.1757128817778;
        Fri, 05 Sep 2025 20:20:17 -0700 (PDT)
Received: from localhost.localdomain (36-231-187-52.dynamic-ip.hinet.net. [36.231.187.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a090c77sm23093074b3a.0.2025.09.05.20.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 20:20:17 -0700 (PDT)
From: Nick Huang <sef1548@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: maintainers-if-needed@example.com,
	Nick Huang <sef1548@gmail.com>
Subject: [PATCH v2 0/3] dt-bindings: mfd: Fix typos in PMIC/BBNSM documentation
Date: Sat,  6 Sep 2025 11:19:52 +0800
Message-ID: <20250906031955.21338-1-sef1548@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series contains minor typo fixes in the Device Tree bindings
documentation for MFD nodes, including PMIC and BBNSM descriptions. These
corrections improve readability and ensure consistent documentation for
developers using these bindings.

This series builds upon and complements the previous v1 patch:
https://lore.kernel.org/all/20250902142749.13724-1-kusogame68@gmail.com/

The patches include:

1. dt-bindings: mfd: nxp,bbnsm: Fix typo in documentation
   - Corrected "Intergrates" -> "integrates" in documentation for RTC & ON/OFF control.

2. dt-bindings: mfd: rohm,bd96802-pmic: Fix typo in comment
   - Corrected "contolling" -> "controlling" in comment about SoC shutdown and PMIC control.

3. dt-bindings: mfd: rohm,bd71847-pmic: Fix typo in documentation
   - Corrected "abd" -> "and" to improve readability and avoid confusion.

All patches have been signed-off appropriately. One patch is co-developed,
and the others are authored and signed-off by Nick Huang.

These changes are purely documentation fixes and have no functional impact.


Nick Huang (3):
  dt-bindings: mfd: rohm,bd71847-pmic: Fix typo in documentation
  dt-bindings: mfd: rohm,bd96802-pmic: Fix typo in documentation
  dt-bindings: mfd: nxp,bbnsm: Fix typo in documentation

 Documentation/devicetree/bindings/mfd/nxp,bbnsm.yaml         | 2 +-
 Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml | 2 +-
 Documentation/devicetree/bindings/mfd/rohm,bd96802-pmic.yaml | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.48.1


