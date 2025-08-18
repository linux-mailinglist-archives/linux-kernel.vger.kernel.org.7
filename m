Return-Path: <linux-kernel+bounces-773257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 821FEB29D5A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48C8C7A45C4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACDB30DEB7;
	Mon, 18 Aug 2025 09:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C9W1K+cT"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CA22236F2
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 09:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755508418; cv=none; b=neh8Nz84wS7bV3L2GZPRb1kikX6MqAYJwErNBAmUM615osSfkkXopqbVdTluCpWfK4UHTEVx2lJ8tpkdETzi1n5ZavK0R2EMaPD7JRrqOAUZnAplRuO8E1uQx8XCXZpbKVe2UsifnwPjz9OEdhIP6U1JkFeflmaIr/hAf13Muiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755508418; c=relaxed/simple;
	bh=xelw41k3pm5cV8Se8ISfXTeVZHnkMuKVO9e05eqy3No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHstDGIlgp+iHYoOlz2tZyKw1he20DYD34AidHd4Mq9H1/pGYOD3TK72q+OUgT5EwPzXWxP9Lxu2o6vmHnvgww25n6UAVaNP6apoZKOrUS+WXnm/noCxKfaKJhTOzRe2VG7SHbTG180Rr2yWMQhKdoR1bhLF44nkr4YnWO6qEss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C9W1K+cT; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24457f53d2eso46094595ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 02:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755508416; x=1756113216; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ByAqf7ew0qsvJFSkObrVJcMa/hiCKQ4k7aVcvlUbpt4=;
        b=C9W1K+cT5ps42o3H9HzYBnM4SPO26FQcXEVBikx9EfxJIgbUgTjQh/A1vVVVo0ipZw
         jTt85Q9ciyP1y5VGy7QLDV7ft41Qzb4FfkkXL3slsxH1+rlgiDc7Xd++nU6RtiIoBPKI
         L6/Rzr2zHDjL3GN5WoEfYPn1SYFGiMQULulV2qc+3FERwucLibJTdVxqu9RQyaQyeyf7
         wbHN/lijD+5af2eb/dNiOcq+WDmqkixx3thL2CRhLntiTtBcNkdvGms9GTQMmAYWsuCR
         xfu1AfjnzJsrrzFuL8m3f/Sggy3ty+PKgb3TTH8tmbLWYYOWRQHDH3z5+ysD1MHb8l+3
         8ZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755508416; x=1756113216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ByAqf7ew0qsvJFSkObrVJcMa/hiCKQ4k7aVcvlUbpt4=;
        b=XrWrRV3m+zof24llCE4Yu2ov8MGQUaXfWJmaa0GWDVPG+ClQp/MSxGQRJAHx11lu/+
         swlrC/W2h5J56GxpVrU/RsVr4KdNGLXNWp5ct4FRdBqGJqwQHG2xD5EopvGmJYTvNoID
         8WK1oe5+94qrqW/MwDvJhAxgb2yowLh263ZjCjW0cxWbbIXiA7SZfmZO9Qv/9FKIFTtp
         dlbpxxzrSP0GW6CGh8KqQoIv1mskjHryRfnH983Sbyn2oCqt6CyQSy13aEJfVAHWonQb
         I/9gfxY/GMT6kZaRxWZtHpV8YUpbfvIRqleAViyLEEGoOWooD51D4RixWUhArm4BmPWe
         i9Zw==
X-Forwarded-Encrypted: i=1; AJvYcCWiqiPtADRM0ESSZ67PX+9ZpRUTGRzVoak/HukIcYWObl72sEJVhTIA5njcJNEm4dkDWGYjXGhOEKp3Dcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXYzppCJcLE8ChWidTaKySx4pWHR8JiOcUEUf6CZP2Zm0R+Mpq
	BJeMaF/k4bAe/caTo86AX422lGtxM4Twt0n+vDXyFcpYBIh3WSVTiFeF6ZCOE5Tre/w=
X-Gm-Gg: ASbGncsHTtqB3pX5WhQ5BZD7MQBaNHD8bwZpQjSPqaPSk2X7bnxThV48nV/uFrJYmIj
	uLs7/MfdlmfB0z9WvepGMoyVvfjhV3LDyau/dRbR99laDzv8bTzhWQWC3DcqsODFTOwc7zFNThs
	0smhaOeC5qPcSmeIePLbHEjjUkEJHi+JN6eVk94PSK5N9hRJrmnKBuy9uim7VU/EzJzo0Kr0uFg
	KHF6Q8VpCmnZ8Fr2dFpmCRe0vrXnL/2oSznn4Jff12hhNdxbPSnBZpfnFG81vW8BSsDQdwvKQ4U
	BBfbZnxliSKBo0ciC6wib6Wl4BnFJSgmzcQ0bAjWPwTvTFXB8f4VcvqafxbAC8r6TwiK46ODypy
	z3NSuQpjG8iFSpLlcBgWBz8+U
X-Google-Smtp-Source: AGHT+IH4KDM7M4CRQXVnB3k6j8efu5yywyMexkJLQg2z4smAorz+ZWupNwv9P9EteJCL5oCvCbiASQ==
X-Received: by 2002:a17:903:1b04:b0:240:150e:57ba with SMTP id d9443c01a7336-2446d6d33d2mr159454275ad.3.1755508416372;
        Mon, 18 Aug 2025 02:13:36 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32343c4d680sm7505714a91.21.2025.08.18.02.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 02:13:35 -0700 (PDT)
Date: Mon, 18 Aug 2025 14:43:33 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sm8450: Add opp-level to
 indicate PCIe data rates
Message-ID: <20250818091333.qlbipfkg2hasdzwi@vireshk-i7>
References: <20250818-opp_pcie-v2-0-071524d98967@oss.qualcomm.com>
 <20250818-opp_pcie-v2-2-071524d98967@oss.qualcomm.com>
 <20250818090240.in7frzv4pudvnl6q@vireshk-i7>
 <5f3261c3-3e44-42a5-bac7-624ce4e7041f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f3261c3-3e44-42a5-bac7-624ce4e7041f@oss.qualcomm.com>

On 18-08-25, 14:37, Krishna Chaitanya Chundru wrote:
> I tried to add the level as prefix as that will indicate the PCIe date
> rate also instead of 1, 2 to make more aligned with the PCIe
> representations. I will update this in the commit text in my next
> series.

Okay, I will let the DT maintainers confirm if that is okay or not.

-- 
viresh

