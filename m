Return-Path: <linux-kernel+bounces-803870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93066B4669E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 00:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F5C21CC1CCD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 22:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C23D29B8C6;
	Fri,  5 Sep 2025 22:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="v7ddbdkv"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EB828C871
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 22:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757110939; cv=none; b=i/1lCTSYBW8oOZtTwGXeI8wc1xY2QLp1T8CwT6sKoRAizX/TakUSOQ4kvs3GOxdzTKi71XyxMeolgUh2BRatGJ9zfMQcgc9pI7PrPhw629K3rGj95VJuL5aMgmVH6D+iT3r0P1427k2bZwlhcHdb43aldi1+UZ5oitpB83KZegQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757110939; c=relaxed/simple;
	bh=UafuaGrAhNBYEwWxu5zY9t7ThR2R224yKWDpl0S0AY0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cWcxCLV50vEtifsSDHVG4r4D5OMRJSxJPk6TRX6t1/CKA/agYZTY0YH2avguoE81Ej5ku3t4s7NaxurcXFsrBh4TgGXqM3vUMV7sk0zVcbe/aYd//L5Md3A5WmtgrcRgkIN12M3GQZucT/giqFagGEeRVDuiBfY/d0BR3RbbZNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=v7ddbdkv; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77238a3101fso1904363b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 15:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757110937; x=1757715737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXGZ7pRNDayxxoqb1j5l/r0hwWgUTmCUu/koa8CrTTs=;
        b=v7ddbdkvm8IdCaG2ECMkqYPaOL/TwEtaQJ/dTX6lnDinPf8CcNUbTm3rECWeoYeX+J
         i+Px0TVk5n4yXAXrTSoacAmOxnO44yM2uyMyZHyBFMnEqww2jInHLtwA3/69OccEo2Ia
         QUubtYLrygHBOx4/3nEytD0aOsoOGJe2qIM4cvAPRVzXf0GNMaIC8/tBipWxtUYujVBc
         MGk7Dhbi9k2Ogqdzf5Q6PArYp7oEVdWnOm9l/z+eqKwwltkCnrBPe0XZLo5vjTkj36y3
         yJ/nGJOTEB8Sj5OPfgKL07MjwonLWQqVrbXNLSXxG6ABwD4EuXj9Mnf7VHJlHkrRp9Vn
         inFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757110937; x=1757715737;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXGZ7pRNDayxxoqb1j5l/r0hwWgUTmCUu/koa8CrTTs=;
        b=NzfVo/XwlVSF6Xq24TBgd47kOBLryc9vvE9XtMwMvSoPDCyv9OjAXsYvl/IPOy6q8D
         WLBDmKq4R9ZvUUwiQWwdC3lciKmzG8Dckc/6l1HDCrkLniJMP9f3m6RdnnG4BOQ/VtOO
         rJ9IqM9MIKcyQj/7AX3epS2hyc0WKl5yN5N2uJVAygo53fGxw/B/qs+byC8/Aj1qZ8e0
         EEmPwWH5ByRBlvCDc43oRbclSIV073oKNDnNf/qmBT7ce4l4QxMTTkSu95Rbd4gwa6Q0
         NYUC9Xccp9yk8nuTcM/3qpKG1zO1/Y/UaC5f/d+ET6VIVXut2dVheKO0Aceo+9VrSZ5u
         IhTA==
X-Forwarded-Encrypted: i=1; AJvYcCWoliqyb4zbGmvHhzdJg8lKkSl7kiS5MLVhcTPaL8mpRBUPlNuGkeZ9MMDyc46wOlAK8hWDqKsCK+89K3A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2K7OwuVcFDCMQ6Bqc0nQ/vv4T3IEOif4h4MhCZlIDX1y+HxW+
	vAbIrr2CZpDtaaIyvE0+2wcOz0yehxI6Zob7LAOp9/YWogTaiS2SEbXzkeEAWPnl/JQ=
X-Gm-Gg: ASbGncuxswG2dmS3DDADrju1Z9A/H+g4a+BoEskCCsIc87dJtLfLVLfk1pdcRZvfZRa
	cQC2KIkJoqiJznKYHfsfDDkf/ZGmAFzoCgfq2duvmgBMq5Q7bag+PqcXTNUKJdsRK8oV5NvKlXv
	9fbF7/0VLasaHc1CcY7yDUUJZcLm71ntnX7BP6XVJlWNqpq+m2oNh1iFqyN9m3CuNATQ6ltWOsY
	uM03toR0BXVc1tsHUrs5RfXiCjT8mYpY47PvflOzkcMXlZfZ51TSwovM5YOMgwoZVifDlLiOzEi
	dRocrViOVfy/f9xhUdx2PFboFQoSEWpPLOVnOdL7IingQoaM2VxW6nJKfPbYq9lesCxQo1psBKF
	oYszEcmuUXLsYbnz4QdVL
X-Google-Smtp-Source: AGHT+IGjknjH+FHD6rSrXSEZYpl+gZ+/zeKgcNJWJoULCQXwNQ0Z+EpholtI0q8+4gB9kMf0VxCkKQ==
X-Received: by 2002:a05:6a20:939e:b0:251:5160:f6c4 with SMTP id adf61e73a8af0-25345e324ebmr515972637.50.1757110936974;
        Fri, 05 Sep 2025 15:22:16 -0700 (PDT)
Received: from localhost ([71.212.208.158])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4f8a0a3948sm12694052a12.27.2025.09.05.15.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 15:22:16 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: tony@atomide.com, Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org, 
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, shuah@kernel.org
In-Reply-To: <20250822225052.136919-1-jihed.chaibi.dev@gmail.com>
References: <20250822225052.136919-1-jihed.chaibi.dev@gmail.com>
Subject: Re: [PATCH] ARM: dts: ti: omap: omap3-devkit8000-lcd: Fix
 ti,keep-vref-on property to use correct boolean syntax in DTS
Message-Id: <175711093617.666031.9922081579342524783.b4-ty@baylibre.com>
Date: Fri, 05 Sep 2025 15:22:16 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-d7477


On Sat, 23 Aug 2025 00:50:52 +0200, Jihed Chaibi wrote:
> The ti,keep-vref-on property, defined as a boolean flag in the Device
> Tree schema, was incorrectly assigned a value (<1>) in the DTS file,
> causing a validation error: "size (4) error for type flag". Remove
> the value to match the schema and ensure compatibility with the driver
> using device_property_read_bool(). This fixes the dtbs_check error.
> 
> 
> [...]

Applied, thanks!

[1/1] ARM: dts: ti: omap: omap3-devkit8000-lcd: Fix ti,keep-vref-on property to use correct boolean syntax in DTS
      commit: 5af5b85505bc859adb338fe5d6e4842e72cdf932

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>


