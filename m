Return-Path: <linux-kernel+bounces-756039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6CEB1AF03
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 09:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2F771884618
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 07:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B5222B5AD;
	Tue,  5 Aug 2025 07:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXREu/I1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE391226177
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 07:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754377214; cv=none; b=RDuE7TDQk5gerghM9Gb+hf0l+vMc7V/en7mHmVwIRubcBVYzDBcx8mj9ZfM0g9NuDBiDI9rhymFqC3wx88U70ZrCGA9ai4veik0u7qlIY9qvuCy4cdAdy50byBW0SNbghSMpbfnmpID2LHQZGtkCswoHjVtdru5xsn+urpP2tZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754377214; c=relaxed/simple;
	bh=4ttDSFoTx2hEl3kQCulPLEVxdkGEo49ul/k3VtCKPdo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iMhqwWApMYi2ViMpAAPxbCEC6ho36z0gijkb0T7oV38+K5wmPa3JQhsID7mPWu0Ge1OPEnkF2rdX79CVA6cra/sf/8i/gFElrpAWXyeiXL9ZsUR4DbSodi7AxLnPOFgOgIrbc2zoKpBAVYnMsDeFRODDPsE8B2Ub4ZEv89ZhHIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXREu/I1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32362C4CEF4;
	Tue,  5 Aug 2025 07:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754377214;
	bh=4ttDSFoTx2hEl3kQCulPLEVxdkGEo49ul/k3VtCKPdo=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=qXREu/I1hvHigY8V14E4v9Ut5lyuWMf6F1ei6LsBSG+4XNrZP2UanPXf9hMwU0VKa
	 biI4QrITK5119USxzyldbvIi/KJ3MCAR/bZc0NzOW/h1KR2HCtXuaR/fU11xSvyqGt
	 BAnBSKLvPmK17tCsdYs0SNQ3ET/yg/SqXx346igfPUFPnmngQ5sXtVONET9OybqaGM
	 2nMzmw7ZBIwpSTd14XGRuMacQfrq273ap4O+sw0gGcipsN445yDrVNStPMRUEI4uNN
	 ZzsmNyfCD5pAXgoEiPPiKGP3az8FQop4EArJnZ2aeImMRRt9LhFYFxLGqpmwtDDP3Q
	 yueK/4+Z4tm8Q==
Message-ID: <cef0e7f2-9136-4854-af7c-2b0956f1e2b9@kernel.org>
Date: Tue, 5 Aug 2025 15:00:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] f2fs: add sysfs entry for effective lookup mode
To: Daniel Lee <chullee@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20250805065228.1473089-1-chullee@google.com>
 <20250805065228.1473089-2-chullee@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250805065228.1473089-2-chullee@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/5/25 14:52, Daniel Lee wrote:
> This commit introduces a new read-only sysfs entry at
> /sys/fs/f2fs/<device>/effective_lookup_mode.
> 
> This entry displays the actual directory lookup mode F2FS is
> currently using. This is needed for debugging and verification,
> as the behavior is determined by both on-disk flags and mount
> options.
> 
> Signed-off-by: Daniel Lee <chullee@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

