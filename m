Return-Path: <linux-kernel+bounces-763169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 797B0B2117C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EF962A6A31
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D0B2E5402;
	Mon, 11 Aug 2025 15:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pPQTXHIn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFFE2E3B08;
	Mon, 11 Aug 2025 15:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754927940; cv=none; b=SXniDhXsoJdS24wiyGnkcID05ZQ94JA0GDjqVMkRSN5Ns6strCmWSB15BZEtvqKTEbfvSakVQRa8daEX6cGKX7aRVyCAPcvw7FPw38FPeXSoxhItHxYHUugT+DqBEuZ0fhqBn+d9KZbncD9jy1EyLHISADd+TQG4OaNBHk/8/jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754927940; c=relaxed/simple;
	bh=Yd5o/HaZzslU91jtNAqdnydmq673lrDNfOKS5gO2IqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6GhwLCsKxhMFVkC6z8FUOJ+sg37VOxAuTbwUADT2f016l3k+3KCWmurAGwVgSGzIQYjEKTQFl6L06GkyuaXxKyAWZPwxpqYUK7KD3u0HMaJCmbudA7k8nHMo6E2nLqVy+WYFqxkRiDwMQmOtexUIxj2ZjiwJ/tvD3fJzwdjfAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pPQTXHIn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927F1C4CEED;
	Mon, 11 Aug 2025 15:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754927940;
	bh=Yd5o/HaZzslU91jtNAqdnydmq673lrDNfOKS5gO2IqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pPQTXHInCS/CbPL9SX9tKp6yWhzyu5OcXvRlVna/t1xHJYjvMQWDdvOHX+19HrMX4
	 7Ttq58hbj6L8AWFRC6dHsx0oVEDdr2gAAu6lRtS+UFzBKZHVPzlB/C3Q41WDcp5Je9
	 piDKE8nga1wiQyyftqsJDb3Nld4NDjFIUHTRt8cs=
Date: Mon, 11 Aug 2025 17:58:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Chary Chennoju, Srikanth" <srikanth.chary-chennoju@amd.com>
Cc: "Thinh.Nguyen@synopsys.com" <Thinh.Nguyen@synopsys.com>,
	"m.grzeschik@pengutronix.de" <m.grzeschik@pengutronix.de>,
	"Chris.Wulff@biamp.com" <Chris.Wulff@biamp.com>,
	"tiwai@suse.de" <tiwai@suse.de>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Kalluri, Punnaiah Choudary" <punnaiah.choudary.kalluri@amd.com>
Subject: Re: [PATCH 1/3] usb:gadget:zero: support for super speed plus
Message-ID: <2025081110-whisking-unworthy-6999@gregkh>
References: <20250704114013.3396795-1-srikanth.chary-chennoju@amd.com>
 <20250704114013.3396795-2-srikanth.chary-chennoju@amd.com>
 <2025070407-walmart-mobile-c0f7@gregkh>
 <CH3PR12MB8726ABAFBCBD1DD1DA3B1000B14FA@CH3PR12MB8726.namprd12.prod.outlook.com>
 <CH3PR12MB8726EF467E63B31CCD4BB7C8B128A@CH3PR12MB8726.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH3PR12MB8726EF467E63B31CCD4BB7C8B128A@CH3PR12MB8726.namprd12.prod.outlook.com>

On Mon, Aug 11, 2025 at 03:35:38PM +0000, Chary Chennoju, Srikanth wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi Greg,
> 
> Please let me know if there are any comments for this patch.

I have no context at all, sorry.  If it was not accepted, and you got
comments, please fix it up and submit a new version.

Remember, some of us get 1000+ emails a day to review and process,
patches from well over a month ago are long forgotten...

greg k-h

