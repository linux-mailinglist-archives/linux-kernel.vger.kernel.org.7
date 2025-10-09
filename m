Return-Path: <linux-kernel+bounces-846884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0D4BC9549
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 15:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 27ADB4E64AA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 13:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE4C2E7F0B;
	Thu,  9 Oct 2025 13:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RngzzyuI"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF471F94A
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 13:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760017046; cv=none; b=Ta+a6Y/a7z6HwQptRv5jzRoGez1z2j5VTrj/6PGFIDO5WmPG61UpbLTiaP7OsjCiFQ3ujNPfwHRmWP/0r1fuIkyRUqf1qUlo+K+fXeXOPsqoxWaU1YXnd2CrFTBzFi1VZ5bdeKMM0xTfD61h8l+CLo//rbQHANMnbIsIpYBqBp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760017046; c=relaxed/simple;
	bh=mDYDlD+MEj5MwUVmU5NuaLpTKU8yZWPjWxvcEYawWcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jb7oqrsLMK9V+oF/aUZ7PQ6KO7e+pParLUTB/MP9uaS/K3N646yMhp+m+AJIGrjaDqGJyGFAKe0d0UfMzAIjUuvTGsT+3RDYLnSkT9ioFIEKndjUK5XYNoW/OrUt8ZtuA0bS+75aDTFcmTpdGI26+5u/jGHnS/OuDGvLqBl0onk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RngzzyuI; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ece1102998so594302f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 06:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760017043; x=1760621843; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dq7MfAZyGGxaYmEOpM20FMo+OmujRRkMe061xLULkak=;
        b=RngzzyuIaoez2cuI/KJq8yraoP1kWdrKQ8s1q7g0UqLeag5G1Bh4Tfwve3niLLzRBY
         0FlfjlertMydQFZo8KDNVnzrmcEM2KDLSYKKih56aTCRO2/kvm1eqDAlvbuxWb+m0PhM
         uuHLqbnydb7bzjc6BU35We1YHgJYXijwnHco/Uxn2bH5KLfAUymBwFDa9+scmzJWXxDs
         UKgWa89Sckdnfk8+ziixXFQrUn24megJ/6sZ954+ne32OybHd1b4LIaB1rooG3gmg7Z3
         IZPXirkA3gTpSuJucp5pVBT+ILQRpxdfamhwKD/8qm2Eqa8q0e8BB64u33RKpFCzIjeh
         P31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760017043; x=1760621843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dq7MfAZyGGxaYmEOpM20FMo+OmujRRkMe061xLULkak=;
        b=gbZY7xtEjeJp4Div9bPI4VuLsdm8Clf87cbAWRf9m0s14hXLQPTFmg9T+10Snwlozk
         CpWcqJUlvCvAjl9tpfzXE5JUh/m6EzCb+kt4WWu01h2t3fqyVoJ5GFth5B8PsRxpH83U
         eGOHbeISH/WUghrJgdAv5hbkauEy87Q9kPO5yOFRcsWNWsLjvefCBUE0+//xIzJkWZBW
         MJtShxWfirCpclXqSwMeIUFrG88zy7XCKLggOT3qL/7SP+tXqlY8jI9dBwAwXooNEgkA
         LhlXMKfMTWcos4wpp3oanJPRxB9At35VtNU+GyTFzCYyCWJfBanO7yyIvpjw1sSD58Ey
         /5mg==
X-Forwarded-Encrypted: i=1; AJvYcCUBI4V5JVE5aARKeYhTFkdh31EoC0RgRVQFmgfzpjmhu59495PJRZRhCuukkXuLIJIKadAKwi79Ab5TuI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJYJzK7lPB3zYvuH+HJ0Z/RbrE9rV0fngZvvT9Xr1BLDOAg0UD
	ppH40t0klXwi7LAYJxpUv99y94EyEzon4c9agm0/lswFyS/uliY5HJNbTunPlFOMCjk=
X-Gm-Gg: ASbGncvFiREsDVmp8PkaE0C5H3YQ7b8lvhRHD046oQ/fdfpjci3+WE84V0ovDuW9rUm
	6AcWTahuQqk4XczX2yUFPY0SkXG1p8UfUjeMdbqA4h22RiG1Y4MN2z2KNQ2NBWgWK/nM6ckgBpC
	jQCNE36OeXtC5xqHhMq+CBK9FmVctKeGCFaJjQa068VVBG5sPHrQnHg9L8X8dsRG78gzy5LTzpS
	sukwAaH/nh8ObqMu70pZ6JlAX2nEV5ibjveuITWEfIOcmwdH8Cc3zcx9OarpbeLfRQehkGAdUGH
	7raIprzgF+b20xOn/BhrA8fGu8ZIKvFRhG6sGYdomT3r8oG0TnWu5uq2UXK/GEYswntlw/AB2Yx
	bu+V0Desb4TrxViibxCdH71rlpoiLlLKi9upECKItMNmmKnc=
X-Google-Smtp-Source: AGHT+IFYabcVFHaPLEaZdWVgfaLIPcYjQXcICeP9Ed2Hj3ZjwMcQN94p9RtEMitSp/6LIwax0gqTng==
X-Received: by 2002:a05:6000:1a8e:b0:3ff:17ac:a34c with SMTP id ffacd0b85a97d-4266e8e46b1mr4959913f8f.59.1760017043056;
        Thu, 09 Oct 2025 06:37:23 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f083asm35033794f8f.43.2025.10.09.06.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 06:37:22 -0700 (PDT)
Date: Thu, 9 Oct 2025 16:37:20 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sibi Sankar <sibi.sankar@oss.qualcomm.com>, Rajendra Nayak <quic_rjendra@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH] arm64: dts: qcom: x1e80100: Describe the full 'link'
 region of DP hosts
Message-ID: <yblmrllwwincbchnjcdmsoty53dogkzptmap4jcupnnoqzbqn3@7hc23mopnplm>
References: <20251009-topic-hamoa_dp_reg-v1-1-4c70afa5f029@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009-topic-hamoa_dp_reg-v1-1-4c70afa5f029@oss.qualcomm.com>

On 25-10-09 14:59:18, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> The regions are larger than currently described. Rather inconveniently,
> some control registers, including some related to USB4, are in that
> left-out chunk.
> 
> Extend it to cover the entire region, as per the hw specification.
> 
> Fixes: 1940c25eaa63 ("arm64: dts: qcom: x1e80100: Add display nodes")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

LGTM.

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

