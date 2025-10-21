Return-Path: <linux-kernel+bounces-863850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0926DBF947B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA34C18A7E9A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44714D515;
	Tue, 21 Oct 2025 23:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eUNGPfhX"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA87C1A00F0
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090332; cv=none; b=SBlEp2Tol3HPL1yppb3tFI6UeATTMXzGqjJ/D7sJGwOJ2/v4Kx2CWu6Hj2h2D/WaxQcichhBnXSzeU1Xmvx7O7+Vbux6U198K9DX6FmyRLpyXhBJOaAiji0DDCrgBIoN5d6YfWe5+4tSUhgCBWuF61QZz2pxTda8n+NGaYxPlhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090332; c=relaxed/simple;
	bh=k+BnBeiO3Miqb94H3arg+enUoQaZ7GMv752bGXRupMk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Akz7mf9e0sFBLZ9FbF08dOupz0JcQKyL26LIsMGDCaS0EDTbM++ucKaxAXAEvnQKPwI0St3DpX9TGa10eFjbKUbqGQKcsQ5Rl0NJHHa+5JpZb5i0YulnzQXoBDTQkW70XWDEmuzcc/psu5A+9mGT1EaqMFPgHtEsZeScMX2Ilog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eUNGPfhX; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-427091cd4fdso2999580f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761090329; x=1761695129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5g7ObkSqnx53X5/V5YJ3w24qsBA4fQoZHAaxTh/BVec=;
        b=eUNGPfhXLP39vMOfAUDfCcblMHl7d2kf57PBSlZJknzWcLk0uYztpLbLe6FWTQaG0b
         3mCy0mdq+HymNkEgN1WdJc0Gozm1fEfR0+EYs4yP4AvWQoSyjAFOHKLqZola6F+nQyr9
         DfqhhglJGeivB1kXJCKRglBJa26QnXSl0CnkG9QIpEBISFNH7HfB583w4jjN2hWZj3Xm
         zyG1zxCIR8damJw6ccTpwuQSDsot0ESiPmNaoihE6Eqy8UIKypIvq+VMrJVDk2+gZ2Dx
         vZePwdmiLP4gsQMFHY2Xtb1+KpgzqTOj1I03/lCzKDObE78bopoLHG0UkdfbfrnTNeiI
         bpzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090329; x=1761695129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5g7ObkSqnx53X5/V5YJ3w24qsBA4fQoZHAaxTh/BVec=;
        b=XJpyJ1Kjvw19Aews0cwpRYlPkT+C0YdQHmz8y6tNqiQbVKFfbGJfGSL3ogCTkcmLqz
         Y9itP9kuioFhPkN5gVtLCV6Cfq+OCTuNSiZOsd1Q4ilwRlrQDGdpvWZVbAikmnYYeb1l
         xhLJIEHb2bf4ZtwRjC87XFROurk2JB+b5oeMoRJmzTES79Otj0oL65FT1EqDL+7ZXtJs
         xkWzt5P3eeVi7d+3OCMI8vbXQv+aw9wx0/LdbqIZlI52tfy9AWFaqHiggSjSdmc8fm+T
         G8CGpvhdnd5ijuTvhnrTP9pmJgGiSgeZ/1gTUIuFKcBGaowIlGRUZ+iw9VWqzBW+nsBz
         TrvA==
X-Forwarded-Encrypted: i=1; AJvYcCWYkK/pE9fIdMi7pM1gt4CMQdZ52XimySClpUicikWvQd/8KKH/qedjQ1eN1gN9IrnATK1eblYzxfV63fg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+MHLpSbZz0IuFse7crFh4srUvhSMybvvGH+Nahrc2i5pi5C6N
	AJAW7O01uHmS0cagE4a581UCx1LogqR86ZsEv/kxoQ4Zl96vTUE82ZUJ2InOQ4cXPZw=
X-Gm-Gg: ASbGnctjqUgg27ItZwr+w7YNnw969W1NVWaczAgH1cjo0rg9JHg/Cw4BQbthX+ICgp0
	MRDA0hQK5MCBJM/ZZVIl+NEXXvot3+JLwsAsHSfMFrLWqMDOZ0SsI3Y7BMQqiGh4h1z1/KF/kPH
	JW04GHzudvW5Fv6jgk93MrPvjiq/6uQPue2b9oxQPzGoj6UzNsZR7VPVlLcbaAGCunkxh7sUwEy
	ELLh/oUF3jAo6YamY/La1G0gLZ7UD1uLP8VK2uRkw79yIPnVi32PN1o8nQDHnNCaRN46b3bflOz
	w3mdzhYVQHT+C7zKncxJZBMHpxSCXgEIvY1D1P2DRu4St7pj2cSWyVSnHn1QC6MQixPh0TBRDHH
	feG1XTvEFjoK/bU46ELjd1UITbXQtAv/ABesxWEYjAt+6Qq/hrWf7pJsiQr97j7Nf468MdYrGaN
	qOr//5F+AKComnaMxMsM9RAuzws0K6Symj6/SyhLsCXPF+9s41xBlFaW28vOd6ubGPCSwJbPK6n
	sNk5uAHVYJ9TvRrEhDittYHW0uM
X-Google-Smtp-Source: AGHT+IFLMuoucFczZUZlkgqlVzRu+z33xFXdk/m+zzZi86FabALi9UPFsvpSS8en0ggRC5DDvJZhRg==
X-Received: by 2002:a5d:64c7:0:b0:427:8b4:5bee with SMTP id ffacd0b85a97d-42708b45d53mr10602822f8f.56.1761090329369;
        Tue, 21 Oct 2025 16:45:29 -0700 (PDT)
Received: from linaro.org (host86-130-206-17.range86-130.btcentralplus.com. [86.130.206.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5a1056sm22247870f8f.2.2025.10.21.16.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:45:28 -0700 (PDT)
From: Mike Leach <mike.leach@linaro.org>
To: coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: suzuki.poulose@arm.com,
	leo.yan@arm.com,
	james.clark@linaro.org,
	Mike Leach <mike.leach@linaro.org>
Subject: [PATCH 0/1] coresight: fix issue with insufficient claim tags
Date: Wed, 22 Oct 2025 00:45:19 +0100
Message-Id: <20251021234520.3355-1-mike.leach@linaro.org>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All CoreSight compliant components have an implementation defined number
of 0 to 8 claim tag bits in the claim tag registers.

These are used to claim the CoreSight resources by system agents.

ARM recommends implementions have 4 claim tag registers.

The CoreSight drivers implement a 2 claim tag bit protocol to allow
self hosted and external debug agents to manage access to the hardware.

However, if there are less than 2 claim tags available the protocol
incorrectly returns an error on device claim, as no checks are made.

If insufficient claim tags are present in a component then the protocol
must return success on claim / disclaim to allow components to be used
normally.

Changes read the CLAIMSET bits to establish the number of available tags,
and adjust the claim returns accordingly.

Applies to coresignt/next

Mike Leach (1):
  coresight: fix issue where coresight component has no claimtags

 drivers/hwtracing/coresight/coresight-core.c | 26 ++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-priv.h |  8 ++++++
 2 files changed, 34 insertions(+)

-- 
2.32.0


