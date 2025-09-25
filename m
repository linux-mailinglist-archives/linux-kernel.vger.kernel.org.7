Return-Path: <linux-kernel+bounces-831682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0E3B9D4F5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 05:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FF1D3B3D1C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 03:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED2B34BA52;
	Thu, 25 Sep 2025 03:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYTiIABD"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9D814F70
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758770641; cv=none; b=ea5F62QPIIeHjLhvIIBaxzaBAWC2aQ6Y5Qh9Jq/1u8O1WVABkI+rr9Rs5e/vXmzc15sgBmcQwLxHBjLKT40Fu+QOOKnzzXUQNGbB0HCYvY1MAPwlvTzNPkrz0IdiWKpsLlabVXZy1cBLOD1stsbDPOMz9YVD/MNt1LEWH8d6qgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758770641; c=relaxed/simple;
	bh=X1tNOR4EnqLn3peT9DJH4NTpUhI6OCjta/1nUUQxGwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AkEZj1kJMmHBHEy3yBAQ7JPNUXa2HCX2p6RFoo0XdLhc9ROk+LWSnF0uvLmXex8QbKOWRadOVjQvt3jqMS1mSaTPaMyuQRCruobWE/F3QBjbBhSss9JMheegFnN7m2nC5cdscJe1JRE7jfAg+Af2YeI28SfIHz+fKGfqQdaDPXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYTiIABD; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27eda3a38ceso245595ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 20:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758770639; x=1759375439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ALtdxioioVUPdZ249fa6+reQMnKejsflkFYaDtWyvw=;
        b=hYTiIABDckKcfkyFSuS5Qr0FhdCDJKkAY+aZOITXKrZjcomTbbNh7XFKf3NhH88jNM
         2wx5JhM/r6VX74q+vk3MuGX99jcnxWiCOyHBjc56BXsrvRqTjrLkh9bL1zRCBEMfU9rL
         eiAnJbDcnDR+5c4d5XNVuQCivNkJ04Vv7Jk0xnzZlMrvxBU0L4+6U6H+yaSvtXJJ8vk2
         RKYWGB6f7KkOHGPPgQ8T7bZF1bYiMIBGE5qoC7jEj9cXPihRMpb3iHDfczzgNhy1c3dg
         rizdQrTSGHxGPUbexyJ6VDEwsz4TZTtiAU4IYL+a8WrukbW8uwsyc/mv6PRWgdBHCtZO
         SSCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758770639; x=1759375439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ALtdxioioVUPdZ249fa6+reQMnKejsflkFYaDtWyvw=;
        b=SvMG+5+rzABXrF3hgMNmbU4fBoLZjn6LDTkPW7EfW+jqz+OkxckTcKKFxYksdNQwJT
         Rxj9Mas1Kj77oKrSjSD7vrZ1x7xjRu/YZO/3yIerLdeqpEZt0CdGo/ZSS0snAOlT56uX
         UTVMVd2TcUWPiZx/MxEMAsuOB0Xf3tU1BUyRUAPbEwVPnqAJ9T3zNpnchstyjPTi6kS4
         Mj6pn9lryI5tPLop2WY/Dqvri+EjhyEviLjfxRfZ5PnS4PMM+ccHwllPTtxrjkXtwaGz
         CaUBleZ6XVhqDl37qcTfaPmsb1eeaRIWavTHbJBZwnClF4sxfQ7PiQdbEzcLCHUAfOG9
         +XLw==
X-Forwarded-Encrypted: i=1; AJvYcCW4/tiDFL5U6+HqDrHSCT4wDkApsxLY6raAOv484NiRpYQDDAhRjZQC8gR4l1LSitjDtVCTBRCI3kv/Dy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlnbrtRyUw2f2JOXRfuQ9Dtm3tx+9Pt55zlH6wWn6spfM7WCsh
	4dl/S2plij5Oh/JLfc2PIGpML+dvd3o9M0mOvbUrhz5SxNkgB/6Usqe8
X-Gm-Gg: ASbGncuSl8Z5DriRCU0uoCWx79SsSRaHslmSU1kARFXjEPJN4QxtPd5HKsGp+VgFoft
	kqlZMw79hQjMbOdDnc0Nmjr8WIGZ0oxCSVCMKG6UX2yNNg2soB5YDryfRtW5MkkfUSMUmS3Mqes
	8LE3chjCLKciSysMonWOHG9PTGmdIXOTcbcPyAhWBUCH8/EhzDZW1tNBPLktwryGOB5JgOUW/KO
	j75Z7DTE6YuQo3eCt+fe2AKMn0i5g44B9y1Wgb+EDDtxIJyb3DTURk4yte5/TOh2U95QlovSEA5
	hrQZ5EcfAFA/R23Hn+0Wz5AC7KjiosGaFoK1/3WY2tR0ER2NOaJxbH+ZHLwCGTcXoFODshDAROt
	2S7JaNb4Sj2lX64cW/1LvyOI=
