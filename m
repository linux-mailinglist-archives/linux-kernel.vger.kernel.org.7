Return-Path: <linux-kernel+bounces-726738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5A5B0108D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 03:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72A6C76234C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 01:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299343FB31;
	Fri, 11 Jul 2025 01:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CuBxoeNR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9FE2745E;
	Fri, 11 Jul 2025 01:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752195832; cv=none; b=RNykF9ECfLQszetffJ54vlNtH+H19YdWZS09fLqoDwq0LPZs9S2HzarNWyEGhcsu2dH9hDGgfGH3z6q54PlJr/0Km6mU2Bx3SPKeLLbk/uimHwpUPotiL65m0USQcL1ScXOvn3RIu+/QrEVgPwtBOECukRIFGRJfS08V5HvP0p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752195832; c=relaxed/simple;
	bh=jQSR3rE86ZLXzTeIG9hXp+78TOubi7OBGtsvDKQRAro=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=L8gSimSYskKbJLYXbTxMZbZAbjQhl2vHoT4yVjZT+h8csY6xQuMYaqcDewUUVEWLJ8K99z/Jk06NaXTg4MxdYrCllqL33dGmf8SoezzfFcHesUmzaGCfqIQNtoTRcAVaBq79u4Th7whs8yl3HuI9u6+elHgOoIfgg3LA2n1ZlMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CuBxoeNR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A63C4CEE3;
	Fri, 11 Jul 2025 01:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752195831;
	bh=jQSR3rE86ZLXzTeIG9hXp+78TOubi7OBGtsvDKQRAro=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=CuBxoeNREjKMgsATCBCqVwZSRaQrFSf9vt/rLFpM9i0Oh/mDNz0IR81k829e86qxh
	 EIouK2i2W1BjXSr4Cnf7kUd9BVDkfaP74ial7OtXQeHlDCJ5rRMWCNiM8LAVvu6/QV
	 7ZMirUIdvv8mRzVUAu2dMM0ZwoW/W+LQPzMHNwdp1TrlYQOnTtbZoutAdbK9WjDR42
	 TaBh+ONzJEsp0NREu+v2zMvYjaOQuVyb0p13xQBmiMGJkraO4TIQCRV+B0r14I5Va8
	 G1Fx6ogk6tyeO629i036p1Zkw3hmPH/J9TRP3dqN3jh3jKKfynmvUvjJ5UHM1kIwnb
	 cnCE9qQEbDiTA==
Date: Thu, 10 Jul 2025 18:03:48 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: =?UTF-8?Q?J=C3=BCrgen_Gro=C3=9F?= <jgross@suse.com>
cc: Stefano Stabellini <sstabellini@kernel.org>, linux-kernel@vger.kernel.org, 
    llvm@lists.linux.dev, Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
    Nathan Chancellor <nathan@kernel.org>, 
    Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
    Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
    xen-devel@lists.xenproject.org, 
    Abinash Singh <abinashsinghlalotra@gmail.com>
