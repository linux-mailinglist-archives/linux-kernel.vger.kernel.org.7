Return-Path: <linux-kernel+bounces-884472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 144C5C3037A
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 10:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDC2218941BE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 09:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D5032570F;
	Tue,  4 Nov 2025 09:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AzSJAZLl"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AD5322774
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 09:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762247578; cv=none; b=JIhAifTmU6kxtzFehCisNeOXFYlh7Qjw3TxuU+kN042DuvyKagpx7e4lrv7YWMDICmiATCPJBVhRnSU7u4G0ENBuh8+EmebUUNz66EcxIyuTd/wh97BgYk4YlR1XZdJ16CywSr41qLTQQnMF+zvfmJvg6nkYSK12O9xpcvGOiXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762247578; c=relaxed/simple;
	bh=LVUCOpp3kgbdkbFoCGBVeo/WTOIJWYE+4SUhoMULWNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rcav1XDIIiTElTFtQVIab2kkWZ3NTOR71Rcwlc0Vc1x8+8d9tE3419zRIxgVO44RLF+WcN3hv45Lo07R/OyDViWLW1ooDVAiDZ7RtUBsZsFtqX5QlEvJoDPO/eekSyVpYLAe0S+Nf6sf9jOg0acH/M4Z1BS06uqFZWCXJJ3HCTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AzSJAZLl; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-429ce7e79f8so1664191f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 01:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762247575; x=1762852375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IclWx1Vbfu2B/23R8qVI8UP1mJRseEjCpbGNldPgb8g=;
        b=AzSJAZLlMqgJWxfj6A/9WCAapDGNkzMuX1EkFCvwousWKQMmr8nQVioLrLEm/FfS4v
         W7DBTcHz+LgAvw18JYc4+MPvvhIe09r/dMQtwBUcrhucHCWYzz+wwecNSto3TPRxxZUY
         l4snKHYFdPJ3BbsFHYnUSOnbkEetzulrBnuAkg1V3kaei7JrasdGOn3jEhXmirqgOmPo
         7BkzaTJ1dqhSH003szx9KMZIptpVAPJRnF2gWBPU5JENUkYYY+SUsLWePHhL2gMVTEQ4
         MltGqAw13OOE8KjOnPG1vxm78USkpdmnF8i8U5RKh0RK2SRWs3YWmTo1dwCvyL8NUCNS
         NrSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762247575; x=1762852375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IclWx1Vbfu2B/23R8qVI8UP1mJRseEjCpbGNldPgb8g=;
        b=mG00QDqNadtbIIN6wceMTyOnoCTLXzlbyQszZf2s43Uw4L1PCGMGSu5brK0KhZOgn2
         r0/+hQcq+e7ZXzp6cil5jjA4eQ46+fCXgk7EcXy/3P6NCNexzDRZp7egkBaN/yFtHV+f
         e20/z9dDkMgOo8MCorj0XMIkFzBhUci3+T3VLCaUsejIM0aVqFR0HMVax7zmw57BknJU
         OVZ0yzkjTcc3X9qpEig++Gov9acms0/SbUUROXfuzuH6l1zuYiw1FSJNie/wAauUoiM/
         o2/p8cC4oNEUCUT99T9pSmekPgq3frgGzjpRVXgCp71XV5EBw8jrh2/Q8Cs6h7GlBqzp
         FHDA==
X-Forwarded-Encrypted: i=1; AJvYcCVQtj6nQivRiDsAzNWq4geEAKXqtK3J3DVVP27kPQeF6jxNAvTSF8PvrGGWbqL6SuUat0FtVB7TLE4ccSc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7W7kTfaNqwjKYt08ziJhLDGI6AvYuWaRtOwtifRV47QB3ezuD
	dW5BTrmT/oRj+EtGJWndYxUMfQhi0eN8koNVIjeoMuAZWoDRu6ZrVTvPB3Mgay11E3s=
X-Gm-Gg: ASbGncucZQPnZk7cMcx70jUuUQCegIMRXPKZ30MGj0zDlhXyh77Dv6ArC8dTTWwYZyb
	WaCs8S1TbCllC9uLRiWUpvqItpuN/TiSVF7M1Kii5sNSkHCYSLE2Nsd3CnsJI3kck0bTBYk9q3F
	iXGFlzcb+CLIiLgQuxFjXWbu/I9qSfazvxLKb98QQvwx7js1SPyWiUO74hRD7AwAyXAFEKVyciF
	ImYRH4XQBp7zsYMvrZEiTKbnAR5P0+vEngP+8IXv2nw+8Q2IahJr5F0UvhVkb4t7jhcpsspgJLw
	B1c7hu4ACB/F9LiT36F06SQck3snCJxnH19xlHAL0+m2h2JMVVeIhSIz85sCBycycUMEZtYDN2O
	GUjY6q1y8tVsaI1L/Il6utrfx0vHE3Dn90B6cH/otVOCUWPMAVyZaOTi2cfEph2WZGYNdu6ry
X-Google-Smtp-Source: AGHT+IF/Pp9gxH4+zOc8gIHpFU6GNskkEvWlylLIg3b30tnX3gqQy97OiEWbEr2mO0tiZsgRD9TuYA==
X-Received: by 2002:a05:6000:2088:b0:3eb:4e88:585 with SMTP id ffacd0b85a97d-429bd6aa226mr13535138f8f.29.1762247574378;
        Tue, 04 Nov 2025 01:12:54 -0800 (PST)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc193e27sm3519235f8f.18.2025.11.04.01.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 01:12:53 -0800 (PST)
Date: Tue, 4 Nov 2025 11:12:51 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: qcs6490-rb3gen2: Rename vph-pwr
 regulator node
Message-ID: <3hecqgngqv5rc2642h46rericsypiyjo4yj5bu4jb5prrxta3u@aax3dipbshzm>
References: <20251102-rb3gen2-regulator-sort-v1-1-908879d240be@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251102-rb3gen2-regulator-sort-v1-1-908879d240be@oss.qualcomm.com>

On 25-11-02 11:22:20, Bjorn Andersson wrote:
> When fixed regulators are not named with "regulator-" prefix, they can
> not be neatly grouped and sorted together.
> 
> Rename the vph-pwr-regulator, to facilitate the incoming addition of
> additional fixed regulators.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

