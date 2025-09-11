Return-Path: <linux-kernel+bounces-812603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F730B53A33
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DE095A15F9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0058362985;
	Thu, 11 Sep 2025 17:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCgDyLnk"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D50362081
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 17:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757610942; cv=none; b=lsNXc5R14myU8E9Tu+UwbyZUEJ8nnjpW5nMadqC3nmBHYhO+JSjmiEtCMS2B004kf+FQkUU4jCbC+25Djk/CRiFbqpONE01vq/AZsxiljOXfOhWXjRZtrmI0bFP612jPjGJ3fYMSxAYOqcLVsGnJLEYGUvQAa3cCR/nptocG0/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757610942; c=relaxed/simple;
	bh=MW96MT2H5e5odG8AsWjgHCe+BWBDJHJDIscXEc3BAJo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IsTZjGmhsEhdI2jkK5m7fvlA43rUxYjcPDynFkvVVzWisCF0hqeU6yhnsYkaKnf0tEPslFysPC/ILxK4E5e2RTBht1MFbGIQ7/8BrNqRZY/r4unUKI25sJDZshK7f6lkzeUagn6iIlmzfWLKxsRL6v2HbPj/RQj59HJsqE9wrMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCgDyLnk; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45decc9e83dso6002235e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 10:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757610939; x=1758215739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GlBu2NprIg2+aIhadTPHpgKffn2YpAgdyJg8kJsiv00=;
        b=RCgDyLnkxm9gXTQV/vazW9m9XgBISOx35hfWYIQZ/SoQvDaTdDtEVMaGzM4UTVfgO2
         XXydGuMlPGlt5qE6iYMeEcvazJfFxgUhPOOAjorDBxMSEIrrwyNAOqECGDd8e1NSosfE
         zNt061KCNbdE6OjcXKzP979fAw3HaySEyLx3mPzBkGD+cdV+M4+tUKaxTudeWWr95eCK
         q2RMBLGn3aiUt739yu1v32Z/pZcQ5pyWFPFqzrBcskz8Ni1tESaCIl4j/K6pBN6c2zCS
         eA90K8CuK0fgn75ERW0fHTR4Ha22z6iJDa5GusmY30U80RFsyeIrLLy15SwtjKtJrK4f
         mHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757610939; x=1758215739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GlBu2NprIg2+aIhadTPHpgKffn2YpAgdyJg8kJsiv00=;
        b=XA5KOLVNJK4FAaz3acONCXBLOMoIiMLI7Qzucq1+xmCgIEbp2HTwGvMRem48lzpQAj
         KARafEVLDJYhtzlwMYqDztElDPkfLUExckW9DRdgGm5DHWuJajllr7MiMx0YnWRBcSDb
         Y+lPK8PsP/LKZHJhuqSX3TJShqOzq2c5uCCcKK0nmF5m/Dsw1oYaOH0VhLN3/yL0LRPa
         gbbxhWWvzYcVDoU8Br95/fR/op/lZDt4eNMaR/orbGEbEpyeWhSOspk8/ShWPT0ETK4h
         shb8KC+vBDE+u1C7I3eO6ZEsx3kOdPmpx4XmrJVeumxbN5qWoW9ZmJmHb1K54akRxpU4
         l9xg==
X-Forwarded-Encrypted: i=1; AJvYcCVtU23o+wX0Oa4FVSQoaJz+9DULTHVPoVOzjOKmsWhk/5Vldv+NeKhctlgp3rTzTvLNAFXVtLjVC3HYF+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9QMGP4QbPPZFFAIm7x3DwjbUNv23rF16O2YAiK7N3hFIJ/NVy
	7WNpW+F60wo+yw1mqdtaQgx0vjfTkWS6y4KTQJtNLLnmuahUjH2oTTYz
X-Gm-Gg: ASbGncvRxuDfqw/FQjJ/6N/9wLAfnDhfmiF0yZd2RhXb3IEw55w1zqDoMEJ9dZbaFf2
	2D3n9Egx2Je196SOttuMaBSRaYIF+wV+NME9vlihvsqFwBEnnoc6KI/Y5Bkvos8GFQ7RF0vBLZc
	WDb8aHW2RAa58J5tSFCkRhjsJV7zYugioYCImXqjYUpW4o/IGIqiUlmNv4M3JBgaIIGNo0AC8QJ
	8UwUmpWr+6dFIPGnh/hGyYmrJvJNoyMD6iNLYVuJcHub46wLebTyJZ2WWOcqVc40uHWWySDLTeZ
	G99eJZ+PpsOzngO2wpJ5DpMoPsAEczof9HJpNl58Gy0B8c4ssd/OPEHSWb1WhwmeeGGJ3NB0s82
	pxCXarq/7nlvoxyCjlQqM2lyteYPpdcuzy5ev21mtQnGk0mV/A0/d29OhZMd6WxE120hf5b99hX
	0dc26r3v2wSgYKtq/Rp2Im/m4d
X-Google-Smtp-Source: AGHT+IFyNITYXanMUiTOVy2Osl5V4I64mGYalEHfEOcAOQH9B7h6enLV0/I+HA9A714OXMrpa16Evg==
X-Received: by 2002:a7b:c4d0:0:b0:45c:b601:660a with SMTP id 5b1f17b1804b1-45f211f2fb3mr1627565e9.23.1757610938657;
        Thu, 11 Sep 2025 10:15:38 -0700 (PDT)
Received: from localhost (p200300e41f1c4d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:4d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45e037c3ce5sm30198205e9.16.2025.09.11.10.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 10:15:37 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Peter De Schrijver <pdeschrijver@nvidia.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-clk@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: Re: [PATCH] clk: tegra: Remove redundant semicolons
Date: Thu, 11 Sep 2025 19:15:32 +0200
Message-ID: <175761090509.3229177.9207716245913935287.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250813094003.552308-1-liaoyuanhong@vivo.com>
References: <20250813094003.552308-1-liaoyuanhong@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>


On Wed, 13 Aug 2025 17:40:03 +0800, Liao Yuanhong wrote:
> Remove unnecessary semicolons.
> 
> 

Applied, thanks!

[1/1] clk: tegra: Remove redundant semicolons
      commit: 8ec061e72f15da80df10d4cf29777556992074e1

Best regards,
-- 
Thierry Reding <treding@nvidia.com>

