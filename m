Return-Path: <linux-kernel+bounces-860002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B9EBEF1EB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 04:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9EC53AE7F0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 02:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E150C28314C;
	Mon, 20 Oct 2025 02:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ei1JXGz5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC20277C8C
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760928391; cv=none; b=S2KXQGU994rvyOxN7avyc82jX0M68kafQpR65vXV7/7jRza+t8/6QFf6yfccoRCsccgidfjfrMVEIn2RqZixL9jg0sbgto2DTfw9DOqNXK3IfM8CDKGdTMSJGLBSCDmaD73SJ1DI9F1X8s1md4PMs6ykOAt4DE4yPJgophGGU6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760928391; c=relaxed/simple;
	bh=KeVmy3OZcS609+7WIo2P96H2MFBkXzSKZv7r6Ur8OiY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fQzG0oanP2y1NdXXRCPy03NKMa4mBA2QVTpsfn3x2JLK37Ex5vXT+zlOmAjQMjuO6Lq9jvcqeEludy4sCTRSW7a2pFlRZkGB/eoScugnCps122rJd825nNh73L7sWjgl89dkV4lDlZVFAgvdQRc7LeEael/u/Jilvs8aoXN3TpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ei1JXGz5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760928388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vaYR7lJLOKOF47UML281fsBFUMBWREHpcCTq8GpMwLg=;
	b=Ei1JXGz5tQZIJ9/yo7/Z0HwT4tIP3fivSdqhgqAHxTrUYhJoLOLrh91Q/ECEn2/Zzsbgwi
	3lvlKh/qybuwTdC23uw0S7lStRP6rhXhV+xgKT8gXZoRrenpJlIjbYtNTmS8LQ8D9VgBzJ
	C/YC90pKk1WKdNxm8jQSrEnHB8C3tFo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-ctE5OgICNO-PSrmucN6U1g-1; Sun, 19 Oct 2025 22:46:25 -0400
X-MC-Unique: ctE5OgICNO-PSrmucN6U1g-1
X-Mimecast-MFC-AGG-ID: ctE5OgICNO-PSrmucN6U1g_1760928385
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-86df46fa013so1770489685a.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 19:46:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760928385; x=1761533185;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vaYR7lJLOKOF47UML281fsBFUMBWREHpcCTq8GpMwLg=;
        b=hjXR2z9UuY8v7x5HkfEHozXpXnVIVxtgxjEAdeaC37oKcj8GigSuJSwhvIIOEYhHCC
         aLOWPvqGWIs//Oc8S3ofd2afLl6AFgwjLdvUa+g0rgwD4G0EqDRQM5B2Y9as9vksmZoR
         p4OIvu48tnm/Ttxx5sqtZylUW224oqXFfxLX5WiN9v7MdBBt843zNE5fsMXpvgWb+Vn4
         qkXkCW692IUgWCqmWFuZfijJsC7XWKVuVHAG2lnjLv4isj0etH0p7kzIJ1pv563ty19m
         bvv4kS3j1aerf+3HegmfUxtUJ5Wjm5OXC5+TlU2wpFP9AaW1fD8W6cQ3nZqdo9gSLTPu
         zLDg==
X-Forwarded-Encrypted: i=1; AJvYcCVCrmcvwiqDobRWK/k6eWcndwX7BEMEHz7LDCMr13WSBVZZtH7g4vpRbanPc/rV/RtUfioTUxfeJX8YPDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkjMwrEUtc8MdLNSCkdVOYnQ01NbOVy68xLqH6qmJTCyageHTT
	LG6Eh0jZF4qfVGbg/JxCga+OLG8dqqL21F4AFxcSJWkgj9Z0P2B/31gCQZstI7/14htwWVLYjah
	ylk5fv+iKhzv0EGq31Mjq6KCwj/1PYmi+x/AIumV3BStWWHyvaXikYfTZ1cYQoyvcZA==
