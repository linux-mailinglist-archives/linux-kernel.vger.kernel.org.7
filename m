Return-Path: <linux-kernel+bounces-736195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A35FB099F3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 04:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EB185A0D12
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 02:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119D41C5F14;
	Fri, 18 Jul 2025 02:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQDiBNiY"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FF21A23A0
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 02:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752807141; cv=none; b=IkN27X4aysannWHSU64I4EBTJA/09LrTQG4Rekxhlg8pN8k/1gT5RAzBhqc+UPZQ+dzskvO/RXiVROgnkXNe0PSkjMLCS+3X/AaXZVnTvYMtCCpuj8glOH7i+ReZK9Us/MsqfsFWgrmVF++OcWVHdNYvlKORRQQpHkLUTKKse8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752807141; c=relaxed/simple;
	bh=uO/aLk34PxK6RuOp80mrh8FbIyan0m1N7A2QsZ13ks0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Fk7lMbrEZKv0tXnwRitbmf2rreMLX0hJdkvu4DSq7XhckX2DqU39eHCQ3p5XxxT3V8/xYd3cSmBFuHr+vMHkm1X6bT6wFHGsL6+jf+LtJrlHShNL0TVfEqx8lRDmO548qnpzlTZkmd2K6UiR/npKvTBf8fZeJGFgWiKkVzu5kSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQDiBNiY; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6fadb9a0325so16090136d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 19:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752807138; x=1753411938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pGG0XVFo2FBP426ZvN01QcnEm/j5L0pLYY1EkcsyU/w=;
        b=DQDiBNiYMIEPu9MQMZhKxfirfJ9+LzXGk+WzoNmnQPaatVgukSGbeANupB8xx+Q8vS
         NOlty20FH7bWbuxa1VwUzA6hMYeZYXy9MvrVpX/pYhSikEOUo05FIYCS4nNpXIvSG5Wt
         seTWbbS6z0CeLOPQMp8RF5piZOzgHf9J3+6Upn2bAI2mpQZUIl6VV4No6oPziWxBx9/N
         umwurhiH0MTzXMxJ2uvFe5a9ioPzbSF8Cfr/PFRKXwV6z7opw7WccWvzNYGexS4ePLmA
         0CalIYiHaz5Lb4ISfSFr7cFa/Tx3PSzRmstnHflpVF9GqsyrhcgjoYgYZ4RPw78aAgT3
         BD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752807138; x=1753411938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pGG0XVFo2FBP426ZvN01QcnEm/j5L0pLYY1EkcsyU/w=;
        b=S0u6fHrw5+KrYG2HiswyJy3V2E232kW9CzrGnzZGGfZ4+vC0tbjj6zjyn1qYrp3vFF
         5ILyWT/MYen9CEYhxWNK7OYFY96GWqyoVhDxjkwJ0XjGgnV2Au9wp4hiam292UsG7FCf
         sxLiPE1ks5Z2G/8CKtHK7nVPsJmrkB7hh4lUXOvkqYzAHVLJG1/I3OziDyf4ewofCRqA
         oxWrQ01gsAt6P2Hdhk9m/Dc0KLUlaH96GjlmjoxZ3VdMn3K+iPWOmaKRLpABQ+PbXZ72
         C/ub3n0bGGRgFwW9nGOFfX/b7h4Oq0Scct9jQlgC3gOLmOTm36qGL4USuiC516IEeFdm
         yUlw==
X-Forwarded-Encrypted: i=1; AJvYcCXf3wN5gZUW0nfdvPrGLvsw/axHI68z6utUsyWOURwpvWQ6xt+WbO4dR35HHLrnIVzCeLOmH2KXf8Kba7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYJ/y6KXWqnTovZPpdIIk478xOOWtEO+LeqK4Mfl/zbP8+RtDy
	t0/i7omnFmLZ8lNWYNn5q1ga2t0JUFoHuiGEV3gBJlTDKqomtfK4EWGe
X-Gm-Gg: ASbGnctulsX4eg+yJIroP2z51Ey9TkjJX8X+Ux1ktnqkXufRQysevI5ziDbrwGRCEp6
	vZY593maSqwIkks+mKy08/aEYdODXTfMmTmo98hrG4UYS+YFx2Sf/UgM9PdIbLYpphRKyzk+8In
	ETQj2XDPhzMT24MQKvZz4OEWFd6ceR9kFNBnzMoOj3dJfA23P4huw54wYt4DTCXq7zsZKQGpRTc
	ukVUnHjqcQSXFOH4ft8GrqeB/+XosDcmm5ZEe/HkKNjGv/oR+1AUSJH3ELIHHA6lUi7630hVfqa
	df4WAcxZ8dJVVL99PDpBq4YmpUubTKh6HXKS6nnJycIDrSThyASiSKcDEPun4WU3TsSlVhcaxIn
	fOWjdqKtr1Qi7g7LpJ2cCRh8NtPsnwKqZqN85suK71ujXVKw53wM=
X-Google-Smtp-Source: AGHT+IGGEdFMjsd5e7qbjSVwxJTb2UjsHp4FrYMeWQlkHqMQHmF2eQ2SMeO6q6aDdnjwpskl4Cod9A==
X-Received: by 2002:a05:6214:5f0e:b0:704:93e8:5e5a with SMTP id 6a1803df08f44-704f6ac6425mr143547526d6.28.1752807137919;
        Thu, 17 Jul 2025 19:52:17 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051ba9d63asm2710226d6.89.2025.07.17.19.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 19:52:17 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Subject: [PATCH v5 0/1] staging: rtl8192u: Rename ChannelPlan to channel_plan and fix shadowed index
Date: Fri, 18 Jul 2025 02:52:05 +0000
Message-Id: <20250718025206.171361-1-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is my first contribution to Linux Kernel. 
This patch addresses a naming inconsistency in the rtl8192u driver.

- The global array `ChannelPlan` has been renamed to `channel_plan` to follow Linux kernel naming conventions.
- The local variable used as an index into this array was also named `channel_plan`, which caused shadowing. It has been renamed to `chan` for clarity and to avoid confusion.

Changes since v4:
- Renamed `chan_plan_idx` to `chan` per Dan Carpenter’s suggestion.
- Removed unrelated and accidental changes to `Makefile` and `init/main.c`.

This change improves code readability and compliance with kernel coding style.

---

Vivek BalachandharTN (1):
  staging: rtl8192u: Rename ChannelPlan to channel_plan and fix index
    name

 drivers/staging/rtl8192u/r8192U_core.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

-- 
2.39.5

