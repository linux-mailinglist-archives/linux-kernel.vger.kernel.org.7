Return-Path: <linux-kernel+bounces-894636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A87FC4B770
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 05:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C5D41346FD6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 04:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37742773F9;
	Tue, 11 Nov 2025 04:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T474UD14";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="amQ7CydK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C67F274FEB
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 04:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762835843; cv=none; b=BChimdTKFDXeVMKp2Gdt9MWnXiIJ3mACSAjlHFLIpyf6FRnNe9xNhfoQ1hg1ZJ4J1DE92MZl6b+cQ0heHQD0CWnsEBZ8ScMRB6E4C496OfvQYp1lzaDjpXMGdHOc8JGem0irVq5OiRNiXXWqcAxcQdHGE1qSzjn5vFW9e6FCgZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762835843; c=relaxed/simple;
	bh=4Ij8Kpzw53FTvwgkxB14QlL5wIlcFPKB+tSaSgu160E=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qgoQNLRNtgKbqXdiaQtnWDoPYUamtWi+4PpIa0VgMq91roLzOtE2YvLCKV2EKrLukAmCrHCv56jKWnUflFYMZX+jHW7IHpBHAUOjRNl3xOQkjXR6b1oT/XV/n1Fk3JDkv0aNWTv/wyWBGjgKFR33OXJ5IR2u8Nib3Y+hifmDzwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T474UD14; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=amQ7CydK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762835840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C+JproX8T015qBYAZSJqqnExPu+aACtaRVUSOGM3CqU=;
	b=T474UD14Xn1rGy2GwzWmw1HfdFPlXABoXNiIgq0YaVvK+nbPwlKJmWQn8o1831erFV4VdM
	F8/Qsr7II8xw7OFJ7L8wo0WxXvXaQUqmtQoGFsqQi4c+W1/amxy4ar3DplKhiSmBjBxMW6
	rUNx4JOOG02o8Ta5iqd2WBb8F5/YWkU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-lilP-b9bNQWBLPFQNV4Kjw-1; Mon, 10 Nov 2025 23:37:18 -0500
X-MC-Unique: lilP-b9bNQWBLPFQNV4Kjw-1
X-Mimecast-MFC-AGG-ID: lilP-b9bNQWBLPFQNV4Kjw_1762835838
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4edae6297a2so32534131cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 20:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762835838; x=1763440638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C+JproX8T015qBYAZSJqqnExPu+aACtaRVUSOGM3CqU=;
        b=amQ7CydK65mTQIwvr6CjGgfX0KE5jH8dHTwAaMQM9aFWGBMKwy/zcSvR4kjmNm6xcF
         Xs9p9b3PiOhJmNLp1ofZ1H2/CeQdl1Wl40O8+D3iZ+O2IpGOPWjAD9sSJYy3xzi71A5o
         X0bEAbOjRFGHUX97DZItnPHK26Fc8xjXxINXSfKoUWf57g9xBdhQv25fmAEW41VK5+yA
         mn+mEDMkbwoADxjZd/bn3Z7KAvrAcNsmHpEPchhtlBR5MiGUhL7uh85HWl5XV2fEnu/J
         zN/t1WZpGuSJ4QRO5R08vb0SKbKOG2DQ9DWQQ2TZFhuvDKRSm6eMu/6Dv+NPSHDv0B0A
         KLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762835838; x=1763440638;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+JproX8T015qBYAZSJqqnExPu+aACtaRVUSOGM3CqU=;
        b=GtO95vgZTRVqYiA3YouM+1q82DlLLJHaLhkzGjQPgvsdp1dLnmq5mS4v0p6i3K1ioo
         HdI30UmEbWhALnTelZLb/GZa7SluddtzX3vqv8cMqvuSyH5icGfssh4wEbZUB8enzoYF
         X7cEnbAHygMUHTkVKiohG5+WKe9IuNXBh+WWGnti8kcoQoMKoT4jjMuTF0Ro51qHYDK1
         10ZOPYOWzRZ2utVL+fCYGXePrasYd6a+gEMl+E2w6xyRG4u41PcUIsmPIfkFRN//ZDgG
         EzMUyMy5NtIesiZmQWVncq8fFkMlskw1lAihn4x4q5tkdyg+hw7XcEL56xmgTrdsGCZG
         NRfA==
