Return-Path: <linux-kernel+bounces-632537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1820EAA9896
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 18:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2A94188998C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 16:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDB9265CDA;
	Mon,  5 May 2025 16:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HaYDNELv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A267C19D09C
	for <linux-kernel@vger.kernel.org>; Mon,  5 May 2025 16:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746461716; cv=none; b=IdV3d14VIZOdfRvVOPV7WkydXZOjIfO5faTTOkKaQfMZ40wIqjq3U0HD6VCIEdvRPU4tvQPKX+TZgGoMvD3ww97n4Zz+ZMOVUhP0sipVEW8BqjL1+pBCNN4+muhOPjehBSPQHXn6P6F/EzekcBogkylkOvWz2+8s/AUgOdf1xDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746461716; c=relaxed/simple;
	bh=CaA+z1nrMs0DavxR/2ZuXbQ6DU5WdWeh1f05OF2DxvY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ab9R77cl2r2uVR60rRrDi4ub8bsl6vajw71BxuT5Ho2oXykIKHy66PPrwoNFrj5hHVC5S6VCENmwZeDrTmttSMGj/Z4QZrVaq4lO7qtvMzjovDGa3DYk4ZhFzvlnJR7K57DAHhJQTpjczmaZdIbx6kHVsYZQhlJ7vp2EfnXxg3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HaYDNELv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746461713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/6VP/PCYn7O63eQP+Ejrt/yjLZYTj6N/r7MclnN4sWY=;
	b=HaYDNELv8JyQPPsObFgWvWo4/gab/JkpuZmfTgZdGDQeoU8p2EPT67frUvQUs9s9pcmGT0
	Et5p/mhU1M1bRiE7o15f9ZbFZoS4CfwaW3xP8fbzuPgaeNjVI5Mb9TlvuAxoHhJ2KPfq5N
	+Jd/IZGKZBGFUHtixdikRaUJ/b1V3Tg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-UVoktGEhOA-W6M_znVdbbw-1; Mon,
 05 May 2025 12:15:11 -0400
X-MC-Unique: UVoktGEhOA-W6M_znVdbbw-1
X-Mimecast-MFC-AGG-ID: UVoktGEhOA-W6M_znVdbbw_1746461709
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7C76A1800263;
	Mon,  5 May 2025 16:15:09 +0000 (UTC)
Received: from [10.22.80.45] (unknown [10.22.80.45])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C15FB18001DA;
	Mon,  5 May 2025 16:15:06 +0000 (UTC)
Date: Mon, 5 May 2025 18:15:01 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>
cc: dm-devel@lists.linux.dev, Alasdair Kergon <agk@redhat.com>, 
    Mike Snitzer <snitzer@kernel.org>, linux-block@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-fscrypt@vger.kernel.org, 
    Bartosz Golaszewski <brgl@bgdev.pl>, 
    Gaurav Kashyap <quic_gaurkash@quicinc.com>
Subject: Re: [PATCH v2 2/2] dm: pass through operations on wrapped inline
 crypto keys
In-Reply-To: <20250501212320.8281-3-ebiggers@kernel.org>
Message-ID: <af9771ce-5e88-02d1-3595-fd18a6f2eb28@redhat.com>
References: <20250501212320.8281-1-ebiggers@kernel.org> <20250501212320.8281-3-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111



On Thu, 1 May 2025, Eric Biggers wrote:

> From: Eric Biggers <ebiggers@google.com>
> 
> Make the device-mapper layer pass through the derive_sw_secret,
> import_key, generate_key, and prepare_key blk-crypto operations when all
> underlying devices support hardware-wrapped inline crypto keys and are
> passing through inline crypto support.
> 
> Commit ebc4176551cd ("blk-crypto: add basic hardware-wrapped key
> support") already made BLK_CRYPTO_KEY_TYPE_HW_WRAPPED be passed through
> in the same way that the other crypto capabilities are.  But the wrapped
> key support also includes additional operations in blk_crypto_ll_ops,
> and the dm layer needs to implement those to pass them through.
> derive_sw_secret is needed by fscrypt, while the other operations are
> needed for the new blk-crypto ioctls to work on device-mapper devices
> and not just the raw partitions.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  drivers/md/dm-table.c | 177 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 177 insertions(+)
> 
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index a937e1e12482e..0a71bedff81c5 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> +
> +static int dm_exec_wrappedkey_op(struct blk_crypto_profile *profile,
> +				 struct dm_wrappedkey_op_args *args)
> +{
> +	struct mapped_device *md =
> +		container_of(profile, struct dm_crypto_profile, profile)->md;
> +	struct dm_target *ti;
> +	struct dm_table *t;
> +	int srcu_idx;
> +	int i;
> +
> +	args->err = -EOPNOTSUPP;
> +
> +	t = dm_get_live_table(md, &srcu_idx);
> +	if (!t)
> +		goto out;
> +
> +	/*
> +	 * blk-crypto currently has no support for multiple incompatible
> +	 * implementations of wrapped inline crypto keys on a single system.
> +	 * It was already checked earlier that support for wrapped keys was
> +	 * declared on all underlying devices.  Thus, all the underlying devices
> +	 * should support all wrapped key operations and they should behave
> +	 * identically, i.e. work with the same keys.  So, just executing the
> +	 * operation on the first device on which it works suffices for now.
> +	 */
> +	for (i = 0; i < t->num_targets; i++) {
> +		ti = dm_table_get_target(t, i);
> +		if (!ti->type->iterate_devices)
> +			continue;
> +		ti->type->iterate_devices(ti, dm_wrappedkey_op_callback, args);
> +		if (!args->err)
> +			break;
> +	}

I have a dumb question - if it doesn't matter through which block device 
do you set up the keys, why do you set them up through a block device at 
all?

What about making functions that set up the keys without taking block 
device as an argument, calling these functions directly and bypassing 
device mapper entirely?

Mikulas


