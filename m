Return-Path: <linux-kernel+bounces-874049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 41265C15684
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 106C3502A80
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C18733FE1E;
	Tue, 28 Oct 2025 15:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reznichenko.net header.i=@reznichenko.net header.b="YCSOK9tt"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0B633F8DA
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761664673; cv=none; b=vF3jW79BC8lk4GFtoemY6xG6zR5+xhlLs7csZsybaBVB4Gi745gaal4kSsv64Y9G4bfPJtjvDa/ZzGe+/d/rQPSCK9oo+UGwRv3QI7R1xzruPYYxK2nVCV1K1J+uk7a495dkFRGcvP0KdPa6BYM+epJoyYBybO8DbVRcgegUDJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761664673; c=relaxed/simple;
	bh=MMaMHTb4Ah2CCrUzmnNSZ0wgi0JyjgLlM6vbEvp2sbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUilgGnKYmCr6O9qZOkjZftJDJ+Y5Fgms9+38RWjZxotMfgd295lhfktitTwHcRpR67bbYrgfkp1xAXWs4YSewi3Lhg/uZqAc98x/7l3ttJ5lqHSj9RPAH6Yn2ZatUby42bxz8N+HPM2IUQL0/6WAgXAngbYq1XdA5AJIZo5HhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reznichenko.net; spf=none smtp.mailfrom=dpplabs.com; dkim=pass (2048-bit key) header.d=reznichenko.net header.i=@reznichenko.net header.b=YCSOK9tt; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reznichenko.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dpplabs.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b62e7221351so5378097a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=reznichenko.net; s=google; t=1761664671; x=1762269471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMaMHTb4Ah2CCrUzmnNSZ0wgi0JyjgLlM6vbEvp2sbk=;
        b=YCSOK9ttSSGanTt51EsKsqwqq8wteU+FncXeGl3p7zWom7oOtmLbMB4jwLwccPuYHU
         luuCrzTrwXIyaa+yC/oPFsoebtAWun3X9LuEWw1AXx5aBWH3sF6Xr8UDCYzK/r7T8HsC
         HyC2cCrsbGkvSeuekO6ztDd5klOuk/KQ8cwWR0rJlqEqBENaMguPCYqwRbPGtEnPP6lE
         FtqeFBvD4lBseIn7LhpOYgnO6H8zKgsn31u4QpgjoAqr7QgQr5SpfcUjo5/rhc01mdp6
         Xj1CIuTtWajxV1h8C0IXLdBicXs5jsEC6cVLhaMDrtoEnow9+ziEW8QFQxRYptx9gXTc
         mCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761664671; x=1762269471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MMaMHTb4Ah2CCrUzmnNSZ0wgi0JyjgLlM6vbEvp2sbk=;
        b=Xfx2jldYmPExeDyBHEmIbzzWYOqlfGrBt9kj+F5GiDPMuMaFcBirPTGxci+dv8mPhT
         JkU6kEIShKzUhG6XRYaYrAALfpf8Gy/SFMQ5NmAFdE8f1wbskaoJ/KiK1B2DnrZ3NiZB
         xP9itZNVYhe41NCvx39vsqioVuF5qGKKhQGW//Gu8flScE2cIutz2+Tve99u5XNu3hSw
         ZbPz7psUgHHfRxmlp8I31eiUT/akN4Q80vXywzfameuduN4duah+ByMe6x8uQAoCd7mD
         HIVZgn+jFZHLw78licGwGDeyf0zYmVX7Q4MK0DPfzjVIwLLjAD6A7b0U/Y0zGp4Twq5t
         A0gg==
X-Forwarded-Encrypted: i=1; AJvYcCWBBf/Z5qB5O1da0hZqReg68HstE9UN7ifMDOLIjDDMj0CV+CDCE2QGjBMwCU0sbWYAs96uWoZSLDzndFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAAbt7QXhXUpdPxp3LZJaGRFuHe2GmRbijHZI+rICtQFe6zSH3
	fahJs39SVI9JpEYy7NLMyKcEM561IUTSJJB1V5UIPrryw7jj6SuQOVatbG2NQW1NpzI=
X-Gm-Gg: ASbGncsXXUEjN27KwUFezi9nGVDZg94Hm8r8ceejtoYZUlU5mZvfaGKJ40ahTO22YQ+
	EAzsjjrFOvZssf44VVG1653hKSG/UDKzhxoy8EO1cHMuEmLxFA3irQdTZ/Fi2NC+AeM6GW0AVCk
	Sn8Tmf1YTYWRPtSMO9/bIf4Z5I1zKvxHFXHoCosaIfqDYVERzt8EyEJb8YwpaYlGE7iI64pYEPF
	Ts+58/1ztbjbuc6R0qC+u4Fvuw3sphBSNh0JQZSyRkDTSzewRFRpHtrmHGHdki5xOiRUqQw1UW3
	2DKHnKYZascdHtlV1Wt5E3Cnd5RzKImnO2GgWD2tMWKx9CLQOEjxEib4EVQtoKZBKxegwPdrtCz
	jTXEij3cNMc4k8A6b4HIJEZbNDzSr5beKUU5/oPrm+Z3NKaG5T3coBEw6aO+l7kAXjEjItPG7Az
	+C5Shp1mGG1fdHG+M01A==
X-Google-Smtp-Source: AGHT+IH2TaPyS4w0bOjLoYbINLXI1oqC6DBGXJhehW0z/yn2CnV6ID73kQc6DVG+AgvO4fXzT9O+Eg==
X-Received: by 2002:a17:902:db11:b0:272:dee1:c133 with SMTP id d9443c01a7336-294cb39de3bmr44858755ad.22.1761664671204;
        Tue, 28 Oct 2025 08:17:51 -0700 (PDT)
Received: from z440.. ([2601:1c0:4502:2d00:647b:c9a6:1750:9275])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e42afdsm118620375ad.99.2025.10.28.08.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 08:17:50 -0700 (PDT)
From: Igor Reznichenko <igor@reznichenko.net>
To: robh@kernel.org
Cc: conor+dt@kernel.org,
	corbet@lwn.net,
	david.hunter.linux@gmail.com,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	krzk@kernel.org,
	linux-doc@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	skhan@linuxfoundation.org
Subject: [PATCH v2 1/2] dt-bindings: hwmon: Add support for ST TSC1641 power monitor
Date: Tue, 28 Oct 2025 08:17:47 -0700
Message-ID: <20251028151747.663000-1-igor@reznichenko.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251027191425.GA1403533-robh@kernel.org>
References: <20251027191425.GA1403533-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Understood. The bit in question controls the alert pin polarity on the device side,
independent of whether the pin is used as interrupt or not. I'll drop the property
for now and revisit if there's a board that actually uses an inverter or needs to
program the bit explicitly.

Thanks, Igor