X-Forwarded-Encrypted: i=1; AJvYcCVnlOWFsG0Da4aZ11fE2S2Zjzdr/t+EUS9P4sjfppbx8V7RLA7KLiphnkGR2esARX/LpXlMXWCR3nSzqNM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9umkH0Y+v+Ixgp6t8+FyKETfUeDS2sQ1bq7zPvgTRSBDADl9G
	c0Z5HA+BguBOKZo/dN52EIVGRFK2UI7hu+G1EBQ6OuA6VQIwiITWnxIQsn0OAVzbwESJt3QQNMJ
	xIHAG+fFvpHHI09f7KTP6LVbtnhnurj5t71HPNZE6MWyXjgeh5f5t5qt5ZQdhKyxfiQ==
X-Gm-Gg: ASbGncsXe3VXm8Pm4w2H+wRP5KnTCwIWP0IFMw1/XWbNP1VRcTe3WphaosoTw5zyo4n
	32VnnJYHjWcPEhiAOfpzauFi+4e68SkTSAMFEZeEuwGGyAkjLL1kZheJJgQCcQ7AIPaLh7HeNEG
	6XpzYOsdQcuMt6PXYNQYDw1U2ey8Hpm6RQW1iYA12l3QNJOpxcfokefRTTZMyaZqHPIb/E+kVy5
	WzV/p7Yset9eM80RQd3MjQF4WJWWa9/6SZNef4Lp3qEfraC69CBDAmoP9M9sirL7gKqyo+GQRYH
	MXp6fuhL02tkof6Y6324vvqbmXwQZScfRAIXmwyUFbaoGQAiXutVs3Ftc1692Bht58H4bFjBxoP
	2m+fmJQVYayo73ceuyvFOsSYdazq8QR1GXMu6UYgYH93gEg==
X-Received: by 2002:ac8:59c3:0:b0:4ed:8264:919e with SMTP id d75a77b69052e-4eda4f99536mr125294571cf.44.1762835838436;
        Mon, 10 Nov 2025 20:37:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKIbjVumbhQ6UlTo32QTUXlZ/B0AGMGTqMqjVXCshP8q/ARwDZpWgxkIo7Vshy4zJl+b4h3A==
X-Received: by 2002:ac8:59c3:0:b0:4ed:8264:919e with SMTP id d75a77b69052e-4eda4f99536mr125294461cf.44.1762835838167;
        Mon, 10 Nov 2025 20:37:18 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4edb5a108a1sm41301131cf.24.2025.11.10.20.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 20:37:17 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <e5a25c3d-cd81-48bc-bae0-b1b28778272b@redhat.com>
Date: Mon, 10 Nov 2025 23:37:16 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 3/3] cpuset: remove need_rebuild_sched_domains
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251110015228.897736-1-chenridong@huaweicloud.com>
 <20251110015228.897736-4-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20251110015228.897736-4-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/9/25 8:52 PM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> Previously, update_cpumasks_hier() used need_rebuild_sched_domains to
> decide whether to invoke rebuild_sched_domains_locked(). Now that
> rebuild_sched_domains_locked() only sets force_rebuild, the flag is
> redundant. Hence, remove it.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index c357bfb69fe2..22084d8bdc3f 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2184,7 +2184,6 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
>   {
>   	struct cpuset *cp;
>   	struct cgroup_subsys_state *pos_css;
> -	bool need_rebuild_sched_domains = false;
>   	int old_prs, new_prs;
>   
>   	rcu_read_lock();
> @@ -2348,15 +2347,12 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
>   		if (!cpumask_empty(cp->cpus_allowed) &&
>   		    is_sched_load_balance(cp) &&
>   		   (!cpuset_v2() || is_partition_valid(cp)))
> -			need_rebuild_sched_domains = true;
> +			cpuset_force_rebuild();
>   
>   		rcu_read_lock();
>   		css_put(&cp->css);
>   	}
>   	rcu_read_unlock();
> -
> -	if (need_rebuild_sched_domains)
> -		cpuset_force_rebuild();
>   }
>   
>   /**
Reviewed-by: Waiman Long <longman@redhat.com>


