Return-Path: <linux-kernel+bounces-820153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCFCB7D4BF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51753164F43
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 07:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8F3304BDB;
	Wed, 17 Sep 2025 07:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NLmkfube"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF9030170A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 07:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758094378; cv=none; b=HNhe0Ygzx3Rgb9thPHm1cQ0ZURyuLKxom8+H+H15zIDXTIe4Z8/quFO/K0v54gGJuu43lHogGtue9efEiwPJYvSv6oewZp0/ZnAtD8K0u70lVNP2dvIh+meD0WN++R9xhbb0jYb133HA1OLwxei/qv/7dAdKDe3QYI+y32N4DOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758094378; c=relaxed/simple;
	bh=eCYXJzo5m35j8hJQiDG8cjwLDvRfKAgYtylXrSmcRok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H9toQkn2LLS/35jmkN1a3Cs+3UJEpcU+73c5ARkSwYMAmdU3CRjAGckHHgMjPawHE7Yfck4g976Jvzu02iwXNW5+XstjSbLUBP+ZL87NEdwEU+7TGwAeKZ6IhJy40/ES4M9/iPKx/hPAUiozOvFWtdd7K2xN+WzOhqkufzc/Pxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NLmkfube; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45f2f10502fso18283915e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 00:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758094373; x=1758699173; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ivNUuHI0POvr17goW1FI7bdjUYorxzKhYbrqovFRDAg=;
        b=NLmkfubeOb+q5jfvQTPkVUfNJYkc4D32oTC2kafnoUsv1ZPHPoA+9WFwMRCtRzHfd3
         0PaGyY37qS/Dwp2Fk1xTAdiqZZnJEY8AZSZ3MDz6EBoxqfWKiz0j/udyz3PR+B72UXDR
         4EoHEphGei7Njt0Xk8OQwIaOSLvC0G85ILqaxf46dw/c62OF1Z5Fyg0V0aa4h/O2CUw/
         GKlBHUchZ1eLHq3csbrKM+jTZ8YGiNBTyIb14ljYBK6SMMbWW1Ye7V3tFExXheLnZ2BS
         +cKQD5LSP7va6suv1IRsRDZe7whQfIUTwe0MAU163+h3BSZWYAjo5j01XDpKmlq3QxTP
         kkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758094373; x=1758699173;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ivNUuHI0POvr17goW1FI7bdjUYorxzKhYbrqovFRDAg=;
        b=c9bRlEFsWZFgGZAFYdj1ii70F+OdC6uQS4HrjX4Iih9fDP1RKxN4EPaGAxjNnZv/3D
         F5TgjRoi3v+p+og2WcYCUe62G7GJyxxQ0jMt3js8sktnvR/A7Wu7r60Tw/yRNN2JPyI6
         ldQz2mB8Ci/GXNxlGQytq9XS4aIcb2l3mKZ7eANezs+fynhSkT+qUtfQl03XkpAQjH5J
         WckOSMdbn96owgwZmDk2tzz62+mUJh8cn0OUTwwzYHXz35G0bMIg78H0d6b8F3FBedHS
         gutortqdhpeBATsDa5Ilck0o8cVB9xj1uarFqC5NUYwArbPy/tUVBmKL/Z4NmJMOrC+X
         MG8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVo5bpIq8AFLdiNPLmAizEuyynhwnb+afZOip/F8epz40XWNyVZTvLCMD8F9OXqxZJNch9EOXqqkjliJyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMEAAupqHhhrrRjg+1GeGlMtT4vykl/pV7F+6l5pss4TE/lpXK
	5MuyxOZq5+vAFowPPLmgH0TYZBbd8EkFK47fv7mfBTgfRw6rOMoWMfMRdVN72VR9/n4=
X-Gm-Gg: ASbGnctBDVkjrvCnqwYnNQAE3VWw5KybYSzsNhs6ah/HEeSmptn6MJP4mIr3u7B+Tw3
	npQwgcXpDl10tGVZ/2G08uwjrm8zK3FDwNcZ2hvvjpA5wt3tXF695zoz1+e6UQxvZE0AyfCrBAC
	JoVBdwvy+RTF+xCw0LAQMK5eeYgq39lXHeclBS+vDp30UIy9TTDiOzvVxrDZ0em8B8UGubLxiC9
	K7VnHFuk9pmEKtP7YHruOxYZ9qYUJiflT2mpwjOgzX8fRmRQ79P2gI4lAnx0RL1zX7ILpz26BHW
	DCot93lft2QLbTgQL74zbfrnZUuFIkHVK4QMY90NqxgMvCX25Bw6H653DVBbXRS+OTbIBYQBDHW
	eLxFLtg8nxRAcLl13Dh11dHlMgV0l+Sy1ysrRhw0=
X-Google-Smtp-Source: AGHT+IEDokaqI9K94dDKvvgnGzxx8bF/zgdMFVrvUHzAt9R9Nl/uLKSr4AYRxA++O9rkJ0BNXhJagg==
X-Received: by 2002:a05:600c:4ec8:b0:45f:2843:e76d with SMTP id 5b1f17b1804b1-46201f8a9f5mr9858205e9.4.1758094373157;
        Wed, 17 Sep 2025 00:32:53 -0700 (PDT)
