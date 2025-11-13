Return-Path: <linux-kernel+bounces-899974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78862C593A7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B76113B5F4D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7F52FC890;
	Thu, 13 Nov 2025 17:36:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E136C1FDD
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 17:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763055382; cv=none; b=nwYXQhAZuSEH9UAsk1GoMk+/UDlXNNFjTOJ9DKux23JTV3PTl6g43rblD6lBF7fouCvAAUmQ9jdErFzDoSvPDU6wfrpk1U2d3XidbX37x500WIQ5iGuHEilR9bQnEWkXpN55W2EBh5lWjXUd15GmPmknNLYtf88YmNMnGsn9das=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763055382; c=relaxed/simple;
	bh=836v6azOCZGWXXPMQBNFGJUiyQFnooxDOWCqr871Bkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OY3xnHqFz41/n9ItLrw0J+i2HJGIh5tLNfZRmYYbT1i3LjRbezYCRMD/JlHTnP4oV2TqkeYliGWth1XF/Y2WKnUkJsY6RgXKtW0RXjx07sr/uNwwm4gLPPrMR5o1FFvHdlUqexSE3Pg+gvoRLpF34GFQ6js4iaNFqCihzfWAY6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EF8E12FC;
	Thu, 13 Nov 2025 09:36:12 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A21B03F66E;
	Thu, 13 Nov 2025 09:36:19 -0800 (PST)
Date: Thu, 13 Nov 2025 17:36:17 +0000
From: Leo Yan <leo.yan@arm.com>
To: Mike Leach <mike.leach@linaro.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, suzuki.poulose@arm.com,
	james.clark@linaro.org
Subject: Re: [PATCH v2 1/1] coresight: fix issue where coresight component
 has no claimtags
Message-ID: <20251113173617.GA3568724@e132581.arm.com>
References: <20251027223545.2801-1-mike.leach@linaro.org>
 <20251027223545.2801-2-mike.leach@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027223545.2801-2-mike.leach@linaro.org>

