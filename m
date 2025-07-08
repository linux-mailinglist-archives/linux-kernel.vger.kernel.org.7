Return-Path: <linux-kernel+bounces-721211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F08AFC62A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2D9D17CFD3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB94221D87;
	Tue,  8 Jul 2025 08:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZonJT72f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDA22BE04B;
	Tue,  8 Jul 2025 08:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751964726; cv=none; b=kMjZTDnAnVLKrQhFbI8Oa4jU6+aqIes1UpX3TInq1ZmRh7tglfYcZaZl5lXvyGcNOEKpPTCM12Zrb7E1DENcBrguk52FJs2ZLqFg7nsJj++DQCcVHxvbLR22qABMWJwfZz7xarXAbOISw8RnaClFNCZxVc3U4TRqXEbz7JrWz1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751964726; c=relaxed/simple;
	bh=no3EIa3+l7xCNHzn8X4T0WAUjmg9asbn4ZAZ6fjDVtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gdL9XbQ/g2CPH2ZvzBlfHMG3MRUYYfbs6pPhf0ebXWnICgtAjmwFuz1bgr6+ZF818/sU2alp4eB19RJwU4c36AhLTtNgVo0Gj6N0RTsELGHA33A9YwfRkn8Xk/O+PomSWr76533sjnjMDZaduTTNvIo1N+qrQH6gMd8E5wbcKcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZonJT72f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1852AC4CEED;
	Tue,  8 Jul 2025 08:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751964725;
	bh=no3EIa3+l7xCNHzn8X4T0WAUjmg9asbn4ZAZ6fjDVtc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZonJT72fO/zsCh1F2pEs3Oo3qd/Fh7A+1omwHdHj8sh0gsHgd/2xFJ/WyMtmmX8C1
	 7cRupQ8lxFZWjkZBBMHQ6u1+7GDzDV8O5EiBca+WRsjSZSwwckqKkOY8h+uOEqNl0V
	 z/QLEZ2xqXljkToO5IbonkIQID00plJaeKXBdKoQb1ov5xHPhXNkCF2z6PVl8177X3
	 sghwQoFIAQKL9cp3niEdF5EAPwcH6pqQSRe7PjMyPZ0EQK+sYSg/ar2Tx03MIb2yum
	 FwOI5T2BUl5L/xd6Ktp3vUQSKgEnS7zDW+UAxoS3S8NBn3BeUfXhx3CEVJDo3uUYlk
	 FYFuqMWq7U8DQ==
Date: Tue, 8 Jul 2025 10:52:02 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Georgi Djakov <djakov@kernel.org>, Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Dmitry Baryshkov <lumag@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 3/4] dt-bindings: interconnect: qcom,qcs615-rpmh: Drop
 IPA interconnects
Message-ID: <20250708-fortunate-agate-coyote-e3b022@krzk-bin>
References: <20250627-topic-qcs615_icc_ipa-v1-0-dc47596cde69@oss.qualcomm.com>
 <20250627-topic-qcs615_icc_ipa-v1-3-dc47596cde69@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250627-topic-qcs615_icc_ipa-v1-3-dc47596cde69@oss.qualcomm.com>

On Fri, Jun 27, 2025 at 09:37:57PM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> This has been agreed to be characterized as a clock resource, not an
> interconnect provider. Bring QCS615 in line with the expectation.
> 
> Fixes: 6c5e948f1fff ("dt-bindings: interconnect: document the RPMh Network-On-Chip interconnect in QCS615 SoC")

You did not explain any bug here to fix. Difference in agreements in
characterization does not feel like a bug.

Best regards,
Krzysztof


