Return-Path: <linux-kernel+bounces-645871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BB5AB54DB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 14:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDB57863751
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 12:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D14F28DF07;
	Tue, 13 May 2025 12:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vr/whzJA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91EE28DF16;
	Tue, 13 May 2025 12:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747139692; cv=none; b=kUsWJVCAA9ui1tw/Qf/t/iZgsknxYIjcqPOabqXzJH0twlfUnkktrALC/olV/eNxntbLWU6GUZQ5oO4INnLMHHcRlJMLKBplOY9MF/pzMlx1HDlfBS0+eWpv9j9Ov8biZ74nIvfuMm/lJZ6Z2RGxbVG2tMpKWMZ0jHYq5DTTvrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747139692; c=relaxed/simple;
	bh=V65EwGMfUSwwCFmkURHxv2WonuP9SO8A45yGilsY/Go=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Bcz1uVedMqsyDcrmBhpXTcfFaeummEYyESNw6RWx42x5oMuJgle4AnWYjGEH3zVCi807Dv9D2My29ugbiRtVuzmj63xr7ukP3EsRIEIzPgW81iSELq/5E3fQN1njeQcx5vxU8I78cPUXTDUwHaioyGPPgbEW0tbXEM+NNmR4iSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vr/whzJA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54DD6C4CEE9;
	Tue, 13 May 2025 12:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747139692;
	bh=V65EwGMfUSwwCFmkURHxv2WonuP9SO8A45yGilsY/Go=;
	h=From:To:Cc:Subject:Date:From;
	b=Vr/whzJAjsgA0zsbjRgEnqj71dccbWX0SU4cxFuzuJh8KcPljeKH4yVNBAav5Q3GX
	 wHsnJakahjH3LD2l+rmKBJau4t5KkH2xRVGu0H9pkKORwc6MD1Bl8Pce8NNr+K6JxK
	 jjjUPYfFjyyARdn+65o5AoJ7YLpMfDtvPNe1y2wUD6iHlsreyeWXMBsJVCmxenJlw8
	 ZAgm/tcDLDYTLiDkFKbcvKPEcYBPMllL0fMFP3f9IBsJiKX6ItE7UO0cmgNMmDhXvv
	 cp4iq4ZqlS1JVPqwdkBOnHxOhE387JrIg7A+qiQQLaBuZjt9JOKQaUfBQL8/3x47HY
	 smvLO/DIDgrUg==
From: Arnd Bergmann <arnd@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] ALSA: qc_audio_offload: address space cleanups
Date: Tue, 13 May 2025 14:34:39 +0200
Message-Id: <20250513123442.159936-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

I ran into a build time warning and spent some time trying to
gently rewrite the new driver to avoid the warning and make it
behave more like other drivers.

I'm still a bit confused about what the driver actually does
and why a buffer has to be mapped into a two devices, but I hope
that either my patches clear this up enough, or if they are wrong
are helpful to have someone else sort it out properly.

The patches are currently queued for v6.16 in Greg's usb-next
tree, so my fixes look correct, I hope he can apply them there
before the merge window.

Arnd Bergmann (3):
  ALSA: qc_audio_offload: rename dma/iova/va/cpu/phys variables
  ALSA: qc_audio_offload: avoid leaking xfer_buf allocation
  ALSA: qc_audio_offload: try to reduce address space confusion

 sound/usb/qcom/qc_audio_offload.c  | 158 ++++++++++++++++-------------
 sound/usb/qcom/usb_audio_qmi_v01.c |   4 +-
 sound/usb/qcom/usb_audio_qmi_v01.h |   4 +-
 3 files changed, 89 insertions(+), 77 deletions(-)


Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Wesley Cheng <quic_wcheng@quicinc.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-sound@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


-- 
2.39.5



