Return-Path: <linux-kernel+bounces-745462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DC4B11A4B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C48F3586A9D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 08:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F442459E1;
	Fri, 25 Jul 2025 08:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HDR/DOqj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C732046A9;
	Fri, 25 Jul 2025 08:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753433685; cv=none; b=AALRHwnca+kauX9cfKQaZYmZoOhyB/iwVAwHaF6UM8+3mGPyFLL77puodDFXdOmQstWOwLa+8qnWbqvnGZjHINWB76E7lNzTdsZVaWPbiMDfxFxRlmN90+c4QMDwSjuNfzXjr14L1sg+UH5bfIjxrmSHoLPwJrrT1mB8ZQCIoOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753433685; c=relaxed/simple;
	bh=hjFINsVpC6FAHAXLNRPyDkHQkeG1X5fPEVv1tAmDq3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbYwtMusD94W0zKcsNSBSiMYfBD23YPox8yrdKr4D4ipN6qbJOyZCh+8oKUw65svq8woAVgzthoqMy09KioNDyijLg1+vqFYW5Z88+uXa9EM9fcP55QYNuk+Cq6Xv4Gph0/ZKnwziLRj+h8jC5PQp2qWq/twd4xSoD770JVZ5UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HDR/DOqj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A44C4CEE7;
	Fri, 25 Jul 2025 08:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753433684;
	bh=hjFINsVpC6FAHAXLNRPyDkHQkeG1X5fPEVv1tAmDq3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HDR/DOqjdCaRRhBY0sA4QC/wRqKvjm+J8arwxALJwVShl/+cPjod0YfTY7OcN3KNN
	 4xVH6UY+XTQyMK4V325iyuqO78dXxDGZjNsx7NLWqJYUZksoDFuCadNAipJpkTnhwN
	 jW6bNXJrdRIPm2Gjw4pVdf/S0eujZusj/w7cQidA=
Date: Fri, 25 Jul 2025 10:54:41 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
Cc: Luc Bonnafoux <luc.bonnafoux@ssi.gouv.fr>,
	Alan Stern <stern@rowland.harvard.edu>,
	Kannappan R <r.kannappan@intel.com>,
	Sabyrzhan Tasbolatov <snovitoll@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Pawel Laszczak <pawell@cadence.com>, Ma Ke <make_ruc2021@163.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Luc Bonnafoux <luc.bonnafoux@oss.cyber.gouv.fr>,
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	Alistair Francis <alistair@alistair23.me>,
	Oliver Neukum <oneukum@suse.com>
Subject: Re: [RFC PATCH v2 0/4] Support for usb authentication
Message-ID: <2025072555-praying-shakiness-121f@gregkh>
References: <20250711-usb_authentication-v2-0-2878690e6b6d@ssi.gouv.fr>
 <2025071344-possible-fabric-bbbf@gregkh>
 <d2ghp3qafwrxiwkrizzxqayzkhu36ke4dolxaloksmz4z5fzpn@paxcer43kru3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2ghp3qafwrxiwkrizzxqayzkhu36ke4dolxaloksmz4z5fzpn@paxcer43kru3>

Hi,

Let me focus right now on only one thing here:

On Mon, Jul 21, 2025 at 04:51:52PM +0200, Nicolas Bouchinet wrote:
> > > Limitations
> > > ===========
> > > 
> > > The USB authentication protocol come with some inherent limitations, [3]
> > 
> > That's a 2018 reference!  Are you saying that the newly designed
> > protocol was already discussed in 2018 and found lacking?
> > 
> As far as we are aware, the last version of the specification [1] is the
> last is the last version that includes errata from 2019. [3] is a
> research paper that explored the limitation of the protocol. We are not
> aware of any evolution since. We saw that SPDM reuses some of the USB
> specification fields but we are not entirely sure yet if can be used in
> place of the USB specification and if it fixes the limitations.

So, this spec has been out since 2019, and it's "broken", AND there are
no actual devices using this?

If there is no hardware out there, I really do not want to be adding new
features to the kernel for this.  We ripped out wireless usb because the
thing never actually shipped and was dropped by the vendors.  Let's not
do that again here.

So if there is no hardware, there's no need for this at all, right?
Where are the vendors that wrote this spec, and why did they not
actually add support for this to their devices already?

And, most importantly, is Windows going to support this?  Because if it
is not, then there is no need for us to support it either as no vendor
is going to only be building a USB device just for Linux systems, right?

So, where are the vendors?  Without that, this is not going to actually
go very far at all, and just bit-rot in our tree :(

thanks,

greg k-h

