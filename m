Return-Path: <linux-kernel+bounces-779707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1DAB2F790
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46BB35A7B00
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5A3310652;
	Thu, 21 Aug 2025 12:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sYgxJ9uz"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020782147E6
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 12:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755778171; cv=none; b=B1NaYSGGSfNwBbKUJZFgvSqE9h/4mVIZPtUIzauu/9dNw/a27vNytPyTpTORqxBiY9cRBxmv5JVocnSpBEQQfjlFQDEVg+M/ykqkeO4nLxCViACYXvH3fks0J9T7oA0uYQ0eUdEpskF7xEipPSJVcPq22iU7C7NqGEyP22gKvZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755778171; c=relaxed/simple;
	bh=S/Tcj7k1fvyu+MUdyFaMxX8E0mplGdjQTDqgU6HcZaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHlndjWgkJezL/boUoi3827ILcqJaV/w3WOL4dKpcPlLlfOg6vAHqVqS7pH1zaVdLxrVnDlfNUR/MjzZl0lDuT10Nb5pE6SjVl6NkFiHZxWxG7voDZ+aK3W+PsGSB4JcfLNnXqKOxsHf9ZA9qmfzQjCiv8ZVhaJflUOrGdnNQkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sYgxJ9uz; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55ce5253adcso952544e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 05:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755778168; x=1756382968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S/Tcj7k1fvyu+MUdyFaMxX8E0mplGdjQTDqgU6HcZaw=;
        b=sYgxJ9uzihuji64/IdMyt4EHsjShPUBnkNNpwV6QSFqQouoiyH5WAGSungprTE2VdU
         /VmVU8taK1f8z4Zso2slAW4m/3X0/KKFwOxJSw8Vl2tR9VVootqxpL3tCdww7BAeiIpG
         AgdDAd8cgCV0i00B/EY2K+rqF5TXPRfZzKWL57lys6L0KA6QEPN/EuheceL76sXzT1sr
         lOeupQeEEFtovuWkiVE3ZHlbYgwHeNUYI3yy5qfXaKC0HoikQC2AUgy3nflsCJ5xWNbU
         v0AgKif78hAxrQVIMAk5FK/le/Sj4cKOWWSn3pD3Jd0ku0fOpWt6fhgHWkO9yfnf0ch4
         E1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755778168; x=1756382968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/Tcj7k1fvyu+MUdyFaMxX8E0mplGdjQTDqgU6HcZaw=;
        b=mEg6dbciMDUQscIgrDC4vIRl476IJgfmCsvNc1MMzOu0ebzHR4XIkASaSQRhp5og2K
         XKj1BSf+oBX1eutoTMZexaDTqMX9QS+L+01ed6ndQ3vWviaWzX+easS2JyCl5ExUoQYK
         3ncEgrSDKYKfJaRhVRbJg9OilmlHcC5QmPMIXAWeY4RX04eUkl4MRkbVUhoKAeMs0PMl
         m2tuqTiHLodBD3gApIpD/VrkZXfg21Hf714gbRcRt7dBi+qgi0wepLQjK02t+BFVzV78
         ho27pm5gnUQWFoFyeE/aBTDHN346iJmNYVYsiCFc+CIAPjb1T/wOwOoMLLRhp8b+ENUO
         9GCA==
X-Forwarded-Encrypted: i=1; AJvYcCU7yRFODg6ymVNpeU7dULOUcx+yJ06kHUlo6OCFX3qGYTAXD0/D3LyNBNT39gujh5shkCZXHfWauiQQ5rI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaKrAoDmrzax858dS9ALfqCgfKHZ+uHtcAZ0A88BMRmhOHEFBq
	k6ON5UF/KngZ8j6/VHt6OCU5ZNo3aXECx7FkuRJ1kT19iWoDaNuUImf63kVLj0RHvtg=
X-Gm-Gg: ASbGncsuw2kt6cWBYh/sg3e6RQSxGDE1ZpldrPy90bdtOKkkyEiCHDslaAyXR0rrdhJ
	0mTU+y5AGaIi+hHqcWZN9UCiwyUQc599uzhKlXEDvS7feI5PD9sZp7dmOKdDqlii/SmOuhw4n7V
	IIApCE9JybDvOHgD0ZQ8mAC0hvmRIAyMpF9o0G20sk4TcNaV1+0P3FcQc8dJ8mL0cvBnYv31Y+d
	V12UFPqzDBIEykThB5BETVw0jtCzv/0fFVeO8PRZEoqzr16eErdN3ak7LqNXjUaxSi8PTZLNyax
	uxZOUtCJUncCQFse6LLVOphqF6m8xCgRRhawN+3io0Y8oT9BRXygj7FOCu0qQn+5yFqxcSd3str
	44PWVABGwRQ4mtn1RcVoqWau47m8Qp2HJS4+RymtpKdJ9
X-Google-Smtp-Source: AGHT+IGaaCCMTb+GY0WxEiA8aIjR4ryzxzqZ4dp3Zq2ctdGCP7YbQha8ZNnpdix3i4pfLzcLwMPwIQ==
X-Received: by 2002:a05:6512:6408:b0:55b:94ea:1d38 with SMTP id 2adb3069b0e04-55e0d4fb7c8mr825892e87.16.1755778168039;
        Thu, 21 Aug 2025 05:09:28 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef30:6153:383:a3fe:6207])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3f358bsm2991125e87.110.2025.08.21.05.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 05:09:27 -0700 (PDT)
Date: Thu, 21 Aug 2025 14:09:21 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Stefan Schmidt <stefan.schmidt@linaro.org>,
	Hans Verkuil <hverkuil@kernel.org>, linux-media@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] media: iris: Fix firmware reference leak and unmap
 memory after load
Message-ID: <aKcMZ7vTYAOBWuha@linaro.org>
References: <20250818-iris-firmware-leak-v1-1-1e3f9b8d31ce@linaro.org>
 <fe1fe768-678a-48db-c603-2fda3effffb9@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe1fe768-678a-48db-c603-2fda3effffb9@quicinc.com>

On Thu, Aug 21, 2025 at 02:33:18PM +0530, Dikshita Agarwal wrote:
> I noticed that the maintainers were included in the CC list rather than the
> "To" field. please ensure that all relevant maintainers are added directly
> to the "To" list in your future submissions.

Yeah, I had a bit weird choice between To/Cc in this patch. I'll change
it for my patches in the future.

Note however that there isn't any convention given for To/Cc in the
process document [1]. It just says you should "copy the appropriate
subsystem maintainer(s)", so everyone does it a bit differently.

I would recommend to avoid relying on To vs Cc, to make sure you don't
accidentally miss submissions from others as well.

> Reviewed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>

Thanks for the review!

Stephan

[1]: https://www.kernel.org/doc/html/latest/process/submitting-patches.html

