Return-Path: <linux-kernel+bounces-838632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C10BAFC97
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 11:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C85C93BC42F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 09:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18CD274B39;
	Wed,  1 Oct 2025 09:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9otv79I"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D6B241663
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 09:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759309694; cv=none; b=cUVnMfT/6kbJHbh/uW46xAvuPN5mQvc+VEPXBpoPxfMekpe98wYGSuK6dEtrx+I4WcD4TbHoJuxfd79cUbvkEjkqpYDl0TOwX+ENczk9yFopCTmOdGfQjqbO7pcZ2164gTM5gYpAWtbpNHRuRbHBx95Bw6GWWoAcCMdZu+nOTeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759309694; c=relaxed/simple;
	bh=cHh/cHIF2ix4T1MbAz3cbtmZwsbFRKUVOa1sotAMdYE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZNq5Q6qV5k8NXv6j1QW+NlZ7b7mai4Tq1Reed48Mw6g2UmanldolXYPK36Qqq4qbRGWquzk30tipxDb/ww1JiSseDmxPOzFsYZ+x2y6ZpeNQPOKFXzjQHs5e4M7y2nLaacszT3F23T14QjbO5SZuW38zPecUz2KfvU7+pX51erU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9otv79I; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3307de086d8so6454664a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 02:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759309690; x=1759914490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xdn/qXRMwLNp6Zd/Eb/BpsxnL14+u3sr4IN56KWCSQc=;
        b=Q9otv79IzcCTZSc1wotjhDEpXDuYJxhhH320YokwjB9XET1iZ5ht1fvCsOoMFvJK3K
         /bMJocRulncmUBN0a1BQsUoVoaDTRU8CyvGujuxvLxfKNdRmDR2vPx6UV0qMCwYEViEe
         czhzyFkWs0Xy1js7fyYSRXhob05ShFvT25SJwPM885/rFUv4oh1TGRO3AcUwC/MZMH/H
         MJILUt72PQcx07jZhvaAeqCN27MVGU7Oo0a1zkCp0QBpKZXlMP0nMFxebDSy7QxaRFsk
         dFBPOuUwkULF1RmNKzMnIsDorbjM7PmaLp6NxE6N0l7ZOqtZeQcefvE5woeE4xvWlmIo
         vmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759309690; x=1759914490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xdn/qXRMwLNp6Zd/Eb/BpsxnL14+u3sr4IN56KWCSQc=;
        b=nuvnatqAKI5oXfRCHqxyDbEdiNLCnRyOhTh2tECZKFaH0umyizQe75lSLuzk6XsCef
         /2pec7J7Aif/kXGYF94xnoAUEooJL9fB+gt83BTU6CmCb6dMTlo7ji8Q5Y/b/5lunUnH
         KSP51U/4cmhRi7cK0evLZ6WYp4/f0viN+5iMs3jRIxJzURFu9cgT5L1dVQaewatgQB4U
         fq0XWubK48VQJUxIhw3arG0AbrdkSYwphAgp2D/+C4/aAt8dOzgLVPmS1qQ4lmo+u+Qj
         +WyImvN5FY1kVkNdca6RNngYdRWQHczs3AyfA3k91VWU2y7pJJdEpajfnFr2dO+gpoP5
         jfvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXS9rx435LP7lNPxTT/H3ajCkQxQ73ad8M8Kw+gQccvRYdGq8XeoZTRXanvDGyMBwADP2z4016QDkM3VX0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2dltcq6i+eIqxSEIpeg75w61xhfVmWb56lOPwRFHdyz8kdU0X
	FeVH/g1cq1JlNGPW/2+DCkwUCNfh5iAdugmoThZRE3otZJr1byTZAZjA
X-Gm-Gg: ASbGnctsaCQhRquP0qColok8HUtL4ZOIxii71BoTnKP2qvrVZN0VbALG6MmiPkcsJFh
	dWfjesnqEDXuxNQFyP/5lvMiUY6/6A0n9Qwr8JXj+Ejbf4MXV5p5FUQrscS66qdBkabsryUb610
	5xGzJXHHpCTclEjMqy4vPFITe3kN1IwpgP30hKlsZBk2yYnpKgQ93NNAQzWMWTMOUL85yd1QOI3
	VMaAxkFOMWtVNpfOEu5drlPLgMPntq4++K8pOkwIBC3Sq1lVgytB3QrgYOOheqGdWjRbeXlYiLQ
	nw2ORXxtc0TArmDJGI79OGBUpo+1/yUcjP6LJejZ0T4cb+lOTgI4B0JrSZxdTrE3TNKAZOWq6HV
	j596aO7GA1yOjjfkfW4oxKHKv/tj0imPGATS7ZfOAa8+dG+ehnjJwYBOoncaNhR7Ky4O1UMWZVg
	==
X-Google-Smtp-Source: AGHT+IHCAXG1BqEfze3gHRwn6lpXtkf7tuj30SDlHiLv3IUP0y93ub/ofCCeyp+nvvaX5lId2eVgIA==
X-Received: by 2002:a17:90b:4f85:b0:336:b60f:3935 with SMTP id 98e67ed59e1d1-339a6f08820mr2965105a91.23.1759309689779;
        Wed, 01 Oct 2025 02:08:09 -0700 (PDT)
Received: from ti-am64x-sdk.. ([157.50.93.46])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c55741e6sm15477230a12.29.2025.10.01.02.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 02:08:09 -0700 (PDT)
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
Cc: linux-sound@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com
Subject: [PATCH] ALSA: emu10k1: Fix typo in docs
Date: Wed,  1 Oct 2025 14:37:57 +0530
Message-Id: <20251001090757.45991-1-bhanuseshukumar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

interally => internally

Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
---
 Note: No change in functionality intended.
 Documentation/sound/cards/emu-mixer.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/sound/cards/emu-mixer.rst b/Documentation/sound/cards/emu-mixer.rst
index d87a6338d3d8..edcedada4c96 100644
--- a/Documentation/sound/cards/emu-mixer.rst
+++ b/Documentation/sound/cards/emu-mixer.rst
@@ -66,7 +66,7 @@ FX-bus
 
 name='Clock Source',index=0
 ---------------------------
-This control allows switching the word clock between interally generated
+This control allows switching the word clock between internally generated
 44.1 or 48 kHz, or a number of external sources.
 
 Note: the sources for the 1616 CardBus card are unclear. Please report your
-- 
2.34.1


