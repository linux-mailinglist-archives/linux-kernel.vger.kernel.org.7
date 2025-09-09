Return-Path: <linux-kernel+bounces-807709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CB0B4A849
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BA143B45DD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30DD2C031E;
	Tue,  9 Sep 2025 09:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="smTtIC1H"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6AC2C0303
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 09:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757410621; cv=none; b=BqzerXVzm99076Qq6HZMWCO76BZ3q8uM2xrh88BGnmmv8CQwkYt+pdrq7NvWSL88cff1xVayP3XXeuTobS/0NmdCvXwMrvTgttc6t1T0L41mhdVpNdrlM8ftuE1kk7yi02HJMv4mS8/uPGlBHblGjgOAjYs4G/fmothp2TB/UCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757410621; c=relaxed/simple;
	bh=Yz6J5XsFeNL8NmPGr7AxBWmV+j5pQO7m4OHjHN7HDcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ecJBtJHQ4pDa4UHU92+MJWay074ySfTboiM10DzeAkAtPX6qH/KcIS95L2zbOO9oq2d/x4KcCSFTDYcpJFe6XybHhMdVkBCsZfSrYo/Rf+egDBdAhqpH7oLv6ctAwJ7E1Vr3sJC406kdCXFQeE+h4Vlawdyh3vElzGNL5mAeABQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=smTtIC1H; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3e34dbc38easo2270935f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 02:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1757410618; x=1758015418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZ0scMPLV0oolu3xB65Tra/ziHHTvdwf4gejra+JrpU=;
        b=smTtIC1HdFp4zm7dfNIV8xjkC56KN/e2EsJ/Fqp3zM5Ypn3akxDY6LdwSua08XdtMf
         emQw7AqkqiRgXQcfy5sH4mLNRztbuydR8FZ4FSewpC1SUWricM5WsaH6U86sgPwPR/H+
         WwP91f0RtOPCT97pddA1GawQn0SFfik0EvWAtijfttYA40XIvz4RUTWd1df2JP1h+1WF
         9aKgINXMknvfBdEgWBHtFz1DBSHV4llOOZiiN3nW5Q6PaIQEH7JmRxMK78cGI0hq0RTL
         83ynPtgbVxAj16sdGYTeSx0skWqrhEoNDPYLChmjJM66lm0X6L3uPj5AslqHBiMubXEA
         CzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757410618; x=1758015418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZ0scMPLV0oolu3xB65Tra/ziHHTvdwf4gejra+JrpU=;
        b=ah1KUpv5Hj7yeS3LMHgSc/6MkHtl/BRKmBe+g4UUqa6+UCmVf/nO9G3Y88bxThrAZ/
         TXiHp7bGnXmbfKXCA0SGRLuWEHyQKEq8+5FoBLmhq1oyhge3q8qW6hhSh3zMiUVNxvYp
         EHS4s1Lg2l+MiUXkWM7wYWZZTcao4cSRgrfWv8uMhe0kxvz2IMJX0lJtidrT67y+GOdo
         cqIpyLdnJ1Nd+VsMhifaTwDecumLO9cFUCfcMd4R+7pKukRJxF2t0Dy2pidLP9qeIZsn
         fcWuL175IkOwJ4VHrvrrte+rEEbt081U47xh0kSOQsvcbspBL/gW1dMgMww0UVr813O3
         rHow==
X-Forwarded-Encrypted: i=1; AJvYcCX7q97BlqPZhD/x8ozWwLBGjn7ox6GAdjWH1Wx6xwZ3AVi6VL/XCJvlhuNHrBIvBTBtHJ8a/Ocg7JlSXZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhM3M+fpQJRv1vjs73Au/KfFcktYtKu5LVKJztsOXJ7eqkbKiG
	U45eS6qK6BGcyLYqjO8+cEM8ZuA7B5dIxwr7/gRIBy+LnvG8B/Qfk417ZG4zqw69YYI=
X-Gm-Gg: ASbGncsxHq4KuY3ZImMA9bdc1IXFUZMbyAfYtbTqtirc687E+s2W6IZbpxBE+ESzFhc
	PrHEiSaAW9Bo53X00cojZ+5VQb9o3wKDrcVu3Alg1VYiY2i70W+zraQwH2gZ0FsTofDVaV8pQfD
	sQhqE7YqZjIKWfxoXxyeigyOcF2Lt+ZoIl/prWu0+eBZ5aSJ4cQm/c0sh+9B0W0mThlFvVE/FCI
	cq7/ngdpTCYyLYkMR8Y9VtzFkyqTpW+uXqZP0j4wEW8tu6OFzqZYVOJYJAJLfRO0ETZCLBrdGTf
	K4SMsDIxvq4huc9I4gGRJdBkoVe0+bszQKQbEtMEIZhIYg0/CaCTyM94cMzT0VpfZXVB41hZIFP
	ZQE0ofgIv+NLzncASEbi9t73lrNOHZvVSwyQ=
X-Google-Smtp-Source: AGHT+IH5058N4Rvd5SjRTCT0K0xTeKjsfyIV1AW6yxL/MErMs8EFAtZAWt/Eh3NEKIOxQKJuvUljOw==
X-Received: by 2002:a05:6000:2f87:b0:3d9:2fa8:1009 with SMTP id ffacd0b85a97d-3e64c3acf34mr8542734f8f.45.1757410618327;
        Tue, 09 Sep 2025 02:36:58 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:c1ee:7be9:3ebb:6cc0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df1ba282dsm5478035e9.5.2025.09.09.02.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 02:36:57 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: zhuyinbo@loongson.cn,
	linus.walleij@linaro.org,
	brgl@bgdev.pl,
	Chen Ni <nichen@iscas.ac.cn>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: loongson-64bit: Remove unneeded semicolon
Date: Tue,  9 Sep 2025 11:36:55 +0200
Message-ID: <175741060875.70455.7070575500700308990.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250909065913.4011133-1-nichen@iscas.ac.cn>
References: <20250909065913.4011133-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 09 Sep 2025 14:59:13 +0800, Chen Ni wrote:
> Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
> semantic patch at scripts/coccinelle/misc/semicolon.cocci.
> 
> 

Applied, thanks!

[1/1] gpio: loongson-64bit: Remove unneeded semicolon
      https://git.kernel.org/brgl/linux/c/52bdd69671b63d5bdac80ed7fdfbad44e915710b

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

