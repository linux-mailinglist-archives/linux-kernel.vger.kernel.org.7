Return-Path: <linux-kernel+bounces-886608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 32765C36109
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 15:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE9334F4320
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 14:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49422EDD7C;
	Wed,  5 Nov 2025 14:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CJxhTk1I"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D66322C67
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762352867; cv=none; b=RKzQFwrzHGnKDCuV7u39C2sWDQpLJ7ZrhG8vMEPextm0ZXGKwk67dIcHiU+iGGop+vo8HxmQBOYd0GiVYZAVHFQODbJD6QHwbsfwUYPzvuEbm1yJGVJBpjNVquNNRvwfEv/npfOKCkw/3PKV9DDMUJvNQpkODQKvnMPxP5k2fek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762352867; c=relaxed/simple;
	bh=Kx5HjbExlotfx9BFsIQjbMPKUFyTph67j1jO1h0KIOA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HENMuFHm9LPPmCefyhr4Xr6tmAd4+/+qc2aD1nvfR22nwQI4IqTIDd+AbRI3K/siUtTRlU9FwbfGtJ0FwLBsQEGqz41is1gjEf0FpfFMX11fz4Wt10mJn74gMmVehHbuaqYsHvgx9x6fkJkKa/MEjg6TUtQ2srHQiGJswANvJKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CJxhTk1I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762352864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iEE2UforngC+1b7eNTw5Y+Y6g1pOkzaHLNr1gL9KqPY=;
	b=CJxhTk1IJphgARRsNLC9wCokkifi+DH14G5d5CTqKW/kuGlmxy4Ci2YccTOCj3SXIhPPA0
	ohWY/rGGuW7np4MXasY5ewU9rB2iVQ57dow2ZG0vT7hj/hIyk0j7YlP2N0B9fKazB5nXQz
	ZYvmCA2U+XPF6WmJnSSKj2jB9d7Y74c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-ylVNauNeMGeXAXE8hSmzeg-1; Wed,
 05 Nov 2025 09:27:39 -0500
X-MC-Unique: ylVNauNeMGeXAXE8hSmzeg-1
X-Mimecast-MFC-AGG-ID: ylVNauNeMGeXAXE8hSmzeg_1762352857
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 306091955DBA;
	Wed,  5 Nov 2025 14:27:36 +0000 (UTC)
Received: from [10.45.225.163] (unknown [10.45.225.163])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A60619560A2;
	Wed,  5 Nov 2025 14:27:32 +0000 (UTC)
Date: Wed, 5 Nov 2025 15:27:28 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Shubhankar Mishra <shubhankarm@google.com>
cc: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
    Jonathan Corbet <corbet@lwn.net>, dm-devel@lists.linux.dev, 
    linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Eric Biggers <ebiggers@google.com>, 
    Sami Tolvanen <samitolvanen@google.com>, kernel-team@android.com
Subject: Re: [PATCH] dm verity fec: Expose corrected block count via status
In-Reply-To: <20251105140645.2150719-1-shubhankarm@google.com>
Message-ID: <074e1ecc-6690-1c22-0dba-454e191e1b6f@redhat.com>
References: <20251105140645.2150719-1-shubhankarm@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Accepted, thanks.

Mikulas

On Wed, 5 Nov 2025, Shubhankar Mishra wrote:

