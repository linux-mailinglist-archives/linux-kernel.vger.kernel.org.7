Return-Path: <linux-kernel+bounces-779943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DF0B2FB99
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FC17AE3F10
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7A023D7E7;
	Thu, 21 Aug 2025 13:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UzSjDFX2"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8A52EC578
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755784056; cv=none; b=Z/eP4s5jqIjc5bTBtDUbcymbL/GpEG0aPn0ZSKnx9UaUH3BFoisjf21TcApnA959LlKtqmwR97zSbR8TnPUOdUdWeid3z0OGKd/Ph/HbIo4DizTWpTpkthKUsk7Eo5xWeS+tYVXxco57SOchZwDtacUhefnu7sUghmmrCLBPqBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755784056; c=relaxed/simple;
	bh=HKdq5zrnBFDA5jHszrIlOFxSN9mtx8yukFEXWRNwoE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESVk2wmEst9UJKJA67sEQPLCnwb6KgxlAFP7buhixgHxCPS2LHgHfM+JSDQU7HWa1jCd4WgjLkcMRtl7qeQcL65JeWqc9mObIFstF5G8DUelvwRmUiKoUMu+H8CFuGm+DtW6+7dXykjaeEYQNozFJzh5kNOsF3cexh2/PqSruiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UzSjDFX2; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3c43399ea42so721106f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 06:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755784053; x=1756388853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1cNqt6F+utCAzBkTSdbP3iFxYXyHm8glU0KYUD049Co=;
        b=UzSjDFX2JC2iVIfkV7SrLRXUGI8MA3tTT/ME/ryo7U6g8qv1Kosb3WlElqeccU1XGq
         r97/ZYwb9yGrNtrXTYUP0XDUxIVhpzViS4T3LS6EQ7OX491epL7mnG/aVohXxQaBTXob
         tgDasAA5sXILXmRuj5oN2F3mxN82V/DiqmwkEHApEK6AwsZSGOa4/g5q9yvH3lmkhWaR
         uAobFMCvDju5bEuu0ypmFiUlkEdomayEi2/BPtOuWPjcWDftBe5b2k1BQV1/3Sbv9gWS
         y2KF+j17YgtoA71kDExi+jTeCZLSG4bV2oh7rI1fxIGueuPDccn5d00cDux6VSJ/yqH0
         2egw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755784053; x=1756388853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cNqt6F+utCAzBkTSdbP3iFxYXyHm8glU0KYUD049Co=;
        b=EQ3gYIQ5hKgu/AJDz+3QKDDR8TMH0YmTlBdgku5/2Ksltai6DnlpxEVVrefuVNhoQJ
         cIyxX2/UYW9vhMuomfWov0v1fnsP118jcAZdiF4N8BMta1SLe4h4VToBw/8ctShRTGSy
         DJO9rl7BCWtn0+H8mbocBR5Khm3bZDtfjrb0nJg3pCeXp/iT0MH9kCqwWCgYJFfICun/
         BwtvxPyL2WFd0tMcLv38IeUKD0FM2ZWGI0DbBmEXK0ZgV36dFy+Nj19E687+s5zFjiy3
         jZd8eglJfgwWIH9sLLcftPiMyq9g7C4GrvF21W/g5TYzDGyUxTOKeRMu77NhtfIMGb7+
         SiOg==
X-Forwarded-Encrypted: i=1; AJvYcCWiIq+7d1RpMxsQ5IG3riBS7vjtyB1hqZYaff1wg5B6rOvMY6kxv1jjwoTiAplmomDvLgfNDu+G4ixYAv0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0fB64doBjRMEH8M6NmyBfz7jH59I5eHHSRpkqlyGlTkZequf6
	oTOCnanoFgeDLDhB2DoZmF+Mb6BINdsH5IVHZzbyawBgr4KSSHFUxc0NGiEpoYFcv+o=
X-Gm-Gg: ASbGnct5rkszXtEzRZQ4HOAegMTlipz3b0MwwC9ClIz/pN+IGnD8ztmQilyvyS60IUu
	9I6Y/YnYrmwE3h8282rqluAqpJYBjXMZa1uBjSR4zP5uOOLVCujV+LKvZ5ZWFgWBW4EvsugktVW
	R8/obhft+h//vh5fl8O8bQ769N4lWuYb5dkrU9qPW0RTIZpOLkIzeHWNcfYsisw0MAoeCuncfjF
	lm6vGfghoYIXQeZlfmtJTtg0klZLAMnCF/7fvfuJq3KgeZxBnFS0yR9vrX1ndRIrh37tXk7Yxgw
	VcvNCX2hAsl6Qj9k+h5uItlqkdoNQSTGSrFlWM7Wz8GIHnL7tVCKZHztHCveuHNcINxIwlWGrtG
	JeLnvxv2ortg13Qd2NhCdaTB2cq3VIOs/mA==
