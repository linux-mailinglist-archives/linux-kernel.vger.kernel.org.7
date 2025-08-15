Return-Path: <linux-kernel+bounces-770087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06950B2769C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE058628CD6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E9429D29D;
	Fri, 15 Aug 2025 03:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KM5sqvmZ"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C3B29CB3A;
	Fri, 15 Aug 2025 03:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755227592; cv=none; b=NJtfnCNim6USoz9P3nvCB2Bc+DFUqwYjYp2TmSXbwWttwWBFP6AdoT/WaduvJXwY7VdJYVjs8RCc22z11KQEj8UEJLKCAleDQazMnKCy4y/oLf1/v4OpTeh7mevqEhXdYbet24fan3sm7HHzVhyJrdoNsjsZacl5YmMYJP09ogw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755227592; c=relaxed/simple;
	bh=bK5MUMffMIG52ZvazOBSyKQOIQq1ccOmmUYSL4k85vk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=feKyilh0YkKx/kHm11BnYQ/S6Z/lVlkH+xSQHea6/JRnXq0RRLIUrWbW3yI4w4MEtleDMRBH/QTQ1LOunFxIqzU74i2E/epa3KvygC5D4e8b0CwKfP2rrN2RiXqgSU8ugcCN8r4suyC1crec7d9Y5UU6+t+q5s/xFsOAWj/mjz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KM5sqvmZ; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57F3D4eQ2522137;
	Thu, 14 Aug 2025 22:13:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755227584;
	bh=tlIHiZicXqonxoIZ8gXjkv3nF3NV4zWaAnN3p0bvutQ=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=KM5sqvmZklivQ31BBInk2GRL+teaOmiynz9Z07o/F5CCSkcTz8uJZTlidO/9r8YDN
	 p5a9Mqk69vmOJlf1rJAjZ13iJiLXGFoFY1A9Fb8iRYkRmt7A0jlTuvw8eFTVCUg+Q0
	 cILXlRbX3mKodeiikqxjQfGnydfNPlk05WXKprCk=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57F3D4CR2294493
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 14 Aug 2025 22:13:04 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 14
 Aug 2025 22:13:03 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 14 Aug 2025 22:13:03 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57F3D3nd390516;
	Thu, 14 Aug 2025 22:13:03 -0500
Date: Thu, 14 Aug 2025 22:13:03 -0500
From: Nishanth Menon <nm@ti.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
CC: Beleswar Padhi <b-padhi@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <afd@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 33/33] arm64: dts: ti: k3-j7*-ti-ipc-firmware: Switch MCU
 R5F cluster to Split-mode
Message-ID: <20250815031303.ms6ieu4iovho5mp6@desolate>
References: <20250814223839.3256046-1-b-padhi@ti.com>
 <20250814223839.3256046-34-b-padhi@ti.com>
 <f49bf01b-6704-4a03-9b3d-7f7495e544e0@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f49bf01b-6704-4a03-9b3d-7f7495e544e0@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 08:11-20250815, Kumar, Udit wrote:
> 
> On 8/15/2025 4:08 AM, Beleswar Padhi wrote:
> > Several TI K3 SoCs like J7200, J721E, J721S2, J784S4 and J742S2 have a
> > R5F cluster in the MCU domain which is configured for LockStep mode at
> > the moment. The necessary support to use MCU R5F cluster in split mode
> > was added in the bootloader. And the TI IPC firmware for the split
> > processors is already available public.
> 
> It will be better to mention sha id of bootloader with links, may be below
> tear-line

In the commit message, let us stick to just what the kernel folks need
to know. Specifics of bootloader etc can belong to the diffstat -
unless the patch has direct relationship to the bootloader in some form
and we need to refer to that details in git log in the kernel (the
diffstat and discussion information is already on public-inbox if anyone
wants to do "deep research" :P ).

Device Tree is about describing hardware. Let us keep it to that.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource

