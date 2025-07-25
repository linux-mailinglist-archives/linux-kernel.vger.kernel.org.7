Return-Path: <linux-kernel+bounces-745742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFA3B11DBB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 13:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14365AC668C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5112E6115;
	Fri, 25 Jul 2025 11:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CCHtdZoM"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0C415746F
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753443782; cv=none; b=AEOiXSAHjMXmYhUMli5wyss4E83N+yxEGD0+YotAI9zbjfbIrXGoOv5OPRF/IC6jSTESVvh/pOOCRLjUOCL5HMm6AXkhl5qmCZpKFdgTX2YMiRCk8L2J/OQ/1v3TTjf4Gfrwws/s/9zphAddq1gTuQHAyoU2dbTxuLwSTCrgqTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753443782; c=relaxed/simple;
	bh=iA/hyGhetbS2gRaULrRQIK8ommfvKWHeynd7Bi9FakU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WN7HbkDa8ddfsJ0jb+ZsTc31eshChxYFs/WnQTnVs3qvKw5togo2OpQGBSUDWlpSrrvX9S6fijzV5kHECT2cnAyqschxm1tsdOKuMA2XxnFPFK64w7MkFhSZDeKtuOHz7wf/+mFNYS4aNbQNwPuILWKHCYQIt5I/yOJgQhk++GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--verhaegen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CCHtdZoM; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--verhaegen.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3b5f97cb8fbso913639f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 04:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753443779; x=1754048579; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Fs4WIMRpWwIcuHXQawsP7PuMKJnOQxUvgvwqbySpiXk=;
        b=CCHtdZoMkBcEyprUHkiKLDUvQsHyE21ok/Jumk96Ll5WuWWtuYXsDF3f8TjytolzsO
         T+0JuYuoBtsrxkXXn5RgcONUwz+eWASXrfJj+7VF4Ud1oRoiq7QCyXGggd+UqvB7ddpB
         VhvuCImdBAn4Q6I/Syi1AnZHac1TeSzVntsiUOiCRXGhyhWn2E2No/iK9dN34oTqJBnc
         /whatFaVC8w2UV8Xge2R2dv6OZxjuBJE7vQ/YZHkAgQhkQjhmyaXcG5h7ZoLOTIGpiHg
         8v++fKvCeJWac2TgTTVBfXjL4XviRmGbE9x7fbuEPrJmvXGhc+Z2eRMeI/EQP7g17tC0
         O8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753443779; x=1754048579;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fs4WIMRpWwIcuHXQawsP7PuMKJnOQxUvgvwqbySpiXk=;
        b=fmCLA4iD5nhNTZao41/wI4HLl7JL0Z8VlWYZJpXAS7VAaeRRxKPofWmj6BAdZdnrdv
         30GORm0cfrQtluMKDMI5DqYSd7Snx+bgrKmb5Cy+Ll6fK/Q4J+8WZDldJtLrzSHNyfT/
         D5lR22LBPLkiqh+7USN4nGnR0lAREYpm2S9svbaPidGF/8cyhKhpgxNHtlT8zIayhBZ2
         ZJmhUSbi68TPa71ThDlx5tjQ9jhjviKku1lhWgKue1rbDpe1OW7nIz69smk+sV6REAbB
         AUrkoCcYqwsvafFfvQUfV5xtwtrCZ5k1e1qweU2TnIFa+wX5YcdJ1a0TbzCafI4y0lQn
         Ntqw==
X-Forwarded-Encrypted: i=1; AJvYcCVETaXd6rqURSxmgt4MEFVI7GWItPr+M190SwbLHFvG+1OM5hPLj+FaAiF/cAZM+c4mmSPYDLInYOmJVhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG43kL5bCq2WxGKDgUYq7QrcAeJ726C/kg1gSeGjFzyIxsfDvb
	ni+oCZb4sOSK3YD2LMfR+HVZtZlzBsMnJ4U9fECICKI+IEZUIWhRqMk8IeY8/C+2tbLsHkOfqFw
	qus4CySbIjOVqdrUKzQ==
