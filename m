Return-Path: <linux-kernel+bounces-661456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15349AC2B3C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 23:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 831741B66B5F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 21:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4881EB1B4;
	Fri, 23 May 2025 21:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xqf5x82b"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DBD7482
	for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 21:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748034613; cv=none; b=cMo67xsB6mtSzisUZg0zmz9UkSzG9qOvOteFR6BNbPU++9OLJdST6K4ffYAupD3FaTiGmtZYGded17SN7AUa3FhEHFwmkbSLHI2IC5BGw0L/ayuKVnE99h5HitID55e12Jxf+rHZQJc0JHDPjyila+0OpyzXT1zruSmvg6e6hBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748034613; c=relaxed/simple;
	bh=EZX+iloKE1202xeqiX3o/fp74KwDa+hl9tuC6RdD61A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BEwZ4mLK4YlRiEOBPIK2lEHEDZJEaem+e+F/veEptqtnR+GJS7Ijl6qHpXNnGvVavLa3+wsG7uhF7KuO0190Rg4G1Og0shYw/F4Tt8syhpkuf1BGyIugiM0Czsdz1lxdF3EdkO5OixiaNkjVZPMAsxrgTLD4MCNqQCDc1p2h8gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xqf5x82b; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 23 May 2025 17:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748034605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EZX+iloKE1202xeqiX3o/fp74KwDa+hl9tuC6RdD61A=;
	b=xqf5x82bYXC9hs9HwTlrsdIgorVip1Qv26Q+6zUDn5V/PjT6HSL4uY45RPITPpgXTqkOPb
	spIwk0SdoX+Ez80bXv/JXy56xTLYmv8bMewW3qcW4J46HUmd+jrvaXGoxcMGkJ/s+vtG0c
	Q3nyfUBDejpwXSRSfeu+VcjR4BnpW8k=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 0/6] overlayfs + casefolding
Message-ID: <ltzdzvmycohkgvmr3bd6f2ve4a4faxuvkav3d7wt2zoo5gkote@47o5yfse2mzn>
References: <osbsqlzkc4zttz4gxa25exm5bhqog3tpyirsezcbcdesaucd7g@4sltqny4ybnz>
 <CAOQ4uxjUC=1MinjDCOfY5t89N3ga6msLmpVXL1p23qdQax6fSg@mail.gmail.com>
 <gdvg6zswvq4zjzo6vntggoacrgxxh33zmejo72yusp7aqkqzic@kaibexik7lvh>
 <CAOQ4uxg9sKC_8PLARkN6aB3E_U62_S3kfnBuRbAvho9BNzGAsQ@mail.gmail.com>
 <rkbkjp7xvefmtutkwtltyd6xch2pbw47x5czx6ctldemus2bvj@2ukfdmtfjjbw>
 <CAOQ4uxgOM83u1SOd4zxpDmWFsGvrgqErKRwea=85_drpF6WESA@mail.gmail.com>
 <q6o6jrgwpdt67xsztsqjmewt66kjv6btyayazk7zlk4zjoww4n@2zzowgibx5ka>
 <CAOQ4uxisCFNuHtSJoP19525BDdfeN2ukehj_-7PxepSTDOte9w@mail.gmail.com>
 <CAOQ4uxhnOMPTBd+k4UVPvAWYLhJWOdV4FbyKa_+a=cqK9Chr2A@mail.gmail.com>
 <CAOQ4uxhnOMPTBd+k4UVPvAWYLhJWOdV4FbyKa_+a=cqK9Chr2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhnOMPTBd+k4UVPvAWYLhJWOdV4FbyKa_+a=cqK9Chr2A@mail.gmail.com>
 <CAOQ4uxhnOMPTBd+k4UVPvAWYLhJWOdV4FbyKa_+a=cqK9Chr2A@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, May 23, 2025 at 10:30:16PM +0200, Amir Goldstein wrote:

That makes fstests generic/631 pass.

We really should be logging something in dmesg on error due to
casefolded directory, though.

