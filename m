Return-Path: <linux-kernel+bounces-812137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 503F7B5337C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9255A06054
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD76322DCA;
	Thu, 11 Sep 2025 13:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="c8jmXGwL"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0111A322A3E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 13:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757596771; cv=none; b=F6hBW0XHlH6meUAR02f0rhWB416vKJ/J4fkCyvNX0TS68a7RFytmZBqMB96RH16PGHq45wDUaATU20jda0S4IIRx92+DlEAsCUzxJs+ucxFCzSPvrK37SMyezn+dkm2Pmy217uhBDLVhwO6AKDKmt6O+TYIWOI5bBKGbPJXF52I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757596771; c=relaxed/simple;
	bh=0bqSOryJEQ/X3+/vSnEr3yI4I9N6P79OuHfoWbsAg2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DAeqQeTPXNtGEX+R4VvfK+BO9ASVkzI0hoVzGJhYQq70GhNQLBYOlRjXFgRlw1tmBBCNeHxYRtg0F+mY/L1UPVtCwqxxv7zTPLWxl92tCe5jTxEqDxkSehubM0n1Ai/u+A+mInWDVqslcWjgEXknyV3pQ1scNCPp9NspRoHv8Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=c8jmXGwL; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3e07ffffb87so414674f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1757596768; x=1758201568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RoTjGjEf5o3PoFa4Kwu5lnAnxIVCW5Ws6ti5lef2kWA=;
        b=c8jmXGwL0xzs8zb1abu5BzxzKey4ymBXTIgFJY6lILtF7HJoSnsCppAwVXMQzT1Rgf
         q5h+RWO7Js5D5A00RsievlHEpipbAxWilWlz2EwZjwvlmNUzd4fTYgHfLZN1dirubq4T
         s29hz5+7yMIWoFkZ1ODYKMTvXdzzxP5xZTwMCFEjl2Axguux2v/t/Xaql41wm9e7blvh
         XyGIWXvWtmP1rHuc3eJ44TF7YT89LLPJy2l/BOiDdrcJBRtpsiDF5gQOLOgUNQ6q2lcT
         HPTz57/oWzzwG1sAhtm6ZV5mMYVg0Vyk1yFu199Gkkc51wnrc5ZDvwsUI5lAbLruS8wJ
         luow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757596768; x=1758201568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RoTjGjEf5o3PoFa4Kwu5lnAnxIVCW5Ws6ti5lef2kWA=;
        b=ul8T59ua2yauZX0M25hkvxPgqQIaFCPZ+Mm7srYoMjrd/xgQhIS0sTPHSdfG8q2xzc
         1Z/4jSSreuA6oZwZx3uU/gKX5/zlPITxt1EyBxZ3AVz//HRE95aZqBhvV5ItKvc4odIi
         2jRZzJOHG1RIWgOokZFcJHojhyu4jtV/mGRnBSTnTH3U6+3P8Netgt2M/znD1JhMQ0xc
         DKHcoZ7DXWrHK0wWWj8KD951VWKwecHA2gaWd7w/3p7G8Q3BnvOHFjoe6ZCxj9B/1gmR
         +cx8P+cCn4S1I5kEm+jrvVyLFahuWWG8/UHToth13k0PVWXouFASoAVZPEAJ7hKKkVKu
         PqGg==
X-Forwarded-Encrypted: i=1; AJvYcCUbq/Z4xUspTvPu1zfz7IVm/mXMSN/jB5GgYcEFbkzWeVCRczyz+3+CWonNhteskSGlusQBxbOPpwgA6Bc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5+1MzUKmxwX0uHhImRNlB9Rr0dP7FkupAz6g4bd9feN8C5+Qn
	HwcWuN4lGjb/Away27+k34IUVz8+guUdVfOqbu0Z/T+HO7O1yxIJzz9Yn0bjmfkKpj4=
X-Gm-Gg: ASbGncuQzqF6FnEBwwS8AU6dDdM2Utwy9nCSgp+uHlQ8JTK4xgpi4+eCb6W9PjlnIo6
	vHb+BOdVNhaVy9pn4O7Fmwo6tD1SareAcCiddeWyKRGAs9Muxedx2v2Zsg3gki4rQJ1qFLYWhw+
	1dAI/3ZFe5gnjBp+xG84xCrAAgsnQjU1C9uf+IoMvmzXH94cz22acwgqAnsT7mkyF04xjk2KJFm
	7C8n0K4XvyiKcV2jOtQJKWEN+Br29gGN/PfXP7S0HrDDPvla4SMkez8RJWjcKwHku4fa2XcO5tJ
	lAjSPJgxmnEt+SZFDji6urIlSmONYokmpTrnukOrNlCaS+ooEMRDgxdUFoxvM/2R6V6VrzjGoyn
	Bt2CDcTRa6E/iNCmJ51tRATk=
X-Google-Smtp-Source: AGHT+IH8nHuk3NSLqjFY2vj/PBH77XKaFOpHdcKlyadMrh/8ELLpleuBiAgM8Qj5GJ3//zqteimh3g==
X-Received: by 2002:a05:6000:2886:b0:3e2:e079:ab32 with SMTP id ffacd0b85a97d-3e642309dc7mr17268671f8f.7.1757596767963;
        Thu, 11 Sep 2025 06:19:27 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:3e84:ca5d:e1de:73b8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607870c4sm2483656f8f.22.2025.09.11.06.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 06:19:26 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	kernel@oss.qualcomm.com,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	Monish Chunara <quic_mchunara@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
	Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>,
	Sushrut Shree Trivedi <quic_sushruts@quicinc.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
	Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>,
	Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v4 00/14] arm64: dts: qcom: lemans-evk: Extend board support for additional peripherals
Date: Thu, 11 Sep 2025 15:19:25 +0200
Message-ID: <175759676089.37240.12221834042390731955.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250908-lemans-evk-bu-v4-0-5c319c696a7d@oss.qualcomm.com>
References: <20250908-lemans-evk-bu-v4-0-5c319c696a7d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 08 Sep 2025 13:49:50 +0530, Wasim Nazir wrote:
> This series extend support for additional peripherals on the Qualcomm
> Lemans EVK board to enhance overall hardware functionality.
> 
> It includes:
>   - New peripherals like:
>     - I2C based devices like GPIO I/O expander and EEPROM.
>     - GPI (Generic Peripheral Interface) DMA controllers and QUPv3 controllers
>       for peripheral communication.
>     - PCIe HW with required regulators and PHYs.
>     - Remoteproc subsystems for supported DSPs.
>     - Iris video codec.
>     - First USB controller in device mode.
>     - SD card support on SDHC v5.
>     - Qca8081 2.5G Ethernet PHY.
>   - Audio change [1] to support capture and playback on I2S.
> 
> [...]

Applied, thanks!

[05/14] dt-bindings: eeprom: at24: Add compatible for Giantec GT24C256C
        https://git.kernel.org/brgl/linux/c/c7ec58c39b0252e6635dde55e5c708132ab25cfc

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

