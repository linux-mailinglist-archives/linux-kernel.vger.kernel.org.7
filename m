Return-Path: <linux-kernel+bounces-810670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F24E6B51D98
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 303611C26310
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A1932A835;
	Wed, 10 Sep 2025 16:26:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1854E20E030
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 16:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757521602; cv=none; b=MllbpByCCI5aNxK0JdgL+aCyOXh9GubJ6qSLB1dJdolegd7ZIHeELaKe/IgUHjxMtBzznfX5C8i1Jc6GdI432nVypkuv/xNavt9nA1blZzw6ddNG6P+DXukDLNxRkSpc74g+pEXrG4/krIBOAWEyejLR2t/k7zCt/w4+d5i+tq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757521602; c=relaxed/simple;
	bh=LWaXtmveUodSU7XL4Qd3qfU8Caw8TZRo2hyzJsSk02c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c/YsbTdpqdFe/wRCA8F8xdcKH+k3NGfC3s+71JxLak/ibe+TnOjGANOID/HXg3orgjjA2lboUxntRlz1KKFpJJol+27VSjqVAXfrxd2nJXI2uUQ+P6NvrE1J4Xo9iERYhOgQxPFGbEZumwl9x2YMYBE1ZZsiPXcA6OucImQ4B60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43EB816F2;
	Wed, 10 Sep 2025 09:26:32 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 94E913F63F;
	Wed, 10 Sep 2025 09:26:39 -0700 (PDT)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: mike.leach@linaro.org,
	james.clark@linaro.org,
	alexander.shishkin@linux.intel.com,
	anshuman.khandual@arm.com,
	Lin Yujun <linyujun809@h-partners.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] coresight: Fix incorrect handling for return value of devm_kzalloc
Date: Wed, 10 Sep 2025 17:26:01 +0100
Message-ID: <175752153909.1858468.4773577291103133788.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250908122022.1315399-1-linyujun809@h-partners.com>
References: <20250908122022.1315399-1-linyujun809@h-partners.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 08 Sep 2025 20:20:22 +0800, Lin Yujun wrote:
> The return value of devm_kzalloc could be an null pointer,
> use "!desc.pdata" to fix incorrect handling return value
> of devm_kzalloc.
> 
> 

Applied, thanks!

[1/1] coresight: Fix incorrect handling for return value of devm_kzalloc
      https://git.kernel.org/coresight/c/6292413be002

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>

