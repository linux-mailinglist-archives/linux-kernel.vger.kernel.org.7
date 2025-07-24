Return-Path: <linux-kernel+bounces-744029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D49C4B10715
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21A02189C511
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0562580CC;
	Thu, 24 Jul 2025 09:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="DIhshwtA"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6885257AF0
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753350949; cv=none; b=F1PKZ0bTlI23y51474rB8nEHolkM41HHnei6LpKULdjtGm9zvtyNN6L///6EAjlFErApnmRC15K2n/4qdGZjy3EeMOYJb81mJoHp9mAL64c437qt2pkOr15c7sktAmBGz7J9WcXcD8UJE7OjnZee6KnSO553RWSh8gGmhkCUkVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753350949; c=relaxed/simple;
	bh=T6z/JcKCr3nrlWauYV3AJcOoEaGVBeYh9OPAnzcSIV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kc8tZICpVxMeN7UkaXZKqE9qv1pEX4A89YlX1lxNlekCpJjiX6ic3ybrjAIflo3rdX0TsR/IcqDxq6Nhf2wHrmPKyzU6FBaSOORm2XBzxLznYTv+pmm/SDSwqDd1e4BUUJ5oPly1hwDniB6KG2sQGizB0i1DJLWzvEib5Qo+wYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=DIhshwtA; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45618ddd62fso8353225e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 02:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1753350946; x=1753955746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkXB2c1oP/E/k06GcTgcZXpElzLoIFNZDVG4i5HTvOM=;
        b=DIhshwtAZ55KMcQMYusrJpUWFhyxPh76H4UOO0xPXHCwnEYEFNIPC+lGNgxLtcINLR
         yEdbPFoPmW6AOR5vF6Vs8DXXIbdi/WkHVhB/DdN2UhwzJJk14V54OhaRdiwcfnaUUBjD
         BoK/qcH93Vw+GdK3E2ToxAaLZ2ZV8Rzs0aQZUqkJUmu1gdupJQ7Esu0rjw8bBgFv3DlZ
         Ms1OYTg8ll9/5lwGD66wRAJDl1HIzFzoPdr4Y/WNLYYhuuZ77VDtxmi2AJP+Oi/PuBz4
         vM0Yh5FnNHTDxwudx+IfQ+pypSIiIb7vPFQPdveCQptloCOzjjSvuPsarNOpZ8pnoEve
         B8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753350946; x=1753955746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hkXB2c1oP/E/k06GcTgcZXpElzLoIFNZDVG4i5HTvOM=;
        b=F+UPlioL0hVZNzdZTThgnj4J0eClQ7XGGXKTChUMpnJ7Gu+AWgjTCxEAJpdpJ+zL1V
         KEg5R9nfjijQgoUXGZxkU1NWbGy7pLGFdz3iKgxNrjsRHZ358yjxKB/0Bct3dnbRVCmm
         zrMJiWsG4cotmuoV2Li9BmxVtH1d75b296hoMCKUUBHli01lsCDU3QYQ+OEIdW8ZD+IB
         UImJJDii+en8GvYAlYYoV+MFRABdTgPmPoZ5qra2wVEOmgDZEnovu3OriZT0wbixkm4S
         ESlPWdmArm84yXBNRyrevb9sPyqVOpeScUXzOC1epqV3igSVfStfo6oLBGh3Ee275CHD
         lS/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWo84vdMjwecvwc3K+YF6b07iyOXLa3l7YSj1suAUsooQQXhpvJ7kdYKksKZaIU9CyoxfeFnW7NLvK4sB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNQFWdONX33Vs35SyYhSI/mYGXJ3DIABgyF+VCYveXJHUIA+0e
	cLsmwi8yLNQ8L08ClLZDHg/7DD50YoYfRuJ5S265Sw0g/gXJhjlitii9U1MONilyRQ8=
X-Gm-Gg: ASbGnctPigli2rV9EsadwxoCZRDWD0T+QpbgnJ777dVeGPXqVcWOAbcOttfTrsMVyuX
	+ErwQobHxIwi2xFM6vqyq844wp8Nhdo4+CJ0KYwvUhe8O1KmZD6z2viqjU/gs/o4pOTIsBfd1vo
	2ilmDeRSTaIyzJ6FlFOKhRcATBUseAuEqva4KcGbEiXx3tx88aoWGx7JEHf+VVZ3huuJmidOPQn
	c+SRZw5ZAzBwb4nm6faZma+Ka9VQaFBZmhg4ZaadG41F2cY2zpV+78+RF2u+F26Prrop4GRvOd+
	G+YuNfikHxklUXg8dYF/fVSGU4iRxwZmOcytYKmAQwcBCGD2WaoXOnG3163hl4IWofEmuRDPJA/
	vZTn6zflnwxhj/aDh90/o+jk=
X-Google-Smtp-Source: AGHT+IGRP/pIwNEZN/YSf647P0VBiKuokrllq5cryuGfggOfcoyMAvsAeQOTeSXR8LCaWYe+gmrK6w==
X-Received: by 2002:a05:600c:37c8:b0:456:cdf:1ecd with SMTP id 5b1f17b1804b1-45868d76755mr53246535e9.31.1753350945830;
        Thu, 24 Jul 2025 02:55:45 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:f44c:20db:7ada:b556])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4586f88cfe3sm10532965e9.0.2025.07.24.02.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 02:55:45 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Yao Zi <ziyao@disroot.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/5] rockchip: Add power controller support for RK3528
Date: Thu, 24 Jul 2025 11:55:43 +0200
Message-ID: <175335094187.68378.6716301267666015992.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250723085654.2273324-1-jonas@kwiboo.se>
References: <20250723085654.2273324-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 23 Jul 2025 08:56:42 +0000, Jonas Karlman wrote:
> The Rockchip RK3528 support multiple power domains, one PD_GPU that can
> fully be powered down, and other that can be idle requested.
> 
> Vendor kernel flag all power domains on RK3528 as always-on, this takes
> a different route and instead tries to describe all devices power-domain
> in the device tree, even for controllers with unsupported runtime status.
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: gpio: rockchip: Allow use of a power-domain
      https://git.kernel.org/brgl/linux/c/cc2f156a33278d9b23b5cf8f738c55c842d0f225

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

