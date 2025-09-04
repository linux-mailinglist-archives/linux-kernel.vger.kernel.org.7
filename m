Return-Path: <linux-kernel+bounces-801053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8EBB43F43
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A1763A7FBB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C50A334718;
	Thu,  4 Sep 2025 14:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yzc3Ahcg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F8032A82A;
	Thu,  4 Sep 2025 14:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996543; cv=none; b=qHL6tysfXQgS2D/Fb3dYJ/YVzzidEIGHa/KaSL2d/0rPOvs8VQ7cVqVHm92iK9dsac4QNI2t3AyN6DMMOwgU8ZNK6wh+6vAS8PgY2z7IaL8HMAveL9ONyCYYn+HDoMzyTQxtd9m4bBvmE0E7oD6lIrgA6k6/2syMsxwYTRrTQYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996543; c=relaxed/simple;
	bh=13Vao6vM05i586BKsrcvJusV4RmB/SUfMB7U/IZm0Zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H2bSOVB+6HxEnrWHzWzpwxBrCjUnP8qwuiFQTtS/FI7VgRuGXoePvzw+q54v5kbLwklnijJSN1EN3Y6zmk9X9YkEx2PV/DWi00qFOu0I0mQDZNxLI9XiHrM6aShSEYGUElb1r1OmpoYuLSbVmLv+nq+0I+zkbBhv3K7jIGjMbQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yzc3Ahcg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371F5C4CEF7;
	Thu,  4 Sep 2025 14:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756996543;
	bh=13Vao6vM05i586BKsrcvJusV4RmB/SUfMB7U/IZm0Zo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yzc3AhcgTVe/+co6Jb1QLz1tBe8Aviw84s/NnVIAvHKov9Qj9Igy3nA/E8VD/Bwmj
	 fz+D2/AFiHVjdEoEFM2Z8mfsW1z10JFeLc26jBvzghbSQ2SVDNRiveYH5Gi5Us358s
	 GAHudjIP1vhYC37Cn9QCEQ8WqMc+dEFKZDcgrbG56Cwk7700bM9UOFR3xjfDyIojKJ
	 dytUFcCQti6XfK00RHoP1RkP6FehDDds2FbGcqQXPkkVOkC8hnQQ2nkhOjO/M0Fcr/
	 tfbhcYDYXkklPAT5o3D0tfEKUy7Q2ywjNlcN/MpzkmL4Bfk6pC1+Sz2ezMv2Fjpj7D
	 HWopX8srJnpiQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Taniya Das <quic_tdas@quicinc.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Lukas Bulwahn <lbulwahn@redhat.com>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] clk: qcom: Select the intended config in QCS_DISPCC_615
Date: Thu,  4 Sep 2025 09:35:35 -0500
Message-ID: <175699653026.2182903.505730012257567394.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250902121754.277452-1-lukas.bulwahn@redhat.com>
References: <20250902121754.277452-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 02 Sep 2025 14:17:54 +0200, Lukas Bulwahn wrote:
> Commit 9b47105f5434 ("clk: qcom: dispcc-qcs615: Add QCS615 display clock
> controller driver") adds the config QCS_DISPCC_615, which selects the
> non-existing config QCM_GCC_615. Probably, this is just a three-letter
> abbreviation mix-up here, though. There is a config named QCS_GCC_615,
> and the related config QCS_CAMCC_615 selects that config.
> 
> Fix the typo and use the intended config name in the select command.
> 
> [...]

Applied, thanks!

[1/1] clk: qcom: Select the intended config in QCS_DISPCC_615
      commit: 9524f95c4042545ee8fc3191b9b89c61a1aca6fb

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

