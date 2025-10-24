Return-Path: <linux-kernel+bounces-868174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E90BC04915
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3870B18933EA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 06:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B2F275AE2;
	Fri, 24 Oct 2025 06:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cA14dYLz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2801924BD04;
	Fri, 24 Oct 2025 06:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761288686; cv=none; b=toqVwIAdcQkSizlWOW6ARfw63eME398bZT1cX0HNjYL7F5MUCDxE6VfeRb5E5Ifi33qnPKh5mMkUp4WbwGyJLwRgn7vEqpz+0/WaIp6Jvut7vEUkA1PWMsa/qqajXZjNEIN1plOxa7L3C8CrlXNwv1I9jo2TC/cYsb9ecn3ZAho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761288686; c=relaxed/simple;
	bh=BGXJbcgR47vbLX0csbAK9SHcXP8iwZy1HP69ARA31RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjhgrw6Gjm4g8O1TRskn2jIEM0Ve85rafZbw5He5FNiyPx+nk0+xq1bVBf7vjJie5L0rrLoF+BBWHhG3Zbpns6Ojc8xngEcXygBzt0A4bbx1u6GbiqSg7cnbCb2Di8BldWnVacmC4EXKUnR7oDxi9h1jSzQKV/wTVYk3z8VO41Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cA14dYLz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4381AC4CEF1;
	Fri, 24 Oct 2025 06:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761288685;
	bh=BGXJbcgR47vbLX0csbAK9SHcXP8iwZy1HP69ARA31RY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cA14dYLzv1WJaCBlakQu2FQXWHIL/B+3yKCN/io/0GZSHqd3q/w6tmxUKrnhHzbJa
	 qQVNVgjjlQAhm8HgX1tMp6UNKDct2e8Yo5u4zC3BE17UzxUv7MCb3xlDGp0FJAMZj6
	 i5xGRU7VHjSk9XKGzCK0ti4nqt/qAvH8MC2cLAlcUZiJppMpKigdc3JFMisF+gYalK
	 p9l9L7Z+4t9uSVV3fAxDeJvBac/VnfC9EYJD2sf1IQxEumWLHQt1ME5YkNJStLOPWm
	 LtKl1tZzrelGjMK6hEbaF0jh1KG6XBp+pvoRZyJw+7isNlvm+imRGj2Q8S88vv85Ph
	 KcKZPMuR6nidA==
Date: Fri, 24 Oct 2025 08:51:23 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Wesley Cheng <wesley.cheng@oss.qualcomm.com>, 
	linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v8] dt-bindings: usb: qcom,snps-dwc3: Add the SM8750
 compatible
Message-ID: <20251024-nice-nonchalant-seahorse-8add5c@kuoka>
References: <20251021050954.3462613-1-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251021050954.3462613-1-krishna.kurapati@oss.qualcomm.com>

On Tue, Oct 21, 2025 at 10:39:54AM +0530, Krishna Kurapati wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Add qcom,sm8750-dwc3 compatible to flattened implementation binding.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


