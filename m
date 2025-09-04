Return-Path: <linux-kernel+bounces-800507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3454B43893
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7997C5A26D3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37E62FD7C8;
	Thu,  4 Sep 2025 10:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XApCXX6N"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6159E2FD7D3
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 10:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756981137; cv=none; b=OmtuFp++7sX7bSRnmkm1R4M936EiWAeq1oBKU4I5htf9bqStkakRfJmQLqSoOuOWF5vp0ufbzoAXcnRkco46s/41ip1QbJisLQaUWnvSHU7P9DgeFmAtRm5lHCZmypNc8SHTlxcjHWZo76+UIHLnXfd1M75YL8tz2HhyLkPLSkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756981137; c=relaxed/simple;
	bh=0z4DvdjsLX6ePogBY1auCiBA6lQ5eI1Z0Og0lwAREbU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j2gNad/GhmnYMSYCeyZ971INJA37CIqfLByjkqNo2nA3+Yv2fmRVhrKfZIPQ8DHKxtLBzn2zxe7IpaQPrbvfF8C0v1IINVxxxXQgrLcij8Qvq6sR7UmVAUKy1kzyQ+XM0d+gl1LKYObEYWT/wf6DQf6nISUmMKJj09jHtU7GO9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XApCXX6N; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b0419ea6241so7987666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 03:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756981134; x=1757585934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=788DvyHs5EODeIANR32XpfigfVcSqxiFxI3EsfOqEDI=;
        b=XApCXX6NeNhNAvhmv8CVw75krY9UpYhjvZTYa59GqJjJPe/TOI8//VN5zgPEHK1BJI
         QSs7lI7/izZE87KcZxBE/eR6DcLe8vuE7ipf1VZpcZCURX2sjonDp3yXj4cqZu+0nreR
         0colCHAEN4emV5MzJ/TLPjVYH/fQf0ECbzthOIAjTtcCwQutEArATKMTtZfpYVD9f3z1
         EwYofra9Qx/hmCKqnHcAI0wICaH6bNAjVW6gkKgKjcsl2BU8RYvo6LPFOwC+I1ZSm77k
         KWwNFEa4KWsL3Uq0bOHmPfJvXwx+g9Q5MwY7K7MKfcdz7xFlabxX5uNJK0tVZQ/n/DP8
         /zwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756981134; x=1757585934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=788DvyHs5EODeIANR32XpfigfVcSqxiFxI3EsfOqEDI=;
        b=Fc2WjjuBPXT6PHRRp6tXmVmILL1wFDkt5ITxBgyx7NY/sBvfiaskqzgtp6jq9Npo3J
         NFqhZMHZujeyNRiXteXuS7aJs9MdUH6EnWtgPSVkHTJmVud4PjAx+gzvZhKxiKRNL7q3
         mWv0Z1VSWeY70o9zzBxId42yigIoKwG/yZ8dgukDYb8R1YPlsgWh4Fp4oIkB7YzQi8b2
         yJt5w4AZfUCqHAkboMTg/2Htx0kx5XSrvKecqPw4FNhHhyyKGXfDGp7GJMVPB1BnJ9em
         4N3F2BWeGfhoXh963KdTw6OnI8QpfwmyRLPgm5NpL+LWDf91JqvCPvyF6M+1xiXwGsSs
         OlRA==
X-Forwarded-Encrypted: i=1; AJvYcCX+Sci9IqR6D3rRbdH5GTTRn+u1OwYPWrDl4YWP0KslEdV6ieqwL/bF6ZHBjVsXyXaYQIe6SmPqBbiKSK8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm3e45JQBtsqBimDpFWB32zt7hzwb8N72iy6GGYC9cQEG8rEq9
	Ya5gnv+xew6d9tJaI9x4q6tsjAh02p88wOeCLKhnPFStGBJDYvNPmUgO6yXLVT05PPQ=
X-Gm-Gg: ASbGncuscdD7bG9tlF8NkxmmoGpHAsIbt151saQ+hfXSzgsqvYoLknSTyitfem9g6XG
	VJeLawbFI193ynCuFs7zAwZ99zfO36A/fyDv0IFquWRKB1M7BoHHLiRHkk7+Ox2KcZ9F53o1Bio
	KmFWqg2GGETOrEffRcvqihoMxAT88R2iY+1cGM+G187e2qZaDetEGmTn0y523xUtdTFI86M45IY
	DAvqBpBNoJ/nrxQpMEIOe5jrbkU0yI76PQR681xgNJ1sh4RDddMt6ooLJeTJ3vTpaW3QWRgwLlG
	qvGD8gkKiXP1tBN3WmnofogoXIZNtaILqRp3mX44aURfRLGUdnL3uprEpKjUXbIAjbhhbJn4AbV
	lXBRtNta23D40KEe0hd1rJDoxn7V+pv4zHEM0pWuacMiV
