Return-Path: <linux-kernel+bounces-753981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98123B18B33
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 10:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EC20621CAF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 08:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499561F12FB;
	Sat,  2 Aug 2025 08:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="YIu0tkQ8"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2152C19F48D
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 08:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754121852; cv=none; b=HoqXoMoxojXOGywdQYqm7H3OTK9tIsWQUkbph7H8N3ZokwoxGpHmSeMVO5KGJpPwrFaDiVCiW660LAp6BUs4aRvtv2irXYVKgHnOr0PrtoR9HqK+s5pQUyDIEDZQ7ERJjzAeVMCP9JsF31Mi0OcrWHkK8MhMqz6eHrEPcE0Cbvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754121852; c=relaxed/simple;
	bh=QoOUDAAVQSFOKK944c8AHx1DTv1o8j26q+nPpSqLgdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKnNWDxz73VLMd6uzYirKVreg+52dglrsVnxabiULe+ppcp400mHuOgAaGe6lFjOqIGq77Mj3lPTEoobgbkb8k4Uxoe0tdyOA226Fj+O88NTUdILpHLH7GdYAFYD9Mb9wshbH5wUw0tkBG7GXrtlIRvZ47NuT8VV9p5vAeWqZas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=YIu0tkQ8; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=QoOUDAAVQSFOKK944c8AHx1DTv1o8j26q+nPpSqLgdI=; b=YIu0tkQ8XBBV6NTImwERUTzEDX
	MBrb1/JAGqBVgG7TuztXPbv3+oOLwZgBWAWS3HIap2Pex+VFMEhxVWadUAtG8hmc7WXQfQIAvx6pC
	zt8ShWCi0ErBz+RhDG0d9OP+03eaG2Ji1XNcGVkZx7n+lhsVkZ9xbbgKneFyEY1gzQAMLeOr3Z2dv
	kPBTB3mScbPfcovC8MWcjMbw2Oh4D8jG/T6rlFFSmQ7p0JX9tGQHUKC9hdTB+fNqp9qAtv5qB24Hl
	9JL2l2PGHVsRiDpO6DbUDrK2ca3zlQk8oiCcr+lQXHzuVfiwHEXn6Bn/Bo8Ynw/3j640s+O6j4m1z
	1Ivp6h4g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ui7Dn-00000006hnY-2HoU;
	Sat, 02 Aug 2025 08:04:03 +0000
Date: Sat, 2 Aug 2025 09:04:03 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: =?utf-8?B?6auY57+U?= <gaoxiang17@xiaomi.com>
Cc: Xiang Gao <gxxa03070307@gmail.com>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"oleg@redhat.com" <oleg@redhat.com>,
	"mjguzik@gmail.com" <mjguzik@gmail.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
	"joel.granados@kernel.org" <joel.granados@kernel.org>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOiDnrZTlpI06IFtFeHRl?= =?utf-8?Q?rna?=
 =?utf-8?Q?l?= Mail]Re: [PATCH] pid: Add a judgment for ns null in pid_nr_ns
Message-ID: <20250802080403.GW222315@ZenIV>
References: <20250802022123.3536934-1-gxxa03070307@gmail.com>
 <20250802022550.GT222315@ZenIV>
 <15b18541f37447dd8d5dbd8012662f67@xiaomi.com>
 <20250802055252.GU222315@ZenIV>
 <c7968242db914979953277226fe55fc8@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7968242db914979953277226fe55fc8@xiaomi.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Aug 02, 2025 at 06:38:20AM +0000, 高翔 wrote:
> I see, but does adding the judgment for ns make the code more robust?

It's an impossible condition for anything that runs in a context where
get_current() is allowed, so... I don't see any benefit in adding it.

