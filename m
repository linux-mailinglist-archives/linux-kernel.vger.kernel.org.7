Return-Path: <linux-kernel+bounces-746905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA4EB12CC1
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 23:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2566D4E254D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 21:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387AB222586;
	Sat, 26 Jul 2025 21:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b="FjYv7uJH"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B21317555
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 21:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753566613; cv=none; b=Nqzs7nJ+AiF/lyuFOeMpwWozlESZDWeHlftS4MRByis0or2Ufg0MsLqk1/oebHF7ivOzCgglHsNfyfWgnHU+1LLUZH5mDEZqDlnSR+P8D/AyXQ0E4slNfxANFjCJ0DneFVLo+1n2Pb4NBhzg3NVD9kGf0rN91QcrJ9wByZ6oeEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753566613; c=relaxed/simple;
	bh=kSk6pZi5JERX35vTFewHBzc9w+TCNbhDLEr20oEZUH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcYGNWm2MJ4QJELcD4B5ixejkFZAgLaX4x7guvsTvc8iyW5hW46knoWYYU2+UhSFqP+h6Qn+4fCnCEFekNYb2bg3UEXdSSAcattElF6xuCo1SSqO3jrxT2Keqp05zBHCOW0t0mWBXwMyhfLFjXv6SAiuNTLpJDpEOtk/jx6KW3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=kerneltoast.com; dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b=FjYv7uJH; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kerneltoast.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-236470b2dceso27973345ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 14:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kerneltoast.com; s=google; t=1753566611; x=1754171411; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OfyX0fUAfObswyvdjCTspDSkpBigkD/S5xxQ8c6KV3Y=;
        b=FjYv7uJHRGCMal4GaUhg99baBOP2kMvBuHwNBYke92hwbshg745PM8jv93O1pmDHa2
         6FWCjYQlYgNth9gK4eqCp3jsNK3E35d/utH1/aftvRQgLrEQPe3/eQBp85bsmxyxFIle
         VI+1Tw8sb+B59c7sk3NSuE9pBnbCO8wIGGfkAfPwfou/WHjDyDpPxLbpHQaheh/guQRy
         jJcWQfqAU7HpOuB4PIVsuKtmTfoUGSMpAQWQkHkt6IMHwfaYxtJoawI2eYtanGjUBJfn
         l+mX0Ht5UGjdOuYnZiOJ0QqIWw+534q5KukeUIp471iDlAkCxsg1knqaq/GMzN7eBrdo
         EL3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753566611; x=1754171411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfyX0fUAfObswyvdjCTspDSkpBigkD/S5xxQ8c6KV3Y=;
        b=SBgonbmDmHj4LxWBdsDwZcAB+9QCGEb+onQSD8nq9NG+8pqyA7juftRYmbLeTuwF0A
         lO6FWaA78Eiw8Gc4hnsDMwefrbm46xVVdLoB6hSSxU1eDhwGbE63HALuBamV3DU7f34G
         OjavJFJg9coB++Wt6siEiKp6cBNDG4pvoXLQFFDWuzMy9YHmpSNSEWHCftUz2PHp1Q1t
         SI4cX4svJPjrBQxupz9n5W6QgbSKWfRmBjq3yI76sfdhuNdR/t1mqj6yS/bQ8IJKFOZv
         KvDtKACjKmeHY99Yc+JcRk2Gx20utVFvl8eLfVciUWaTbJgbK0ZU8kuXs2sTuDUrGRZL
         Hx+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXzhbV2ALW55oPux+LU9OpUCjnp9/rPqooMJcDTOqxi2rqZXKNiEPFG9aGWNzAESns0y7wPcI7p+BBc1sM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt63ofsEk1mnwtZUQMHB7M1jcnFrZUssBbj+iFoe19CsCvghBG
	ZUgr55QjLE/aLq4SJIJIVkzitMn1ddJtqbtt+LH5BE7dMPhvvsJY6eTo532lx9yUlmge
X-Gm-Gg: ASbGnct/zkiE1IViZI2RkfIAC/oDB8cxRqt8BCxSNTY9binC5bN4ahNBlHx73MXfvJQ
	6edXn0jDYpoTNpFNZF3fBILIFEaLMYw2MFsKZjKZ21Ty57rFem/YZ5Es76H6TA1+VuQ+ZdAHAkq
	byC/imeTEnj56Jm3oFj6myVne/65RglYO32+pqV2qif8KYBr2vZnnQGbmc9ACzemRX6CII9dhHw
	HLOnS0QpD3hYsY/AncLkpN7ayYFSHXuva83Nh+Ky4dJo504n7A4N/ervfqZ3ElWL3s7yuSyFht6
	8ZQU8hOh84P1YildbSI4o48uksKdgvQuqlii4VQLA+cKnImq56eD00nSm8F4dLIoACYlndC/qMp
	wByCap13MrRNm3zdhfguJhB65cXUvgsxKt/0=