X-Google-Smtp-Source: AGHT+IHWntgtcODAj/7kFve1sXTz2DdTGamGtUT21D8b3aznENuQ1mZPsX7EylSYmJeT9xBCC+l8AA==
X-Received: by 2002:a17:907:25c3:b0:afe:b131:1820 with SMTP id a640c23a62f3a-aff0f01e9fcmr1044118066b.6.1756981133581;
        Thu, 04 Sep 2025 03:18:53 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b041f6fb232sm1103667166b.87.2025.09.04.03.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 03:18:52 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srini@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] ASoC: qcom: q6apm-lpass-dais: Fix NULL pointer dereference if source graph failed
Date: Thu,  4 Sep 2025 12:18:50 +0200
Message-ID: <20250904101849.121503-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2051; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=0z4DvdjsLX6ePogBY1auCiBA6lQ5eI1Z0Og0lwAREbU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBouWeJllIVY+hQGdNqHZvj/tioDr963JGTfjhCS
 P6pL6DYWlOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaLlniQAKCRDBN2bmhouD
 1xJfEACRVcFni8dKH4V2yPLhU+lrF63RMHnlRzgHV9jmPHmN+MvF6Q2Kz+dfrN9qSOaI3EQjmUq
 qtnY7eUeCe7aPA3eUdRBbqaoumyMc56M7YQW6HWWVHBkpHQz5xipIT7lJyIUSJ7WGlr0xFJfnLa
 TBi/sKAZKgvvjhfKe6eXwSxpl2/L1/hQ6BnWrURJH1bwxDyJl6j+wm7BNxOo6QJgHQc/J9U42u4
 axXFpApSpaZ71EZIyaiyo/PdYPX2EULNm8C+gOFIrsggipVxt7oYTzEQhogJtblISh3H/rtBEQ+
 vqNNlphoEEpCnwfrKdGYIKiOU2S3xp/QLm3AQCxFKSSIbg4q7PHl8mCsiIaXVRQAtVoBuDguZ3/
 CwlY4Hl+zI9wsNdWh09G8+C95WOGbSQul5LWEzq+eNlopX/2r/50m3Yu3kmFNqEARid/PtgtcrC
 OJTMRJW4Ohhsi8HGf0GFyv1LAl2P8xu4RUwVL/4SP2MzMg7iazAlZbbXc05O9BCvfP6s0JI2Yu+
 KNh0uP7oXCAKQ7Jt5J4zGI0376RuS4fEgVofTdSYnHZi+9OQES9Ww3Kps13xIS96+9zrNe/j5Kl
 CiC85g6WdbLDFSEg0I4eZ7bpdN4Rgj8GFOVVUYgLJqFXdb6q0LLrAJqodNUAVjtAeSAgitAbAhj ywZWoUCPOGTRV5A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

If earlier opening of source graph fails (e.g. ADSP rejects due to
incorrect audioreach topology), the graph is closed and
"dai_data->graph[dai->id]" is assigned NULL.  Preparing the DAI for sink
graph continues though and next call to q6apm_lpass_dai_prepare()
receives dai_data->graph[dai->id]=NULL leading to NULL pointer
exception:

  qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001002 cmd
  qcom-apm gprsvc:service:2:1: DSP returned error[1001002] 1
  q6apm-lpass-dais 30000000.remoteproc:glink-edge:gpr:service@1:bedais: fail to start APM port 78
  q6apm-lpass-dais 30000000.remoteproc:glink-edge:gpr:service@1:bedais: ASoC: error at snd_soc_pcm_dai_prepare on TX_CODEC_DMA_TX_3: -22
  Unable to handle kernel NULL pointer dereference at virtual address 00000000000000a8
  ...
  Call trace:
   q6apm_graph_media_format_pcm+0x48/0x120 (P)
   q6apm_lpass_dai_prepare+0x110/0x1b4
   snd_soc_pcm_dai_prepare+0x74/0x108
   __soc_pcm_prepare+0x44/0x160
   dpcm_be_dai_prepare+0x124/0x1c0

Fixes: 30ad723b93ad ("ASoC: qdsp6: audioreach: add q6apm lpass dai support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Use approach suggested by Srini (you gave me some code, so shall I
   add Co-developed-by?)
---
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
index a0d90462fd6a..20974f10406b 100644
--- a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
+++ b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
@@ -213,8 +213,10 @@ static int q6apm_lpass_dai_prepare(struct snd_pcm_substream *substream, struct s
 
 	return 0;
 err:
-	q6apm_graph_close(dai_data->graph[dai->id]);
-	dai_data->graph[dai->id] = NULL;
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		q6apm_graph_close(dai_data->graph[dai->id]);
+		dai_data->graph[dai->id] = NULL;
+	}
 	return rc;
 }
 
-- 
2.48.1


