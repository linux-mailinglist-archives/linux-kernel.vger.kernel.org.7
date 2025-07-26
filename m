Return-Path: <linux-kernel+bounces-746720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6422B12A65
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 14:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C004E189F86C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 12:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BD1244698;
	Sat, 26 Jul 2025 12:10:25 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F153E204F99;
	Sat, 26 Jul 2025 12:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753531825; cv=none; b=VPKbR3SCCJDxdWrdTb1by3LboL25uYefFRmmwQvnjhJ5Z2AkIU+djtONEKWjH8OOBhIdcTUXgYbb5zirDngJlckSoVFXzZt3Y2nbgR4wht6WKhj9xsTsTB3QrVVJkkgUt8RW2eAKaXqdTwPms95ntUGDrdSAx9zUMXDGVrTUaYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753531825; c=relaxed/simple;
	bh=i8ofqofMPRyEy3xiqiZRYbhA3MBjLpiOaAVO+LMJSPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/631HAE949aZ8O3BtvjZDgRKvkIHncDNvHDJ50SKR7rKOrK9/KUfFIbOqzG/4Lyp7mJ4gBp9tvrf7f7GOH8tJ36o7rfo87vP229iqhpRuCHY6UW0a9TS6eiV0rUX2ZJtIhLcXlVNAZa0vBh+eXUjDAxHruaCDsbNkIUZ+OVFYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.48.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id D284A341004;
	Sat, 26 Jul 2025 12:10:20 +0000 (UTC)
Date: Sat, 26 Jul 2025 20:10:14 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>, sboyd@kernel.org,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
	linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: spacemit: fix resource leak in
 spacemit_ccu_reset_register
Message-ID: <20250726121014-GYA756241@gentoo>
References: <20250723132504.66273-1-hendrik.hamerlinck@hammernet.be>
 <ed5fcfec-6330-46e8-a302-5cf1d8b3a9ce@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed5fcfec-6330-46e8-a302-5cf1d8b3a9ce@wanadoo.fr>

Hi Christophe, 

On 11:16 Sat 26 Jul     , Christophe JAILLET wrote:
> Le 23/07/2025 à 15:25, Hendrik Hamerlinck a écrit :
> > The function spacemit_ccu_reset_register() allocates memory for an
> > auxiliary device. If auxiliary_device_add() fails, it skips cleanup of
> > these resources, resulting in leaks.
> > 
> > Fix this by using the appropriate error handling path.
> > 
> > Fixes: 988543522ebd ("clk: spacemit: set up reset auxiliary devices")
> > Signed-off-by: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
> > Reviewed-by: Yixun Lan <dlan@gentoo.org>
> > ---
> > Changes in v2:
> > - Properly place the Fixes tip.
> > ---
> >   drivers/clk/spacemit/ccu-k1.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/clk/spacemit/ccu-k1.c b/drivers/clk/spacemit/ccu-k1.c
> > index 65e6de030717..5bb85e32c6cf 100644
> > --- a/drivers/clk/spacemit/ccu-k1.c
> > +++ b/drivers/clk/spacemit/ccu-k1.c
> > @@ -1059,7 +1059,7 @@ static int spacemit_ccu_reset_register(struct device *dev,
> >   	ret = auxiliary_device_add(adev);
> >   	if (ret) {
> >   		auxiliary_device_uninit(adev);
> > -		return ret;
> > +		goto err_free_aux_id;
> >   	}
> >   
> >   	return devm_add_action_or_reset(dev, spacemit_adev_unregister, adev);
> 
> 
> Hi,
> 
> I'm not sure this is correct.
> 
> auxiliary_device_uninit() which is called if auxiliary_device_add() 
> fails should already do the clean-up.
> 
thanks for your review,

auxiliary_device_uninit() call put_device() and will trigger release callback,
which then call spacemit_cadev_release() and do the ida_free()

> So I would say that this patch adds a double-free issue and should not 
> be applied.
> 
I agree

> If I'm right, note that Stephen has already added a "Applied to clk-next"
> 
Stephen, can you drop this patch? or simply revert it if too late..

> CJ
> 
> 

-- 
Yixun Lan (dlan)

