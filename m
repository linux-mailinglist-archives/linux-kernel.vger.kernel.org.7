Return-Path: <linux-kernel+bounces-758437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35841B1CF1D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 00:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 643A85639AB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC892356B9;
	Wed,  6 Aug 2025 22:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcB633vG"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AD1205AA1;
	Wed,  6 Aug 2025 22:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754519854; cv=none; b=P6IQF71rQN8WgGtowQwnErm+NzfgSlYFKQO/toiLLcTrmXBIkudkrR8XFxedgzUAXOzat2UUt2KD/jpm5YVI17Ka0cdC84Bo9O0Hb14CWKjyYbMO5CY8DwIcM6BQLqO675ps7Fe52+p4NDcZ/UrgifsrsKbgDYEG00CIH+SxGCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754519854; c=relaxed/simple;
	bh=GQggngq9RUB7V0jcF0mSBur446HCrK/DXqXlSDNNB+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t1hcUkV95msJcTIWh80pAZ18NFgpMwUAA/wkYAFBGiwtBRTCsPgPE9N7D1oWi6THbb7Qh6rGlMxnLgMeIwchgAhYk/jUce1tYVJg2OV35FQPD3GXKtBA13lGS/Kh12P88MxRsPahlG5Tc72HoNY8Eyc4S5rQE5lnzgKCIO7XdMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcB633vG; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23ffa7b3b30so3152755ad.1;
        Wed, 06 Aug 2025 15:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754519852; x=1755124652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8TVZ3Ief7tQQvhpMVUaEwXY3BktPk6w7JChPGDEPpBY=;
        b=QcB633vGjdu9DFl1/BiW1qTqMInvUhga8js97jT+2HG/aq4jU6FwaxgfEn3DxwTMnM
         6eDR/gygDNBEJqV1rCL08C28bRcvVRkJr8UD6yrbdLVJWsLy3PyTeZcaaix2Jez/av2X
         0TjgAx6KNIWiATj8qXWxQk3oyd6qkIQ0wZBTV33sqp/uvj8u0AtvOwov19zTyz0x0Vue
         bcQH6nerOam7SP9I1wUtmbMZaBL0/+wLvvCHA4Mht/715kej5+NAM7FaW8Zf/dxqVnyE
         0MZjGT5+n85jUdOjgS3j3ycmrW9bmkAhT88CNcav9ySwX0pp8DO2MpKuBSr0f2d/0FhO
         yd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754519852; x=1755124652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8TVZ3Ief7tQQvhpMVUaEwXY3BktPk6w7JChPGDEPpBY=;
        b=Zl7tPbfNUjgEk985YuXMVevtcjIWpt4k6rLnt3wbHFHb04dW9M5f9JebIKUauE0BgG
         1lhSlu4Z2h+gOWzUix5vt1Tau49YAlNBUw4Rc4FBwiJrKGrgx58NH4Bn1gkwbTQTv6+7
         ITmnRD2vTCt+gcPJgoORWGYqlS97LQfI/NNxiWUbUOlvOCvpGko4O7NPcZqH4TPyLSQn
         GxZLSAaSnJ4y2WJyFZ3lLRvAfBwEAsXOjFuxxxkBvjeILUoNus2dZwpNcsC79GtbgXXZ
         7524bhHoytHxa/xdAlWQz9lgdaRUBXwVo6niQ/FAcP9JJAZwrZISBvsvwFe0zhFWUAeV
         nzCw==
X-Forwarded-Encrypted: i=1; AJvYcCWaaeIv4BbfSoHrgbAzwQOKO47Tv1ozbABJZP9WUxElMtIYZwjvnUL58ISVhalEeodaRJFle5iJbZQO@vger.kernel.org, AJvYcCXEVpBrmaEJMDOOlqI37QmXeyQy5ynVbVztS1u7rbaSz6+s8M5HvSYmpResYvZtZDZy5OWjhGhFZ/u5eQj/@vger.kernel.org, AJvYcCXvp+LLasf1mlXICVhIuSvG5hgQanxKYF2d11Uu3Bqq3/YxZr3tsnFU668sS7oYo6EL0db5nG7CZ9Sf@vger.kernel.org
X-Gm-Message-State: AOJu0YwyvoXPeHmFsd6EIORyhfoXyCcP5/x5aVBTKTQoHKGXv73zo5kL
	30ssLUXbSvx1S8oxooITSHtG0WiZdrvF77CDfAsdxh3/fgCS4ZjkCiTcDeNH7w==
