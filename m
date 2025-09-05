Return-Path: <linux-kernel+bounces-803871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4625DB466A1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 00:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A5287BAA87
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 22:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8372BDC35;
	Fri,  5 Sep 2025 22:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VverU1BD"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEFC295DB8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 22:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757110940; cv=none; b=eZtOQROtXPHltcPujDn8kuM0j4V+B8BoKtUtgGyawspcdlO3e52TXGhHnAA3pjMMtdUyT4oyjYemscrsLH0gwTA8JBrqpJwwY5KY7evXPQT5hqWR7HqwGs9hCBgp0Nez9FkHeq8jPpgcVXkBW1Jv3mPPmNW2Sh/XdDbACq3Cmm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757110940; c=relaxed/simple;
	bh=4usknWEddfoi3Fas3Wgvr8wktFDBvKA4BChkoL+6ZII=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AjOKwgsgxI6ytFtS4zuWqPwUdVe9Y7fDK54/n7GntS1grFNYD0iPx7egOCK97hr/Wh06KMK2JS6ZgeVJ2ewNO04U+eZacQcrzKaj+b+MX2nw4ZA0WkRKgmswBj+yerSgq44ybwKbCb2oD7NYQeuz+51WFchSPGX/+BUxkgeB1K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VverU1BD; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-329b760080fso2571079a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 15:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757110938; x=1757715738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajXrw2kXWcvaLXXTxcLJ0XN71Q9IM46eyqVaC58AnZw=;
        b=VverU1BDJnvUX8bN3NHzQpdocZt2adzhSN+Nvj1kEQXpwEUoHb4s2Hk+f7B5dHQqS5
         XoPbhSV21MPrHBEdHIM/V5iesW00YhsTgyw9MieXwtusEfh1olRTdulr5Hp4w73sXBcG
         GF1AhUNx5hqhohVjD7cby+al96I1HI6Vhfnu9q7rSg9r7KOSGPl+G73lb1WGO9sTER14
         c6TGeuRbmmnohho1kEj9+WQAzqgJWn4Ni9UUGOAVPRPzTkWGEEI558IErMThyfbMAOXe
         HH3uxcSDX/L+nwx+q8O1WK1R+WC822ophD21v5O72qmlihLfPN9K3x4sqqL8i0XpKNIi
         IuUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757110938; x=1757715738;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ajXrw2kXWcvaLXXTxcLJ0XN71Q9IM46eyqVaC58AnZw=;
        b=KbSzzk31VNs77zMpHVYZH8E1GL+m37Up/fY+9iF2vRxDjHYkpKommeoJlNHLsz1siK
         6b0reExnbrcWVqKUQGrNc8Wg/NwgAytRPG82SCQ8spz8PAgvvsUvhxamULfTwmfNBMSi
         H9KoyyK5GwgPyJh4hBRX/xK5YKcSkySWHYtZex/BgXRwrRP72SX/eKx/o9hxcdPu0c/a
         FCGZ1GoudroMprcWLUEBSEI1iYQg4BKw6xHKO/ygy/eryxpdD4tPiQpjip0zS/VM+LLb
         Ey8a/1sMJn6PkYXy9Qplc6BL4MLOfjkvMDw/dEN6FBdRjHs7jzeHr9f8/yWSFuoEAEfP
         Oiig==
X-Forwarded-Encrypted: i=1; AJvYcCVJ74V7Ixe2Ebb8C/vI87sFESEpt5cyA08P3hpnrewiVJHYPbSeF/7L0GfxGQhSr6X7LYG3MzShrotVry4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeaPTuPFzAR3Bk2oxIgybsW4lA9oi0ivWgiBXvXWjqYczAA9Jk
	mt1vNNrmZkOknGBE//YXAKR+zbdKXb1BQxQrQFzxO0f/Q8QH+KS6Ic1/Zf/gEoT/IbjtDqT4UAN
	XRTFV
X-Gm-Gg: ASbGncuAj/7HF/fAa2VH7OKwxhFcJTdT0/EBL1e411Xm3AULnaYWW0/twp/QkpmpD5g
	MK0yTyj8biTTYBwvAv+rPmBVPiWDflDo5NMNJk9tCgBOJ74gNDkxUHJBNXrrz3OlbCgEcOuj0HH
	DJfrF0aAgH6x2PkQY34PJ1mf540/rbopcLqokxwRL/4vY0HELbu45bx0hRFKlLzaa9aDw6j44JU
	3ahAbAiSN42KpdJOy4DAV8iGX/FYZHz60UZe6iKF1Wyxy0pXwAvL61baLykkImac1iGBnba5Xma
	ERy4+PhEMsPbhm3r/AJr9byc1tMxSv7olS5n8FDTepML2k4J/BzEx3QSAdva7PfjXfsd1zApiXn
	b4vPMhq7IrcQ7yjScWeM0
X-Google-Smtp-Source: AGHT+IEvDKPFc4gicRV4XwsSMT0l8afEt7vdoanp91e0aTRQHmWzkYtjOcm3TMm9WB4qrIiHEdmjxA==
X-Received: by 2002:a17:90b:3f8f:b0:32b:9d3c:13b3 with SMTP id 98e67ed59e1d1-32d43f60f43mr501790a91.18.1757110938006;
        Fri, 05 Sep 2025 15:22:18 -0700 (PDT)
Received: from localhost ([71.212.208.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2af911sm22510696b3a.23.2025.09.05.15.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 15:22:17 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: tony@atomide.com, robh@kernel.org, 
 Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: uri.mashiach@compulab.co.il, krzk+dt@kernel.org, conor+dt@kernel.org, 
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, shuah@kernel.org
In-Reply-To: <20250830215957.285694-1-jihed.chaibi.dev@gmail.com>
References: <20250830215957.285694-1-jihed.chaibi.dev@gmail.com>
Subject: Re: [PATCH] ARM: dts: omap: am335x-cm-t335: Remove unused mcasp
 num-serializer property
Message-Id: <175711093712.666031.7805837780140276251.b4-ty@baylibre.com>
Date: Fri, 05 Sep 2025 15:22:17 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-d7477


On Sat, 30 Aug 2025 23:59:57 +0200, Jihed Chaibi wrote:
> The dtbs_check validation for am335x-cm-t335.dtb flags an error
> for an unevaluated 'num-serializer' property in the mcasp0 node.
> 
> This property is obsolete; it is not defined in the davinci-mcasp-audio
> schema and is not used by the corresponding (or any) driver.
> 
> Remove this unused property to fix the schema validation warning.
> 
> [...]

Applied, thanks!

[1/1] ARM: dts: omap: am335x-cm-t335: Remove unused mcasp num-serializer property
      commit: 27322753c8b913fba05250e7b5abb1da31e6ed23

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>


