Return-Path: <linux-kernel+bounces-862623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FB2BF5C6C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E84DD18A5832
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C446232B9A4;
	Tue, 21 Oct 2025 10:27:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066382DCF4C;
	Tue, 21 Oct 2025 10:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761042430; cv=none; b=ZlUzs6ylQQaXh1Ib6TYt6hJY1IL23f33JUuG/Om5i3GmrXp5gsbcLKPJyTTT/I7TSxdNMtLfO3lDvohuWKhnJfhNZImE3fdtr7i9X3ZRqEEPv0wcW4DiOAUqB1/rt+8fsoVjKNN0qj9G8zHDphoy99RiiplFOSt7FFMAO23bIl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761042430; c=relaxed/simple;
	bh=9C2gF+29Fvzf+fuvgdOECtCr7Dt16kUl1iAoSL3nZCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2BaSOa/SFDV4fNABKyUwNSiSoJMSu4f4pxT8eiXO+RlR/++zF+HVxhIdG2QFeSO8Saoh0xHfTpuWgl6p4MCUYcFEHfkZReatiwcFGDb435Eh9shLrXG8PfqBkeVzAmzRrBsDwhEA9rYyDe7784adLD3vfZCjWArjEc3tkSp70I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1433F1007;
	Tue, 21 Oct 2025 03:26:59 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1EFF3F63F;
	Tue, 21 Oct 2025 03:27:04 -0700 (PDT)
Date: Tue, 21 Oct 2025 11:27:02 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, sudeep.holla@arm.com,
	james.quinlan@broadcom.com, f.fainelli@gmail.com,
	vincent.guittot@linaro.org, etienne.carriere@st.com,
	peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com,
	dan.carpenter@linaro.org, d-gole@ti.com, souvik.chakravarty@arm.com
Subject: Re: [PATCH 06/10] firmware: arm_scmi: Add System Telemetry driver
Message-ID: <aPdf9lyY9ysq2mPx@pluto>
References: <20250925203554.482371-1-cristian.marussi@arm.com>
 <20250925203554.482371-7-cristian.marussi@arm.com>
 <20251020172328.00002fc3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020172328.00002fc3@huawei.com>

On Mon, Oct 20, 2025 at 05:23:28PM +0100, Jonathan Cameron wrote:
> On Thu, 25 Sep 2025 21:35:50 +0100
> Cristian Marussi <cristian.marussi@arm.com> wrote:
> 
> > Add a new SCMI System Telemetry driver which gathers platform Telemetry
> > data through the new the SCMI Telemetry protocol and expose all of the
> > discovered Telemetry data events on a dedicated pseudo-filesystem that
> > can be used to interactively configure SCMI Telemetry and access its
> > provided data.
>

Hi,
 
> I'm not a fan of providing yet another filesystem but you didn't
> lay out reasoning in the cover letter.

Sorry, I dont understand..you mean here that I did NOT provide enough reasons
why I am adopting a new FS approach ? ... or I misunderstood the English ?

.. because I did provide a lot of reasons (for my point-of-view) to go
for a new FS in the cover-letter...

> 
> One non trivial issue is that you'll have to get filesystem review on this.
> My review is rather superficial but a few things stood out.

Well yes I would have expected that, but now the FS implementation
internals of this series is definetely immature and to be reworked (to
the extent of using a well-know deprecated FS mount api at first..)

So I posted this V1 to lay-out the ideas and the effective FS API layout
but I was planning to extend the review audience once I have reworked fully
the series FS bits in the next V2...

