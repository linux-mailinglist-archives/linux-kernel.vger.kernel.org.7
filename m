Return-Path: <linux-kernel+bounces-856431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8441ABE4278
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 16BB64FDA5F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F83C3451B0;
	Thu, 16 Oct 2025 15:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D7KtpM8Z"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073C5343D93
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760627546; cv=none; b=lcniDyFP3gS4RRwO1Q1Js1hYb9mNQ8/YecPLQC+U8wCcySgHGCluBHsBWDhOf/FUK7hoRrid5fjGuHNgqeN5bA4MOi0+Xy+ni0mo/4bTBvY5QWdvP8C8omOaUqB85nTxYjCz3ckJZeEMuyYhjYeHrmyrl/jj+B2FlkmZOv5voSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760627546; c=relaxed/simple;
	bh=yCg35r4ms7gsC/mGtCURPao3mJuEsBfHclwa8/neqMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxqrTOet4eQZKPbK995IoZFwXeMMnnxEnVsNS/36dLPkWvTg+7SHSEGCptDZ3rWNXjw0IRN5BZiFIO97JOSsZL6dw/30fW2pN7rxJGd0e/OpQRGdokG3gPvleL4k+cPTNlMotguK6S7A7C8x4d8bLjxK4XxDxtYInES3k3o+eBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D7KtpM8Z; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-780fc3b181aso557203b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760627544; x=1761232344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ut2s/s3FIafEe4ZDshWAioE5+2hw+U5ZIXkh0yek/f4=;
        b=D7KtpM8ZqjDr8SDyt1fR1cBcERWth6ral6Br4EmIldcjUK3n+4GlY/oniLPuV+LRtT
         R5YIWzlOt/4egCI4aleRjZQYoy/C0KhxxgVq6jDWEwNRDiw84Du+scun3p6FCxQB405U
         VGCDTdIaDfXoHuqFhPC+b3QCBtiZe4NLjVG1HTa3Q2bBHLTbyXHNGIHD1lIncuH6sXAV
         Clm4vFqaL6YD7nQPeyZNkXXBmBIJ3DlgUGgj0fjTra9NPIUysZX+u8wbUQw8+UtOZzE4
         elXCMVSiDxqscLCISHjPnJ1IeW2Ln8lXUS3392UZ9g01G2jgjkrDTxd8KBgG17tGSoDD
         NQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760627544; x=1761232344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ut2s/s3FIafEe4ZDshWAioE5+2hw+U5ZIXkh0yek/f4=;
        b=v6pB+IDzuBe+P50TnwfDhn3qTJWsIfq0Cacz9FOJ3U13Nfmb1LfCI3IH1IwTcjFOJ8
         LjC+nxsdwtx8tB45AISCPA/GCBQP3Ip9yipwr/OAp5F9TZyyu7a/Rlf/zrh8ApFV9UIi
         kSzX1l7elMidvvhn7QQ86rp2Zd8BDwz7OJti493/rKTDY/2rmR1XDTtT+TX0BoJqtorp
         X9iGjA8wfRUhT6O59ZHW+9/fLXx9NSARMpKqZ6gGrpMhZrgDbMKZXgIIdCVQ0+EQnqrI
         FmbTjSvl7sB3D3Z74c8MYyyhXCWc8YTqFqHTYW3a3XbsRzp0Hw9/in9qJ95cvhsn6nZa
         xsng==
X-Forwarded-Encrypted: i=1; AJvYcCVFJldsTaku4nRbQtprEfEqVVXYJDniYX7g/vjaelsINS1EcIVGbLw0kslsrlLhjnuL8UoyBNy7kXysA3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaRqutC+SJVbpzJhvrBhUaet+a5XRQxCvwLvWkSqKdYhexc1ue
	NuRhuen428u+nBH6wsV6CNPOsmglfd4MegERFNjYaqwnxSdYRE0A5UGElCYsqmcDtsI=
