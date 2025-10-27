Return-Path: <linux-kernel+bounces-872703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 292B7C11D3A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E4B51A666B1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FC434B198;
	Mon, 27 Oct 2025 22:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uoBqhw+T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E1B34AAF5;
	Mon, 27 Oct 2025 22:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761604529; cv=none; b=Xq6hwBa34PwJDJxzctAYNdGqQyJBqNk+x87Trw20dNXoQ3D4HNpTvAWhPJpAqVh/ZssUSfwJiHC6WoMjIf+GVaxwgxZPMoE68udWXaaJ1Fu+JmmUmHRWb0Kd1B7LGBju9W+4QSzUKWqQDUrzvmAmMW/hcOXG+VWFkNx6NIvBQwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761604529; c=relaxed/simple;
	bh=7Ii7lyDAUOoZcAzalxKR7YzpfZvEDQkxSBDrjbAdQOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E+B4dZoMcdgDPkq8TIfwYSbSQffqqhVkKgSVn9vFxlM3Kaz7Xc/wNE1gpqvp61WHAGJhOvhlfS/v53rvuBK7O7oWhYd0LGXsTQJXCYRBz9d5BoR0JIg7345LUlizfwM7wLl+PzL1Ba0AV7QYjW92MoLAHOqhkNCUIetNQkyX4u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uoBqhw+T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E74C116B1;
	Mon, 27 Oct 2025 22:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761604529;
	bh=7Ii7lyDAUOoZcAzalxKR7YzpfZvEDQkxSBDrjbAdQOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uoBqhw+TuH7YnNWXXWiXOcOjweN8yPBl6lLGK3Je9zBTRtyI2NsgsILyQPyYeBvaU
	 U/J3oU9/leRrAgvT8lWw2jpd0atyiyTgm8Ro1w1dIn7nKrhJa2/id/r+Xnz7ntUJkv
	 dgDEQ21i3CVh/67HQNOY8zeFbvB7mtUXb+nYdZoltv8dMVX0+HNFscaEv5z+XUYNN2
	 R2heQ17hCvpfkBdr+aB53dV0zVurEWR8MA8GzMem9ry58UOtCbdoB1irSAe367BS7i
	 GkMFkb+JqStQDEGTt7qh+gU4D9izsTYTrIkGzhkpN398M38bShYDPBwPdi/4yROrmD
	 4EdP0xuckpNbA==
From: Bjorn Andersson <andersson@kernel.org>
To: Georgi Djakov <djakov@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
	Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mike Tipton <mike.tipton@oss.qualcomm.com>,
	Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
	Imran Shaik <imran.shaik@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v3 0/2] Add OSM L3 provider support on QCS615 SoC
Date: Mon, 27 Oct 2025 17:37:22 -0500
Message-ID: <176160465171.73268.4640144203295643935.b4-ty@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250819-talos-l3-icc-v3-0-04529e85dac7@oss.qualcomm.com>
References: <20250819-talos-l3-icc-v3-0-04529e85dac7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 19 Aug 2025 11:24:45 +0000, Raviteja Laggyshetty wrote:
> Add Operation State Manager (OSM) L3 scaling support on QCS615 SoC.
> This series has dependency on [1].
> 
> [1] https://lore.kernel.org/all/20250814-qcs615-mm-cpu-dt-v6-v6-0-a06f69928ab5@oss.qualcomm.com/
> 
> Changes since v2:
>   - Updated SoB sequence [Dmitry].
>   - Addressed review comments related to reg field in device node
>     [Dmitry].
>   - Updated the commit text as per review comment [Krzysztof]
>   - Link to v2: https://lore.kernel.org/all/20250804061536.110-1-raviteja.laggyshetty@oss.qualcomm.com/
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: qcom: qcs615: Add OSM l3 interconnect provider node and CPU OPP tables to scale DDR/L3
      commit: 44562f5918907b2e0d7e265540afebe7a42c48d2

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

