Return-Path: <linux-kernel+bounces-843975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0274ABC0BB0
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 10:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A228634E050
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 08:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792612D94BD;
	Tue,  7 Oct 2025 08:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G3rSDdVb"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EE92D5410
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 08:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759826180; cv=none; b=OsyiWnc0m1oeArxyI1aGOo3zNvbtmALvTnQGCb8e1J91cJBFMieQbOxDiGpYS8Fes8e0/z1Vx+7abi13XGdG9UTDXK/a7CbDpFQpthOcvJ/N49roltYp7mnxTf0nLgZSY76oNL5XFNUmWAEDFk7+dCGk5BRJ+ZsIZv6AryddCW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759826180; c=relaxed/simple;
	bh=hclHZaPwvU+Or/kgDq9GYsNnRsFBBmjtWca90LyRtXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JoYEtocwkr4Tx7lmpNelKDZ2MKVJxovxvUVhK7Befo6QU4KWV0ahe8TpSZ1IY7U3qgfUTxroUgO0HQMsovAuiXV8+ASKuYtFSLPZr16QCE+KVOUDRnh/AgEfXLGCsTR9rK8Rz58J2vNZBfe0/ysXfflMZizG9PmyooaBUf/XT7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G3rSDdVb; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e4473d7f6so36113765e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 01:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759826177; x=1760430977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P/Puk0DGClgU/d0N9KPCXsJda8f3CNcdxuN1BPXv0d4=;
        b=G3rSDdVbIEkxIEUR5jo4ejt9aPv88tOyhobo9qltV+JH7QORuUESnDPrQkwHOGVivI
         ev7JzUfrlXAZNcnXgRVoywyEzQPginE8TQrKiI9HHW1KXMQ7HygMUtZNBP3XkUyu2fQ8
         aH7WPDF+THlD0CO4ul6KVe2zLVHQ1cmR8x4E1ThgfOMMkAsXQhZb5a/PuoDbaeYeQESc
         7kS6Xd56WuS755Rd+d3izKqWKa6iLAbttfLvgkfeY79rqEm6hqf/eklKvJMYPfqsIXga
         feHu/HJ1TlRzm/bNrCQT0FmMHJrcY7n8dvLRvfDFvXcrfurCdOyEewiedTCac/7peusj
         jpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759826177; x=1760430977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/Puk0DGClgU/d0N9KPCXsJda8f3CNcdxuN1BPXv0d4=;
        b=jAUGKKNhKwNAg1GGNYqNgiEA3XFP7xMZjOJgZBwmUvE2hSX/tV/X/NmfCGtf42YcdY
         qOCEPLjjoOTkL3bH6XzEukwKmMFELVDfx2Cy1GOV3ojCjW4A9eJtkMVXkArtHDtDPJWS
         OCJiWGDNy5CIMQGys1ZynIMYns+jlfNzfeeVU6MCE9fBERr9iKWoVMCRfQymSxFkUl6G
         lwgx7Ey8R72Es/1xSYP8+Cco3RVAqDqsyTsPtQyu1viam6Xp6xKf/xIMDfYm35NyQvrH
         QSH4MMoNgUwrHnH+IP9nOYUwQAQjNXajmoMuSJI1UhYjRhsuqF6nSOrpBXejinTWpUlO
         7ZZw==
X-Forwarded-Encrypted: i=1; AJvYcCWHV2WjLn4BHKbrTq6pNPFjEtXOIdwVEFKXf1TqVci7vTVyP4ttnH7C4KvLvJ+XLgoiwRT31lBWP6Zg8TM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Rob4ib8Tnw9Vgga5ydC70eRlZeYHOHsbrqBYr7dXo3bzJsBI
	deR9MPYooUPjYieStW4Qv3wdwJGA1QD68dH6jRO976EUu4o3E5w8K6VmMALAo6gH8BU=
X-Gm-Gg: ASbGncv1Pc87p+tnR+UT5VuXmHIT5e9iSNB36VM7GrRPdZ6abIvcUK5D0ZugRVvYGUu
	GFVmKy06aytFzK4FXzPY4DsZS/9BquDilR5N2UA2cEAmu/tCBNy443yzz1hfN4BwsC3cAzNy6Z9
	EeEaxO5BNXxAd7Kat9HuDpU3rVznSwhU/Oleva47UxszYD005itR32EWP3r2tenmy1slPJfJZyE
	eaVgKdJXhz7miT4ToqvmzBEFeVMu7fubPhEn3tvkiATnuNXiyjCOtKHXnsWwtQ9kP2i5xHccOrJ
	0YWCYhTt9xBpWffsoPC/nmxLoa5WQiZwVv2Xm6ApbZe4DmZSfQjz4UaCKymCiMC+AD1oAYla+Li
	InM13B/xEiqsxhr62ggjqzCJHBBDzIjJyX8TMPEcM2j5Ecd8=
X-Google-Smtp-Source: AGHT+IGSw3Oke9DIjL+Gqc2rIqeM9+dXoWrNDqM+qZ8Vk9YiyMWaLjloD47BAFLjtVPGVOkVw7GP4w==
X-Received: by 2002:a05:600c:c4a8:b0:46e:4c7c:515c with SMTP id 5b1f17b1804b1-46e711549a1mr93067795e9.34.1759826176991;
        Tue, 07 Oct 2025 01:36:16 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a0241bsm284196215e9.11.2025.10.07.01.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 01:36:16 -0700 (PDT)
Date: Tue, 7 Oct 2025 11:36:14 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rajendra Nayak <quic_rjendra@quicinc.com>, Wesley Cheng <wesley.cheng@oss.qualcomm.com>, 
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Sibi Sankar <quic_sibis@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Bryan O'Donoghue <bod@kernel.org>
Subject: Re: [PATCH v2 2/3] clk: qcom: gcc-x1e80100: Add missing USB4
 clocks/resets
Message-ID: <i4vpoy6bgkclazobrozspxmza3j7kyynbbs5lgdydtfxsk7daq@aqf435db4n2p>
References: <20251003-topic-hamoa_gcc_usb4-v2-0-61d27a14ee65@oss.qualcomm.com>
 <20251003-topic-hamoa_gcc_usb4-v2-2-61d27a14ee65@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003-topic-hamoa_gcc_usb4-v2-2-61d27a14ee65@oss.qualcomm.com>

On 25-10-03 20:14:39, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Currently, some of the USB4 clocks/resets are described, but not all
> of the back-end muxes are present. Configuring them properly is
> necessary for proper operation of the hardware.
> 
> Add all the resets & muxes and wire up any unaccounted USB4 clock paths.
> 
> Fixes: 161b7c401f4b ("clk: qcom: Add Global Clock controller (GCC) driver for X1E80100")
> Reviewed-by: Bryan O'Donoghue <bod@kernel.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

