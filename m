Return-Path: <linux-kernel+bounces-819800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D7DB7DC2D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3950327373
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 00:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCEB21A95D;
	Wed, 17 Sep 2025 00:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOLqJGkC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9A61FCF41;
	Wed, 17 Sep 2025 00:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758069908; cv=none; b=SuZUJ723WSg2zqu0jBBPj+Qc+sCOv9bU70tlGVGxtMBqvUENhkanz4D4YQTK4BcWJcW5BwCIBKMfhifTkuNDo3rs4tADTLLul0ZKNaDveuDE9t8JJd/4guOvZljFTYIKPGwUXq4OkLvjTW8js5cth7/uYk7zU9ecwKrxJ6nRzqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758069908; c=relaxed/simple;
	bh=08aKrV6uZO4aHBNX8HBlFZTyzEGL/6BQESJFuei9G3g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mhoz7HECgrNrEa7F7i4pyaOwqXV/ad4MrpG9WR77lw6nD++X6+/SANaEB7fZW+CkFRQUia8k03DJ4fv8+jgmbIvzXZQclHbdeLOIwnjeDmw/b4HYh11wSV2vusVnZAhcAnJeF5m+3Nx3Ih4q7YG9w3061p3UnkE+QD9gufqPNsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOLqJGkC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF1EC4CEFA;
	Wed, 17 Sep 2025 00:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758069908;
	bh=08aKrV6uZO4aHBNX8HBlFZTyzEGL/6BQESJFuei9G3g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kOLqJGkCtUjqaSzJ4EggQAq3NVsheqjXtqwxn/c2fMxuM81QlG+d0Ur1PsErWODhe
	 gIzVr3gJATSLFQ3jM18v1RUm9kv4AER6GnOSSRvcezyJGrt4bCq82S5K+js9Rn0ecu
	 YF2VvF5XIOr+FizFpom1R5LW8I1y2dzqL43rwDnmyr5eGmEbwVWUzK2Ki4IrHHtP91
	 OHc/qEVil2LG2DUS2DRjyMzIxOtEiwjgfeDiTw7wd3Ewcbv5E5LnxFZIbEhAxGqW5X
	 gOfhXsT5rBySvpgOdr4C94gMxFpwNvEBqWjCQHjArgJjEE64rDkpWMQjZI+er2DaLj
	 1u/SyAMD3O5/w==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH 1/2] arm64: dts: qcom: apq8016-sbc: Correct HDMI bridge #sound-dai-cells
Date: Tue, 16 Sep 2025 19:45:03 -0500
Message-ID: <175806990241.4070293.6685476941445915035.b4-ty@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250904084421.82985-3-krzysztof.kozlowski@linaro.org>
References: <20250904084421.82985-3-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 04 Sep 2025 10:44:22 +0200, Krzysztof Kozlowski wrote:
> HDMI bridge has only one sound DAI and bindings already expect that
> (dtbs_check):
> 
>   apq8016-sbc.dtb: bridge@39 (adi,adv7533): #sound-dai-cells: 0 was expected
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: apq8016-sbc: Correct HDMI bridge #sound-dai-cells
      commit: e36b9782fafa4502bd2d3e2aaf4fbf425e9ca908
[2/2] arm64: dts: qcom: apq8016-sbc: Drop redundant HDMI bridge status
      commit: 24f8b8ef130b7249684948a2a82318476f7ab11c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

