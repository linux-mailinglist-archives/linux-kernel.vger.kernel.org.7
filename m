Return-Path: <linux-kernel+bounces-721169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB65AFC5A8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1539D17DE63
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676F52BE020;
	Tue,  8 Jul 2025 08:29:12 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4032299952;
	Tue,  8 Jul 2025 08:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751963352; cv=none; b=HKzXV1RNdKhbWuYs9OV6ibrAhLOBX3h3nwHd40jvOyFUyH7pixqyjPVAXSPZAKNMOZV/qGm73Pr+vu1XvSoULkZfe9cp1nZBtFPpd+ZCfpOXqxntK0UBUJBNftHxJTx4CGmJOqifwjhmIrYBv3hd6bJoVPENDv+gJzbAcDh9A+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751963352; c=relaxed/simple;
	bh=fdde0O+qc0A1SzNn5GBogdmdmE1kr/KLgmmzbI1i6yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOIToaCorOir2Ri/cY/Y+bAyCWo9iEh4dJTYRS8wgg2fkmKM6ivbrnAnwU9A3vgiazSykrenC5PYfLXZKKk6joqLvXB9h73wscC7U1X15QgsCkyFLM7JyQ7mTbth7Fvq7NYcD0YUdco4hN0PMvCECbLzxPTns/HJbd6fpJ8tnJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00831C4CEED;
	Tue,  8 Jul 2025 08:29:10 +0000 (UTC)
Date: Tue, 8 Jul 2025 10:29:08 +0200
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/4] regulator: dt-bindings: qcom,rpmh: Add PMR735B
 compatible
Message-ID: <20250708-rich-vermilion-ringtail-ada0de@krzk-bin>
References: <20250625-pm7550-pmr735b-rpmh-regs-v1-0-cab8ef2e5c92@fairphone.com>
 <20250625-pm7550-pmr735b-rpmh-regs-v1-2-cab8ef2e5c92@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250625-pm7550-pmr735b-rpmh-regs-v1-2-cab8ef2e5c92@fairphone.com>

On Wed, Jun 25, 2025 at 11:18:57AM +0200, Luca Weiss wrote:
> Add the PMR735B compatible for the regulators in the PMIC found with the
> SM7635 SoC.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  .../devicetree/bindings/regulator/qcom,rpmh-regulator.yaml | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


