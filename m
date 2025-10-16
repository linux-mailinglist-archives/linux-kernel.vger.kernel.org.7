Return-Path: <linux-kernel+bounces-855801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A17BE263E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EB2A3A9095
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3104F3074BC;
	Thu, 16 Oct 2025 09:30:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A072717A2EC;
	Thu, 16 Oct 2025 09:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760607028; cv=none; b=nRTOy/atGkLSzUQn/vSGOzdIxCldWva4A+RIX9n//k/MSWvosUE9rcUfkfqEJS4Y4H4pMPf73+/yqf31BoLFcoslNy6meeJD8wHr0cV3VBn6UfW+2IlONry2ZnO8SnbqTWO1Udo088iYsi0rNbaowv4m0WZ9rPPsYKKN29zAS+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760607028; c=relaxed/simple;
	bh=bcN8Qyfy/hOpGRcIoG2/JB6yzledE1NHryJL+tVYf0I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SlMJG+Be893MUlB6fALBMD9wXc4ueW+y1QVbM7nJZtIrJLGbxF73MejcWASSKeMHGqZPZuWZSdF7uXCBDjZDe5B02/B//QYD4fz9c+JJtYY5PAQYKb9fjp14mzRz2UkzBWw1dqAfgL2T/sg2GVT3B1MALwjjzrLQOAmIXrMHyNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A65F1688;
	Thu, 16 Oct 2025 02:30:17 -0700 (PDT)
Received: from usa.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0683A3F6A8;
	Thu, 16 Oct 2025 02:30:23 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: cristian.marussi@arm.com,
	Artem Shimko <a.shimko.dev@gmail.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] firmware: arm_scmi: Fix premature SCMI_XFER_FLAG_IS_RAW clearing in raw mode
Date: Thu, 16 Oct 2025 10:30:21 +0100
Message-Id: <176060697680.944189.4592525887904393167.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251008091057.1969260-1-a.shimko.dev@gmail.com>
References: <aOVGGaY9NmKqUwPG@pluto> <20251008091057.1969260-1-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 08 Oct 2025 12:10:57 +0300, Artem Shimko wrote:
> The SCMI_XFER_FLAG_IS_RAW flag was being cleared prematurely in
> scmi_xfer_raw_put() before transfer completion was properly acknowledged
> by the raw message handlers.
> 
> Move the SCMI_XFER_FLAG_IS_RAW and SCMI_XFER_FLAG_CHAN_SET flag clearing
> from scmi_xfer_raw_put() to __scmi_xfer_put() to ensure flags remain set
> throughout the entire raw message processing pipeline until the transfer
> returns to the free pool.
> 
> [...]

Applied to sudeep.holla/linux (for-next/scmi/fixes), thanks!

[1/1] firmware: arm_scmi: Fix premature SCMI_XFER_FLAG_IS_RAW clearing in raw mode
      https://git.kernel.org/sudeep.holla/c/20b93a0088a5
-- 
Regards,
Sudeep


