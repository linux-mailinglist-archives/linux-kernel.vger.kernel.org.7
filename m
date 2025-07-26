Return-Path: <linux-kernel+bounces-746902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B64EB12CB2
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 23:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 203BE54263D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 21:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BB0221FBD;
	Sat, 26 Jul 2025 21:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b="I2pb7UzD"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134342063F0
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 21:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753566109; cv=none; b=l0a/pnvsv76kK5b96ogcR5uzV1sZFE/D2F6hyHrdiWr7Pbx+r0Py12LEBPJQMp7ppFovaOIgaYIQZ49oXhb95z2OS+GuIrjSGdrj3921xJmNSVOFc0asy3JgaRJMe+kAb8BatIfpMGkiwm06MxW2pqRMAwNIomKXRAjotrB0O4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753566109; c=relaxed/simple;
	bh=/C5sZYXLh1D3x18pubyMwI6xQ1bhbBON3vKomijkFZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzbhVajOu/6Hap+UoyQPFa5THWAEKF2JnmESI2hOc104vx0eHvRYxu9xfNQb4hLat/iJZjy6B/NxV5rEuWNpdtREPmr3BFWqec4L0dUqokAGFV0Jw2jVuBODTkilU64Env0YvgiXGcQYrmjIbpWSdNu0CP9T/YElbQ8cEzQD5yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=kerneltoast.com; dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b=I2pb7UzD; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kerneltoast.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b3507b63c6fso3590807a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 14:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kerneltoast.com; s=google; t=1753566107; x=1754170907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rs2+aUKXKDAWp/9xZPQX34KN7Y9pjWo08LcS4J6bqco=;
        b=I2pb7UzDX50w0ug3X90D0gg8Dq7enpqE9JocficqFcDjTJGisWepkKvPt8E2hKifem
         J1MnA6f8PYZb19Rd1CbAQQZMU78FilgDpLIngI8sd6FAjBIzfBPpFc7F59oYTTyAJEsM
         Oa5c47hskE6kpVE48zonIW2wWoehl6eul9SuSbEOxuBgwNTieCaXocTaavYVYOFGbDbn
         EdO/J1mWJRBRKAmWK3QlS6eC01ncB5DknT7KHR0Vnb5+habx3rFgD4dfZJhs1dlOeE5E
         jGMecENNyS733DzoouuAVmQRKKRTW1lTPtPuyIGSak4U87vMPKiOZdsgI73eTDEsGrT0
         vTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753566107; x=1754170907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rs2+aUKXKDAWp/9xZPQX34KN7Y9pjWo08LcS4J6bqco=;
        b=a4fQLEAS+VmtMA/AcKha8FTLM7zTzrvmLp0+fKtOg6tWfSrcinswq6yJPcXwy0eMR5
         XmSYy039fTeq9Nx3nKNJw6Ge54aSLIFWGK5S1ZNueCgmVj4hyT6hQOnUv/SEwq2j5Y6Y
         j2fDiO9BwAh+yRUC0FacwmFF++w5fw5EOUyJLOS/y+RyMK2HmDe+kV5+r66G4x1j6/U5
         KMzwKni5xGKg6ru8+27wxr9V0qTw2mLAikE4AMFKIYTKhoAmFitNFSoOjm92IAz4rwMj
         rEfPH3xh/XN1Rbp7l3uPz0xEnvmlXloU0ICkYUPFvsjD6DoIfJNx/weI8/ZiHiJt2wXy
         RyLg==
X-Forwarded-Encrypted: i=1; AJvYcCURvnfI9wBjnV4Cl2TSWZDUhNhqyzQzqcRneE73Dv+Uh/RJoKO/cxe/T8mf1FnYzp+WIwDKoOvWlBMMR3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDRmIdh/LJkCpnsc621Z2qW4n1SwgT3cM/7x2F9D9zWcTU67B4
	xL7k9L0oke2pD7LEpbHluhYBE757VGMfRhbL0DPZN3H0mKS6Cd2YvrBlbzfRK+YfC0vC
X-Gm-Gg: ASbGncvIwq5WEnPTwimWgKuGcLUXrOrlaVic6sbKHTfFbOqOuhwoVcB+xP6wWI1+bao
	1nx3GTA++7Jk32hve7L7cyj7aUEWaTomKyRJKZoANIJrN63Lh0+LpEnD/Sli8ayd7edjK4GOTv6
	+kexL6ZmY24A4HM6se+wfyl3wWAzMs7PZuxq1IPH19cWrM8JEldP5a8n54L2yQFcXJu+/oydTwx
	U5/667WrsLJMSMypwHybwsoDTfTwW/aXdBKRES+6nDoEEGmoM0o9WXBcf52bNuJPPpx/EzoCk9H
	Yvg8mP/cp/B+BkKOQRGf18VrTRZCebcG3BAlVZ2YahMTYDgFJSxRCgUoE+gB27lEKOzYH4OI8Uy
	3OiiKA/HIRss+iue2ZYnNP9iGq44HC4Qnpvo=
