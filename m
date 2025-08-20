Return-Path: <linux-kernel+bounces-777214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD08B2D6EC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D42B1889B1E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381F02C11DA;
	Wed, 20 Aug 2025 08:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ofYFmVYq"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12DC27147D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755679190; cv=none; b=m1t9tClUxvzDRpLLcyvwDd3tG5qDGQhzoF6n1WQ4ZsGwI7NfBDRV8zPTC5O/ilLL5U0tiBst2MIKjmUBOfv+nAUWLL3llajb4KwvdVyciYA2mptS02qIaVV7cDWLqGzcYZ5piUTiOqOnjehg7IYw9kjxBiFX+iNY+1MpwCtVMt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755679190; c=relaxed/simple;
	bh=B5Odn0BpuqAx/zQPP5UfzrjrGTX8wxfSsyNahtVboZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmmv9CKCkWL5+r+6Td7c7GqeNgz/ICXGL9X68P1HucAugWZor3UFiMmt9iGry5ojlF/N77GOLAvpuugw++D/wyiigmzJcRRey4q6YeAxm2z+rg4P/CYceGAw7XoqEkkJZWjYZTtx9hlJqj4pzsTzzLdIDLZ6FgDVZNQA15yOxuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ofYFmVYq; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45a1b066b5eso32515855e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 01:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755679187; x=1756283987; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IfdcMs0PNyVozDxCFB7NWyoBaP2B6WgwAVLq6ldhhGE=;
        b=ofYFmVYqIz7TnLyqS3oui/I6FgAZ3uQL8D60Gd5HHy8UsCMuC6fgQZKfdFGQipUPDL
         RJ/L3lTuYfFEJ3oNwyW4bDZvzuuB/CJ2DsXizq8qb+V/UdNbBKrMzGF2CkvCN3am2NlZ
         riHGA+mO2rGW/ZXpZC3Yrt7SaPQAZo+EKu0n74OTJkcdxDHSpOM9p60b+9q6lQnbwm1M
         7Aj2mlJt69N9sdDqQRkKRoUgpIRkTWkDX3iqoZ6N/luck3SbwQ+O6DeuB6ll5hdBYpi9
         qNKNRkqDty5aQHU82EtlJcJN5w+0RsZKOdBID7Ha/b1dBzomum4e+Y9tmR8SHGlNkpV7
         6TTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755679187; x=1756283987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfdcMs0PNyVozDxCFB7NWyoBaP2B6WgwAVLq6ldhhGE=;
        b=eW+q3gdiX1ZD1cNBMaKrE7dSdn18BULYSVPIxvXcXr3cCpdi8bwSFKX16P4w1wqj9C
         6njtQeIMAk0vh5oNSgrTy6fqQqf2inlx0M2hTc41DuVSvEp+NBk31QTy/8adxc3WcVmM
         vmAel1yw9cnZg4B3juIQt3Oh5HiTmL4tPmQKS/krv0M8ypsSBGt7S/a03qmbxTD2JImf
         YBP+6MfPPs+iimKC5KB3yalfTmnNmeX5JP+jxHO7TAo2pmw9LxWxyc2Re6boS7vu2HSB
         iijCORhb2g6CAwvBgnUM+pTuyRW59mpto1LPPno9qE7ToT1zrNbvHG2RGnV6oJkL4lft
         swIQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1RoY2Eduy1cQt3MdE3xyRVf7do9cs8qRJfLVnH8JmlTMCjfr0sM7n5DkLRe2SfjdfLkXfy6M5cSuiRa0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbQD0W+fBd0g4DGANgp9fjeHzejTKSbegjS4A/ORdhel/C4kS+
	uvP2WW/nZ+XQ2VHYl4kCI7KfZHhDrV2AnsoAz9of12d+GoHa0tL7n2whoJGgO4qb+Ss=
X-Gm-Gg: ASbGncu6BZGNf4PcMwNTZb7JO2Ah5lZf5qRFyTVUhLEXayal3XLhWp8JZYRgITO6zb/
	Tyi1tEJzS1lTLQ2mIZcHVH3/Qhegtur4FOgP11s3EFbuLvGBlKioA4Y5mbTmTgooC8NYZZ5mNgl
	nWYQVv7bLt7Nwr1I86II4OOrjJHerDywR6pFV9kujECHhP0r99CfbQSrf8906XuP+F/0KuTWm8f
	0MsUXiYz8tO0UDp3PX4900OWPPXQM4rQa9D8dpSg5GJucRLKyFcjCORg4Xl2SEEtaffRz8THOpD
	AbEM9zCtnbJA0qXyWcdH4XR/doV80ZalQcdtqxCRWnWVpdxZWXCTMagO3WSHcf8XWfSfZLS/XTb
	ZysSug2hXkA+xAAyKzoU=
X-Google-Smtp-Source: AGHT+IGJauwKyrl57epN9GYL9wKpPJYYPayxZn61Gui1IwqTxzG6ooIUmqPZFZG1hvz5cY1leyuB5g==
X-Received: by 2002:a5d:5d0e:0:b0:3b9:1684:e07 with SMTP id ffacd0b85a97d-3c3303dbf5dmr1187908f8f.55.1755679187055;
        Wed, 20 Aug 2025 01:39:47 -0700 (PDT)
Received: from linaro.org ([82.79.186.23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c077789106sm6850315f8f.51.2025.08.20.01.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 01:39:46 -0700 (PDT)
Date: Wed, 20 Aug 2025 11:39:44 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Taniya Das <taniya.das@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Taniya Das <quic_tdas@quicinc.com>,
	Ajit Pandey <quic_ajipan@quicinc.com>,
	Imran Shaik <quic_imrashai@quicinc.com>,
	Jagadeesh Kona <quic_jkona@quicinc.com>,
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v4 3/7] clk: qcom: Add TCSR clock driver for Glymur SoC
Message-ID: <aKWJ0AG4r6owg-O3@linaro.org>
References: <20250813-glymur-clock-controller-v4-v4-0-a408b390b22c@oss.qualcomm.com>
 <20250813-glymur-clock-controller-v4-v4-3-a408b390b22c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813-glymur-clock-controller-v4-v4-3-a408b390b22c@oss.qualcomm.com>

On 25-08-13 13:25:19, Taniya Das wrote:
> Add a clock driver for the TCSR clock controller found on Glymur SoC,
> which provides refclks for PCIE, USB, and UFS subsystems.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>

LGTM now.

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

