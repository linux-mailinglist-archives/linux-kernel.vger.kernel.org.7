Return-Path: <linux-kernel+bounces-886663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEB7C36347
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 16:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 083634F7117
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 14:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F120632D0CD;
	Wed,  5 Nov 2025 14:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="JM6VIsvw"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085212C237C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 14:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762354703; cv=none; b=HrsPl/l7JrD0u/0FRgNpCXSa+S4mi+fIsH5ZXG5TOsBeYL9n1433ubOals7T+8kQAlRhP3T5Y2UpjUz4+afFa5Z7RLU2jMUFPUYZmH/PIN0bSz64XjOBnb/P8G7Yd6Cfu5RcH9f00d9x8jLaRZHqXCcRCnMsCISc4jQ8emJhQJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762354703; c=relaxed/simple;
	bh=EOlQYtM3Ja8pSPVHJqaJhALzG0oSZlYV891a2hdAh9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OE/pPt0yl7vgw+lfzeWXveD5hrJ61kMEk4z5gUbXSetJHCdj7fo3T3Yg7S1WUjEYJCRJc4MAk5MZR5qVMi5Fke5NlU7/WsUi3WesSm+F0iXnnHRqFHBh1ukbTS3/BFe3PCwrjN0awGmN3QEzG6BY9149KzGwhF94atUuBWBc6dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=JM6VIsvw; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=j+8lmcfXXp+njydpClU6nphHyEcjCaty8/2kZQYj9+E=; b=JM6VIsvwqcE8eA2d
	RGoZizM7LrU2/c1pbjv4fPyhyPmNcCS+u9oEkJyXjNgN3CCUm/LvyXxU8CcwCNiH3KEtnDppamwkZ
	SNpncQlBCZLBhSrHX0u39GkDa1lunWV4bOMAMIspvUT/wlq92C72AtDlCh74hjK38cpZ3KyvBg9XG
	tVtswSKIdXa6RtKXw/Z3Roze/3Mzu+ZsdJszjeTJKhfmim1NoqA85sjBKcaRp+lc7cvrkiV7Rx7vC
	+ZHScghNqX3xVup1c5nofV6dtlOTPB9NxMS0F+/AENn+uK0xqK8RZbTacDbBFOfu+QfBXh5PDR3He
	/drijtdl2LsE01dXVw==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
	(envelope-from <dg@treblig.org>)
	id 1vGexe-00000002CEf-1dvB;
	Wed, 05 Nov 2025 14:58:10 +0000
Date: Wed, 5 Nov 2025 14:58:10 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Finn Thain <fthain@linux-m68k.org>, mark.cave-ayland@ilande.co.uk
Cc: Stan Johnson <userm57@yahoo.com>, mpe@ellerman.id.au, npiggin@gmail.com,
	christophe.leroy@csgroup.eu, sam@ravnborg.org,
	benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, rdunlap@infradead.org,
	Cedar Maxwell <cedarmaxwell@mac.com>
Subject: Re: QEMU limitations, was Re: [PATCH v4] powerpc: Use shared font
 data
Message-ID: <aQtmAjvkD9CzzIJH@gallifrey>
References: <20230825142754.1487900-1-linux@treblig.org>
 <d81ddca8-c5ee-d583-d579-02b19ed95301@yahoo.com>
 <aQeQYNANzlTqJZdR@gallifrey>
 <20108eef-b7cf-3f23-264a-5d97021f9ffa@linux-m68k.org>
 <aQgJ95Y3pA-8GdbP@gallifrey>
 <797f0a13-350f-e26d-f1ef-876419e1c013@linux-m68k.org>
 <492c13c9-666c-9578-6c66-0eb8fefc93dc@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <492c13c9-666c-9578-6c66-0eb8fefc93dc@linux-m68k.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.48+deb13-amd64 (x86_64)
X-Uptime: 14:56:52 up 9 days, 14:33,  3 users,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.13 (2024-03-09)

(Copying Mark Cave-Ayland in - see below)

* Finn Thain (fthain@linux-m68k.org) wrote:
> 
> On Mon, 3 Nov 2025, Finn Thain wrote:
> 
> > > OK, remember I don't think I've ever tried PPC via MacOS booting, so 
> > > not familiar with it.
> > > 
> > 
> > I will try to set up a MacOS guest in QEMU, to see if the hang can be 
> > reproduced that way.
> > 
> 
> QEMU appears to be incompatible with the Old World ROM from the Beige G3. 
> 'qemu-system-ppc -M g3beige -bios 78F57389.ROM -serial stdio' drops into a 
> ROM diagnostic menu and won't boot.
> 
> I did get 'qemu-system-ppc -M mac99 ...' to boot into MacOS 9, by using 
> OpenBIOS instead of Apple firmware. Unforunately, BootX is not compatible 
> with this configuration, so it won't help.
> 
> BootX is compatible with beige powermacs, but 'qemu-system-ppc -M g3beige' 
> with OpenBIOS fails to boot MacOS 9 ("MacOS: unable to find an interrupt 
> controller node").
> 
> OpenBIOS wouldn't boot a MacOS 8.1 CD-ROM either, but for different 
> reasons: both mac99 and g3beige failed with "No valid state has been set 
> by load or init-program".

Thanks for trying,

I've copied Mark Cave-Ayland from Qemu in; he's down as the g3beige
maintainer in qemu, he might have a hint.

Dave

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

