Return-Path: <linux-kernel+bounces-764618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD8CB22534
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5C05504FAF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A3E2ECE8E;
	Tue, 12 Aug 2025 11:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="kxYVcsWM"
Received: from mail-m3295.qiye.163.com (mail-m3295.qiye.163.com [220.197.32.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501982ECD38;
	Tue, 12 Aug 2025 11:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754996600; cv=none; b=pwLD60CzjqGWIoqJrtv8h9jT6Dw3JHQhgiPtn7Eh5qzkuFNZEIvZmNu0bTnaZcXGxoY8a/YfrzhUKIcTLZbh4JmnHiNGPjO9hXHL+px7LvDYqIs9hR9J3KYaVC8PgQBvEwyM2HeayCIUiFBjh6WHhwALYPRxCoFGC9z1ZL/OxMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754996600; c=relaxed/simple;
	bh=aMU6L1c5K22WNXfOw4hDrPqadebF1K1kG8GKgIO4tjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kNG3IJuW5to+hv+dCXbKMrtTNQJHlXsxhw2ewB7GBFjvXjN0S6wMe+AhhkLlpPb6ttPMFgmbClnmewWQ2Bd2oqoNB/fSFVV9DhlOCiwcWkqVPPyuP8HCeYfi/lpwDu7GsjiQaZDPNsnkl4HWv1JZJH9ahvkQXLljKTy6bbmA3Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=kxYVcsWM; arc=none smtp.client-ip=220.197.32.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Received: from albert-OptiPlex-7080.. (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1f1d6e1f4;
	Tue, 12 Aug 2025 17:47:42 +0800 (GMT+08:00)
From: Albert Yang <yangzh0906@thundersoft.com>
To: robh@kernel.org
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	krzk@kernel.org,
	linux-kernel@vger.kernel.org,
	yangzh0906@thundersoft.com
Subject: Re: [PATCH v2 6/8] arm64: dts: bst: add support for Black Sesame Technologies C1200 CDCU1.0 board
Date: Tue, 12 Aug 2025 17:47:41 +0800
Message-ID: <20250812094741.2040632-1-yangzh0906@thundersoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702141957.GA1416711-robh@kernel.org>
References: <20250702141957.GA1416711-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a989dadae4509cckunmdb40a9fb81067c
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGk9MVh0YShkeTR5PGElPS1YVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZT0tIVUJCSU5LVUpLS1
	VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=kxYVcsWMOpTGsnZF5jR9z7iRDjwbaGFjkdHOwNe4pUuDdnqz/6W9yl9SXEm7boBfhRMV7X4HIgCUjsrq/UNELXgIdbA3UbU/fuqHYL1HzZ4ZtIRDYOzuUw/KTlKwuhGmP+nc+XP1m0Ml2G2UyuPn9JVIaxb+zAEeMk7BV9mfr3M=; s=default; c=relaxed/relaxed; d=thundersoft.com; v=1;
	bh=H2WTsuc3EhhC/Vf4tfE8U6JbtAliV9KGGfugOgJdqqw=;
	h=date:mime-version:subject:message-id:from;

On Wed, Jul 02, 2025 at 09:19:57AM -0500, Rob Herring wrote:
> On Wed, Jul 02, 2025 at 08:31:33PM +0800, Albert Yang wrote:
> > Before (incorrect):
> >   memory@800151000 { reg = <0x8 0x00151000 0x0 0x1000>; };
> >   memory@800254000 { reg = <0x8 0x00254000 0x0 0x1000>; };
> >   ...
> >
> > After (correct):
> >   memory@800151000 {
> >     reg = <0x8 0x00151000 0x0 0x1000>,
> >           <0x8 0x00254000 0x0 0x1000>,
>
> These are very odd. Are these really main memory vs. some on chip SRAM
> or some other specific purpose?
>
> A 4KB block doesn't really work if the OS uses 16 or 64KB pages, but I 
> guess that would be up to the OS to ignore them.

Thank you for pointing out this issue. My colleagues and I have discussed 
that these two 4ks are indeed ineffective, so we will remove them in v3

Best Regards,
Albert

