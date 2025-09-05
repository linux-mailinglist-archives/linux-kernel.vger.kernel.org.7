Return-Path: <linux-kernel+bounces-803866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA35B4668F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 00:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C09156216E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 22:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBB528000B;
	Fri,  5 Sep 2025 22:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Icf5Av4c"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648A622370D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 22:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757110933; cv=none; b=C4GKkzWI/Nj1Xw8brlWkWfII0Cha6rjxD6UPsyzVSaerufqbAzuLsQWkn848GwMnOvC6Pm97G0I01muOmyzsjMtOJdJKWB/VWpayWl2FsHqoSJA54Kp7Mao7w5Wcb2X5u0+egqcXaBri6jBirJFD6lXzpA5vx1K5fSywt1MN+Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757110933; c=relaxed/simple;
	bh=0bc6X9lasc3Dgouopm68uZKL9O0T820hdWUqYskkHBI=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZIj1yTLH3QtOjR/X8QsRJAvTEvvg5tv1EAnWXzQG2OsetmxrZvWes6ywItxHcAsjb1Rzc8MkKCNdV81GyhFqiZTcG8A+78TgHm2XOrw7B3cG+7oEFndE4AmP36d/egiKCRdXg5Bf4hCfeUvr3MuZbQwNGHtt+km1Pjz4OWrCaD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Icf5Av4c; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24cb39fbd90so24222365ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 15:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757110931; x=1757715731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SOkRZw86+PUG/uFynPEf2qCkjPKg3bHXnCqaNk5Joig=;
        b=Icf5Av4cfnlaZ/9eJfQfjpwZBh7clFjBvtlY6b4ZuFuuCXVhgJ94oyh46OSONmNkk3
         zZK/Sg3i14WLKw++WPJmpAe8jt5Peh1i41xEyAk8WrJFrCoUJQ5Hfk6yezswKHqD1TlI
         2x4X+njWfco2ebtuBzOTO7Zn9BvmCL9dY8fUuhGRrh62HqwsmOYzFSZooMGTIHCsBaPV
         rI6ywTlQvy01eeOomzW0omjqyQQhsfwq+u/yInj1h07IE7LFoQvXthjdSW4dcXn2Lxvs
         HGn3RQMLc8FANmUYP096+B627Xgsl5rkli61n4b41wRe5VP+dVrNQSL+gxFP0At3rfEA
         uePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757110931; x=1757715731;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SOkRZw86+PUG/uFynPEf2qCkjPKg3bHXnCqaNk5Joig=;
        b=tuNeiUT3U5us6qtEgEwHYDj568+ooKzQ7i3+EvoCbWR9p3WUmvk0F7JaR4cxbJjVrz
         RVDjnRF7lvUxnB/w49u/tnE8L+DfblWJO4ZSzb7ZRan2rqMi/Ilbf+k7mu9vsuBK7bzh
         6QLajdCdjTFmj2g0ewY5LnI7W6FDm9wf39zF3z6cnBPzw2p5CFSfLqpuKS1ROhDkdoqJ
         KH+A1uhmch/Hnp85k3ahJnMLasPj6Zj/MHneZDyekLtetdi/6MewqvXgPGMOGvpXIC7R
         DRMKpmib99htIGlE5IHeQAinLRkphEWYE2OsVc/18uPf6Aqg/DQjIHHk5ZFw6tni7CNu
         OVaA==
X-Forwarded-Encrypted: i=1; AJvYcCV4E1s5a1JF3ryQrqDcaLDebnvHaJPuZISnP6Vs1Th4ZssLEVed0LI+CsfaWR8JbCqaGN/RIo8DJ0+Ongc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAWAmOgwOyHK5e35oidoEWJznqclyWAm/Q5iWhjIs0TQ4XJ3ls
	hM+skV8pxGLaZHe1E3V4eLrnmJct2JDxcxBNWbajEN63hsA50cfXHiyW6Py38C47wTY=
X-Gm-Gg: ASbGncu4u97Q94zV7w7y7kLBhVD5EEmamOPbn6eGF7BEtU4vxI/A3fiW7iuJ+2EKpg6
	OAM884BKnzEPd+8swvZFIEH0pBcnNVb5DO+YanTcMK7ZfRkOPl1Mn0VaLDuDCMqF2DGraGGmHIa
	0MQztwQu4ORF8lOIRzW4W5+96/sr9L+r6p7F57EipEaS8tWCtJ0hhqYFRgV28e7J6fZ7ENyZelS
	1XiYSJ2DwUaCawejTLn1R8LeoQBKav6/4U4rH8sjwDa+HhkUY5QuQZ5Vb78RcgAuwmPyTss5p02
	QtT8ok4NCzvJu2tVtw8G4CYX3aIiLtz5OZ8v8138Zh0R/O+2KG0fgJJjHYeLYsmgSvHEYG2jg+W
	qxB2UOpruU7h9PlJRFlyXmaBVkTil59k=
X-Google-Smtp-Source: AGHT+IEymXQXFLBMg4vgdQqHVKloKPw02WcKpLxBw3Dc3FZxTNE5+JD0FsUK3rBu+92NffbaYsX8tQ==
X-Received: by 2002:a17:902:d2c7:b0:249:1440:59a6 with SMTP id d9443c01a7336-25170c44d22mr2423685ad.33.1757110930726;
        Fri, 05 Sep 2025 15:22:10 -0700 (PDT)
Received: from localhost ([71.212.208.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24a92f89809sm183819685ad.2.2025.09.05.15.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 15:22:10 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-omap@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250717142212.92333-2-krzysztof.kozlowski@linaro.org>
References: <20250717142212.92333-2-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ARM: dts: ti: omap4: Use generic "ethernet" as node
 name
Message-Id: <175711092981.666031.9611010303714828103.b4-ty@baylibre.com>
Date: Fri, 05 Sep 2025 15:22:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-d7477


On Thu, 17 Jul 2025 16:22:13 +0200, Krzysztof Kozlowski wrote:
> Common name for Ethernet controllers is "ethernet", not "eth", also
> recommended by Devicetree specification in "Generic Names
> Recommendation".  Verified lack of impact using dtx_diff.
> 
> 

Applied, thanks!

[1/1] ARM: dts: ti: omap4: Use generic "ethernet" as node name
      commit: 7c3e113ef09d474c4b076c42f1264c4fa78d1dc8

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>


