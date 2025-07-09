Return-Path: <linux-kernel+bounces-723329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 402FAAFE5DF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99FBA1C4022E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E4128CF77;
	Wed,  9 Jul 2025 10:35:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6677B288C13
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 10:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057350; cv=none; b=EbP4bRwsGxDofKss62uoqgWSh87nlGVW+8RBiDBpAQRJKdBvXupWsvvyLoYf4iS8eELE+IIjvpX+50RO6bEwRwUOG7K8g6aBUX9upM8AE/kHNna9mJ/PCG0h1SS5TrpWU9l7tkI5UE6zaPlpJoOeQJhL/AIY9PXnxIDx4E3fyCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057350; c=relaxed/simple;
	bh=2/k/izbTZbHn6eNC2leIlO8nXjyZIW5ijddFyKR2OSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=caaGdysSOsry4ADJ0w5MY3vDKSsna/57PkHyQHiq0FNU/0NyzSisVc7HX/cbM6I7B84DrtfIY83ir9bqMzbM+7QkYCnXGyFO3fTdOXqH9Hwrt9VnmoT2Q1N0gf3LYprk6Bv+v/ktaD3sChGUGmjxXCETvB9hCUfSkHG8gPHYL1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F4AA1007;
	Wed,  9 Jul 2025 03:35:37 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 94D273F694;
	Wed,  9 Jul 2025 03:35:47 -0700 (PDT)
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
Date: Wed,  9 Jul 2025 11:35:38 +0100
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
      commit: 59b61f705b83d41a876144975a2332c7b8ea96b0

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>

