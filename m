Return-Path: <linux-kernel+bounces-797352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C84FB40F3E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 23:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E20F617639B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 21:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D1F272E67;
	Tue,  2 Sep 2025 21:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="i/ktlGsD"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00610270EA5;
	Tue,  2 Sep 2025 21:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756847868; cv=none; b=L1k6RnjudRAxb0lTQidBZbYRrFb0VDf4K1dVSGW/Ofynopp801cneNWQNggkScO7z3uwo+Q2JhfHYh7jQhPXsHTWw6vZm6ABnWC9njgJpX72wdd3EJT1s7oaQYIJwg2BwXAMDtmduANZVVSIKt7rfkrXBdPfC7O6eTKldyHr2KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756847868; c=relaxed/simple;
	bh=LjzOty6mM8/+BGls+KFr4xgrzsuNgY6vQs68b4xpXwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQaLJUQCacuSxQUUqFxymSB5gZGZ/EsRFb/quo/ch4mfcIQk8mOuGDflppoMmPVb2D1etMg2R9f8Tn2WMFbOKKHBeNYNQEw1GmplhTDjRD8kpWzEigJ9mpBTrsM41YyKkdqM67WrmRLY6K5CiCqn0iT0JjuYyX5BlqhWG8RCEf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=i/ktlGsD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AS7qSYs5FiBWKPP9nMV8J8d+/ZZhjnSHN6ijHP0mkmc=; b=i/ktlGsDgBup0MVxtsaUpYMTcm
	QOQoca6wAsVWNbWN8M0kTQ5dDTOj1BxQaVP+MZOaagjiwujLti57MdGvnLjd5JJ0sVC+muWXZY+r3
	Ktosiev3zZACRh5YEZiSV94t44LPpVqEkWH/ZhzN7ctmDhE1Ublk8s6phGFMfk2K8zTo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1utYNi-006vs2-EO; Tue, 02 Sep 2025 23:17:34 +0200
Date: Tue, 2 Sep 2025 23:17:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Joseph Steel <recv.jo@gmail.com>,
	Konrad Leszczynski <konrad.leszczynski@intel.com>,
	davem@davemloft.net, andrew+netdev@lunn.ch, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, cezary.rojewski@intel.com,
	sebastian.basierski@intel.com
Subject: Re: [PATCH net-next 0/4] net: stmmac: new features
Message-ID: <68975e58-9018-484d-b8c1-2afcb1ad606a@lunn.ch>
References: <20250828144558.304304-1-konrad.leszczynski@intel.com>
 <40c3e341-1203-41cd-be3f-ff5cc9b4b89b@intel.com>
 <y45atwebueigfjsbi5d3d4qsf36m3esspgll4ork7fw2su7lrj@26qcv6yvk6mr>
 <26ca1ef9-2587-43cd-9a5c-171cbc8f6080@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26ca1ef9-2587-43cd-9a5c-171cbc8f6080@intel.com>

> >> The series looks good to me.
> >>
> >> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> > 
> > Not a single comment? Really? Three Rb and three Sb tags from Intel
> > staff and nobody found even a tiny problem? Sigh...
> > 
> 
> Not everyone will find every issue. I'm certainly no expert in this
> driver. This is why it is good to have many reviewers.

As a rule of thumb, Maintainers ignore multiple Reviewed-by when then
call come from the same company. At least if they don't actually point
out issues.

There is a nice quote from a bootlin/free-electrons developer. It is
something like: In order to get my patches merged faster, i review
other peoples patches, so freeing up Maintainer time to look at my
patches.

Jacob is a good example of that, he looks at patches from many
developers. Maybe more Intel people can help out reviewing patches,
particularly other stmmac patches, in order to get their own merged?

	Andrew

