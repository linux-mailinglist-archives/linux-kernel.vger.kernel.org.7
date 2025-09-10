Return-Path: <linux-kernel+bounces-809691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8EDB510CB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D7011C82A74
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1961730F80E;
	Wed, 10 Sep 2025 08:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XoWGGI3l"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B0C30EF7E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491912; cv=none; b=uvMiL9K6dXFboP7BzJvnNRrzxl5DGKq+G6KaJzXVbS/nsHdDquv2nBtS/qTS+42+DUwc9NdYyo2ziUqt6Vkd8a82LivVayS1PEc+2UfX2PKVJ7ojr6WhO4FUYCjvMsn4fQrnxZ4YdVSp2qfX5ETSMEb8TWFjjnQ6jazFICOabmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491912; c=relaxed/simple;
	bh=zV6UIzKpC2XSiOBKmnRX5bxOtaKg0EgMOEBzfFrZUB8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iPTYmzXnkkrsaXi/B/+U37u+TGCwoR/lT33e4jpF1SLH8laKELLEQ/BQR5LtmUfhrFk2uxLwFdOqi2n3Pbw5T1VN/M0HZNwkCOkAf22SuRG8FXg0kRm8uemEnUf+rY/kOb9rQ2XuCWneCF7X7bDIGwSuyfkfzRZUtLIdlboRIKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XoWGGI3l; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3dae49b1293so3302784f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 01:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757491907; x=1758096707; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=68YOxZzKrnQTKmgz7fSU1hdvIBDa3DAXw0GY+gLPr3Q=;
        b=XoWGGI3lOuZ424fI37chCp4TPDueSOGIWyN3/Jvjp/zhgJ7B1ZM/KCiTsmTOkV+lw4
         Jr/vMTxDAm65xOw7aL8g7Fl2kYT+cR6+5KqT+EeHSHbTMLscSkdqeUkt8UMs8re1FBwt
         Zrx68FKghGOXyjsVxZroYZq+d1auQmS0WXGOawBM0V1XqwgOU29smHKjLzAT4WO26X5c
         KsYHCEdowMMsclseZM7ACJVm6KnLR8Zp4ByMSk4YpoLyOcYCPd51M92OeUVaZTdKRsCU
         wW8iAVLEhtTK7n8V+PKpMjcsDAq6e8zSPffnlMW1BfvYKWN6RaQ51JsrHUqIDJZgxPFw
         Uu6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757491907; x=1758096707;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=68YOxZzKrnQTKmgz7fSU1hdvIBDa3DAXw0GY+gLPr3Q=;
        b=bP1nk0AuitVkn2O4nswHfT6Nfevo7Q8j6LcuAwDDZ7Y8jLHt9KBXuJ/cClO562TDG2
         TDvZyK/bljFJvSwoObw0T+cEUtvFpgk8w4Ww5TxWqt1eBpM/ckWqg/l8dop/NGzOuYpj
         CyaxBvVN9kxjCb0wK0L3OJKa5sADRY7dPNhupH00ScvmKThNckErwvU8AA1JfqHU+/5e
         smH6/s2vl+0i83OnttOHHYfZNeU3K4r66SSNNiK7n7aDBHOCn/kvPVmeq6ccLj7nxH1t
         vcCRv6bAEgeIlBVgE4hm6ec+EyItpuoC6dK+cvIRm8OfDcyAJ0RKWqsdMAsDfV4+XLDb
         3WOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVz1AcmEzcCxWFhHMyVe/wRVgyn8Di27kjpL+SHlZbHrw12qoitakn9WLRG17wbqOA8yYcY8cNQWI4XmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4n/e6L8yu83K9TklpDTdoMDD3qmkBgseNCLbj/wyEnaaP/owc
	RChv5CJR1waU35TaGOrfAoNp85mQ2etzfR3bpnv2S7kBfTOrPcAbVomwD/VbAcItXXE=
X-Gm-Gg: ASbGncvakdF2UQkHzBgXkduhujhmSTN3ENpNQrIXetvtxbr+esHJi/L9XQaqiro5INU
	M6JhcF/NGoyPshkSy916TQtTMJd2zWR7pExF1gD5k2hB6nmGpX5Js/P58tHQMSxm3JpHvpKj0au
	USZMLv2zWo73UY9a3/AIv2CeLLWmLR1/HH46Y51FCHHfwnRrOU7Y0euH5QiTinbnlOTMBrF9qhx
	rNHdDNtyaCJQcWJLTe05JFYnRzaV+WvKDT9hpzemj1ZDxV/qgRobqvDvGv7Rnbjnpx00R9YtXSl
	MCqe2FlSQRsAqO/3h5u+9Nd2cvdjAqS3vkGCBAW68487wGd/DA8fRYLlxLHM3e/5KQcBGvNFRPI
	PLD/QyxzkivzDK5A/HqE8VoHGAMTW
