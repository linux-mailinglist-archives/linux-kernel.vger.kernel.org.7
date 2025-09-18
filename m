Return-Path: <linux-kernel+bounces-803783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE90EB46530
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 23:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A79E11CC7CF3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5639B2ED144;
	Fri,  5 Sep 2025 21:08:54 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E460D23BCE7;
	Fri,  5 Sep 2025 21:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757106533; cv=none; b=al1nVNs55S/nRLGNQ0Zm4+aG7tF5V+cfzVTBLFoRVc+UV3atR6S8GnNLc7XCDwi9QkWc5bNmmM1yVeoNia2LmAtDn5t7e7yygEskE+jF8maaWN+pwV7AXJvWCPJwXBMGL9n8fWvdnJZNdX2w7FXYwIN/XBpSBdtFJ32kNuE5Kd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757106533; c=relaxed/simple;
	bh=4rPsrvP5ud7ZdUTA9Et+F3ysR950L5eJc5+JLoFGr84=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Vzrc9pSxN18qHCnKOOf2JpJKj+lLG+4fH1bfYJ7DRcWoV625xAWKW282Qvr/oKg70O1cmEcgod6x74bOvk8XSmzfJnnBi0i8PuSfD4NdYB2UwKX8QKffZiw1q7Aw2cFr1pjRyknxcnWwZBx7kBAuzafFx9z2tzWm0+vVsp69wYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A5AC4CEF1;
	Fri,  5 Sep 2025 21:08:53 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 74B05180B21; Fri, 05 Sep 2025 23:08:50 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-pm@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
In-Reply-To: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
Subject: Re: (subset) [PATCH 00/80] treewide: Remove redundant
 pm_runtime_mark_last_busy() calls
Message-Id: <175710653046.85438.14429572500422818899.b4-ty@collabora.com>
Date: Fri, 05 Sep 2025 23:08:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 04 Jul 2025 10:52:25 +0300, Sakari Ailus wrote:
> Late last year I posted a set to switch to __pm_runtime_mark_last_busy()
> and gradually get rid of explicit pm_runtime_mark_last_busy() calls in
> drivers, embedding them in the appropriate pm_runtime_*autosuspend*()
> calls. The overall feedback I got at the time was that this is an
> unnecessary intermediate step, and removing the
> pm_runtime_mark_last_busy() calls can be done after adding them to the
> relevant Runtime PM autosuspend related functions. The latter part has
> been done and is present in Rafael's tree at the moment, also see
> <URL:https://lore.kernel.org/linux-pm/CAJZ5v0g7-8UWp6ATOy+=oGdxDaCnfKHBG_+kbiTr+VeuXZsUFQ@mail.gmail.com/>:
> 
> [...]

Applied, thanks!

[21/80] HSI: omap_ssi_port: Remove redundant pm_runtime_mark_last_busy() calls
        commit: ca50b295fd473ef797b69b8538036cca716f3d55

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