> Enhance visibility into dm-verity Forward Error Correction (FEC)
> activity. While FEC can correct on-disk corruptions, the number of
> successful correction events is not readily exposed through a standard
> interface.
> 
> This change integrates FEC statistics into the verity target's
> .status handler for STATUSTYPE_INFO. The info output now
> includes count of corrected block by FEC.
> 
> The counter is a per-device instance atomic64_t, maintained within
> the struct dm_verity_fec, tracking blocks successfully repaired by FEC
> on this specific device instance since it was created.
> 
> This approach aligns with the standard Device Mapper mechanism for
> targets to report runtime information, as used by other targets like
> dm-integrity.
> 
> This patch also updates Documentation/admin-guide/device-mapper/verity.rst
> to reflect the new status information.
> 
> Tested:
>   Induced single-bit errors on a block device protected by dm-verity
>   with FEC on android phone. Confirmed 'dmctl status <device>' on Android
>   reports an incrementing 'fec_corrected_blocks' count after the
>   corrupted blocks were accessed.
> 
> Signed-off-by: Shubhankar Mishra <shubhankarm@google.com>
> ---
>  Documentation/admin-guide/device-mapper/verity.rst | 6 ++++--
>  drivers/md/dm-verity-fec.c                         | 4 +++-
>  drivers/md/dm-verity-fec.h                         | 1 +
>  drivers/md/dm-verity-target.c                      | 4 ++++
>  4 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/device-mapper/verity.rst b/Documentation/admin-guide/device-mapper/verity.rst
> index 8c3f1f967a3c..3ecab1cff9c6 100644
> --- a/Documentation/admin-guide/device-mapper/verity.rst
> +++ b/Documentation/admin-guide/device-mapper/verity.rst
> @@ -236,8 +236,10 @@ is available at the cryptsetup project's wiki page
>  
>  Status
>  ======
> -V (for Valid) is returned if every check performed so far was valid.
> -If any check failed, C (for Corruption) is returned.
> +1. V (for Valid) is returned if every check performed so far was valid.
> +   If any check failed, C (for Corruption) is returned.
> +2. Number of corrected blocks by Forward Error Correction.
> +   '-' if Forward Error Correction is not enabled.
>  
>  Example
>  =======
> diff --git a/drivers/md/dm-verity-fec.c b/drivers/md/dm-verity-fec.c
> index 301a9c01bf86..d792eaed0792 100644
> --- a/drivers/md/dm-verity-fec.c
> +++ b/drivers/md/dm-verity-fec.c
> @@ -177,9 +177,11 @@ static int fec_decode_bufs(struct dm_verity *v, struct dm_verity_io *io,
>  	if (r < 0 && neras)
>  		DMERR_LIMIT("%s: FEC %llu: failed to correct: %d",
>  			    v->data_dev->name, (unsigned long long)rsb, r);
> -	else if (r > 0)
> +	else if (r > 0) {
>  		DMWARN_LIMIT("%s: FEC %llu: corrected %d errors",
>  			     v->data_dev->name, (unsigned long long)rsb, r);
> +		atomic64_inc(&v->fec->corrected);
> +	}
>  
>  	return r;
>  }
> diff --git a/drivers/md/dm-verity-fec.h b/drivers/md/dm-verity-fec.h
> index a6689cdc489d..dd55037377b6 100644
> --- a/drivers/md/dm-verity-fec.h
> +++ b/drivers/md/dm-verity-fec.h
> @@ -48,6 +48,7 @@ struct dm_verity_fec {
>  	mempool_t extra_pool;	/* mempool for extra buffers */
>  	mempool_t output_pool;	/* mempool for output */
>  	struct kmem_cache *cache;	/* cache for buffers */
> +	atomic64_t corrected; /* corrected errors */
>  };
>  
>  /* per-bio data */
> diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
> index bf0aee73b074..52a0e052a5e8 100644
> --- a/drivers/md/dm-verity-target.c
> +++ b/drivers/md/dm-verity-target.c
> @@ -848,6 +848,10 @@ static void verity_status(struct dm_target *ti, status_type_t type,
>  	switch (type) {
>  	case STATUSTYPE_INFO:
>  		DMEMIT("%c", v->hash_failed ? 'C' : 'V');
> +		if (verity_fec_is_enabled(v))
> +			DMEMIT(" %lld", atomic64_read(&v->fec->corrected));
> +		else
> +			DMEMIT(" -");
>  		break;
>  	case STATUSTYPE_TABLE:
>  		DMEMIT("%u %s %s %u %u %llu %llu %s ",
> -- 
> 2.51.2.1006.ga50a493c49-goog
> 


