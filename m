Return-Path: <linux-kernel+bounces-802870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F10B457CB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F62D3B3A3C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7D034DCFC;
	Fri,  5 Sep 2025 12:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="FxeNlOWc"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835FF27461
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757075167; cv=none; b=CCaGmvooyFajEJ0idJPn4rJFegZElUpRfGD7lwTTtrZzXg9x3Hapa5UkEpG7k+FmevfLdjJw+zKryriR8MsaEvIeOwcOcmaWyAQZh4tQdYQVDSh3miGPY3JyWCkQsWq81Tyv9PNXiSy3D4UvRXVqlMIMotP/I78RjtHRl+FXO0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757075167; c=relaxed/simple;
	bh=UNbvGndv1S61WpjCG4QZ/lSTct5Dr7ON8Y6ehcau6GM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rj7tBVb3pKYjsykg0jU8BOZuf5QxXZstAgw8L52HUxxUPVmd1UUBWTJjjmobTCOhVNevbA1f55OT7QaiYorUptb+dHEshKMKEtExMyD1GtGF3t5d9f0m6mt+UvFsMnwGIdRnwv0q4DsXFQojBDMu1cidBmkUzK7HuXaTwH+adtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=FxeNlOWc; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p54921b16.dip0.t-ipconnect.de [84.146.27.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 73A0152C54;
	Fri,  5 Sep 2025 14:25:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1757075156;
	bh=UNbvGndv1S61WpjCG4QZ/lSTct5Dr7ON8Y6ehcau6GM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FxeNlOWc0vnOtMnc53lZ6jehc7BQyGtRGRakNcUVX+Y41F0RGI/dg/TUrt5ErrtVS
	 h6/5xfwcj2gf+W1c9WSrNyKK/c/DN/rdL8E7aCyeqVxPOzPcmxQTcWfG8+YTyQBPNB
	 S2XLajyxNWPktg72WzR2UkocNLS0HyRRrSrGkPspypkEBYB2Jbq10MzXv+4sz0FtgH
	 vOeEVRFN1GIf2e2jFvExt2H55oGbgPiNAmzS0of2F1zfPQrch69HF2ntXfpvqNCWbW
	 BIEP+jwyLe0kMPqJBXaj9JupWfEah4l2x1H57ZzZoDruWBK8YuB1t6/yvvXef5YKZs
	 H81jPXIlKc7hA==
Date: Fri, 5 Sep 2025 14:25:55 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: will@kernel.org, christophe.jaillet@wanadoo.fr,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/amd: use str_plural() to simplify the code
Message-ID: <aLrW096GmNn0o_5C@8bytes.org>
References: <20250818070556.458271-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818070556.458271-1-zhao.xichao@vivo.com>

On Mon, Aug 18, 2025 at 03:05:56PM +0800, Xichao Zhao wrote:
> Use the string choice helper function str_plural() to simplify the code.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>  drivers/iommu/amd/iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.

