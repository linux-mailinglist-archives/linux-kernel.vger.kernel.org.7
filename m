Return-Path: <linux-kernel+bounces-801051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F40B43F22
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D126E7B5247
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0DF322552;
	Thu,  4 Sep 2025 14:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXTZttb+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC5B31E0FB;
	Thu,  4 Sep 2025 14:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996541; cv=none; b=qFRO7KnjU4I4ly+9w6jFSII2Ehp86mug9AdxCMD96Y3Dq1+74zaZj71UHcaNN19DRM8fNjUZ3RaRLR7HJ+J+WeQ+whz2b7z4L2wkKNrhf6WGPueNf2N1y2OZ0LTmYCwIG/85AM/GZt4LUdH3xJL0FKMouNcOpoPbdUNNQOxRXxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996541; c=relaxed/simple;
	bh=FO71ksKB+qiq70bIdl6nEYQDCVWC96yaGJNlSG9tWro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fi0g8rVC//fUaIUEi0HSwIqRs+EAH6h+A88QlKOughgoZB0BJMVZOq7Y+t9IugzuxW74qWTza3KGndGurLNz+a+ZzRcCX0SKkctXs0969KN16F1Vf256OLcd5ZbjtGNiY4gzQH3ER5TWI+DKTEYKG59SSg0pTVq95ddoxebewDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXTZttb+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2474C4CEF1;
	Thu,  4 Sep 2025 14:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756996541;
	bh=FO71ksKB+qiq70bIdl6nEYQDCVWC96yaGJNlSG9tWro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TXTZttb+sLLcPQfmkkatrh3Vd7c+K8d0Gc3+pl11EQq3+CnJ7SC6NsYSgCQm24sKx
	 SVnbgs09UbAXVt32syDxBq7niVi6qq7c8bvO1DUq5oWA5/Hl0w5xoTXhQ0S1GguRo6
	 4bm1WTxHs/Efn1AyxHIs93hpb29Pbc3VlFRY5ZBlJlilmEv1nciX155zSBniLE6/yt
	 eN8KAXLjAfOmOsob2+HsvIJujh+EdaxTfZhkbFd7/JMNwUL6/I5cBeGW6JmVAmxAQs
	 1/4n03ypIqYI1GfdDpYPz5kOU2pLSU+Xft7P0tLb+GKPTer5I1yeP2ODeJlhQcZUoO
	 nR1ufO5iFN3lg==
From: Bjorn Andersson <andersson@kernel.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: common: Fix NULL vs IS_ERR() check in qcom_cc_icc_register()
Date: Thu,  4 Sep 2025 09:35:33 -0500
Message-ID: <175699653025.2182903.2541346631015073729.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <aLaPwL2gFS85WsfD@stanley.mountain>
References: <aLaPwL2gFS85WsfD@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 02 Sep 2025 09:33:36 +0300, Dan Carpenter wrote:
> The devm_clk_hw_get_clk() function doesn't return NULL, it returns error
> pointers.  Update the checking to match.
> 
> 

Applied, thanks!

[1/1] clk: qcom: common: Fix NULL vs IS_ERR() check in qcom_cc_icc_register()
      commit: 1e50f5c9965252ed6657b8692cd7366784d60616

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

