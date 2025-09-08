Return-Path: <linux-kernel+bounces-805149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB35B48494
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A9B3189AEED
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 06:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C710D2E36F6;
	Mon,  8 Sep 2025 06:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mCDATx/3"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82FD2E1746
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 06:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757314599; cv=none; b=mQM5YkAJqSd3gFTXn8V6pmH96lG8RnHpg3b/sRx1N6I6FlhXHbWZi1l+o7tbFeB/KDayRgtTfvRwMLi86aOHpuNupqcQkEy5G3FtNme8yarWHMuIuCwz6Tz30ngUTXkF5G4j0hkoaLj1oQKqHQ3uU2JbcBvuAfhQWGr9/64uuWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757314599; c=relaxed/simple;
	bh=Csq17eCLJmv7/7QqayNfbYw3ZtrTeNIABT5r2MMdoUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a2RZQ91pn96Yor0r/4AiPxWz89suTNtF5kqqGIo+7HuLGV++NGdNmELzy0IunA/WUuS4vcGQ8It2h0ESy1qMFI/iZbU7y07d+EEMpt37J5MdfZY0txavcuvKH/vDv3Rvc4Iubo9kYDzeNpZPj7Q+XM3CXZuZt4VEv5THnasqVTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mCDATx/3; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2570bf6058aso5213655ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 23:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757314597; x=1757919397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vfO9YzOQHvlcLzI/Oqj9hLG6esUOkytAkeiwFxmfpUM=;
        b=mCDATx/3yiX1K5qsI/04JjsJivHS4KLolpgblY0iOgK/9Zq+BSieBrZtQLVO0Je/ke
         McavgOlHN+BUVOpD+oxZjjwEymV9gaD0mMBDdCr85p3TrUJlFjmbOdK43DBycCFsI3ZD
         Vjj23N7CES8gSNHEl8PutjuSWBoaZ+JbxFm6UhdF8X72cpLYI/vnxcgvsx/1/lBw7pb/
         lz0Y7BJmn9JPQj82NBmoxl79rKYZMoYbA/kMcfHGPLVCG8Mbzx7LisyXKuTPbn80mSzC
         cCgSLUMCPr0VFZZTUL0uTs0dBqjD6sNcvpCaz2GeEXb5q6aqBwrY9AmJ8NIJbaCr74bd
         QOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757314597; x=1757919397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfO9YzOQHvlcLzI/Oqj9hLG6esUOkytAkeiwFxmfpUM=;
        b=ISggdcspp/FtD7/I7uncccY6QoBMKYJ783yN5t4NXTE005bfsPcUrx94Ettrio+gZc
         BYPTbLjYPeKBBjx/MFyVqUu1anan8ZLZngYpm69g9GQkSxWCWD0kBFo6OcZ4QZUoFcgh
         utqRh2Ah73unv/4Xesaqkd0pWD0XNRkqUOOXptQG8bZf0jx3LzVrmSeDJvu5D8qGb74G
         jK8v/DEAxE+bmLVd2GBWz+4fWgtblyWvIVIiDiGMNhU4ETldrnyOwomyw7e2DHwgjJGR
         fM45XAg3f3tru0jT6OuLnbPnTwVa0BC45HipQv7LW0qACAPmi3TNgZfewnxkqJhlauKu
         f3Lw==
X-Forwarded-Encrypted: i=1; AJvYcCU5uAvt4GQrnNkXh9HIiWLLyssEQs9tc9KNw4gQMyDWTtxlvF+oMJ97HgUId5Qognu2xrcFxwMKsuh3RRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLcXtlJtzYigG1vQ4YdYBbPXwJPExDsZtghF6Zmh8SkgxbpTtK
	5nlD0dC3p9DfWhwoecA/0Vt8ZtaputNAr02JfRoTAEszMgyRuAn5JHO2t05pwrMrFyE=
X-Gm-Gg: ASbGnculNHqJTcVc0lh339PpcUIn5pnHm0V2cGYVX+dGEwhmgFsiWqstZYvBtiyfe6p
	1Ne5q+CCQ13g+UL+02UH5sBQvR+PVWMQOtj2I5pJD8d1YNimTOyZ+0wEw9bNAZCNyPhKEqY38Nr
	dOazfDmiWtP57aJgkNdXH3aaw9HPgZaLRrYoBsLR/2hgQAkMFKGfv3U+AtJ67+d89Plvzkk0ouU
	HiwBQ47X8gkc8uhTNAx3DvuSzh3RD+K1sRqZs3v1qPWwlrSgHgohap/ccsfl4NDPcZelW8fs1zs
	7G37vXxZOUzOrab3Pc5sOt0WAEyFIjOB4R/2Mk21caRs3Ab5c/gVpkZnmcmshlKNWBBjDQUb2QX
	eSBb5Zj/d+rRkDc+m8INgmBQXpUH3l88hNCI=
X-Google-Smtp-Source: AGHT+IEqN3OfxLAXjoh0BbnNn+jKgNAUzLVPIjM7aPLqTsUdL89FPCgDXAlE/ux9DfFsh6AFqBW7Pg==
X-Received: by 2002:a17:903:3805:b0:24a:9b12:5248 with SMTP id d9443c01a7336-25173ea1a3emr108269335ad.54.1757314597217;
        Sun, 07 Sep 2025 23:56:37 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b905689d1sm150907355ad.64.2025.09.07.23.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 23:56:36 -0700 (PDT)
Date: Mon, 8 Sep 2025 12:26:34 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Vinod Koul <vkoul@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH v3 1/7] dt-bindings: cpufreq: qcom-hw: document Milos
 CPUFREQ Hardware
Message-ID: <20250908065634.m4p4tmjyb7h5bcfq@vireshk-i7>
References: <20250905-sm7635-fp6-initial-v3-0-0117c2eff1b7@fairphone.com>
 <20250905-sm7635-fp6-initial-v3-1-0117c2eff1b7@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905-sm7635-fp6-initial-v3-1-0117c2eff1b7@fairphone.com>

On 05-09-25, 12:40, Luca Weiss wrote:
> Document the CPUFREQ Hardware on the Milos SoC.
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

