Return-Path: <linux-kernel+bounces-876823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 16292C1C724
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 23D9B4E61B8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67E334A764;
	Wed, 29 Oct 2025 17:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wJG7nB8o"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740ED34F461
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761758838; cv=none; b=Tx9ujNTQcrtd5N1fSC4r4xTcobM1fK7nSaZ3SrN4ulnqC0g+rUh9KmpiollUUYn4gToVKaUrPq5SOn3ltqUzT7vgNcpEuqgsIX+4KCZFXDyisrQEn2H0kxYbpasesD8phIBn5wDdWqq84/zxjvdTDA3nDbX4Lh2XrrMHJJ5NLng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761758838; c=relaxed/simple;
	bh=UQrZCV0Pxucy/paO9oIYk44QqsywogrGoVLEjPeYwYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PF1A13XXe6I42qeNqkdzHrcgqau294z4R4Tk0yeGPVOS9qpxcJ1kBRHaTmxA6sJrwbSIch9y9k6G4/f7VTh5eNz+vWY3fMrTaCrxhUlrNQ+c3puV3kL6P4gv6PJqmj+N+ZhKSUMZYsthE1mLSygsygTBwB1f4Jxg5kuzfe4q3ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wJG7nB8o; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ee130237a8so94196f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761758835; x=1762363635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LERQGbpK6sWnegCCieprtsVkNrIrpJVXxod/FzSq1lk=;
        b=wJG7nB8oT2/2KNvwn1h952p1IAmFdEQ8YWK/pbOxkyeokvqCX/bmF/0M6nXGf7xJXF
         Owj/abnKfQxZkSjHviLn1erA4RLG+/HTwSVSodMAUjXddbRvi+QAr4zUF4atjeSR7NI/
         ycxixns0xnVwwGUgi88G03DzAWM2BaggOAolZhCEF4r1FxElIFDukiXsebLqUaGFieLe
         cLxN8pGRDQpwXZKO4hrNfB3an57/y5WHQ3miKUG4L/lAdQhx5S+7olD4MNC4iBHJ9VG9
         Z3dRlTNpm8YBzYdIKT5RCtroyfpo7csegul22hi/5H53GUsYr1B4mnqYusDvwjkwvscc
         ZN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761758835; x=1762363635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LERQGbpK6sWnegCCieprtsVkNrIrpJVXxod/FzSq1lk=;
        b=NpvHKGcyXvjGwQhB2gaU/C5+MpDMVygKDxICNYUsnnqlyifsjwXDD1hmuBwX934SBN
         VW7a8pQlVAsKlz2ngOqV3wAzyERPYrkGaabJfayyWiWgLaaItTRenmIBu4reDJIB/POU
         1bdBf4rCL0Cz80he7T9aI1XC6DfompZphrWVxmXKTHojUU8ucbMuUxEjCj7+k9H/zD5g
         2isYx9Wp0K8BMypClWkogJxeEVyyU6YOT1g3+raB0CrgoCgeQUqruaOCmzRbFsTrfXXi
         K5UFWe1XFmVSernrYH1rjWts9MRWzlzLfPlkcyxzKPdUYoVMUjYnu++w/SbyZR6IO0eo
         tNlg==
X-Forwarded-Encrypted: i=1; AJvYcCVkysaM0nu3biKqFGCIswRGdX1NIdvOFWd3QZxI9F6k4y793CM8PeRV6nMBGS4r6mZwyExUep9QLmrevqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqbBmyv+8lWqPU52lW5Mbgt6iVJHYEpbdbugLo7Uqg8G4aTSNg
	CTf42M5+3xvxVQwucjIe8YiLI4B5xFbnLu70cOkbuvzrQG4akOoNuf4+o1luA48iZns=
X-Gm-Gg: ASbGncvstUR1BM0tIJB+51JKmUkJkSxyNbVJRsWyDNE3OeiDRDQITsGIRZTT8A5uwnV
	6YIf2qKhbmJljH44fNPQen3v09lHilwEHV73BNOGKIV7VqAr/D1npfUZr538Osst1iwTcPAH6oh
	KzuJ9Bl+9n+b7ZUDrg8JHEPbZIav35rfxDxqqpAXLjRs40bSIQpAl3JNYLXNZblKJIPsW6lkZfl
	aeA/cifQ7635sfjV6WvFYEovWq3igNKodMmCcn6WjFYUJWgr8bV8tL3sOS/Ft+HpZ1ajpOwHKDJ
	+S3QkYZ6P1KGg42x/IvCQZr2LbwByPC3yA5H/jhQzOXcgg4zMhGWwCuUR3HXxEaT35oInAfZKva
	2iHzZ1YKXB+yJnvCiZP13v9lLVTvtWz/YcMBUghyirEWxEj+qkhYDMhRkqhtxFAX1sme27KElrP
	f3HaREAvRaiw9AtLcy/Pa3Fx7jlJw=
X-Google-Smtp-Source: AGHT+IGxe4jpxUouMWLVsRenjuSxsjsZQUPcxK4QeyI1E3yc3B3LTUrsFOqkuU1/nPk4T3qkDUAkIA==
X-Received: by 2002:a05:6000:1863:b0:3df:c5e3:55f8 with SMTP id ffacd0b85a97d-429aefccbc6mr2723649f8f.54.1761758834656;
        Wed, 29 Oct 2025 10:27:14 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4771906714dsm46330015e9.13.2025.10.29.10.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 10:27:14 -0700 (PDT)
Date: Wed, 29 Oct 2025 20:27:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lee Jones <lee@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mfd: syscon: Don't auto create "no-auto-mmio" syscons
Message-ID: <5d94d26b71dc74c6891a2c2b22fcee879e3737b1.1761753288.git.dan.carpenter@linaro.org>
References: <cover.1761753288.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1761753288.git.dan.carpenter@linaro.org>

Most syscons are created automaticall and accessed via MMIO. However,
some syscons can only be accessed via a custom regmap because they are
only accessible via the secure partition or via SCMI etc.  We register
these custom syscons by calling the of_syscon_register_regmap()
function.

However, the problem is that syscons are generally used by looking up
the phandle and if the syscon does not exist it is automatically
created as an MMIO syscon.  This creates an ordering problem where we
need to register the syscon before any other driver looks up a
phandle.

The fix is to add a "no-auto-mmio" property to the device tree.  That
will prevent the syscon from being created as an MMIO syscon.  When
the driver looks up the phandle it will get -EPROBE_DEFER if the
syscon has not been registered yet.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/mfd/syscon.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index ae71a2710bed..063526f039d0 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -183,7 +183,7 @@ static struct regmap *device_node_get_regmap(struct device_node *np,
 		if (create_regmap)
 			syscon = of_syscon_register(np, check_res);
 		else
-			syscon = ERR_PTR(-EINVAL);
+			syscon = ERR_PTR(-EPROBE_DEFER);
 	}
 	mutex_unlock(&syscon_list_lock);
 
@@ -271,7 +271,13 @@ EXPORT_SYMBOL_GPL(device_node_to_regmap);
  */
 struct regmap *syscon_node_to_regmap(struct device_node *np)
 {
-	return device_node_get_regmap(np, of_device_is_compatible(np, "syscon"), true);
+	bool create = false;
+
+	if (of_device_is_compatible(np, "syscon") &&
+	    !of_get_property(np, "no-auto-mmio", NULL))
+		create = true;
+
+	return device_node_get_regmap(np, create, true);
 }
 EXPORT_SYMBOL_GPL(syscon_node_to_regmap);
 
-- 
2.51.0


