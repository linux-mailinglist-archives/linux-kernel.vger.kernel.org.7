Return-Path: <linux-kernel+bounces-765073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2A2B22ADE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E1DA7AD968
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E882EA743;
	Tue, 12 Aug 2025 14:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ghBjadcu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837CC280CC1
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 14:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755009852; cv=none; b=SsD4u6p5mJRccs/uUpyagFN/iVU+vLQ3+f6RjEqbb+JlM8QN+SMP8ZikYSnw/2n7m5yECqUvvRzh7+LDZJ/DkEgth6F7iIQkpF5LIwALxXN7o4jT2/hVNh2oBgjI74ivenzEz5QWV0YBW9MbgbZVHO2aG3X9ZQiM6qxnKxwTXT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755009852; c=relaxed/simple;
	bh=XVWCAtqiIuVkfrO6+ebbHiZyyWqO2a7hGPigNRefIZk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MBE+cHVRVyhYa8jS5QC2zQacpWHIHknjLmoazNgx5R/X45G8FZSVgV+irS8/zPl2J70FZkz2uAjEVPxm/+1/d+7b7XfKDjrJkTizLLwXs38ie1cYsLCp6Iaw0xmL8TrUBAeS97Kn/D05LH1YK4RNs6RFI0+mN/HvitksehPFNMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ghBjadcu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755009849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F8SRqg++OlbXFY+j9lois5UJ3vRtb2rmOlD6n8xgG7Q=;
	b=ghBjadcuf51d3xFrxKQv2fWe0ATAyk6BkvjEB9GpatDd8mgyLHtCsyUp/2AONVdMrs/wIw
	QET/8UEgS3LNIYr0XSEByyyTbHjKjrxirzcJz8hhstZLn1NYCTd7SSUvIyxVdYxWFTk9sd
	Tvc5VcM7hRZ1gh2TMj7V5onVzeG/jb4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-BvOJyLsOOzibTnbxCMz48A-1; Tue, 12 Aug 2025 10:44:07 -0400
X-MC-Unique: BvOJyLsOOzibTnbxCMz48A-1
X-Mimecast-MFC-AGG-ID: BvOJyLsOOzibTnbxCMz48A_1755009847
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b08431923dso136094571cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 07:44:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755009847; x=1755614647;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F8SRqg++OlbXFY+j9lois5UJ3vRtb2rmOlD6n8xgG7Q=;
        b=qGGPA61+IkVXFK/Ew3mydE4lq63c9gCllEHeCSXv3/rQBiEN9elaK08GQDOqerR7no
         j/Y53QR5rMzY+sodkP/wAbHHdeyabux0t6aOgBuOyC4R+pL8QXfXFZhn7tySZc6UfrCY
         hG1eidbm1kulGoO1A/mUI73hiilsdjp7zNxabu7PzgBCUfTmlrl67CzoxzQQNe7hOjpU
         W8ok/XMqjhOjyWnfPnzYlayfeeGIXy2KxAZn/5gbhqny9GLuj5IUOBAh4Tm0HzzwdiCl
         V0jaEpCIVsyhMBsMclzW6svWlfOP8gXUv1wan52nrUp//QU0VpWLL7e5J7jwomZDfou0
         hIJw==
X-Forwarded-Encrypted: i=1; AJvYcCVbIaBv7LQJICeWfrmuFdv5tL7nQeGPNiH0zQsngmWjgvLsPcjIJkd+Aym2kNQS7IC0w0zewkmNnDoiQaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP9dBxS9q/8MgDF/QLgovJfNF66pqSZmop/UPC5tAKtYg/ROD1
	sERcWtG2iSmZJFpkk4KSImzYxeZpq9FRKtjGDmBiIYluQQiFUp8Xnxfc/oG+USMNp6qmZOoF2WJ
	4NUVVIxaeZYEXP12IDTKjk4rXrlToufMPRGj5S4tkakYkjZE7OxO6EesrJNHJGF+csQ==
X-Gm-Gg: ASbGncubZgEiVw6SKYLU3vX+l8YaIEbT3Mzq8Dct7p3U4FrzAQyCGx3cTpP+XrSbMwt
	toXqhX6VlPL7eVfQ+XLc0SACFJRT5WXvCsqoc0QH06IIDe+hxLROPnA7t9bgSVHTZZUGpjnow0K
	9JqhKmoNsoa6rfJQGNJNvxF1sUDBc45bTdz+QQjys+/xESCn14FklNNo9yocE9eMypMqU+7lVIu
	iMjTfFa3C0X3n37ftI7IKI9MDe0x4KEBtH67JzoNZwWzU9/EnB4ehXCmcPJhC9nbHlGAv05zNIO
	AhDNXzZz1dGm2Ve9kPiMGvCzcavTu976YNGsnc5LlSOXQWyllCjlAm5YtNYcVHVPHLCrLpAqdxQ
	wjjOrm8Swuw==
