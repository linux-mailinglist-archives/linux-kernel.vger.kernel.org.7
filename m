Return-Path: <linux-kernel+bounces-864096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAA3BF9E50
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 05:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE4F556057D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 03:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DDC233128;
	Wed, 22 Oct 2025 03:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dFRM3Pg0"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56021350A21
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761105537; cv=none; b=d8GzHBS7bmJ5Fq3LkqCc0FWxutH8An3aDT/6oGWiNmrO9GqoIhWtqDSOSFf6QADBHpQzY6gBKFuSA1CbmJa5aPqmg3pidX1rfoeoiBqQHRMwZgAVU+D3O0weyfeGXcgI15hkK8GegpPwNIzwHgzUS8F8tbkWY0Miuc5M94U8xhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761105537; c=relaxed/simple;
	bh=eD3Ij+lZtQ4DnXw+Tr7kovgD0K44T1dMGiw6LsDx7yw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QnKStzLjNUUw5YjqVH1Kt2JD6kQTVWwbWrbWrvcWcSBe6hs/uoALphI5EqQ/gzuG89nUgwMfm8ENEd2KTHVIWAxhlXRObCY3474b5r93TEKwDQsdd2W3O832E8M+vNQkqrNc+NMnt0NU558PkZ2agSjoisgmmi8SHcasCvn6fjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dFRM3Pg0; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4270a3464caso2724903f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 20:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761105534; x=1761710334; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o57tAm9bEj69a+6wod50M/v+YTegpl9/ax57TD+w3u0=;
        b=dFRM3Pg0f2OFxMUtUgawSWaBCgTFe1/4ZI/QAe3QXChhMl4VFst0EfQt/udHx0JzUJ
         H25/8moVI2BLRyT8JKcK08/89aAjAM2zEy77JGWOU7RIOqFi9hyUBEqEqPuVePc/3aHd
         FD1uNNvSgmIjJEe01WBsIFK6bTiflR9lCPj2gW1OagZK/IXd/x89ACAP7gH8ewiQi5iv
         7ndKUoUDpuZSfeSWS0NeqI7AtCbZkDM6YNpSFsKMfT2Z6di0fHc/T91jo635XL7q81/6
         BmqW/25xVk2lUZWRN1UsxGtPtZlQYuPUrvIaRHj0bSWQiSmd8fpF6WAnJFldFupmqeVo
         rkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761105534; x=1761710334;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o57tAm9bEj69a+6wod50M/v+YTegpl9/ax57TD+w3u0=;
        b=s2S2lU2VUD9T287xS03+A2b0TvOLFJ/FuNjJD8u6SVPsSGpWnacAvtUzD59RjWyBgW
         qpooAwdEfTW+drFS3r+m1W/7yGGAau6Z07oJ/jhq2xMKYIU/UlA/7JF+yCVe49rPFoFG
         Jssb/BpYFeIvKv9XHx00+hCIXRFa12gFWQs12Dbxy82GSsgiTZk6Ojzjznw72XzbLtw3
         fRzSrAM7CPii4gV9z9C66e6nHW2+cfDOykGj9MW6FV6HRBWTEYIOyk/9C5s/TXHwPWxl
         NBVzPB5HrJFA98CfTl/lWHQDBYmpFp/1BfzTLOgUpObjFWrgDQ/bBFJR+7z2CJtvGCEE
         6wSQ==
X-Forwarded-Encrypted: i=1; AJvYcCW//n5T8ZkP5Bt04zzWVILdPN9Hm/oXgou9Nx52i8ceDp4KN1Jizdsfm0GqQA2JBO13s5xAZEaTd6QZ340=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWhZNxRR49oXcuItBWzAX0v8YmtvYkUlvP6SyeZX9yfzsWVo6R
	aJy0D885Xd4jCd8MHMSuY7xmrRjtjJ6qYrvY9/pgu3JGlEYURR6IiXupaznqjn4tsck=
X-Gm-Gg: ASbGncuay2i0WtiL8nAqAlONKlCEA4VbgzpRkyQ/uTGF2VJjZOe8nPLbd+Bh9iL0Jrk
	PYjxzuY6rO95veOkQ5eQbwKRmsVUb5e3ZShNlaxCoXYh+04ryF7N8oz6oGr8u4SUnpPmbeQz0+D
	zqdfIld1LPQSTMRq/VnBVRk1GFwS2FgKZLjnluPbbHidXK/CG89RCv5pQkrHUBOK0IZnJkGktE0
	dqGdHMlIbuhQhkEmiWlDelXu8adDs6vv4ZXr8kydnU3oMaIwrw/5Pmi+0NAjQnMUi7rTX0qLI7E
	oE+HC5rOXD5NZP5QVftdKdEBbX2chAwD5sI/XcmGPNNO6b0edSpj8kRCWKgzI1Alyg0YGyqN5Vt
	NXMPFU6saenOsVXMVPiiJtG5XUfHvTpjD0BHz2CL7vRZf/ksRNt1FqwCq7Kx9USwG8yj84qn+X7
	SULbDOPzkt6xOQGx5q
X-Google-Smtp-Source: AGHT+IGn8Otegez7YT97/Q+RL+NH5eMmlBzrdp9SHgbeYCrM+gFyib3bAAvmS/oihsg0BsFmBaDKFw==
X-Received: by 2002:a05:6000:22c6:b0:3f0:2ab8:710f with SMTP id ffacd0b85a97d-42704d83514mr10579228f8f.8.1761105533675;
        Tue, 21 Oct 2025 20:58:53 -0700 (PDT)
Received: from orion.home ([2a02:c7c:7259:a00:11f4:2b3f:7c5a:5c10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a6c5sm23637639f8f.28.2025.10.21.20.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 20:58:52 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
Date: Wed, 22 Oct 2025 04:58:49 +0100
Subject: [PATCH v2 1/2] ASoC: dt-bindings: qcom,sm8250: add QRB2210
 soundcard
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-qrb2210-qcm2290-sndcard-v2-1-32e9e269a825@linaro.org>
References: <20251022-qrb2210-qcm2290-sndcard-v2-0-32e9e269a825@linaro.org>
In-Reply-To: <20251022-qrb2210-qcm2290-sndcard-v2-0-32e9e269a825@linaro.org>
To: Srinivas Kandagatla <srini@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexey Klimov <alexey.klimov@linaro.org>
X-Mailer: b4 0.14.2

Add soundcard compatible for QRB2210 (QCM2290) SoCs, where the older
non-audioreach audio architecture is implemented.

Cc: Srinivas Kandagatla <srini@kernel.org>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 Documentation/devicetree/bindings/sound/qcom,sm8250.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
index 868acc077046596120ea7f427e802282ed03c853..15f38622b98b904c4107f4800cd1a4159191fda9 100644
--- a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
@@ -39,6 +39,7 @@ properties:
           - qcom,qcs8275-sndcard
           - qcom,qcs9075-sndcard
           - qcom,qcs9100-sndcard
+          - qcom,qrb2210-sndcard
           - qcom,qrb4210-rb2-sndcard
           - qcom,qrb5165-rb5-sndcard
           - qcom,sc7180-qdsp6-sndcard

-- 
2.47.3


