Return-Path: <linux-kernel+bounces-868895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B74FAC0671E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E23F53B5DA3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D6E3195EB;
	Fri, 24 Oct 2025 13:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XzM2Pj7W"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E8431A568
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 13:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761311709; cv=none; b=Hhe7oCDum+n7+rzJ5XcP4fgQVaJ/LqOtRBZuu2eBnwm1Edc4X/i/zKAV5eJ/7Lg+yUkZp20n+0iGI5Jwkk/s6YkJ3HqpBAFuvwVFlVfxw48vTy0kZkqVmfH1atSOf1XYj580xej3ClfQE6VPBgk5cLgQzODIdm88jmQf1L7KwsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761311709; c=relaxed/simple;
	bh=wCq96Dati4I5E2IUC254UV7B0adcrwgl2OQoaQ6PdTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOHD8LQzJ1mn55aYKiuwlfRSgbo+jvFEDUUnxYqMwsJJx65xUmT+M4UDDU35h6i0/NodUbLbOgMJ5GS56oGmo+LlO0en1bFZNK6tWGf1Giog5e4WGdzsVY8h21woiiVE4v7Bs9ANsEfNL3gcJCRZCQIjRlu5WQ5DokrLQaNa9UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XzM2Pj7W; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-475d9de970eso871635e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761311705; x=1761916505; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kIR6tDdHpPuBqygBUUeA5fTj/g8t+nxKee6d+FHniQ8=;
        b=XzM2Pj7WkovyAlCuHdZR8hdIhb9QsVo0KZ/lym2wLy7F6EOnkcH1quKZpjYcIAtvlh
         kCe4ZFjJXlLNumtWy772EhTMJNTKX0azBTDHlQpBmkxKzChYZB49zI2mHI2Fkb95Iwx2
         p0UqCzcV3X/R8rTcNZs2FTDoDUGf4AaWNKARRXl2XiKBh6IAoqcXaXyDIo4AOMM8kDu2
         C7tJgOfnCSB5Px+QTWNEOExYExYEeAJcH7rNw9j3dpxSiuKtxl/cLP7AyAnWjbiwVAPw
         PqhB7eg8uQf4xxX6nOkb550yyRxGVpBlx/MAnKdjQbJ5i2a6lKQV6bzExr5t4rVb+Al8
         9+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761311705; x=1761916505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIR6tDdHpPuBqygBUUeA5fTj/g8t+nxKee6d+FHniQ8=;
        b=SLYckr0kwG/ROSc7rBaH4mV5gLxqnIg3dQZ1k5fwWMwru1/Q6wiVme3LH4YYfYZqPu
         qjmYRYE5VL0gXF5zfYSl4RdSLdkBEQAgy9+sZZOyrEWKHYkwdiHqaX61Bs2oBLa9cPVI
         SK80PIn83qKmSi9q/lRhJhTqFYLx/IZhUMgTwyu2A8AflaP3rBWOV8pM7TEoTWiSsDNF
         KAjfSfuRzzhhkSjQUQuJwhUtIlVioeVrozjuYgUMV27eVT36lNkdEhM80B2QcYV2HMcf
         5xjtVBigBYCkAfFKDMxKwub6VEsFEX8s/tVQ0nY5cGBrjdbtzwF3KETmb7ZNnw1w61y2
         KfrA==
X-Forwarded-Encrypted: i=1; AJvYcCWjaG6lk0ldbLANZ/3q70/pV9qnW7hF0OZQgP+C7qtPFU28gAFI6jMwFxYX3lz/Y3GZ0SrmCccQZb8yDB4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+QW2JQz9WIXuNFebxRAJLNuHsJVFurUXJAKl1sU4hStjzw+m9
	q7wwNatIIh9YRFD2OCCeOkSzc6pN0jPlMvCRCbDYvXsy09GeyySrZVwYXLzkV7aphdA=
X-Gm-Gg: ASbGncs6sQkJ1Y1O6GBs/s6gCRBgI7ZmBRO9HwQZOKUieIQIVWSvrjAAtY1uL7ba7xY
	34VFb3b8g2NiK7TCvYjlqT4z9oGKOSIqZhUCWz5p0Ew3iodufgkah+nI9oGShLYs8UODaDpJO/x
	N4yHxdPFUa/jrQdymnnWSV4EF9PqiLlSXKAcaruysSZOZMjKJ/L4VXWZdbzDHbVL/+wU1QMk82X
	k9IPK7+xio9g5wVcn9HVW7IVSA5Faoccv6PSV8pHQU1DvymteVDMhCXgzBIS/DU28naVeQhTZV4
	la4LLi2lcLI3fGDG7h5didm4zqv3hpSCm/bQlpK5hrTnQFnTqk9RFYIJeU23e36d6lxHtKPidpw
	4KxL3ogrUxPUD/wFgdcg03yhBktbDsJaDY8DFFO1ebTDGxu345JUHGIvlnRpyOf7xEvzUfd7/g1
	3zYwc79dI=
X-Google-Smtp-Source: AGHT+IF8wfDFIm97Ka9nM3TiqqSxvLDXMj4s3y7C7+WqZVoPL/8Vk1qf9yFW0k4qQa+9E0As7IpBXA==
X-Received: by 2002:a05:600c:444d:b0:471:1306:aa0f with SMTP id 5b1f17b1804b1-4711791fa1amr183046615e9.38.1761311704587;
        Fri, 24 Oct 2025 06:15:04 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496afd459sm88434425e9.1.2025.10.24.06.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 06:15:03 -0700 (PDT)
Date: Fri, 24 Oct 2025 16:15:02 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rajendra Nayak <quic_rjendra@quicinc.com>, Sibi Sankar <sibi.sankar@oss.qualcomm.com>, 
	Shazad Hussain <quic_shazhuss@quicinc.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: lemans: Add missing quirk for HS
 only USB controller
Message-ID: <y4iksnsmjwthbulucddej4a5qcvrp5uk6nkx6airkeufgkp65a@yruyzlosioxr>
References: <20251024105019.2220832-1-krishna.kurapati@oss.qualcomm.com>
 <20251024105019.2220832-3-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024105019.2220832-3-krishna.kurapati@oss.qualcomm.com>

On 25-10-24 16:20:19, Krishna Kurapati wrote:
> The PIPE clock is provided by the USB3 PHY, which is predictably not
> connected to the HS-only controller. Add "qcom,select-utmi-as-pipe-clk"
> quirk to  HS only USB controller to disable pipe clock requirement.
> 
> Fixes: de1001525c1a ("arm64: dts: qcom: sa8775p: add USB nodes")
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

