Return-Path: <linux-kernel+bounces-747566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFE5B1354D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06C0118969C9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC72223324;
	Mon, 28 Jul 2025 07:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b="AWDtd8nq"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0DF220F5A
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 07:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753686284; cv=none; b=V5eqq1a/naaaqJSWifI4/5bu7vsrUjop3jSf3+sh1W1jdzIfl/5YHTY53ePpzdezcROQgsM5u/aXzijKYkvHVF8krFpgoYQgwsVUSTwPYXne4hY7cutC3LFzavceH7/R4y0E1Y2/qj0JW/lekVI2ICwRgpKI7WOOlcOZu/2M7Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753686284; c=relaxed/simple;
	bh=gx2qwJ/1EBl27vpk6NyytTFfopAhDGWK+cGrJfC5nV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ruLj8RrGHw3i7iXy8bjMEFlfFHB7NuJ8aiWqyG2Wqf568Rb/wGrDeJH6TnfqtrpmA7eM+O+dgBER8sD8PIBn4/xyTOPjhk18FLQejjK1AW7dvsq0LKvaZ6lQWSpmC46Li4iHr1rdrD48ffDOSS4y61lP9oOTQ3nImOtN/csY9N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=kerneltoast.com; dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b=AWDtd8nq; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kerneltoast.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2403df11a2aso2570195ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 00:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kerneltoast.com; s=google; t=1753686281; x=1754291081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EZJyuhDRhONqMzqU5e7bbsSLCsS4zD8CKsQZd+K42t0=;
        b=AWDtd8nqQ2J/zHIhzbOCknupGQznOSM2NXx9IBW74i1+UAbJSCDGw25vMQ5gik0Tc9
         S+y4ExPRu6FA2RMURkMZ/kh4ze0eCvh+Y9Eq1uUnZB2C5yEKQn8q+L464Kn1xOmGXY2F
         wUarqzCc8oZJfqvXkliAv1mD/3xrTcf83HxbdxNrpMAnWY3kUqDVusjH110BPuA2a5Ur
         n8E8lKdbxtS2wZ1aUabzBECDb6N5A5IxFboIgQOVPNs6UNCnfgTY3hnz78M7YKexRnS6
         emguXv67hf6ZPY3AEd2S4waEKGhbBgpNyeFA8DMdutQT2Od2bx2Q7qlJBN/GwfBTqGbG
         2XLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753686281; x=1754291081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZJyuhDRhONqMzqU5e7bbsSLCsS4zD8CKsQZd+K42t0=;
        b=Lyar2sR6RjukLXtTsrb6vPNZm47Z7ZJqeAGNfcL+VR4KrclIllghd0gvIZHl6k6fmD
         eH2qR2iRie84lafkIyOItHP6b+m4ijEE9PkL9yhnmo3uL6RpkpbTUixzhDq4r9E6Ovvk
         QLj2GMmjxwnn7dm6yFQPRx3RhmEDBPkVF6DQsQUxh/UywR2fbZLcaWRMP2/Z5CmUDM3I
         ugNjgYm3SJfM/tpokkn8UnVuBGZdDcqaqct8Cct3Wy0GhuGOeNfRSk3mBrgcKTvKE60i
         bQfpu4hOYoQWYg6j3cFgJMTZo/2OGTOfK0WhJEJg+5qgj0BoYjyHwfHy6HFXpqTg7g2q
         ptNQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1dsuj5GVknnig5O8DrMbMJYYDMQCHAB2TeN57HnVl7GW36H8sWzhsEz9LnebW/Vg1NBh8oWi8CfUc5+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwanMp3URX6aUHoLiCWqU/GU9qWW0tQXDWaEqn7YhWuejAxGXQ2
	p80Z9l93BevL0d9AZv+CIAoQpjsyBUv09yxv3UpWrK8V7O2W6Dve1oa1s6qoKaedu1fF
X-Gm-Gg: ASbGnctqlwYFPUhjar+yyTR5d5z/h44E/AK7ChFzX/AGdfLKBXMzVrt4sDjAyu1QQfZ
	ue1xKqQLWQbYEkVeZmVDRwCmFWdPjNwwcJE50xyVxRp1vuYFCEGLUDr9lxYj4RAyYena3hoFs7T
	3bT9VEG+t3OMC9GdjjFUPNoBOXEaY7D2s49DljYXjvlx2SIGJCyrzC1V5IC8LJD6bHjOCSwH3hC
	ybZdDu4z48f3LIOhSomsmT3CyvsVjEeVAw07bDOhIerUUUCiKVp9m7Jbj2CW5v94QcV57AvVbBu
	pj08k+sBpyQaFBZdJlcUzSXwmIakUpm8BuJHbi8tDwMK8e2nmJUv1ojM6gUsHwhjKSHNiT9mhCi
	a57bRGu1JvvV8LVUPGZMwdSI=
X-Google-Smtp-Source: AGHT+IHQTIVfBjDvcZpuhp3bBfDaRic6qCYUSTdt0EhO0u7dMOdVBEKjG/OcI2Il9iQeyZ9vp2PFig==
X-Received: by 2002:a17:903:4b4e:b0:240:3ca6:184c with SMTP id d9443c01a7336-2403ca63fcamr21931915ad.48.1753686281382;
        Mon, 28 Jul 2025 00:04:41 -0700 (PDT)
