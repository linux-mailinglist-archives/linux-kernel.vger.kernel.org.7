Return-Path: <linux-kernel+bounces-723335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC39AFE5EF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5519D1895B21
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B89028D8C2;
	Wed,  9 Jul 2025 10:38:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB422749F1
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 10:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057532; cv=none; b=WZJc8BV4Bh6nI6xjcjk65erBCNUcyMdAFUpW6dZ1bbmvGYzcCSmo3hciTAUnF/GiqPkYy8RHS627KFTlOtiDX1GfVxhufwSEIwRl0NX6PfU9smbx/O3SoxcQOc6jnxmjOiAg0YuLxKPito8wfv5KuMe6OpviD/c5g+Pw7gn0pQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057532; c=relaxed/simple;
	bh=Fpxx5MLLvM75BD/Rcys04uH8/DSWIDvU1+fFmoln3rI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lrfzTUHdRg5BYiMUGxMlU+r5f/UUePDsH6P/9b6guhDgKgihKeSIMA+fGIlsDue3qe6OtgNz/Vwm/yKfbA5AXlGJJC1hMqavJhNJm1AX+zkwuNGEqmxVeA7fArJbqTjhs4BF55JcHKytWlypJAhXbA8lvMUCNJKISUp7MKU5/yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A11061007;
	Wed,  9 Jul 2025 03:38:37 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1335F3F694;
	Wed,  9 Jul 2025 03:38:47 -0700 (PDT)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Yuanfang Zhang <quic_yuanfang@quicinc.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	kernel@oss.qualcomm.com,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coresight: Only register perf symlink for sinks with alloc_buffer
Date: Wed,  9 Jul 2025 11:38:38 +0100
Message-ID: <175205730826.265536.15080802362273791797.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630-etm_perf_sink-v1-1-e4a7211f9ad7@quicinc.com>
References: <20250630-etm_perf_sink-v1-1-e4a7211f9ad7@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 30 Jun 2025 18:26:19 +0800, Yuanfang Zhang wrote:
> Ensure that etm_perf_add_symlink_sink() is only called for devices
> that implement the alloc_buffer operation. This prevents invalid
> symlink creation for dummy sinks that do not implement alloc_buffer.
> 
> Without this check, perf may attempt to use a dummy sink that lacks
> alloc_buffer operationsu to initialise perf's ring buffer, leading
> to runtime failures.
> 
> [...]

Applied, thanks!

[1/1] coresight: Only register perf symlink for sinks with alloc_buffer
      https://git.kernel.org/coresight/c/59b61f70

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>

