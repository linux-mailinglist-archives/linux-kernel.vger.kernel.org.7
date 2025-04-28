Return-Path: <linux-kernel+bounces-623001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EC5A9EF82
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 13:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF98E3B375F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 11:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622002676C8;
	Mon, 28 Apr 2025 11:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="fiAf+NIj"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5CF266567
	for <linux-kernel@vger.kernel.org>; Mon, 28 Apr 2025 11:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745840451; cv=none; b=GMRPhu7re7rwkS00wJpktDcb/fmpWulE0L+2fXxfrutFMlVnTZEPvO2vYQa/lB1MY7pJQAhdiiZ1buR78N9Zd5tpY/BXnFsqoxKxoy28/uCed+5UlOCU1NCWBVJIEXMieLufD+vaZTb3nPmY8iaukLHkrCnb0eLKiEksdoLq5RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745840451; c=relaxed/simple;
	bh=nzt/f6c1LIWwQHAw6ZUO4VvSc1zWD9M1Qn1JPfbiXLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJMufJZAjKS6VD3a6kM5M7KXZnK5MVVQscTvfjWqFPtLyQOpd85PEZGuU9PmLh/Q4qqaTJjXOgkWK04tcF8ZHFccD8OcAD6NSmYlnjoCoEmdFXrRytI057BHRaUHrGLNExr7dnJbS3UNohEKNRn43RarpEfk7LkDoEL93KC97vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=fiAf+NIj; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id B31FF496F0;
	Mon, 28 Apr 2025 13:40:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1745840448;
	bh=nzt/f6c1LIWwQHAw6ZUO4VvSc1zWD9M1Qn1JPfbiXLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fiAf+NIjZWzChFvI501+oH7j4H8Oo1dZ3E59+2M7rp1k8FfxSLIi6y665WU+Ikllx
	 7zEu0mf0pepLuvA7lDlX1+B6YOsi3noC/AyCx7IYo+HHp84JCKAf/0rirugxIudjQX
	 Ida3G7CSRBJSPVQoPETVtL/IUBopP1yxWTkXdgFL9ap22ZYlSgP8LXT7SBex5MtqM9
	 waFQFd2gWKfp21reKUqWbSHLdVCH5SMDx/3soV7yVkAKPzxFxgkO5VZBiVXnfih4Z1
	 n+yWB/o421+4gfcn5UNvwVTdRKiWwdgiRmjT/Qx4O8X2NuvcYeURoT0Xd2FnFa0ZUm
	 lj29ANMeREM0A==
Date: Mon, 28 Apr 2025 13:40:47 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Sean Christopherson <seanjc@google.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Ensure GA log notifier callbacks finish
 running before module unload
Message-ID: <aA9pP_InHAgskqcM@8bytes.org>
References: <20250315031048.2374109-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315031048.2374109-1-seanjc@google.com>

On Fri, Mar 14, 2025 at 08:10:48PM -0700, Sean Christopherson wrote:
>  drivers/iommu/amd/iommu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Applied, thanks.