X-Gm-Gg: ASbGncsXGG1GuhNlWnIfzzZHbhMLiTMm6d4H/yCIlVFdlHmQDrSkUhIaHym/3CGhJRN
	krzsL8UHtqQhmLduEw6z7Nt9WOSMhB3ZdlHptD6niy6/NIhx7Reyo4rhboReZI+nTmVYtXcax0X
	t7JALV69oNe7KHgypvbhhXyN7MD25OWn27+gfFbbaMVRh5TPG1L4bG1q31tU2F4q1Sd+/hccc+7
	f9etxQ5ed2TU1U8bFMs6liGKFuNH8upCIUoeVkuNn2e43OSOCway3Zy/FapITXXukx/9ohwySaX
	X7uJ8Vb8z6a0mYZ/tHY3RLyHrP+WSuL+pf8PRPmkRL6LfQIueYSYdxBmSY5RNR9tpesa3L7gIS1
	abAKoiAjIY7RbaURYcVsvqIqe9wPrAcixtfpKNF56SiVEd+Eg5MPBpdyRr6pvgKFWzm12RF64r7
	zOShPZLxknBVUgCQrHunEnT4dd
X-Google-Smtp-Source: AGHT+IELjLEOjB5GZ8wek/jbgtacavjiPcJ12k9YT8oJ8gP2sncFT79C4nC7cfzpXzG3kveX/6VhGQ==
X-Received: by 2002:a05:6a20:e212:b0:263:52cb:bc49 with SMTP id adf61e73a8af0-334a8607db3mr427025637.35.1760627544219;
        Thu, 16 Oct 2025 08:12:24 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:c6a8:58de:b8f8:4d8e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a22bb5b8fsm3152334a12.37.2025.10.16.08.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 08:12:23 -0700 (PDT)
Date: Thu, 16 Oct 2025 09:12:21 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Tanmay Shah <tanmay.shah@amd.com>
Cc: andersson@kernel.org, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] remoteproc: core: full attach detach during recovery
Message-ID: <aPELVfhkk0qDXqa9@p14s>
References: <20251002153343.766352-1-tanmay.shah@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002153343.766352-1-tanmay.shah@amd.com>

Good morning,

On Thu, Oct 02, 2025 at 08:33:46AM -0700, Tanmay Shah wrote:
> Current recovery operation does only virtio device reset, but do not
> free and re-allocate all the resources. As third-party is booting the
> remote processor during attach-detach, it is better to free and
> re-allocate resoruces as resource table state might be unknown to linux
> when remote processor boots and reports crash.

1) When referring to "third-party", should I assume boot loader?
2) Function rproc_attach_recovery() calls __rproc_detach(), which in turn calls
rproc_reset_rsc_table_on_detach().  That function deals explicitly with the
resource table.
3) The code in this patch mixes __rproc_detach() with rproc_attach(), something
that is likely not a good idea.  We either do __rproc_detach/__rproc_attach or
rproc_detach/rproc_attach but I'd like to avoid the mix-and-match to keep the
amount of possible states to a minimum.

If I understand correctly, the main motivation for this patch is the management
of the resource table.  But as noted in (2), this should be taken care of.  Am I
missing some information?

Thanks,
Mathieu

> 
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
> 
> Note: RFC patch for design discussion. Please do not merge. 
> 
>  drivers/remoteproc/remoteproc_core.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 825672100528..4971508bc5b2 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1786,7 +1786,20 @@ static int rproc_attach_recovery(struct rproc *rproc)
>  	if (ret)
>  		return ret;
>  
> -	return __rproc_attach(rproc);
> +	/* clean up all acquired resources */
> +	rproc_resource_cleanup(rproc);
> +
> +	/* release HW resources if needed */
> +	rproc_unprepare_device(rproc);
> +
> +	rproc_disable_iommu(rproc);
> +
> +	/* Free the copy of the resource table */
> +	kfree(rproc->cached_table);
> +	rproc->cached_table = NULL;
> +	rproc->table_ptr = NULL;
> +
> +	return rproc_attach(rproc);
>  }
>  
>  static int rproc_boot_recovery(struct rproc *rproc)
> 
> base-commit: 56d030ea3330ab737fe6c05f89d52f56208b07ac
> -- 
> 2.34.1
> 

