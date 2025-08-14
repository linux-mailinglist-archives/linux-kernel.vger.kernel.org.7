Return-Path: <linux-kernel+bounces-767786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AABC3B25902
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 03:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBAD31C22FF9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 01:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6909F1BD9D0;
	Thu, 14 Aug 2025 01:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gg/UALNe"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F298126BF7;
	Thu, 14 Aug 2025 01:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755134825; cv=none; b=AAkcD5TxoD7RTCzTtTEdHEHIPe2hfK86quf5pjKZJs+6zvU8KQSGusVXSGDQhKGBN+lOFR64Y3PkXdRUdU6AUHxMtnUcKZMhW1pfUpzMgNJQjTp4nU8VVn9lrsDDapyR6VdoDFwS7eyaMEKtDmguZ0YajHnpWlyJgC5F4/fDLus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755134825; c=relaxed/simple;
	bh=r05ub/QKCffj6d9WvFTHyg4/XX0MtUiUBmmUM1+7QNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mz5KrBUDaW7ZM3KVdUwT/z5xpr+fLmWbPxUHXL2e7QkCT4mopmKxZl6SdA5KEOl99nrT0D4vpPHanYZ5l2xkdqR64Ulp0dGdPnHgd1YPV/j0HFt/LDZAjJ6TlicgdGjK4HygQTaOryU2hIp3UPPkYzML0kRYCnGgMj19rCrfZmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gg/UALNe; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-88432e6ca05so28072539f.3;
        Wed, 13 Aug 2025 18:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755134823; x=1755739623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fh3hbfAPnUv9G1YI9juHyYX03wA62ePqU142wDCL6b8=;
        b=gg/UALNeZ281zSWLSMKmdkoGw68lkjdOnTE6lE7yzjfDv/6P/TKpK7uK1R6uT4GCE8
         tGFkdiiwcfZV64A0EeDwmyBxiNpriK3fdqUkBJ+Or9kcSnV1DnZS/u1fj7jCX++JDUy3
         FHzVdplQVnpMMHY5kOm11/07wkP4ejwG4uiOtYyn3BQIcqGHMRymyBl/VL9BOgOMVazO
         2CU/VzQxDSjyFtZR7PSklS7y10TEjkNKGWvTfs+uJ6n3vKFphGrZnhwGl594AGIGZo1K
         YFRS1nMVEOXTk1s+La9+45fV19v3xLQRh8eecB2p4npVhPC0Brzf/8HYBL/6fO4Q0g61
         YAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755134823; x=1755739623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fh3hbfAPnUv9G1YI9juHyYX03wA62ePqU142wDCL6b8=;
        b=mAXUijmzAvbmb+JlD/xmr8/0tNKscu8H83HeoiULLud5P5FWxTnlDBmmqe0dkBW0IU
         JOfxIMTpjbfXYl0UrRehKCPGLlFOtqrnLdkknjQw3b91Git0Frip+HPvqcBkGx5vokdp
         pBLxvtqjFvXkc2pjT8LTxq73M9XvHbwArDS9H5d0MWZ7MAvoiOh+9AVUu5Mi26oAtC/Y
         PCVvWRt48zRYEBrdS4QbujE8R5MvgOUWqOeh4KWJ0dwtEHc9jH/cxxCMv1J9+mWTpfnh
         bShJE9mY2+zHWaHRnMhkgC88x2FAAvzOBrQrbn6PFSlqPg0wuWMeMuxdsq3JUe1TA7kT
         LNSA==
X-Forwarded-Encrypted: i=1; AJvYcCUhndP2JGiXlFmEB6+Ya2J+c7NyZIGJD+rzX0CYmTNrNxl4WGWIAYGTzc3xUYy55IgVAyO9H+a338DVQUs=@vger.kernel.org, AJvYcCVMPgFzP1amFSE9Xp9peP849wInVQDAyrUAmqmgElTRPjA8uYx6kDcuVtQp3cV+CwLJz3fqFPTi+J6Rte8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0L1Z/RE+cG8geCwaZbhOrMBo0L0mzgxSJ6gq7MBTkAAaMFIuN
	zF24fuufJDfpHs1bcCAg9agvLFXN/TqycdngDZHIL7BJ9LZG/SFZGaKN
X-Gm-Gg: ASbGncsnvpWmuwJTT/KTFQonAR5+QoM+OjJodmWUl6/eXaK37/3XKqL0Yc77zVzg4kW
	i1Bo9nT0RqHxNhdfJO0Z71P5g0dDlNm5CFlJw+RiX2YEKLt+fl5lUapiIsD8enUapPOwZ8fQusW
	DoRlTwTbEzy7Bco8G5j2VUZmvOE5LbySLRP4E6yYk2r6wnx3B47SK1YS1ag/9tKnLGPmjoykSx7
	JDvi+wY5NgTB6JaRtRUHcdPuBw02Ri1/hBbD4iqGvToMPP/XMTRpfne2/vAp0I/545a53C5MeE9
	/XZAXFztmVDviH8flIWKAsNU+vNPUd5X7IPP34T62ZCjc/9us3XUuzTmxn5SQy+/COkeBbGT4So
	jxvRItfZQ1guD6WtQd1VcEhBKDqgQqFhTtnN0Z0RibbUKjLTmkzK6n1MjcTmJ2u1DtMQ=
X-Google-Smtp-Source: AGHT+IFk4rAezJrZ8KB37l+E0BRHoncpAw9qNT9ZlZVyNknBnDU49aSvpBLehQo7DzJZcha8fc2zmw==
X-Received: by 2002:a92:ca45:0:b0:3e5:261c:bac0 with SMTP id e9e14a558f8ab-3e5709a85d6mr21296165ab.22.1755134823462;
        Wed, 13 Aug 2025 18:27:03 -0700 (PDT)
Received: from localhost.localdomain (65-128-248-47.mpls.qwest.net. [65.128.248.47])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50ae99ce764sm4044087173.28.2025.08.13.18.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 18:27:03 -0700 (PDT)
From: Shimrra Shai <shimrrashai@gmail.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: Shimrra Shai <shimrrashai@gmail.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] ASoC: es8323: Playback enablement for Firefly ITX-3588J and similar hardware
Date: Wed, 13 Aug 2025 20:26:49 -0500
Message-ID: <20250814012652.81424-1-shimrrashai@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small pair of patches is needed to enable the audio output to
speaker using the ES8323 CODEC on boards like the Firefly ITX-3588J
that use the right-hand DAC mixer to connect the line out jack. I also
enable associated DAPM power widgets so that the volume can be
controlled in the ALSA mixer. This seems sufficient to me to produce
basic audio functionality on this board and any others that might use
the same features. I tested it with both ear buds and a pair of
speakers plugged into the green jack on the back of the board.

Shimrra Shai (2):
  ASoC: es8323: enable right-hand DAC-mixer connection on ES8323
  ASoC: es8323: enable DAPM power widgets for playback DAC and output

 sound/soc/codecs/es8323.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

-- 
2.48.1