X-Google-Smtp-Source: AGHT+IEkYrj6kv0r98d6vdlLZ7nm1KHBvgDzCH8zTJu/LUIUWNAlJSeF/oMmjr7mZf/D/M56RHi9Iw==
X-Received: by 2002:a17:902:e74f:b0:23f:ac71:ef0 with SMTP id d9443c01a7336-23fb3197539mr109807735ad.43.1753566611371;
        Sat, 26 Jul 2025 14:50:11 -0700 (PDT)
Received: from sultan-box ([142.147.89.207])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe30cef7sm23128315ad.26.2025.07.26.14.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 14:50:10 -0700 (PDT)
Date: Sat, 26 Jul 2025 14:50:07 -0700
From: Sultan Alsawaf <sultan@kerneltoast.com>
To: "Du, Bin" <bin.du@amd.com>
Cc: mchehab@kernel.org, hverkuil@xs4all.nl,
	laurent.pinchart+renesas@ideasonboard.com,
	bryan.odonoghue@linaro.org, sakari.ailus@linux.intel.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	pratap.nirujogi@amd.com, benjamin.chan@amd.com, king.li@amd.com,
	gjorgji.rosikopulos@amd.com, Phil.Jawich@amd.com,
	Dominic.Antony@amd.com
Subject: Re: [PATCH v2 6/8] media: platform: amd: isp4 video node and buffers
 handling added
Message-ID: <aIVNj1DLab18eArC@sultan-box>
References: <20250618091959.68293-1-Bin.Du@amd.com>
 <20250618091959.68293-7-Bin.Du@amd.com>
 <aIEiJL83pOYO8lUJ@sultan-box>
 <ff2f17c6-c5e4-4b7b-b897-8abb4cb79c35@amd.com>
 <aIVLlZvTQFoBL70r@sultan-box>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIVLlZvTQFoBL70r@sultan-box>

On Sat, Jul 26, 2025 at 02:41:41PM -0700, Sultan Alsawaf wrote:
> On Fri, Jul 25, 2025 at 05:22:41PM +0800, Du, Bin wrote:
> > > > +		dev_warn(buf->dev, "ignore buffer free, refcount %u > 0",
> > > > +			 refcount_read(&buf->refcount));
> > > 
> > > This refcount_read() is a possible use-after-free because `buf` is accessed
> > > after isp4vid_vb2_put() puts its reference to `buf`. So something else could put
> > > the last reference to `buf` and free it after this refcount dec but before the
> > > refcount_read(). Maybe just remove this dev_warn() entirely?
> > > 
> > The warning is important to debug mem related issue, plan to keep it but
> > without accessing buf or buf->refcount here. Do you think it acceptible?
> 
> Yes, that sounds good. So something like this:
> `dev_warn(buf->dev, "ignore buffer free, refcount > 0");`

Sorry, to fix the dev_warn() we need to make a copy of buf->dev first:

--- a/drivers/media/platform/amd/isp4/isp4_video.c
+++ b/drivers/media/platform/amd/isp4/isp4_video.c
@@ -584,8 +584,9 @@ static void isp4vid_vb2_put(void *buf_priv)
 {
 	struct isp4vid_vb2_buf *buf = (struct isp4vid_vb2_buf *)buf_priv;
 	struct amdgpu_bo *bo = (struct amdgpu_bo *)buf->bo;
+	struct device *dev = buf->dev;
 
-	dev_dbg(buf->dev,
+	dev_dbg(dev,
 		"release isp user bo 0x%llx size %ld refcount %d is_expbuf %d",
 		buf->gpu_addr, buf->size,
 		buf->refcount.refs.counter, buf->is_expbuf);
@@ -601,8 +602,7 @@ static void isp4vid_vb2_put(void *buf_priv)
 		kfree(buf);
 		buf = NULL;
 	} else {
-		dev_warn(buf->dev, "ignore buffer free, refcount %u > 0",
-			 refcount_read(&buf->refcount));
+		dev_warn(dev, "ignore buffer free, refcount > 0\n");
 	}
 }
 
--

Sultan

