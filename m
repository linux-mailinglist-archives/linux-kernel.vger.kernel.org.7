Return-Path: <linux-kernel+bounces-690624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E5EADD9D9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 19:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A7AD5A15FE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 16:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1729236457;
	Tue, 17 Jun 2025 16:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGZ62YGH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159A81ADC97;
	Tue, 17 Jun 2025 16:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750178510; cv=none; b=Qab0/LfpDksU6iivPbEqF+rEcYMBG9t8F27MlZJZCNny8Rqi4rUl3p4ydQgClLWjtptF5JfJwT0Hs9clVrJpDUGgdmRZxV3PEuQfz97dKpfV33HFxIjxsuGrNg8j0UBWG1ZssPxMQiNsB6d5fCB9Im1EDHQD0P1x6VlPlwiOGJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750178510; c=relaxed/simple;
	bh=3deT+Pse1UsDb9IBGWHRo7tZxOhm4Ao/X+bA5Ha+pfY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=s/OfNRjuRjJsxDKobb7774L7KRVmWrNZEGhGuWDFUbddiB1KZzgxnQz/Orqr+4XtXWlZFnu1isn5pYiLqlYGrjfctLzRYsPjmUXNpHAk6ZM1xgbI6pKD3MePyFxnj0/rBOT1XR/WIM23BdRXritrglYUI1pU+Xxjboikfpe0ZGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGZ62YGH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64392C4CEE3;
	Tue, 17 Jun 2025 16:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750178509;
	bh=3deT+Pse1UsDb9IBGWHRo7tZxOhm4Ao/X+bA5Ha+pfY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MGZ62YGHhakSEeW9wUJDW+ExY36reNAOY++1Q1A/gs5PKurpoNP8K3kB6J+g2OfvC
	 yfCvnN049RM/C0jwyolm5JK7owV37sWKSZjQHtVIiFRZVffVFQHNeMZpMbTTAmvOqM
	 HfV8vtRwX7OqkXj5kff9ilr8PFuM+qUc3SzhbZ50FllluclqM3pnMm/qWy8ZMp9fU/
	 gaQqez5yR7te87q1BPS/zkHHXrpDV4guZflICuOBr5/5WsZM/Yf1kI5NUsQifyyuUD
	 sMMyfn+dkr3c/kh/kf0vgjzgY5DodC0tWHNml0DLLWwJBsr+/yFv0fA7J0BcKjzFnS
	 hp0LNZ6Fm4Xng==
From: Manivannan Sadhasivam <mani@kernel.org>
To: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
 bhelgaas@google.com, krzk+dt@kernel.org, neil.armstrong@linaro.org, 
 abel.vesa@linaro.org, conor+dt@kernel.org, vkoul@kernel.org, 
 kishon@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, quic_qianyu@quicinc.com, 
 quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
In-Reply-To: <20250529035635.4162149-1-quic_ziyuzhan@quicinc.com>
References: <20250529035635.4162149-1-quic_ziyuzhan@quicinc.com>
Subject: Re: (subset) [PATCH v6 0/6] pci: qcom: Add QCS8300 PCIe support
Message-Id: <175017850194.43806.878167709542899652.b4-ty@kernel.org>
Date: Tue, 17 Jun 2025 22:11:41 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 29 May 2025 11:56:29 +0800, Ziyue Zhang wrote:
> This series depend on the sa8775p gcc_aux_clock and link_down reset change
> https://lore.kernel.org/all/20250529035416.4159963-1-quic_ziyuzhan@quicinc.com/
> 
> This series adds document, phy, configs support for PCIe in QCS8300.
> It also adds 'link_down' reset for sa8775p.
> 
> Have follwing changes:
> 	- Add dedicated schema for the PCIe controllers found on QCS8300.
> 	- Add compatible for qcs8300 platform.
> 	- Add configurations in devicetree for PCIe0, including registers, clocks, interrupts and phy setting sequence.
> 	- Add configurations in devicetree for PCIe1, including registers, clocks, interrupts and phy setting sequence.
> 
> [...]

Applied, thanks!

[2/6] dt-bindings: PCI: qcom,pcie-sa8775p: document qcs8300
      commit: be84da3e19666da5c43c5c4ad86eff456510bd77

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