X-Google-Smtp-Source: AGHT+IF+aey3zIQg5GKYJoXPwVZLDSMaAarObf04DoKusKxuuPB1FlhE5Skl6HLSQ58yxneD1ofyrA==
X-Received: by 2002:a05:6000:26c1:b0:3df:f7d1:f8ae with SMTP id ffacd0b85a97d-3e636d8ffadmr11307892f8f.4.1757491906862;
        Wed, 10 Sep 2025 01:11:46 -0700 (PDT)
Received: from orion.home ([2a02:c7c:7259:a00:a727:6a46:52e3:cac2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df8218944sm18119995e9.12.2025.09.10.01.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 01:11:46 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
Subject: [PATCH v2 0/2] Add raw OPUS codec support for compress offload
Date: Wed, 10 Sep 2025 09:11:40 +0100
Message-Id: <20250910-opus_codec_rfc_v1-v2-0-35fb6536df6b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALwywWgC/32NzQqDMBAGX0Vybsommph66nsUkfypC8VI0kqL+
 O6NnnppYS/zwcyuJPmIPpGmWEn0CyYMUwZ+Kogd9TR4ii4z4cAFSCZpmJ+ps8F528XedgujRoJ
 xJSh1KQ3J3hx9j6+jeWszj5geIb6PFwvb13+1fEBZX4MBXTFdw/WOk47hHOKw1w9VcfilisoJW
 wsJSshvtd227QMv20AZ7gAAAA==
X-Change-ID: 20250616-opus_codec_rfc_v1-b60bd308893b
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

This series adds support in kernel to recognise raw (or plain) OPUS
codec playback for compress offloading. At this point this series
doesn't deal with OPUS packets packed in any kind of containers (OGG or
others) and focuses on adding missing bits for pure OPUS packets.

The second patch adds its usage in Qualcomm Audio DSP code. To correctly
recognise raw OPUS packets by qdsp6, each packets needs to be prepended
with 4-bytes field that contains length of a raw OPUS packet.
It is expected to be useful for usecases when OPUS packets are streamed
over network and they are not encapsulated in a container. Userspace
application that will use the compress API has to manually add such
4-bytes long field to each OPUS packet.

This is tested on sm8750-mtp. It is expected that next hardware revisions
will also support raw OPUS codec offloading.

Dependencies are:
-- hardware with DSP that supports decoding OPUS packets (>=sm8750);
-- adsp fastrpc;
-- explicitly setting format in sm8750 soundcard driver;
-- running adsprpcd tool with support for Audio PD and DSP libraries
loading support (or its alternative);
-- tinycompress fcplay tool that will prepare raw opus packets and
do the required addition of length field;
-- mfc module in topology compress-playback path, that module is
expected to parse channel mapping and do the required things to
map streams/channels to physically-present output channels on backend.

The userspace tinycompress tool with support for raw OPUS compress
playback is located here:
https://github.com/laklimov/tinycompress_opus
branch: opus_v3_workinprogress

The userspace tool is not expected that it is ready and still needs
some work, for instance recognition that it runs on Qualcomm hardware.
More like working PoC.

Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
Changes since RFC (mostly as suggetsed by Srini):
- added struct snd_dec_opus_ch_map to struct snd_dec_opus;
- changed tags;
- reworked comments for struct snd_dec_opus;
In qcom audioreach patch:
- corrected how {stream_count,coupled_count} is ejected from mcfg->codec;
- stopped dealing with channel mapping parsing (this is internal struct for
  decoder on audio DSP side);
- used sizeof(*opus_cfg) for payload size;
Tinycompress/fcplay:
- small updates to match kernel structs.
- Link to RFC: https://lore.kernel.org/r/20250616-opus_codec_rfc_v1-v1-0-1f70b0a41a70@linaro.org

---
Changes in v2 (as suggested by Vinod):
- opus decoder struct: switch version memeber to be union to allow reading it
 as a byte or two 4-bits fields;
- audioreach_set_compr_media_format: read version byte.
- Link to v1: https://lore.kernel.org/r/20250820-opus_codec_rfc_v1-v1-0-54d5c7560856@linaro.org

---
Alexey Klimov (2):
      ALSA: compress: add raw opus codec define and opus decoder structs
      ASoC: qcom: qdsp6/audioreach: add support for offloading raw opus playback

 include/uapi/sound/compress_params.h | 49 +++++++++++++++++++++++++++++++++++-
 sound/soc/qcom/qdsp6/audioreach.c    | 27 ++++++++++++++++++++
 sound/soc/qcom/qdsp6/audioreach.h    | 17 +++++++++++++
 sound/soc/qcom/qdsp6/q6apm-dai.c     |  3 ++-
 sound/soc/qcom/qdsp6/q6apm.c         |  3 +++
 5 files changed, 97 insertions(+), 2 deletions(-)
---
base-commit: 65dd046ef55861190ecde44c6d9fcde54b9fb77d
change-id: 20250616-opus_codec_rfc_v1-b60bd308893b

Best regards,
-- 
Alexey Klimov <alexey.klimov@linaro.org>


