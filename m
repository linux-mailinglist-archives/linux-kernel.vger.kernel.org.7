Return-Path: <linux-kernel+bounces-761921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A55D8B1FFEE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D97027AB73A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA942D8DC2;
	Mon, 11 Aug 2025 07:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I02WnLXt"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC62182D2
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754896165; cv=none; b=Ew/k6zAn9Eq88pHxUIk8Ig8c830xJKUznGCZWd+AAsR/QVTr7ub5CyNgFuFypIxJACIj2K+oCgWDpC4hXmKj0e0zEWIEcVW5/XUHdcihbu+8jKqrUlL31gtnN3ltn2aYttTjtnoTohuKMhQEICV3N6JTMm/fSlpLg5fLhEwlOh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754896165; c=relaxed/simple;
	bh=Yg147T4WYxla65KOp+vRXkCjn0RCox5NBYHIURElZIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YQo2a0tUE1Od1fBWYyy79r6IR8KiIMSL+o+gvHbdS/Y1v75anOwh6SaG4EB4O+o/TBrHVqzrwFRvG74WOdbwD8Q7qiWqEzZtrSKA7B9AaaNR0tS0wpYIWuz3obH4E8qwwaoYlej7WO73VdrlbFnMu7mAv1EHGymC5u3rj/7nHuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I02WnLXt; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-af937728c3eso796220266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 00:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754896162; x=1755500962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TQJF1tsZ7Z0OP2onFvcErsSZGdBuVRlFFPersqZoAb0=;
        b=I02WnLXt4OWAnbSxH5weeyx7by69cG+4TiXViZ/Yx9ixaeba2YvRNdMHtMeTjmnW3S
         EOndP1j2uuYwXENEtB5D87QKrek7RyWubOz3TRizH9N0ggnHGB4Rl+9ETgVMuBTDPOHR
         lloc3g44pdIXZNJcjbw7AQMYU5jDV6XXvNM2O+K0+pMgOCmTsEGA5GdwFOKCT5YEMNWA
         uX/XreXMLIkvh4zQCxKMn74xvywWiyKGiOTRh408RCiewXChbOIHxokNfuKSMXGs4Xm/
         50umiMhiZzblMC5simGdjIFKkXq4EmfGUB8k2M7pMU8cjY4oGF/fq6aqVCY4k/bYemb+
         eElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754896162; x=1755500962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TQJF1tsZ7Z0OP2onFvcErsSZGdBuVRlFFPersqZoAb0=;
        b=YTCkNg5ssNk1kgKSeeLf62DyUqTb+y859qNd/pFfDNNY6rHSPLib5Rmhc7P0ySsSc4
         YcMUM1PFUyj1BWXYqpwk3m+bl5w80cUv2xXh9uBQajd6rqHx7ljgJNGs0sPHkUSeCk9B
         WLqAuFAEb+1MmEP/G+lK3rfNyGt8s6EVM3qZVuyjMtK6QChBrcISqY2tVwihdbRHBw+M
         NeanyMT69/sw2aJte9YTXmqlv+Mnsh7whMUEDNcM0Z051rlq9Ycit+vgKMTmbSZCnqLH
         kbuFMx0s9mVz5T5ytfm5yQZKbCipCuiskAiNrG8VqnmUAvnM7IQwwbPyFT9ZBTHpYxfb
         MEig==
X-Forwarded-Encrypted: i=1; AJvYcCVzZtP3aLIRywQW61aUid4wBhOqkaxBIC29iGp20a1DIdlHyiu1oOLtuMuKANJiL6bHpwfaJhZVHqKkpNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzujBdx8h0aO96aa28Zj/RaiDfxRZMhvzM2lQP5c7cAJKaZvush
	lDElB7xS/bWwF2GiE6v6r/G4tA/MiO/53EQMbqaQIn8soRk0oq6bycSX
X-Gm-Gg: ASbGncvf92OmE0dq7TvFhFwUTBhKKBQY8SUNQxcWhClQsylcjHb24690wS6CDMzfgBN
	vvNSCwmCHmn0ZhCCziJRspRZNDtPrEnbg4M31065P9C/GY7Cyu2fXkKVR97FaF1+Ah5DaoDkXeW
	P7LwQJ5zCIV1q1ttp8CAAhkU+mnXup8UZU6sOiV625Qq8yvAl0JZiD3P5ws3El7BzPvf41WmsQN
	kXeW1pEIH251eAynfB4QbQhOOVZQkwyC4Oip7avTYTLPFyu4En6FjJBXusm+r7bfcW8eNH8a01L
	ZMrkIm2LcLxip9Vov39pSGdkBT77JPR6Pa/AzlCsC6raqRGY6M0bbIS+1lVC5oE94M4ZOh3nYJq
	Sm7XzaqfLuQsRw+rSiPMQDypWDZUOgJsRI4VR17XsbasRu8hfv1XCoAVn4KcAvDKhc4bG
X-Google-Smtp-Source: AGHT+IFgPCNs5OUVvllUX1WzbEdayauDKN3fF1huY8E1N3hDKN3pD/U3iFt7tSORJIFy1nYIvHZ2cg==
X-Received: by 2002:a17:907:3da8:b0:af9:7025:7d5a with SMTP id a640c23a62f3a-af9c6fd8b44mr1118031066b.18.1754896162142;
        Mon, 11 Aug 2025 00:09:22 -0700 (PDT)
Received: from tumbleweed (ip5f5ab8dc.dynamic.kabel-deutschland.de. [95.90.184.220])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a14a0sm1979188766b.33.2025.08.11.00.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 00:09:21 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/2] staging: rtl8723bs: rtw_security cleanups
Date: Mon, 11 Aug 2025 09:09:04 +0200
Message-ID: <20250811070906.27232-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains some cleanups to the file rtw_security.c.
The patches have been compile-tested only due to lack of hardware.

Michael Straube (2):
  staging: rtl8723bs: use crypto_xor_cpy
  staging: rtl8723bs: remove unnecessary forward declarations

 drivers/staging/rtl8723bs/core/rtw_security.c | 76 +++++--------------
 1 file changed, 17 insertions(+), 59 deletions(-)

-- 
2.50.1


