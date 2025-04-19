Return-Path: <linux-kernel+bounces-611447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E55FA94204
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Apr 2025 08:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C053189E593
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Apr 2025 06:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1014786338;
	Sat, 19 Apr 2025 06:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CjYh+aDd"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D4214AD2D
	for <linux-kernel@vger.kernel.org>; Sat, 19 Apr 2025 06:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745045705; cv=none; b=oahYRd/uk+F7NOkZt9cEiiVvu0lZ50WXIByO7+33zDEJILv21faDoZrQqFCBsRouwlOCv3MUyUiDglTNXVmxXEl+ZJvNp0m/srAb3Wq4ZIkWj84utEYKWH9aBkKKAetpo10a1tu5eE1QCtrnCLThkMdd6DbQcGuJUE2ete8EHwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745045705; c=relaxed/simple;
	bh=7V8yw5J+1i1mhYMW7TfQ/SiJZ+3ro2qr9nOVTet9OK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZNWm9y4UOiPkhrhb5IQwNhRW28F3MuMPd7XY73c7Mr52WXmUvsUhhzgkqpb2RCJ8EewXsVBzz0leBCkrAcgvJkp/xK+bn05eJwekTUK4XarZAZ6j7AzdCG+8FxCbuPQ4ZxmPUgBRkVGu8z+Agh4o4gfLVZOsVYr7w7LnPq8/Ebg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CjYh+aDd; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3035858c687so1877192a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Apr 2025 23:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745045703; x=1745650503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TICD64AIOfQs/ZYDCIR8qIZ9IkU5scdShX781+egCtQ=;
        b=CjYh+aDdsGaFzFCww/y1+WE/ILdbPlvJIS4u2LADV5HY5o+/yePU7RAFGHDe13afQh
         tVOYTE7fVZPkhuP/tpJ3JPAfDNOyfqw0XvvcoVx9bNx4pFTJM7b6m+5SJN/G75NXLf+r
         qOazSH9n1UMrg4brq7ugh/BCbI5SuFpPw58N2tXt6a+Sd9nxM1/fq9s+3S57X9CO7TqJ
         ovu0DcEMQXqsOjur2i8yilgdfk+3N/TTxA1jt1/Mwr5pUmSanLFOGNBOSPLdq72LXcS9
         SdZPlr1kLCq47CpzYPJXg2uV4TGsotzdVStTxMlbGVY4FdggR+C/feORJ207YYUCCy/t
         lQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745045703; x=1745650503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TICD64AIOfQs/ZYDCIR8qIZ9IkU5scdShX781+egCtQ=;
        b=RYRVTL8TFlgVdCfFpLm0Ilw5GYhC9rQYqDjZmFGaOptEQXh8R04CuTYTFULhAvnG/C
         cWSFwWTvPb12K3HgbH4EYoxm4tPdTaSd4j4PRDPPfmV/D3iV/XZwmS4FFYiqTENftnyZ
         jWd1bDhXOdqJ93GofKx4xBCqBXDExuVhmXOSEnVfEqazGDakFAkcA6nOq5oV9O3aRjW2
         dDQkWokGljHj3Z7LnOobEWoWWH1kS9YFshKbz2AyC21i8nPFuk530EA2p1m6wEHWnix7
         jfIrTLsC4f5gymLEtJfHfWVLog/TQIuW3cUkE6J35y9bsXpEc8IlVKO03IqwDCMkTKLP
         8csQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8X0LnXFFKansQNCuKZIS4RROF/vt6g1AXMEtR7hI4DqLzz8iQ554+qhtlv0dukgj/yWZXaPE7pH+v/I8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylsnz0wX6jlN7sC9mEzIw4dMwokdDkNMaiJDjDKv5z8lv8+9ge
	+APYTI3QkJmUzVBLPjsb4YixSYtQxBs6KsPqLn9tvoOrNCtsnZ5f8YtCDup3Ag==
X-Gm-Gg: ASbGncsIXZ4wwFCPyokJG36jbzi91G5WnQixNiILNBMfRgLh82j8zXJDlzQ0FUCztiD
	RuTSoi2/IcJoyTOs12x6fa927sXjNSnwjdcRMTy/epMejzO8xiOOxoSFPpwEgwYr/KBLs6g4J62
	4FBlhGXHGeyfMrPujBJbU9lHiy8nUP1MSV98nrRMaxGZl8mi6XRNC+lcsU49uYl+8QHIQwOf2Vp
	Zr4l4rne3jUoVPJDG8r4TokwLKYbclA5S/z+gk7rdeT/6KMi/AXyaBXZqtQB1J9cXmiok3ywbQx
	kcQVkDF7W6w1rp5gNYQsll4R+5qNZESX0ELClKXgYTD83uoTdjg98A==
X-Google-Smtp-Source: AGHT+IEF+s5cUaANZHoNtJTxHRWI2o+ROo6OeQ0i0fU+x5mBKy6gzJ99hJDGFllQSCcfHn9Y0iJK4Q==
X-Received: by 2002:a17:90b:5827:b0:2ee:f076:20f1 with SMTP id 98e67ed59e1d1-3087ba53cd7mr8741809a91.0.1745045703223;
        Fri, 18 Apr 2025 23:55:03 -0700 (PDT)
Received: from thinkpad.. ([36.255.17.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087e1149bcsm2380251a91.41.2025.04.18.23.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 23:55:02 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	quic_mrana@quicinc.com,
	quic_vbadigan@quicinc.com,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v9 0/5] PCI: dwc: Add support for configuring lane equalization presets
Date: Sat, 19 Apr 2025 12:24:49 +0530
Message-ID: <174504563258.14560.1691218790091373846.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328-preset_v6-v9-0-22cfa0490518@oss.qualcomm.com>
References: <20250328-preset_v6-v9-0-22cfa0490518@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 28 Mar 2025 15:58:28 +0530, Krishna Chaitanya Chundru wrote:
> PCIe equalization presets are predefined settings used to optimize
> signal integrity by compensating for signal loss and distortion in
> high-speed data transmission.
> 
> As per PCIe spec 6.0.1 revision section 8.3.3.3 & 4.2.4 for data rates
> of 8.0 GT/s, 16.0 GT/s, 32.0 GT/s, and 64.0 GT/s, there is a way to
> configure lane equalization presets for each lane to enhance the PCIe
> link reliability. Each preset value represents a different combination
> of pre-shoot and de-emphasis values. For each data rate, different
> registers are defined: for 8.0 GT/s, registers are defined in section
> 7.7.3.4; for 16.0 GT/s, in section 7.7.5.9, etc. The 8.0 GT/s rate has
> an extra receiver preset hint, requiring 16 bits per lane, while the
> remaining data rates use 8 bits per lane.
> 
> [...]

Applied to controller/qcom, thanks!

[2/5] PCI: of: Add of_pci_get_equalization_presets() API
      commit: 2f12e20457a27599b6e1e1b0f08e6175e37c7e05
[3/5] PCI: dwc: Update pci->num_lanes to maximum supported link width
      commit: f1eb5da4d28b3788049ef98428b395fbab3478fd
[4/5] PCI: Add lane equalization register offsets
      commit: 165d80061e771390da26a29d362ceff96ab75da8
[5/5] PCI: dwc: Add support for configuring lane equalization presets
      commit: 3b35b43825f4e906d46519908dfff76a58d58bbb

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

