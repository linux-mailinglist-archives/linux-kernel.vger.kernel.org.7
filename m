Return-Path: <linux-kernel+bounces-614087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49941A965ED
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 12:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03355188C56D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 10:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABF92144BB;
	Tue, 22 Apr 2025 10:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EfgEK072"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EA32139CE;
	Tue, 22 Apr 2025 10:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745317677; cv=none; b=lWX6i2ZiWKHciNX3B2JB1so8oJGtN0vapXeV4qdFWw4xHEVP68QVThUCRrGCfBNCUiC9yy/CTp95kWCnkcIvwytVOhHD77fenVDr1kPXx2Rq+w/3RLi4InrIvhyNP2pED008s2TJ/mrHvOFW9463/R+iWDiknY4fBBr6I1t3dWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745317677; c=relaxed/simple;
	bh=B2UZi9ugbozdfNpiJDP5cOj3pRIQYoJbDLco0LpvDNM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lpj9klk7d7ShpJpN8fsbgidVCacS9cjubnp4azHZjzXAVjVrs62WvfgeqyOuRyUEZvszj7I+GFEgKrmHkYFX0zD4LgBAM9XI2jL4jRkNAF5y94vP0zKroux6dZbOpK/aG5pzvzhfXVqH6K3w7ARG5P11ms1F8u/A3ApMmvn0/m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EfgEK072; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53MARlGm1181497
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 05:27:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1745317667;
	bh=+tqEJztsEGWVhO4AAXHU0QU5LU+OnvvfKfNHDEDrh+I=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=EfgEK072ZvCgXi6UPy5O9lKiZLuZ3SpBheWeO8X1yZ3jramrmXyXkVRHDBiVBQKlK
	 EtIpygt05eMkYrYipLoI7pEqy7lkK0ixc7uFZ4RDzspHHaxi2ey/JwrkTC04eeFdmb
	 Mir8OGBUqYtmc4+3wbPsn0ujb/4gYVkDwe77QL60=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53MARlxQ006133
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 22 Apr 2025 05:27:47 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Apr 2025 05:27:46 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Apr 2025 05:27:46 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53MARj4Y125210;
	Tue, 22 Apr 2025 05:27:46 -0500
Date: Tue, 22 Apr 2025 15:57:45 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>
Subject: Re: [PATCH 2/7] arm64: dts: ti: k3-j7200-main: switch to 64-bit
 address space for PCIe1
Message-ID: <7f6ea98c-df6d-4c94-8f42-76cc8306b6c4@ti.com>
References: <20250417120407.2646929-1-s-vadapalli@ti.com>
 <20250417120407.2646929-3-s-vadapalli@ti.com>
 <8b707fbc-9d82-48d0-a227-366d4e83e8a7@ti.com>
 <231e009e-0dc2-4876-b052-d11b64ee5a0a@ti.com>
 <d517b2bb-2bf2-44ec-8509-6281c5566972@ti.com>
 <8d43fdc6-760d-49cd-b4f5-95d13a52220b@ti.com>
 <8c7b68fc-c275-45c3-830a-3ea3174f38f5@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c7b68fc-c275-45c3-830a-3ea3174f38f5@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Mon, Apr 21, 2025 at 01:29:47PM +0530, Kumar, Udit wrote:
> 
> On 4/20/2025 7:48 PM, Siddharth Vadapalli wrote:
> > On Sun, Apr 20, 2025 at 10:17:46AM +0530, Kumar, Udit wrote:
> > > Hello Siddharth
> > > 
> > > On 4/20/2025 8:33 AM, Siddharth Vadapalli wrote:
> > > > On Sat, Apr 19, 2025 at 11:35:50PM +0530, Kumar, Udit wrote:
> > > > 
> > > > Hello Udit,
> > > > 
> > > > > On 4/17/2025 5:34 PM, Siddharth Vadapalli wrote:
> > > > > > The PCIe0 instance of PCIe in J7200 SoC supports:
> > > > > > 1. 128 MB address region in the 32-bit address space
> > > > > > 2. 4 GB address region in the 64-bit address space
> > > > > > 
> > > > > > The default configuration is that of a 128 MB address region in the
> > > > > > 32-bit address space. While this might be sufficient for most use-cases,
> > > > > > it is insufficient for supporting use-cases which require larger address
> > > > > > spaces. Therefore, switch to using the 64-bit address space with a 4 GB
> > > > > > address region.
> > > > > > 
> > > > > > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > > > > ---
> > > > > >     arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 7 ++++---
> > > > > >     1 file changed, 4 insertions(+), 3 deletions(-)
> > > > > > 
> > > > > > diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> > > > > > index 5ab510a0605f..e898dffdebbe 100644
> > > > > > --- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> > > > > > +++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> > > > > > @@ -759,7 +759,7 @@ pcie1_rc: pcie@2910000 {
> > > > > >     		reg = <0x00 0x02910000 0x00 0x1000>,
> > > > > >     		      <0x00 0x02917000 0x00 0x400>,
> > > > > >     		      <0x00 0x0d800000 0x00 0x00800000>,
> > > > > > -		      <0x00 0x18000000 0x00 0x00001000>;
> > > > > > +		      <0x41 0x00000000 0x00 0x00001000>;
> > > > > >     		reg-names = "intd_cfg", "user_cfg", "reg", "cfg";
> > > > > >     		interrupt-names = "link_state";
> > > > > >     		interrupts = <GIC_SPI 330 IRQ_TYPE_EDGE_RISING>;
> > > > > > @@ -778,8 +778,9 @@ pcie1_rc: pcie@2910000 {
> > > > > >     		device-id = <0xb00f>;
> > > > > >     		msi-map = <0x0 &gic_its 0x0 0x10000>;
> > > > > >     		dma-coherent;
> > > > > > -		ranges = <0x01000000 0x0 0x18001000  0x00 0x18001000  0x0 0x0010000>,
> > > > > > -			 <0x02000000 0x0 0x18011000  0x00 0x18011000  0x0 0x7fef000>;
> > > > > > +		ranges = <0x01000000 0x00 0x00001000 0x41 0x00001000 0x00 0x00100000>, /* IO (1 MB) */
> > > > > > +			 <0x02000000 0x00 0x00101000 0x41 0x00101000 0x00 0x08000000>, /* 32-bit Non-Prefetchable MEM (128 MB) */
> > > > > > +			 <0x43000000 0x41 0x08101000 0x41 0x08101000 0x00 0xf7eff000>; /* 64-bit Prefetchable MEM (4 GB - (129 MB + 4 KB)) */
> > > > > Sorry for novice question,
> > > > > 
> > > > > with this change,  How do you see  old EP working which supports 32 bit
> > > > > addressing,
> > > > > 
> > > > > or some translation is possible ?
> > > > > 
> > > > > 0x43000000 0x41 0x08101000 0x41 0x08101000 0x00 0xf7eff000>
> > > > > 
> > > > > to
> > > > > 
> > > > > 0x63000000 0x00 0x08101000 0x41 0x08101000 0x00 0xf7eff000>
> > > > I didn't understand the question completely, but I shall try to explain
> > > > the changes being made which might possibly answer your question.
> > > If I understood well then what you are doing here
> > > 
> > > 0x43000000 0x41 0x08101000 0x41 0x08101000 0x00 0xf7eff000>
> > > 
> > > PCIe address
> > > 0x43000000 0x41 0x08101000 -->
> > > Property 0x43
> > > 0x43 as npt000ss ->relocatable, prefetch and 64 Bit memory space PCIe Bus address  0x41 0x08101000
> > > CPU address space 0x41 0x08101000
> > > This will work fine, if EP supports 64 bit addressing scheme.
> > > 
> > > In case, we want to work with EP of 32 Bit, Then do you see , we need to relocate PCIe (lower 32 bits) to CPU address (64 bits)
> > A total of 3 Address Regions have been defined:
> > 1. 1 MB IO in the 32-bit PCIe Bus Address Space
> > 2. 128 MB Non-Prefetchable MEM in the 32-bit PCIe Bus Address Space
> > 3. (4 GB - 129 MB - 4 KB) Prefetchable MEM in the 64-bit PCIe Bus
> > Address Space
> > 
> > '1' and '2' above provide backward compatibility with Endpoint Devices
> > that can only support 32-bit PCIe Bus Addressing. The __newly__ added
> > '3' enables Endpoint Devices that support 64-bit PCIe Bus Addressing to
> > claim larger Memory Address Space on top of what is supported by '1' and
> > '2'.
> 
> Thanks Siddharth,
> 
> I understand, you are enabling 64 bit addressing, keeping previous
> addressing scheme unchanged.
> 
> Since, you are changing, it will be good to give max possible addresses for
> 32 bits EP.
> 
> or
> 
> If you are saying , 32 bit EP has to be limited to 128MB then

Based on the offline discussion, since the total address region is 4 GB,
and given that all of it is addressable in the 32-bit PCIe Bus Address
Space, I will update the patch series to allocate the 4 GB region as:
1. 1MB IO in the 32-bit PCIe Bus Address Space
2. (4GB - 1MB - 4KB) Non-Prefetchable MEM in the 32-bit PCIe Bus Address
   Space

Regards,
Siddharth.

