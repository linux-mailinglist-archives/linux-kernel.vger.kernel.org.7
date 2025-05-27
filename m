Return-Path: <linux-kernel+bounces-663338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F148AC46E6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 May 2025 05:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFDBC189549A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 May 2025 03:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04CD1AF0C1;
	Tue, 27 May 2025 03:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjigB9WT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DA917B50F;
	Tue, 27 May 2025 03:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748316966; cv=none; b=FFRB7vNxThu5+KhrbSn0K8nY7AINp92kujxXN/n0z8I/Jb+PSL2+9PCfdgYDbHYobXzkezVHZkyhmukX85HqDEF1WhXY5r2R4CkeLpHbgHf3ZykV4EkduzqGC/RoiTa2iQ8pbPrTbUkHv2+nJ3X9QeeoUUMIS/ht3usN32R/11s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748316966; c=relaxed/simple;
	bh=R6crNMTD7b76Ug/l5ZrajpcpFjKDO6xDU2hYOiw848w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oL2TDs2i2TmGa6TPHTiJUPrWeXJ2Z7Lv90xYJzfaCwZmSF+1ukfF6woymmc6o14bQ7L6aJdj+08vxP4qnj8FcGrTnusEkSOFIyyAYow4o9EQBLcDkx7qn62+45fuUUBcstN74Z1FKG8qR1Oh1kAdH5p15XVFK8MYHliSPX/SC5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjigB9WT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92DC3C4CEEA;
	Tue, 27 May 2025 03:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748316965;
	bh=R6crNMTD7b76Ug/l5ZrajpcpFjKDO6xDU2hYOiw848w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mjigB9WTgVWz14jZCwIPJZoUHb07SpURvBPMkpFof/ykW9mnvaobNrnihlq8tmReB
	 CjDVAt4/QWoxArU/fn6YKyPvYqc1RdF3YG43e7LZj1z9lFSEdEwXEvhr7+68w9pfOw
	 fJdIRF0g5SY5Hd7U1d7x6/Q8wZCvs+Se1vVikJhmgUSMiXyJxDvDxQE0my5bCRZbho
	 4Zydyn1x3+DNynX11j+JHF4SiAPDpEcAXJG8OZ2IOjLb/yWkAHMGdUNfJ3rfQ0KIND
	 ZcsPmgdaRouDFFba/EezR365VeZ05Xa2pzSkXdkfIfIP0c9ZzqxI9fp0rln7HHuIt6
	 Q0btl5+xQxgVw==
Date: Mon, 26 May 2025 20:36:02 -0700
From: Kees Cook <kees@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: clingfei <clf700383@gmail.com>, elder@kernel.org, johan@kernel.org,
	vireshk@kernel.org, gregkh@linuxfoundation.org,
	greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] greybus: Avoid fake flexible array for response data
Message-ID: <202505262032.507AD8E0DC@keescook>
References: <20250526110654.3916536-1-clf700383@gmail.com>
 <aDRSaZ4Rq47hjMuY@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDRSaZ4Rq47hjMuY@stanley.mountain>

On Mon, May 26, 2025 at 02:37:13PM +0300, Dan Carpenter wrote:
> On Mon, May 26, 2025 at 07:06:54PM +0800, clingfei wrote:
> > As https://lore.kernel.org/all/20240304211940.it.083-kees@kernel.org/
> 
> I don't want to have to read a link to understand the commit message.
> 
> Does this change really affect anything in terms of "enforce the 0-sized
> destinations" rule?  I don't think this is a destination.  I think Kees
> enabled the checking he wanted.  You should probably CC him since we're
> refering to his email.

FWIW, the above patch became commit 7ba59ac7da2a ("greybus: Avoid fake
flexible array for response data").

> > pointed out, to enforce the 0-sized destinations, the remaining 0-sized
> > destinations need to be handled. Thus the struct
> > gb_control_get_manifest_response and struct gb_i2c_transfer_response
> > are removed.
> 
> Here is a better commit message;
> 
> "We want to get rid of zero size arrays and use flexible arrays instead.
> However, in this case the struct is just one flexible array of u8 which
> adds no value.  Just use a char pointer instead."
> 
> I would have ignored it, probably but actually the
> gb_control_get_manifest_response struct is not used so put that in a
> separate commit.  That's a simpler commit to review.
> 
> "The gb_control_get_manifest_response struct is not used.  Delete it."

The patch content itself looks mechanically correct. I think Dan's style
suggestions would be good to see. Can you send a v2?

-Kees

> 
> > 
> > Signed-off-by: clingfei <clf700383@gmail.com>
> > ---
> >  drivers/staging/greybus/i2c.c             | 9 ++++-----
> >  include/linux/greybus/greybus_protocols.h | 9 ---------
> >  2 files changed, 4 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/staging/greybus/i2c.c b/drivers/staging/greybus/i2c.c
> > index 14f1ff6d448c..2857c2834206 100644
> > --- a/drivers/staging/greybus/i2c.c
> > +++ b/drivers/staging/greybus/i2c.c
> > @@ -144,15 +144,14 @@ gb_i2c_operation_create(struct gb_connection *connection,
> >  }
> >  
> >  static void gb_i2c_decode_response(struct i2c_msg *msgs, u32 msg_count,
> > -				   struct gb_i2c_transfer_response *response)
> > +				   u8 *data)
> >  {
> >  	struct i2c_msg *msg = msgs;
> > -	u8 *data;
> >  	u32 i;
> >  
> > -	if (!response)
> > +	if (!data)
> >  		return;
> > -	data = response->data;
> > +
> >  	for (i = 0; i < msg_count; i++) {
> >  		if (msg->flags & I2C_M_RD) {
> >  			memcpy(msg->buf, data, msg->len);
> > @@ -188,7 +187,7 @@ static int gb_i2c_transfer_operation(struct gb_i2c_device *gb_i2c_dev,
> >  
> >  	ret = gb_operation_request_send_sync(operation);
> >  	if (!ret) {
> > -		struct gb_i2c_transfer_response *response;
> > +		u8 *response;
> >  
> >  		response = operation->response->payload;
> >  		gb_i2c_decode_response(msgs, msg_count, response);
> 
> I like when parameters are called the same thing on both sides.  The
> name "response" adds no value.  Instead get rid of that variable and
> pass operation->response->payload directly.
> 
> 		gb_i2c_decode_response(msgs, msg_count,
> 				       operation->response->payload);
> 
> regards,
> dan carpenter
> 

-- 
Kees Cook

