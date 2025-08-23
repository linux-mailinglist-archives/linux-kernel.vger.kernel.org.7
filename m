Return-Path: <linux-kernel+bounces-782948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 274AEB3277A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 09:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23DA0171726
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 07:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA8422D4C8;
	Sat, 23 Aug 2025 07:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWxmOVe0"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A331DE4C4
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 07:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755935509; cv=none; b=r4qUXvTlHspJawjZ4HLXJI9uj1LP8wuTWYF4Ms1Uvs2oOMgWf+Zm3j1vVRiTd0FzgZG9Lge4jQzQ0WI6reie6FqGxmnQcprYfAcclfdVIzhJcji2CJFkduDzVqNc2Ar0JsyFb3IRBHbOGK2Tbw6g94GHntNX2kaKub66NsY2SBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755935509; c=relaxed/simple;
	bh=MQYAc+vLzWD5tas7zc9B7Km62R50lygAdReGAfcPhY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G5UYuHg/8Idx9tS09oLkkfv+Hd2X6hQ74sHu4dVGBvTxtbGCoXut8GlXb9MlmD6MX5kc36Gfx/7nu00glfj+6vH2W4nd2jM/qpciMuUPJVsq6WtLHNpFyGKvPzCxAPlqMRNMh1jJLz4uM1b+iFyhdUNXI8MoX3yo0Bax+9oLqOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWxmOVe0; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3c4e9efb88aso1498604f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 00:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755935506; x=1756540306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QjBThWlI+y1/suOLDhw9XzEjYdkK/QFob0Uq6Qp8aHg=;
        b=PWxmOVe0wAmX+r33SuQQL3a5poNo7GQw6J0EvbrDmZKJS7d9HblRRp1wvGtn7DuYyB
         XP1w0LZZEhMhf7OVrLc/E30UGOhev7tcmeL4zaw8zKBtxkS/8vuiDTxNTaFI1uRV5zZM
         BhlQSic1v+pw1LalHAAk5Jsx40K0rG2BmqheBB2SwO7lfEspCu6dW3jpAkCpstJm1i/P
         4U64ky6TYiYidhqpw57iONkIjQgfVDgWswfvvGBaa8JIyjSupQ1etx7LYj6B3JYKWvEg
         GJVS8fBSHJUJQ/p6cNiiDN1zPf0tTwGGT657WPDxpDuh/O5ApOnoQVxqmpbSpqBERZEK
         pLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755935506; x=1756540306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QjBThWlI+y1/suOLDhw9XzEjYdkK/QFob0Uq6Qp8aHg=;
        b=t8cBm5V5lHSVNSW9gZtyPG52qnN6LmQhguXIP/UGthY+Kj5241o738u1YROVUMoDHe
         XkXaeeetJwsVwDZGxg862/lQ3To8k3dftxR4RhYGpzS1nZHsH0KuPlOyE/unxF/XYMHe
         7PcBtIuPiAB1tIWgnMpmr6J0jtVKryJ75ORkUT4HYBEQ37nU3rta73njqhoZUZqc2xBf
         ysUqgpqR7wZv423zWCTZ8kTYeaSMh7ET9QGoIY237yStmlfD0eD259MXJ6ILj3ZpoHdi
         pThs0J7Sx9asDlJUKP5ss4Bq/lwZavKXV4WmGEMh3B7wGktC5vol2FSZfAaXoi4APLUu
         qylA==
X-Forwarded-Encrypted: i=1; AJvYcCWkrSBasayjyRL2/zRtcq312N7ikVX7DnA2uofwP4ohAuY+EaAHmbaLUl4NOxYbCff1WzHP/EfRQSMKKNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO5p3Be8CUtKoy65v+pbhJrZIEw5EFNQUTV3bU1fOuNhskvaPb
	80x5tC4cReSPpum3IOW3vEG3DqlpyoydaczpbyCRnW1UOHQr7lnAZRY3
X-Gm-Gg: ASbGncsnA7YT1PfMIEV8zh/HKy4SAmFqWzzQuorOCycLJinJsa20P9cgEfzrVGnag1z
	Ac1FjnCmSAVGaHi1Kz+Ct1ZLPt+btfARepCtDirm2FOjlWAVTsYreGhGfcUVGfUH6Rki5/by9kj
	7i5dT44zGglYdeyFkR37lqUP4k3YSkTO4D8e5YQskOS4sbRHZ52scyPR7ISCEJcHGAPu/2dG0Y8
	Yyfmkw5KnjCWCxEBovDtKmR/CjpWijdu7dTsaoMS3xM7AolifGzCisPNBXurzAva2ADDomVivSE
	imE+97NlkmAoreXo4iXEQh2snkMiRZU8X+hSK283OCPjYfS4rDuULqq6WJ9ZpWlKa5U6U7g3joU
	5cmMyEUx285e53fw9UOXgfzME2feO0amlYBo9idzsCa0DlNN+h0qi+IY=
X-Google-Smtp-Source: AGHT+IFd9sVYyZE3sI5Ey4wdQ15aVHWFhxBBI0yTcTBvbkIbotuk1JFW62jPaxc8WPpjFhHb4ZpS3w==
X-Received: by 2002:a5d:5885:0:b0:3c5:356c:8a7c with SMTP id ffacd0b85a97d-3c5dde75899mr4358435f8f.51.1755935506021;
        Sat, 23 Aug 2025 00:51:46 -0700 (PDT)
Received: from dell (117.red-81-33-123.dynamicip.rima-tde.net. [81.33.123.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711211cd3sm2512295f8f.40.2025.08.23.00.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 00:51:45 -0700 (PDT)
From: Javier Garcia <rampxxxx@gmail.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Javier Garcia <rampxxxx@gmail.com>
Subject: [PATCH 2/2] drm: fix kernel-doc struct tag for `drm_modeset_lock`.
Date: Sat, 23 Aug 2025 09:51:39 +0200
Message-ID: <20250823075139.34797-2-rampxxxx@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250823075139.34797-1-rampxxxx@gmail.com>
References: <20250823075139.34797-1-rampxxxx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Add needed "@" to avoid warn messages about duplicated symbols
as there is function and struct with the same name.
- The fixed warning is:

	./Documentation/gpu/drm-kms:476: ./drivers/gpu/drm/drm_modeset_lock.c:377: WARNING: Duplicate C declaration, also defined at gpu/drm-kms:48.
	Declaration is '.. c:function:: int drm_modeset_lock (struct drm_modeset_lock *lock, struct drm_modeset_acquire_ctx *ctx)'. [duplicate_declaration.c]

Fixes: f3a808817fdb ("drm: fix drm_modeset_lock.h kernel-doc notation")
Signed-off-by: Javier Garcia <rampxxxx@gmail.com>
---
 include/drm/drm_modeset_lock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_modeset_lock.h b/include/drm/drm_modeset_lock.h
index ec4f543c3d95..0de7046dc653 100644
--- a/include/drm/drm_modeset_lock.h
+++ b/include/drm/drm_modeset_lock.h
@@ -75,7 +75,7 @@ struct drm_modeset_acquire_ctx {
 };
 
 /**
- * struct drm_modeset_lock - used for locking modeset resources.
+ * @struct drm_modeset_lock - used for locking modeset resources.
  * @mutex: resource locking
  * @head: used to hold its place on &drm_atomi_state.locked list when
  *    part of an atomic update
-- 
2.50.1


