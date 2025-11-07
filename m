Return-Path: <linux-kernel+bounces-890474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C978CC40235
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7627E189B4A0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55D02E6CD5;
	Fri,  7 Nov 2025 13:35:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53445246769
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762522530; cv=none; b=rwwmUCxFDucvvw2AR5sJ8EGJfCKys39mfKkiw73punc+A9F/t2EkK/++W7Zc3yOijmumPeXAwbWWMQw3tYLDkypdKR+FEef3nAFNWMaWsEbYPvy+vtW1lbcbw9yYeP3gGnpwLTk41fHmk7wLZM9+c0jjnm2VS6/lMkycu2PjdRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762522530; c=relaxed/simple;
	bh=sjP/3T3qtrdDsnvm+YhYn0YDvsXpYkCzkeuoy9LuIpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JRx/t5i8/HAONiwz+4piZyMsDXBQrQslvw2SYhLGbkiKV/qGh9V15iAJ6TDyh08UeFASo73IjjVW2dTg9x6eN0t4sBcFMB13RJdr9f686GeYloiRpLLvyszCHBTsiws4hgZJdINL5sJdGTa1uOzUynLCIZaZ0uq1tzQItdvUmdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3FD71515;
	Fri,  7 Nov 2025 05:35:19 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 56EFD3F694;
	Fri,  7 Nov 2025 05:35:26 -0800 (PST)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
	Tao Zhang <tao.zhang@oss.qualcomm.com>,
	Mao Jinlong <jinlong.mao@oss.qualcomm.com>,
	Jie Gan <jie.gan@oss.qualcomm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coresight: tpdm: remove redundant check for drvdata
Date: Fri,  7 Nov 2025 13:35:12 +0000
Message-ID: <176252250205.436027.680396021677885922.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251107-fix_tpdm_redundant_check-v1-1-b63468a2dd73@oss.qualcomm.com>
References: <20251107-fix_tpdm_redundant_check-v1-1-b63468a2dd73@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 07 Nov 2025 14:16:39 +0800, Jie Gan wrote:
> Remove the redundant check for drvdata data because the drvdata here already
> has been guarranted to be non-NULL.
> 
> 

Applied, thanks!

[1/1] coresight: tpdm: remove redundant check for drvdata
      https://git.kernel.org/coresight/c/aa5edd1b5ece

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>

