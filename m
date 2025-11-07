Return-Path: <linux-kernel+bounces-890702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC66BC40B1C
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 16:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B70418824F2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 15:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB18623506F;
	Fri,  7 Nov 2025 15:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="QDhG0AYy"
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696D132E73D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 15:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762530902; cv=none; b=SmE3FgMXezkVYoXeBeghTby57qJ03zvQC4a6OagW/s67B/LIWuSv8AOWa+Wvn58zjiZhHhxenNyv7uoI4uQC1O1tW/C8o9AtfLf2kl4/Vq3PdJI0JMgjyeb1TnThaEdYb0LcdVJ/EOne3dbmjGmWqq7JIySVreM3Qpnyh6KA5HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762530902; c=relaxed/simple;
	bh=D9oq68VrORbAYW4+VlHxCsq/enrwgz5myr/oEzlR8GU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/0VjV5Gf+C7C8efZzAoxJKUtK705ySOy+fHCwmk9X90FJVooyt5pXQLzlXLIAFQpvnklUoBAMbhQ9DGQVgIqsBGXJoa1/Kr5iZQZnA9H61USsdacfTrr2f6JO1EsBHcKqNuRkD6QR1wWa3HgLh0AXhg7HMOt1uxFI+N3mijIug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=QDhG0AYy; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1762530890;
	bh=x5wU+8XhNn87+1HQLINKbrKQAzx0N1ebWVPXX+dgJtI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=QDhG0AYyG2bmrQHoIwHUfAUBtq+2lI9a8i4+jGXTnoIDZh0Gc0oePgIdAlnQ1uGb6
	 FXupU1QWpFRz/gCM7XqtY7uhKuM39ep0Ar0dTbU+3PLXUU+QitfDxIAboPVxtWDIr8
	 mjzcL6oE2qn3ayAEFVAbt/fbY6rRgdFhM8Zr3zQo=
X-QQ-mid: zesmtpip3t1762530885td6bbd925
X-QQ-Originating-IP: AVnxMsCEYCH+Te+U4txA0lr7Lg9JiGfupg08FrYRM88=
Received: from = ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 07 Nov 2025 23:54:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14462180775243901098
EX-QQ-RecipientCnt: 16
Date: Fri, 7 Nov 2025 23:54:43 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Xuyang Dong <dongxuyang@eswincomputing.com>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Krzysztof Kozlowski <krzk@kernel.org>, mturquette@baylibre.com,
	sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, bmasney@redhat.com, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com,
	huangyifeng@eswincomputing.com, pinkesh.vaghela@einfochips.com
Subject: Re: Re: Re: [PATCH v7 0/2] Add driver support for ESWIN eic700 SoC
 clock controller
Message-ID: <AF4FD688167B825E+aQ4WQ7qbYqtHbSKl@troy-wujie14pro-arch>
References: <20251023071658.455-1-dongxuyang@eswincomputing.com>
 <1abb85b.c11.19a582bcbbc.Coremail.dongxuyang@eswincomputing.com>
 <039a3a41-c60f-4296-afd9-2bf3467574ca@kernel.org>
 <6d2d7ddb.cbd.19a5cf92465.Coremail.dongxuyang@eswincomputing.com>
 <1618037D174FDF5F+aQ2hU1J9oLEKCq25@kernel.org>
 <5a9911a3.d09.19a5d8d32cd.Coremail.dongxuyang@eswincomputing.com>
 <6C7E97902D2C1367+aQ3EYikxWNtINfyj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6C7E97902D2C1367+aQ3EYikxWNtINfyj@kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NwBLjZV1DHf5Z/E9sfbRdiJNwQVJv0GL/oIX4OKaT3mObSJ20pl9Xi1P
	rBNfPYz9vP+qxO2XFSXZwz84v6sV5UUrN/zUK+uHfK9joog5uIZ3ongbRrALZfwk3AmcfYC
	5emfK9XdrlTGaSqcXWd9q7DANwUupqsvBIhFvYeICCuJNNNWZq7ZoLMOz3EB+jswljd0BnQ
	XrgNs+RU0soOq+kXDy7MCJLhDuCoBqsd+QOsfddBihUUmOCJTnM8cUkCAtm9m1HrLk8x4ZJ
	HAYoq5+aJmQ6d0uvipY1T3/X7cFuqShuQjvFNyVWMVBKSFQkncNQO5qShULFRl6YWUHIyV3
	eOK6gWHm1P9xp1ljOpC3ILsqI4Ty7+Y3gsmIJfcioozDoWAnxXAFkUpv8Lis6RPn/EMzBq7
	UcgdENz5Cmy8J64/pXBy0ZhKgtN3hAG4B6qSjBTsC7O+EOM835cdmIaVu/i58M9SQ3LGyYG
	sZEwwtQHOMp9y1rL6nNzLY3PQNuFUAE+/MOiP9o0Nos2KJ1nf5Q8Yo3hSuGJaCKIBupeFvw
	qHLVvExu6ie1ei4rfXVhxglWr3oghElLXbZk+Xtv6gFTgqx4H8PDf6EbaQGcyf6qfWx06Gq
	QzXmP4bg33ug3SnjeODrpeXIb1qLkMf6gFSJMLhmJCfST/sUxeT/9crdOGNBu03D1owTxmr
	OKttheFsGBMiiVdEBYTnNQjmVcpYEsL7rAMyUv47NIJIt/Y6bthW3/u+lrDRLq6hEul91Hz
	64c4XmL52F5u9C6xcpNI/e1cPhY3dM6zli6Kgm/wwRzNBVWjI8SIlKTZbRchqnfrbNyZkAb
	o2o34CmyLvuCI1XeMHuCEMq0tMmPhSif2e5h4U65Emq2UY4rJxxLSrdbVxtHyCcn3jKbTO5
	XYQKSzWsE81/8Wi28eSMYztkW0ULcvvLqRIKKqftMMzz+TPaHlrx7P8cmglzvpnnPfrt3gu
	Z/PGsMLGN1HkZkvqohbVj+DMKvJ2FDCxcddIvmEqf5Cjz/gGTOZcqDVjVDTxpBu8bBs7Y3X
	c6QTWucKOwrRlafUzBaHNapwgiqaQ6UdXRJZnkYx8bnJOTah8joHagrLAhw0022rObYMO9G
	0EYNdzPa3c08iwdSEslvBl9H++4nu0csDuFAyfo4WkxlMiTGT0WJkXNSSEvPItzPQ==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

On Fri, Nov 07, 2025 at 06:05:22PM +0800, Troy Mitchell wrote:
> On Fri, Nov 07, 2025 at 05:02:06PM +0800, Xuyang Dong wrote:
> > > > > > 
> > > > > >   Gentle ping. Looking forward to your reply. Thank you very much!
> > > > > 
> > > > > Please do not top post.
> > > > > 
> > > > > You did not add any maintainers of these drivers, so I would not put it
> > > > > high on our priority list. 
> > > Do you have any plans to become a maintainer? If so, this patch might get
> > > reviewed with higher priority. I think that's what Krzysztof meant.
> > > 
> > >                               - Troy
> > 
> > Hello Troy,
> > 
> > Yes, I plan to become the maintainer for this driver. I will add my 
> > maintainer information to the MAINTAINERS file in the next patch series. 
> > Would that be acceptable?
> I think yes.
> 
> And if you send next version, please dont't send to this email:
                                       ^^^^ no "don't" here..
> troy.mitchell@linux.dev instead of linux.spacemit.com.
> 
> Thanks.
> 
>                               - Troy
> > 
> > Regards,
> > Xuyang Dong