On Mon, Oct 27, 2025 at 10:35:45PM +0000, Mike Leach wrote:
> Coresight components have 0 to 8 claim tag bits. ARM recommends 4 and
> the implemented claim tag protocol uses two of these.
> 
> If a component has insufficient claim tags then the protocol incorrectly
> returns an error when attempting to claim a component.
> 
> Fix by reading CLAIMSET to establish then actual number of claim tags
> and return success when attempting to claim a component were there are
> insufficient tags to implement the protocol.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-core.c | 46 ++++++++++++++++++--
>  drivers/hwtracing/coresight/coresight-priv.h | 10 +++++
>  include/linux/coresight.h                    | 15 +++++++
>  3 files changed, 68 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 3267192f0c1c..61b4902b0ead 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -131,6 +131,39 @@ coresight_find_out_connection(struct coresight_device *csdev,
>  	return ERR_PTR(-ENODEV);
>  }
>  
> +/*
> + * Reading CLAiMSET returns  a bitfield representing the number of claim tags

s/CLAiMSET/CLAIMSET

> + * implemented from bit 0 to bit nTag-1, valid bits set to 1.
> + *
> + * Claim protocol requires 2 bits so test for MS bit required,
> + * bit 1 -  CORESIGHT_CLAIM_BIT_PROTOCOL_HI
> + *
> + * return true if sufficient claim tags implemented for protocol
> + */
> +static bool coresight_claim_tags_implemented_unlocked(struct csdev_access *csa)
> +{
> +	u32 claim_bits_impl = FIELD_GET(CORESIGHT_CLAIM_BITS_MAX_MASK,
> +			 csdev_access_relaxed_read32(csa, CORESIGHT_CLAIMSET));
> +	return ((claim_bits_impl & CORESIGHT_CLAIM_BIT_PROTOCOL_HI) != 0);

How about a simple one?

        return !!FIELD_GET(CORESIGHT_CLAIM_BITS_MAX_MASK,
                           csdev_access_relaxed_read32(csa, CORESIGHT_CLAIMSET));
> +}
> +
> +/*
> + * check if we can use the claim tag protocol.
> + *
> + * If currently unknown - read register to determine if sufficient tags and
> + * save value, otherwise return current value.
> + */
> +static bool coresight_check_use_claim_tag_unlocked(struct coresight_device *csdev)
> +{
> +	if (csdev->claim_tag_info == CS_CLAIM_TAG_UNKNOWN) {
> +		if (coresight_claim_tags_implemented_unlocked(&csdev->access))
> +			csdev->claim_tag_info = CS_CLAIM_TAG_STD_PROTOCOL;
> +		else
> +			csdev->claim_tag_info = CS_CLAIM_TAG_NOT_IMPL;
> +	}
> +	return (csdev->claim_tag_info == CS_CLAIM_TAG_STD_PROTOCOL);
> +}
> +
>  static u32 coresight_read_claim_tags_unlocked(struct coresight_device *csdev)
>  {
>  	return FIELD_GET(CORESIGHT_CLAIM_MASK,

Why do not apply claim tag implemented check in
coresight_read_claim_tags_unlocked() ?

> @@ -156,6 +189,9 @@ EXPORT_SYMBOL_GPL(coresight_clear_self_claim_tag);
>  
>  void coresight_clear_self_claim_tag_unlocked(struct csdev_access *csa)
>  {
> +	if (!coresight_claim_tags_implemented_unlocked(csa))
> +		return;

Here it does not call coresight_check_use_claim_tag_unlocked(), which
means the cached flag is not used. I think we should be consistent
across all claim tag functions.

This is why I suggested to put the flag into csdev_access rather than
in csdev. Seems to me, it is nature to use csdev_access to store this
flag, as it presents a attribute for register access (we can consider
csdev presents a device on bus).

If agree with above, then we can create a new function:

  void coresight_init_self_claim_tag(struct csdev_access *csa)
  {
      csa->claim_tag_implemented = !!FIELD_GET(CORESIGHT_CLAIM_BITS_MAX_MASK,
                           csdev_access_relaxed_read32(csa, CORESIGHT_CLAIMSET));

      if (csa->claim_tag_implemented)
          coresight_clear_self_claim_tag(csa);
  }

This function is called by probe()s in CoreSight drivers, afterwards,
simply check the flag "csa->claim_tag_implemented".

A minor benefit is we can drop coresight_check_use_claim_tag_unlocked()
and the enum coresight_claim_tag_info, as we just need to initialize
csa->claim_tag_implemented at the init phase.

> +
>  	csdev_access_relaxed_write32(csa, CORESIGHT_CLAIM_SELF_HOSTED,
>  				     CORESIGHT_CLAIMCLR);
>  	isb();
> @@ -175,12 +211,13 @@ EXPORT_SYMBOL_GPL(coresight_clear_self_claim_tag_unlocked);
>  int coresight_claim_device_unlocked(struct coresight_device *csdev)
>  {
>  	int tag;
> -	struct csdev_access *csa;
>  
>  	if (WARN_ON(!csdev))
>  		return -EINVAL;
>  
> -	csa = &csdev->access;
> +	if (!coresight_check_use_claim_tag_unlocked(csdev))
> +		return 0;

> +
>  	tag = coresight_read_claim_tags_unlocked(csdev);
>  
>  	switch (tag) {
> @@ -190,7 +227,7 @@ int coresight_claim_device_unlocked(struct coresight_device *csdev)
>  			return 0;
>  
>  		/* There was a race setting the tag, clean up and fail */
> -		coresight_clear_self_claim_tag_unlocked(csa);
> +		coresight_clear_self_claim_tag_unlocked(&csdev->access);
>  		dev_dbg(&csdev->dev, "Busy: Couldn't set self claim tag");
>  		return -EBUSY;
>  
> @@ -237,6 +274,9 @@ void coresight_disclaim_device_unlocked(struct coresight_device *csdev)
>  	if (WARN_ON(!csdev))
>  		return;
>  
> +	if (!coresight_check_use_claim_tag_unlocked(csdev))
> +		return;

If use the method mentioned, no need to spread
coresight_check_use_claim_tag_unlocked() in claim and disclaim functions.

Thanks,
Leo

> +
>  	if (coresight_read_claim_tags_unlocked(csdev) == CORESIGHT_CLAIM_SELF_HOSTED)
>  		coresight_clear_self_claim_tag_unlocked(&csdev->access);
>  	else
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index 33e22b1ba043..270f179c8535 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -41,6 +41,16 @@ extern const struct device_type coresight_dev_type[];
>  #define CORESIGHT_CLAIM_SELF_HOSTED	2
>  #define CORESIGHT_CLAIM_INVALID		3
>  
> +/*
> + * Coresight specification defines a maximum of 8 claim tag bits.
> + * The precise number is implementation defined, and may be obtained by
> + * reading the CLAIMSET register.
> + */
> +#define CORESIGHT_CLAIM_BITS_MAX_MASK	GENMASK(7, 0)
> +
> +/* MS Bit required by the protocol */
> +#define CORESIGHT_CLAIM_BIT_PROTOCOL_HI	BIT(1)
> +
>  #define TIMEOUT_US		100
>  #define BMVAL(val, lsb, msb)	((val & GENMASK(msb, lsb)) >> lsb)
>  
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 6de59ce8ef8c..fefe4317a793 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -242,6 +242,19 @@ struct coresight_trace_id_map {
>  	raw_spinlock_t lock;
>  };
>  
> +/*
> + * Coresight claim tag info:
> + * CS_CLAIM_TAG_UNKNOWN      - not yet checked.
> + * CS_CLAIM_TAG_STD_PROTOCOL - using standard claim/release protocol.
> + * CS_CLAIM_TAG_NOT_IMPL     - no claim tags available.
> + */
> +enum coresight_claim_tag_info {
> +	CS_CLAIM_TAG_UNKNOWN,
> +	CS_CLAIM_TAG_STD_PROTOCOL,
> +	CS_CLAIM_TAG_NOT_IMPL,
> +};
> +
> +
>  /**
>   * struct coresight_device - representation of a device as used by the framework
>   * @pdata:	Platform data with device connections associated to this device.
> @@ -265,6 +278,7 @@ struct coresight_trace_id_map {
>   *		CS_MODE_SYSFS. Otherwise it must be accessed from inside the
>   *		spinlock.
>   * @orphan:	true if the component has connections that haven't been linked.
> + * @claim_tag_info: how the device is using claim tags.
>   * @sysfs_sink_activated: 'true' when a sink has been selected for use via sysfs
>   *		by writing a 1 to the 'enable_sink' file.  A sink can be
>   *		activated but not yet enabled.  Enabling for a _sink_ happens
> @@ -291,6 +305,7 @@ struct coresight_device {
>  	local_t	mode;
>  	int refcnt;
>  	bool orphan;
> +	enum coresight_claim_tag_info claim_tag_info;
>  	/* sink specific fields */
>  	bool sysfs_sink_activated;
>  	struct dev_ext_attribute *ea;
> -- 
> 2.32.0
> 