X-Gm-Gg: ASbGncswDH7N+uvanpV9hO49uhmK/9cz1TAiHIk093g727v8Fz6eTx2Iq6ObDxLMB7V
	wGqAU3quZx4uaszShUoAgF54mOXpuRXwmmaWru0UXOXJ1QkdnJgotYmo8PX/3sxBsYf8o2Rhna+
	sxAksMQFHAnvTLgW43CllwKPNTDjZw8sEu8CEzT/poQy9O6ajHxR84V/BOMfQA6ZWPBDkYEmEC3
	LTg23R3In38T4+QMsAXt/6QQHLHuyzOfda63RDXKcWHxjvOxnS4QAqDhuyvxTREmt99W/nMZz7O
	Wuq7DZp1MCbxi5TIxiY3FhNqiAf5QOWCUtV0P80XE3chMw+1eE3xmcOfszgq4GzZWQ3GxkrDyTT
	NtcOpJ1Hx6p62+1Wx0QWcvcUEqDatG+FKiL2JbR81Wn8fjQ==
X-Received: by 2002:ac8:5841:0:b0:4e8:a389:dde with SMTP id d75a77b69052e-4e8a389107dmr133834851cf.69.1760928384883;
        Sun, 19 Oct 2025 19:46:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdpuhmuBtAZSe/RG5MVrWKv6sbxpPf9Ow6aau+pVSBCRG8T8Y/O64VRTkwscXL+aNK7uwHbA==
X-Received: by 2002:ac8:5841:0:b0:4e8:a389:dde with SMTP id d75a77b69052e-4e8a389107dmr133834661cf.69.1760928384484;
        Sun, 19 Oct 2025 19:46:24 -0700 (PDT)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8aaf34386sm46065881cf.4.2025.10.19.19.46.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Oct 2025 19:46:23 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <d719fdbc-515e-4386-b4d8-1d5fc0f7edf1@redhat.com>
Date: Sun, 19 Oct 2025 22:46:22 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 07/16] cpuset: introduce
 local_partition_disable()
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250928071306.3797436-1-chenridong@huaweicloud.com>
 <20250928071306.3797436-8-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250928071306.3797436-8-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/28/25 3:12 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> The partition_disable() function introduced earlier can be extended to
> handle local partition disablement.
>
> First, partition_disable() was enhanced to support local partitions by
> properly managing the parent's nr_subparts counter and integrating
> notification operations.
>
> Then, local_partition_disable() is introduced, which extracts the local
> partition disable logic from update_parent_effective_cpumask(). It calls
> partition_disable() to complete the disablement process.
>
> This refactoring establishes a clear separation between local and remote
> partition operations while promoting code reuse through the shared
> partition_disable() infrastructure.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 60 ++++++++++++++++++++++++++++++------------
>   1 file changed, 43 insertions(+), 17 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 154992cdfe9a..87ba43e93540 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1576,13 +1576,20 @@ static void partition_disable(struct cpuset *cs, struct cpuset *parent,
>   				    int new_prs, enum prs_errcode prs_err)
>   {
>   	bool isolcpus_updated;
> +	int old_prs;
>   
>   	lockdep_assert_held(&cpuset_mutex);
>   	WARN_ON_ONCE(new_prs > 0);
>   	WARN_ON_ONCE(!cpuset_v2());
>   
> +	old_prs = cs->partition_root_state;
>   	spin_lock_irq(&callback_lock);
>   	list_del_init(&cs->remote_sibling);
> +	if (parent && is_partition_valid(parent) &&
> +	    is_partition_valid(cs)) {
> +		parent->nr_subparts -= 1;
> +		WARN_ON_ONCE(parent->nr_subparts < 0);
> +	}
>   	/* disable a partition should only delete exclusive cpus */
>   	isolcpus_updated = partition_xcpus_del(cs->partition_root_state,
>   						parent, cs->effective_xcpus);
> @@ -1592,6 +1599,9 @@ static void partition_disable(struct cpuset *cs, struct cpuset *parent,
>   	spin_unlock_irq(&callback_lock);
>   	update_unbound_workqueue_cpumask(isolcpus_updated);
>   	cpuset_force_rebuild();
> +	/* Clear exclusive flag; no errors are expected */
> +	update_partition_exclusive_flag(cs, new_prs);
> +	notify_partition_change(cs, old_prs);
>   }
>   

Similarly, change to partition_disable() should be done previously in 
patch 4 ("cpuset: factor out partition_disable() function") for 
completeness.

Cheers,
Longman



