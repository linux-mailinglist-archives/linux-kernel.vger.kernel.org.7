Return-Path: <linux-kernel+bounces-827444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D5AB91C77
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A1C0426906
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC89280025;
	Mon, 22 Sep 2025 14:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GP+ttq9V"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C144027FB25
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758552216; cv=none; b=EpVr505ZdPc9p2AvJHYEpiUNPV/0XmwcREg2jDWOWZHnt8QFXIfHnKFuMCOkPQjmJoS/x0Y/HIyORXctFEMQK/9yax2X+J/z7EHgvHAJm2+Fyt3K/svrbhKadh2hV/XBGDTSUohsE4sDvXcpnS4lCAE1HJzwdh1aTgQ3w6ShWRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758552216; c=relaxed/simple;
	bh=+nr7BwNeXXEabqJuUJ4Znex193FXbxHrLOOQ7ddOBBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kXs5ME0KyxNuA0dVLCPkAQnBn+6cPYuC+bGZNZDAW+OFC9Oj19UfDlw6Q2lGVy7E2gahjaPZFcBw1mTlXKX97qVWES+0VNh9Ojnks0gibQP1pMw5WgtXzRnApC5712sfE2Ipfzfv5DKKpeMGGbqUoEFGVQB5OK5b2V3DddG665U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GP+ttq9V; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45ddc7d5731so30729455e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758552213; x=1759157013; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=69/QOJ2Y48NhDwYXM0mdWy8yyNCu9BEWxX9HIURiSOo=;
        b=GP+ttq9VqPVJvoDSCapWXV30/uNKjKCyJx0uasIJMbGyeZaf6q3bAFdlN0kTPooyhu
         mJhutkcAA4knAXlS0kJGSBwLj6lqR6NNOJ4JfD5EEtsBdnN0C2bu0sBdh7YsCdK/OKiX
         ZlTgf3Iy9AC99rvgAjDjPXBa/CqgyuDtk+cpFWiPrmOt7lTI5yDLZi4jPlj9IaUWleJv
         MiTkYBwpdn3waE9ziddc+9yEcr1eTyAQKwd1mfiBtYCu1Db+fueWXsxVxXX+hcjcTYBC
         4toA+cRmfiKJvRon0sqMyEyrkiIRmCld6232PDVjaezxxCi5UuZKVjl7uV5kxAuPW/PF
         nykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758552213; x=1759157013;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=69/QOJ2Y48NhDwYXM0mdWy8yyNCu9BEWxX9HIURiSOo=;
        b=ndW2AyhcUSMeAxSsxWWNHoGnca2iEfNr92ih5/TIPfySE8dHSpGagOdkHQ6imE+zUq
         Irq1LId7WVbVEf1s2lCrhLqAsbMjQ9WAL1meSbSdTL8mYIcIycvOX9lnmy+vVQbopxIe
         NkaKOwy2qP6FFIkeCSikCGjKXiukND8IErgbNxLl3RhoWDk8kMM9BvysuzVCWYwD0ycn
         YhpOE74TJL3OGq6FCTURd9yEnylY0+yg5rIEC/+FzIL0qlGl4XOJpG3VN9xzMlX8DPm+
         9kd2Zvqi7+d6CHHLPkNZBpzAYEujoOpuGiZu8NVnusBZJQbHY9giINTmG7JhO0ZIYrLQ
         sVYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUK3/chwdG7GjpuNFNRGwP5K+w+ySfxrGgecWbEgi/j+EXv0BHx2l5E6L1a0+nmEtPJ0f/siRyR+6oiuFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPybYrjPra731emlxgoGONvYgqm0ltKHRRxF23rdPzSwE5/z3U
	7m0EgRSsK70Bw27swxxan0l2SrJx7t8EP6JWpQMuzHLozCulHIPWBwVikom5VFU+aNLKFzsucBr
	JLbTD