X-Google-Smtp-Source: AGHT+IExiuoke1BO1yKig9GT9/NXxGRxhsCiCsu8+WVeI+rNb6cIW7R9xXIvDy8Jo/2hG/yxkf2Ddw==
X-Received: by 2002:a17:902:f551:b0:274:506d:7fe5 with SMTP id d9443c01a7336-27ed4a17347mr12353165ad.4.1758770639109;
        Wed, 24 Sep 2025 20:23:59 -0700 (PDT)
Received: from rock-5b.. ([45.32.55.39])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3342a3cab8fsm503548a91.1.2025.09.24.20.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 20:23:58 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: dmitry.baryshkov@oss.qualcomm.com
Cc: airlied@gmail.com,
	broonie@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liujianfeng1994@gmail.com,
	lumag@kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	quic_abhinavk@quicinc.com,
	simona@ffwll.ch,
	sophon@radxa.com,
	tzimmermann@suse.de
Subject: Re: [PATCH] drm/display: add hw_params callback function to drm_connector_hdmi_audio_ops
Date: Thu, 25 Sep 2025 11:23:38 +0800
Message-ID: <20250925032338.20243-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <5au5p32oyouifgmqlnl7unm6n7tbxq45wpwpqx57xoepiucmxw@tjqlbh2a57yk>
References: <5au5p32oyouifgmqlnl7unm6n7tbxq45wpwpqx57xoepiucmxw@tjqlbh2a57yk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

On Thu, 25 Sep 2025 06:08:58 +0300, Dmitry Baryshkov wrote:
>> [   14.055198] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
>> [   14.067225] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
>> [   14.089925] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
>> [   14.105988] hdmi-audio-codec hdmi-audio-codec.0.auto: hdmi_codec_hw_params() started
>> [   14.106027] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
>> [   14.122707] hdmi-audio-codec hdmi-audio-codec.0.auto: hdmi_codec_prepare() started
>
>From this log I don't see, why the function would fail in the way you've
>described. Could you please post (for comparison) a trace log without
>your patch?

Here is the trace log without mu patch:

