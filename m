Return-Path: <linux-kernel+bounces-872699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B85A5C11D64
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45EA6567F2D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C750348445;
	Mon, 27 Oct 2025 22:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3PmDVIr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFDF346E45;
	Mon, 27 Oct 2025 22:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761604525; cv=none; b=BrLAHYDbICcneXXwQHmuuWyjwhAkFKahbXKF3xSCqgMDJZ17CKiYC0mrbHlYZOQMoOx5AueoZkNXSwPLUrz1IDlMbcU5secyX2DYeDCWYvkVamEaVoBm4zLksTw5L/3Ewcdzqfz1WJZaELItWh+q8vLH9mwcYGpTQleSo3ZN/2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761604525; c=relaxed/simple;
	bh=3mc6VYIH9+zXVbfurOKwLhCS9Y75h1WKZ+pOO6+zvc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NVqop2S1XKRaBI1Jb8eO0oTmtoEKNqga8JZ3atab2pObpz26LrBVujTvX3+87hqsh4iONPRyS6NyULx0PnIJMTkl6JA9NEMg+bqUM0C1d1+g4PZHqqhc4QryRM/5csmcDc81AAe2Axve8rb5nDTe8Frku0aGeLCUApfNuavia1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3PmDVIr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC95C4CEFB;
	Mon, 27 Oct 2025 22:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761604525;
	bh=3mc6VYIH9+zXVbfurOKwLhCS9Y75h1WKZ+pOO6+zvc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b3PmDVIr0DXcmo0TJ48k0ZuHAxaKpui/SzujPVupaLNKg7GgrW+U0bxLDrxvw6bkZ
	 rfgtBDgpwQqt+Lf2DMQIVa2/ebN8/IkqkHC1UphF9jSnwxyqJd5NU7T4VxldW3XjRR
	 53rC1OUivYbAKwXYHaZOkcq+q1JIJflCQE67QRoJOkOUyvxqPB4M2j5FZnK1JOTqhr
	 4NynJ1rMi51TFzO2qp0JCzDfOfDNHC4+NBhQt2Wd22FdZQoUpl114s6qkLq2pzeAMr
	 f0hv3xhS9aw0Ap6HmF8VpyeSbAeLeNJzXSTz2TUN2crcOyvmf6SSHp6Q63QLn3HXWW
	 7rzvms0VBf4tg==
From: Bjorn Andersson <andersson@kernel.org>
To: konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
Cc: quic_srichara@quicinc.com,
	quic_varada@quicinc.com,
	kathiravan.thirumoorthy@oss.qualcomm.com
Subject: Re: [PATCH v1] arm64: dts: qcom: ipq5424: add cooling maps for CPU thermal zones
Date: Mon, 27 Oct 2025 17:37:18 -0500
Message-ID: <176160465252.73268.12350962000691210732.b4-ty@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023043838.1603673-1-quic_mmanikan@quicinc.com>
References: <20251023043838.1603673-1-quic_mmanikan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 23 Oct 2025 10:08:38 +0530, Manikanta Mylavarapu wrote:
> Add cooling-maps to the cpu1, cpu2, and cpu3 thermal zones to associate
> passive trip points with CPU cooling devices. This enables proper
> thermal mitigation by allowing the thermal framework to throttle CPUs
> based on temperature thresholds. Also, label the trip points to allow
> referencing them in the cooling maps.
> 
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: ipq5424: add cooling maps for CPU thermal zones
      commit: d5e86096feb689c9f5d9aa07c913747ba430a600

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

