Return-Path: <linux-kernel+bounces-778556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5182CB2E752
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 23:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D18AA4501
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 21:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2742DAFCB;
	Wed, 20 Aug 2025 21:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qp3FEFXK"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78E326E71E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 21:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755724575; cv=none; b=LvLDk1vGCBFjB4NYJipa1m7y0z47rb27xBo2j1G8ImDlqvM0zdVVJZNzRwGypd9niXL5RUVqdc/gUiS3LVIK6v5+dOGOJrFhyviCqcVRFoc1bcSTMQ/dzVh4HKWrss/xSvzaFcj4NxzCvAhpQP21+iKKhGOQbVD1jzyAG4l1VVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755724575; c=relaxed/simple;
	bh=x/i6YSno0uZn+m73vZYG7p5SK1WjGPZPgx8s0L4S1+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C1/nJKAl+v7mAbgv1gn5FXZXECxmF5TUAAnkO19dxxdDE3GSYuANWBPnpQ0hqdW5h5+uEm5zLqnel54C16Lx7i2EPwXOWik0GPgc+vCLtPIQE6q13IKy34alOKYK8EDIuBp6auC2XF8uVTV2J9kD/nfqIK/LDRkjmyCIK3407/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qp3FEFXK; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45a1b05a59fso2164895e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 14:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755724572; x=1756329372; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iHnq1zNUNjsCGwo2uZ1IBjHQWm9iZco+f3TAzh7Rxzk=;
        b=Qp3FEFXKJmIMI3bIWzyH2YRNxjTxneBBGW90yvIWRB95N7ovaa3FEdbAKQ/P12uuF9
         pNkBpXHoFcQPvpunJTGREWlSyFMBrmdZJ37WsfDsMd9WkFMCvT8yPu1v34L3BJxiD3oT
         5VXUFH53N5JmJ1F3lo2mSiHHW9cL59Hfu/DAu98zG+OaeH8WCPgfqPTChAQyyCIKB5ir
         7JmUOaiM/lOCQDrhH0J6N2eQ9OFPX2G7X0cG24eFw4gIIRVV85wJaZu5M31MSjiJaMwK
         3zv8AT6lUb8C/aMRTo/MZ8YP9VNlx+PKL7CgVepJAe3zGssEgzx+AdPh1fP+iilBI5z8
         zdew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755724572; x=1756329372;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iHnq1zNUNjsCGwo2uZ1IBjHQWm9iZco+f3TAzh7Rxzk=;
        b=UiGqLy64a+0vXOR25K5pObPVFEmADsNPmirEI9Q17pambb+UOHpsdNFbN4PCkHQ14m
         hBhZ4sIwLC3qhiWxGO8cYcKAYwqDIdNQJXNIsFAhaNGHcY3xK/7ctdXMq5fHNnRZIRik
         U2qHivLjfg283V3aaKSamgxgncUb4VyMAobbSb+UO2LgH4y3y6D7tpD7Hd5RLsidMUyV
         kAHUFHvYrJPhGSYhSzLN5U2gS6VE8sg4DBEvaju8dkIiydxse/FnBD9DvOiRytmgDLjM
         1l/mr+D+PrhmRDLZ33B2Izdcq2VakzhPdtDd9EzkvKVRlek321XNUZqKWaJdah9s0tKH
         rqKw==
X-Forwarded-Encrypted: i=1; AJvYcCVjpNkOzVLWYLL09srk0BMcrE2pb7rZCNg8C6xnHjx0S2ovlu//iVMuwx4n5MHLQIv1+la8RyDfKylL/Kg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRknA6//ZDyKoOC+hFNRL2r5r6hZC5EiB+KPYGsfRZjpJHuwx4
	3cVwcLS8EvzFFQabUVkAkTzESU3ruX0InhlD1LWyP5uRnOYt7ecG8I9S8udiMEsCaQ8=
X-Gm-Gg: ASbGncufbvKrX6jvcPR8QAErkXiZ1gK7vzoMYZ8MKLrKuatBmseoWmsDHIsH61Sh3tq
	AjiuJRaz8vSSuCVD2Dxiopu2P21BCM9e7s//kGk6Fq3402hMywIeQ+MIFoIi2noZuKKwSWscvdc
	nkgQRENvmNHg2Gpdp1ROxN0yFtN4RFXHXDmahCgYMX4JOiJMYjyKp/4GEwh/rIYvJ3WI0cv8I/2
	tcWXEZcIQ3wB2Y0eylvnZZeMqXUNwV8wkzWKzSpy47wiW2J6M+eQszkRyiD9AojOIJztl8QmL/O
	K0VR5KCpcydbm28URE6qGqlFi6bH0/TWsi8TGG+0bm4IhaqDQa46NK1HvJjGFz/sOOV+FDLVM9p
	SuV1+pKbN6vCPhmQ83CgvZyoysJGhFK/TjqND030=
X-Google-Smtp-Source: AGHT+IF6mc6i3GB80pU+NXSZj3BrVHUS/irruglP4BirKVhRoCkCZCYy4zY2P7/VCJuci1L8rEovxg==
X-Received: by 2002:a05:600c:630d:b0:459:e3a1:a0c4 with SMTP id 5b1f17b1804b1-45b4d865e87mr42375e9.30.1755724572081;
        Wed, 20 Aug 2025 14:16:12 -0700 (PDT)
Received: from orion.home ([2a02:c7c:7259:a00:41e2:cc8d:197b:62f6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4d7b2948sm162105e9.0.2025.08.20.14.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 14:16:11 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
Date: Wed, 20 Aug 2025 22:15:59 +0100
Subject: [PATCH 1/2] ALSA: compress: add raw opus codec define and opus
 decoder structs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-opus_codec_rfc_v1-v1-1-54d5c7560856@linaro.org>
References: <20250820-opus_codec_rfc_v1-v1-0-54d5c7560856@linaro.org>
In-Reply-To: <20250820-opus_codec_rfc_v1-v1-0-54d5c7560856@linaro.org>
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
2.47.2


