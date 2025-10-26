Return-Path: <linux-kernel+bounces-870528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B4FC0B0D3
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 20:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 115E234A1B9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 19:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09C32FC881;
	Sun, 26 Oct 2025 19:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TsV2NkG2"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189F724C06A
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 19:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761505911; cv=none; b=kLD+tlprUwGHtuZ4AmR5cxa+G/fgNlUNuqptTisS78B+/Hpzqs0+tjSpWqReRY625IKkp2V1AJyN76466XXf9QEpETj6UCohpalIo361iW63bmsyhQXzii3qy54yOlWFo0cmESkfMKnKndJPIfIdKgF8/wrjYs0GmQ3xgfts/Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761505911; c=relaxed/simple;
	bh=+AUJLFop/NP1PqN2N9QlTcoa51Nm9Pq8GtfyWKv+TXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLlLho4kgd3sH+SAdDo7zPPXJLqZ5v5pL5jZV20d1/1r0461Ejc0bqH0uYd1dYGLD8vx48h2G+HwLeQ5Aah2BeZNKM+7VgHIvnem3q49SYvgbJKwj3XDq4O7mwmLUktNluxEJpgHkBKK4JuN1IHr5JdBRjPAXVaLLVzQ8EQupbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TsV2NkG2; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42421b1514fso2644804f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 12:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761505907; x=1762110707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kxkTyzPeNmi6+toC10bTmxd1f4OEXI+mwvGXkJgCrDw=;
        b=TsV2NkG2JgebcKkWKLiKv8x2sIDNLjeEH7lumT9TjYJ/M8RARTIqMtXjEM4YLaw2rE
         89c6zzWOMCi4AMiNVQRNSuDCPXE22V9yuyXohtAq52jadFxS4Y0NleA/NCfrbLHe7eeX
         7w587XZGVC2HaCPkzgn7KC9gfoQajPnx2A4olJ3VHzqTbHRKo9L550TRULkemDNhVhJr
         yPwEOcIn3MMBeBKTFzN4Ck5dzd/aSVqhHQ9HDNpfPjIWcT5XvQrH4a5XrVOqPopqUINi
         mhemGe6rXdqNEuldbmogKrdv3+yi56aGPCg9jCu2iaLHL1HfZ+wTqXqo1UdVI8H++VWi
         CXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761505907; x=1762110707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxkTyzPeNmi6+toC10bTmxd1f4OEXI+mwvGXkJgCrDw=;
        b=c7m/FcmWaGL8U2d+vzBpJ5AWmL6nOT3TAIb7jFblWrvGxyndBnD0zugDb7Qa+/7FuM
         ampdda5ABAfxDUlvvEgoTOSTtUIve9nVbAcc47+PuGAT1/jlUTP4vpPwcireYs96hOiS
         NTOuEtDaFZxWgKOihdPAes/wi3pfKoyFzcq5j+ehoo0ZSJL27ntorpu9KpQW7kLgzplI
         Nv+sTHjawmxRtwIY9nQucM2nkVbipHdSMw/AbQWi8uJkMkCgY/qJFSfea2v+J/WnfuNi
         yf5MrLovFStJ8ygNWuFuOhLjoUfCW3m/HmHiKP4mmVQfI3u3wZTAcFEcAtRcO2Yj0NYD
         gyqA==
X-Forwarded-Encrypted: i=1; AJvYcCVYN7ZSCG+jfDYQZZYBt24DsvoKjsMUrnV5X+LtULNh/fTYRKm2fD8Efzo488Tg0AbRQXwmW9xShaFjAFs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Qo1QJu7csEOAGxwTbh1Kl5FMIvb5IBN5y9qN7d2WTQilktH+
	Ekhf1AVkgSRAuZyVKXK463Jq6cCg0NaNGKCOeSMUYEh3zaa+MF/GToWmrCiXEWNdwBnAATCNwbu
	3o2L/
X-Gm-Gg: ASbGncvqax6ocKfZ0f4MClNK1zmzxq2krYfHIZ2/UNIZ0trWVGdH9/w0gir981AYX5n
	p+EK1G46ashsui5Z4CAzb9zyNBfkNKmX0T8RdBFMn4ofpWq3s2Pk4cbfEWGUbrjPqe9FmMDjOm6
	ltc2aFFCQXJ/kWk7VP7diRQbOk+omcID94wdvkjp6Ubj4jTrT9pHUaFZTlJDPO2TmjGeH6Bp+P4
	XBPYFH9yw8tqPomkfCAjoSgo8DPQpX9g2D0kmXArRWk7k2DnOSofFmBLOMdp5R936Al3MgzRiW4
	mzG50MDHJ97lDmzGTiUAtceDXOLjrSXe63nDrbc13HFN+RaS8fSwzI5PDJ3ZMYyYECjJBYOL/6a
	3SBQNsdXa+5nB9p39re9sD7y7PkXcpT8GL8ZLkf0zxeOE/o6CmVmEin/QMEiCmXQG6aH62GB5kk
	KkPXfePzc=
X-Google-Smtp-Source: AGHT+IHzexoxvDrDvl24BhwQnRe4QdBdByW9rd0vZNY8yvB8WV7YYfd9RJbflJWTepT5nb//VF+/0Q==
X-Received: by 2002:a5d:5f82:0:b0:3ea:6680:8fb5 with SMTP id ffacd0b85a97d-42990701979mr5977601f8f.2.1761505907325;
        Sun, 26 Oct 2025 12:11:47 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475ddd41a5esm44681245e9.5.2025.10.26.12.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 12:11:45 -0700 (PDT)
Date: Sun, 26 Oct 2025 21:11:43 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: Thara Gopinath <thara.gopinath@gmail.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: qce: Provide dev_err_probe() status on DMA
 failure
Message-ID: <qolhxtuathf4go2wyiheptmd2u4nsg7gvlpj3jlzprkybv2hds@wp2clrvcurjo>
References: <20251024-qce-dma-err-probe-v1-1-03de2477bb5c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024-qce-dma-err-probe-v1-1-03de2477bb5c@oss.qualcomm.com>

On 25-10-24 14:35:07, Bjorn Andersson wrote:
> On multiple occasions the qce device have shown up in devices_deferred,
> without the explanation that this came from the failure to acquire the
> DMA channels from the associated BAM.
> 
> Use dev_err_probe() to associate this context with the failure to faster
> pinpoint the culprit when this happens in the future.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