[   14.093437] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
[   14.105285] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
[   14.127546] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
[   14.144819] hdmi-audio-codec hdmi-audio-codec.0.auto: hdmi_codec_hw_params() started
[   14.144855] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
[   14.652233] qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001002 cmd
[   14.659556] qcom-apm gprsvc:service:2:1: DSP returned error[1001002] 1
[   14.666326] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: Failed to start APM port 104
[   14.677484] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: ASoC error (-22): at snd_soc_dai_prepare() on DISPLAY_PORT_RX_0
[   14.690897]  MultiMedia2 Playback: ASoC error (-22): at dpcm_run_update_startup() on MultiMedia2 Playback
[   14.699779] msm_dpu ae01000.display-controller: [drm:adreno_request_fw] loaded qcom/a660_gmu.bin from new location
[   14.702160] [drm] Loaded GMU firmware v3.1.10
[   14.714573] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
[   14.721910] hdmi-audio-codec hdmi-audio-codec.0.auto: hdmi_codec_hw_params() started
[   14.721923] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
[   15.231216] qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001002 cmd
[   15.238577] qcom-apm gprsvc:service:2:1: DSP returned error[1001002] 1
[   15.245323] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: Failed to start APM port 104
[   15.256528] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: ASoC error (-22): at snd_soc_dai_prepare() on DISPLAY_PORT_RX_0
[   15.269943]  MultiMedia2 Playback: ASoC error (-22): at dpcm_run_update_startup() on MultiMedia2 Playback
[   15.279988] hdmi-audio-codec hdmi-audio-codec.0.auto: hdmi_codec_hw_params() started
[   15.279997] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
[   15.785610] qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001002 cmd
[   15.792908] qcom-apm gprsvc:service:2:1: DSP returned error[1001002] 1
[   15.799687] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: Failed to start APM port 104
[   15.811261] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: ASoC error (-22): at snd_soc_dai_prepare() on DISPLAY_PORT_RX_0
[   15.825865]  MultiMedia2 Playback: ASoC error (-22): at dpcm_run_update_startup() on MultiMedia2 Playback
[   15.843283] hdmi-audio-codec hdmi-audio-codec.0.auto: hdmi_codec_hw_params() started
[   15.843300] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
[   15.991449] rfkill: input handler disabled
[   16.349109] qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001002 cmd
[   16.356529] qcom-apm gprsvc:service:2:1: DSP returned error[1001002] 1
[   16.363279] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: Failed to start APM port 104
[   16.374539] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: ASoC error (-22): at snd_soc_dai_prepare() on DISPLAY_PORT_RX_0
[   16.388835]  MultiMedia2 Playback: ASoC error (-22): at dpcm_run_update_startup() on MultiMedia2 Playback
[   16.399355] hdmi-audio-codec hdmi-audio-codec.0.auto: hdmi_codec_hw_params() started
[   16.399371] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
[   16.905665] qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001002 cmd
[   16.913032] qcom-apm gprsvc:service:2:1: DSP returned error[1001002] 1
[   16.919837] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: Failed to start APM port 104
[   16.931141] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: ASoC error (-22): at snd_soc_dai_prepare() on DISPLAY_PORT_RX_0
[   16.946106]  MultiMedia2 Playback: ASoC error (-22): at dpcm_run_update_startup() on MultiMedia2 Playback
[   16.958230] hdmi-audio-codec hdmi-audio-codec.0.auto: hdmi_codec_hw_params() started
[   16.958242] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
[   17.464922] qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001002 cmd
[   17.472219] qcom-apm gprsvc:service:2:1: DSP returned error[1001002] 1
[   17.478985] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: Failed to start APM port 104
[   17.490126] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: ASoC error (-22): at snd_soc_dai_prepare() on DISPLAY_PORT_RX_0
[   17.503539]  MultiMedia2 Playback: ASoC error (-22): at dpcm_run_update_startup() on MultiMedia2 Playback
[   17.513599] hdmi-audio-codec hdmi-audio-codec.0.auto: hdmi_codec_hw_params() started
[   17.513606] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
[   18.019162] qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001002 cmd
[   18.026682] qcom-apm gprsvc:service:2:1: DSP returned error[1001002] 1
[   18.033427] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: Failed to start APM port 104
[   18.044729] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: ASoC error (-22): at snd_soc_dai_prepare() on DISPLAY_PORT_RX_0
[   18.058144]  MultiMedia2 Playback: ASoC error (-22): at dpcm_run_update_startup() on MultiMedia2 Playback
[   18.068168] hdmi-audio-codec hdmi-audio-codec.0.auto: hdmi_codec_hw_params() started
[   18.068176] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
[   18.574028] qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001002 cmd
[   18.581321] qcom-apm gprsvc:service:2:1: DSP returned error[1001002] 1
[   18.588086] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: Failed to start APM port 104
[   18.599667] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: ASoC error (-22): at snd_soc_dai_prepare() on DISPLAY_PORT_RX_0
[   18.613127]  MultiMedia2 Playback: ASoC error (-22): at dpcm_run_update_startup() on MultiMedia2 Playback
[   18.646419] hdmi-audio-codec hdmi-audio-codec.0.auto: hdmi_codec_hw_params() started
[   18.646443] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
[   19.152583] qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001002 cmd
[   19.160139] qcom-apm gprsvc:service:2:1: DSP returned error[1001002] 1
[   19.166909] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: Failed to start APM port 104
[   19.178407] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: ASoC error (-22): at snd_soc_dai_prepare() on DISPLAY_PORT_RX_0
[   19.191821]  MultiMedia2 Playback: ASoC error (-22): at dpcm_run_update_startup() on MultiMedia2 Playback
[   19.222661] hdmi-audio-codec hdmi-audio-codec.0.auto: hdmi_codec_hw_params() started
[   19.222678] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
[   19.730557] qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001002 cmd
[   19.738156] qcom-apm gprsvc:service:2:1: DSP returned error[1001002] 1
[   19.744933] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: Failed to start APM port 104
[   19.756633] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: ASoC error (-22): at snd_soc_dai_prepare() on DISPLAY_PORT_RX_0
[   19.770042]  MultiMedia2 Playback: ASoC error (-22): at dpcm_run_update_startup() on MultiMedia2 Playback
[   19.789888] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
[   19.799242] hdmi-audio-codec hdmi-audio-codec.0.auto: hdmi_codec_hw_params() started
[   19.799252] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
[   20.308857] qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001002 cmd
[   20.316540] qcom-apm gprsvc:service:2:1: DSP returned error[1001002] 1
[   20.323280] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: Failed to start APM port 104
[   20.334923] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: ASoC error (-22): at snd_soc_dai_prepare() on DISPLAY_PORT_RX_0
[   20.348392]  MultiMedia2 Playback: ASoC error (-22): at dpcm_run_update_startup() on MultiMedia2 Playback
[   20.358449] hdmi-audio-codec hdmi-audio-codec.0.auto: hdmi_codec_hw_params() started
[   20.358456] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
[   20.865298] qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001002 cmd
[   20.873431] qcom-apm gprsvc:service:2:1: DSP returned error[1001002] 1
[   20.880197] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: Failed to start APM port 104
[   20.891777] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: ASoC error (-22): at snd_soc_dai_prepare() on DISPLAY_PORT_RX_0
[   20.905293]  MultiMedia2 Playback: ASoC error (-22): at dpcm_run_update_startup() on MultiMedia2 Playback
[   20.924421] hdmi-audio-codec hdmi-audio-codec.0.auto: hdmi_codec_hw_params() started
[   20.924455] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
[   21.431143] qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001002 cmd
[   21.439239] qcom-apm gprsvc:service:2:1: DSP returned error[1001002] 1
[   21.445985] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: Failed to start APM port 104
[   21.457877] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: ASoC error (-22): at snd_soc_dai_prepare() on DISPLAY_PORT_RX_0
[   21.471375]  MultiMedia2 Playback: ASoC error (-22): at dpcm_run_update_startup() on MultiMedia2 Playback

Best regards,
Jianfeng