X-Received: by 2002:a05:622a:590e:b0:4b0:7915:9765 with SMTP id d75a77b69052e-4b0eccd1726mr59918451cf.49.1755009846957;
        Tue, 12 Aug 2025 07:44:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKHg3U1+wE5LXpOAb41ZqegmqSeXii/jIiXvt61sEz9qRoASxs/xeyUF6IfNZS8YPumZQ+eQ==
X-Received: by 2002:a05:622a:590e:b0:4b0:7915:9765 with SMTP id d75a77b69052e-4b0eccd1726mr59917731cf.49.1755009846194;
        Tue, 12 Aug 2025 07:44:06 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b07611dc5asm114366661cf.42.2025.08.12.07.44.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 07:44:05 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <db5fdf29-43d9-4e38-a5a8-02cd711b892a@redhat.com>
Date: Tue, 12 Aug 2025 10:44:04 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 1/4] cpuset: remove redundant CS_ONLINE flag
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250808092515.764820-1-chenridong@huaweicloud.com>
 <20250808092515.764820-2-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250808092515.764820-2-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/8/25 5:25 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> The CS_ONLINE flag was introduced prior to the CSS_ONLINE flag in the
> cpuset subsystem. Currently, the flag setting sequence is as follows:
>
> 1. cpuset_css_online() sets CS_ONLINE
> 2. css->flags gets CSS_ONLINE set
> ...
> 3. cgroup->kill_css sets CSS_DYING
> 4. cpuset_css_offline() clears CS_ONLINE
> 5. css->flags clears CSS_ONLINE
>
> The is_cpuset_online() check currently occurs between steps 1 and 3.
> However, it would be equally safe to perform this check between steps 2
> and 3, as CSS_ONLINE provides the same synchronization guarantee as
> CS_ONLINE.
>
> Since CS_ONLINE is redundant with CSS_ONLINE and provides no additional
> synchronization benefits, we can safely remove it to simplify the code.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   include/linux/cgroup.h          | 5 +++++
>   kernel/cgroup/cpuset-internal.h | 3 +--
>   kernel/cgroup/cpuset.c          | 4 +---
>   3 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index b18fb5fcb38e..ae73dbb19165 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -354,6 +354,11 @@ static inline bool css_is_dying(struct cgroup_subsys_state *css)
>   	return css->flags & CSS_DYING;
>   }
>   
> +static inline bool css_is_online(struct cgroup_subsys_state *css)
> +{
> +	return css->flags & CSS_ONLINE;
> +}
> +
>   static inline bool css_is_self(struct cgroup_subsys_state *css)
>   {
>   	if (css == &css->cgroup->self) {
> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
> index 383963e28ac6..75b3aef39231 100644
> --- a/kernel/cgroup/cpuset-internal.h
> +++ b/kernel/cgroup/cpuset-internal.h
> @@ -38,7 +38,6 @@ enum prs_errcode {
>   
>   /* bits in struct cpuset flags field */
>   typedef enum {
> -	CS_ONLINE,
>   	CS_CPU_EXCLUSIVE,
>   	CS_MEM_EXCLUSIVE,
>   	CS_MEM_HARDWALL,
> @@ -202,7 +201,7 @@ static inline struct cpuset *parent_cs(struct cpuset *cs)
>   /* convenient tests for these bits */
>   static inline bool is_cpuset_online(struct cpuset *cs)
>   {
> -	return test_bit(CS_ONLINE, &cs->flags) && !css_is_dying(&cs->css);
> +	return css_is_online(&cs->css) && !css_is_dying(&cs->css);
>   }
>   
>   static inline int is_cpu_exclusive(const struct cpuset *cs)
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index f74d04429a29..cf7cd2255265 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -207,7 +207,7 @@ static inline void notify_partition_change(struct cpuset *cs, int old_prs)
>    * parallel, we may leave an offline CPU in cpu_allowed or some other masks.
>    */
>   static struct cpuset top_cpuset = {
> -	.flags = BIT(CS_ONLINE) | BIT(CS_CPU_EXCLUSIVE) |
> +	.flags = BIT(CS_CPU_EXCLUSIVE) |
>   		 BIT(CS_MEM_EXCLUSIVE) | BIT(CS_SCHED_LOAD_BALANCE),
>   	.partition_root_state = PRS_ROOT,
>   	.relax_domain_level = -1,

top_cpuset.css is not initialized like the one in the children. If you 
modify is_cpuset_online() to test the css.flags, you will probably need 
to set the CSS_ONLINE flag in top_cpuset.css.flags. I do doubt that we 
will apply the is_cpuset_online() test on top_cpuset. To be consistent, 
we should support that.

BTW, other statically allocated css'es in the cgroup root may have 
similar problem. If you make the css_is_online() helper available to all 
other controllers, you will have to document that limitation.

Cheers,
Longman


