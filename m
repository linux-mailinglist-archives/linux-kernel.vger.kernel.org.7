Return-Path: <linux-kernel+bounces-791685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E668CB3BA23
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 13:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C4D23BEEB4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 11:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0CE2D6E59;
	Fri, 29 Aug 2025 11:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HnWSoTl5"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BC8229B1F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 11:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756468046; cv=none; b=sU1ob3FwPBLYsigNncef4EienLMd37PXh4ITRTeewBwIkMl8TbeY8Uy7vDyqCDjzyGSG/S0Bq+3g9jFAaioRdVSzLb0NhUL3wlWdEKj9F7Acosjj/FqQgPFPgMmgegs/kUpuyReLbFUx9u/Na80fsPa9XQD5aA+dLRh8af7zv1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756468046; c=relaxed/simple;
	bh=nH+7SyLbGXXqvFgRv8pQOol512xjM5XrGIqVoZmP1xI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gma1htlXeb49CrfeAGOfpG1/QYIg4kcT9Y61pNLXQ4tO2+nACe+LUVWtCheTKkNZlyddIdYy52fN2fKofZRhg7oRTNCaSaDtOsC8i8gZ6mquv+1Icha8ejhWAkM90apv6BPr7aDohEscbBaV/YUinNfNVTV/ZRD84OTSyxgWfGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HnWSoTl5; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45b7c01a708so6410815e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 04:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756468043; x=1757072843; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KX/IvhXAlhsi61CJEzF6AyA/gZBXATfTlkMgbkVbOHU=;
        b=HnWSoTl5WdVa3ZoIHD+XeOZpjtMn0j2oP3N7l3tuQLsZcL4IkEGGRs+mNI6ufQH7E4
         pED5wW73flVI9gcFhf3HAqnnIruFxJI3N6ezPUY8YT1bUp+Rqwsf+2qA8NpPy4KvRt8H
         NfZ+KaduWZjrsb1/Sz6BGBNtANIHhtuXuezMZJlgroOMBaeYB/OlD5lB02eRPYhYanUW
         iAidsrK2g4GRWtR1n8fDTus3XGNPc1j4UJ3jTUiu5+/x/aaMIVbzH0RadT1GgOetnQeg
         dh+uzAy6GSFHsnRTPEDMq9N5krsNaioFsZGpO9UQCNst5CWd1yiRkvkFk6Hm9MxcTnvZ
         P3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756468043; x=1757072843;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KX/IvhXAlhsi61CJEzF6AyA/gZBXATfTlkMgbkVbOHU=;
        b=W8jaK7ninqS9wCj/qkZu9pU/9pqGQhrf7AjKujHCGKMJZnjiJETo/1shUk5kMNyhh+
         qOIMEjIkLvbAmgMd3BA3djGWR7aCAgpepwM6digOISv3vJ8Y61SBEZ9Hv/MfqtLtq+V8
         vc9MgqE5bn05vUA+TkxFLXiqLyxY8lQbpYKUdnrVRzcEPQ2hnYKQfkBF+YqPeeX/KjIE
         GIUUe88TZB9FguYjb1jbvfEuBFsNec6D2GCpF5pDo4ic7/jFj8k6gDEqRrYyjAmLsgyq
         eyscBy0VtM07SZKbcYjM/skTE0zKeBKOJZTyAEK7cqmvy4YVuGUt3Ctl+E+FV8Urmpqg
         kjLA==
X-Forwarded-Encrypted: i=1; AJvYcCWDLy1RrZajeb/q/Qog9+hnWJ8vGuDH41/Kuy/k4RP+WuC32Twktzs6W5LjU/zaI0z6IfVlDkxrAZM7IAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE0wxcdekYQYpy7gYo9utHuVGItOJWn15QYz95E8XBWHoNYIuF
	JR/bcYcriut4kE8JUVHliwusbev6ZRYOCdzPdWAX1BFW6KayYnKx4yQZpM7NeE/2V3o=
X-Gm-Gg: ASbGncshPTCny+ilEyrzL/mYge7P9cxHt6LIQsWH5yPEnCs2WGVlxepbL7o5AG+IiQ+
	ysOHQRRLrMNn44XSLMetqHds1OkQ56j6NZZVvlG82WAh/7ozubQDSA4b3y4nFP7zPVgf9FvCKRj
	n44fzvCFdwe2RoBZvYXBNraDmOUbxCP28lRPmkekFRQnR62DSUJiGh0HeIJoIR6mar58u04RC0d
	HQnCvIESdZPMXSmLtJim3is0L9f4hexRRo9hN3yx1LVP26NO8u3w/l2iIZDPbkPKXJTbqaRI96M
	e3OIdFhp/G7qHBzbdZZXDdxo61mLi107caafc+0sgWyPlGiIZ4r64A9E1eIz7tEIYoaEhQ5PDS0
	kJPG5tql/tWuEORane+4zzHT3O5ASMfI=