Received: from orion.home ([2a02:c7c:7259:a00:75ac:2ea2:dfdc:89c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613eb27f25sm25442035e9.23.2025.09.17.00.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 00:32:52 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
Date: Wed, 17 Sep 2025 08:32:50 +0100
Subject: [PATCH v3 1/3] ALSA: compress: add raw opus codec define and opus
 decoder structs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-opus_codec_rfc_v1-v3-1-7737ad40132e@linaro.org>
References: <20250917-opus_codec_rfc_v1-v3-0-7737ad40132e@linaro.org>
In-Reply-To: <20250917-opus_codec_rfc_v1-v3-0-7737ad40132e@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Srinivas Kandagatla <srini@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Patrick Lai <plai@qti.qualcomm.com>, 
 Annemarie Porter <annemari@quicinc.com>, 
 srinivas.kandagatla@oss.qualcomm.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 kernel@oss.qualcomm.com, Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, 
 Alexey Klimov <alexey.klimov@linaro.org>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
X-Mailer: b4 0.14.2

Adds a raw opus codec define and raw opus decoder structs.
This is for raw OPUS packets not packed in any type of container
(for instance OGG container). The decoder struct fields are
taken from corresponding RFC document: RFC 7845 Section 5.

Cc: Srinivas Kandagatla <srini@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>
Co-developed-by: Annemarie Porter <annemari@quicinc.com>
Signed-off-by: Annemarie Porter <annemari@quicinc.com>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 include/uapi/sound/compress_params.h | 43 +++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/include/uapi/sound/compress_params.h b/include/uapi/sound/compress_params.h
index bc7648a30746f4632ecf6695868e79550a431dfa..faf4fa911f7fc2830c3ae42b93650fe40d8a776b 100644
--- a/include/uapi/sound/compress_params.h
+++ b/include/uapi/sound/compress_params.h
@@ -43,7 +43,8 @@
 #define SND_AUDIOCODEC_BESPOKE               ((__u32) 0x0000000E)
 #define SND_AUDIOCODEC_ALAC                  ((__u32) 0x0000000F)
 #define SND_AUDIOCODEC_APE                   ((__u32) 0x00000010)
-#define SND_AUDIOCODEC_MAX                   SND_AUDIOCODEC_APE
+#define SND_AUDIOCODEC_OPUS_RAW              ((__u32) 0x00000011)
+#define SND_AUDIOCODEC_MAX                   SND_AUDIOCODEC_OPUS_RAW
 
 /*
  * Profile and modes are listed with bit masks. This allows for a
@@ -324,6 +325,45 @@ struct snd_dec_ape {
 	__u32 seek_table_present;
 } __attribute__((packed, aligned(4)));
 
+/**
+ * struct snd_dec_opus - Opus decoder parameters (raw opus packets)
+ * @version: Usually should be '1' but can be split into major (4 upper bits)
+ * and minor (4 lower bits) sub-fields.
+ * @num_channels: Number of output channels.
+ * @pre_skip: Number of samples to discard at 48 kHz.
+ * @sample_rate: Sample rate of original input.
+ * @output_gain: Gain to apply when decoding (in Q7.8 format).
+ * @mapping_family: Order and meaning of output channels. Only values 0 and 1
+ * are expected; values 2..255 are not recommended for playback.
+ *
+ * Optional channel mapping table. Describes mapping of opus streams to decoded
+ * channels.
+ * @struct snd_dec_opus_ch_map
+ *	@stream_count: Number of streams encoded in each Ogg packet.
+ *	@coupled_count: Number of streams whose decoders are used for two
+ *		channels.
+ *	@channel_map: describes which decoded channel to be used for each one.
+ *		See RFC doc for details.
+ *		This supports only mapping families 0 and 1, therefore max
+ *		number of channels is 8.
+ *
+ * These options were extracted from RFC7845 Section 5.
+ */
+
+struct snd_dec_opus {
+	__u8 version;
+	__u8 num_channels;
+	__u16 pre_skip;
+	__u32 sample_rate;
+	__u16 output_gain;
+	__u8 mapping_family;
+	struct snd_dec_opus_ch_map {
+		__u8 stream_count;
+		__u8 coupled_count;
+		__u8 channel_map[8];
+	} chan_map;
+} __attribute__((packed, aligned(4)));
+
 union snd_codec_options {
 	struct snd_enc_wma wma;
 	struct snd_enc_vorbis vorbis;
@@ -334,6 +374,7 @@ union snd_codec_options {
 	struct snd_dec_wma wma_d;
 	struct snd_dec_alac alac_d;
 	struct snd_dec_ape ape_d;
+	struct snd_dec_opus opus_d;
 	struct {
 		__u32 out_sample_rate;
 	} src_d;

-- 
2.47.3


