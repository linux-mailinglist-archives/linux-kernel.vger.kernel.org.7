Return-Path: <linux-kernel+bounces-727305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A88B01820
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 11:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0D0F1CA2CC6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EE427B4E0;
	Fri, 11 Jul 2025 09:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dHBxRfa5"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E594927CB06
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 09:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752226628; cv=none; b=BMv+WT5/9L40aoHEOz81RGDo6CMhzs+njYCDLDZj6PzgzVzY5OR+vFKDd1g5teR9kl/YzXWn+waCVSSf4j9vzm4851/DMF+gXbHv9JfuGzGkIPYmtm9sggLFfogdiCNffaNwygo3njdQtiNwWvqwlsrZw5p8bvdweihOj0ksQdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752226628; c=relaxed/simple;
	bh=6YZCSoHK95TeXgXlBf0GOGvNtzlsSLsVXR1XKW53PBY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tgIHWXmvsl0mM408ps3ZKsbhHMyxhPioQkNvf5yNTRW+il6ZGYnEm99n8iAti6EP78I82YzXmojd6wBb9tytf+DYFensduQDTUJd1/CR6UeYTg8p7H3BWLKrT2rpZH7hvKPWdQVUSrC4Rkujjka6ToZi3lw0PCUWVAw3dhC1ndk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--verhaegen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dHBxRfa5; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--verhaegen.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-606ee65164fso1998808a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 02:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752226625; x=1752831425; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+N72RreF3X1ulCyF9Eewj5G4ApF4h1mESu3uQOVVQvU=;
        b=dHBxRfa57PkShbEqvEpLdOLISuSr0rXOeII/X1rz5gCnTgyXg+5je9g9r2JLVQ7V+h
         YRJuLIuxGUbXjKwAG2/ZQSR40KnmzFXboiVeQL+dJp35E+WI8JxBl8DWQRYaA9zMtusw
         2TBPjf3688JJWf8FZPpZafK0iAZLa3yk8l90EamWkO4BoLhg2Y4TjYf9UXWNYb0YEjxQ
         LRVQUeJ1URSQK3mooEyurwApxUJTzAqXnh06CnnLCMaw63WTwf/wYuh4trowRnp3jdII
         /59qGyazm5v4jKRozwnqRw5TdfwB8y4gpqa2ubv8NU04MzmiLi22YXLVD/AIQDBdygq4
         Wj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752226625; x=1752831425;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+N72RreF3X1ulCyF9Eewj5G4ApF4h1mESu3uQOVVQvU=;
        b=ne1OeigXXfgLxPV92syEZHKnLcB0AA8AxlGTD59YbYC//0jbZ2D94etDK0jjBQ+lTh
         CPz3KZY8T46TrB6GiQGDZq/XHHDZ8SKfiaqXNBLzJ6vDxCZ8ot4Hq99FnfYjQGweWtxE
         NpYOgp+/X15Zgr9TOWtM4sHBHxuhr2smD9N1piPtH57SY5NfbpjrratM/K8w0CoA0Ltb
         /mCpS0sKq/vfto1Kd18FpKCWl0vJsaIYHb7PFLcKaK4pUb+ARXd7fOT7g+PqJf5bXijx
         9Ho2WP45weyVIMrb+J2/HtM/CyC+7ITFVWac9oB1BVHoCeMiXRjebmRQPlSj1cx2r/fd
         wkUg==
X-Forwarded-Encrypted: i=1; AJvYcCXRa7fsBoCf7mx8k8GPkGLnVbHhJk5TIdAr6ao/QyITqjDzxfi/COxnGqK0mLgDABfhxfKWqyTTK4swaNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtOvK+/6poNc8Z75g4hyWuZYu4qJf4+OYfQExyoSzwHpF4DfmQ
	4FLw9X94zFtzsY2M/OARcsAPrJCfpUF/PFJpOdc7Xs09NMoWGJb+WQ+JYtqyx8iv4eEiI/Ge7uG
	RVCbLClyjzOuTOdcO8A==
