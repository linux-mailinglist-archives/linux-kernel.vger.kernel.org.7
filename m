Return-Path: <linux-kernel+bounces-767722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD50B25810
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 02:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCE9D72850E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 00:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF0BAD21;
	Thu, 14 Aug 2025 00:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gDBjSgkH"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD9C2FF64D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 00:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755130222; cv=none; b=C1QanZX1lNzZ5CZXFileBiQGabYPQynHgFlQZI6rLbq5TdDegzaMaUDCL3EyjzJ2NvLo5kl/G3mpk+vj+Cbjwvo/B0Fv0U7UbrOIQ9FLy7CXLNrxds7vwuuzcPYJyuqDy/m5JYi9kGy/oLMfAGqD6+31EktQ6f8BZVzgMwXALNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755130222; c=relaxed/simple;
	bh=r1QCrmN8tVo4aJpeIo0LUvhjUnUqAZ5cDFytjwJaPAk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=CKo+YCih4h4OVfgfVXXZDD3TXXYmydrKxbML4c+F/W8UGAQm3swffJjOJrIsiUDVUQ75Q+sw1JEDpQm1KQhr+raHjPIdnfy0D81IOsE1fmhpTfRgAHuq9xjcXlkv6KkyMBoLPQqwS8Fgg/XuqXeOMvoTGOa72H8o3DgmVAEXEto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gDBjSgkH; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b9a342e8ffso266748f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 17:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755130218; x=1755735018; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpKIMCug5prSO8UBINdYvWrP0TkGisSi9mxT6awdEX8=;
        b=gDBjSgkHkE1DcZ8ecoJHcRpsd84Odlscj+9dOKuA26g4J2691NnFt+59dIajYA0rkJ
         uDN2O+Mvm6uS9DXHJv3Ft8pDKkv5DC/JbtNVENuU+mmpwCh2RS26vdIWBi8f/3qJTPb6
         zE/2ycRw6wBtLEKaMCXgrpYkHpVEXgAU/eH+WuJAr8xOIQ4x/rbM1dbJmG0AJ6PWMKKF
         sehdD5KELkext8T+V0+kOh62Zkl873v1zqojpKFKjkenBb/dh+QfB2vnHkGEPI0mymfs
         AiEYhDSvPaE8G5CD1kBlui6YUsXIPvBTqzqtA8wW5A33cp/IsUKqARWHfRDIyjyg/fGx
         /WXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755130218; x=1755735018;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gpKIMCug5prSO8UBINdYvWrP0TkGisSi9mxT6awdEX8=;
        b=CL2YqJ6JDU5QvFup9223bAHsa7tf6AtWe71+Z3LmP54xJfObdeavPpTf53xGidECMm
         YuSDU021qMjoT9895mL9p3ZkXpmuBKWjiR29a9Xkh6/N8+a7FkdACT5LM+kVTkg3noCx
         WExlLQmu4VxPWTY5ySSdyCrmWsFipq1zZkn3UseauSG/IJBbMBxMzsWfRthku5Du6gWg
         neWOmgUyy5AFPnQiJE3dGF5GnLLUNZ1e2Eza+Pf2yLBv3UGewkrzRHjUiXrwSVWLghQs
         I1usqvyI1Me06Rah29mVR1wZ90Irph0pfZxOLRJpQ7ko++5w/FGHUosY8zBe563mn/Vi
         K6dQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdkBrk+nlwO0i2B9uvqp36YkctME8uathJSh4L625EvQg7wfHMLtv91hIIuydkv800XL+ls8xbRg0+6D8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLoTsyiuxHBf73p/pwPRMZPnqW2pDW8k4Fd2LYcXKgfvr93JRe
	M909hXxg9OEX4bid2HbueZ4ZuOTFzTWD7kUwjQBv8bqL84mEI0eTsG2hofNkHjkrtv4=
