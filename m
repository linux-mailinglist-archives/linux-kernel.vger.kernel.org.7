Return-Path: <linux-kernel+bounces-761478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A830B1FAA5
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 17:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 650F31897B87
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 15:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E77246BB4;
	Sun, 10 Aug 2025 15:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caTJpOI6"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287AE1E7C18
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 15:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754838432; cv=none; b=IfWvYj521+63H5DuOhBsK/XGXQqrZbFvOgUAd6MPbcOhsRliO7x1q4OVx1BJE4+v2Qav4R5/qLHdA1IWJ9uANqETKwbWpryZZq6uiJ7NRfLi16YaS3cmfl+ygCV5R33LBjccwTVyvXavA5zS2OTDa//Oi9gHWd75GmvrpXJ3tBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754838432; c=relaxed/simple;
	bh=deRGbW0s/h4m4pwH2/0Jt/It4jlWPpRe+yq7Go9R7TA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jGkPceNGm/88vDBznmm80+XE+h7UPwt7Ddmsl0si5TUMItol5e/1ZRPVCVWXZtLyQiNYR8DKNQ3E0Srrxy8elp8/pbp0xVk6F9XIYCBNBAtIbomyOxAjyHPcrNg3Jhzxk6yrmSbIbHrjNDJEZL6R3qwxenA40YLXl481E7TDTV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=caTJpOI6; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-459ddf83023so21410175e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 08:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754838429; x=1755443229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQ59xHtOgWbEJc4IF9smzu3yNmmI1a87WpQPWKQVfHs=;
        b=caTJpOI6Bk+ZWvIC+LfYnEQ0SiAAw3nJitmCTac5Gn/fwS4GV5qc+WhFhNObJWov+a
         1BtIcAWwssFkjakdxsoSwGBFeGCC/nE0XFQ4jHOAvWxL796+s+kGNOOmH6IZNAplgqU/
         eUjd20+MSK6btgyW4e2NWU3HP3qoxyYjcJGcOodOarJlUHdemxucCdrf7qCqF8YJFd+2
         zjrMoJ1eCgbzJOionXvnP3RnAPgb/5JGsoxHmvhmY0tbAHmgq7NbXDIqNJ+v5vTHXPrB
         f713riGSFpRwHtHvRMQagJzWSjIBhQGqa5q5RJRFXrK0MdpAzHwINoeKQg0ZUHylvdnG
         AwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754838429; x=1755443229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQ59xHtOgWbEJc4IF9smzu3yNmmI1a87WpQPWKQVfHs=;
        b=Bt++xy9RUEjOK9ofEF0TJJTxf5dlXwcwH12P2RlrvofIKz+FM92H6PFfKD23tlUzPy
         SFihJkFO7mie+KJ2OQKtTaK0/gd5ExQ9w5SI9v8RWuig8y8HvoBFnlEoqosdO21tx4iE
         9wjXbm08fnQdRsctUzFDn1lYoRgh516L3B/0ImFsCj0dYXmL0P89plJ1QqT2CJm6m6+C
         bOHeH6VIUJOF2D7xHQeo/4P3l6I7EEdqPFPID2rpNx7EDY+zSfulYNfx/yL5b5RZzwIE
         chs3QsUqL+x9XENXfHvTaEhx2cruRexT9k2pRedqf647T1BbAcQJVNg2NuvJ5rrkba8R
         0mKA==
X-Forwarded-Encrypted: i=1; AJvYcCUOfOkCz0kWxq/GHDn19A0p+05qGuiNk8XfMaf/XdbZiY/7Gkjvd1TBv3wDplt91ldpGH+Dn8AydK4O0ZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIbpn4yHcriTp5s76mS3wdBMmdVPV3iMZdcpkwDmNMGfyQF/0t
	Eq58FfkInp8LDs1WhZSHyzgMuiS3IXHpDUMom69vKUwLs2Po4XNOtg/Zd+P8Ksll