X-Google-Smtp-Source: AGHT+IHFOCtCs6k1iE35uepmQ8fkKxb0JFiQDnymiBd74U3fea8sOfyyLF0qyCnCfl97eLtQmON7Trpt1dqf47g=
X-Received: from edyb7.prod.google.com ([2002:aa7:df87:0:b0:60e:4b0b:3d5d])
 (user=verhaegen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:1d4e:b0:608:f493:871e with SMTP id 4fb4d7f45d1cf-611e7c0aaf8mr1935764a12.14.1752226625150;
 Fri, 11 Jul 2025 02:37:05 -0700 (PDT)
Date: Fri, 11 Jul 2025 10:36:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250711093636.28204-1-verhaegen@google.com>
Subject: [PATCH v2 0/4] ALSA: compress_offload: Add 64-bit safe timestamp API
From: Joris Verhaegen <verhaegen@google.com>
To: Vinod Koul <vkoul@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, 
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

The current compress offload timestamping API relies on
struct snd_compr_tstamp, whose cumulative counters like
copied_total are defined as __u32. On long-running high-resolution
audio streams, these 32-bit counters can overflow,
causing incorrect availability calculations.

This patch series introduces a parallel, 64-bit safe API to solve
this problem while maintaining perfect backward compatibility with the
existing UAPI. A new pointer64 operation and corresponding ioctls
are added to allow the kernel to track counters using u64 and expose
these full-width values to user-space.

The series is structured as follows:

Patch 1: Introduces the new internal pointer64 op, refactors the
core logic to use it, and defines the new UAPI structs.

Patch 2: Exposes the SNDRV_COMPRESS_TSTAMP64 ioctl.

Patch 3: Exposes the corresponding SNDRV_COMPRESS_AVAIL64 ioctl.

Patch 4: Implements the new .pointer64 operation in various ASoC
drivers that support compress offload.

This series has been tested on a Pixel 9 device. All compress offload
use cases, including long-running playback, were verified to work
correctly with the new 64-bit API, and no regressions were observed
when using the legacy API.

Thanks,
Joris (George) Verhaegen

Signed-off-by: Joris Verhaegen <verhaegen@google.com>

---
Changes in v2:
  - Corrected author and Signed-off-by to be consistent (Mark Brown).

Joris Verhaegen (4):
  ALSA: compress_offload: Add 64-bit safe timestamp infrastructure
  ALSA: compress_offload: Add SNDRV_COMPRESS_TSTAMP64 ioctl
  ALSA: compress_offload: Add SNDRV_COMPRESS_AVAIL64 ioctl
  ASoC: codecs: Implement 64-bit pointer operation

 include/sound/compress_driver.h               |   3 +
 include/sound/soc-component.h                 |   5 +
 include/sound/soc-dai.h                       |   6 +
 include/uapi/sound/compress_offload.h         |  32 +++
 sound/core/compress_offload.c                 | 210 ++++++++++++++----
 sound/soc/codecs/cs47l15.c                    |   1 +
 sound/soc/codecs/cs47l24.c                    |   1 +
 sound/soc/codecs/cs47l35.c                    |   1 +
 sound/soc/codecs/cs47l85.c                    |   1 +
 sound/soc/codecs/cs47l90.c                    |   1 +
 sound/soc/codecs/cs47l92.c                    |   1 +
 sound/soc/codecs/wm5102.c                     |   1 +
 sound/soc/codecs/wm5110.c                     |   1 +
 sound/soc/codecs/wm_adsp.c                    |  53 ++++-
 sound/soc/codecs/wm_adsp.h                    |   3 +
 .../intel/atom/sst-mfld-platform-compress.c   |  17 +-
 sound/soc/intel/atom/sst-mfld-platform.h      |   2 +
 sound/soc/intel/atom/sst/sst_drv_interface.c  |  43 +++-
 sound/soc/qcom/qdsp6/q6asm-dai.c              |  41 +++-
 sound/soc/soc-component.c                     |  20 ++
 sound/soc/soc-compress.c                      |  21 ++
 sound/soc/soc-dai.c                           |  14 ++
 sound/soc/sof/compress.c                      |  44 +++-
 sound/soc/sprd/sprd-pcm-compress.c            |  28 ++-
 sound/soc/sprd/sprd-pcm-dma.h                 |   2 +-
 sound/soc/uniphier/aio-compress.c             |  40 +++-
 26 files changed, 503 insertions(+), 89 deletions(-)

-- 
2.50.0.727.gbf7dc18ff4-goog