X-Gm-Gg: ASbGnct0wPOmkBmHQ28myOdoSgRw97ee6ITdxVEhqmhYq7nnwEYdvCuvegmPCL5m6EI
	um98t8yP7jd5l9RqJILBqb30fEYroXO5W9YotDqzI06ideQmxo09OJQJTmS57OSVy32tAov6oH6
	hVp8NF9N7+4IgGsLeJMWs3SKHpHurhAUtO0hm0awcN6H3g6fgP1ERt1egHGdd1qRdnPxOdghBVs
	gyY16Q+osGnToYAkbywDF2iCCI5RSmp2zKSRMADu5FqUt9tLKdHWGML9HzGU/xUbK2nvjfhD5SZ
	ncm7BB3LupfHLp7XrrEBYmU3p+GDdIf0QOICfWayxVjB6aZ6tsbd9d8cIp4T32D8ryIyI7kY4Qz
	f2zf6TMDj0+OnQnU34yP+yFNSX1E=
X-Google-Smtp-Source: AGHT+IEL5c2Xg+0dBRlOrtdb9SKnnns8CAIkWnJ+rAhdQ3/ikKH0DsK1f2QeK/B8eUDvA0MAmimMfA==
X-Received: by 2002:a05:6000:200f:b0:3b7:908e:e4ac with SMTP id ffacd0b85a97d-3ba50662180mr342068f8f.2.1755130218457;
        Wed, 13 Aug 2025 17:10:18 -0700 (PDT)
Received: from localhost ([2a02:c7c:7259:a00:7f3a:5ab2:26aa:831f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3ac093sm51686067f8f.9.2025.08.13.17.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 17:10:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 14 Aug 2025 01:10:16 +0100
Message-Id: <DC1PQIF1FR6Y.JO8TBH3K6TS1@linaro.org>
Subject: Re: [PATCH 0/9] arm64: dts: qcom: x1: Disable audio codecs by
 default
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Stephan Gerhold" <stephan.gerhold@linaro.org>
Cc: "Bjorn Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski@linaro.org>, <linux-arm-msm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Abel Vesa"
 <abel.vesa@linaro.org>, "Johan Hovold" <johan@kernel.org>
X-Mailer: aerc 0.20.0
References: <20250813-x1e80100-disable-audio-codecs-v1-0-af82d9576f80@linaro.org>
In-Reply-To: <20250813-x1e80100-disable-audio-codecs-v1-0-af82d9576f80@linaro.org>

On Wed Aug 13, 2025 at 4:58 PM BST, Stephan Gerhold wrote:
> Currently, the macro audio codecs are enabled by default in x1e80100.dtsi=
.
> However, they do not probe without the ADSP remoteproc, which is disabled
> by default. Also, not all boards make use of all the audio codecs, e.g.
> there are several boards with just two speakers. In this case, the
> &lpass_wsa2macro is not used.
>
> Disable the audio codecs by default in x1e80100.dtsi and enable only the
> used macros for each device.
>
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
> Stephan Gerhold (9):
>       arm64: dts: qcom: x1-asus-zenbook-a14: Explicitly enable used audio=
 codecs
>       arm64: dts: qcom: x1-crd: Explicitly enable used audio codecs
>       arm64: dts: qcom: x1e001de-devkit: Explicitly enable used audio cod=
ecs
>       arm64: dts: qcom: x1e78100-lenovo-thinkpad-t14s: Explicitly enable =
used audio codecs
>       arm64: dts: qcom: x1e80100-hp-omnibook-x14: Explicitly enable used =
audio codecs
>       arm64: dts: qcom: x1e80100-lenovo-yoga-slim7x: Explicitly enable us=
ed audio codecs
>       arm64: dts: qcom: x1e80100-microsoft-romulus: Explicitly enable use=
d audio codecs
>       arm64: dts: qcom: x1e80100-qcp: Explicitly enable used audio codecs

The subject or title is a bit confusing. "Disable audio codecs" and bunch
of enable commits.
Maybe "Move audio codecs enablement out of .dtsi into whatever"?

>       arm64: dts: qcom: x1e80100: Disable audio codecs by default

Best regards,
Alexey