Received: from sultan-box ([79.127.217.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e6635efb8sm8734762a91.19.2025.07.28.00.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 00:04:40 -0700 (PDT)
Date: Mon, 28 Jul 2025 00:04:37 -0700
From: Sultan Alsawaf <sultan@kerneltoast.com>
To: Bin Du <Bin.Du@amd.com>
Cc: mchehab@kernel.org, hverkuil@xs4all.nl,
	laurent.pinchart+renesas@ideasonboard.com,
	bryan.odonoghue@linaro.org, sakari.ailus@linux.intel.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	pratap.nirujogi@amd.com, benjamin.chan@amd.com, king.li@amd.com,
	gjorgji.rosikopulos@amd.com, Phil.Jawich@amd.com,
	Dominic.Antony@amd.com, Svetoslav.Stoilov@amd.com
Subject: Re: [PATCH v2 6/8] media: platform: amd: isp4 video node and buffers
 handling added
Message-ID: <aIchBRdmy48BHl2k@sultan-box>
References: <20250618091959.68293-1-Bin.Du@amd.com>
 <20250618091959.68293-7-Bin.Du@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618091959.68293-7-Bin.Du@amd.com>

I found more refcounting issues in addition to the ones from my other emails
while trying to make my webcam work:

On Wed, Jun 18, 2025 at 05:19:57PM +0800, Bin Du wrote:
> +static int isp4vid_vb2_mmap(void *buf_priv, struct vm_area_struct *vma)
> +{
> +	struct isp4vid_vb2_buf *buf = buf_priv;
> +	int ret;
> +
> +	if (!buf) {
> +		pr_err("fail no memory to map\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = remap_vmalloc_range(vma, buf->vaddr, 0);
> +	if (ret) {
> +		dev_err(buf->dev, "fail remap vmalloc mem, %d\n", ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * Make sure that vm_areas for 2 buffers won't be merged together
> +	 */
> +	vm_flags_set(vma, VM_DONTEXPAND);
> +
> +	dev_dbg(buf->dev, "mmap isp user bo 0x%llx size %ld refcount %d\n",
> +		buf->gpu_addr, buf->size, buf->refcount.refs.counter);

Use refcount_read() instead of reading the refcount's atomic_t counter directly.
This is done in 3 other places; change those to refcount_read() as well.

This didn't cause any functional problems, but it should still be fixed.

> +
> +	return 0;
> +}

[snip]

> +static void isp4vid_vb2_detach_dmabuf(void *mem_priv)
> +{
> +	struct isp4vid_vb2_buf *buf = mem_priv;
> +
> +	if (!buf) {
> +		pr_err("fail invalid buf handle\n");
> +		return;
> +	}
> +
> +	struct iosys_map map = IOSYS_MAP_INIT_VADDR(buf->vaddr);
> +
> +	dev_dbg(buf->dev, "detach dmabuf of isp user bo 0x%llx size %ld",
> +		buf->gpu_addr, buf->size);
> +
> +	if (buf->vaddr)
> +		dma_buf_vunmap_unlocked(buf->dbuf, &map);
> +
> +	// put dmabuf for exported ones
> +	dma_buf_put(buf->dbuf);
> +
> +	kfree(buf);
> +}

As mentioned in the other email, the dma_buf_put() here needs to be removed. But
that's not all: the dma_buf_vunmap_unlocked() needs to be removed too because
vb2 will always unmap the buffer before detaching it. As a result, having the
dma_buf_vunmap_unlocked() call here results in a use-after-free when vb2 calls
the unmap_dmabuf memop.

Change this function to the following:

	static void isp4vid_vb2_detach_dmabuf(void *mem_priv)
	{
		struct isp4vid_vb2_buf *buf = mem_priv;

		kfree(buf);
	}

> +static void isp4vid_qops_buffer_cleanup(struct vb2_buffer *vb)
> +{
> +	struct isp4vid_dev *isp_vdev = vb2_get_drv_priv(vb->vb2_queue);
> +	struct isp4vid_vb2_buf *buf = vb->planes[0].mem_priv;
> +
> +	dev_dbg(isp_vdev->dev, "%s|index=%u vb->memory %u",
> +		isp_vdev->vdev.name, vb->index, vb->memory);
> +
> +	if (!buf) {
> +		dev_err(isp_vdev->dev, "Invalid buf handle");
> +		return;
> +	}
> +
> +	// release implicit dmabuf reference here for vb2 buffer
> +	// of type MMAP and is exported
> +	if (vb->memory == VB2_MEMORY_MMAP && buf->is_expbuf) {
> +		dma_buf_put(buf->dbuf);
> +		dev_dbg(isp_vdev->dev,
> +			"put dmabuf for vb->memory %d expbuf %d",
> +			vb->memory,
> +			buf->is_expbuf);
> +	}
> +}
> +

Remove the isp4vid_qops_buffer_cleanup() function. It causes a use-after-free by
doing an extra dma_buf_put(). This function isn't needed now that the refcount
issues are solved.

[snip]

> +static const struct vb2_ops isp4vid_qops = {
> +	.queue_setup = isp4vid_qops_queue_setup,
> +	.buf_cleanup = isp4vid_qops_buffer_cleanup,

Remove the .buf_cleanup hook too.

> +	.buf_queue = isp4vid_qops_buffer_queue,
> +	.start_streaming = isp4vid_qops_start_streaming,
> +	.stop_streaming = isp4vid_qops_stop_streaming,
> +	.wait_prepare = vb2_ops_wait_prepare,
> +	.wait_finish = vb2_ops_wait_finish,
> +};

[snip]

Along with the changes from my other emails, I believe this finally fixes all of
the refcounting issues. No more UaF or leaks here. :-)

Sultan

