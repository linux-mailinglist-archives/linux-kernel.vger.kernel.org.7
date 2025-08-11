Return-Path: <linux-kernel+bounces-761784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B91B1FE6E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 452273B359D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 05:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213B32609D4;
	Mon, 11 Aug 2025 05:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OS9iFu/e"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412EABA27;
	Mon, 11 Aug 2025 05:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754888891; cv=none; b=egYB6JKMgKvdXE0j1+qRuowEyI4ohtzaM5cfphIomGfg/gI2JAqmZfjV0bcEA/CTqh2EGuAZJWVPqJDYB9z9SUQocQ3aY8VsBbQwfXRMep01cdowFkrjsd1iPnlvJmsEBBvZOOpvEHCBvRshaWZoX0eVy5W8H8uIuA59jsXF8LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754888891; c=relaxed/simple;
	bh=RMY2bATnV4cjLgOWCRTmYiuPfDVBcoxAzako/99mMSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tDRbtlRxDE4siOSxWXzkK5rfQihxdFnnu03TS7DxnOW9U9kqVJmzvbXOP2VDgY5tYUWx3FATMSw//dJhTGnzI32qDyRWv4mXlvWSdlqbWtinOZwzXwOoLgAVskpmx0FSL03bpMU7VZrS6jcD5NuTdSMDXxxb5KzOntUOQNLCpAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OS9iFu/e; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b3aa2a0022cso4521915a12.1;
        Sun, 10 Aug 2025 22:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754888889; x=1755493689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3uJx6H0bgZMNvKN2xZWp5t68BRE/GUQFBMyhoVqXJA=;
        b=OS9iFu/eJIFq4RD8OvWMgmeW0Fumf9iu8sESNdbjzoUOYGjanCoumQPPsH7zZV9Hnz
         JmUojqD2qFct2704BFYKNG9H7aVgL/m5QA13vnQgYLM6PqUq6QpRAF7Ypi0rG1nY6R1A
         W4LiL7n7Q0+Ak4k4de1JJVNXLzNhyenURu+4yxBWW3ngpKb/S5fl40/5viF8FdKZ2f72
         paPXjqz4aZjU5kAwQ8w9mb87ayqnhdDDTxiVVWw2A/sJzeyTJrSxMvqWcp5HkN3FI94F
         qqOE5CJZfkXhvPDcBzLFqg04YH4VAC28f7OzrzDqGwSo6UvrKfVhPOwraRAjKhY85syr
         Z4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754888889; x=1755493689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U3uJx6H0bgZMNvKN2xZWp5t68BRE/GUQFBMyhoVqXJA=;
        b=XY4Ffmyzo3L9qXWwDI/OsNL2e8SH0jgO5PB1ghMZ2OwKJNhBRJjfcBcVl1v3s/+91P
         ujjXyhzF2khP1ZfIUOANTxv3+F9KdbC4S4MFUFhEk4NwBHBxxTgaMXfOlRRpSFOzTWgM
         UyVFoTnnnDEI6ta71FWVOo4uXmMR7zjYCFZuAdv/naN8tJa22/RbIETHAoXhdDxR8yT/
         ii7dgafwHzioxkBivoWgyWVGVBvqCQfXUdGLiiC5rVXUic9JPaxCEg0JlU9BlZ7xZgLc
         yQc1GZK+owmB3r7H7hZ9f2mol/yBiejAmwKkA2QUlN7Jzy3buvJygNfCpGTKseCIPZvw
         Y8yQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcqZQOxzYb3yo/jHhsJm+N4ojY0S97TLQrnnKg9RIh/zd3KZchDZGbhpn9O/E1h8wUlO3/h+z2utWXshi4@vger.kernel.org, AJvYcCWZ1xR87nWgnIisFzN48NAWrrH4DlswXIUaRudkHlZWv9gWNXDZxJJL1YESjfZ05iLg+z8vMqd9yUXeng==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Q1ZmJDMmZeIKfDJQpkWGvDmYjQCav6NDKp08E0odTQcjGKqX
	fFUAVwMAQwWEsG59+OhPFAQ/uSL1x1ms68bYWrovE3/7f/uKQZBh8UN/
X-Gm-Gg: ASbGncsraX5ihSwUbMntX1k2kn8UONIJYbEePsw8azDCgyRoSZgtHCYt1Vf2vDr5mTY
	2Nbgd69tqsEADQRIBzPkh5YgwgjcWjVDAuzismKvnZ1rnK0Qr6QYItpePapWPVTXE5qS5uQGiqL
	7IIlBgWWEhT3mucOAqgaDXdEkuT0w1Husw8ogTh2VL/MxhLDdxae/vM3aQ1Aey1uQIAqct36XHK
	EOhqg3hgLbDF7fmennH/GZ4c/YvAzRbfdrPFiXec2hSzZXPrw/c06rJU9P6g7ssLzbHmb06WM6a
	Feh/XOCSuv+ofys1pMdb/wh9oAjBGkBCbJTcd/761jSpXk8nbzITfMncy7+z4tNWR0RPVWr+aN+
	CDWGLRlzr5RTfDQfwawpfrzcopSdjzLkLAviZ6Lcvpvq+aejiint8Hcrh3Y9onKg=
X-Google-Smtp-Source: AGHT+IHRP2ORvjcPgmCsDArFfJ7uqPOYw1EViOzZhBinQJpg8Rk1T4jMMRJITTHae8iEQf9wXsYajw==
X-Received: by 2002:a17:902:d4cd:b0:240:92f9:7b85 with SMTP id d9443c01a7336-242c19aaf88mr158054415ad.0.1754888889438;
        Sun, 10 Aug 2025 22:08:09 -0700 (PDT)
Received: from CHUACHEN-M-44LQ.cisco.com ([2001:420:588c:1300:b0b4:efd7:1f57:6e0e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f21c65sm264726815ad.73.2025.08.10.22.08.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 10 Aug 2025 22:08:08 -0700 (PDT)
From: Chuande Chen <chenchuande@gmail.com>
To: jdelvare@suse.com
Cc: linux@roeck-us.net,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chuachen@cisco.com,
	chenchuande@gmail.com,
	groeck7@gmail.com
Subject: [PATCH v2 0/1] hwmon: sbtsi_temp: AMD CPU extended temperature range support
Date: Mon, 11 Aug 2025 13:07:51 +0800
Message-Id: <20250811050752.76030-1-chenchuande@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250810084307.41243-1-chenchuande@gmail.com>
References: <20250810084307.41243-1-chenchuande@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuande Chen <chuachen@cisco.com>

V1 -> V2: addressed review comments, also save READ_ORDER bit into sbtsi_data

Chuande Chen (1):
  hwmon: sbtsi_temp: AMD CPU extended temperature range support

 drivers/hwmon/sbtsi_temp.c | 46 +++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 13 deletions(-)

-- 
2.39.5 (Apple Git-154)


