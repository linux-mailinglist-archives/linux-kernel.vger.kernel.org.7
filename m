Return-Path: <linux-kernel+bounces-648483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7BAAB7796
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 23:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 860569E2F9E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 21:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF76829713D;
	Wed, 14 May 2025 21:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obdnExe/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2F629672F;
	Wed, 14 May 2025 21:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747256658; cv=none; b=aDgxwsRHEaisLVCPrH30SpI0fMDDhP1oLekLoRJs09zC5zgDyKQ21c+zCc3Glq+ySxs+tL7PnPSwS4hwfkiHnK4piPttrjPmz7LEKK9n5XvnSEKqBucQFm9or1HT1YZYqt11c8Iv9ausi7wXUaqwKqTx8VjRVwC1rR5MtnPcenw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747256658; c=relaxed/simple;
	bh=/lDGsklcLu7DIIGn7RXN59HEYU8MZchhPb9gEng2K1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tt6ea1DLUml8QUZneL1nCyoA6WhxhFlDckBEw19wmJahIqDsS/3kFpYjuWcu1db6zzm0CwqX7SieFOMuAjvFybaBVG02b2tDr4GsD/rkT3RPOYn+tyhdVOzLoiFPaI4LcVNcUdyHpJZUgS2WXh244tBxXp+Fq2hbaw4ttzqEiu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obdnExe/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507CDC4CEF2;
	Wed, 14 May 2025 21:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747256657;
	bh=/lDGsklcLu7DIIGn7RXN59HEYU8MZchhPb9gEng2K1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=obdnExe/x0/f/uEMrPBCkf/WLoYTHe5yfkXs2o1pu0MLA65VtpQkyM1qzXrrBiGST
	 zpp2wkJJAaLcbii/qJxeO82e8WhPEivXvQoznbdmGdwXGc+Gi2pOVjOvWqjaUtJxrq
	 SDv4mVcLp8P5MaPPIluASb0cclZk4DgolZxXFaVWYI5KFYACid3PLTpOVagIjbkKM6
	 rvn/Xn2ZXa2LINZqZ2EKoat6tahdkxsGPh7dSumpL2JQANyjxPHUu38wYUbPV7SAkR
	 8ckpGYk/1QBlCKqDzRLacxtP11M0Q607GYT8/MbOuewWQ1Nw4hL0IVZh5MvopPF+yn
	 KbqQpHIuhH4QQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nitheesh Sekar <quic_nsekar@quicinc.com>,
	Varadarajan Narayanan <quic_varada@quicinc.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Praveenkumar I <quic_ipkumar@quicinc.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	George Moussalem <george.moussalem@outlook.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	20250317100029.881286-1-quic_varada@quicinc.com,
	20250317100029.881286-2-quic_varada@quicinc.com,
	Sricharan R <quic_srichara@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v10 0/2] Enable IPQ5018 PCI support
Date: Wed, 14 May 2025 22:03:46 +0100
Message-ID: <174725663046.90041.649453939299816108.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514-ipq5018-pcie-v10-0-5b42a8eff7ea@outlook.com>
References: <20250514-ipq5018-pcie-v10-0-5b42a8eff7ea@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 14 May 2025 09:52:12 +0400, George Moussalem wrote:
> This patch series adds the relevant phy and controller
> DT configurations for enabling PCI gen2 support
> on IPQ5018. IPQ5018 has two phys and two controllers,
> one dual-lane and one single-lane.
> 
> Last patch series (v3) submitted by qcom dates back to August 30, 2024.
> As I've worked to add IPQ5018 platform support in OpenWrt, I'm
> continuing the efforts to add Linux kernel support.
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: ipq5018: Add PCIe related nodes
      commit: 18a5bf00a02ca54d51266b861518f2844c4f08d7
[2/2] arm64: dts: qcom: ipq5018: Enable PCIe
      commit: 22667f0b306f9cfa0c5be20166222f0e66272533

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