Subject: Re: [PATCH] xen/gntdev: remove struct gntdev_copy_batch from stack
In-Reply-To: <287f6b7e-069e-4a79-b72a-ae11be4c235f@suse.com>
Message-ID: <alpine.DEB.2.22.394.2507101802220.605088@ubuntu-linux-20-04-desktop>
References: <20250703073259.17356-1-jgross@suse.com> <alpine.DEB.2.22.394.2507081150230.605088@ubuntu-linux-20-04-desktop> <287f6b7e-069e-4a79-b72a-ae11be4c235f@suse.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-476946106-1752195831=:605088"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-476946106-1752195831=:605088
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 9 Jul 2025, Jürgen Groß wrote:
> On 08.07.25 21:01, Stefano Stabellini wrote:
> > On Thu, 3 Jul 2025, Juergen Gross wrote:
> > > When compiling the kernel with LLVM, the following warning was issued:
> > > 
> > >    drivers/xen/gntdev.c:991: warning: stack frame size (1160) exceeds
> > >    limit (1024) in function 'gntdev_ioctl'
> > > 
> > > The main reason is struct gntdev_copy_batch which is located on the
> > > stack and has a size of nearly 1kb.
> > > 
> > > For performance reasons it shouldn't by just dynamically allocated
> > > instead, so allocate a new instance when needed and instead of freeing
> > > it put it into a list of free structs anchored in struct gntdev_priv.
> > > 
> > > Fixes: a4cdb556cae0 ("xen/gntdev: add ioctl for grant copy")
> > > Reported-by: Abinash Singh <abinashsinghlalotra@gmail.com>
> > > Signed-off-by: Juergen Gross <jgross@suse.com>
> > > ---
> > >   drivers/xen/gntdev-common.h |  4 +++
> > >   drivers/xen/gntdev.c        | 71 ++++++++++++++++++++++++++-----------
> > >   2 files changed, 54 insertions(+), 21 deletions(-)
> > > 
> > > diff --git a/drivers/xen/gntdev-common.h b/drivers/xen/gntdev-common.h
> > > index 9c286b2a1900..ac8ce3179ba2 100644
> > > --- a/drivers/xen/gntdev-common.h
> > > +++ b/drivers/xen/gntdev-common.h
> > > @@ -26,6 +26,10 @@ struct gntdev_priv {
> > >   	/* lock protects maps and freeable_maps. */
> > >   	struct mutex lock;
> > >   +	/* Free instances of struct gntdev_copy_batch. */
> > > +	struct gntdev_copy_batch *batch;
> > > +	struct mutex batch_lock;
> > > +
> > >   #ifdef CONFIG_XEN_GRANT_DMA_ALLOC
> > >   	/* Device for which DMA memory is allocated. */
> > >   	struct device *dma_dev;
> > > diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
> > > index 61faea1f0663..1f2160765618 100644
> > > --- a/drivers/xen/gntdev.c
> > > +++ b/drivers/xen/gntdev.c
> > > @@ -56,6 +56,18 @@ MODULE_AUTHOR("Derek G. Murray
> > > <Derek.Murray@cl.cam.ac.uk>, "
> > >   	      "Gerd Hoffmann <kraxel@redhat.com>");
> > >   MODULE_DESCRIPTION("User-space granted page access driver");
> > >   +#define GNTDEV_COPY_BATCH 16
> > > +
> > > +struct gntdev_copy_batch {
> > > +	struct gnttab_copy ops[GNTDEV_COPY_BATCH];
> > > +	struct page *pages[GNTDEV_COPY_BATCH];
> > > +	s16 __user *status[GNTDEV_COPY_BATCH];
> > > +	unsigned int nr_ops;
> > > +	unsigned int nr_pages;
> > > +	bool writeable;
> > > +	struct gntdev_copy_batch *next;
> > > +};
> > > +
> > >   static unsigned int limit = 64*1024;
> > >   module_param(limit, uint, 0644);
> > >   MODULE_PARM_DESC(limit,
> > > @@ -584,6 +596,8 @@ static int gntdev_open(struct inode *inode, struct
> > > file *flip)
> > >   	INIT_LIST_HEAD(&priv->maps);
> > >   	mutex_init(&priv->lock);
> > >   +	mutex_init(&priv->batch_lock);
> > > +
> > >   #ifdef CONFIG_XEN_GNTDEV_DMABUF
> > >   	priv->dmabuf_priv = gntdev_dmabuf_init(flip);
> > >   	if (IS_ERR(priv->dmabuf_priv)) {
> > > @@ -608,6 +622,7 @@ static int gntdev_release(struct inode *inode, struct
> > > file *flip)
> > >   {
> > >   	struct gntdev_priv *priv = flip->private_data;
> > >   	struct gntdev_grant_map *map;
> > > +	struct gntdev_copy_batch *batch;
> > >     	pr_debug("priv %p\n", priv);
> > >   @@ -620,6 +635,14 @@ static int gntdev_release(struct inode *inode,
> > > struct file *flip)
> > >   	}
> > >   	mutex_unlock(&priv->lock);
> > >   +	mutex_lock(&priv->batch_lock);
> > > +	while (priv->batch) {
> > > +		batch = priv->batch;
> > > +		priv->batch = batch->next;
> > > +		kfree(batch);
> > > +	}
> > > +	mutex_unlock(&priv->batch_lock);
> > > +
> > >   #ifdef CONFIG_XEN_GNTDEV_DMABUF
> > >   	gntdev_dmabuf_fini(priv->dmabuf_priv);
> > >   #endif
> > > @@ -785,17 +808,6 @@ static long gntdev_ioctl_notify(struct gntdev_priv
> > > *priv, void __user *u)
> > >   	return rc;
> > >   }
> > >   -#define GNTDEV_COPY_BATCH 16
> > > -
> > > -struct gntdev_copy_batch {
> > > -	struct gnttab_copy ops[GNTDEV_COPY_BATCH];
> > > -	struct page *pages[GNTDEV_COPY_BATCH];
> > > -	s16 __user *status[GNTDEV_COPY_BATCH];
> > > -	unsigned int nr_ops;
> > > -	unsigned int nr_pages;
> > > -	bool writeable;
> > > -};
> > > -
> > >   static int gntdev_get_page(struct gntdev_copy_batch *batch, void __user
> > > *virt,
> > >   				unsigned long *gfn)
> > >   {
> > > @@ -953,36 +965,53 @@ static int gntdev_grant_copy_seg(struct
> > > gntdev_copy_batch *batch,
> > >   static long gntdev_ioctl_grant_copy(struct gntdev_priv *priv, void
> > > __user *u)
> > >   {
> > >   	struct ioctl_gntdev_grant_copy copy;
> > > -	struct gntdev_copy_batch batch;
> > > +	struct gntdev_copy_batch *batch;
> > >   	unsigned int i;
> > >   	int ret = 0;
> > >     	if (copy_from_user(&copy, u, sizeof(copy)))
> > >   		return -EFAULT;
> > >   -	batch.nr_ops = 0;
> > > -	batch.nr_pages = 0;
> > > +	mutex_lock(&priv->batch_lock);
> > > +	if (!priv->batch) {
> > > +		batch = kmalloc(sizeof(*batch), GFP_KERNEL);
> > > +	} else {
> > > +		batch = priv->batch;
> > > +		priv->batch = batch->next;
> > > +	}
> > > +	mutex_unlock(&priv->batch_lock);
> > 
> > I am concerned about the potentially unbounded amount of memory that
> > could be allocated this way.
> 
> Unbounded? It can be at most the number of threads using the interface
> concurrently.

That's what I meant



> > The mutex is already a potentially very slow operation. Could we instead
> > allocate a single batch, and if it is currently in use, use the mutex to
> > wait until it becomes available?
> 
> As this interface is e.g. used by the qemu based qdisk backend, the chances
> are very high that there are concurrent users. This would hurt multi-ring
> qdisk quite badly!
> 
> It would be possible to replace the mutex with a spinlock and do the kmalloc()
> outside the locked region.
> 
> > 
> > I am also OK with the current approach but I thought I would ask.
> > 
> > 
> > 
> > 
> > > +	if (!batch)
> > > +		return -ENOMEM;
> > > +
> > > +	batch->nr_ops = 0;
> > > +	batch->nr_pages = 0;
> > >     	for (i = 0; i < copy.count; i++) {
> > >   		struct gntdev_grant_copy_segment seg;
> > >     		if (copy_from_user(&seg, &copy.segments[i],
> > > sizeof(seg))) {
> > >   			ret = -EFAULT;
> > > +			gntdev_put_pages(batch);
> > >   			goto out;
> > >   		}
> > >   -		ret = gntdev_grant_copy_seg(&batch, &seg,
> > > &copy.segments[i].status);
> > > -		if (ret < 0)
> > > +		ret = gntdev_grant_copy_seg(batch, &seg,
> > > &copy.segments[i].status);
> > > +		if (ret < 0) {
> > > +			gntdev_put_pages(batch);
> > >   			goto out;
> > > +		}
> > >     		cond_resched();
> > >   	}
> > > -	if (batch.nr_ops)
> > > -		ret = gntdev_copy(&batch);
> > > -	return ret;
> > > +	if (batch->nr_ops)
> > > +		ret = gntdev_copy(batch);
> > > +
> > > + out:
> > > +	mutex_lock(&priv->batch_lock);
> > > +	batch->next = priv->batch;
> > > +	priv->batch = batch;
> > > +	mutex_unlock(&priv->batch_lock);
> > >   -  out:
> > > -	gntdev_put_pages(&batch);
> > 
> > One change from before is that in case of no errors, gntdev_put_pages is
> > not called anymore. Do we want that? Specifically, we are missing the
> > call to unpin_user_pages_dirty_lock
> 
> I don't think you are right. There was a "return ret" before the "out:"
> label before my patch.

You are right, I missed it.

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
--8323329-476946106-1752195831=:605088--

