Return-Path: <linux-kernel+bounces-763893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6454B21B54
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 05:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A716C622BB2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 03:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610FD2E54A2;
	Tue, 12 Aug 2025 03:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDhKf8bE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3A02E5425;
	Tue, 12 Aug 2025 03:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754967899; cv=none; b=FdBJVGVA2g4tJ9bXtGX61pH+WgD3dNjO6AH8HhtiX5xh6IbYeJYHmGt9d0vtGpwFxwfMwIVx1NuBQOzgtTZER212/xhCMW0yUFYb+SSc3YvZv5IdCbh4QnDLFEMb9Kd7lWUbKErR/HWYXYVNqPCxU6cHjX6Zb9gbbs36DYr9jno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754967899; c=relaxed/simple;
	bh=ddAbB81iVWyC1B90mOAnboTaW07e06F4VJGiuhkO6tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FtFPrrBvfs7BNckA2+w5JE7UlQ9ms6fWMFItzxt8lwYZ64zgbBGTa3wDUhvDTwh+HHm1pRhfPErD3PDhLE7sVAQUam5XxNO91kMHy0uD+KTIplRuAmd7yD5s7FcKM35Hbd66RltMhfgF/mFjRRUkBgfogvy1szXDvmGYwRxXYkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDhKf8bE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A426C4CEF7;
	Tue, 12 Aug 2025 03:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754967899;
	bh=ddAbB81iVWyC1B90mOAnboTaW07e06F4VJGiuhkO6tw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MDhKf8bEcTad0Y5DZHeOfE1FjXq+JWm5nFGpyrijlMaDEd0BWMJ8+Sao4aalfQV8T
	 N7UvpaWJlyRg6sRk299Vn72gqoLV9NWBoTkdkKQxsRkTYWpyZ/5KoObQh50EfjdDIS
	 su23ko5N/6vcEqb3aKC9Y3ocoZg6+cu7B1wiTm9me8k3l4oDPzGf6nrZNjzYN8tzls
	 DrglJWZHIO3IU3Fzn+tCtOoZx5+FxiW2FgUEYLmbWtb2YBhvxKVIYFOBDEUFWEV5RE
	 j9XAQoq5BIz6COfnrhDTyAexyldmPWCkV5BxQ9Ft3+4mUWFlC+U3OUnYkuYFMmPU3a
	 joQTGJEazlcuA==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8650: Add ACD levels for GPU
Date: Mon, 11 Aug 2025 22:04:49 -0500
Message-ID: <175496788913.165980.17832405110521980066.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250729-topic-sm8650-upstream-gpu-acd-level-v1-1-258090038a41@linaro.org>
References: <20250729-topic-sm8650-upstream-gpu-acd-level-v1-1-258090038a41@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 29 Jul 2025 16:40:53 +0200, Neil Armstrong wrote:
> Update GPU node to include acd level values.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8650: Add ACD levels for GPU
      commit: c2e07613b8d40f0ac60dd9b28c0dd15f9a298c11

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

