Return-Path: <linux-kernel+bounces-814473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D3FB55482
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 18:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A25D4AC1552
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943233168E4;
	Fri, 12 Sep 2025 16:13:02 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345A1314A94;
	Fri, 12 Sep 2025 16:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757693582; cv=none; b=aq60U6/F0QqpakguSmPdhGJN034NxGrvu29T/RJddQeMAJCW2tDUBx19EXp565WdJ/mnyaelWrqA6p1bCGkW+lPfg77bPOxxGD7yALakBs21GzSqB8K2WlJtvfdNrOADDxRbCP3RbHwdoFX6YffwKjf4xPj22PE+iEv1j3wPc/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757693582; c=relaxed/simple;
	bh=4lhlLjm3Y1Bq0U2EnCek+tbyEVEygRa5NMrGKRfBY/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBO6X7eD8NOGHCCUyl6VeWfyLgi9D0be9SdrRThVLJSFcRyLTZNN/lCJ2SAfYo6iYCkdvS3MEHl+/2vlXriQqJF+9VoQRxOsWBhkd6S6pJq4vfuzZUVlhnM2JOc/1o63QdeQy0SHPFPkRomKeKP8Jp8syQMgP0IJEs+Ay2nBDFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8BDC4CEF1;
	Fri, 12 Sep 2025 16:12:59 +0000 (UTC)
Date: Fri, 12 Sep 2025 17:12:56 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: will@kernel.org, broonie@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, james.morse@arm.com,
	ardb@kernel.org, scott@os.amperecomputing.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com, mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v7 1/6] arm64: cpufeature: add FEAT_LSUI
Message-ID: <aMRGiF9Ez18tc4u9@arm.com>
References: <20250816151929.197589-1-yeoreum.yun@arm.com>
 <20250816151929.197589-2-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816151929.197589-2-yeoreum.yun@arm.com>

On Sat, Aug 16, 2025 at 04:19:24PM +0100, Yeoreum Yun wrote:
> Since Armv9.6, FEAT_LSUI supplies load/store instructions
> for privileged level to access user memory without clearing PSTATE.PAN bit.
> 
> Add LSUI feature so that the unprevilieged load/store instructions
> could be used when kernel accesses user memory without clearing PSTATE.PAN bit.

These two paragraphs are pretty much saying the same thing. Just replace
the second with something like "Add CPU feature detection for
FEAT_LSUI". No need to explain the PSTATE.PAN again.

> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

