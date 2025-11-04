Return-Path: <linux-kernel+bounces-885567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF64BC33571
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 00:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 145AB18C0FBC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 23:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7314C347FCE;
	Tue,  4 Nov 2025 23:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="L+gDBIOj"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE67346FBC
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 23:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762297624; cv=none; b=MHSXLi/QT9sd66cKEqLcs2rJp/xYsLBL+0Yu3aQs7VWmVF/Cd9EuZ++dPm9u847AgdBTvulIKkNvmhKIxSMnD0KxR/jRPn/ON3SN6tKCXfUro5N911o3B2EFDGEKy5nOtqXLGHoLtATRhKfjHPG66Asl45SsyXQtefMnt7yakcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762297624; c=relaxed/simple;
	bh=zm4ajFWLAvXc6tDsBMzDloo5DMNFuXxBUvESaJIps2U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=a9MONCY2LqprbEV+UaTPmqMO87AYXc/cncKJ+0JD8Qka2EKiyd4Qq5G80L7/gG4dl+g/YHzsElePcOCq1hhRl38KFS0R/NCKNsMMkMp6ydm9/JLHm0vOv8dX4Z1FHzC1Xb6a4GshTmNaNP3bOMjZcsoRsNNORXWpt0NGqhkxXyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=L+gDBIOj; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b62e7221351so5783120a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 15:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762297622; x=1762902422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7z8AC+yiHAIwmarbixp3f4qrcLuRr1Vhyqm82NW6W2M=;
        b=L+gDBIOj6gWlLMXiLUzY/HYxfn8Ooea1+n0ZDytiGZUVEjMNY+JqQ/QTlUoSVMXnUx
         lWYEgO2v1DMn0mM+EbLS0666ooZMUDnYZrOUGi4xL2IvnPrb/PppBZCtd49KEs51KJae
         fhwecyXAPgC7OVAuferGUO2KmpMBOeZd+z8siYGQTdT8o4Gji276cQkzSwHPW/ONvq4x
         RMd1i1y6+JbnoVoNyqQ6K/KXW+Kb0oTiMgHFi2Jpf70ZJ+U0W1ggrKQ7vpE8wD1/NR+S
         CUlW+7zyDNhu/HohaX91UCcFcy/EbBrX0v7RboRistX5rVGWBCRkajNc+MkrMXHrNsV+
         cJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762297622; x=1762902422;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7z8AC+yiHAIwmarbixp3f4qrcLuRr1Vhyqm82NW6W2M=;
        b=vR8m0M2WoodwHH4wR0a7JxSjyk+tblyTO+bMnl843MWBGDN8NsKT+UtqJutd4LsW8x
         RN/gryCa0f2oo+VeWcP81DbqxWxU4ZYmeojlAhwTCXQxuYVQnrlss6cbz766Jg6eiZBS
         0kNgVcKn0oEo5m5BkYHfKWhKDjHmGq0HGNSLDW8gVmfQ0oNtbBi7ruR8MRxQf4yJaLmU
         3Z5MtO2SCRezkXnfIlRpXH6WRFEGqpwRnTw5Wy9oATRuF4MX2s6A0eaDcDuLZcLWxqSd
         u9Awwo/RaAuQNHjcsbjzM7IpnCtqUraIA/BQm6oxWmwPi8Fi3RcDFewX8V35kk1uaR4H
         9pFA==
X-Forwarded-Encrypted: i=1; AJvYcCVxRrE0VpS6lnyXeI7uu86N6wZNATe3ddUXd2DMVVViHZ5ZijDbtHbWXVV0K0GJmD41R/0GSyHErB0gMpk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7fF0upe25AxpbGETZdQg6AMY541hlXG2WLvh/GbiecQGXBzrn
	3tseeUEXiltDK/H9f4OKE6nKSpc/tGmkci0kqiYENOUWznPLpepJSnz4rdbqlMYm2qE=
X-Gm-Gg: ASbGnctv3EkZKMuchhEWDwW9ChQn+ROXUoL53HCJgWwEYUjn3e49iT96FmpHfNAQmwS
	gRT88vjTQlxsMD5f4yrCnAaUddAMaApxspiTNEH4niz5/sDVFDnfqT6kincZGmiOhQgT+KEayxv
	f6dYWyuRXo8rGPiEdmnyP6axK3obAn31xqgf3/yaXMBZ/xbV5XieX4psDerACwgC7MIdR6vnkCi
	idRxuBEHUTRnXLDf4GVpCxjTo9SAgHDi73wsNVzQRAUOu3uDnwlJ5v3ySVkWlRKKWuDW3oF8Txi
	CvIBiq/dDjF0naE8kCrC6zNbUXQPEmYnKKOphja/9c9qQpt8MnOSK+CfhjRI9/IYvc5zeA8/5gc
	KFkrxWHBBy017+/Th8+edhYL3dWxAJv68UcuI+wEohphfmgcpJa95LvyRKfDiK5uj0AjjajFX5Q
	==
X-Google-Smtp-Source: AGHT+IEmNKJYP343ceTj40sn2ysBbxZxF2rHm3xoHDdRm81PPZZipomUwb5FT4ZE7dqDQV5SPUTNhQ==
X-Received: by 2002:a05:6a21:32a2:b0:2ff:3752:8375 with SMTP id adf61e73a8af0-34f85f23b25mr1132220637.45.1762297622638;
        Tue, 04 Nov 2025 15:07:02 -0800 (PST)
Received: from localhost ([71.212.208.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd633bf6bsm4132570b3a.56.2025.11.04.15.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 15:07:02 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: nm@ti.com, vigneshr@ti.com, aaro.koskinen@iki.fi, andreas@kemnade.info, 
 rogerq@kernel.org, tony@atomide.com, Parvathi Pudi <parvathi@couthit.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, danishanwar@ti.com, pratheesh@ti.com, 
 j-rameshbabu@ti.com, praneeth@ti.com, srk@ti.com, rogerq@ti.com, 
 krishna@couthit.com, mohan@couthit.com, pmohan@couthit.com, 
 basharath@couthit.com
In-Reply-To: <20251103125451.1679404-1-parvathi@couthit.com>
References: <20251103125451.1679404-1-parvathi@couthit.com>
Subject: Re: [RESEND PATCH] ARM: multi_v7_defconfig: Enable TI PRU Ethernet
 driver
Message-Id: <176229762178.2840692.4781785513910576373.b4-ty@baylibre.com>
Date: Tue, 04 Nov 2025 15:07:01 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-56183


On Mon, 03 Nov 2025 18:24:51 +0530, Parvathi Pudi wrote:
> The Programmable Real-time Unit and Industrial Communication Subsystem
> Megabit (ICSSM) is a microcontroller subsystem in TI SoCs such as
> AM57x, AM437x, and AM335x. It provides real-time processing
> capabilities for industrial communication and custom peripheral interfaces.
> 
> Currently, EVMs based on AM57x, AM437x, and AM335x use the ICSSM driver
> for PRU-based Ethernet functionality.
> 
> [...]

Applied, thanks!

[1/1] ARM: multi_v7_defconfig: Enable TI PRU Ethernet driver
      commit: 7d9ebbffc545033897aeb30f2a0a45ead1668bf1

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>


