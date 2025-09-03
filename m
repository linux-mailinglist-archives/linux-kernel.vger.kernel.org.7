Return-Path: <linux-kernel+bounces-797728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFD9B4148F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A3331A88393
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 05:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC68B2D6E66;
	Wed,  3 Sep 2025 05:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WcRYAlDw"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7252D6E4F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 05:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756878751; cv=none; b=Jc+4V/MO5yCtMyp4/s08SsfGei5EEoDl8f7kyQZC+CysWhvXwGWCg/1qIcqQJ5hdAYpuuklMSCfA+iV1ltBX+reuFuh9G868wcdBU3QDUy+2NHMMOfHZHyUmcS+uHVIHDPlS2nP9CsXU8gPKMn/gmVFqEF+EQP1I4MojttBEvuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756878751; c=relaxed/simple;
	bh=pUTayYOusLzNmrYT5IbElVRwDbAaKIqMxWTMYYd647Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WN4UM8NVgzgfRa7APfKZsNNJxvSeuu+mZpn+D1MHxXnPUSf6q0b5UnN8nq+8NRsSFUObfVaFYPpa690vHCZuSuI7tlXQnqKMBntvwRQZZOYkGCEWnJJ2TbPccZ8MK5fAhel0Q3awoPy9/yBdcgbRaUqnBZEVQlcGCPU0VFYQ86I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WcRYAlDw; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45cb5e5e71eso1136155e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 22:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756878748; x=1757483548; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O2SHfXlAMbQlOhrChDAPutEQWuy8htWNPwTHbTwvBXo=;
        b=WcRYAlDwjCIYGQptIX3cWB80pmoGrDl5OUHWHQmjayWvBe21c7yPXtZgV6fB7DAgzs
         ySuGp/8HqUggs/nJNVLmg1MH4oEvDWABZc803qw+/sIAUNuOBMiVPxo/a9rNEI6tja9y
         XsVCVtNK0bzMFBR45TdlhOUUuFMVXKrlc5h5PrZfg29idx6MeeZVSuku3dByPWgHiOoP
         lbgFA+bfst1tZ3ArYbFom120c+mlDn420O4qjqJFckA22zu/GX1/M0SiEiXx1miQvCG8
         u924iYTrX0LQqPGRxLDe5z9wFP2CF36kD0skqjLMD0FEMDK5GLy1d3VbUs6+S4TZArnC
         nwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756878748; x=1757483548;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O2SHfXlAMbQlOhrChDAPutEQWuy8htWNPwTHbTwvBXo=;
        b=rn+9pyz8EW1rRx3/MUrjZ5rh7IiWHyCf0opzt2psbUf+aRsfPWS59/AOt7zmNNFbwh
         PplvX/SgtVvtrrSLZAngQGZqcH2CUwoz1a7PZFgRE3JLtilqX8jpOZt4elbWWI2UEofB
         Z4yHbbkVLt8bgSJ24ZeocZ0DUpf8rQY0rQawAEp5kIst4/lh0hVACHbEk0kNWTId1AVW
         VuhOdOih+qlm1dhhw6Bnv4LgJVibQol5Ust8MENdeBKUaVbLSl4Xs1AkkXUwcqrN/Rq9
         4ZUoK4XQXtUiW77FX/sgWRcIRumW57KH3UCJ/kXgn8c7CGkjahYLOLow5KVQjAyS8LyX
         4cBw==
X-Forwarded-Encrypted: i=1; AJvYcCUXGErdVifR+rYDPz5fbbwht+A344LRW0hWuF2XpZhYOX0cRdzpAqXAqRQRRMDmptjMFXrPTL79tpy0swQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCXEg4vd7QoZxSB/JrYorv0jWoNEadJWxUDRdtUCbay5nQhQMF
	LRy9SL1CAe3FrKoL1xNdfE5XZIP8zq259v7AN+PAiTzl9h41duiPUfsgqpzWTTFRBJY=
X-Gm-Gg: ASbGncs5JqiqSJrj3nJ2Y2lKgO1TqyKTjKAHMURZaZQSzVe+gHoEBT4qPlT1Jqh6c2f
	UxnbmWITA3GCtZKsyL2McM4Biq/EPbo27/x95wW+0r2zd5hngGvggELr1GmibkQ+qwYRKoE9xWv
	6Y9H4S7UuiRmM18dlIML9XT7KdeHA2GZu2xTjlMKTAZ8Hw1AhUbcW2F7bBI6j/CX+1RsavuE04O
	Ox/HjI82LQap+PSf0EIlgTgSJ0TiTsq+dgU41DHhS+h608GAgLBx59yaKHBnrrFKRlxLbIixZAL
	M/xK3+q+nnt3bmsy1a8XdD0A96AUxV+3HXnSPmj2VBjAq0i55fEZO0ZHRGtXgRKueGkUKRDb2Cf
	Rh/RrkcSabBLYu4IA7futC/voYbahpPOz8VNetg==
X-Google-Smtp-Source: AGHT+IHmTYpS8pExI03NdGUx6gu4VM382Zj6xNSSMkKqIjXWiMXf3gSWFiBd4pm21+i3C4X/vRakRg==
X-Received: by 2002:a05:6000:3110:b0:3cd:6cd:8c2 with SMTP id ffacd0b85a97d-3d1df72effemr10191588f8f.60.1756878747702;
        Tue, 02 Sep 2025 22:52:27 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3d21a32dbc5sm18690066f8f.11.2025.09.02.22.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 22:52:27 -0700 (PDT)
Date: Wed, 3 Sep 2025 08:52:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Philipp Stanner <phasta@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] ALSA: rme32: Fix serialization in
 snd_rme32_capture_adat_open()
Message-ID: <aLfXmIQRFTXr5h8O@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

We accidentally deleted the wrong line of code when we did the
conversion to guard() locks.  If the rme32->capture_substream has
already been set we should return -EBUSY.

Fixes: 8bb75ae244c5 ("ALSA: rme32: Use guard() for spin locks")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 sound/pci/rme32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/rme32.c b/sound/pci/rme32.c
index 123dddcb6972..ca9bbf554650 100644
--- a/sound/pci/rme32.c
+++ b/sound/pci/rme32.c
@@ -936,7 +936,7 @@ snd_rme32_capture_adat_open(struct snd_pcm_substream *substream)
         
 	scoped_guard(spinlock_irq, &rme32->lock) {
 		if (rme32->capture_substream != NULL)
-			spin_unlock_irq(&rme32->lock);
+			return -EBUSY;
 		rme32->capture_substream = substream;
 	}
 
-- 
2.47.2


