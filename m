Return-Path: <linux-kernel+bounces-887675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8759BC38DAE
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 03:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 420B84E375A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 02:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FEC23EAA0;
	Thu,  6 Nov 2025 02:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/ilDATg"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9D123BD1D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 02:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762395866; cv=none; b=tqH00HOZS9aah9NKSPN/eaBOEvIsoEMff6xhH+2IZOS7KinBlzlP1TYV+imrR+vj0+cvIJiXQJDHeZXnJzaqt5Nvhp4D2AzYbNEoJO93/CkjRIJl/CUELSHdpFnglkEGsodo7bOj6Zh/zirtLB8iWr6XtBpfqOXDt4N/SPg8rL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762395866; c=relaxed/simple;
	bh=JWCfGgBmQQxrxuCl1RY9fu47jEEgQx2cBaxVGHaxX+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hWBn3PHrH3bmXFz+9YDzM4TqJznErj9tVRWCaVg4UQ+lyl+/kKZd7o9J/ndqjgfd5zP09VniasBM+gzkYiU4onswVVilE6nCMQY1vIE+h8cXnm278imeJNCLHC7DD5qF50cY/owL6jVC+6XzqtdAJBJJcIXfz24TOYzVQPmqRWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/ilDATg; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-28a5b8b12a1so5249085ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 18:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762395864; x=1763000664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0GaLlObt46a8EJpPZb4z/i0Sg3qenVChJ2WAkd7GSp8=;
        b=D/ilDATgeUNIqOnse/WKjaaryo85WsygweY1UQTyd+AIceGpf6myXR6AEl351g3zwC
         EL8l4d1ilspF0bw7vYROtQMU3lmwJiSxgXKPpA2gaOPhy53bA/hTnbDasHM/9w9z1yE/
         UzeVc/Pb+RthEh6JPhSupB5LzYVh/X/y4JXWLqUyZmN0lsdej4PHrTRax9XwMmPmBKBx
         K4syC1S/oYBoHHsUQ3ipmTISVC4xZfrm477URV+onzL3ChJSaezV2I7Ad7lt+tS3H+kx
         r80ASHnTlJ0Ce4BcrNtl7k2mlg0cl42zRp7nhBPRnw98jr7Eg3iv7ly2+Uga+FCvnJUS
         4q7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762395864; x=1763000664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0GaLlObt46a8EJpPZb4z/i0Sg3qenVChJ2WAkd7GSp8=;
        b=hSBODdwuYq5ZS0lTlpWExLBVT3pv288h0sdsqojq4KA5liqUiljRWsQG7Pjp420NDw
         5/M9oLZGbJBHFvlwRhIRwjXCGx5eLoH59SQQiZv0uaZ8hO7UREwwRDl0cZkQpuJ6gSiA
         kygHgFuu2ZWkVpmvw/YsfdxybESWKi51R2XUYXa1TudOheunK9/4963hTdqXavzaWuJr
         pbUlin271SiTL2vnYwYXnNT8IAHVU29oHnINEWUNlyTIJdK5wMV/zic9Hpqy9MJgPRHY
         ArwJjl3L6LzRertIOX4X42sF60I4cy4dR8JKjkGL8McTUhnojUI4ytzW4xnd3f9BzcGg
         46dw==
X-Forwarded-Encrypted: i=1; AJvYcCU2p3W5xHnMBJLQpEk4Y5TGnbXGmbJJAcq/vG2xL4LzIlmNHtVRw0B1mLnCHpe7dUjwgdgv+MkuTs3fOF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YycVHnGpPfwjkN6ApvTNDq0RB5RopqOgBRwccSXLv5P3A+FfgOK
	lxnJQjVTTXLEDJD145Tr62t8o97BYVVTfnJnCHgCCrX/3PUL/bv8bsuW
X-Gm-Gg: ASbGncvHQCqESoSS4xGYKJdimXJgDQ5kV52Y3I/g3TqzMFJ9CwVbFnvoe6BnPC+uFun
	kE52tA49QLMMfVP9/y8IAt0diXGKG2IfefZSMHeZCOS0or4GVOOJ8ZkdNGezgzh/SxoxTgkqeE9
	wOL+6dD2grHb0T1HwV8h/uxTwxO5AtkHBRU70iZ35OykivpYLvsTfsn6aaYjrcThGuDlGWZQmhO
	4+Wx4D8F6ukHYE5dkSieRQA86zLuMpElKEdbhZqPsJoL1z9FjVbm2rMHtLAUlskl3QL6Im9eWIx
	cWAw381nfXY3cIDf6aFnOHza0CMp8xOuqVCsnpZM42qBWDzqgOnOkND1KlHY0XwxmpNV/3H9a16
	qlk+TLMM4Fqq+M0ZEDGmcmd75Iro7y53mqmgjOJkhzBKq2k1E1jiUSdYytg==
X-Google-Smtp-Source: AGHT+IErrz9agjCHsj6Y7R7pkGgYn92tuq2BTiQ/UIRvnUTq70BO/rMnUcWv2UD6iPMrYeceNuar9w==
X-Received: by 2002:a17:903:1ce:b0:292:dca8:c140 with SMTP id d9443c01a7336-2962adb9205mr76924825ad.44.1762395863655;
        Wed, 05 Nov 2025 18:24:23 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5fdb5sm9399935ad.44.2025.11.05.18.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 18:24:23 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Ludovic Desroches <ludovic.desroches@microchip.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:MICROCHIP AT91 DMA DRIVERS)
Subject: [PATCH dmaengine 0/2] dmaengine: at_hdmac: support COMPILE_TEST
Date: Wed,  5 Nov 2025 18:24:03 -0800
Message-ID: <20251106022405.85604-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First commit fixes compilation under 64-bit and second actually enables
it.

Rosen Penev (2):
  dmaengine: at_hdmac: fix formats under 64-bit
  dmaengine: at_hdmac: add COMPILE_TEST support

 drivers/dma/Kconfig    | 2 +-
 drivers/dma/at_hdmac.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

--
2.51.2