> 
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> 
> > diff --git a/drivers/firmware/arm_scmi/scmi_system_telemetry.c b/drivers/firmware/arm_scmi/scmi_system_telemetry.c
> > new file mode 100644
> > index 000000000000..2fec465b0f33
> > --- /dev/null
> > +++ b/drivers/firmware/arm_scmi/scmi_system_telemetry.c
> 
> 
> > +static ssize_t
> > +scmi_tlm_update_interval_write(struct file *filp, const char __user *buf,
> > +			       size_t count, loff_t *ppos)
> > +{
> > +	struct scmi_tlm_inode *tlmi = to_tlm_inode(file_inode(filp));
> > +	const struct scmi_tlm_setup *tsp = tlmi->tsp;
> > +	bool is_group = IS_GROUP(tlmi->cls->flags);
> > +	unsigned int update_interval_ms = 0, secs = 0;
> > +	int ret, grp_id, exp = -3;
> > +	char *kbuf, *p, *token;
> > +
> > +	kbuf = memdup_user_nul(buf, count);
> 
> I'd use a __free(kfree) as then you can directly return in error paths.
> Will keep the buffer around a little longer than strictly necessary but
> I'm not seeing where that will cause problems.
> 

Ok.

> > +	if (IS_ERR(kbuf))
> > +		return PTR_ERR(kbuf);
> > +
> > +	p = kbuf;
> > +	token = strsep(&p, " ");
> > +	if (!token) {
> > +		/* At least one token must exist to be a valid input */
> > +		ret = -EINVAL;
> > +		goto err;
> > +	}
> > +
> > +	ret = kstrtouint(token, 0, &secs);
> > +	if (ret)
> > +		goto err;
> > +
> > +	token = strsep(&p, " ");
> > +	if (token) {
> > +		ret = kstrtoint(token, 0, &exp);
> > +		if (ret)
> > +			goto err;
> > +	}
> > +
> > +	kfree(kbuf);
> > +
> > +	update_interval_ms = SCMI_TLM_BUILD_UPDATE_INTERVAL(secs, exp);
> > +
> > +	grp_id = !is_group ? SCMI_TLM_GRP_INVALID : tlmi->grp->info->id;
> > +	ret = tsp->ops->collection_configure(tsp->ph, grp_id, !is_group, NULL,
> > +					     &update_interval_ms, NULL);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return count;
> > +
> > +err:
> > +	kfree(kbuf);
> > +	return ret;
> > +}
> 
> 
> > +
> > +static int scmi_tlm_bulk_buffer_allocate_and_fill(struct scmi_tlm_inode *tlmi,
> > +						  struct scmi_tlm_priv *tp)
> > +{
> > +	const struct scmi_tlm_setup *tsp = tlmi->tsp;
> > +	const struct scmi_tlm_class *cls = tlmi->cls;
> > +	struct scmi_telemetry_de_sample *samples;
> > +	bool is_group = IS_GROUP(cls->flags);
> > +	int ret, num_samples, res_id;
> > +
> > +	num_samples = !is_group ? tlmi->info->base.num_des :
> > +		tlmi->grp->info->num_des;
> > +	tp->buf_sz = num_samples * MAX_BULK_LINE_CHAR_LENGTH;
> > +	tp->buf = kzalloc(tp->buf_sz, GFP_KERNEL);
> > +	if (!tp->buf)
> > +		return -ENOMEM;
> > +
> > +	res_id = is_group ? tlmi->grp->info->id : SCMI_TLM_GRP_INVALID;
> > +	samples = kcalloc(num_samples, sizeof(*samples), GFP_KERNEL);
> > +	if (!samples) {
> > +		kfree(tp->buf);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	ret = tp->bulk_retrieve(tsp, res_id, &num_samples, samples);
> > +	if (ret) {
> > +		kfree(samples);
> Free them in reverse of allocation. Makes it easier to review.
> 

Ok.

> > +		kfree(tp->buf);
> > +		return ret;
> > +	}
> > +
> > +	ret = scmi_tlm_buffer_fill(tsp->dev, tp->buf, tp->buf_sz, &tp->buf_len,
> > +				   num_samples, samples);
> I'm a little surprised by lifetime of tp->buf if this return an error.
> Perhaps add a comment on that.

Ok.

> 
> > +	kfree(samples);
> > +
> > +	return ret;
> > +}
> 
> 
> > +
> > +static struct scmi_tlm_instance *scmi_tlm_init(struct scmi_tlm_setup *tsp,
> > +					       int instance_id)
> > +{
> > +	struct device *dev = tsp->dev;
> > +	struct scmi_tlm_instance *ti;
> > +	int ret;
> > +
> > +	ti = devm_kzalloc(dev, sizeof(*ti), GFP_KERNEL);
> Given use of devm I'm guessing this will only be called from probe().
> With that in mind...

Yes...

> > +	if (!ti)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	ti->info = tsp->ops->info_get(tsp->ph);
> > +	if (!ti->info) {
> > +		dev_err(dev, "invalid Telemetry info !\n");
> > +		return ERR_PTR(-EINVAL);
> 
> 		return dev_err_probe()
> 

Indeed.

> > +	}
> > +
> > +	ti->id = instance_id;
> > +	ti->tsp = tsp;
> > +
> > +	ret = scmi_tlm_root_instance_initialize(dev, ti);
> > +	if (ret)
> > +		return ERR_PTR(ret);
> > +
> > +	ret = scmi_telemetry_des_initialize(dev, ti);
> > +	if (ret)
> > +		return ERR_PTR(ret);
> > +
> > +	ret = scmi_telemetry_groups_initialize(dev, ti);
> > +	if (ret)
> > +		return ERR_PTR(ret);
> > +
> > +	return ti;
> > +}
> > +
> > +static int scmi_telemetry_probe(struct scmi_device *sdev)
> > +{
> > +	const struct scmi_handle *handle = sdev->handle;
> > +	struct scmi_protocol_handle *ph;
> > +	struct device *dev = &sdev->dev;
> > +	struct scmi_tlm_instance *ti;
> > +	struct scmi_tlm_setup *tsp;
> > +	const void *ops;
> > +
> > +	if (!handle)
> > +		return -ENODEV;
> > +
> > +	ops = handle->devm_protocol_get(sdev, sdev->protocol_id, &ph);
> > +	if (IS_ERR(ops))
> > +		return dev_err_probe(dev, PTR_ERR(ops),
> > +				     "Cannot access protocol:0x%X\n",
> > +				     sdev->protocol_id);
> > +
> > +	tsp = devm_kzalloc(dev, sizeof(*tsp), GFP_KERNEL);
> > +	if (!tsp)
> > +		return -ENOMEM;
> > +
> > +	tsp->dev = dev;
> > +	tsp->ops = ops;
> > +	tsp->ph = ph;
> > +
> > +	ti = scmi_tlm_init(tsp, atomic_fetch_inc(&scmi_tlm_instance_count));
> > +	if (IS_ERR(ti))
> > +		return PTR_ERR(ti);
> > +
> > +	mutex_lock(&scmi_tlm_mtx);
> > +	list_add(&ti->node, &scmi_telemetry_instances);
> > +	if (scmi_tlm_sb) {
> > +		int ret;
> > +
> > +		/*
> > +		 * If the file system was already mounted by the time this
> > +		 * instance was probed, register explicitly, since the list
> > +		 * has been scanned already.
> > +		 */
> > +		mutex_unlock(&scmi_tlm_mtx);
> > +		ret = scmi_telemetry_instance_register(scmi_tlm_sb, ti);
> > +		if (ret)
> > +			return ret;
> > +		mutex_lock(&scmi_tlm_mtx);
> I guess this will make sense in later patches.  Right now it looks like you should
> just check scmi_tlb_sb after releasing the lock.
> E.g.
> 	mutex_lock(&scmi_tlm_mtx); //I'd spell out mutex
> 	list_add(&ti->ode, &scam_telemetry_instances);
> 	mutex_unlock(&scmi_tlm_mtx);
> 	if (scmi_tlm_sb) {
> 		ret = scmi....
> 
> > +	}
> If you really have to check if (scmi_tlb_sb) under the lock just take a copy into a local
> variable and use that after releasing the lock.
> 


Yes a lot to review/rework here...

> > +	mutex_unlock(&scmi_tlm_mtx);
> > +
> > +	dev_set_drvdata(&sdev->dev, ti);
> > +
> > +	return 0;
> > +}
> 
> > +static const struct scmi_device_id scmi_id_table[] = {
> > +	{ SCMI_PROTOCOL_TELEMETRY, "telemetry" },
> > +	{ },
> 
> Drop that trailing comma.  Only thing it does is make
> it easy to introduce a bug by putting something after it.
> 

I'll do.

> > +};
> > +MODULE_DEVICE_TABLE(scmi, scmi_id_table);
> 
> 
> > +
> > +static int __init scmi_telemetry_init(void)
> > +{
> > +	int ret;
> > +
> > +	ret = scmi_register(&scmi_telemetry_driver);
> Why do this first?  My immediate assumption is this allows
> for drivers to register in parallel with the rest of init
> happening.  Feels like it should be the last thin in init.
> 
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = sysfs_create_mount_point(fs_kobj, TLM_FS_MNT);
> > +	if (ret && ret != -EEXIST) {
> > +		scmi_unregister(&scmi_telemetry_driver);
> 
> Given the classic pattern of building up more things to undo.
> Use gotos and an error handling block as that's what we normally
> expect to see in the kernel.

Ok.

> 
> > +		return ret;
> > +	}
> > +
> > +	ret = register_filesystem(&scmi_telemetry_fs);
> > +	if (ret) {
> > +		sysfs_remove_mount_point(fs_kobj, TLM_FS_MNT);
> > +		scmi_unregister(&scmi_telemetry_driver);
> > +	}
> > +
> > +	return ret;
> > +}
> > +module_init(scmi_telemetry_init);
> > +
> > +static void __exit scmi_telemetry_exit(void)
> > +{
> > +	int ret;
> > +
> > +	ret = unregister_filesystem(&scmi_telemetry_fs);
> 
> Documentation says this only fails if the filesystem isn't found.
> How can that happen if the init above succeeded?
> 
> I noted from a quick scan that most filesystems don't check the
> return value.  The only one that does uses it to print a message
> and otherwise continues as if it succeeded.

Ok.

> 
> 
> 
> > +	if (!ret)
> > +		sysfs_remove_mount_point(fs_kobj, TLM_FS_MNT);
> > +	else
> > +		pr_err("Failed to unregister %s\n", TLM_FS_NAME);
> Given 1 out of 100s of file systems bothers to do this. I'm suspecting
> it's a thing that won't happen.
> 
> I'd just call the sysfs_remove_mount_point() unconditionally.
> 

Ok.

I wil rework heavily in V2 the FS layer and post also to the related FS
mailing lists...

Thanks,
Cristian

