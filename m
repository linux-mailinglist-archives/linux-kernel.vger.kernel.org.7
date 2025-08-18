Return-Path: <linux-kernel+bounces-772681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEA7B2960B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 03:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D51651963640
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 01:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE931F418E;
	Mon, 18 Aug 2025 01:15:51 +0000 (UTC)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1918D288A2;
	Mon, 18 Aug 2025 01:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755479751; cv=none; b=Hi4jDiAiowqJij1bBRK+s9J95XFftArUycbdqGged91tUz6o5kBo0SkduW6P+wif/8kqJf0rLj6Zf1diyFnkC02fhWDhG63M/rhnXtdnB9YTIEaiol8Rtv8FdE5gPcclXVRi5MNyZHcICNW6kyOyhkG5CDKP7+WGjKPxCH/JuA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755479751; c=relaxed/simple;
	bh=re+a3hWvgegvjpaptPnpkLKcIKZ7lfEQo+cdRQVOra0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GD6OF340AQyyoGtd1+FGrs5GJaeSxopi3iLyHCuCN+cTk2WUx3gehqZLh8sup33oi4ri5dDOgTFuQsS90ezRvkzHLtpTdAZ+S3GcPeSBT235YYWgsSG4QiajnAZuwmj3McRvVMpXd7RK4pPVnVjbm4PNglUKInURH0JNHqIwN5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz8t1755479679t304d19fa
X-QQ-Originating-IP: U+HouEQjyiYAmzyTLPl5BSeqSP+HEtl38Pp5dE5JTBQ=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 18 Aug 2025 09:14:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10326870123005562293
Date: Mon, 18 Aug 2025 09:14:37 +0800
From: Yibo Dong <dong100@mucse.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] net: rnpgbe: Add n500/n210 chip support
Message-ID: <154C964FB97A8BAE+20250818011437.GA1370135@nic-Precision-5820-Tower>
References: <20250814073855.1060601-1-dong100@mucse.com>
 <20250814073855.1060601-3-dong100@mucse.com>
 <a0553f1d-46dd-470c-aabf-163442449e19@lunn.ch>
 <F74E98A5E4BF5DA4+20250815023836.GB1137415@nic-Precision-5820-Tower>
 <63af9ff7-0008-4795-a78b-9bed84d75ae0@lunn.ch>
 <67844B7C9238FBFB+20250815072103.GC1148411@nic-Precision-5820-Tower>
 <ade28286-33b9-421c-9f3f-da7963a69d4e@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ade28286-33b9-421c-9f3f-da7963a69d4e@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MbQ6VWviL2slGqhyV++OhRr+yjnS6ZWEM+HzcX5GvEHMAr8vGo0URgJO
	eZz0WTzDjEW+0rlf7lA9GGM6kMi42yGHCPoAxD4Nm0YbBh+XhvBDlcj/AFsCA9EBN5aTRnu
	mBw5DMBwuV1yv3YTdnqAE0p0d8wlbhdDW7aRJmRO6ZaHGQWS/DHASVsh0f7aUERAzLq9fL2
	Dl0ZybfO0Ywh3kszttdHSGD4Msf7OhvqG+gNqHAnablr59EDRNhN/a7KlTake+jxXrfYqWJ
	MVeU3u4QSbZFHRZsZhga/JsdzYg9CM4Jn3EvzuDibneV0cyIapz0Wp9ptTwqrNUXsQRtIXj
	+9wWUvdAvUjY+9Ah3UXzoxsy3cSzApXKhKRvjnycyvuGabun4VgKLw7v6xbRJ4dNF5KesCt
	iLEx6AyhIzRhK5bQX7Uv0UIF3JIf0jsnv0n3ynQP5jnp8rN9nP5EHBMC34QMMH711ED7R9g
	rNJjAnWNiNMzCeHFSkO+tCn2y7qd9rSUFnSmmZu5sU7Fd84xlK/Bh75+NyKHZkyut9i+VeJ
	OL9hXzG5E6zr60Fsrm7pDOD1QOS9WBIHCIgCm9A2kyw1Xff92gcNlexJ/PR0HBRcWSgbKh1
	ey2lJayXkUT7jzsaO9fpNZJ5ODtjeb0DR/8PVQJGlDGIYJLQVp7jAoZjVNSLhFXahDk+xwN
	DSjw5ss21LmJLt/OZsHgYymV6uTfdZb+0e1fFDeTBlhdVLrTfztaxyj1COfUSzTSssLxaU9
	ufZs08AdhayrmctuqdOr83Wviw//uVtafCA4Ph9owQhvYgXFSwxi7VNbR2N+K4LIiCBIRAL
	BC6v3J4iQhxy6sOyFRAQlDbrcD4hzwXj9xHirG+5+x+MOS/tVzaVUlgxPI8aXOnlCRBiIAe
	o6taEsAxDJtVZ1T5l1EQke0637YfDTNFMgJ1gEBlB7hY/V3HGGwQ9hlAgXzN2LSQP7yAUgC
	GoTDXA6OBwadrN+QdwzNaaQ6Cjqk5CVRus9HPBJlyUF1t4ORHd9Thg8L44XwOtX1JzDwm0P
	h7t+erRNQVhD39NLcm1XnYo2p5/hP+hyaj2ZjVplPuVdkLInbysqEOol6eNcqW1/WNQmS3U
	A==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

