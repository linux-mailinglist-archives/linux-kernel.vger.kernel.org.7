Return-Path: <linux-kernel+bounces-880303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E146C2561C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 171EA427CB7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C7434B661;
	Fri, 31 Oct 2025 13:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i1E3EwTD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6C9223DF6;
	Fri, 31 Oct 2025 13:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761919153; cv=none; b=doFp5Kg2uloCjsznCohu1ifZj/zWOJHGF8hqTrcDiFw6CstO7DFaWbAJD/Ngd+FAhcwKhp0leKKzdUR8E4d6kgH3uoN10rwh9/eWJvkpxuwOHu/+VfoU57t0MJodVNmDs30g8mT7JzObPbcuDIpSIDDgCRRho9vIRCXTkd/Jltw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761919153; c=relaxed/simple;
	bh=CotR711s/swRyE6KNESaqesi6msjhQObc+17WNR9CBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6Fcde/pQUwyApbDHENxau5jUi5KUVCMYimiRwLToIjCqvVp6dCE88Sr3VglFMtdv5mcAThQxgP3deg92ivyvCh1nKRM/2S0tI4VopU0iMCfLfuIqeiDCHpRkVHzQku0mtNDWn45kNvNv2gecsSVmPZK2eTAJTeE5cLF3/vbwVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i1E3EwTD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7213C4CEE7;
	Fri, 31 Oct 2025 13:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761919150;
	bh=CotR711s/swRyE6KNESaqesi6msjhQObc+17WNR9CBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i1E3EwTDLAhABtdgy4z3uzS2bu8LtnceVJlthCGYWv5E9zKlxUqAU2kC2U8kks/qr
	 9ZLHSwwmM8JY+Vgo6ExMPeC+FGyzHF0GLJSacPVwXPA2YLb7MiXzn9Ur6HgktSsJti
	 M0CoBuiXY8W6sYv+DhoZOicditrfo5FVnEtM2xqE=
Date: Fri, 31 Oct 2025 14:59:07 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: vsshingne <vaibhavshingne66@gmail.com>
Cc: skhan@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: core: prevent double URB enqueue causing list
 corruption
Message-ID: <2025103118-smugness-estimator-d5be@gregkh>
References: <20251031134739.222555-1-vaibhavshingne66@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031134739.222555-1-vaibhavshingne66@gmail.com>

On Fri, Oct 31, 2025 at 07:17:39PM +0530, vsshingne wrote:
> Prevents the same URB from being enqueued twice on the same endpoint,
> which could lead to list corruption detected by list_debug.c.
> 
> This was observed in syzbot reports where URBs were re-submitted
> before completion, triggering 'list_add double add' errors.
> 
> Adding a check to return -EEXIST if the URB is already on a queue
> prevents this corruption.

This text makes no sense at all, it does not describe what this patch
does in any way.  Please do not use AI to generate patches.

greg k-h

