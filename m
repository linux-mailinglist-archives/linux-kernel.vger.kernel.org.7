Return-Path: <linux-kernel+bounces-748842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC5BB14699
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 05:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D35917A7D86
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 03:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC51D219E8D;
	Tue, 29 Jul 2025 03:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rcq48nOX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A207286A9
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 03:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753758412; cv=none; b=p16wwUh2WbMYs7Q89MpA/znoNE40WL/SiJ2g6lhHb+PJp8rry2D6aMT6RMgJ9c5Xr6cTU2WmnvvrMzay7ufSU1uojCNS6ylOq/29tiFHOv/K9WVaqwZCqIkbSe33A/p+4M2oVFpn17ueWsubPrZ89PnMiSOlkk4/6IJTnvt6Rpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753758412; c=relaxed/simple;
	bh=vckEhDztamPT2ztafM7NGX8lZ4VHy1pJroP6LRG6KAY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cHgnusvOGD1LDBqoygsdWj30TwnB7uDnAV1rvEMEzEs9yfxvZc8oXoHs/+cPTSWnRMGRRCBqc5fRiW2O4k3V+9qKgav3fYRcChVR5NM09UQn27tC6UTNnDEw4aJyNTvzqe+VB0AS5YN5OpRCQt5Mi0Z2iaY5HDawH60X3mzrzIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rcq48nOX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C032C4CEE7;
	Tue, 29 Jul 2025 03:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753758411;
	bh=vckEhDztamPT2ztafM7NGX8lZ4VHy1pJroP6LRG6KAY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Rcq48nOXA5b5V0xPytSI8n3odO4x+m6f20jwEf8gi6Z7HMZDQueYQspaaT7YTA0oJ
	 hCplI+7ZwOBXhtSei7m8ZAg5bVF1IUGcxohOxMBNLcG90a7j6Xk3rllSkmHaLMOZ8X
	 jUc85DHiJLNuB7ltiGVFkF5/2WsIlI7vkBQEyZrNQA74prGqnthXDtg3xbTcLqwmUA
	 HvpnKuFJxFM8BLrdr7bBYxB1dE3E9NQhEouTeAPYV+g51H9/kUVQinEmO/QOXr99TH
	 G6GJFOnt39I+Gf+MJFdzxtlLQdtWmxPkT8rzTJw4HE4H3ujliBku0016dkoadu3zAA
	 YGtYal5f6ko/A==
Message-ID: <b61fae81-ec51-4fb5-8974-76236e9eb858@kernel.org>
Date: Tue, 29 Jul 2025 11:06:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: add gc_boost_gc_multiple sysfs node
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20250728164544.1051653-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250728164544.1051653-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/25 00:45, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Add a sysfs knob to set a multiplier for the background GC migration
> window when F2FS Garbage Collection is boosted.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

