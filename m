Return-Path: <linux-kernel+bounces-856384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E0FBE4038
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 939E51896A17
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6173469F6;
	Thu, 16 Oct 2025 14:50:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E990345736;
	Thu, 16 Oct 2025 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760626238; cv=none; b=HJzaPhfrmbjyg+SewrInX8OSA55GsTnEQgup688/8AOdYEp+kbIXnTqEmtn+vmr5IfRsZbLWo5fNCenUY+yR0zTaFIutPoQWf/JBcGmHXmFTYiEVEB8/rMzFgsiHd4EpDdlHM2A81dqLwilecTafvj02RdkADSmptzSYEbGiC+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760626238; c=relaxed/simple;
	bh=hs6qVnI/f6YslxIS5hdDDB/6/A1g/tpE0SrPb86ZExg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4Ix98KWf5MgX7B2Y0b3qB60XhSHyNAoQa2bKVHZV+eWoEnb/Nr7yQ2crSc5gnOuoQOcz3DXbjeNVPS16NsyRU0zbOwWWq3Yd4k3YlRx2G7uI4qds2jHQTMWCR3VbQRa3sqmOB24YLbCIEiRxkwtqvBvG6LEN1hHvfhbPTgTWdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44F121688;
	Thu, 16 Oct 2025 07:50:21 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 236D03F738;
	Thu, 16 Oct 2025 07:50:26 -0700 (PDT)
Date: Thu, 16 Oct 2025 15:50:21 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Chatre, Reinette" <reinette.chatre@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	James Morse <james.morse@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] fs/resctrl,x86/resctrl: Factor mba rounding to be
 per-arch
Message-ID: <aPEGLWDL0bd2Y3df@e133380.arm.com>
References: <aNFliMZTTUiXyZzd@e133380.arm.com>
 <aNXJGw9r_k3BB4Xk@agluck-desk3>
 <aNqQAy8nOkLRYx4F@e133380.arm.com>
 <d15d97d1-286c-4857-8688-4d8369271c2c@intel.com>
 <aNv53UmFGDBL0z3O@e133380.arm.com>
 <1c4b6b46-16f9-4887-93f5-e0f5e7f30a6f@intel.com>
 <aO0Oazuxt54hQFbx@e133380.arm.com>
 <bf18c704-66d0-40cb-8696-435ac1c928b5@intel.com>
 <aO/CEuyaIyZ5L28d@e133380.arm.com>
 <SJ1PR11MB608386E5B83880643B23E159FCE8A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB608386E5B83880643B23E159FCE8A@SJ1PR11MB6083.namprd11.prod.outlook.com>

Hi Tony,

On Wed, Oct 15, 2025 at 06:48:55PM +0000, Luck, Tony wrote:
> > I'll try to pull the state of this discussion together -- maybe as a
> > draft update to the documentation, describing the interface as proposed
> > so far.  Does that work for you?
> 
> Dave,
> 
> Yes please. This discussion has explored a bunch of options. A summary
> would be perfect.

OK -- next week sometime, probably.

I'll try to keep it high-level, since we don't have a final design yet...

Cheers
---Dave

