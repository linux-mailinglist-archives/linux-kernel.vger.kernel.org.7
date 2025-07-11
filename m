Return-Path: <linux-kernel+bounces-727013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED5FB013E7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D22A3AE5D9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84EB1DF268;
	Fri, 11 Jul 2025 06:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p5A8YpnE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6141A08A3;
	Fri, 11 Jul 2025 06:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752216693; cv=none; b=LHis/o3qrGl+R5Ypg/UqgsjOuEsQcoFpVrre7LuU4tUGGFtUaxqwhgIC4dB+62g63A1OQKAci/G/P0MH00eLcHyA+jCrrLkGzDXkk3LfRbBM/TuZMEtBWzngEw76ILLxnuY4tq/EjhiZFx0YLfgSkGPXhb082Z/G04wVnHTZe5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752216693; c=relaxed/simple;
	bh=wgsKhzdfMzjTQNnKiRuPYSNlGTF338MZWPENTlmzD9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7XuWdIokYykI34/4yZQtCwUPbXOzFwPd60BGGMulktgmp0qkCv3pCFRkW8aNB0Y8NkoLknSbyQbbgyvMHjaBbC6+c8cesTFA+S7Vx5o/GeC7DVGr8egfmbs/wARIJlquQz/6969hcq3HIRSlyTYaA5L/D6LEr6lk4QaHAW4hQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p5A8YpnE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350D1C4CEED;
	Fri, 11 Jul 2025 06:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752216692;
	bh=wgsKhzdfMzjTQNnKiRuPYSNlGTF338MZWPENTlmzD9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p5A8YpnEONtyJVVj+40XFHhtjqMaW/KihdEiUz6hUsdoLdf8mDVdU5xtMUjyYxNyb
	 qi4XK6drPwD5/QRTMcrtgqgaZ4L4A0HKD6haD50RchvtLsaUtoWR+AQDDtUTYEvg4a
	 nKu01208rnfs+gEaja75rSVKNvXPEy+ioU5Lxlkk=
Date: Fri, 11 Jul 2025 08:51:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: jackysliu <1972843537@qq.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2] usb: gadget: functioni: Fix a oob problem in rndis
Message-ID: <2025071116-landline-antelope-5c9f@gregkh>
References: <2025071150-removal-bullring-5649@gregkh>
 <tencent_693B44F3060A525A26EEC5ED8DFF5E92C906@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_693B44F3060A525A26EEC5ED8DFF5E92C906@qq.com>

On Fri, Jul 11, 2025 at 02:40:19PM +0800, jackysliu wrote:
> On Fri, Jul 11, 2025 at 11:46:35AM +0800, greg k-h wrote
> >Sure, but again, BufLength is not used for anything, so the value of
> >that variable means nothing as far as I can tell.
> >How exactly?  Again, BufLength isn't even used in that function
> function contains below code:
> if (gen_ndis_set_resp(params, le32_to_cpu(buf->OID),
> 			((u8 *)buf) + 8 + BufOffset, BufLength, r))
> ((u8 *)buf) + 8 + BufOffset determins base address of buffer 
> and BufLength determins buflen.

Yes, and then look to see what buf_len (not buflen) in
gen_ndis_set_resp() is used for.  I'll wait... :)


> >How was this tested?
> >
> >And even more importantly, how did you find this bug?  What triggered
> >it?
> I detected this problem through static analysis and calibrated
>  the device via qemu emulation.

What tool generated this static analysis?  You always have to mention
that as per our development rules.

And what qemu setup did you use to test this?  That would be helpful to
know so that I can verify it on my end.

thanks,

greg k-h

