Return-Path: <linux-kernel+bounces-895335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D03BC4D895
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A5D74F404F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6610A34C808;
	Tue, 11 Nov 2025 11:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWLa8n2L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25DD3587A2
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861693; cv=none; b=V/+YAHbe2LXtwEoKgyiwOV0pKByDJ9LwSuPrXz2vBMTwAZlaH/YkPNUlBVaCQ9w1IXM2WUP3nZ8U2uvBNLuxykVmi7Or9AfFxEJHIb7m5qCSHV1RM8eBt/tne0LiF4XqmZQk7AlHfZowo91B3LCfX6RpthplpybdwwcrcySlaMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861693; c=relaxed/simple;
	bh=AFkDmOI1fbj+HDs7mKqCfbwpRVPt3oi0SdU7LB8Q8os=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H8YPYXWdj8s52dnskO4R7vyYHOedPjpCzCXFnBxSu6B9eSJl/YamyZTDVkQ0Yay5+VIRtE5+bY4f3yFAFMsV0GBkKca1ctShopvrNDheXg1YxdqV5LMY+3zPqPFDJ7mXQU+XhAlRKRThCQDQCfwPriZf4R4VODoa9QAA4121+eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWLa8n2L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF95EC4CEF5;
	Tue, 11 Nov 2025 11:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762861693;
	bh=AFkDmOI1fbj+HDs7mKqCfbwpRVPt3oi0SdU7LB8Q8os=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jWLa8n2LF8G1dVRqwgDoncrNRuPwf1Td99fdaW3lhz2TqKeeWZTg9KSrfRX+GKUTD
	 L7ixGkW7oHNZ9JByfYA0PWkwHhltxM8dYRxJTL9tGKZIpqSPjRPc6kHfQPmZUEt7Qh
	 KSDcIyOMac3RTU8Gm5QY7fH2q2hjT4YnywVKkkerr/+r2Xeb3PPTkDycJVkowNX4SK
	 vCNrDnNUbZktdm+3OfQoonnqgFPkHoeTmm4Zenpf+tIEJRKG3D+tWMMZFv2jWf+8Bc
	 gVHEvZMxbxLmzj2BcASX38O3maES+78SOv1JlGD4gi4kPBdlHCNndSGnC+34o/UTPp
	 j9JnfUQ7mIlxA==
Message-ID: <10d001cb-2600-4957-9c8e-123ef245c1f6@kernel.org>
Date: Tue, 11 Nov 2025 05:48:09 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] firmware: stratix10-svc: fix for v6.18
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org
References: <20251103124105.34655-1-dinguyen@kernel.org>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20251103124105.34655-1-dinguyen@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Ping?

On 11/3/25 06:41, Dinh Nguyen wrote:
> The following changes since commit 6146a0f1dfae5d37442a9ddcba012add260bceb0:
> 
>    Linux 6.18-rc4 (2025-11-02 11:28:02 -0800)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/stratix10_svc_fix_v6.18
> 
> for you to fetch changes up to d0fcf70c680e4d1669fcb3a8632f41400b9a73c2:
> 
>    firmware: stratix10-svc: fix bug in saving controller data (2025-11-03 06:24:19 -0600)
> 
> ----------------------------------------------------------------
> firmware: stratix10-svc: fix saving contoller data for v6.18
> - Fix the incorrect use of platform_set_drvdata and dev_set_drvdata
> 
> ----------------------------------------------------------------
> Khairul Anuar Romli (1):
>        firmware: stratix10-svc: fix bug in saving controller data
> 
>   drivers/firmware/stratix10-svc.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)