X-Google-Smtp-Source: AGHT+IE6sYUh8BxMIMLLQlY8sdD0DAtWz+61SjvndENSWhM+VWl24xZTFdLXTJzV2n7T/jA/aN+mnw==
X-Received: by 2002:a05:600c:4e90:b0:458:a559:a693 with SMTP id 5b1f17b1804b1-45b517b957emr252723875e9.18.1756468042770;
        Fri, 29 Aug 2025 04:47:22 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7c461edasm29873255e9.9.2025.08.29.04.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 04:47:22 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH v5 0/7] spi: spi-fsl-dspi: Target mode improvements
Date: Fri, 29 Aug 2025 12:46:42 +0100
Message-Id: <20250829-james-nxp-spi-dma-v5-0-3246957a6ea9@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACKTsWgC/3XQTWrDMBAF4KsErasyGv3ZWfUeIQtJHiUqjW2kY
 lKC717ZUOoSd/kG3jfDPFihnKiw4+HBMk2ppKGvQb8cWLi6/kI8dTUzBNSgEfm7u1Hh/X3kZUy
 8uznu2taSJx+98az2xkwx3VfzdK75msrnkL/WFZNYpj9as6NNggMXYBpCSRCieftIvcvD65Avi
 75WDbT/VdE3UpAVyhNuq8slE/5uN0LuEVgJEJYoRFTO+SdCbghUe4SsBNlOWxV1NBieCLUl7B6
 hlh/YpvMOIQiEP8Q8z98GczmFtwEAAA==
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, Arnd Bergmann <arnd@arndb.de>, 
 Larisa Grigore <larisa.grigore@nxp.com>, Frank Li <Frank.li@nxp.com>, 
 Christoph Hellwig <hch@lst.de>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.0

Improve usability of target mode by reporting FIFO errors and increasing
the buffer size when DMA is used. While we're touching DMA stuff also
switch to non-coherent memory, although this is unrelated to target
mode.

With the combination of the commit to increase the DMA buffer size and
the commit to use non-coherent memory, the host mode performance figures
are as follows on S32G3:

  # spidev_test --device /dev/spidev1.0 --bpw 8 --size <test_size> --cpha --iter 10000000 --speed 10000000

  Coherent (4096 byte transfers): 6534 kbps
  Non-coherent:                   7347 kbps

  Coherent (16 byte transfers):    447 kbps
  Non-coherent:                    448 kbps

Just for comparison running the same test in XSPI mode:

  4096 byte transfers:            2143 kbps
  16 byte transfers:               637 kbps

These tests required hacking S32G3 to use DMA in host mode, although
the figures should be representative of target mode too where DMA is
used. And the other devices that use DMA in host mode should see similar
improvements.

Signed-off-by: James Clark <james.clark@linaro.org>
---
Changes in v5:
- Change some ints to size_t for consistency
- Separate change for making buffer size a page and making target mode
  buffer larger
- Explain reasoning for target mode buffer size change in commit message
- Replace an if with a min()
- Drop applied fixes: commit
- Take Vladimir's change to separate -EINPROGRESS and cur_msg->status
  changes and fix the bug
- Get max segment size from dmaengine rather than hardcoding it and
  store the size in struct fsl_dspi_dma
- Link to v4: https://lore.kernel.org/r/20250627-james-nxp-spi-dma-v4-0-178dba20c120@linaro.org

Changes in v4:
- Fix !CONFIG_DMA_ENGINE build (and actually test it this time)
- Reword completion counter comment
- Reword some commit messages
- Reset tries in dspi_poll() for each transfer
- Check for fifo errors in dspi_poll() before checking for completion
- Link to v3: https://lore.kernel.org/r/20250624-james-nxp-spi-dma-v3-0-e7d574f5f62c@linaro.org

Changes in v3:
- Stub out DMA functions in the driver so no-DMA builds work
- Link to v2: https://lore.kernel.org/r/20250613-james-nxp-spi-dma-v2-0-017eecf24aab@linaro.org

Changes in v2:
- Store status in cur_msg->status rather than adding xfer_status
- Show exact underflow/overflow flags in error message
- Rate limit error messages
- Add a comment about resetting the completion counter prior to transfer
- Rename dspi_is_fifo_overflow() -> dspi_fifo_error()
- Add performance figures to cover letter
- Rebase onto https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/for-next
  to avoid some conflicts
- Link to v1: https://lore.kernel.org/r/20250609-james-nxp-spi-dma-v1-0-2b831e714be2@linaro.org

---
James Clark (7):
      spi: fsl-dspi: Avoid using -EINPROGRESS error code
      spi: fsl-dspi: Store status directly in cur_msg->status
      spi: spi-fsl-dspi: Stub out DMA functions
      spi: spi-fsl-dspi: Use non-coherent memory for DMA
      spi: spi-fsl-dspi: Use whole page for DMA buffers
      spi: spi-fsl-dspi: Increase target mode DMA buffer size
      spi: spi-fsl-dspi: Report FIFO overflows as errors

 drivers/spi/spi-fsl-dspi.c | 222 +++++++++++++++++++++++++++++++--------------
 1 file changed, 156 insertions(+), 66 deletions(-)
---
base-commit: 07d9df80082b8d1f37e05658371b087cb6738770
change-id: 20250522-james-nxp-spi-dma-a997ebebfb6b

Best regards,
-- 
James Clark <james.clark@linaro.org>


