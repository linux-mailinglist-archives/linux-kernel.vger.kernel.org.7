Return-Path: <linux-kernel+bounces-841500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F3BBB7890
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 18:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A49FB4266E2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 16:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9882C031E;
	Fri,  3 Oct 2025 16:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CR3HMJLZ"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F18E2C0279
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 16:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759508826; cv=none; b=rSlEma8M5V0af5XfeViFfqZkLM33nI9xXXNHE/CR9mpFHjzN5CGhDnMiCL7PUNMfg2I3avQG3P5RSDMQmfVp2qUQFfuo8nbpVe45yMVA8JxcEjI3tCHog8UTpPwAgJpeUWhVeGqJHfjFi13MYzbqwNwStHLo/P1lgM/X34UAi4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759508826; c=relaxed/simple;
	bh=0RiStN3RrbvB94Z1yKDlLdZYvlG/Mj3msFqW/hElFc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AdyUxmXuus5Y7zV9mrzzxT0XaseKmaS1kaIBQQnIt7kmIc9gRU1Wb1mYY23sW5iSW5bFapRNgup4LQ27J/A+nqC9behLjOii5JiRPatM68Kje7I699lDVInSumbTEqA0YAKc0iNOd0hbuWlQxf7vup2W79tCf7WlSqOos2gy6LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CR3HMJLZ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-28832ad6f64so28875875ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 09:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759508823; x=1760113623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/2q9wYSU+eDUIzaN6J73+bHEEYdLDRSnT+gWaueKZ3g=;
        b=CR3HMJLZN/BC/Kk3kmdZjC1crASgEUur7oXy8FpfLzI+CKlUFYuQTGD9JRv7X1/aab
         CMO4VVm8bbu6PL1Oy00KvwslJGbW9odk6KN5PcgTHSmwmiT8OIpTSsiNEeEKEhGxtYZB
         xqSlHzX5LicQ3OrOTJFs1y/+2PLq8opGgCH14tuo+z+rNF2UK6Fec9ClPLI2UlePoP1R
         ggFBNNez6jhMtAE/mb11OVlIcy+Hk2HK8vGyYKRV5FWz6F+adeT3eL3C2Mmevdk3uGXu
         wjhZdupw/aKJjPnqqlZVL6dJLbOYbSVv9G+GaUM81J0XGZ+Drqpkq/CN9uJ1qnJbDAe5
         B8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759508823; x=1760113623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/2q9wYSU+eDUIzaN6J73+bHEEYdLDRSnT+gWaueKZ3g=;
        b=DkljTJlCCaSRzk257RzvE2RMpLDV9jsSjqSdwe8eVomoT0oILl/Qbf/CWauHD3mAso
         KYKIu8SP/wiJmxuqN28oD5hldVnlxTEMBI6nnx5D2R/8Z0R05dJjkZYvL6HOtDKYruvC
         jhc+YlVOPXpE+GG25pyyfUdCOp6n06TXAd8lokItXggc/QJd42XbXBVNIS3WXLLNXyUq
         Y1R5vRrDVowZywD+KxRprBqBVZ6l2ZwuWNS+wHLzgGqEXr80RgoAeIQs/2JTB+aRE7ck
         YHHGraNUlxbZIMNOLFg9blqGKF9kd1xsIsDZogOaJ58yeGlzpGqkkB+QcpoQVZfCBlP0
         oK1g==
X-Forwarded-Encrypted: i=1; AJvYcCVmnAGCHT/MMp4Lw31Yg9r72+9WZc9yi5HgFAEmm9BZMVoVB9Ry5lFYzzHfSTjMT0HLGoqVrCTiDXLzhwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvDxB/qN8VYjnUFMP5K6Ka9PfGwpcViFo/Zm1MZTg5DPtB3LmS
	YoOXAY1547H9ZMXFjiR3meJToIs/CFvjfetoWuWQ/R9+JGZShr2auN6J
X-Gm-Gg: ASbGnctNxHtM1XjwYwz9oshiRwqtMNiqfqx2HmK3FFH8QL56ngtiYPuTBuRj1+6cFKo
	bQWL/R5y5sX1JfKHvauLqyu5noDz4K09sDVh/DmI8uxd58Gvx8QZjK35uuCj3n/pRgVxW/pKmhl
	P9BImNGNAd2rxo93efjEfHlZ8Jj3eCAw97dXAKhFYkKVRu6FqUsjIroSMGxCWAmvWjinXApFWvU
	n1ImuTbKrp1xTBM7n75VHLFl1m+/8qLSTo9wxK8kUPtPqQrY2HrcHgk7HXx3lCeFgbZW67ndNYL
	FDtDKAPcv6r5ovBfk11mTUpDp+9uwCGwcMKr9lge4/UCahEjP2tig4oJjWsL/XihFvyp09nequ1
	SieW7VkAOBrqsx+4lqlJUFhFFPJKa1+EuQXgf8SlU7OM5GhFFmqH5rQJYsjCznUvkrqYwGUvg6m
	19
X-Google-Smtp-Source: AGHT+IG33/LmrD2uJocMd7V5DXyh8BugwNDBXU/jsQ9avtbxXfaUabsRIgvZ5f2Dqev4eNNRS1l/Ew==
X-Received: by 2002:a17:903:41c9:b0:27e:de8a:8654 with SMTP id d9443c01a7336-28e9a674da9mr43290275ad.57.1759508823360;
        Fri, 03 Oct 2025 09:27:03 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6ff0dddsm8416787a91.18.2025.10.03.09.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 09:27:03 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: 2023002089@link.tyut.edu.cn,
	corbet@lwn.net,
	rafael.j.wysocki@intel.com,
	superm1@kernel.org,
	viresh.kumar@linaro.org,
	qyousef@layalina.io,
	zhanjie9@hisilicon.com
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org
Subject: [PATCH 0/2] docs: fix malformed tables in Chinese translations 
Date: Fri,  3 Oct 2025 21:56:09 +0530
Message-ID: <20251003162626.6737-1-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes htmldocs build errors due to malformed tables
in the zh_CN and zh_TW translations of cpu-drivers.rst.

Gopi Krishna Menon (2):
  docs/zh_CN: Fix malformed table
  docs/zh_TW: Fix malformed table

 Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst | 2 +-
 Documentation/translations/zh_TW/cpu-freq/cpu-drivers.rst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.43.0