X-Google-Smtp-Source: AGHT+IHMVJv48LgJP5O70k5eAvSlSCPV6tDJVlD6+m6sZAVPOjxebsZVtdpCfVfSxyoEwWE+zeaiXw==
X-Received: by 2002:a17:903:234d:b0:234:b123:b4ff with SMTP id d9443c01a7336-23fb30cc681mr121327155ad.21.1753566107244;
        Sat, 26 Jul 2025 14:41:47 -0700 (PDT)
Received: from sultan-box ([142.147.89.207])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe4fc7a4sm22848025ad.120.2025.07.26.14.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 14:41:46 -0700 (PDT)
Date: Sat, 26 Jul 2025 14:41:41 -0700
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
Message-ID: <aIVLlZvTQFoBL70r@sultan-box>
References: <20250618091959.68293-1-Bin.Du@amd.com>
 <20250618091959.68293-7-Bin.Du@amd.com>
 <aIEiJL83pOYO8lUJ@sultan-box>
 <ff2f17c6-c5e4-4b7b-b897-8abb4cb79c35@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff2f17c6-c5e4-4b7b-b897-8abb4cb79c35@amd.com>

On Fri, Jul 25, 2025 at 05:22:41PM +0800, Du, Bin wrote:
> > > +static struct dma_buf *isp4vid_vb2_get_dmabuf(struct vb2_buffer *vb,
> > > +					      void *buf_priv,
> > > +					      unsigned long flags)
> > > +{
> > > +	struct isp4vid_vb2_buf *buf = buf_priv;
> > > +	struct dma_buf *dbuf;
> > > +
> > > +	if (buf->dbuf) {
> > > +		dev_dbg(buf->dev,
> > > +			"dbuf already created, reuse implicit dbuf\n");
> > > +		dbuf = buf->dbuf;
> > 
> > The dmabuf is reused here without taking a reference to it. When the get_dmabuf
> > memop is called by vb2_core_expbuf(), it assumes that a reference to the dmabuf
> > is acquired. So you need to add `get_dma_buf(dbuf)` here.
> After test, we found we can't add get_dma_buf(dbuf) here because it will
> make cheese APP fail to open camera with following error:
> amdgpu: [drm] *ERROR* failed to alloc gart kernel buffer (-28)

I see, it's because buf->is_expbuf is set to true even for the implicit dbuf, so
the initial reference on the implicit dbuf is never put, causing a leak.

Also, the refcount increment in isp4vid_vb2_get_dmabuf() is done every time even
when reusing the existing dbuf, but releasing the dbuf will only do a single
refcount decrement. This also causes a leak.

And, isp4vid_get_dmabuf() may fail but isp4vid_vb2_get_dmabuf() doesn't check
the return value, so there may be another leak when isp4vid_get_dmabuf() fails
because of the refcount increment. The refcount increment and setting of
buf->is_expbuf to true should only be done on success.

I have fixed all of these isp4vid_vb2_get_dmabuf() issues in the following diff,
please try it:

--- a/drivers/media/platform/amd/isp4/isp4_video.c
+++ b/drivers/media/platform/amd/isp4/isp4_video.c
@@ -476,18 +476,22 @@ static struct dma_buf *isp4vid_vb2_get_dmabuf(struct vb2_buffer *vb,
 					      unsigned long flags)
 {
 	struct isp4vid_vb2_buf *buf = buf_priv;
-	struct dma_buf *dbuf;
+	struct dma_buf *dbuf = buf->dbuf;
 
-	if (buf->dbuf) {
+	if (dbuf) {
 		dev_dbg(buf->dev,
-			"dbuf already created, reuse implicit dbuf\n");
-		dbuf = buf->dbuf;
+			"dbuf already created, reuse %s dbuf\n",
+			buf->is_expbuf ? "exported" : "implicit");
+		get_dma_buf(dbuf);
 	} else {
 		dbuf = isp4vid_get_dmabuf(vb, buf_priv, flags);
+		if (!dbuf)
+			return NULL;
+
 		dev_dbg(buf->dev, "created new dbuf\n");
+		buf->is_expbuf = true;
+		refcount_inc(&buf->refcount);
 	}
-	buf->is_expbuf = true;
-	refcount_inc(&buf->refcount);
 
 	dev_dbg(buf->dev, "buf exported, refcount %d\n",
 		buf->refcount.refs.counter);
--

> > > +		dev_warn(buf->dev, "ignore buffer free, refcount %u > 0",
> > > +			 refcount_read(&buf->refcount));
> > 
> > This refcount_read() is a possible use-after-free because `buf` is accessed
> > after isp4vid_vb2_put() puts its reference to `buf`. So something else could put
> > the last reference to `buf` and free it after this refcount dec but before the
> > refcount_read(). Maybe just remove this dev_warn() entirely?
> > 
> The warning is important to debug mem related issue, plan to keep it but
> without accessing buf or buf->refcount here. Do you think it acceptible?

Yes, that sounds good. So something like this:
`dev_warn(buf->dev, "ignore buffer free, refcount > 0");`

Sultan

