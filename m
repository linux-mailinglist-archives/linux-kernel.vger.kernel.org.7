Return-Path: <linux-kernel+bounces-893331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B31C4718B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61FE43A4A65
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F8A3126AC;
	Mon, 10 Nov 2025 14:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hxjbBL4p";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z/pAgo7o"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023633112DD
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762783525; cv=none; b=YFxpcftJGQAnVluEWGAp9YNyjry3zlMRE9mQwbXjhIQqVudWAqB0zPIrOjxy8FTSqoD+wSEdrRFVekJOW2PwCDpj5nBcVjeOQejwIjr8MG3Pj7p/BmJ8i+ozBwC8zkoyn4hb/mRDgrmpBshxbWTHbF0XwlECS4maVXrVYPgSdKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762783525; c=relaxed/simple;
	bh=1HKyg/y+K486ffMg3gd1pV9isJ6E8/RZqZT9tEAPbcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dqOsUlFlxgB3prxaxBm3kwkenitt16+v0/wDqAeFXWLTIzLzum0PVTVqIJAqgyYoo0yV8o0hp+5N4MGe8Bl+fsN9TfXQsMSCgLlrBZrgf8Ev058sJm+mQm/tRo4DmPVkEiqHSPKBxV5vrzlBc6as1xfr8yvn9WNdIYuezv7Rjz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hxjbBL4p; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z/pAgo7o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762783523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2JtzOcemGD0TJWG3B+UVtVletzjnKYruntoqmhaEm2o=;
	b=hxjbBL4pJJ3uf3ouvvdm6x3oh9yTCcOLAINNVNr+cvL9xKrgVj8wM+fX5xgsQGRXrXx+dd
	RGFb4CH8vRvDX/OKItFuL+39dK587128LqpyCy61hRWM079FtApY9hMPXljCcGZDs8qQHq
	9Ypa8ij1CpcqGB2uaJD5TFbbQ+RwJpM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-DVK6FLN7M_G0y3_9DkctgQ-1; Mon, 10 Nov 2025 09:05:21 -0500
X-MC-Unique: DVK6FLN7M_G0y3_9DkctgQ-1
X-Mimecast-MFC-AGG-ID: DVK6FLN7M_G0y3_9DkctgQ_1762783519
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4773e108333so18653625e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762783519; x=1763388319; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2JtzOcemGD0TJWG3B+UVtVletzjnKYruntoqmhaEm2o=;
        b=Z/pAgo7ouk6libY8pSq4bJc3ZRO5GDaJ62rvIbJaeq6mx/HV5HVTn8Ui5AmilPRfV7
         1BDEjaoxiQ9Te2q0ZGBV3M8rIx6K/Zw36MIBzPVCsbtGk728seke/3SUfSmTvFq05pSp
         oTnm9NR6DJ0cawXO/n6rG0MJk/6zG5+hIjg9LIm3Fsu6k+2cPSsch3st0Vg4Uz4UXJ1i
         6eFuxG7L0KYwspjnzfQTtys8Kbj6vTSl253PEtSX+kfpm3kKLYWxembpSfhez1WtIbJq
         jyfT3PN2Tjq5yGYcqKIIRxK851xe32QkvmM/cv57ORgTv5qtcc+V9AMGKpXnYtPKnIcn
         Wzrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762783519; x=1763388319;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2JtzOcemGD0TJWG3B+UVtVletzjnKYruntoqmhaEm2o=;
        b=jB8szA8+caqsHmOJvzRtER8c2OXoaVdbAm+CijWvqUqDbSojr1WSoIHrgAmG4IXRLR
         zh5+kPJF0KbNwAWCQozfmdYOy11WyvzsmPDDMSucu/alrI5jQIMLEZOCFCKUG22vGJ3U
         Cs0yOAdbsZlxSnQXv+SLSkzp/zDhNnHVzdBzGyd8LVIQBvbm5b2xUzcnpPabdRdDdM+E
         LFBrrILLhO4ntgSQdBha5hD0U9+fJYD64OEYaBTpHKnUhsj0xtLdyw3ZGqON1EJfkYXO
         Dh1tvQFzkwd6NhRe271edEYfnMSw9SKrgNQg3vFJJ7ClvKPauOLAgkmWYXKwkpeKXEI/
         JdQg==
X-Forwarded-Encrypted: i=1; AJvYcCXRZXaf1qzSNerB9xKt86VWAmvwqeGJaiGp6VcgBpuBSOEMzfYavVgTj68j9qeAnBglkQHtfKteGajBQfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyECjKmVWFGxvVuCv/GX28iFup0CUNdk9Ie0SzO5i0juozlre0n
	+VHCs2C8mOkBckmsJn3Lur9H0a/TW3SE2DdzCutPftJEeGDW4WEamW8ZAG9Etsk18dgXGKr8iNE
	5bvtm7PtmWb2a2cQDYvRur7C4HI07JjX0qkf17pzszADOPRh5KREP3HZNTmWRbQs8hw==
