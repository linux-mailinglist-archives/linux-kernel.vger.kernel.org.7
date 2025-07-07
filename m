Return-Path: <linux-kernel+bounces-720198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 651E7AFB871
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75B424A110B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 16:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D788A224B1B;
	Mon,  7 Jul 2025 16:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zKLr/UlW"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838BA213254
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 16:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751904788; cv=none; b=WGNK/JKpq5YbC9O+7NIlLbLUsXNce6EewqwhIhzC0BhOgiAsGcyHIitMA7oVQFJl0fWLeAN0fypKtnITqlnquqtQVY28MnG8T3Y/OffMwFG2QvrNNIOzKNHn4nXh7ov1jCpPbEKbrFeJNf7xx/jDybJ/W8+B6N1jDB4pnKqr/QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751904788; c=relaxed/simple;
	bh=0h2aJlmPnSWDsdCU/F4A5RMFeDhbcjsspm212YRtJYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tirgHpGlYOpA/SKkWky+21mLDrHRC7gFQMRd4qTl1cCC5BNwFgnBdE0aLfG2NYtSFHs+f6j7CGiVoTJ4O5BFE9QOGUr/eD76jOO3bxEBI/h7O9M69F6kpOJn8OXTFZsHMgonDOvI/B3HtmID5gjlYzN3JED2JdWSvFrRgH8T2Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zKLr/UlW; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23526264386so31908795ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 09:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751904786; x=1752509586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rTB9AhUzbXze0SvlJXhNv6ywJb1Le3/qXDwCwOY7m50=;
        b=zKLr/UlWJwuskqYq7hPRwBppAXf5ZQ5CtyG1cc+EiIomGunmRQJMPE72jlED3iBXqb
         9Yp33pgKrOVLzniBfepJ5WSW0PY4eQD9ubNCYw3vaKljNh+xoaUW9z/QOCj7F09obFC2
         qVfF88yp4Z5EeQNqqblEP/YXp4lxxNaoyPcoYk2Sxs3xm/VcdV7ollGPrZc+37M1JX9r
         8G6/JlJ9k07u1xkUwVM5/iBqVBQHgXLyB7GzB1jTUr7CcgsmBQHIocxYBNLUNols4ng8
         PqthJcN0RFHx6oPLsyioj3RgWEUOxCJQvKVgLFlMsTaYRwF0d21/696K/zE1G36/cYbL
         oWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751904786; x=1752509586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTB9AhUzbXze0SvlJXhNv6ywJb1Le3/qXDwCwOY7m50=;
        b=UNT6lo612iDLC3fg3X3l9qR65rp0I04B6SMlrmmhft7MZuvpOBJ6Xb+OXKB6JcLxMH
         4naRbPu+imKiemnXyeTxY7PBm013WiE7Q+Unw4BUBIe7xXylKjV5KAk7/X8AstCOYFhy
         y9PzgglZN4G/1/tPdaS+PNEOKAoabs5zg7I68WeD9bC5zJDRgE9NGPGfD/jMJPzPJeDR
         7TiXeOqDDAPZbxMvvwPE2KDgGvtoN3KU5wzuSkAMXsvRFKLe+LRVBkRwyiBWbbXxahMp
         u9A3F5tMJE9Jpimf5vCKbzlsBOPT7SxfuGywBZFzMwoitJGFl1vvbeJKHqCEsEehiHPe
         vg0A==
X-Forwarded-Encrypted: i=1; AJvYcCXoiPhuhGRDPK3VXyjrP8ZO9URx8XOhAVBCynvnNw2mcMNFVj2oR+a2zNIJdP0+8mKl3Wsk0gWAi3TOeQs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0LbzdImkFMYS+xbhC2teSiGwkmv3G7TaG+73/hsiZ7WAuowgQ
	FSoYPdBJfH5pQb0StkOT+kcEVVJXwIoZ9BItDIaMvOm61hi5fxc8FCdenirz0hmGoaY=
X-Gm-Gg: ASbGncsYnT0Lvy5YVCnp3K5tXWNXeCD9Met3/e2VquSSDPLmX8YV7di+Eg9cgzfDFIZ
	0dyLkt4Y7nKmfVS46TkRBtRkqkeDpDRkEqh8kouGUg5Xvq4i6YDUnhzhUuMW95Gjmlh4Z+4jbha
	OFmHoHs/uPHrz2NwBpAmU9Go9xxejSY7gl/nbKGmgqcaxWpIhMDJYzOMs8tq+HmyEwYpy0cY+E5
	QDJB7S0fbIzYJS4FKT1/sw5/Bxxo1r7E1nb196oRHwkH7tNMUYBz2jfB55lr64y9RBfPxfVFw3f
	8gip9MSDkUVBKpbCj6gaS8cjBAmzc58P6XDKKtWrJ0OKgLjsCBBcXEtJwJ/H/MJ+tA==
X-Google-Smtp-Source: AGHT+IEQezXaHRglxK6u+wE7BwHS5SdjM0yKB0UdNJiBREdoJn93Iqgm0TzBfL2Hm1mR3xJxK3359A==
X-Received: by 2002:a17:903:41c1:b0:235:c781:c305 with SMTP id d9443c01a7336-23c8755c92amr199352805ad.24.1751904785665;
        Mon, 07 Jul 2025 09:13:05 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:1746:c463:9d35:6eed])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee475a3asm9236671a12.17.2025.07.07.09.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 09:13:05 -0700 (PDT)
