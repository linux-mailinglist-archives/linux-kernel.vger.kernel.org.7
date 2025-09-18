Return-Path: <linux-kernel+bounces-823280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AE4B86056
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 152EC4E35FC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D60312814;
	Thu, 18 Sep 2025 16:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xPy3sIcH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C75244692
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212841; cv=none; b=k+i9XHo864LdlupElULyXSAT4N2961BHiKY2v4+cBTpcHwjKsguynSmyPKPEzXBuLzqPN5UGzLIuGgAoy5MzTp0b39vWO6aucluzTWPrVMod053BTwXJn2L5S/fk57XlOZm1mbWlR7mclLp3v/Tydr2gF5V7vc/rSMvYHzReH94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212841; c=relaxed/simple;
	bh=NN989nk/5dfBYdhkrfZLY4quFIfFrDZ/kloAz6j8mI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZUhyitGlwVn3SwuuecW6NKVLtykoxj/qfUIWqqvEZKgqIzi2MRzCwpzbBRMjmyf6NPay/YA4oixynbNZQT/z4DDMS5aJEiwsTu3E2Rwtu+OaUG62dJpgJhVj0+V4ofxACQyrwoqqqigq3YF06SoYP6ucQ9hpkLKexMUJnQsbSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xPy3sIcH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C47C4CEE7;
	Thu, 18 Sep 2025 16:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758212839;
	bh=NN989nk/5dfBYdhkrfZLY4quFIfFrDZ/kloAz6j8mI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xPy3sIcH4Ms9Z/SuqOmT3XWicWlCS/HiNDm8oxnShs7ZNLD26K9z8O6Dl9P32VqKl
	 cqvzdJsTi758zGHFbrD+LyMGOIjCsYz6Atex6wJAmLSiKv3GlqkNhBpx6m1bXUJgSw
	 ioUHKxUU0cjASsM1rh+nppTOx8YDGa4Euurs1Vt8=
Date: Thu, 18 Sep 2025 18:27:16 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: "Usyskin, Alexander" <alexander.usyskin@intel.com>,
	"Nilawar, Badal" <badal.nilawar@intel.com>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Gupta, Anshuman" <anshuman.gupta@intel.com>,
	"Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
	"Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>,
	"mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
	"Poosa, Karthik" <karthik.poosa@intel.com>
Subject: Re: [PATCH v9 2/9] mei: late_bind: add late binding component driver
Message-ID: <2025091805-sedan-elongated-40cf@gregkh>
References: <20250905154953.3974335-1-badal.nilawar@intel.com>
 <20250905154953.3974335-3-badal.nilawar@intel.com>
 <tbflj3r6picnz7pzhiz77gzhrdnmfxlruhtas4rfrvm27dapss@3wqf4dd2lmsx>
 <CY5PR11MB63665FAB1FE8D8CBE17C31CEED0FA@CY5PR11MB6366.namprd11.prod.outlook.com>
 <wuy7xx57puqytyigl2fbosluckauxikgdvcrdvtubbob6olvyl@wlbsiuquprep>
 <7l4emr357ugep2brz67d6mxgudxqpgfkf3gyhr5cp6i6uhku42@jhgdf4cujbis>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7l4emr357ugep2brz67d6mxgudxqpgfkf3gyhr5cp6i6uhku42@jhgdf4cujbis>

On Fri, Sep 12, 2025 at 12:19:21AM -0500, Lucas De Marchi wrote:
> On Tue, Sep 09, 2025 at 09:43:02AM -0500, Lucas De Marchi wrote:
> > On Tue, Sep 09, 2025 at 04:50:41AM +0000, Usyskin, Alexander wrote:
> > > > > +static int mei_lb_component_match(struct device *dev, int subcomponent,
> > > > > +				  void *data)
> > > > > +{
> > > > > +	/*
> > > > > +	 * This function checks if requester is Intel %PCI_CLASS_DISPLAY_VGA
> > > > or
> > > > > +	 * %PCI_CLASS_DISPLAY_OTHER device, and checks if the requester is
> > > > the
> > > > > +	 * grand parent of mei_if i.e. late bind MEI device
> > > > > +	 */
> > > > > +	struct device *base = data;
> > > > > +	struct pci_dev *pdev;
> > > > > +
> > > > > +	if (!dev)
> > > > > +		return 0;
> > > > > +
> > > > > +	if (!dev_is_pci(dev))
> > > > > +		return 0;
> > > > > +
> > > > > +	pdev = to_pci_dev(dev);
> > > > > +
> > > > > +	if (pdev->vendor != PCI_VENDOR_ID_INTEL)
> > > > > +		return 0;
> > > > > +
> > > > > +	if (pdev->class != (PCI_CLASS_DISPLAY_VGA << 8) &&
> > > > > +	    pdev->class != (PCI_CLASS_DISPLAY_OTHER << 8))
> > > > 
> > > > this doesn't seem right, we should allow other PCI classes. AFAICS this
> > > > check could just be removed and just leave the INTEL_COMPONENT_LB below
> > > > to protect for component match
> > > > 
> > > > Lucas De Marchi
> > > > 
> > > 
> > > The subcomponent is unique only in its own instance of the component framework.
> > > Or I'm wrong here?
> > > We have to ensure that we have Intel display device, not any other device to
> > > subcomponent check to work correctly.
> > 
> > We are matching by child-parent relationship + the component id. So you
> > have both the mei device and another pci device that added that specific
> > subcomponent and both need to have a common parent. Thinking about
> > another device that would match the parent-child relationship:  audio,
> > but audio doesn't add that.
> > 
> > what scenario would cause a false match that I'm not seeing?
> 
> so, I doesn't seem it would fail any, but it's fine as a sanity check.
> This is in fact very similar to mei_pxp_component_match(). If we are
> going to remove the display check, it could be done later on top, making
> sure not to match what it shouldn't.
> 
> So, this looks good to me. I tested this on a Battlemage card
> it's correclty loading the firmware:
> 
> 	xe 0000:03:00.0: [drm:xe_late_bind_init [xe]] Request late binding firmware xe/fan_control_8086_e20b_8086_1100.bin
> 	xe 0000:03:00.0: [drm] Using fan_control firmware from xe/fan_control_8086_e20b_8086_1100.bin version 203.0.0.0
> 	...
> 	mei_lb xe.mei-gscfi.768-e2c2afa2-3817-4d19-9d95-06b16b588a5d: bound 0000:03:00.0 (ops xe_late_bind_component_ops [xe])
> 	xe 0000:03:00.0: [drm:xe_late_bind_work [xe]] Load fan_control firmware
> 	xe 0000:03:00.0: [drm:xe_late_bind_work [xe]] Load fan_control firmware successful
> 
> 
> Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
> 
> Greg, does this look ok to you now for us to merge through drm?

No objection from me:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

