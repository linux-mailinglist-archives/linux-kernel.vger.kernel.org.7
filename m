Return-Path: <linux-kernel+bounces-741773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F46B0E8C7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 04:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 042A81CC0E9F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 02:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03AC1F12FB;
	Wed, 23 Jul 2025 02:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="FCfp4EP7"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F851EB9FA
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 02:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753238752; cv=none; b=ph1m6tKnFVqoMoXG8Iddt4IcfjYtjkt7X2Am0HeEKP67Dur6OeiERKn1touZKhQbPqFQKE7kr1z122b8ver+ytCzyzB63SgtsiUX61tBHAVRfSgKJgkt5+RBn5+aNxxt8JqVWU/9laGsFbze3H7jpXi6M96nCPYC41NIMDxKyCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753238752; c=relaxed/simple;
	bh=NaLSk2wcR31aNsVG82x8b2oRLfG/ZKAvXjkp2fWVa0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVOaNnDEaXchawXysd/LucbTvG4MJSmaeJka9csK2JC/WbQSfvSdSD0RbiFjfcboe7n2ai2e41AgO+LAORG0QFRAKtazYTakNla2y/5odKu1mkODonLfH2BVGX2g1QxNQZhicEP0GKqKgWu+Vd59x0rzEYIRgo15S7D/U2NpcxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=FCfp4EP7; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JBnetYrKt/fcJK1elqWbgzpuzW5UUqwlhumrENABEqY=; b=FCfp4EP7QImuJI70jLHkOyj62t
	U5E219ng8xGptoiwYopCkxf6u9o7SiKQJIzCBN8vjPus7/kQ6XUBCa+Hc+vBHQXPDP9AeLyER2EsU
	kktFAbbrFN1+pHKdn962GOuVLiiJYjpatbMT5LukYP1mV97qt+J0Uu1gW3mEm1XI5bPs5CGAMvIXI
	3ktvUmccQGqs0cLiimdZJrD4dZ6GsOJ6JL8ZfbeY46MUKav+XyC0ZadIsciAfarTYfjvsZuBNzJ3m
	cix62cRLzvKycYVdlnjMZOj03PTY+JXpzcATt+aIsid1V7yUs6zwgxC/iCazAq/h1rwvKfyinRG+T
	7JIy8l3A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uePUK-00000005AjP-1633;
	Wed, 23 Jul 2025 02:45:48 +0000
Date: Wed, 23 Jul 2025 03:45:48 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	syzbot+fa88eb476e42878f2844@syzkaller.appspotmail.com
Subject: Re: [PATCH] hpfs: add checks for ea addresses
Message-ID: <20250723024548.GM2580412@ZenIV>
References: <20250720123426.132651-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720123426.132651-1-apokusinski01@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Jul 20, 2025 at 02:34:27PM +0200, Antoni Pokusinski wrote:

>  	ea_end = fnode_end_ea(fnode);
> -	for (ea = fnode_ea(fnode); ea < ea_end; ea = next_ea(ea))
> +	for (ea = fnode_ea(fnode); ea < ea_end && ea_valid_addr(fnode, ea); ea = next_ea(ea))

That looks really fishy.  If nothing else, your ea_valid_addr() is a range check;
are there any situations where we would want to allow fnode_ea() and fnode_end_ea()
be out of that range?

