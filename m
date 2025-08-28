Return-Path: <linux-kernel+bounces-789261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3698CB39306
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 07:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EDD11C228A8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 05:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AF71EDA1B;
	Thu, 28 Aug 2025 05:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tcJKhJ2r"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE941CAB3
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 05:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756359066; cv=none; b=tAChSb9AHcXOMH4L7ZDX2bZH2VIflkypQJLPSu1R0NximZlO44uFZxFdCSoHGPdfrosh48R4Sznjsf8JqKZgH8rPqw3V1atqkg/CnaSGD4eXD1j1HCC8J16TOU3fHps59ASZKUlLB9Jb1aEy1K4RhlQ/wqpBvJ/kheUo8Uvm72Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756359066; c=relaxed/simple;
	bh=5zKrEAuiGDKnNed1dJm/eqTT9oB2Ui5PKZfLN3hNsjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CzKkTRlQECI6uPlyvrQ7Zlph3bCA2tV27mEN5sQY26fXroTIESG7NcijlvDZuVeskT6Iq0B0W0bNsiOgDhQDc4FgctnF0P0jY9NW77u4nwDtGQuILIRoHZPrrrvdLqAnWLcYfD+a/rUwBmWBYJYEyhNMeCcyXAfX/ABbGfCRk24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tcJKhJ2r; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3c7ba0f6983so365708f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 22:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756359060; x=1756963860; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dukyz/wwn5n6nYfGASrhAq9EDpRCS5QgtuNGs9mvY3o=;
        b=tcJKhJ2rjU8XiF2creoqkOcYEVC6e6SsYdTiMhu3oxjqw4HyZZP5CRcQi1Ufj4whg+
         JYbb2z60MCXFsuAGriWHxewudJ/gzRJ2AHCmJShNkH/niWb3CW8hYCxj6aA5QDZxEDdE
         L8LwmCudkPpl6tN/UiQgRYdtcjwgTnV68z/YgSWYMVwkOh0/qhEP4xBGjfuQOJJZCb0E
         rOyKLnM09qdk9TTip/XKzmZ5e2LkbXQ3OQwLc7m8MO6jJmb5LbMkFQxbRn+Jx7diEAWf
         swdogQWCmYa2BsTgAtr/5gJ+aHSULLzNCptplGychuwMWBq/WACHcbJQr89MNRGYyMN+
         0EaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756359060; x=1756963860;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dukyz/wwn5n6nYfGASrhAq9EDpRCS5QgtuNGs9mvY3o=;
        b=v6d82sxILOtJB1YjQGkhnQwLBSCbiaIcUDR5qyeKYqh2vio+wJevODpVaaLImM/UKe
         p3ceQoOSHJ/fkhrIig22UmujmAURJ5ZvRIaf4C3nT6emSXwnl7o4AHhKIEpF9sGEY4Df
         iDi8zC59dB0Ize8QvJmvWS4jKp/RY6edOCEBjgDcqHdp9f5T3aeLTLG61Abibd0eb8MK
         OSqNd8uNVcwCx+ZM3mQqDeAnoaOXVQSOfbwWnSSJLI9hv9UDvpEg3Y9SSY7saR+MvbSG
         THo7BJsXsnqeet5bIwzO8tW1CN3SoChesZDdqGU+xug4nYcdFSS8Jy82ltYFrP4UwQw6
         Y68g==
X-Forwarded-Encrypted: i=1; AJvYcCX2BfSKIHxRmlQ3eA5RfLh9FKST2rX15lJ8JxNh8RWSnGbINWmiUFiO2vE7zoI0j6MSB8WFcC0PBjQRkxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjSLTB737oMPog22GMklhKtXHMdRqYbqgi4CI2kn0uKulSIC/f
	ehQopohkLXySZMLZcpXdXt7vq3RhISV6SN1jxYZnJzNJzywiTih54kQpcmw2qN7pF1Q=
X-Gm-Gg: ASbGncs2OfM/J4fcBCQCikj286d6DTHKnUT6E/3uyVfsrFpBMnrbAEbwaOx4JO02mPk
	iiWOb0bZ6lOOn7qMrWvQP7nYS/6fs1CLFzsoSKamlQAgsL2uaqrErs38SRzzq197lyXc7PvjmVW
	Fk3ukG1fKPpks6hzCVi9ng7tPipLFm4PQYgkKXVTQOmNiD3ZR57C7ypP25zvF9fkPv5SUdM1pqh
	EsQts5B6iJfqKorsNug4k5C4bBU/fxXUod69xTXXKZnx2vN+yJeSMq/VAHl0T+l1Fpg5JR9geEE
	4absVCbIED2jIuk4bKlGeozXg7yu5upbzcOUQc0zuSH11g/dJNZqb5IZSbhuNMeOqRAbgHTBdCB
	RwhUX+oQfjhUmMfLrihAS2ql/V2eV
X-Google-Smtp-Source: AGHT+IH4nwfNWHmZGlR8S50a3ZT7D5vEGnIKIVmskD+uwNW3XeQDTxi4IgzGD08mK38khPTU4HbCsQ==
X-Received: by 2002:a05:6000:2f86:b0:3c6:97ae:a59d with SMTP id ffacd0b85a97d-3cbb15ca063mr6020844f8f.8.1756359060216;
        Wed, 27 Aug 2025 22:31:00 -0700 (PDT)
Received: from [192.168.0.251] ([5.12.38.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cc4b102889sm6638839f8f.51.2025.08.27.22.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 22:30:58 -0700 (PDT)
Message-ID: <05e9dfa9-d628-4a4d-8cc3-f6854cc186d9@linaro.org>
Date: Thu, 28 Aug 2025 06:30:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] arm64: dts: exynos: gs101: add cpufreq support
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Conor Dooley <conor+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
 willmcvicker@google.com, linux-kernel@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, kernel-team@android.com,
 devicetree@vger.kernel.org, =?UTF-8?Q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>
References: <20250827-acpm-dvfs-dt-v2-0-e1d2890d12b4@linaro.org>
 <175633665113.3746832.15304875656374701987.robh@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <175633665113.3746832.15304875656374701987.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/28/25 12:18 AM, Rob Herring (Arm) wrote:
> New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/exynos/' for 20250827-acpm-dvfs-dt-v2-0-e1d2890d12b4@linaro.org:
> 
> Error: arch/arm64/boot/dts/exynos/google/gs101.dtsi:75.24-25 syntax error
> FATAL ERROR: Unable to parse input tree

That's alright. There's a dependency on a bindings patch that's described in
the cover letter.

