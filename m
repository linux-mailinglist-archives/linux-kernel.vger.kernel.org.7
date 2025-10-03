Return-Path: <linux-kernel+bounces-840998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 936BBBB5EEA
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 06:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D2593C7E18
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 04:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5CE1EB5D6;
	Fri,  3 Oct 2025 04:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHc4/yTZ"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023D3C148
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 04:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759467593; cv=none; b=EoYza1/W772oTr3wt97ZAbSqhJnaZJxowe/XqSaY+fNav8NbQohnwiY0fjhhOS+ZWonCHdNRszzpeJXaZ6K/iy4G/ss4u3dmWglPQo0dMZdQ4/NNL752fDX6IR1c9k2L3SeFbExOyXHucxNPZCGyVW5QXV1uu9SoEQCEUGOMNjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759467593; c=relaxed/simple;
	bh=SDibelJ8WaN+m2Nw635MwP9cYpqavCFzJAbryqPuKC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oz6BAbIOlbi8yGoOo0QUeTkxJ/XrXLYARBIsxDArs7EX+wqqht3sieqv+DO9vn3vUCSFnGoiOEKo0ZsZ1zscCSjNGWHcLshhRXvH1/DaSKWw7uMlRhaiVu9FKwYAfur53nd+zN8fjwTPCMngqs/H9BzSlxueocG696f68IJEPBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHc4/yTZ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3fa528f127fso1294472f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 21:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759467590; x=1760072390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ezb2+W7XUTivwDtpbnZX14PeKRgmQOtAgQZxnhbhRD8=;
        b=AHc4/yTZFClkV/wAU7t4GhiH35jOI+Jwty3SVl/Nb+saNFTIptmUf1sSzaMDxWWQvs
         S40/p+29XiYMhZtUa3EFR8srATAUnMwyWJAiGg8WU6s5xMTNVxPj2/YeNHmIHqicFA7E
         VaK5Q0Z1xR71GVqx/3eonYILGhl3mttTsFaoNyn7JfwHO4r2orOjznl/1sL0JXCuWimY
         1C3553m1EnOMCBJ6adcWi/wkaHiMTIgrDSi13RiAfxKMUO/e4NvPd97+2P9gC+KY2XuW
         r7Jx0lp/EUHyPSc/v5OcDJQR4i3ATlSAtnKDiTtJ7cZrLlLBbDueo573hqhqn5k2imaG
         s63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759467590; x=1760072390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ezb2+W7XUTivwDtpbnZX14PeKRgmQOtAgQZxnhbhRD8=;
        b=FFvq16pCUTMT8RoUvLnLMEvmRrbjLWwpYB0qaygrfcocJQ3U5P4VsAfVrYTAOAHtJs
         49szXDaVJDn/SZ2gXxFESwWSC9Glyn5YovgjTkg47FpDRVeFX9J6KCCu45zrzs56gpwn
         u90l4PhJ3Lw+tbHmxYgtwygwx1f2mQUZjym3zJY9wRA66+jPjy9rcgg9y1RNi8NdCa9R
         6M2HZumREmUrADvHeAeYzLbH+zQQdH7jTMvhcqIYHfrsuWqluGBGrL0eZez7R2oJHeE1
         gsrxB36J8kXjkNgblap1ncNWjq3i1yVb2LzP+3KzCDlhcd9TXDkXXieI5WZXBWGf9LvF
         1/Dg==
X-Forwarded-Encrypted: i=1; AJvYcCXO2tBgsrHPZZHRg2vWapia7679t5DcR6y0T/vKWIFe8iuhsUyvSl8Xt8h8V/6KmJ+qYbKvq5wS7lAK9JQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAF98tPJO2nP1/E6qzyFzpHYyjtwwp7mqiyFyVnvCBFN8LgWVp
	n/NXlJIfunm7MlpBg6Aqvd7X6YHmhB7WjZJKXhI0kRIl/pRRp2md52m7
X-Gm-Gg: ASbGncuCpQdtjMh8MwWl9NZGmEL+EXLVGXt5CENrGqqWyCsXfYZyJH8EJ/zrQndNROq
	cN7cv73bz8tK+WFm+zQX+qFTUNxGTKw+wc8mkRLa8qh3u3doOQKcGbfEHf/BWiAGNjTysQE9FNC
	RwrKvxxMlcv/qjNUU9Jp/rnafuMSphM6sBZQjz0g74D7QHNJemwGgWOsFF2Ldy2k9ehpidTMefk
	Ku8BMQJhw+9nCQ4oNi2abO6qtyrTx3mHSUMZEiChM80lhZt8n+rag27c7BQx3W9Wz42PkxKhIHt
	QKDtjW0eK2JGlHsr2MuAPslWXKquse8U/HNV0c7B17sKM1CuRaLmJgsxyBLWl93L9XoQT/UC+4I
	yESNbnFDiOQ2Z+9vPQSFcdQEB8YrP4mlf1XUqEdNr20Z6bA0X5l2fhGKW2ywh
X-Google-Smtp-Source: AGHT+IF9fKIKwqtZdSmzz23uYKOPh0PHkyguSU5Svn97r7CPyqV0UeMbltYUSMgZAhnK1oo3NKfhbQ==
X-Received: by 2002:a5d:584a:0:b0:425:58d0:483a with SMTP id ffacd0b85a97d-4255d294cb7mr4009234f8f.3.1759467590083;
        Thu, 02 Oct 2025 21:59:50 -0700 (PDT)
Received: from gmail.com ([136.226.167.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a8542sm6242734f8f.9.2025.10.02.21.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 21:59:49 -0700 (PDT)
From: hariconscious@gmail.com
To: lgirdwood@gmail.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	daniel.baluta@nxp.com,
	kai.vehmanen@linux.intel.com,
	pierre-louis.bossart@linux.dev
Cc: shuah@kernel.org,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HariKrishna Sagala <hariconscious@gmail.com>
Subject: [PATCH RESEND] sound/soc/sof:Use kmalloc_array instead of kmalloc
Date: Fri,  3 Oct 2025 10:28:50 +0530
Message-ID: <20251003045849.1172-2-hariconscious@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: HariKrishna Sagala <hariconscious@gmail.com>

Documentation/process/deprecated.rst recommends to avoid the use of
kmalloc with dynamic size calculations due to the risk of them
overflowing. This could lead to values wrapping around and a
smaller allocation being made than the caller was expecting.

Replace kmalloc() with kmalloc_array()

Signed-off-by: HariKrishna Sagala <hariconscious@gmail.com>
---

Resending the patch

 sound/soc/sof/ipc3-dtrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/ipc3-dtrace.c b/sound/soc/sof/ipc3-dtrace.c
index e5c8fec173c4..6ec391fd39a9 100644
--- a/sound/soc/sof/ipc3-dtrace.c
+++ b/sound/soc/sof/ipc3-dtrace.c
@@ -126,7 +126,7 @@ static int trace_filter_parse(struct snd_sof_dev *sdev, char *string,
 		capacity += TRACE_FILTER_ELEMENTS_PER_ENTRY;
 		entry = strchr(entry + 1, entry_delimiter[0]);
 	}
-	*out = kmalloc(capacity * sizeof(**out), GFP_KERNEL);
+	*out = kmalloc_array(capacity, sizeof(**out), GFP_KERNEL);
 	if (!*out)
 		return -ENOMEM;
 
-- 
2.43.0


