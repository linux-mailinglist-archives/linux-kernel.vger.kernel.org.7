Return-Path: <linux-kernel+bounces-885566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E88CAC3357D
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 00:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A4524EE213
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 23:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B23347BBE;
	Tue,  4 Nov 2025 23:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MfeTqO1D"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FB4346E79
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 23:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762297624; cv=none; b=tNPAPTjAZtBhIM/G6CKtMR3lLOlDf/IWkaLQ+860ulqzk9UBK4q6c/NFS/IcYtthWAgy6a0zgdeUnSD+DiCfcSjRRGHbfknfVr1j+Udk6bfOI1pk/a0awFplFvRoJnIvJqyRWKTxOnTlSH2jG01psQFIZunlsF8n3hyZSfuT6lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762297624; c=relaxed/simple;
	bh=yHkKXPbR33zJA3OGgfovSgAEgZn+oC9vSJyjIjciccM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uQ4fWwEp9w5rbyB6djszgQqv4G5KTfGu0mQWaFs+5qU5Ky13Fcv/IrXHepmo9Y5mXj/xf4KWvNUkf9oo1aVrS2JmQ5/lfgqbuJFUkUv0DCpSG7YNSMdkD2diS6/977fMUkQK+z41vlgkgFaN2tNZueB9o2ZEIWaY5crp+CYTvKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MfeTqO1D; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so298111b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 15:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762297621; x=1762902421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIQrxW79ZVgRUN8Wsqvx7zHmiYo35lAP7L+li0aZHjA=;
        b=MfeTqO1Dvc8gouY2B2MNvQcXsm2O8X03r/Lixk7jAziZuiOeFhg1SyTpjWVkEfhz2c
         ykr5/EWl1hFW0yrRt4PwJSX0mQM41w0zLhfHoSCSnTsyOdbTo1cWUwTVDhaPTjEKLh/z
         ePtdeekuC4Izp31jNFWLrTMOhjG45oNDA1nWzLqSH50VqtF2UvWck1mM8Ovd1eq9Vl+m
         Spg/mMZhTfOC0Hsjeluohu0OthqwbSBMu1AtrV9WlWt6DmZs+wXruxjfvw33I9DYuuyy
         dEX8kbwO+W7F386i6Yy5GaK5ir8IowSDJypN+Jmvih8uFABlGmi8V01o9QBNC8IidIOT
         J9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762297621; x=1762902421;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jIQrxW79ZVgRUN8Wsqvx7zHmiYo35lAP7L+li0aZHjA=;
        b=tAk5OYWqAvAJbdJhvIL2am6dKHID5tWlBAIRccYNm39MBIhzVUPMmWef6IZHWzswUZ
         cdZ61Xb8obGyR3gTh1XFtLVQ2GQu36FY3ugwVk2k7M0bpFED5xHB59/pBAZ1YJfFZUU5
         5Lqz/d3CxqgdLiwVpB3hpNjAhnjbr/0WVVeI8rbFppMUnzcnGOA/WzjwdJAtTOYgdqCb
         fxfFRiUnwAzn4i0vP17H9e2tbJO9g09LyUGCeffrnOQ3HFQePfLPG1nWToh4nk1gsQjY
         vTlb8LTFa6PiT7uRb7w1db6m9LDpYfUfmrcbx44s/YiSVs0xP/6YqNP5bax12nwBhQXl
         rAdw==
X-Forwarded-Encrypted: i=1; AJvYcCWSOIQwTgVaJDmeZxXIecKPedhbMnp8pOf8EAOmfdIZQjnxtHpc1JqHPB63XUqr0yYeOEpNJ0KIQpSuja8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0mGAhUPXvHQnTwt0rBcXvwtEr9mGNh00T+kquixpNgiK1BwyI
	B/00ZAOVLRO9BA7AQJvzkfD+hd7l60ccwwOG5aTrs+9dVjj6JUcdkuVBkBD/+jdRl/7syYvWuW7
	TQJ5/
X-Gm-Gg: ASbGnctCJU5tq8fU0yI4F53Csw31vNslCQ6sILyrjh7vTo2kVrZSrXBO8YztoOG0g9h
	/sLmbM8ARz/Qghu4D/M8Vmf5ucG4u3yB/ugK3dnd9YObAuvFlx32cpVjg/Q0HeV/4aF/E2wzGGH
	0/YCPvO3iScr1+H7cdrFeIq1VTmmOFRQeThNeGbjLijBlFsvwHnqH04wk+D1SGEXzbGiNJ9VC4w
	6874U0+UtKw/FOfmbcvcmGdSGCtdRWs6PDsjA5xK+0Oarmu106fmYLp3GgK/P+ZRY2DcILbYA7O
	R1lGRSpbfsn4I9UGTheZYvMeoYIrXy+EotDRMoB0oPP8oYmtPNqrctEM5MSbX8pwhR0GYH179My
	DESMuFQxzHbf+p3z3+yHUd8cL/phAdVII7XLyCfp5kEwhAei1J6s179LccOrjJIR/06h/G2RuoQ
	==
X-Google-Smtp-Source: AGHT+IGGdQvgI/Vf/KKbauI1cOuwqSxlp39uLs0QpL5udfp/2y8wBHW57wYN3h5DJcHi+fIfaHZvoA==
X-Received: by 2002:a05:6a00:9515:b0:7a9:7887:f0fa with SMTP id d2e1a72fcca58-7ae035df724mr1524948b3a.1.1762297621600;
        Tue, 04 Nov 2025 15:07:01 -0800 (PST)
Received: from localhost ([71.212.208.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd5d5797dsm4147472b3a.49.2025.11.04.15.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 15:07:01 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Barker <paul.barker@sancloud.com>, 
 Marc Murphy <marc.murphy@sancloud.com>, Tony Lindgren <tony@atomide.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Charan Pedumuru <charan.pedumuru@gmail.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
In-Reply-To: <20251024-ti-sdhci-omap-v5-0-df5f6f033a38@gmail.com>
References: <20251024-ti-sdhci-omap-v5-0-df5f6f033a38@gmail.com>
Subject: Re: [PATCH v5 0/3] dt-bindings: mmc: ti,omap2430-sdhci: Add json
 schema for the text binding
Message-Id: <176229762078.2840692.12323662945445152208.b4-ty@baylibre.com>
Date: Tue, 04 Nov 2025 15:07:00 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-56183


On Fri, 24 Oct 2025 07:57:07 +0000, Charan Pedumuru wrote:
> Create a YAML binding for ti,omap2430-sdhci and fix vmmc-supply
> property typo for a DTS file.
> 
> 

Applied, thanks!

[1/3] arm: dts: ti: omap: am335x-pepper: Fix vmmc-supply property typo
      commit: bb2ffb47d82229a4f54ca6a83784fa288914803b
[2/3] arm: dts: ti: omap: Drop unnecessary properties for SDHCI node
      commit: 9485ba8ab325c4b420ec92661f15ed14741bb9d1
[3/3] dt-bindings: mmc: ti,omap2430-sdhci: convert to DT schema
      commit: 333fa35fbd1f20b0d8a4af3b236fd9f52f3431b2

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>