X-Google-Smtp-Source: AGHT+IEVYehtHEprrhiAHZ95g+2gC92ze98k0Qt+xZ5aG3XGkuNcSUyzwUUV+kZ0DY9YfP8j0y302pUuBMzx3Ko=
X-Received: from wrs26.prod.google.com ([2002:a05:6000:65a:b0:3a4:eecf:ec38])
 (user=verhaegen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2905:b0:3a4:eb80:762d with SMTP id ffacd0b85a97d-3b776688508mr1531386f8f.56.1753443779538;
 Fri, 25 Jul 2025 04:42:59 -0700 (PDT)
Date: Fri, 25 Jul 2025 12:42:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250725114249.2086974-1-verhaegen@google.com>
Subject: [PATCH v3 0/3] ALSA: compress_offload: Add 64-bit safe timestamp API
From: Joris Verhaegen <verhaegen@google.com>
To: Vinod Koul <vkoul@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Cezary Rojewski <cezary.rojewski@intel.com>, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
	Bard Liao <yung-chuan.liao@linux.intel.com>, 
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
	Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, Srinivas Kandagatla <srini@kernel.org>, 
	Daniel Baluta <daniel.baluta@nxp.com>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Joris Verhaegen <verhaegen@google.com>, kernel-team@android.com, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-arm-msm@vger.kernel.org, 
	sound-open-firmware@alsa-project.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

The current compress offload timestamping API relies on struct
snd_compr_tstamp, whose cumulative counters like copied_total are
defined as __u32. On long-running high-resolution audio streams, these
32-bit counters can overflow, causing incorrect availability
calculations.

This patch series transitions to a 64-bit safe API to solve the problem
while maintaining perfect backward compatibility with the existing UAPI.
The pointer operation is reworked to use a new timestamp struct with
64-bit fields for the cumulative counters, named snd_compr_tstamp64.
ASoC drivers are updated to use the 64-bit structures. Corresponding
ioctls are added to expose them to user-space.

The series is structured as follows:

Patch 1: Updates the pointer op, refactors the core logic and ASoC
drivers to use it, and defines the new UAPI structs.

Patch 2: Exposes the SNDRV_COMPRESS_TSTAMP64 ioctl.

Patch 3: Exposes the corresponding SNDRV_COMPRESS_AVAIL64 ioctl.

This series has been tested on a Pixel 9 device. All compress offload
use cases, including long-running playback, were verified to work
correctly with the new 64-bit API.

Thanks,
Joris (George) Verhaegen

Signed-off-by: Joris Verhaegen <verhaegen@google.com>

---
Changes in v2:
  - Corrected author and Signed-off-by to be consistent (Mark Brown).
Changes in v3:
  - Rework pointer op to return 64-bit timestamp, rather than adding a
    parallel pointer64 op (Charles Keepax, Takashi Iwai, Vinod Koul)
  - Bump the protocol version for ABI change (Takashi Iwai)
  -Fix linker error on Intel Atom (lkp@intel.com)
  -Rebase on latest for-next sound tree (Takashi Iwai)
  -Avoid changing return error code for ioctl (internal)
  -ASoC: Replace u64 % u32 by do_div(u64, u32) (internal)
  -ASoC: sprd: change current_data_offset to u64 (internal)

Joris Verhaegen (3):
  ALSA: compress_offload: Add 64-bit safe timestamp infrastructure
  ALSA: compress_offload: Add SNDRV_COMPRESS_TSTAMP64 ioctl
  ALSA: compress_offload: Add SNDRV_COMPRESS_AVAIL64 ioctl

 include/sound/compress_driver.h               |   2 +-
 include/sound/soc-component.h                 |   4 +-
 include/sound/soc-dai.h                       |   7 +-
 include/uapi/sound/compress_offload.h         |  35 +++++-
 sound/core/compress_offload.c                 | 100 ++++++++++++------
 sound/soc/codecs/wm_adsp.c                    |   4 +-
 sound/soc/codecs/wm_adsp.h                    |   2 +-
 .../intel/atom/sst-mfld-platform-compress.c   |  12 ++-
 sound/soc/intel/atom/sst-mfld-platform.h      |   2 +-
 sound/soc/intel/atom/sst/sst_drv_interface.c  |   9 +-
 sound/soc/qcom/qdsp6/q6apm-dai.c              |  26 +++--
 sound/soc/qcom/qdsp6/q6asm-dai.c              |  26 +++--
 sound/soc/soc-component.c                     |   2 +-
 sound/soc/soc-compress.c                      |   2 +-
 sound/soc/soc-dai.c                           |   2 +-
 sound/soc/sof/compress.c                      |   2 +-
 sound/soc/sprd/sprd-pcm-compress.c            |   6 +-
 sound/soc/sprd/sprd-pcm-dma.h                 |   4 +-
 sound/soc/uniphier/aio-compress.c             |   2 +-
 19 files changed, 167 insertions(+), 82 deletions(-)

-- 
2.50.1.470.g6ba607880d-goog


