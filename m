Return-Path: <linux-kernel+bounces-855800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6460ABE2638
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A65B4F77CD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E7D317715;
	Thu, 16 Oct 2025 09:29:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7591A2D3A7B;
	Thu, 16 Oct 2025 09:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760606950; cv=none; b=O91bhz8R5t5RogtcGl5UoTpT1vDf254RE2bor/hyFhoAds8JISMAjkAa8epQuZM7Hqrq7qA5to1JyhZSWxZdzlgcOyKwGM5adkc7mg1iDdUak4ddhcV4M7uDvMdWD9lzpu7VMbvhUSW0SZaIenQUNgahdGHRKo1j7VzmwT6vxwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760606950; c=relaxed/simple;
	bh=EAWgT5z5MTksp7psxgdDyL9aFudbTvq9CSH0Z6/TVnY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EZZ0a0gjLxYU8O32z1XwY++nHeaYpxmT4Oss+YFWc1YuA2ezd71BOPeKbkhIapanXUBCD30Tm5YKl8vDFC2HOkSi89C/wCXeopBP8GQPwMsIZ/PkQq4DJgXvUZU08ddpTY3vo54eMKa+Xa0say0hbkxL2QIY78YK/YrfASdffQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A74321688;
	Thu, 16 Oct 2025 02:28:58 -0700 (PDT)
Received: from usa.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 711813F6A8;
	Thu, 16 Oct 2025 02:29:05 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	philip.radford@arm.com
Subject: Re: [PATCH 1/3] firmware: arm_scmi: Account for failed debug initialization
Date: Thu, 16 Oct 2025 10:28:57 +0100
Message-Id: <176060686586.943664.9077379123610100540.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251014115346.2391418-1-cristian.marussi@arm.com>
References: <20251014115346.2391418-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 14 Oct 2025 12:53:44 +0100, Cristian Marussi wrote:
> When the SCMI debug subsystem fails to initialize the related debug root
> will be missing and the underlying descriptor will be NULL.
> 
> Address this fault condition in the SCMI debug helpers that account for
> metrics counters.
> 
> [...]

Applied to sudeep.holla/linux (for-next/scmi/fixes), thanks!

[1/3] firmware: arm_scmi: Account for failed debug initialization
      https://git.kernel.org/sudeep.holla/c/2290ab43b9d8
[2/3] include: trace: Fix inflight count helper on failed initialization
      https://git.kernel.org/sudeep.holla/c/289ce7e9a5e1
[3/3] firmware: arm_scmi: Skip RAW initialization on failure
      https://git.kernel.org/sudeep.holla/c/092b9e2ce6dd
-- 
Regards,
Sudeep


