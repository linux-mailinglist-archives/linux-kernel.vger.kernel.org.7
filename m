Return-Path: <linux-kernel+bounces-882796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F09C2B84E
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 12:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D89134F5658
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 11:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396E13043A1;
	Mon,  3 Nov 2025 11:45:49 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA8C303A24
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 11:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762170348; cv=none; b=aGHs32vN7HzmxW22PbO7lZnPOivED462oBzSjPfR/QRdPqOcudlK9O6g2SUSmIRQ04l1NCmtITJv2qMDivVx5gArjiEnCw3BQIcveoAhwSDtMWUmcLmaQh7Q201vUgaMiUQIZdnnaG8Pq4+EvEr+CGzr1Jr8+rR/cLRHYtbdxC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762170348; c=relaxed/simple;
	bh=MKJuDyzMYpC4p9udbkgW6jYEMAYBxEipPY7uSuKbOr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Otn1lMDB0yz447uUYM7DKZ692ozcoV4g8B0cZFpY0pvnLW2QTahZGYhvid6voB/z9kK66nQsgs7xpyB6KnEuRSN3MAVqdwcZxzJ/sNaxXgksvv/tbk/Iho4yfRZN4OD81nLeOXS4pxbcF0RkkIu1iHIO9kLOy5dxMH8/SOOz4NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 44D44227A87; Mon,  3 Nov 2025 12:45:43 +0100 (CET)
Date: Mon, 3 Nov 2025 12:45:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chu Guangqing <chuguangqing@inspur.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Fix typo error in nvme target
Message-ID: <20251103114542.GA15280@lst.de>
References: <20251103024131.1855-1-chuguangqing@inspur.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103024131.1855-1-chuguangqing@inspur.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 03, 2025 at 10:41:31AM +0800, Chu Guangqing wrote:
> Fix two spelling mistakes.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


