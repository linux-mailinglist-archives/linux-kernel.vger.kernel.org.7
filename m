Return-Path: <linux-kernel+bounces-739639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8187AB0C909
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 18:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB94C4E2F54
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7744D2E0B6C;
	Mon, 21 Jul 2025 16:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fj3s4AMl"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588772E0B58
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 16:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753116267; cv=none; b=m900Qt1Bt2VEI2ryfj7qIb7aW4xKfRwpc5x2PHprEObvwGQk7d2lB8mY8rb44UwufTBLO4R7jF6KWSYGjAIozhEzpre7QSN3W7bT7f1x0UwjU/Q9L2b25n6x7LMpPT+cXvsLvALxxi36v+QMHAJBj9A5jMULU0wI4MFpKjgygns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753116267; c=relaxed/simple;
	bh=O7nGlE2cUnoQsJ87vOVZuT5VL9XavOP7p041iJsJGAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lp2dixTPU6oDU9GFW5j4C9YrG4tbQZUtnHzaa2KA9sp5ouv6EKd6PUynMpwSeMggC8nRtxozVxS3IlGZ72rgcKZ36vS0dZr018VbUNzOusH4ijC6GDmSycLisXiQl3tOjXTXLUve/gq6wDT+BGW++bgz9oRW0377FH/7u2QEOkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fj3s4AMl; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6077dea37easo7089878a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 09:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753116265; x=1753721065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FKskQkPQDwDVwakSdk6+iW0gLfYzv7Hl13YRRQgIlwQ=;
        b=Fj3s4AMl1zx/6yO5znnVdcOd5GQaExNcHiANx713hni/ndbkMcGN5/hWRede3susIu
         rE6E+B+4gpIgH20TzjK2eZ5wwuUQxGQry0IjF9hhsvVBDJUVEIoNZmhoXpUKfzwk9NvX
         zHEGGwlypGkB6IEqQAfQswT6BxoyAVY3E3ch3xo4BhdxT4x8qDsVDZmkwtBCMI3GAOK4
         2YvwQagmURcj8iX9p3qwuRxOg/F8UcTkUOehBuhmiYA5x7AmuZnF5CLqlx4BswvSEpnI
         us58i0wCYy4WLbfEftu7MON+89SSA6Gz/npcmCI9L3hzrWkWEOjr1yEK3Vnvja0PblWN
         dbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753116265; x=1753721065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FKskQkPQDwDVwakSdk6+iW0gLfYzv7Hl13YRRQgIlwQ=;
        b=YxZ2P3YC4WGEoTfCmA5kRz7hl5/ESxckpK0bEf5A+4P5ZKhWuaeVmk5GavlImJUXzF
         nz4eZBUfdyB544FydD5G62GjEkvDhWndYfyx2e1mHtssLrVlrm36QKaw2ICST/1Ei39x
         uSbeb/qTsaF+3fDiCM+lQm6+jB9fL0aRdwhHcME9TrGyzb+1y9cRWpdxLugQXzyVNrJW
         apsVHunLfysLRQqB+bLM7blqnXh/RgewazFIJ5dVWZOydnRoq2USYxuvZ28asJmcyns2
         /D8UzOrE82/hVv5TxrFEKnPyyX0vgkDptWeXPgZ+CrguhHt+FhnoHo7shps0fx4F9k1A
         brRw==
X-Gm-Message-State: AOJu0YyrhMC2BQv9I+F86oru6Q4RzZVsCtz/w01YL4HwaohmQ7bFnloR
	EoP/chk3Bq4BWiKhTOUdcHaM4VUEoYh58Cqx81wA/S4ikg0aK/i0PtoB
X-Gm-Gg: ASbGncv/7r4VAGgozIE2BTGPm6A91K8bw6nHlGHcntEW4RALK7Wv5KT8Zlb2ehZX+/d
	CLI3yFksWqnSx3RSWJExNckTcnpvy6lji1SBOvUV8AfRRIcvoHtv+t//E24sn3F2prBNJOLudue
	PrtsJnWE+ZjA+ayJF6Jtnq9j4FyaKfZ2S2uYDkwV1ma8O7w4DrUM4gaJvKH8/o8lTFVx955w2P/
	FDxyAYXd6zDmLUJbqCmo4pRIm85KqdYLG8PSqdyfcMGqdKev4WUFOUa29/+vVFmrXSolpR24vUx
	leUxCu0mmynxBLLSCCAYn0/qMWfAQAAvBPj3XKYANvxycg3ksDEjlAxE82w5cq9nDU05dN9jvmE
	H9nFBRmYTG3St1qzcFVY=
X-Google-Smtp-Source: AGHT+IEIY+6MxOvCrh2HOD/KC/SO7Ewz3vmGpX7AcSRvRANm9qXC6XIwEIMtliVBiPMsW0gORPG3CQ==
X-Received: by 2002:a05:6402:254f:b0:60c:6c85:48dd with SMTP id 4fb4d7f45d1cf-61285bf83d5mr18607084a12.23.1753116264269;
        Mon, 21 Jul 2025 09:44:24 -0700 (PDT)
Received: from zephyr ([77.237.184.54])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-612c907a5b1sm5662655a12.53.2025.07.21.09.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 09:44:23 -0700 (PDT)
From: Ali Nasrolahi <a.nasrolahi01@gmail.com>
X-Google-Original-From: Ali Nasrolahi <A.Nasrolahi01@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Ali Nasrolahi <A.Nasrolahi01@gmail.com>
Subject: [PATCH v3 0/2] staging: rtl8723bs: fix coding style issues
Date: Mon, 21 Jul 2025 20:13:41 +0330
Message-ID: <20250721164343.8395-1-A.Nasrolahi01@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series addresses several coding style and comment formatting issues
in the rtl8723bs staging driver as reported by checkpatch.pl.

Thanks for your time and feedbacks

Ali Nasrolahi (2):
  staging: rtl8723bs: fix comment formatting in basic_types.h
  staging: rtl8723bs: fix comment style and formatting in
    osdep_service.c

 drivers/staging/rtl8723bs/include/basic_types.h  | 13 ++++++-------
 drivers/staging/rtl8723bs/os_dep/osdep_service.c | 11 ++++++-----
 2 files changed, 12 insertions(+), 12 deletions(-)

-- 
2.50.1


