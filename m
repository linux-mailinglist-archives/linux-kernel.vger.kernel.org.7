Return-Path: <linux-kernel+bounces-810669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D04FB51D97
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 685C21881E45
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DF3334383;
	Wed, 10 Sep 2025 16:26:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9847327A04;
	Wed, 10 Sep 2025 16:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757521583; cv=none; b=pQX+RatuFIV47Z3xvnjNHWURfT4BpGz+shG3j2XI9bN7klX4R14hKj4OmKwWSWL6zJuWgtX1XLk7lCHmyArisqyJCz9pQqEU2SCe/axmK94QssglNOPgN3dOztbkNni+SNscj6r4mg9MCp7DMikN23Nqb61ljDo2sqWCU6HH9l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757521583; c=relaxed/simple;
	bh=g5UrjwaGEa3oun9vYFWEdV929yoZW6OpDgUw21L2FZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OkhvKlVJtOXgtvk90woPiZOJQxxTRp0eyM7Vhx1HWOsE3v52iFw/p57Zs0RvKWJj91CeRF5EWRYEJM8H97OgJCsPVZgqTprNfJaS31IM1/RZzbEZZqEl9Omx+APmz+3VnLI/cq+hOGkVwAVKOCJNt6FmPrkwk2ZaJ5tlSUVb1Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D059116F2;
	Wed, 10 Sep 2025 09:26:12 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9DA733F63F;
	Wed, 10 Sep 2025 09:26:19 -0700 (PDT)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
	Mao Jinlong <quic_jinlmao@quicinc.com>,
	Tao Zhang <quic_taozha@quicinc.com>,
	Jie Gan <jie.gan@oss.qualcomm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] coresight: tpda: fix the logic to setup the element size
Date: Wed, 10 Sep 2025 17:26:00 +0100
Message-ID: <175752153907.1858468.5330366699431350067.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250906-fix_element_size_issue-v2-1-dbb0ac2541a9@oss.qualcomm.com>
References: <20250906-fix_element_size_issue-v2-1-dbb0ac2541a9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 06 Sep 2025 07:53:04 +0800, Jie Gan wrote:
> Some TPDM devices support both CMB and DSB datasets, requiring
> the system to enable the port with both corresponding element sizes.
> 
> Currently, the logic treats tpdm_read_element_size as successful if
> the CMB element size is retrieved correctly, regardless of whether
> the DSB element size is obtained. This behavior causes issues
> when parsing data from TPDM devices that depend on both element sizes.
> 
> [...]

Applied, thanks!

[1/1] coresight: tpda: fix the logic to setup the element size
      https://git.kernel.org/coresight/c/fd6974c19eb3

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>