X-Gm-Gg: ASbGncv4STTm1c9KW/9kXdwkH8APDgV4UP+RrMwNFOd076JaYDbfD42V461vFPfnrqv
	TRdbtAmYCBxdAPTdzg/WjwnI5Jn333uBpyPLTgKxzyvL76AlycGouarV1SjFqJdAMI3CRWIaNdU
	IAUrp+NsTWwg11U20vjcxBzed3FklR+mGUWFFqrJeemT2Dm0+qhn2FNaerEiSU9lc01Zfh1niVc
	VUOYNvdBn5i0w8aa3eHVQUSd80teb/1HxlLcnw29CGZL82zr1Bt0h2CXPliW6yq8HteCxhH5qca
	U5crGYpUMaLXlKuhPYUqO/PVknQRXfthoLcFuXJO2tYD9PN7iJQ5iHtK+o2B3bq5WkALhnnOQ2C
	5Uxlob6sByiuJoPtowa9aXZD5fa1tuMnIJ0zbv3j+QPpKIN8PgB/s76gMnM/DNB7Cw+pkot42BR
	SAY0CI
X-Google-Smtp-Source: AGHT+IEQZbTfjz/n6EoTuO6sa0hfwF2cmnLNm1tXNXdf1KOquGcIkr5nfHYn6H6BmuAwRx0z43CD2Q==
X-Received: by 2002:a17:902:cf04:b0:240:640a:c560 with SMTP id d9443c01a7336-242a0ad00damr62222945ad.24.1754519852220;
        Wed, 06 Aug 2025 15:37:32 -0700 (PDT)
Received: from CNTWS00427A.itotolink.net (111-242-118-39.dynamic-ip.hinet.net. [111.242.118.39])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2426dec66desm86776775ad.54.2025.08.06.15.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 15:37:31 -0700 (PDT)
From: ChiShih Tsai <tomtsai764@gmail.com>
To: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: jdelvare@suse.com,
	linux@roeck-us.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	corbet@lwn.net,
	t630619@gmail.com,
	ChiShih Tsai <tomtsai764@gmail.com>
Subject: [PATCH v3 0/2] Add sq24905c support
Date: Thu,  7 Aug 2025 06:37:22 +0800
Message-ID: <20250806223724.1207-1-tomtsai764@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add sq24905c support

---
v2 -> v3:
- No code changed, included Acked-by tag from v2 review
- Link to v2: https://lore.kernel.org/linux-hwmon/20250805124449.15187-1-tomtsai764@gmail.com/

v1 -> v2:
- Modify devicetree properties ID to silergy,mc09c
- Combine to a single if statement for MFR_ID.
- Add description, SQ24905C compatibility to the ADM1278
- Remove two silergy properties,re-use adi properties
- Link to v1: https://lore.kernel.org/linux-hwmon/20250804124806.540-1-tomtsai764@gmail.com/

ChiShih Tsai (2):
  dt-bindings: hwmon: adm1275: add sq24905c support
  hwmon: (pmbus/adm1275) add sq24905c support

 .../bindings/hwmon/adi,adm1275.yaml           |  9 +++++++
 Documentation/hwmon/adm1275.rst               | 24 ++++++++++++-------
 drivers/hwmon/pmbus/Kconfig                   |  3 ++-
 drivers/hwmon/pmbus/adm1275.c                 | 11 ++++++---
 4 files changed, 35 insertions(+), 12 deletions(-)

-- 
2.43.0


