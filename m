Return-Path: <linux-kernel+bounces-730630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18897B0475B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 20:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C34917F0FF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 18:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D30A270578;
	Mon, 14 Jul 2025 18:21:05 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B13325B1FC;
	Mon, 14 Jul 2025 18:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752517264; cv=none; b=t4NWTuyN2KWz6Fs+GzTKYTXFyz8519UW7zQIrlHrCmPga3HS6PhTLAcSGJCDZoUNNon+uJOejNb4fyNnm5D1mZk9UvaIpTdRJG4YY4CcHCRb91AZ2NaApxdP37fiYFpPAHTArUrZpCDjgrtMxKaouOlcb7k6TFfsfUVK8j7M5ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752517264; c=relaxed/simple;
	bh=NAxieNvCStZ9yHKTgDadvfqNRmd2PfOXbQvodUZZ7CU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jRUOxOchjBhMbKi8Y3j23zEUFKAGIoPmIIwsfi9fb9BVQzIcq0YyTzTEDz/1nw0lE8k9MpgRXNAgGTKMy1oGowDZI3ttIobimY8QnWKn1f628HCRvgR2MynB7IJVWdTo0xKAH5jfgmK70i0ClV9jE4rbKs7qsSp+jMFEOzuQe8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bgrFj4k7fz6L4st;
	Tue, 15 Jul 2025 02:19:53 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D50D2140142;
	Tue, 15 Jul 2025 02:20:58 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 14 Jul
 2025 20:20:58 +0200
Date: Mon, 14 Jul 2025 19:20:56 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Stephen Rothwell <sfr@canb.auug.org.au>, Lothar Rubusch
	<l.rubusch@gmail.com>, Andy Shevchenko <andy@kernel.org>, "Linux Kernel
 Mailing List" <linux-kernel@vger.kernel.org>, Linux Next Mailing List
	<linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the iio tree
Message-ID: <20250714192056.00000a78@huawei.com>
In-Reply-To: <aHS9TZWsKThHilpQ@smile.fi.intel.com>
References: <20250714181341.1d10df2a@canb.auug.org.au>
	<aHS9TZWsKThHilpQ@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 14 Jul 2025 11:18:21 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Jul 14, 2025 at 06:13:41PM +1000, Stephen Rothwell wrote:
> > 
> > After merging the iio tree, today's linux-next build (htmldocs) produced
> > these warnings:
> > 
> > Documentation/iio/adxl313.rst:230: ERROR: Error in "code-block" directive:
> > maximum 1 argument(s) allowed, 11 supplied.
> > 
> > .. code-block:: bash  
> 
> + blank line here should fix it I think.
> Same for the rest.

Thanks. Fixed up and new tree pushed.


> 
> >         root:/sys/bus/iio/devices/iio:device0> echo 1.28125 > ./events/in_accel_mag_rising_value
> >         root:/sys/bus/iio/devices/iio:device0> echo 1 > ./events/in_accel_x\|y\|z_mag_rising_en  
> >   
> >         root:/sys/bus/iio/devices/iio:device0> iio_event_monitor adxl313  
> >         Found IIO device with name adxl313 with device number 0
> >         <only while moving the sensor>
> >         Event: time: 1748795762298351281, type: accel(x|y|z), channel: 0, evtype: mag, direction: rising
> >         Event: time: 1748795762302653704, type: accel(x|y|z), channel: 0, evtype: mag, direction: rising
> >         Event: time: 1748795762304340726, type: accel(x|y|z), channel: 0, evtype: mag, direction: rising  
> 


