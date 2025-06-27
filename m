Return-Path: <linux-kernel+bounces-706208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3528BAEB390
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 12:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F5AB3BBEB9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 09:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D11296152;
	Fri, 27 Jun 2025 09:59:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937A8293B4F;
	Fri, 27 Jun 2025 09:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751018394; cv=none; b=PnDaLkOK7nB1prwbf0ZLrXmR2vqwyqDiR4fEgZvLcm0ph/8C5lhXs4tqAHFpC0AsmO/J3dWamiSEL4aPtJgtEeP60GgVpi0mU/MRyqNLwHp6hK0kVTNJ/T/mhlCk6oBoSqgj0PQiQvPrZdlU36cYXE6U2whDjwjCe9eyQg6WFQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751018394; c=relaxed/simple;
	bh=IqgySpdr89LCIfgHo0vt2XviXsu2SmYw1XILN7dGClA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oiWlfIk6yU2ruspHvuMGKsnYu5DjFBslmXjdzMCItFj7Q50WE9HZTBZ662GcqZ+1EY41nOZkzHLmbT+rB1lxfhfsHoxwQtP789MyT5qkyX55ihDGLbCZbdUpAtRIvEzvk0qTBPNqqlXUvkRDgY9ri+p1TDzbK30d3/F6eEpcPZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 878591A00;
	Fri, 27 Jun 2025 02:59:34 -0700 (PDT)
Received: from usa.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 61F2D3F58B;
	Fri, 27 Jun 2025 02:59:50 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: smccc: support both conduits for getting hyp UUID
Date: Fri, 27 Jun 2025 10:59:47 +0100
Message-Id: <175101813277.203162.12125301148602551857.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521094049.960056-1-anirudh@anirudhrb.com>
References: <20250521094049.960056-1-anirudh@anirudhrb.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 21 May 2025 09:40:48 +0000, Anirudh Rayabharam wrote:
> When Linux is running as the root partition under Microsoft Hypervisor
> (MSHV) a.k.a Hyper-V, smc is used as the conduit for smc calls.
> 
> Extend arm_smccc_hypervisor_has_uuid() to support this usecase. Use
> arm_smccc_1_1_invoke to retrieve and use the appropriate conduit instead
> of supporting only hvc.
> 
> [...]

Applied to sudeep.holla/linux (for-next/smccc/updates), thanks!

[1/1] firmware: smccc: support both conduits for getting hyp UUID
      https://git.kernel.org/sudeep.holla/c/1733432638f3
--
Regards,
Sudeep


