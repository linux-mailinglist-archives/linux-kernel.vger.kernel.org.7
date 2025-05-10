Return-Path: <linux-kernel+bounces-642514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8E7AB1FCD
	for <lists+linux-kernel@lfdr.de>; Sat, 10 May 2025 00:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BCAF9874CA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 22:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497B6265CBC;
	Fri,  9 May 2025 22:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAT78gA9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912DF2620CF;
	Fri,  9 May 2025 22:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746828819; cv=none; b=HH/JjpdYCYbX80JUSAzUEwtNMmCwVepSZmTGJEIU9sLQtCFvhN4OmJR05/EDglcYOT1EFFudfoN+jxdw1z7X4LlOB5YVO1e9/mVFRL6tWCU00THVw/qYHdeNvxVfIKy5VHHzFQPtRQvwEhIJnMkYYLaSDFM8tFt8+8keJSL7r9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746828819; c=relaxed/simple;
	bh=4r6cXTJtpj+KRIp+puQ51CE0TKRWfmeB5g5F9vhdkbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QlL7eFKdKQUzHA/O+JYKoHeoFxCiuFgC1KHww4UwFPQzu0Sxr0SNJooJAEy2oDtabVoYhAvY6+wi0TJjB/LgkcH41/rq6jBSkEUlxzSkr1ofWcKMoS8lAztnZYXfcddvZ08qpmBH8c94G8TWe4ink0zNuTNR9/8rEMndJZVx39s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAT78gA9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE26C4CEEE;
	Fri,  9 May 2025 22:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746828819;
	bh=4r6cXTJtpj+KRIp+puQ51CE0TKRWfmeB5g5F9vhdkbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OAT78gA94AISpTp0UolS6uvjWiuaj33lRSGMUefpq6kn1RQliTekpIU7VkTb1sW1i
	 QXs7YlUjUxikz7tWBtHoFXuYVXIv9pi/FyOB9xEC4l5dcBpEaDdsoKkLjDf2g2bdEy
	 CRvQSHvXlXcTwO/1NiT0ODS0Qa0v6ruLmOSMC0omj3i80mE6hMFqBXvjK2si58i56D
	 BU4gPF26Nzi8K6JAPrs25V11dn8bPj9hUl2epigPLVC7d9qlxkQ7ogZg/9Nxrw4jO5
	 Gb1Z9bI8lGVdv/P23CYQtFpEe6aPyd+7t99oOWLKhMbLl+Kceco1OAy84cy0O3SxBF
	 gqR87Wao4zhUw==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abel Vesa <abel.vesa@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH] soc: qcom: pmic_glink: enable UCSI on sc8280xp
Date: Fri,  9 May 2025 17:13:26 -0500
Message-ID: <174682880456.49052.9648788902915008949.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250326124944.6338-1-johan+linaro@kernel.org>
References: <20250326124944.6338-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 26 Mar 2025 13:49:44 +0100, Johan Hovold wrote:
> Commit ad3dd9592b2a ("soc: qcom: pmic_glink: disable UCSI on sc8280xp")
> disabled UCSI shortly after it had been enabled to fix a regression that
> was observed on the Lenovo ThinkPad X13s.
> 
> Specifically, disconnecting an external display would trigger a system
> error and hypervisor reset but no one cared enough to track down the bug
> at the time.
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: pmic_glink: enable UCSI on sc8280xp
      commit: 4d7ee0e277d4558ef025a5c4d6e1c7a8c8a1e68d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

