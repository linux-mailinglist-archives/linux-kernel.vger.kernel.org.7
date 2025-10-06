Return-Path: <linux-kernel+bounces-843506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C0EBBF9BD
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 23:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC5824F24FA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 21:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D782609E3;
	Mon,  6 Oct 2025 21:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpvuLjag"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED5025A630
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 21:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759787650; cv=none; b=A6LwmfrLU2k1QrAW4y4BVpODhVfKT1WUU1ioEWp7gmyKPJXSazttfUP9HDtjYXL7r9cao7kNMGS0arKTelBqlyiACNGNhMXK7OC1siI7SY03HTWLrlRUs0sNYNdEXRpRYx3Mm1+eMwzTaUWZRAKJpswrDX3H8QwfXFvwUS3VZ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759787650; c=relaxed/simple;
	bh=eiISPe7E0tv7cAYf9Q7LNVtb80iqR4+ue9pgUekuy+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=abC93SDy/EHIJluP71ta+6ELlM7ppwaPECq4OwEcz3j62DKaDK3qMrdSj2tBJWJp76TF2eJtjmH8MyUf8WvocVByxfyR9HAnFV6DFfZ5/PGAdT5XZDITK2APd+A9nslIZ5RMZx/Nl315PCAZoMubK6Gqtls6BSte8mvJ17yEWC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpvuLjag; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-856328df6e1so528294285a.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 14:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759787647; x=1760392447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GzHR9nOubrbOV66JDSdOHQf9JHwFVJCFi2cD9sJyIbU=;
        b=ZpvuLjagy9UsmaEbNSIJYZ5e1y83BvWWsXOVZQzgiLMXuS4V/QjpymvSwTFSbLIOY2
         JWFy5AIxUcPBxE92gHNUE26bhgfFMZtyimXxqCdS/8QX29U61UBT8mYhvkPpFAfu80nW
         MaVSR3pkLVX8Ac2gD9W4Da2dGET7yWFu3aejDl/ZgtZ8wqtgbTKCZWHJZLwJRqCPDK6B
         AkwM2S0FKpc2d3I8kEbkzwkQnz4aOcr2+xdAC8/eZ45/xHYZy0EPPMXVCdbNV1iE58km
         yzLJND/oND6CQFGFHJuXCJKqzFU8ccvnoiKEGpZZZQNJnp8uzzqWWjIdQOYkm8rXyqVp
         qDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759787647; x=1760392447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GzHR9nOubrbOV66JDSdOHQf9JHwFVJCFi2cD9sJyIbU=;
        b=KZlWfmXs2zHzJFh6qs3Ro9G76CKmnhpixbzC6M3kg5vn1iMXH61c39/wU4SIMTMbZw
         rG9tVEk6aHBKhPRjsy0gbuFrKvhiveyjnZey0i0MoGKyXqlWESFt0fJKfLlbM6J7Ltoe
         k2EmA0mzdQrKwmMps/m8mn6Nvx6CbKdgC3pg6tfbMUEsly7CqdNYTGqg/Z6Dm4rZyBFc
         phIvpMidBSaCYvDEIThcfDsEw9ROWGzpHQBsKWnlVYlpulHKvk4rXEmra8Qyghhw3+St
         XijLIotMuIXYBAratM5Vm2tWrj9FvTVaRgkljx8t5wk0VzdiegMMh+2PqtavLBU7Imqp
         oSOg==
X-Forwarded-Encrypted: i=1; AJvYcCWAcTmyFeRvs4xUoN56KJ7f83j5HCd5NMgddWE3b0b+28kM0SJbqHO9epECnjt3o+ZonFEyrrLK1FN35rw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgx3gpit0f0fIrLfngBmc4a31uaBLzgchWlNrCteM+ZCaTrsW0
	wmFsm6AajSxFAP4H1lva2F84NNUukgCxnWaxPeB67SVUmFscxjwUGsme
X-Gm-Gg: ASbGncvt7mk2ue0I9jUr61mGAx/8IS9B4lhD2HIryUk/KXwhMuP7poT4+Kx1MVfS2+Y
	6pM1RH44x6aRCvKdUmwkVGz9V320G3C2bHjPfZTAMqcmb5fpsVUX2n2fXpr1uVqRajzd4ny3MJ6
	fb/SUn1TZ1dF36Y1/ICAFWjZePKlpQQzH9G8wt7y8NEeBtI+CSHXQtmPVpnVHiIgaWiZVecko0C
	qI9Zg+f157cM1RmyBmkE+tqHzSUK0WibWg+Krs2QbVvwCh3LLRvBJ5Safjt5tIBxMDNxZjCw3Bm
	amnKL0YHb8qsED+MfrhvPXRcGVJTtjPufLdi0MDCuXvwdCGf65fMZgwYmuQY8UkmG0QCbwVFk+F
	oymF+/vRaH5o+cqSZg5CTExv6MdQRVizH+FejTw==
X-Google-Smtp-Source: AGHT+IG0UNlyx78vsddyW3DjBY/aA6lui1aLxmretPKBkhllfywXoRVS9YugmVjoHVxZWQR0Lyw84w==
X-Received: by 2002:a05:620a:4514:b0:858:a4dd:d180 with SMTP id af79cd13be357-87a3808f557mr1974325785a.40.1759787647517;
        Mon, 06 Oct 2025 14:54:07 -0700 (PDT)
Received: from fr.lan ([81.200.23.195])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-87771129478sm1314168585a.1.2025.10.06.14.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 14:54:07 -0700 (PDT)
From: Ivan Mikhaylov <fr0st61te@gmail.com>
To: Iwona Winiarska <iwona.winiarska@intel.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	Ivan Mikhaylov <fr0st61te@gmail.com>
Subject: [PATCH 0/3] Add Emerald Rapids PECI support
Date: Tue,  7 Oct 2025 00:53:18 +0300
Message-ID: <20251006215321.5036-1-fr0st61te@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add PECI Emerald Rapids support for CPU and hwmon interfaces. dimmtemp use
Sapphire's callbacks about reading thresholds because it's same
platform/socket.

Ivan Mikhaylov (3):
  peci: cpu: add Intel Emerald Rapids support
  hwmon: (peci/dimmtemp) add Intel Emerald Rapids platform support
  hwmon: (peci/cputemp) add Intel Emerald Rapids support

 drivers/hwmon/peci/cputemp.c  | 18 ++++++++++++++++++
 drivers/hwmon/peci/dimmtemp.c | 19 +++++++++++++++++++
 drivers/peci/cpu.c            |  4 ++++
 3 files changed, 41 insertions(+)

-- 
2.49.0


