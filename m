Return-Path: <linux-kernel+bounces-874457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 62325C16622
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A95804FF3D2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAF834AB1E;
	Tue, 28 Oct 2025 18:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="EreA7tfW"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F8D217F31
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 18:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761674575; cv=none; b=eh/azYDM+/2TGoGzSgqkDaTjj/SIeSeeqaCX9rzA0qpbljcsQ56/UUKTwHZJvejMfiF95l3HRBP45y+tQz/JI7GI6MgCS4XlCwU9BceH7bjWWvK77cD5MVWtAi4JcKNk5p5ud0Dv+NxC3JRcF0u11KAUjIWnRMQH258kqfPA8VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761674575; c=relaxed/simple;
	bh=DNGUKIcPvP6XXVdHXngvXFcoyF2dfLg67vBwGeHGowY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wjej1osuwTu178f8VuhZ70nFlvnPHDcxYzLdmbolrQGqh8mozPAFRHEayiyk0LhKKIWMIswVF289i+hEHHNuhfYuNym40tSCpWg7t2u5eJ4N1/t06uDJKvy7BwJHcHX9JeD4TV5jdcEShxlHNcKvklViHZxhEZ8HHH41Pd/B950=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=EreA7tfW; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DNGUKIcPvP6XXVdHXngvXFcoyF2dfLg67vBwGeHGowY=; b=EreA7tfWW8BmjNoCexpbjjymYR
	ljXUvDvR9p0qIALxlEgxC+UCjPYTBuo2pLiLtsrB+SSQyBU3047tQL2Fe3K4//URXetYSsPwvnKaH
	xPiKts8O7e7XtmMkrxQs7gxkcMWcn1FNlYXx3+8AyltU6yKT7AmOvlCyR0Z1iPdfYjOm2g5pC+0tm
	F+gUkoAwhFtxEdUfoMK8T/Omhd2uIBUyuvOs7IidCuEjruOUpLbJE5b+39gfAY5C9VaWJY6E29DX1
	gAw2ieCAVdm8MKclSPv/gQtwdrP1Xal3tjD44AxeZNW/cBK7K+01jAW9m3YpgO1ZsA/ppH9dYXtJf
	4WzuExYg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDo1y-000000098px-3dwW;
	Tue, 28 Oct 2025 18:02:50 +0000
Date: Tue, 28 Oct 2025 18:02:50 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: syzbot <syzbot+cd7590567cc388f064f3@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Forwarded:
Message-ID: <20251028180250.GO2441659@ZenIV>
References: <68fc0765.a00a0220.9662e.000d.GAE@google.com>
 <6900fc80.050a0220.17b81f.0037.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6900fc80.050a0220.17b81f.0037.GAE@google.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Oct 28, 2025 at 10:25:20AM -0700, syzbot wrote:
> For archival purposes, forwarding an incoming command email to
> linux-kernel@vger.kernel.org.

For fuck sake, either generate a more useful subject, or take
that to a separate list just for syzbot use.

Do you really intend to end up in a bunch of .procmailrc?