X-Gm-Gg: ASbGncsd0uTnfe61maH70k5LYble8diHrveGlc4ue/QeMZ3tT4mTDCPHpdpxyZjo7mu
	hE4d0RIBlHecU1lelDg/pnhOD/TwaceqCgABC4MRNK2/5Qn6MnYEUX5pAGjhjDHJ+taK+gQMIJv
	cfJTfJUQs3pOC+/4QzKp8JGrErN8Gr+vKXSwnzKRnzdl5oOlUHqhR6qNOEWcwS0lIQT7qZiS2ws
	JKEUC8Kb1lVXOjFo6fWwOLU5cZoJtWnzz/oSpdSjjCCecgibyJHoRKgEsE6c3RiT062noPYXg7O
	HsIN/THtlMl+7liSG/ikDCLSV3ucUL5jnMySNFHcFaIKzyt3QyqjOOAV51iUnQFc+z36FL+nugu
	Iq0RORfPTUlFw9HTujHCpwI8acwK62W04uA5xIIo=
X-Received: by 2002:a05:600c:1381:b0:45c:4470:271c with SMTP id 5b1f17b1804b1-4777325ab51mr76639785e9.18.1762783518787;
        Mon, 10 Nov 2025 06:05:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMjn+CCsjUlMm3xzTYdWVzE/NNKmYzLaSSOr86S2ftoTTogHmleVtc8GMhLnQCQcUAUSFpsw==
X-Received: by 2002:a05:600c:1381:b0:45c:4470:271c with SMTP id 5b1f17b1804b1-4777325ab51mr76639435e9.18.1762783518357;
        Mon, 10 Nov 2025 06:05:18 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62? ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47763e4f89fsm116138455e9.3.2025.11.10.06.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 06:05:17 -0800 (PST)
Message-ID: <0749be61-2f3d-440e-887a-c841007e5b50@redhat.com>
Date: Mon, 10 Nov 2025 15:05:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/client: log: Implement struct
 drm_client_funcs.restore
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
 simona@ffwll.ch, airlied@gmail.com, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, gregkh@linuxfoundation.org,
 jirislaby@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <20251107142612.467817-1-tzimmermann@suse.de>
 <20251107142612.467817-4-tzimmermann@suse.de>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20251107142612.467817-4-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/11/2025 15:19, Thomas Zimmermann wrote:
> Restore the log client's output when the DRM core invokes the restore
> callback. Follow the existing behavior of fbdev emulation wrt. the
> value of the force parameter.
> 
> If force is false, acquire the DRM master lock and reprogram the
> display. This is the case when the user-space compositor exists and
> the DRM core transfers the display back to the in-kernel client. This
> also enables log output during reboots.
> 
> If force is true, reprogram without considering the master lock. This
> overrides the current compositor and prints the log to the screen. In
> case of system malfunction, users can enter SysRq+v to invoke the
> emergency error reporting. See Documentation/admin-guide/sysrq.rst for
> more information.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/clients/drm_log.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/gpu/drm/clients/drm_log.c b/drivers/gpu/drm/clients/drm_log.c
> index 19e55aa0ed74..4d3005273b27 100644
> --- a/drivers/gpu/drm/clients/drm_log.c
> +++ b/drivers/gpu/drm/clients/drm_log.c
> @@ -315,6 +315,18 @@ static void drm_log_client_unregister(struct drm_client_dev *client)
>   	drm_client_release(client);
>   }
>   
> +static int drm_log_client_restore(struct drm_client_dev *client, bool force)
> +{
> +	int ret;
> +
> +	if (force)
> +		ret = drm_client_modeset_commit_locked(client);
> +	else
> +		ret = drm_client_modeset_commit(client);
> +
> +	return ret;
> +}
> +
>   static int drm_log_client_hotplug(struct drm_client_dev *client)
>   {
>   	struct drm_log *dlog = client_to_drm_log(client);
> @@ -348,6 +360,7 @@ static const struct drm_client_funcs drm_log_client_funcs = {
>   	.owner		= THIS_MODULE,
>   	.free		= drm_log_client_free,
>   	.unregister	= drm_log_client_unregister,
> +	.restore	= drm_log_client_restore,
>   	.hotplug	= drm_log_client_hotplug,
>   	.suspend	= drm_log_client_suspend,
>   	.resume		= drm_log_client_resume,


