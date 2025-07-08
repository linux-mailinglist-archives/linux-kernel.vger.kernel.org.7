Return-Path: <linux-kernel+bounces-721899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EFAAFCF46
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 938833AB4D4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC923225A24;
	Tue,  8 Jul 2025 15:30:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7431C4A0A;
	Tue,  8 Jul 2025 15:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751988629; cv=none; b=Rj1aDks0lYW6dj0cgQczW9rP3f4RCM7UYbaW2KmkpRSd11eIxFCY+3E6Xaki0IjxQoj2GmRx82heO0L1Fr+pwXawrR7sBPNP8a8vGaoIuuolmN2T7WsHFCWb/bUiQFLv4EjOyvl3lFPFznfamot8nqJSvgo4pPguhzhbzgw+bfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751988629; c=relaxed/simple;
	bh=m8ITrJD/KDdwA++T+lyOQ9bTYuHM9TbNxOy/lgOyQPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dRkanwXOU3um9LSfqDXVKWj62JB3C3hV2w9DpTViYW9gjIYP0fIIkkKHXOmgMKFIG4ragcm/PoCt3DCUCjWiPodaAP3RG/6DAUBnInroWZAKNUcPTITz0OgfqP1phUSM1YQTX0tiOCiME5eBOGr+jEwwWwUGuivYNX5wT05bMJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B751A153B;
	Tue,  8 Jul 2025 08:30:15 -0700 (PDT)
Received: from usa.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 686463F738;
	Tue,  8 Jul 2025 08:30:26 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	peng.fan@oss.nxp.com
Subject: Re: [PATCH] firmware: arm_scmi: Optimize notifiers registration
Date: Tue,  8 Jul 2025 16:30:24 +0100
Message-Id: <175198844540.786463.17262807646940735306.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250707144220.485365-1-cristian.marussi@arm.com>
References: <20250707144220.485365-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 07 Jul 2025 15:42:20 +0100, Cristian Marussi wrote:
> Some platforms could be configured not to support notification events from
> specific sources and such a case is already handled properly by avoiding
> even to attempt to send a notification enable request since it would be
> doomed to fail anyway.
> 
> In an extreme scenario, though, a platform could support not even one
> single source on a specific event: in such a case would be meaningless to
> even allow to register a notifier and we can bail-out immediately, saving
> a lot of needless computation.
> 
> [...]

Applied to sudeep.holla/linux (for-next/scmi/updates), thanks!
(with some commit message changes)

[1/1] firmware: arm_scmi: Optimize notifiers registration
      https://git.kernel.org/sudeep.holla/c/b5daf93b809d
--
Regards,
Sudeep