Date: Mon, 7 Jul 2025 10:13:02 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Iuliana Prodan <iuliana.prodan@nxp.com>,
	Peng Fan <peng.fan@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>,
	linux-remoteproc@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Hiago De Franco <hiago.franco@toradex.com>,
	Ritesh Kumar <ritesh.kumar@toradex.com>
Subject: Re: [PATCH] remoteproc: imx_rproc: merge ITCM and DTCM regions
Message-ID: <aGvyDp36iWv5UQ19@p14s>
References: <20250703130831.18830-1-hiagofranco@gmail.com>
 <aGgAbwToGhsc5VV9@p14s>
 <20250704190816.kth7bdf34ufc2ht6@hiagonb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704190816.kth7bdf34ufc2ht6@hiagonb>

On Fri, Jul 04, 2025 at 04:08:16PM -0300, Hiago De Franco wrote:
> Hi Mathieu,
> 
> On Fri, Jul 04, 2025 at 10:25:19AM -0600, Mathieu Poirier wrote:
> > Good morning,
> > 
> > On Thu, Jul 03, 2025 at 10:08:31AM -0300, Hiago De Franco wrote:
> > > From: Hiago De Franco <hiago.franco@toradex.com>
> > > 
> > > Merge the contiguous ITCM and DTCM regions into a single region to
> > > prevent failures when loading ELF files with large sections:
> > > 
> > > remoteproc remoteproc0: powering up imx-rproc
> > > remoteproc remoteproc0: Booting fw image rproc-imx-rproc-fw, size 151824
> > > imx-rproc imx8mp-cm7: Translation failed: da = 0x1f48 len = 0x1fcb0
> > > remoteproc remoteproc0: bad phdr da 0x1f48 mem 0x1fcb0
> > > remoteproc remoteproc0: Failed to load program segments: -22
> > > remoteproc remoteproc0: Boot failed: -22
> > > 
> > > This approach is the same as commit 8749919defb8 ("remoteproc:
> > > imx_rproc: Merge TCML/U").
> > > 
> > > Suggested-by: Ritesh Kumar <ritesh.kumar@toradex.com>
> > > Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
> > > ---
> > > Hi,
> > > 
> > > The ELF I tested had the following data section:
> > > 
> > > Memory region         Used Size  Region Size  %age Used
> > >     m_interrupts:         680 B         1 KB     66.41%
> > >           m_text:        6984 B       127 KB      5.37%
> > >           m_data:      130224 B       128 KB     99.35%
> > >          m_data2:          0 GB        16 MB      0.00%
> > > [100%] Built target hello_world_cm7.elf
> > > 
> > > Which triggered the error. After this patch, remoteproc was able to boot
> > > and work fine. Thanks!
> > > ---
> > >  drivers/remoteproc/imx_rproc.c | 6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> > > index 74299af1d7f1..bbf089ef48ee 100644
> > > --- a/drivers/remoteproc/imx_rproc.c
> > > +++ b/drivers/remoteproc/imx_rproc.c
> > > @@ -166,8 +166,8 @@ static const struct imx_rproc_att imx_rproc_att_imx8qxp[] = {
> > >  
> > >  static const struct imx_rproc_att imx_rproc_att_imx8mn[] = {
> > >  	/* dev addr , sys addr  , size	    , flags */
> > > -	/* ITCM   */
> > > -	{ 0x00000000, 0x007E0000, 0x00020000, ATT_OWN | ATT_IOMEM },
> > > +	/* D/ITCM */
> > > +	{ 0x00000000, 0x007E0000, 0x00040000, ATT_OWN | ATT_IOMEM },
> > >  	/* OCRAM_S */
> > >  	{ 0x00180000, 0x00180000, 0x00009000, 0 },
> > >  	/* OCRAM */
> > > @@ -180,8 +180,6 @@ static const struct imx_rproc_att imx_rproc_att_imx8mn[] = {
> > >  	{ 0x08000000, 0x08000000, 0x08000000, 0 },
> > >  	/* DDR (Code) - alias */
> > >  	{ 0x10000000, 0x40000000, 0x0FFE0000, 0 },
> > > -	/* DTCM */
> > > -	{ 0x20000000, 0x00800000, 0x00020000, ATT_OWN | ATT_IOMEM },
> > 
> > In commit 8749919defb8 "dev addr" and "sys addr" were both contiguous, but in
> > this patch "dev addr" is not.  How will this work with new kernel that use old
> > FW images?  Am I missing something?
> 
> No, you are correct, I think the use case I tested was not good enough.
> 
> If I understand correctly, this will break older firmware expecting
> .data at 0x20000000 because dev_addr is no longer mapped for DTCM entry.
> 

Correct.  Older firmware would still expect DTCM at 0x20000000.


> Do you think it is possible (or reccomend) another approach to fix this
> issue? In this case to keep using the TCM, instead of going to OCRAM or
> DDR.
>

To me the best way to proceed is understand why using the current mapping is a
problem.  The changelog describes a failure condition when dealing with large
sections but does not indicate _why_ that is happening.  I think that's what
needs to be fixed rather than trying to move mappings around.
 
> Thanks,
> Hiago.
> 
> > 
> > Thanks,
> > Mathieu
> > 
> > >  	/* OCRAM_S - alias */
> > >  	{ 0x20180000, 0x00180000, 0x00008000, ATT_OWN },
> > >  	/* OCRAM */
> > > -- 
> > > 2.39.5
> > > 

