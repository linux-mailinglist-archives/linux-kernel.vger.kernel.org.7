Return-Path: <linux-kernel+bounces-859040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C168BEC89A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 08:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 315A54E2D80
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 06:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01441283151;
	Sat, 18 Oct 2025 06:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CljpQGQc"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9927F1A5B8B
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 06:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760768715; cv=none; b=uE9wsA7dEFedMj9PZLtEOv8qGiuJJ/f4pdphXPqxDk5eyBVQ9n+K0n0N37Qk18t/g3kIHE4vTk+PTgDtdA4w8XigmcqglWnh5FFIFuAWFtzwQhxUcQ3WJTxTwC9F/hu9JhEKEsvzIntoySuhvH51QOLmsRqvtbDRdeVECB5pER0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760768715; c=relaxed/simple;
	bh=bBK06m919fcrgtih+JVTXodl3XFTa8xsFxWUlcI5j+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jGMDSDDVFBKxpFOB5tnoa/0xIjHxi9Xo+IJgu7ttkADN3JSM8n7adwtwuWIzigW86PUHlYIpSGLvhL8Xe8vbNyobgq9eTRD51gHMgZH2T9OvePpzzsHLSuhNee7fu3ob2P6XpQlrK5sGcgiB1d11YJEZyrHK++ZexrO+QNa4nXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CljpQGQc; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ed20bdfdffso2453925f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 23:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760768712; x=1761373512; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IOjOlRS5epVikQ4z5SQ9kGD1JPQvt2c8mE5ArTmJEf0=;
        b=CljpQGQc/nyojHlCfT0Ze05TRRzMSN1Sv15PowzH9VCFP9SB3ErGTQqamPNTcYHyt2
         L6yKPlR0I9k0zxC8HmHh2wxreJuG0FjspGTTicgBFSpSukqin/X04ZpSIitzn1dRLtJs
         xKBMlEnUus90vuYRvETno0wEZ2zZsFZ+5vIkwRxqLKiHQtSLU5IE9c3NnAAK/sXemuGc
         3oe+GxDsqpltFJDk8/cfVvF2I2ffN5TYgicuwhKfa/tkkhkIGebTJGYcL7F7BhSo3OrG
         03d41S/cevvzBO96d7dT46fsPovofFga7826q5TRrFlIY2quaSnFWbaFkwdxlURTbfC5
         gvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760768712; x=1761373512;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IOjOlRS5epVikQ4z5SQ9kGD1JPQvt2c8mE5ArTmJEf0=;
        b=V6b4+/AHewHW6jO+qzIMAKeEgXNS/5u0h9Nz+W16GX1bX/Mnjytgy1mb+syzfRlXVU
         +LyJE2HcbOBgKDDKLrDK+Pu4MTjxedPpL4siPfx7gZcURPdS+uL9Mltr8R6VYsYCeKmq
         j/5ZN8xseV9tZdSRcsHLs6hHR544zAE2UY9iyGRu5nuEvIxZfERNf2HQukc4BzJ53GIb
         uSvhzkkybw9wBBZavRhOaCEDcrPVh86pnWiwNEtMMZdiKLV0b3bE1DgRpql9pVUAi20y
         Nxg+Xmc6BhNU4H3J93H+9KC/OaDzygf0j9nEepELo5jJHpIFqPLz6OwunzT2BEFkC0u5
         NlKg==
X-Forwarded-Encrypted: i=1; AJvYcCV9PrHgZwxsV3MxHzb4oxJOmld2IVs6YNHiruOo6kpIXnMm9pZ83UidObc/E12X3xJ/yh79blRunGn9e28=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmGSZ4XddJ0dnZZ5AT/vVLGV68yTHpWYcHLGCwz0JZ+M+zj0iP
	SUlw0j5ao4S5z6B5BR5FXN5RQ1+KxFIAx0qIlbG9fOztZ54KAAybMOF8eFif+uRGjys=
X-Gm-Gg: ASbGnctO+JnRw/9iQkRebmprxi5pMJPRFqgBot3lOJ13CAnjyjPc1I+aM6tcZ65Faq+
	VsWdhJmAbHwWiDY+ZFwHQ07PpyzfTXfr1B4afNQJoUgBC0/1sMljMzhy4XsyavrFyxqe6PMYIww
	uQ8VGM1+u4mNg6z7lVlZEa+6JNNxVZc8meSsxSDsW8IangD27B5aNMgl6YIyN52MTCttUdqvRks
	Yn3KzMQCvHlk850U1S+Iou06oIMXl8hoCT6yuu0lqfoZQQWRMVAlzRYEmeZZfLjyJSKLsp44m7m
	geHAiYVy0tLzxqgZDo7zyhxvIVyl0wd9UxMdguimy2vE2sTRNK/dDEXXEGYueKKcl8qjDhH2WTR
	ZUGCiQQ/DzQ999qHwm7ayyQfchxCynk73uPfIMwzCGYZcDGITa9xUdlZerGF+tvUfADM9Ay+ujN
	Qgjohfbw==
X-Google-Smtp-Source: AGHT+IHiJtFCilIcqVXt1blvDDyHCgj8C07mXYG9xI18dPYdiNmhymktEi4vcR2/aM4gupMNGoVXIQ==
X-Received: by 2002:a05:6000:26ca:b0:428:3c66:a013 with SMTP id ffacd0b85a97d-4283c66a3f8mr683531f8f.55.1760768711850;
        Fri, 17 Oct 2025 23:25:11 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-471144b5c34sm126120075e9.10.2025.10.17.23.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 23:25:11 -0700 (PDT)
Date: Sat, 18 Oct 2025 09:25:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
	Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>,
	linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] ASoC: codecs: va-macro: Clean up on error path in
 probe()
Message-ID: <aPMyw_ryay9LA5SW@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Do some clean up before returning the error code.

Fixes: 281c97376cfc ("ASoC: codecs: va-macro: Rework version checking")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 sound/soc/codecs/lpass-va-macro.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
index eb4981255f2b..77a372dfb117 100644
--- a/sound/soc/codecs/lpass-va-macro.c
+++ b/sound/soc/codecs/lpass-va-macro.c
@@ -1632,7 +1632,7 @@ static int va_macro_probe(struct platform_device *pdev)
 		/* read version from register */
 		ret = va_macro_set_lpass_codec_version(va);
 		if (ret)
-			return ret;
+			goto err_clkout;
 	}
 
 	if (va->has_swr_master) {
-- 
2.51.0


