Return-Path: <linux-kernel+bounces-884857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4D6C3155F
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 14:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9463F4F46A0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 13:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D45C329C60;
	Tue,  4 Nov 2025 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YFKkKFxn"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B235328B65
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 13:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762264571; cv=none; b=T6w5stxeW0DROAouA3wh23OdtbABxbR2kvNuS9KKO60d2xDUIUMcSXUpl6yZ+SzOtAfrg6zFv+9V1txIjLJrmVMrKMnHRqETFs527PAQdrKGWlXZwNd++jKgWP1lizVyCIQfo+oXKDXf5eiu/CQr9GbS4H18mllGUzA7CpCc3mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762264571; c=relaxed/simple;
	bh=Nk+e5LhOXq+Tmrjv3KNGu3kVW3GltI/oydlbegPLvhs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=XOCoxg2/MIk8Wlzf8dT7OUnhMN/iFlH1vWp3koSipn7GFqscclSi8XvH2aJSLpGI5cXo15wb2O20Op1U7WLwnm5eMD9oM8WcAHxIsAT7rsFD9NwAsGTZVWEypd5mQoXwQ7EdWCXQKgf1qkrn88g4qhUkeaQPQUqpaDhN5t4GVOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YFKkKFxn; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-640b06fa959so4275076a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 05:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762264565; x=1762869365; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9xqeXfYjcP291VncmE7WWBGfjBpgWY07soqm4ctLrA=;
        b=YFKkKFxngWlMvC/yByJlU1jGogG12tAIMhGG7cnibFQZqlmgtrlL2f8s6K1LIVhP/2
         Zr9RTqMB5HWcAG6uzSeKj1ggVZdVk1xLl/21+fLBRwctJAh0NFGQextCA8jZmKXKgEVf
         e3GHlm4PBiOUnyb5ldz1pY+qF+cCMm5QANxQBe61t/Fd3eNE9cwdMwgnSOAKP2ay4sZg
         3H0ajljobZ17yvD9HHrWlAojaDXte8U6ty2atAW+xtZEfMTj8XzoSwRzLYFIaIIoK1JK
         bltEtsSG/yAkQK4B9RH7mdRU6VGdCIjAP+05aBLAjhowjlEM0URTFzIVG9zxVbPsWJio
         7tAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762264565; x=1762869365;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/9xqeXfYjcP291VncmE7WWBGfjBpgWY07soqm4ctLrA=;
        b=f6ECK+7ZM3jVity62Dee8Dq251rM2CDWTaJVCGBUUSGzQ04fb6GwY9TeRi2blJbPZ3
         ja7BfZcJ26FEQLqJoNAp8xOubhicshBGFFbXNWEQ/iXLbWrRgLbPTwqMKD6AsoMoifri
         AR8SbTSjZRKTK/iVc3AcOmJwJeek5Ru+M875KQmIjlzu6oewHirQxrpp08jJ2197fHIc
         tJuGmn7lAneb50+mhN3W7ygwcSmaZSRz0DgZWeSslYNrtkMAqYa3Qbp8I57XxWHRfFzK
         u5O/bamwBx5ExkU2KK9gyWbXlAlOlIvRrkgEnQgDwiRmyEiqaqxbjhsnDgYZWIlrXdlt
         EMeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlonYC+APWyP8IsH5Cx+zfLDKtOeeB2tTjDiuN+yqSgHN/ZM48O9EmDB1LY2Ngudet/EhsDwwoRCLzarI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFVRmx2l4j5oOEBsxkEecIpWhpNbBCZRVdQ2d2UGvWFAkYl/Xz
	PJZMxTmd6H39WE73/zVQ8SJCW8UT4DqXdEsPj6KrRuJON7Mwfb+9U4QpKy3IvMhKTec=
X-Gm-Gg: ASbGncsuzosWqBAXWGNR7GMFXCmjI0p+NZt8lkc8LwnlXMlwQ7Kpx2/2DS6WoRPTeYa
	gJnQ6gnCWTvA3jg95qSzcWtuC1wq5k0YUdw5Wm6BLRRZh9RfzfzLxsnrn0PJNCojdDHUGVdVFrK
	PftkQ6pnX+6WwIEeFNXhgB3eAQf0SJQLOWS+p1FI8UrRdoIJdpFPmlTzN/cyiSavxZjNKhI/0fD
	mSZO+WJkPgCr+ZO/gYVyvJ5SHzwgRIYiXtqcKBbGdOjb7q3nFPWcj9LE6wvWP7hYdD+iP/mGlfQ
	uXpFml1o5fGOiEMuBpk+sBPjfvhlvVYv5cM7CQhT9XFoQV6+HX6sjhSxwacC8B1l0Nyq39IPitv
	j3KLFS9IAHSTnBqr/uGSba1GbWv3HtKrIpQZDeD6Ufsjzuh1JwL0kel60eMaD4kkbGErFi2Hl86
	HaEbQ1O4DkWHCI9g==
X-Google-Smtp-Source: AGHT+IHg9hzENV90vT/x+1SvpgnGo7dcxlkRT1qTgL5xvtzGvp0xcgTMKZtHtHlnlzzokSRFGidBrQ==
X-Received: by 2002:a17:907:608b:b0:b2e:9926:3919 with SMTP id a640c23a62f3a-b707018c40dmr1622075266b.22.1762264565514;
        Tue, 04 Nov 2025 05:56:05 -0800 (PST)
Received: from localhost ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723d6f273fsm215301566b.17.2025.11.04.05.56.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 05:56:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Nov 2025 13:56:05 +0000
Message-Id: <DDZYNH5X7EEQ.3TSTRMMMIXUSD@linaro.org>
Cc: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, <cros-qcom-dts-watchers@chromium.org>,
 <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] arm64: dts: qcom: rename dtsi files for qcm2290,
 sc7280 and x1p42100
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Bjorn Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>
X-Mailer: aerc 0.21.0
References: <20251030-rename-dts-2-v1-0-80c0b81c4d77@oss.qualcomm.com>
 <176210698627.937813.1347882402480558851.b4-ty@kernel.org>
In-Reply-To: <176210698627.937813.1347882402480558851.b4-ty@kernel.org>

On Sun Nov 2, 2025 at 6:09 PM GMT, Bjorn Andersson wrote:
>
> On Thu, 30 Oct 2025 20:20:12 +0200, Dmitry Baryshkov wrote:
>> Follow the earlier example and rename several more base DTSI files for
>> the platforms where we have (or expect) several SKU ids for a single
>> platform.
>>=20
>>=20
>
> Applied, thanks!
>
> [1/3] arm64: dts: qcom: rename qcm2290 to agatti
>       commit: 021df9dee9cd63eee1cfae1bb2381db11a1a45d7
> [2/3] arm64: dts: qcom: rename sc7280 to kodiak
>       commit: dd6edcd7d3e42b143a2f86e8d30ded62106a8972
> [3/3] arm64: dts: qcom: rename x1p42100 to purwa
>       commit: ef659a5bd91bed7fae2c2a150f8ecca06599ac03

FWIW tags/trailers are missing in the commit log:
https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/commit/?h=3D=
for-next&id=3D021df9dee9cd63eee1cfae1bb2381db11a1a45d7

Thanks,
Alexey