X-Google-Smtp-Source: AGHT+IGRsCsNTbh+Ry1lq6ZEMT9N9yWhON8/4j1DFbRCkoRW57mS/7ADV8FIQiHZDBWtT7+21FMWQA==
X-Received: by 2002:a05:6000:2282:b0:3b7:9c79:3293 with SMTP id ffacd0b85a97d-3c4978384e3mr2380212f8f.58.1755784052676;
        Thu, 21 Aug 2025 06:47:32 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef30:6153:383:a3fe:6207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c0771c166bsm11846370f8f.33.2025.08.21.06.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 06:47:32 -0700 (PDT)
Date: Thu, 21 Aug 2025 15:47:28 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/14] arm64: dts: qcom: Set up 4-lane DP for sm8[56]50 &
 x1e boards
Message-ID: <aKcjcB9yABjEv1KR@linaro.org>
References: <20250821-topic-x1e80100-4lanes-v1-0-0b1a0d093cd5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821-topic-x1e80100-4lanes-v1-0-0b1a0d093cd5@linaro.org>

On Thu, Aug 21, 2025 at 03:37:19PM +0200, Neil Armstrong wrote:
> Now the 4lanes support in the QMP Combo PHY has been merged in [1],
> add the required plumbing in DT.
> 
> [1] https://lore.kernel.org/all/20250807-topic-4ln_dp_respin-v4-0-43272d6eca92@oss.qualcomm.com/
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Neil Armstrong (14):
>       arm64: dts: qcom: sm8550: allow mode-switch events to reach the QMP Combo PHY
>       arm64: dts: qcom: sm8650: allow mode-switch events to reach the QMP Combo PHY
>       arm64: dts: qcom: x1e80100: allow mode-switch events to reach the QMP Combo PHYs
>       arm64: dts: qcom: sm8550-hdk: Set up 4-lane DP
>       arm64: dts: qcom: sm8550-qrd: Set up 4-lane DP
>       arm64: dts: qcom: sm8650-hdk: Set up 4-lane DP
>       arm64: dts: qcom: sm8650-qrd: Set up 4-lane DP
>       arm64: dts: qcom: x1e001de-devkit: Set up 4-lane DP
>       arm64: dts: qcom: x1e78100-lenovo-thinkpad-t14s: Set up 4-lane DP
>       arm64: dts: qcom: x1e80100-dell-xps13-9345: Set up 4-lane DP
>       arm64: dts: qcom: x1e80100-hp-omnibook-x14: Set up 4-lane DP
>       arm64: dts: qcom: x1e80100-lenovo-yoga-slim7x: Set up 4-lane DP
>       arm64: dts: qcom: x1e80100-microsoft-romulus: Set up 4-lane DP
>       arm64: dts: qcom: x1e80100-qcp: Set up 4-lane DP
> 
>  arch/arm64/boot/dts/qcom/sm8550-hdk.dts                     | 2 +-
>  arch/arm64/boot/dts/qcom/sm8550-qrd.dts                     | 2 +-
>  arch/arm64/boot/dts/qcom/sm8550.dtsi                        | 1 +
>  arch/arm64/boot/dts/qcom/sm8650-hdk.dts                     | 2 +-
>  arch/arm64/boot/dts/qcom/sm8650-qrd.dts                     | 2 +-
>  arch/arm64/boot/dts/qcom/sm8650.dtsi                        | 1 +
>  arch/arm64/boot/dts/qcom/x1e001de-devkit.dts                | 6 +++---
>  arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi | 4 ++--
>  arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts       | 4 ++--
>  arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts       | 4 ++--
>  arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts    | 6 +++---
>  arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi    | 4 ++--
>  arch/arm64/boot/dts/qcom/x1e80100-qcp.dts                   | 6 +++---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi                      | 3 +++
>  14 files changed, 26 insertions(+), 21 deletions(-)

Nitpick: Could you send a patch for x1-crd.dtsi and
x1-asus-zenbook-a14.dtsi as well? :')

Thanks,
Stephan

