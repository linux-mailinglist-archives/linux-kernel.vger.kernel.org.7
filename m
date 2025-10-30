Return-Path: <linux-kernel+bounces-878646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C760AC21271
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A843C4E54BE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28F236A5FA;
	Thu, 30 Oct 2025 16:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWH5N6PR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EF3369997;
	Thu, 30 Oct 2025 16:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761841370; cv=none; b=PKQv/ZD03s38CziLEPhjiSreolMzV2P3OxkmHNZ6qqpswTytxzgY2OdVm55q/51IbxzqSQ/M7wWF9jOD95w1fPub9y5twQMVqi4B3K8L46UW5qn8kzgSNI6gPLv3y76KdFJWJ2d0brfAWWzJR6gC6NzLRm8gj4FTyfjyy6NEKxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761841370; c=relaxed/simple;
	bh=Ag31N728bxunSc2tqeOYqe+eHadaC/qV5kJuRhFzCFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aX1uyttUMk+RHsDy2nCRdEzWPwnGDNyPupBy0UYhCSZWDAe7aM6OKrBRyX986okYGrMyjYRkDpxnmbwZpsrrNc0Olf6+leriUysYT60o//2JrZVKsMhMEcLwZ/BSMS1ViFI/iFKI1hfJ5qcaikzN+3ofKVe5HI1OG18JLkRdOHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWH5N6PR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15A7C4CEF8;
	Thu, 30 Oct 2025 16:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761841369;
	bh=Ag31N728bxunSc2tqeOYqe+eHadaC/qV5kJuRhFzCFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TWH5N6PRVFw2lT969IYxjSBoHNcD8v+w+V96AtI8/3LpRPaJLcsc3BeT6/yXCk3T3
	 iy0bcAOfGda9+4iqHNutCsRFHe1OdeWvH9Mk9lkebgUlWsMkbNOc9XRyHtOWBVayRn
	 FsYWou9sn3wH4U9Cb2cjs1p1jega6aXNVfdI0Xg52PjeXFRRhQ5XmVvyvENFtSO7dN
	 RASz3d5WeITnh4XHlE8KL1sIPrUD4hZt9brjmv9VOwNpyrNuVwnS3Mp7bq8MtpYCnY
	 Jg0D7qnGeIl20NWfQtxgMGScretCYFuV+ZzCOawQjFAVBs/k5LB2RrEZe2EDGDrZcB
	 TLYktQv+RcipA==
From: Bjorn Andersson <andersson@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Taniya Das <quic_tdas@quicinc.com>,
	Taniya Das <taniya.das@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
	Imran Shaik <imran.shaik@oss.qualcomm.com>,
	Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
	Abel Vesa <abel.vesa@linaro.org>
Subject: Re: [PATCH v3] clk: qcom: gcc-qcs615: Update the SDCC clock to use shared_floor_ops
Date: Thu, 30 Oct 2025 11:25:41 -0500
Message-ID: <176184154233.475875.14082891428728778332.b4-ty@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029-sdcc_rcg2_shared_ops-v3-1-ecf47d9601d1@oss.qualcomm.com>
References: <20251029-sdcc_rcg2_shared_ops-v3-1-ecf47d9601d1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 29 Oct 2025 15:07:54 +0530, Taniya Das wrote:
> Fix "gcc_sdcc2_apps_clk_src: rcg didn't update its configuration" during
> boot. This happens due to the floor_ops tries to update the rcg
> configuration even if the clock is not enabled.
> The shared_floor_ops ensures that the RCG is safely parked and the new
> parent configuration is cached in the parked_cfg when the clock is off.
> 
> Ensure to use the ops for the other SDCC clock instances as well.
> 
> [...]

Applied, thanks!

[1/1] clk: qcom: gcc-qcs615: Update the SDCC clock to use shared_floor_ops
      commit: 0820c9373369c83de5202871d02682d583a91a9c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

