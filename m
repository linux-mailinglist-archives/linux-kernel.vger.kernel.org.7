Return-Path: <linux-kernel+bounces-846609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2262CBC884C
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 12:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DAA014E4503
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 10:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9482D73A5;
	Thu,  9 Oct 2025 10:36:05 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866152C11E1
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 10:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760006165; cv=none; b=HHaM8cp68AAG+uNt0kZU15FcLb5m8ld6A0vNnyKtOn28zU2iPVXUdyeQJ9ro33v39rRs1mRRYvnklTHCQskQ+Kz3teqnt8RJ3ERcbax9vzQ+RvZIaI0mubt3TLg2+J/zXizV8NC9oHXex9UAb8NlYmJhrkF/A1SkNzZ0wR+9RTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760006165; c=relaxed/simple;
	bh=7/8WVhR6YNZCUUqxRBuIWw0Py6gnrfnJypI/Eia9nAc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KfdLxhk/rBwrImc1z5mWhIKATjz6TShHGgAO7gIkWGytvH9wvbZlOjl2GVJ/phesU35ITD6ujeYZnz3Erg0W6dR4blo1+cZXeGUoBzxuDCX9XGV4s8z5/HmHhNEoSmdEHGb4VdxtDExFtxcia3y9q3ZjRRc0adCEfumeQZBUQGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cj5nJ5c6kz6GCtF;
	Thu,  9 Oct 2025 18:33:24 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 27D1F1400CA;
	Thu,  9 Oct 2025 18:36:00 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 9 Oct
 2025 11:35:59 +0100
Date: Thu, 9 Oct 2025 11:35:57 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
CC: <linux-coco@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Steven Price <steven.price@arm.com>, "Gavin
 Shan" <gshan@redhat.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, "Jeremy
 Linton" <jeremy.linton@arm.com>, Sami Mujawar <sami.mujawar@arm.com>
Subject: Re: [PATCH] coco: guest: arm64: Update ARM CCA guest driver
Message-ID: <20251009113557.000053e6@huawei.com>
In-Reply-To: <yq5aldlka6oi.fsf@kernel.org>
References: <20251008132758.784275-1-aneesh.kumar@kernel.org>
	<yq5aldlka6oi.fsf@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 09 Oct 2025 12:43:49 +0530
Aneesh Kumar K.V <aneesh.kumar@kernel.org> wrote:

> "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> writes:
> 
> > Make preparatory updates to the ARM CCA guest driver:
> >
> >  - Switch from using a platform device to a faux device (based on
> >    feedback in [1])
> >  - Rename the device from `arm-cca-dev` to `arm-rsi-dev`, so that the
> >    host driver can register an equivalent `arm-rmi-dev`
> >
> > These changes are purely structural and introduce no new functionality.
> > Subsequent patches will extend this driver to add guest device
> > assignment support.
> >
> > [1] https://lore.kernel.org/all/2025073035-bulginess-rematch-b92e@gregkh
> >  
> 
> I noticed that, this will break autoloading of the driver. 

Ah indeed.  You'd need to arrange for the arch code to call the init()
directly (possibly arch_initcall() as before or maybe directly from
arm64_rsi_init), which makes it tricky to do in a module as there
is nothing to kick off module autoloading. You could kick that off
explicitly but that's a bit ugly.

Jonathan



