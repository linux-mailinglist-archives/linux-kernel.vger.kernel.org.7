Return-Path: <linux-kernel+bounces-742115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AF1B0ED7B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 615963BBD24
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88909281351;
	Wed, 23 Jul 2025 08:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZyzWRxl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CE028000C;
	Wed, 23 Jul 2025 08:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753260159; cv=none; b=H15VNhkuHbn27FhIvzT/qfWqdL0vu8kZnqtC+jmrg7Xg/EKQyspzMk3QO31z9hGNi2aLN1zsOm7XsLw24+KJ245RMzMq66vGOGV2mm44jnRlinlOX9JMd2fsxOMgEjPPCo+T5G8ivWaO8HFVmh9uZoNVSR8BUdIenKNHOVdoIA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753260159; c=relaxed/simple;
	bh=zesvY2UHB327gOL9bPZ8+RX/SQpLbvcNuuV8lRMuRu8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=P3LxFj8s8vNfWe0W+DN9ZqjEXhyxGiYH9/216DWuXKRvFvinQJp06rDZGVtv+QSVXkdhMkLimsu5FHOAPwCDUKEb9xLCxLcPiKMLKEIRgeqfLFUlwdGrOc+/bmGMU4IUVygWF8Q+taLqMOy9j2sXb1xLQueoFWLGJ1p02vUZ8mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZyzWRxl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A2DC4CEE7;
	Wed, 23 Jul 2025 08:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753260158;
	bh=zesvY2UHB327gOL9bPZ8+RX/SQpLbvcNuuV8lRMuRu8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pZyzWRxlE69DQYA74H2ItpaPLPv6EZxOyE8MRQ5Qqrl/DbDJtnNZQk+Bc1IVfgo+F
	 AJk5IEHPegaTIwlrep4Jym55c2jtcR6MJnZl5m3Y/El0qBF3o+hxZFaCxO5B9VftbF
	 NXrvn8QM6rVijlwxoHktPhhaDMEGJHI8pkuUR5BTv4OqgYi+3rzaqeuJTFmII11N/B
	 a27CinAVLSpfLNFtKnLf4SY3vqOQKHtiS2w9XN6JjMIWjio71w4f8Emx/OJAZBpx7D
	 gNM2OTg91wpY8I60XcXIzMZRo3dBww8GXRpRX5aJjMyS/CZ0vtvxYplZYzsG15e4Dx
	 YVoAVOz1CYfBw==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, 
 James Ogletree <jogletre@opensource.cirrus.com>, 
 Fred Treven <fred.treven@cirrus.com>, Ben Bright <ben.bright@cirrus.com>, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: patches@opensource.cirrus.com, linux-kernel@vger.kernel.org, 
 linux-sound@vger.kernel.org
In-Reply-To: <20250704075432.3220321-1-sakari.ailus@linux.intel.com>
References: <20250704075432.3220321-1-sakari.ailus@linux.intel.com>
Subject: Re: (subset) [PATCH 42/80] mfd: Remove redundant
 pm_runtime_mark_last_busy() calls
Message-Id: <175326015646.1698147.17317699287040369294.b4-ty@kernel.org>
Date: Wed, 23 Jul 2025 09:42:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Fri, 04 Jul 2025 10:54:32 +0300, Sakari Ailus wrote:
> pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> pm_runtime_mark_last_busy().
> 
> 

Applied, thanks!

[42/80] mfd: Remove redundant pm_runtime_mark_last_busy() calls
        commit: 324db89e720150e9592d26f1c8da84685f68996b

--
Lee Jones [李琼斯]


