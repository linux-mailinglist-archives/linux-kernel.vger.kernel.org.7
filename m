Return-Path: <linux-kernel+bounces-821547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 609BEB81991
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C43C716E94F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A32E3054D9;
	Wed, 17 Sep 2025 19:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2qW8YAV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80CE27CB35;
	Wed, 17 Sep 2025 19:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758137002; cv=none; b=f4eUrRZnE8kdhfiGtX27w9LHxqSV67H8p+kyRa+lKUKoKUbLootpHI8TaNjCChbqNmA1DUbG/K8B97sLK8a9+9e0R1en1a6aPi2vWK7qp/1LADY1EYA/OXWTh12KfGz5IJs3nJLQ7gNIZTraP8fNBN4aL6ZvfmRs8sOGGrcLmwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758137002; c=relaxed/simple;
	bh=qOW7Zmeb4Vk6bFv10n7Qzf8eSn6vy5RSfxhU9LUVEU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pb9JX/WDTzFBPPLqTwGXdjcI3gAZrzxeg/hHNNam3UHUz284jQSje5ZoXg4xsQaUYygZLwvrZpvOsrOphAvbcAgGbqibzXqyucE5t5wvvfcOgSqEY8F8Dr6VkgmLX2fxXdDg9O3aRnUqVmdC5qtZlzgXb95MWfdr3u9xlrouBhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2qW8YAV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E257C4CEE7;
	Wed, 17 Sep 2025 19:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758137002;
	bh=qOW7Zmeb4Vk6bFv10n7Qzf8eSn6vy5RSfxhU9LUVEU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d2qW8YAVtZk8AIUAWA2mDJC5WpChvgAg0/Vgm0qCs+pA9YCCegSJCZl/OviaufLib
	 HWrz6vPoe7F8k1tXE+YudS9KrSq7nkVY/NpxmT52qJwykUyQ1hnDFLTSZ78qOv/fP/
	 KDQF9doM/faq66Dvw2lolJVntXDmBRQzLCTryzT8JXtuo/rwFtaDbIC2WphbvhgguC
	 NyE9ecyTkcoMYtSItWQs/MXw9c6UaEdDfSkBNMWGsD2s2cuOIa6dMeR0xCmGRqR1w0
	 k2jTXOtB75VOzCV2rocm1EjmGB9JMR97RNZ7IkdGWEbclzir73WxUidHYypevdjX0l
	 p9smO6WU1IoVw==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	George Moussalem <george.moussalem@outlook.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
Subject: Re: [PATCH] arm64: dts: qcom: ipq5018: add QUP1 UART2 node
Date: Wed, 17 Sep 2025 14:23:17 -0500
Message-ID: <175813699402.66282.8568877854290348810.b4-ty@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917-ipq5018-uart2-v1-1-f8680bbf947f@outlook.com>
References: <20250917-ipq5018-uart2-v1-1-f8680bbf947f@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 17 Sep 2025 15:49:00 +0400, George Moussalem wrote:
> Add node to support the second UART node controller in IPQ5018.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: ipq5018: add QUP1 UART2 node
      commit: b410d25fb349bc32132749bd2cb17aa17054287d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

