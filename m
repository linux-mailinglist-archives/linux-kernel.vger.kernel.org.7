Return-Path: <linux-kernel+bounces-872918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 571A9C129C1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 02:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5AE8F4E4E39
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 01:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123CD2620D2;
	Tue, 28 Oct 2025 01:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSdhpUTq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2AE217648
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 01:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761616777; cv=none; b=UKRXywhajJUhB1KnOMwSgoPuET+jYYCOeb3MnPDrArGJIOzMUxp+YSHt4ogDH7D68ge91c7n7mDLbMnaqIFthWn6tcrlgHOY3vVZ9g1NKbukKt45+20ZDiSHBIsL0qHRRU/l4WJTG08OES8ExIe6Ux1hmiySbXJH6Vn4luReJWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761616777; c=relaxed/simple;
	bh=Vc9AQ64yWiL97TyVndEKNofGSu7+fEvXlc/ISZ7SGPc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=skL+GsheiNPcK54HhGcWMjpve+4m0cN9J4LNgrfB1dD73S9DrK1pslXiAl5tdZWzJmpLk60NifX96WPT3oG+4iBTWAVOLnRscLzB4SPlby7k2wU8SHwmVG3X9mR6yLzFoaOxWP3PLrRGwuD9zUOKaAaUVZGUiWa9eLp/sjaLUuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSdhpUTq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A9EC4CEF1;
	Tue, 28 Oct 2025 01:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761616777;
	bh=Vc9AQ64yWiL97TyVndEKNofGSu7+fEvXlc/ISZ7SGPc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=VSdhpUTqihs2yf1uKPqdyG+7FXYJSS04FXh9GL1L7QwdP6tD1F73kSixIo7zTADGr
	 NePF/FMgZJP6H3eLrNsUR3AosYN83X9JBslAAgUkV6eepQ8Yb+b4IY5upgTlAsDR0P
	 ktWHyWRoEuG04FFV7MBSzoOEb+drjqkE0j1XE9l6gHP8l0sjZw52gWyJeDrawDfdBm
	 FH2qkk7zDbxAALld52IU/JFWXzh3As64AEyFelMSLBFsfFkc58fsTldrmfJI+9Klc0
	 USRP7RC+q3OedvWoYJyn9VXK4Phg6ike5XwPTx3vHHJ3+CA775qBO64/tXsKAp74Dj
	 S0fdSHBeNuPeA==
Message-ID: <f3499ece-d4ac-4329-b0e1-3cf08619c4c6@kernel.org>
Date: Tue, 28 Oct 2025 09:59:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools: add a missing device_alias in the
 feature table
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20251027185307.3680345-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251027185307.3680345-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/25 02:53, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Add a missing "device_alias" feature into the feature table to show it
> properly in print_sb_state().
> 
> Fixes: 8cc4e257ec20 ("mkfs.f2fs: add device aliasing feature")
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