X-Gm-Gg: ASbGncsEf62cpirORPQ5ugIZ6DoL2gDwbFuxM61x6/65/+lt/UeIDL7aozqs8L20/5r
	RtuSbvq5FnZR+sH/3KUI4nO2eGlpdSnL4D6CXZgxKa48nKHyiLqV2sw+1s/lDZiW94h3srQK1hQ
	VqzRgD/wCH9ELEgnoJ3xypxZnsoWLGmU/UZ6nE9fj1vfVT+Kxb5y1spp+Y8DmRhatcrLqjStPv7
	KzvpuJ1orP2yJOeOHUN2U9EfOPa7f07bg56gvmAPszZksEWx7RRmm9ygy1ebkguj2igz91oAY1T
	inlkXPocN8SjKmI7ryhssZ+olL2qZnXBObVBFJkzARZUaRjSxvos2P97tw8Z8JmzoviBywU84+w
	b6/rfQ4dHoq06GJ9R0jj2NSHc7KcKNji6Rdrwe29vxR44MEEVfBAuTUq9PpGPCj+X06nBMD8=
X-Google-Smtp-Source: AGHT+IExXUNKRCMA4QKU/OEH4DlhUgNPwHI+yErgzi3NlV2OxxP1jX78IKGVbB7ztYO+b2kgWihAhw==
X-Received: by 2002:a5d:5846:0:b0:3eb:c276:a359 with SMTP id ffacd0b85a97d-3ee7c552a1emr9200707f8f.9.1758552212963;
        Mon, 22 Sep 2025 07:43:32 -0700 (PDT)
Received: from ?IPV6:2804:18:10d:538:67e6:b01b:caa9:3531? ([2804:18:10d:538:67e6:b01b:caa9:3531])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfbb7c3bbsm12958965b3a.7.2025.09.22.07.43.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 07:43:32 -0700 (PDT)
Message-ID: <da3e2b5a-a5da-4526-9884-8789990ebf95@suse.com>
Date: Mon, 22 Sep 2025 11:41:22 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cifs: client: force multichannel=off when
 max_channels=1
To: rajasimandalos@gmail.com, linux-cifs@vger.kernel.org
Cc: sfrench@samba.org, pc@manguebit.org, ronniesahlberg@gmail.com,
 sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com,
 linux-kernel@vger.kernel.org, Rajasi Mandal <rajasimandal@microsoft.com>
References: <20250922082417.816331-1-rajasimandalos@gmail.com>
Content-Language: en-US
From: Henrique Carvalho <henrique.carvalho@suse.com>
In-Reply-To: <20250922082417.816331-1-rajasimandalos@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Rajasi,

On 9/22/25 5:24 AM, rajasimandalos@gmail.com wrote:
> From: Rajasi Mandal <rajasimandal@microsoft.com>
> 
> Previously, specifying both multichannel and max_channels=1 as mount
> options would leave multichannel enabled, even though it is not
> meaningful when only one channel is allowed. This led to confusion and
> inconsistent behavior, as the client would advertise multichannel
> capability but never establish secondary channels.
> 
> Fix this by forcing multichannel to false whenever max_channels=1,
> ensuring the mount configuration is consistent and matches user intent.
> This prevents the client from advertising or attempting multichannel
> support when it is not possible.
> 
> Signed-off-by: Rajasi Mandal <rajasimandal@microsoft.com>
> ---
>  fs/smb/client/fs_context.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
> index 072383899e81..43552b44f613 100644
> --- a/fs/smb/client/fs_context.c
> +++ b/fs/smb/client/fs_context.c
> @@ -1820,6 +1820,13 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
>  		goto cifs_parse_mount_err;
>  	}
>  
> +	/*
> +	 * Multichannel is not meaningful if max_channels is 1.
> +	 * Force multichannel to false to ensure consistent configuration.
> +	 */
> +	if (ctx->multichannel && ctx->max_channels == 1)
> +		ctx->multichannel = false;
> +
>  	return 0;
>  
>   cifs_parse_mount_err:

Do we even need ->multichannel flag at all? Maybe we could replace
->multichannel for a function that checks for max_channels > 1?

-- 
Henrique
SUSE Labs

