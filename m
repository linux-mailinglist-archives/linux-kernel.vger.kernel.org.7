Return-Path: <linux-kernel+bounces-800889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C622B43D5F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29EA85A1550
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F19302759;
	Thu,  4 Sep 2025 13:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f0Zmj5EE"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208E72FF15B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 13:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756992943; cv=none; b=HFihfzmhA8Dx2PrOC1sifdt6R/eRyMUnn3DSB5ohRbQ0+SuOwhjfLFlPSnz3V58gmkjCmxS43p9GocTYiMMc5EuldT29qA0TaZJc1WbZc9U/zzpZzeKtPLoRpMNAio2b/OZo64osC9NGftnfdYzRIizgWWt9XbQfnDxHGyucbF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756992943; c=relaxed/simple;
	bh=xrXx9MRx1hlPK4mCTXDWhzJXnqZuhCcmLQv6dj9xiBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CfG6HtbtEZSMSgdK7mqWI8PBI8OtyUI8+QuaBZFE4j0uYjtDnUZiX5FSye90oAPhV34EiegeuQgDAvJv1jzc2nSvZmH+roIkZMdJaS+7J5FtyPlKyFV8NZDtsB6uJ4b6oe4P7ci7C2Vzi1OSiDWrTMioWYbFcLJt8b8FPBjPkIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f0Zmj5EE; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45dd505a1dfso1379405e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 06:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756992940; x=1757597740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ts7F9KH5ZUtAV3eFTPnD4ApkUPnB+DSSD84QPmcRSHo=;
        b=f0Zmj5EErqtjnzzlBfi6YWNZsu8m9woELS8HwY8/ae+oVT0hagizvwX/Medial25vT
         ykfce4hBtyHj95I3Vw5XL8dgvgObzk/mql3EoOhUV+lvz6SSqKdQbWnmkx9PEO/o1f9b
         nuGF5NkKIL6N0Spl3eS00hwDyoPVE9j+qfye77xqZjcxzbtCx6tNXrfp9FlSJgOELVbN
         jMqm2xITXq92l1o4bgZEMA3yw2Pv1lXskgdQInYNmCVFtJuTqfUPKn/dn7xBIJ9DhLRq
         yxIZagRTUKyDbEG0pV7eRKAp5Ay41eGVKDDXTmpTHtFp8WwtM3MsZ9yjKM3tEMC8Frw4
         u1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756992940; x=1757597740;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ts7F9KH5ZUtAV3eFTPnD4ApkUPnB+DSSD84QPmcRSHo=;
        b=SrNPxKzQ2WYWezbTbhWTEapBdYV9EV7JKDz6eWPlrY/CA0sg8MT8tVxHw3FCdlrFSL
         PghktR7e3SrxIKF2eaCUIw/fOT167nchNk1epaIh7ap0b5/UtBjH7YnP18GN4l2cJzKi
         8tJoyA5y+MnHPaaO9A92M+sxIOMHNDZ4x9WeP57PKWUbTeXuSlYiyLO868B+wsGs764z
         ur7XEuGPAD2P6KOqrU8WI/kj6tV5crCvNEFGsO8BOWvIUaPVk+ibl+kSpR/ie80FrCrb
         NWFXTJxP4gj/w2dqc/7ghSVPTdH+DW4wkeAUj71Z7cKyrJ4zLaYRjjbbdB9WTA35i2VS
         Fdkg==
X-Forwarded-Encrypted: i=1; AJvYcCXyk3z1W37IDr0DsxtyqVTInubCgy2CjoDAxcfFJc8DZVNAwPr3FfbeaNc0GU2vYK8WcgC5C6gaKInDwc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjChLEPYrnK+PeU5Vami4uzo/BkgTf56k6qsBPQipaKlBU5hfN
	MqR9icAbrAZlTQGu21wsWUcuztcgX67wk+ZWTuEna3UmXuYMFEQDc+kfhOi54XexaPY=
X-Gm-Gg: ASbGncsxKHXCBSFllzsNtO7Q1VK8Se5WUTcUh5rC9ts/ex1wJzBKCc+DcxZW2yMKOva
	OVAVCmuAgu+Jiij7VfT8MDTc434jpX95SV4DXLtRU6akK/2u2Kf93sTgX5gLXDX8CDz/slt13Fv
	NHSHBR6F7epAPY6DSNExymdL8xOA5ltZwSRNpSMBHKRPZk/OpNioZ9C6pe0Gwyq78JEexfq3AlZ
	WoopM1DVumrEGZjHd4XY7MCfVsPl42ZnWizCZ9ZMudmm+d+8Ozl6NAWj6NgBYznI+nlE08sQzPP
	AvrhQ08Z0iF8qRVhs/0Gmr9KzeRhMXFm0J6KEYPRRx1xpv0m57pRYzNpBDSuuoXlTYI+GjTaDBJ
	7cxlbOT0o2RYGTeTZyaQLx3fKNMRbWf/F
X-Google-Smtp-Source: AGHT+IE1nUiihSeVtcjexfaVaspPPiD19Kl/JDFihVARfiPUJVO2IQmMgm5+rACynonb45+j6ZD7CQ==
X-Received: by 2002:a05:600c:1e8f:b0:45b:8067:d8ac with SMTP id 5b1f17b1804b1-45b8553362bmr139743805e9.13.1756992940021;
        Thu, 04 Sep 2025 06:35:40 -0700 (PDT)
Received: from [192.168.0.251] ([79.115.63.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b9c5c89f2sm100601555e9.14.2025.09.04.06.35.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 06:35:39 -0700 (PDT)
Message-ID: <ec2b808f-4303-4a32-9a53-f5b9dfb57520@linaro.org>
Date: Thu, 4 Sep 2025 14:35:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: spansion: Modify addr_mode_nbytes for DTR
 mode
To: Santhosh Kumar K <s-k6@ti.com>, miquel.raynal@bootlin.com,
 richard@nod.at, vigneshr@ti.com, pratyush@kernel.org, mwalle@kernel.org,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 praneeth@ti.com, p-mantena@ti.com, a-dutta@ti.com, u-kumar1@ti.com
References: <20250904131309.3095165-1-s-k6@ti.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20250904131309.3095165-1-s-k6@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Takahiro,

Would you please review this patch?

Thanks!
ta


On 9/4/25 2:13 PM, Santhosh Kumar K wrote:
> The nor->params->addr_mode_nbytes parameter defines the address byte
> count for the current addressing mode. When transitioning between SDR
> and DDR modes, this parameter must be properly updated to maintain the
> correct addressing behavior. So, implement the necessary updates to
> nor->params->addr_mode_nbytes during both DDR mode enablement and
> disablement operations to ensure address byte counts remain consistent
> with the active transfer mode.
> 
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>

