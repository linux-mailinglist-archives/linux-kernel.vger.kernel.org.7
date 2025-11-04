Return-Path: <linux-kernel+bounces-884444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 103DDC3034D
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 10:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D41693A87E7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 09:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542503115A5;
	Tue,  4 Nov 2025 09:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sRxC8ZhC"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D23303C80
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 09:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762247424; cv=none; b=gxrQnlJtmcKF4pXVDG9VaLiZLjwznxMZoA6tTcdMyIjzAMmquFt/VjR7vkR14bGrRRwywk4+S17jAoHE8YyriwrQ2Pai3aO+HnCdczN22+zEs9DfSM7dw/CccVZq50kNeYD4oaLtNFSzUnpoihQ1WhXtmtwaQcqsRCpxHUZcT+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762247424; c=relaxed/simple;
	bh=e+WrZa3ef8AdRcYId27XHT8jL0SxKU0LfZDZgv50HDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5UMnzmHsDcIiOsAfYaT5vE8nnwrIWSc3Ao7+FTLOizK2QCeyQyIivyV3iyjzEHgYSEkJLxdXtV78bdqTD1S+7a05YlCeTA00qM8NjJhtjCvh1qxCSSzW5ByffeYcPAtAYm5UXyPCSR/V5TLLC4P6mq9ZXNhXxfxZVcvLmBOgd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sRxC8ZhC; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4710665e7deso24563285e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 01:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762247421; x=1762852221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DpweAw5zruf0A8JomoHVO706aMoW4BuNB+DPtZgoR0c=;
        b=sRxC8ZhCitcb8jMy8baFppofJesOvJhYxATqmidj2fyLLKycALUDZWc/iwXFuV1y5e
         5vN131LXZfckyA3Z3Wf1z99UlavzxmGGdgmjTrHQ+jgWqjRZst/F5uYTwmqW8vNuoHsK
         3+OTxrNP9AF400wvn91K+4JrHGa0AMeWaVVst/yFG3l5tTYMENtM++/UBzftx50ZBUNk
         CCVe/5nhtOZRzDaiYcVBdWhD67lLgXG9frGXXkFG63/yIgCztmOnJ4NrDn+IqAMcqC3k
         pRHOHL9uTZ5tUJQlSaZWiO/ZqCQgW+44851/fIUZ1knxd1/56dNtWtZI/ZogAW0KIhx0
         UT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762247421; x=1762852221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DpweAw5zruf0A8JomoHVO706aMoW4BuNB+DPtZgoR0c=;
        b=hhvBq4gjbi734VDxGRW6AlDqjdVXXdKW7Mzbwo317CNY27sywx0yr4bBHLtfgxA1Qc
         nJyKKFQ+rXS2EaHRYUKQFO2ow21PiNwbJlPipnlJauzz5TIG/2uKDi3IYPMuJOq93cnO
         RSKhlaAwnqwbnnuMetDBQzzyeAwCnhp8M1kjZA3I7rIWjWLUWsufDdOXefhnKynFm1uN
         1AhoMm/G8eAhI3EkxQJruLudPPB+oDteoIE6iuu7v7ettCapKCaIFHN2TuPkzmt5NjYk
         xDTMrP17v0xBoLWitGT/DJzv3wgI7k/GvlLdYt5HW3+mPfznvEYF3lcFk42Z1hiuo7EZ
         dn+g==
X-Forwarded-Encrypted: i=1; AJvYcCUiEvIzpGbjvUYZC+/X9ccXi7wCsXOnjEfDW+aK/TQmmnwMTG+2JjfdDpTpHJL2F+BBU0NPFay1S04EswQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3zdiwh/ohw/Z7LBsAkT9bzT1zh2CpPRAvAxSSPRftqU6a2FjA
	l5vWyFDpXglPKnHjo+QoOkXbe8BS4C0NyC2kD96YLpE6BXpudsqMnEkzil+yYhLZ6OjUB7sP2Y0
	LL6It
X-Gm-Gg: ASbGncur/rPupCKscu9uAA5l1Y4NmG/pSjh3Mg5u2QBb+RO+WKRwVYdd1Ixtq4VvwWA
	9GarsEmaK5IC5D6HIu71RSxUn+pvBJvYGTHHVr+O+c9yp/ZfobNBKITpa8ytfE72YOv0ezbObRo
	7eo4JITuKWOsZOJK/+t8quqarDOvQBLvmbT3uDHBlv2jXQRxX5YbKRspukKRVoWOX6VuQcmk4iZ
	HhdPdbU/IfLMPp429C8rDsHeW4L0QFwFWYF0ifUe1jzSqdVDf5Lkgyhxs1XTppyb36ftZnL3trw
	3putUymq04AO4PnmdDFMMK7JwVvLLFsn/IAym1jhjpKTHR+x+i2UqWw5UI1h3css8DReLqmQS16
	otPHmBGaYhWs5URKr1+yQjENgkjYwsD6QU21F+3CiMPCCZhfA/AU4xDhh+/kGAFBw2jY0dJrw
X-Google-Smtp-Source: AGHT+IHCBO7xLP5BokKxzK7/sqIK85VXUnkSNyV6W821hzOhPl8zMr4wD6F/COlyyLObPR50tBq6Ig==
X-Received: by 2002:a05:600c:3b03:b0:477:54cd:200f with SMTP id 5b1f17b1804b1-47754cd211emr18406055e9.9.1762247421039;
        Tue, 04 Nov 2025 01:10:21 -0800 (PST)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c2ff714sm200016665e9.8.2025.11.04.01.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 01:10:20 -0800 (PST)
Date: Tue, 4 Nov 2025 11:10:18 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Qiang Yu <qiang.yu@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Subject: Re: [PATCH v3 5/5] phy: qcom: qmp-pcie: add QMP PCIe PHY tables for
 Kaanapali
Message-ID: <2cdrb57borduwntzkihdikdrmnytibbtw7eyh6xjmyqi3yppyf@iwafnggbrnzb>
References: <20251103-kaanapali-pcie-phy-v3-0-18b0f27c7e96@oss.qualcomm.com>
 <20251103-kaanapali-pcie-phy-v3-5-18b0f27c7e96@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103-kaanapali-pcie-phy-v3-5-18b0f27c7e96@oss.qualcomm.com>

On 25-11-03 19:08:17, Qiang Yu wrote:
> Add QMP PCIe PHY support for the Kaanapali platform.
> 
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

