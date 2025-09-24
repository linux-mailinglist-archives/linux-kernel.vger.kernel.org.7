Return-Path: <linux-kernel+bounces-830337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24262B996D5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DAA31895541
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2262D2DEA6A;
	Wed, 24 Sep 2025 10:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qp4sltb7"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC532DE70E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758709613; cv=none; b=mWE+2adKmO9y/Gn693lSZyh0M5Mv/t8z8HZGwWqw12SWsTKE/zQBbqQ3Tptmayl6cxkEoWUf4F8F6FAtwzcXLjyfXOlf6TIl62X90UkRSmbEae0yPryg1jV7uB71QuvY4wit7JA0+rh95Wy5p+fNA0uOIEvXpexcvPYPAKVffXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758709613; c=relaxed/simple;
	bh=rg52av5kFCUYkXZtU4DrP9/Y4/39PcGOd395Z3Mzk7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O7947/UHerLJPU7wv5vflxiKx3SI98qfrCtkC/5eBfk5a9rFUWhOZ+BNprBhGr+fHAawjlg1TM77OvNMpEvAl/Lr3kkrOxQjYUqvUFcINlPwhhk+w5vb2jUdMr+wisKcMlAF66fC5+kuQ8vynYONFmWIF/8+Kz3DoLTfSinmFeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qp4sltb7; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2445805aa2eso68883475ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 03:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758709608; x=1759314408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SViHo61tUbVEKZUPOiXibeEeLK3NjnTHx+4S6cKWr+E=;
        b=Qp4sltb7VBeChe4sp8+ixOorM/5zarvONK0h4xuOUUhWfttxldKQJMUMha+wF7764B
         zDUVuca2eJNS6HE1Iin0dXmLvDnSnkNzD0fMUAEJqBRjG25Cj2zdqNAbXrBi28psRYUI
         6U9ZbwUKXAk7JuEXRYqVBqgjk/pEJFDyPUyLFJo8W/BJarE149LnurAo15LLL+eviTIg
         KG3HlLIyR6w2Sav3O05bT0DA3WVZfuBumdOtXJ5EMOHt5HK8JZDEz+LU2nBf8v6CHClU
         CknNb7PKQdvYqb4GoTwbI6b2pxQIxiFXO7vxFid4I/Px4hp9jnl68gkEHgRLRwCXriG+
         vmjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758709608; x=1759314408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SViHo61tUbVEKZUPOiXibeEeLK3NjnTHx+4S6cKWr+E=;
        b=thje+f90YsuJkD/qd7U21Icfs9NFikgxrdWrwYXYeLG6fKuDW6URBX0E+YnXM7ww0/
         vnDCBamudsv4X8HA7/NaQDmI2qIm1NI8I9JS0aQqKnl3lzMfzqmAZWWIIVxspa/qLqEa
         WmnOzPik+geiPXWNf1o0/vYsiFhqm4MTzGecq1UrB7UDVZolKgTZfZRFmFfKAbcKbTxV
         3KYvEmhx8GpIAN6r2+rZULA035V38GllJ8MVud0OHnR4haEHXz4by+HDeqzlmlpuYF3U
         hIO+pLBrytEm09wjNf1M/X93TKzXqtagt2LoBEQ21Ol5JuFyIgpjwPIuPsU7XZ+EuuNb
         NEnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVw3QVpyMu5QLwDTcdMpSvbi3QtKJMRLRGpz6m38p6HaKMSR1a6zbAUrHSPNGdTX5TVYSqLdloDswOekaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlygJQlfXY5TCHwtfMaxZsAFNF8RDAN7PCWlRZ396mum9gTDlV
	jdEDB59lzJTvS+pTR0ky2VWFDVrleiRXEAjRF615I9okkQX9TpfH+3mY
X-Gm-Gg: ASbGncvgIQx1uGbpfPYeRfTtE9WwYuMewz8iXTUBpjnNC8AOWeXEV2pzCl5Musrz+oj
	sWB3wMBklLRrFdgCr8x1NgEu+4apcBm26nhztgjaKYm89C7TMDNxAQzS9mzpAjBnjF+kD+5snYZ
	+Pl8PuO2hsoZHXdfb+oBkABhW6kF5Y5OAr0UjtMOkQL8z2/m4cfZq9G4jBHVKl35lLSMXyteqTi
	UGN0y3S+/lxn7pyk5bUkciFyTKgxDdsnDDfub9IWHnHNS3iUWRM1oILCvWuTy1KFPa+OXtPG212
	YqVVYEJA9UyDDKcwu1wqYwOUIZh5rQF5AiQZzTxo0OHvd++Prc/vLvYCbGZF6PZaC6T7OKqh6CK
	NZx2nJte3TeSHj62HXD9teM6RaLDWTEhe5t6s4gaBMiQ0cKUiJnTWKTb35h+KyAp9Pbr2EYZn2+
	erj84=
X-Google-Smtp-Source: AGHT+IE2o5mDhsvuCmWLmP3D4Dz519WVJ+NTPBdX/XXRWo7SqZH8onvtPetftQxVDmOqLZZq0NMxmw==
X-Received: by 2002:a17:902:d50a:b0:276:76e1:2e84 with SMTP id d9443c01a7336-27cc2aa7dbamr63353465ad.3.1758709607690;
        Wed, 24 Sep 2025 03:26:47 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:ffb5:d3cb:7685:ecfe])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341bdb5f8bsm1888800a91.16.2025.09.24.03.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 03:26:47 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+f6c3c066162d2c43a66c@syzkaller.appspotmail.com
Subject: [PATCH v2] comedi: fix divide-by-zero in comedi_buf_munge() 
Date: Wed, 24 Sep 2025 15:56:39 +0530
Message-ID: <20250924102639.1256191-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comedi_buf_munge() function performs a modulo operation 
`async->munge_chan %= async->cmd.chanlist_len` without first
checking if chanlist_len is zero. If a user program submits a command with
chanlist_len set to zero, this causes a divide-by-zero error when the device
processes data in the interrupt handler path.

Add a check for zero chanlist_len at the beginning of the
function, similar to the existing checks for !map and
CMDF_RAWDATA flag. When chanlist_len is zero, update
munge_count and return early, indicating the data was
handled without munging.

This prevents potential kernel panics from malformed user commands.

Reported-by: syzbot+f6c3c066162d2c43a66c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f6c3c066162d2c43a66c
Cc: stable@vger.kernel.org
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
v2: Merged the chanlist_len check with existing early return
    check as suggested by Ian Abbott

---
 drivers/comedi/comedi_buf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/comedi/comedi_buf.c b/drivers/comedi/comedi_buf.c
index 002c0e76baff..c7c262a2d8ca 100644
--- a/drivers/comedi/comedi_buf.c
+++ b/drivers/comedi/comedi_buf.c
@@ -317,7 +317,7 @@ static unsigned int comedi_buf_munge(struct comedi_subdevice *s,
 	unsigned int count = 0;
 	const unsigned int num_sample_bytes = comedi_bytes_per_sample(s);
 
-	if (!s->munge || (async->cmd.flags & CMDF_RAWDATA)) {
+	if (!s->munge || (async->cmd.flags & CMDF_RAWDATA) || async->cmd.chanlist_len == 0) {
 		async->munge_count += num_bytes;
 		return num_bytes;
 	}
-- 
2.43.0


