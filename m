Return-Path: <linux-kernel+bounces-859779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A38B7BEE8D9
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 17:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CA2D189A31B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 15:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0C92EBB83;
	Sun, 19 Oct 2025 15:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gKxaE94t"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B86717B506
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 15:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760888555; cv=none; b=hAH9eoF9uF7W3BLXF2BuxNlsQRp+9adycye38YEGV3tkBoCZIy2JqM/GYmPzMxlV9smD58llh+QKAy4ssCzzSMx6mcC/mkv+qqMPQCoglmrSvxK0iEAZxka/+7iX0hr/UG/lojozAYnyhN5MUq8WudM0iMT+DY05RMX7qUwKyeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760888555; c=relaxed/simple;
	bh=PmZlpEEY0Gy0JFWDFJ6XeXHuOCC0Mcbj7188SWxr2/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8R9ZN+ZA9pK69/olusRUGENKrFSjJXNGfeeljPkhyn2h+ma10lkLCCmNGZUPJMgF7sBqzt8WownBgSGU/RCRv/KX/HCmG0oqCo9YAEs68VmTTUDYrSTLXPXMDJDVTCaX6Zc46caNTPjELH2tXQjLY2oew5PAxT8DM8A7KkliPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gKxaE94t; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-471075c0a18so37460215e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 08:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760888551; x=1761493351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zNWcI2BvDnMLdjyIaXsHEcSmjI5w2/HhMui0bLiWR/w=;
        b=gKxaE94thMAYvR6nKXNpK/F+Od/BuErYt+cdunM+jQlj9cPLNE98sgyQ6z+g4RF6rw
         XDsSllE3pULYq7o27ABIrwo1hn9kZ2RDWqwkZszblxFnft45ag87W/EY2u5asI0c0HOy
         fxZj13hSQ8qCsy/bh7ZPtNKe6o7EZD0XV7n7djZkZqpE6UiehZ4lHyaLJbIMSf/zZFXn
         7TkSQb3hGms1EYNcXaPY+0hnegpYRjAu3Rz09C+asOytXUdyW5c2Bj68Q7R1FiEEc0qR
         MqPAkvyfrfy3h+MX2PUO1FWowJUnf8hjnCF33WYmChMr6waUvpuUtrngHYEOVjJrzOqJ
         QgdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760888551; x=1761493351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNWcI2BvDnMLdjyIaXsHEcSmjI5w2/HhMui0bLiWR/w=;
        b=eHeF+ZdbrLsCwAju+VfJWEcopojS5e1sm8xoy2tjcsTMC2UX97dA59IvKSjqqO+GGk
         ZZxrlIWQbL9pNElpItF8HXfabKmDfOLhFljZW4DII3DzmOTBFc0oQ7IunSDQWSpRrswo
         dnYyBtnd8sqQgbUdGvlgzNaq0xpQSubP5pCTB7xkgqdqlQwxuuz5lx69MT74AOMVu2PF
         VGY046T5xUfF4WZVAGkWIjViLErFmK+hx1xojVYyTdS14sMmGbfXBRqDdhq1i/es9q9l
         oitetVCgxj24TWFOCPolyg7pesgh9cvw3IX/KVqeQaGBL3Fkk6KZlrZCtNv/1czbotJB
         j+rA==
X-Forwarded-Encrypted: i=1; AJvYcCW/k/3wX8jBVppC9z2HRkIthgrTvrFVtymRd6STfcY5C0yWVonww6V/2aHcb5m+zqWG21i4QQNnYAS82OQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1WLikXyizMpMLE9WO7p1pJ7+BsjQYrZWGSZB/Ms60c8qqunWF
	aOHN/iBFbvJclOvfKe5dFzb8jNJvhKpH3CQIeW5+ojYWLBaPT4ffHikTDNU13xVPf1o=
X-Gm-Gg: ASbGncvdQ/n9zdYaQVZcfyyNIzZkB48ps5tO/o/LLXUZSpr5UJ3wMuAX4rFEZEpGwI9
	ocjCmwfzpjxrqCibPezNpfJtG8jTEitxXqu1pzBWc9O8Y/72Vf66ZbNvkSqWYPEEDzVACAcQsHx
	p20+/pGmN4sEFmMt1xVSLEUD3DFuXLqfWwWbCPoSGhbXHQjLFVwjZ2aQFvDTPMmXtya+AT/2R1x
	HkgScxrkaQoYw0xhv3MVx+fMnjN/DiY/2A+p+puKiPd1DIyvU13D2h3i6CPvX5sc1I1sGliH//L
	05rK0FBEOaqYin3Pb5Zih+l9AGoYTDluDbKKmszLjLGQvW7lZ5ULCad5F2ikpb40ZCsLjqT8oq8
	5eBvsSRnpXHsBKgVltK8LycojbMXd946Zahpm01AKs9dtHSXMn9jwWkdjahzr6oMbsqdr21FhE+
	sydzK7cSs=
X-Google-Smtp-Source: AGHT+IGzPw85B5IfdTjkeR5UNt/iOrG4M8XAIOYwmM21CaD/W7Y8OE6WzHu9ieZ+CkuQVu1UuLTtSw==
X-Received: by 2002:a05:600c:3149:b0:46e:4b8b:75f2 with SMTP id 5b1f17b1804b1-471178a7ea5mr64647255e9.16.1760888550742;
        Sun, 19 Oct 2025 08:42:30 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5a0ec2sm10658362f8f.3.2025.10.19.08.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 08:42:30 -0700 (PDT)
Date: Sun, 19 Oct 2025 18:42:16 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 1/3] clk: qcom: gcc-sc8280xp: Remove 85.71 MHz USB4
 master clock frequency
Message-ID: <pexifslihu4oayqkl3b3coulirpudkhud426ntuimwnn2mtb54@dkqiriczitfc>
References: <20251010-topic-gcc_usb4_unused_freq-v1-0-4be5e77d2307@oss.qualcomm.com>
 <20251010-topic-gcc_usb4_unused_freq-v1-1-4be5e77d2307@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010-topic-gcc_usb4_unused_freq-v1-1-4be5e77d2307@oss.qualcomm.com>

On 25-10-10 12:24:50, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> The USB4 HPG says this frequency remains unused, remove it from the
> frequency table to avoid any misunderstandings.
> 
> The reason it's unused seems to be that the lower RPMh level required
> to support it (LOW_SVS) is not enough for other pieces of the pipeline
> which require SVS, which in turn is enough to support a faster, 175 MHz
> rate.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

