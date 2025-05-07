Return-Path: <linux-kernel+bounces-637132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65549AAD528
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 07:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2E3B5051F7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 05:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E538213E77;
	Wed,  7 May 2025 05:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kt7JDn3S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AAF213252;
	Wed,  7 May 2025 05:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746595099; cv=none; b=Rqpc3qB08ZAaVVv5YNaGdhivPL6d1hw7ptG7SAfIwBTidZm64V0lp4znVYNX6fmLr3qMjJ0gfLnAT7ZuH/FPBp4+mh8wshyGKt/MxycGJ6qzwUlFmKJ7UW25jmFHWRVCoKbWnT+9CAK4yv31E3YjOfDy2xG7NeDDcaTxESo6VSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746595099; c=relaxed/simple;
	bh=K+sGiS6wFSLN6qltmvD8F8BgT8XisD2FxVEm48pDpZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YcBYIyxec4jRTs83AoB2hm2uf9cj2/OoKzNjX+D/WyWodAo38QcLszKlqwYSCg+ksCXJR+UxTCoWaZgWTawfUylWuXs7FFIzopafQFQSgdeqxVs0G1xdc0q+x6ZBeaSe9WP3UBeYTWBK7p0+zjLdluCAtgKbScf4V5L92Ax1OAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kt7JDn3S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0941DC4CEFB;
	Wed,  7 May 2025 05:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746595096;
	bh=K+sGiS6wFSLN6qltmvD8F8BgT8XisD2FxVEm48pDpZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kt7JDn3SKtRRwlXPRsteCPmb9cQGENlNiQ4Ja3A9d7BEqCv9nf2OLp6oZg7zdYOss
	 kayY8X6eOh4tU/suQh8aeIiA49wW4Ku3Jen3+ZL5OfW49H4aR5ysJ+o9I+1sIY6REg
	 VxXzsZdvZqzURhXFYlylrMiULHO4aWB2JTvK5jSu1OTnQ9oJxJSQeYuPI7pYnLmEsU
	 G3oQ1gMjyv7jLRIJsv19H8E8EP2zv6N6sEqqc72sa4jmVw4Ck4SZyK7dugvpAIuBYT
	 dN5VzFV+Wi4jSLSKe33fBXhRyQ0SiW6UY4PDm1DXBuIjmd6PksDcxRPS0werV1TQTa
	 mWVcz4MRaPBzQ==
From: Bjorn Andersson <andersson@kernel.org>
To: cros-qcom-dts-watchers@chromium.org,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: add UFS operating points
Date: Tue,  6 May 2025 22:18:09 -0700
Message-ID: <174659505815.5380.3150313012195240452.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424-topic-sc7280-upstream-ufs-opps-v1-1-e63494d65f45@linaro.org>
References: <20250424-topic-sc7280-upstream-ufs-opps-v1-1-e63494d65f45@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 24 Apr 2025 18:31:14 +0200, Neil Armstrong wrote:
> Replace the deprecated freq-table-hz property with an operating
> points table with all supported frequencies and power levels.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc7280: add UFS operating points
      commit: 099f3401dc3b7f4b63f9fa8b2f44f244c5ab3e62

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

