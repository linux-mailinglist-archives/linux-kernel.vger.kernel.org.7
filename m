Return-Path: <linux-kernel+bounces-763441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56574B21499
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 20:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F26F3E46A7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B052E3B0E;
	Mon, 11 Aug 2025 18:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdI0McYU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE8F2E3718;
	Mon, 11 Aug 2025 18:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754937678; cv=none; b=FdjlhA+mQPW4zSiEv6qGEc4Pkhs5AQXGXVNUoyfN4gkpDySglWghYNh+S8s0lZIAalC/EFB8nxLvIzY8UEl3+and9RZVIUcKIoiUhIlyc/i5xfGvguC1I4f3+inqvMzsSgJfzJn9+g9ZZXFeVla1yWGnL1E0E0PpH7Z8KvFdFmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754937678; c=relaxed/simple;
	bh=tsJArN5A9EGOZmuE/sUWM1eWH6VvwvEzXAMvV+eekHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D/LOlrEwM/sYh4vgYfGM3CfiMh9gZszmPhebxSi5JL3rSsKNTtVpmCRWjJE2PztgB0dm1WoaTxdVYSMcTZJ++Ddx+OHkH+tkZLh0QBvhP6d8NrG7d54GY5PEiWm8IOEa381i2Vn5Ien5FuIGxL5mOg9pfmq9I0ks2/8hrDvnCp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdI0McYU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695C1C4CEFA;
	Mon, 11 Aug 2025 18:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754937678;
	bh=tsJArN5A9EGOZmuE/sUWM1eWH6VvwvEzXAMvV+eekHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PdI0McYU7smiUGsgFphhUMF976bH9am4fNA42G5T/y/zQEpAu+AswDA6HF+7ckBa6
	 LRyoNRhxh0nSZo3n7D6NR0FmXnrRQip4W3PmCF/TvwXg1Ov0vanDP3arg/OfgmCFNy
	 AqOVM+LdKBsagyp1RJ7mUAMdaYan9VuWUu+joLA0WVi9D5CnI1z/F0De5IwQms30IR
	 dTKgodBct7H0uhSQNppFVXQoZVG+4HDtX2aisa6frbU17LZqYZTqQT8EZLLPI7tz2Q
	 L7WBBVLz8SIV6Y/jq/5knoxrwkOsvS0X9USYi7wHgTSPKdDrSWEpWHfvXC2+qJrSbn
	 vsTOiVkDKDaWA==
From: Bjorn Andersson <andersson@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH] clk: qcom: Remove double-space after assignment operator
Date: Mon, 11 Aug 2025 13:40:56 -0500
Message-ID: <175493766091.138281.11024572697306167395.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250802-topic-clk_qc_doublespace-v1-1-2cae59ba7d59@oss.qualcomm.com>
References: <20250802-topic-clk_qc_doublespace-v1-1-2cae59ba7d59@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 02 Aug 2025 13:44:44 +0200, Konrad Dybcio wrote:
> This is an oddly common hiccup across clk/qcom.. Remove it in hopes to
> reduce spread through copy-paste.
> 
> 

Applied, thanks!

[1/1] clk: qcom: Remove double-space after assignment operator
      commit: 6ef38b0c16c20701fb8a06d2d2114080fbc785ad

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

