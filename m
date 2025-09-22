Return-Path: <linux-kernel+bounces-826893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7BAB8F8FC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 235EA421AFF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E55287244;
	Mon, 22 Sep 2025 08:34:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E165A279DB5
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 08:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758530054; cv=none; b=LCg+hVXykgRccdEd3IoK1nFCiKTl7duU/NOZuiX2XRWIDeBuP3anlZTqlbyfeFByWqFRVGEwaOuU88uCVaBZYvyR2Opoyo0o2qaXdykB02oAKZj3zxwK306Xvmm9iScfR1Y4moQoRRki+efNAfzuLkCqqp7M5DgF+xHYG9u72+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758530054; c=relaxed/simple;
	bh=KTc8mmZd14FIGtfYi3HzZ+o3IId0EYvgWRT+dGxsmog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rr+j0y3VkPuwuxW0rxNGNE3+PF/bLMoyqcMpfeXdnCECzZNcEVTKFgcwVk7tNwhmo/hirrNbSSQ1xEUJ/9yts3SjTV6rDwGEAHA6BbPyjf41u7uEc8pJtd+CFHCbNhvRyrVtJ6B2O5muvTZSiFkryLlhILHYrf6Qc/O7yoViNIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8057150C;
	Mon, 22 Sep 2025 01:34:03 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABA3E3F66E;
	Mon, 22 Sep 2025 01:34:11 -0700 (PDT)
Date: Mon, 22 Sep 2025 09:34:09 +0100
From: Leo Yan <leo.yan@arm.com>
To: Jie Gan <jie.gan@oss.qualcomm.com>
Cc: Carl Worth <carl@os.amperecomputing.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/3] coresight: change helper_ops to accept
 coresight_path
Message-ID: <20250922083409.GC516577@e132581.arm.com>
References: <20250922-fix_helper_data-v1-0-905e8115a24e@oss.qualcomm.com>
 <20250922-fix_helper_data-v1-2-905e8115a24e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922-fix_helper_data-v1-2-905e8115a24e@oss.qualcomm.com>

On Mon, Sep 22, 2025 at 03:31:40PM +0800, Jie Gan wrote:
> Update the helper_enable and helper_disable functions to accept
> coresight_path instead of a generic void *data, as coresight_path
> encapsulates all the necessary data required by devices along the path.
> 
> Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>

Reviewed-by: Leo Yan <leo.yan@arm.com>

