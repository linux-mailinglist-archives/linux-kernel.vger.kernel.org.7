Return-Path: <linux-kernel+bounces-767803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B651BB25945
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 03:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22D6E583EDA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 01:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA6E230BCB;
	Thu, 14 Aug 2025 01:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKcmAvRz"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6DA14E2E2;
	Thu, 14 Aug 2025 01:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755136084; cv=none; b=aPXP5MEYhUkYtA8MFFLoendjSDcfptNLRNsc51HmSy+xNqf4Lwzhp6UohMTVXUVooiJIYgZKeResL+LSt9bvECsma0B9Bs3ndbTVfsD0THFw7MV7m0Zv2plwaJlYY3DX8osCDFgQENBZ+3ZNxA57RoV+exQXiRdL2LyQ6o9QhKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755136084; c=relaxed/simple;
	bh=tXLnEYuIqmUlSLsLPM8pRKQRuZA3/dxUOJE0ofts8WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k4cCKqwajX/d1neft+o1Lsg5TSodjRG5XnRHJzjJEhmGUlsZ2DP8V68O6/X4cE82zqsz3IP5jYIB/Cn8fz4wrovzmwckfWbr2RJGHQpgaDVBWutjwNMGibJfevaJT44PeezyNey8lbuvfP8imDySpnid3PUYsoF6tfrxNdyWTms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKcmAvRz; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3e57376f655so1554685ab.0;
        Wed, 13 Aug 2025 18:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755136082; x=1755740882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRHb99jNPH0UFBX2I07pqGevFpMjZ1DTdvtyfpI2li8=;
        b=bKcmAvRzEVEhS2V9VxlM+h8UI9OiKRk1iX37bvNRFL2cEZCh9MU9E0bY9MO6Ge59O4
         078IlXFkmqmuVsIq5nVras5fAEXHYVlkvpRuNR4XROnh8lWcUwhWV2CPY4GXIxIgeU8z
         yqQmy4DBO7YbnWgqB3LilIgEU8CZpAGOh8mCdPMlgCqLJQUYdkyVrVg9ngWblUgnEkeb
         ZcUKhjcZLlfmBD3VTXCjEDab4/TNwSZoO0kErJFvFOecB3dHQoyFxRyFnPEl4w8WZdd/
         rStFggsDAtMSPORAOk+YEHtaR8ymH6RaFLeBgq1T83csIZApF0iokXB5E2BbVV/loi74
         sXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755136082; x=1755740882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRHb99jNPH0UFBX2I07pqGevFpMjZ1DTdvtyfpI2li8=;
        b=qcMlpjlvA8bd5/IDmE2TuAWyBt9wSTcFCTveYZ8M8E0pe6Avk+5+uxauXUgT1Hd3/L
         GBUmJEi4gjYhvq2KkqiRr4LtXgc8DJBnChAV6Z1u+T2WzpX4yAzzhRw+U7cXWPj/LRDp
         qRK4Hx0U/csOX3Vu1DTlliT0LdEh2hXenjmfGcyMejnbvc0VchgJ6tPwGzK5YLkY2syM
         VUbUTiIGmYRiPIkFQRQ1xEYnwKEr43gQu2FcnqUv1xOt+sPlhe5RKfj5ddi7EefTRx3Q
         5gjcDzExKLyNaOEhFQ7opit+8OD+OGBiMA9j7mmvE9D9JbbfUcSpZP8nZ+QiOCBSqPDD
         m66A==
X-Forwarded-Encrypted: i=1; AJvYcCVj+nCBUUOoDyTp7pXx9n2rQci+6rNGOw3rpOH/X8+t7wlBPzPjdfJZuRUUb9h+RxTZnsN6Ev/pc0+t2Jw=@vger.kernel.org, AJvYcCXi9asUrH08UxdKTIhHHj3msqE0ylgt1ZReUPxoyoiOLffyXxKYu/V9kbjgy6A7WT+5KgeDc//z8vwL8hM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw41GBZ4H+tJCOOh9ilNEXyEQx3KU2AvP+1+esQKU0EBPnNn3H
	F4pTvLFD1ViTTi0xh+MIWOAaPBWPBE9aKyPIWEjn9+h/j/M9odIg/5+l+VFMiY+F
X-Gm-Gg: ASbGncv2r8lwVEqbCo4/acsr9wWP8yBbGLGahRVetw2TBBx7VmGLmMvou16ahzw1OS8
	8SYu4lH1oZDkxPn7Lo6hos/yIK6YPVaAgR0R2GIJuvYHDnW6fHuSTCLrHp5x82Frk1+iVWcmCSn
	pIre0XulekpJk6g0FdlFFzmsAc4b4xypjiAjliQbLMfr0t/J5LdwIb0obwzxqHz8yfTa2NWL0yB
	cP6pkDisIrceih34nlvvddEOH0iWyCjoFW6gkiiLlhBKX1J49kDSFmatiV6a15unGbReiroFr2H
	SuluJ2a/iEV6jUmD+i5390ahRcFxIs3rUNi+wk523wIEV1XjhB7YHJbifD+rCeSQ6Ety6/8LmNl
	7m+WSZyKM0UasiiHpfN4W98yU6qzJCHBskQnrAIKISe8W0Faij0ZV/cKlO6nEuC5VapxR6vO99F
	sRUw==
X-Google-Smtp-Source: AGHT+IHtXsnK+kBLj28/be1/0hdQ5zE1GehEVJYoBHTHj3XvV+jA9oaNZskmJcAQPEyXFOU+Z2DGEA==
X-Received: by 2002:a05:6e02:1fc9:b0:3e3:fd25:f6a with SMTP id e9e14a558f8ab-3e571e03f79mr17027195ab.11.1755136082395;
        Wed, 13 Aug 2025 18:48:02 -0700 (PDT)
Received: from localhost.localdomain (65-128-248-47.mpls.qwest.net. [65.128.248.47])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50ae9bd316bsm3938726173.46.2025.08.13.18.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 18:48:02 -0700 (PDT)
From: Shimrra Shai <shimrrashai@gmail.com>
To: shimrrashai@gmail.com
Cc: broonie@kernel.org,
	lgirdwood@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Subject: [PATCH 1/2] ASoC: es8323: enable right-hand DAC-mixer connection on ES8323
Date: Wed, 13 Aug 2025 20:47:31 -0500
Message-ID: <20250814014731.86651-1-shimrrashai@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250814012652.81424-1-shimrrashai@gmail.com>
References: <20250814012652.81424-1-shimrrashai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the right-hand DAC mixer connection in the same manner as the
left-hand one.

Signed-off-by: Shimrra Shai <shimrrashai@gmail.com>
---
 sound/soc/codecs/es8323.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/es8323.c b/sound/soc/codecs/es8323.c
index a98229981..3a91713bd 100644
--- a/sound/soc/codecs/es8323.c
+++ b/sound/soc/codecs/es8323.c
@@ -633,6 +633,7 @@ static int es8323_probe(struct snd_soc_component *component)
 	snd_soc_component_write(component, ES8323_CONTROL2, 0x60);
 	snd_soc_component_write(component, ES8323_CHIPPOWER, 0x00);
 	snd_soc_component_write(component, ES8323_DACCONTROL17, 0xB8);
+	snd_soc_component_write(component, ES8323_DACCONTROL20, 0xB8);
 
 	return 0;
 }
-- 
2.48.1