On Fri, Aug 15, 2025 at 03:36:10PM +0200, Andrew Lunn wrote:
> On Fri, Aug 15, 2025 at 03:21:03PM +0800, Yibo Dong wrote:
> > On Fri, Aug 15, 2025 at 05:56:30AM +0200, Andrew Lunn wrote:
> > > > It means driver version 0.2.4.16.
> > > 
> > > And what does that mean?
> > > 
> > > > I used it in 'mucse_mbx_ifinsmod'(patch4, I will move this to that patch),
> > > > to echo 'driver version' to FW. FW reply different command for different driver.
> > > 
> > > There only is one driver. This driver.
> > > 
> > > This all sounds backwards around. Normally the driver asks the
> > > firmware what version it is. From that, it knows what operations the
> > > firmware supports, and hence what it can offer to user space.
> > > 
> > > So what is your long terms plan? How do you keep backwards
> > > compatibility between the driver and the firmware?
> > > 
> > > 	Andrew
> > > 
> > 
> > To the driver, it is the only driver. It get the fw version and do
> > interactive with fw, this is ok.
> > But to the fw, I think it is not interactive with only 'this driver'?
> > Chips has been provided to various customers with different driver
> > version......
> 
> They theoretically exist, but mainline does not care about them. 
> 
> > More specific, our FW can report link state with 2 version:
> > a: without pause status (to driver < 0.2.1.0)
> > b: with pause status (driver >= 0.2.1.0)
> 
> But mainline does not care about this. It should ask the firmware, do
> you support pause? If yes, report it, if not EOPNOTSUP. You want to be
> able to run any version of mainline on any version of the
> firmware. This means the ABI between the driver and the firmware is
> fixed. You can extend the ABI, but you cannot make fundamental
> changes, like adding new fields in the middle of messages. With care,
> you can add new fields to the end of an existing messages, but you
> need to do it such that you don't break older versions of the driver
> which don't expect it.
> 
> Please look at other drivers. This is how they all do this. I don't
> know of any driver which reports its version to the firmware and
> expects the firmware to change its ABI.
> 
> So maybe you should just fill this version with 0xffffffff so the
> firmware enables everything, and that is the ABI you use. Does the
> firmware have an RPC to get its version? You can then use that for
> future extensions to the ABI. Same as all other drivers.
> 
> 	Andrew
> 

Ok, I will fill 0xffffffff in mucse_mbx_ifinsmod to echo firmware.

Thanks for your feedback.

