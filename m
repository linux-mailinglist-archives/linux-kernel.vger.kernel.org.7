Return-Path: <linux-kernel+bounces-850040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 769FDBD1B27
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 40CA54E01F2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 06:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467392E0923;
	Mon, 13 Oct 2025 06:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jwMw3vBY"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EC82BD580
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760337488; cv=none; b=B1WlZo3Bp1Jugv0/soGQ0sPr7JXnS0S9DJysl8hHO5kR3hVVOZYPk74UrZ9WyT7XBwg/NVXoEgKNYQfb67y3/XbCe00gUvo1QW6qmzbFFQCSKJC66xZwEQUmDIzGldENfE+bYmLs1jwHg+cWOfiZ/+9DZaQFRQiGTICHAocpMDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760337488; c=relaxed/simple;
	bh=PoXDgsc5eaObsurpEUKu6JNwPOIyDY+VICtRK1J9xVc=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=n27W05KQ9bgJGURvv4OXpetCluwT0troGVILlc14pMQ0fdGS6aLmtbS/UdEKvxPQOJDVyiDhQ94N9MU8dWc3EaD/i/Wp+Xc0oKTAd341asEHfM2JyuShX4CSALz7Ei712lraqFiz0u3SO89qdON740hYv+9tZUWWCcS9zcUgslM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=jwMw3vBY; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20251013063217epoutp011bcaf15cdf6ec42b3dc9e574fc9e241d~t_UyvvmHx3025130251epoutp01V
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:32:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20251013063217epoutp011bcaf15cdf6ec42b3dc9e574fc9e241d~t_UyvvmHx3025130251epoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1760337137;
	bh=PoXDgsc5eaObsurpEUKu6JNwPOIyDY+VICtRK1J9xVc=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=jwMw3vBYFmeQbmOP+4Pzn948y1FCK+Y4eXbPpUxW29OCKt0Mspmx4/grPaAEF19KU
	 1V1zaTE+Z4jTQUXWeyWHJWUWRKtRU0j3XH3BhvssDfimHvJb/PBPKlhca9rCtcDOW3
	 6ysi0y6XEUCq2IazdyE6BaFrJbvAzTNoUATktsDQ=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPS id
	20251013063216epcas1p2ff5acf8cd650d82076337707f247e55d~t_UyUMzhq1189711897epcas1p2C;
	Mon, 13 Oct 2025 06:32:16 +0000 (GMT)
Received: from epcas1p3.samsung.com (unknown [182.195.38.109]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4clSFD0VBlz3hhTF; Mon, 13 Oct
	2025 06:32:16 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE: [PATCH] extcon: Fixed extcon duplicate issue
Reply-To: myungjoo.ham@samsung.com
Sender: MyungJoo Ham <myungjoo.ham@samsung.com>
From: MyungJoo Ham <myungjoo.ham@samsung.com>
To: Michael Wu <michael@allwinnertech.com>, Chanwoo Choi
	<cw00.choi@samsung.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20251011053719.87055-1-michael@allwinnertech.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20251013063215epcms1p772dcb340914ecf5f5211dc2fdf052ce6@epcms1p7>
Date: Mon, 13 Oct 2025 15:32:15 +0900
X-CMS-MailID: 20251013063215epcms1p772dcb340914ecf5f5211dc2fdf052ce6
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-361,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251011061953epcas1p100a774e1790cd78ccfd9f836bb29c693
References: <20251011053719.87055-1-michael@allwinnertech.com>
	<CGME20251011061953epcas1p100a774e1790cd78ccfd9f836bb29c693@epcms1p7>

>extcon_dev_ids may re-alloc to another while this device unregister not complete
>
>The right timing shows below:
>on extcon_dev_register: ida_alloc -> device_register
>on extcon_dev_unregister: device_unregister -> ida_free
>
>stack information when an error occurs:
>sysfs: cannot create duplicate filename '/class/extcon/extcon1'
>CPU: 7 PID: 222 Comm: init Not tainted 6.6.77-android15-8-g9fab1123989e-ab13366090-4k #1 bbfe3ef014a40c2f67534a3e01169790ce021aeb
>Hardware name: sun60iw2 (DT)
>Call trace:
> dump_backtrace+0xe8/0x108
> show_stack+0x18/0x28
> dump_stack_lvl+0x50/0x6c
> dump_stack+0x18/0x24
> sysfs_warn_dup+0x68/0x88
> sysfs_do_create_link_sd+0x94/0xdc
> sysfs_create_link+0x30/0x48
> device_add_class_symlinks+0xb4/0x12c
> device_add+0x1e0/0x48c
> device_register+0x20/0x34
> extcon_dev_register+0x3b8/0x5c4
> devm_extcon_dev_register+0x4c/0x94
>
>Signed-off-by: Michael Wu <michael@allwinnertech.com>



Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

Cheers,
MyungJoo

