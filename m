Return-Path: <linux-kernel+bounces-890744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B887EC40D2D
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 17:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 57A264F5A5E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 16:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AC2331A48;
	Fri,  7 Nov 2025 16:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgR9S5dN"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD5B25B69F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 16:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762532018; cv=none; b=upxpmcBWjOGJOGwWVEYtU4nzugeiuOr0H2p4eMpVW/rA+GQo8wTi8C7Xn6UOF1AXynS84SmhQUITPhLUjdgbOlIGIJmH3v8ahBXOj8Rj7q2UEayv3DIlpcxweZGs+/TUvbMeASAywmn34CMLXcO9yi01RO1I8fggwMfSJ76kgro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762532018; c=relaxed/simple;
	bh=006rTTlryCDWfBVRjbK4RazdGrSd+IIXntBYe4RAFOk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Y34Q1uHeDtqhj4wyykEMJC44PfmrDInTh998mcQor66UDaN4RarNFCHif1L0cRFoqSAr3JOpZzxmtfkSzj/XUf8Uxt/b9sEktc0AI6z0EIwHxT6UW9GeJY4bYgPtSbml44KCQZLq1T4Y1Y0/zyOhm78pXtMEEJtbVIoA+xfZhV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgR9S5dN; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477563e28a3so6663435e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 08:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762532015; x=1763136815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=c3zW5hXoAW4Cd0eifmMrG/E0EZQc4mLecW94WDy6VpY=;
        b=SgR9S5dNAyj3Z2qwxS+dQVGPHzNASd/DzXHp2N4awc+ybGEIKOlZzRzQsR7xrVoyXO
         jy0YYyBw5JbnXPkp+SqZirkiryiDUsTMkTrTu4lxXtciIN0bYYy2RQ7KlauJ6QqlxgKn
         8kI2eg1QgAR7VpK+2uWkqSpB3g33gqOjPH79KeObWyLHh1e73oJ++HfJSlBGbqhdERTt
         W74aAv8eCRLprNNswnZV2WYvEvvczgaO0SDLnZdZQ2ishZV+qqWbxDDqMVbi868rHkpP
         kXsdy78rKth05Guf5KX9pxZ490dh7q++kWdpJgmvAE1QfDlBWPlpUJyo6/79fQYj3bGd
         4mEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762532015; x=1763136815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c3zW5hXoAW4Cd0eifmMrG/E0EZQc4mLecW94WDy6VpY=;
        b=eQJFR+0OVOK8otAhe4WH5B6VjtcakpBmZEKGh1RNPqv+6v2l1UUM6moD6liWme4aaF
         6Uy0AJBPw93v87qomVfk/+bzIUFBZl1qesc8Bbi+rgubh+hdX1pJOrT/42bxFjBoJBUY
         vGjKUfaxDUXm8X8g+ze681cVvIE8UeWqdA6G6UCe/xtptBv+9fiS+BplWdItXJgmXiC7
         tSnm2Bf1v5godVFPlXalK3GSE/+c4eTDSdl3mxaGB2CD/WVZg9cjnv4KeonPETjTIOU0
         qOp+u+060gokL/2W98MyY0KcVIIdAYDZREM3zr/WltTCa+Ip7P0wr22ylZXRH1OjoU0y
         eAHw==
X-Forwarded-Encrypted: i=1; AJvYcCWmfp4oEb64Wisfup4oBQ2WQ38xtWl3cipChbasSmgI1fTM827ZCrCB0bTiqEc/DkMChrtQPr4wv4Bl/eM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwduCoLHqA2NsSmxEXqitX5C/THQKdTqH6jdPbU3plyXICgLdLc
	1s7Pkn0jLI60+UEM5h7AtV6blST47dhgtAgj8MP9kpC56g14+ppowzrf
X-Gm-Gg: ASbGnctjsDR4SNNUCWG6kcJZvF5JRusCFhJxMOU/ElIDRUY0v6tGwbW/5hKaOvv0mfk
	EBAmso/iXqChyH4ByLoGmIouq7X3bc4Fu6+EJ9j/yD6TGdLEKMlFG83jxVC0Yy6z3VFXy2NOQLr
	11c6bzXy3h/J4rA3m2XGhQmt9FtU1a4HhgrLk6gdiiDfImq9Q+FzcfnTXVR0tDGfzbDftBXxO+A
	mUdngBcb0xPgoFXHANDmtspa4dlaJ7fc/7xcJ4OUOPQDk0iKXinta62OhWhRRd0NVqWa10fteoC
	1I6k8O3L3k5/WN/0o/06XsGRtvs1blVBmAgFwS2uDZFIv9Xfm+bFo2Ee+06iDmVAWeeNhpr34D0
	zJNzvTHLpINOC8ytARCquetQel7l/eH895hMBdHEaaAzrNQ9qp3B1jMWfjWJeJEUZOUxEHuftcQ
	yUk5E8i192KVWqi90rAHfxyzaLHJLlcw==
X-Google-Smtp-Source: AGHT+IFzbNyw6eRdGERkyb2zGQzawSNRB0cz1vEopuvnV2L3SELsmFsbhHoyFtAiE+78OiM7x/+www==
X-Received: by 2002:a05:600c:1ca4:b0:477:4f97:cb31 with SMTP id 5b1f17b1804b1-47772dc4ed5mr149475e9.2.1762532014978;
        Fri, 07 Nov 2025 08:13:34 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4776bd087b1sm66665955e9.16.2025.11.07.08.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 08:13:34 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Srinivas Kandagatla <srini@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] nvmem: airoha: Add support for SMC eFUSE
Date: Fri,  7 Nov 2025 17:13:20 +0100
Message-ID: <20251107161325.2309275-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add simple driver to read eFUSES with SMC commands for
Airoha AN7581.

Changes v2:
- Add review tag from Rob
- Rebase on top of linux-next

Christian Marangi (2):
  dt-bindings: nvmem: airoha: add SMC eFuses schema
  nvmem: airoha: Add support for SMC eFUSE

 .../bindings/nvmem/airoha,smc-efuses.yaml     |  65 ++++++++++
 drivers/nvmem/Kconfig                         |  13 ++
 drivers/nvmem/Makefile                        |   2 +
 drivers/nvmem/airoha-smc-efuses.c             | 118 ++++++++++++++++++
 4 files changed, 198 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/airoha,smc-efuses.yaml
 create mode 100644 drivers/nvmem/airoha-smc-efuses.c

-- 
2.51.0