X-Gm-Gg: ASbGnct023PWP9ouk8GtEpOI3JNtM8q9Y5tjUw5urGLFWz3sw/lqJGqzQcmMbZom/mu
	3nlvtlk2bdG9eZvpK013yWxkXsfyB/tOOg2iDx9NUsjnZis8mif7oIEJTRA21fXsjShtk2RoAGN
	Bb/RTJ71zsv0GoUueSpBBLFLz1u09BKfSwz9s+mOdb90RlrF4snC5qtVqg5oKMxIElBLzkgnQ5f
	D5G953HrgySWtXsD1q2SzpJUpRTt6SmhLToFOOMORfye21IGt1BS0ZQa1LAR0uZwGCERXgmL+fl
	RShcyi6Bh12dCcgDo0D79RYymJTnltIpnkwlFp75QPJWj7rX1jnkrHpW+M8aNSusX2VllUpiCNj
	h1G8tHoflwpz7cag05SMRj0DY8x1TYb2/HOC6qi10eV2oO0LAsVLjay4VDs6TNKRuc3b88wPT
X-Google-Smtp-Source: AGHT+IGnsEOHPXBo/gu/b3QC4R5+Wjtv9EVFuqU+/OTZ1FCVewLf4z2r7z+BM9J6nhmv/NU272ooIw==
X-Received: by 2002:a5d:64c3:0:b0:3b7:974d:5359 with SMTP id ffacd0b85a97d-3b900b50441mr8668873f8f.32.1754838429143;
        Sun, 10 Aug 2025 08:07:09 -0700 (PDT)
Received: from localhost.localdomain (109.red-88-1-15.dynamicip.rima-tde.net. [88.1.15.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8f5d7deaasm16567371f8f.65.2025.08.10.08.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 08:07:08 -0700 (PDT)
From: Javier Garcia <rampxxxx@gmail.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dakr@kernel.org,
	robin.clark@oss.qualcomm.com,
	antomani103@gmail.com,
	dmitry.baryshkov@oss.qualcomm.com,
	me@brighamcampbell.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Javier Garcia <rampxxxx@gmail.com>
Subject: [PATCH v3] drm: Add directive to format code in comment
Date: Sun, 10 Aug 2025 17:07:06 +0200
Message-ID: <20250810150706.305040-1-rampxxxx@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <DBYS3FAEVMHC.178SXO45NIBI8@kernel.org>
References: <DBYS3FAEVMHC.178SXO45NIBI8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add formating directive line in function `drm_gpuvm_sm_map_exec_lock()`
comment to clear warning messages shown bellow that appears generating
documentation `make htmldocs`.

  Warning: ./drivers/gpu/drm/drm_gpuvm.c:2444: Unexpected indentation.
  Warning: ./drivers/gpu/drm/drm_gpuvm.c:2446: Block quote ends without a blank line; unexpected unindent.
  Warning: ./drivers/gpu/drm/drm_gpuvm.c:2450: Definition list ends without a blank line; unexpected unindent.
  Warning: ./drivers/gpu/drm/drm_gpuvm.c:2451: Definition list ends without a blank line; unexpected unindent.
  Warning: ./drivers/gpu/drm/drm_gpuvm.c:2455: Unexpected indentation.
  Warning: ./drivers/gpu/drm/drm_gpuvm.c:2456: Definition list ends without a blank line; unexpected unindent.
  Warning: ./drivers/gpu/drm/drm_gpuvm.c:2457: Definition list ends without a blank line; unexpected unindent.
  Warning: ./drivers/gpu/drm/drm_gpuvm.c:2458: Definition list ends without a blank line; unexpected unindent.

Fixes: 471920ce25d5 ("drm/gpuvm: Add locking helpers")
Signed-off-by: Javier Garcia <rampxxxx@gmail.com>
---
v2 -> v3:
      * Added the proper imperative message.
      * Fixes tag possition.
      * v2 https://lore.kernel.org/lkml/20250810112218.293272-1-rampxxxx@gmail.com

v1 -> v2:
      * Added the proper Fixes tag.
      * v1 https://lore.kernel.org/lkml/20250804212902.22554-1-rampxxxx@gmail.com
 drivers/gpu/drm/drm_gpuvm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index bbc7fecb6f4a..74d949995a72 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -2432,6 +2432,8 @@ static const struct drm_gpuvm_ops lock_ops = {
  *
  * The expected usage is:
  *
+ * .. code-block:: c
+ *
  *    vm_bind {
  *        struct drm_exec exec;
  *
-- 
2.50.1


