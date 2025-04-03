Return-Path: <linux-kernel+bounces-586424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62922A79F85
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 11:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B477A7A4A98
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 09:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527C024886C;
	Thu,  3 Apr 2025 09:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iIkIWv31"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B422459FB
	for <linux-kernel@vger.kernel.org>; Thu,  3 Apr 2025 09:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743670887; cv=none; b=aNmcGUeZiqmiu/r7Eil6NJ2lmdR21DrX4zZ64B+RFPoUy/x4Sk75/EDRlQwGg7xYJ5jP/fozOZMfpL5ffvlLBWQMWt5VC+Jq8nk8+mc6ovBVldeMrqJSGUClj8ikHWTj00Nw7OthloPhqZG+jiG6XW7oLdPrk7OdK3/EdKI+Ink=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743670887; c=relaxed/simple;
	bh=XLaSHPIQi0GraUs3a8fEONalIfB03jXivf0FB3eDu9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgZ5s179n/g9+EJtqxEZO4t969CgwVwp/LVjXaAI37sij7kiyc/bkl2/5wFLhhL/AwZjMqBskBu33wvvEkw9q3FyjTiv4DeczLsoGyZ1HI2p3/4gfJ0AJir9EGPU6PZ9nLuUi6A6od+dr8+1ChMk7P6shxwepXpc62RESvz031I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iIkIWv31; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743670884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u0Fq6CW4btmWUZyI5fPPBqSbZkcj6UpkBIS/toPg3Vg=;
	b=iIkIWv319iIRTfGT/8FGM0VOgc4ltc+ZcTQxGqdch0sm4hxIuQ6pZI9MD7az/wfN/e4pHL
	2w0wsawa91AWreUMw4er72Z0JCriQN0+XEt/oYh7H7wlJS72bm9ZuyF0C9DMetzfzUrRbF
	gOSqPo59kA+gJ58epBgFqJreSBK4LFQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154--omCF2T0PKyhYBbAWYF8uA-1; Thu, 03 Apr 2025 05:01:23 -0400
X-MC-Unique: -omCF2T0PKyhYBbAWYF8uA-1
X-Mimecast-MFC-AGG-ID: -omCF2T0PKyhYBbAWYF8uA_1743670882
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39141ffa913so345465f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Apr 2025 02:01:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743670882; x=1744275682;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u0Fq6CW4btmWUZyI5fPPBqSbZkcj6UpkBIS/toPg3Vg=;
        b=RkMD3n6e79MkV3SBP5vmsuycNjgkEcP87zQldNKfYjJfkOzz/2zpx93+gjhuFEV7Bd
         /3MJzsXJeHMvPPF0fNtQEx5PgFq2Ozw2gPSpGnSO3HXzrODqeCXbfkkpJaBKpaRhfz4t
         JDCL6hetdGq81XgAncLpxpHdnfLZgX2UxjNtq5a2FAn283TZ0de150VD9J1v70zYr/jf
         2oH15Q84vuJJB+2vqzPkCqvq2BFW7IWR1yDpaeICeKiQ6AxbavKDdHxf+IrqyS78RLf1
         CJ+5wMjs6GfS1fOPgIuXAONPpX7KrVgsNZIpJLYxuZVr920n2M4JKrJPBKTsXWI5YYom
         48Jg==
X-Forwarded-Encrypted: i=1; AJvYcCWTOEN3RDfzmgI6s94iykHFoXYZKi4aEyS7JxFHNBg1I+qKc3GINpx1UcbNiYx4Y/E0lWZefJZo+Zm83eo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhUjNYmm+xB9QD9FFV438ndQOvjptsuBE965e9SVBhERTDDg7N
	cWqbHtveGZpx4DHQpzmS5OAUP8pwEG/tnQ47W/PjMzUo+116UMojQ7I9DzSaQggi/TgnFV1we31
	OHGS5hsRAyZN4ucLX3Kb83QwC/3MZdPfBha6rBaT11w/oVZktg+Rjy89gZPlUpA==
X-Gm-Gg: ASbGnct36UomMGUF3cRy1dca3OJzROVx0jmsscmZyzD0mCX+3YHoHppqZ/mH+R5pJHA
	CXma+9MKzGLS7jRKjU1Ts0XmZCjIlYFHBThMiDn0n2qlFWuTZOkUGbGO0EA+dpj4czOVCpaUhgZ
	DEICwDeeVSe3CxSLAruhJ66eiaJN/cfE936ziBVMO+4P53sozHS6XlMBGrZfoWoF9GCyUIxrYpW
	KPVs0Is1at6FSKphFipQ7rfNhNU2we+q42bFiSRdYmBgfkXkyPc42FqgqconlqJ5NjjlLwwkr2Q
	BbJnLkJ5vqnnaa9cgJiM63hclaU/dDSl6pd8LghR99jvNirO5sQZ9ybtDUE=
X-Received: by 2002:a5d:64c6:0:b0:38f:39e5:6b5d with SMTP id ffacd0b85a97d-39c12117d3emr17332783f8f.44.1743670882229;
        Thu, 03 Apr 2025 02:01:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpovJ5UpDSlHVdv51+oenyd/eFQn5aR6V3UwBSXn54lErw6QgoiQzLXfuZblYn8PU/hctiug==
X-Received: by 2002:a5d:64c6:0:b0:38f:39e5:6b5d with SMTP id ffacd0b85a97d-39c12117d3emr17332729f8f.44.1743670881685;
        Thu, 03 Apr 2025 02:01:21 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-59.retail.telecomitalia.it. [87.11.6.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30226da7sm1220816f8f.98.2025.04.03.02.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 02:01:21 -0700 (PDT)
Date: Thu, 3 Apr 2025 11:01:16 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, "David S. Miller" <davem@davemloft.net>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 0/3] vsock: add namespace support to vhost-vsock
Message-ID: <npjlppzeanfwibynwzyuu65gp7uv2o2e3b6bdc6f3kwv42xn6a@sycnrm4yk7ea>
References: <20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com>
 <r6a6ihjw3etlb5chqsb65u7uhcav6q6pjxu65iqpp76423w2wd@kmctvoaywmbu>
 <Z-w47H3qUXZe4seQ@redhat.com>
 <Z+yDCKt7GpubbTKJ@devvm6277.cco0.facebook.com>
 <CAGxU2F7=64HHaAD+mYKYLqQD8rHg1CiF1YMDUULgSFw0WSY-Aw@mail.gmail.com>
 <Z-0BoF4vkC2IS1W4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z-0BoF4vkC2IS1W4@redhat.com>

On Wed, Apr 02, 2025 at 10:21:36AM +0100, Daniel P. Berrang� wrote:
>On Wed, Apr 02, 2025 at 10:13:43AM +0200, Stefano Garzarella wrote:
>> On Wed, 2 Apr 2025 at 02:21, Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
>> >
>> > I do like Stefano's suggestion to add a sysctl for a "strict" mode,
>> > Since it offers the best of both worlds, and still tends conservative in
>> > protecting existing applications... but I agree, the non-strict mode
>> > vsock would be unique WRT the usual concept of namespaces.
>>
>> Maybe we could do the opposite, enable strict mode by default (I think
>> it was similar to what I had tried to do with the kernel module in v1, I
>> was young I know xD)
>> And provide a way to disable it for those use cases where the user wants
>> backward compatibility, while paying the cost of less isolation.
>
>I think backwards compatible has to be the default behaviour, otherwise
>the change has too high risk of breaking existing deployments that are
>already using netns and relying on VSOCK being global. Breakage has to
>be opt in.
>
>> I was thinking two options (not sure if the second one can be done):
>>
>>   1. provide a global sysfs/sysctl that disables strict mode, but this
>>   then applies to all namespaces
>>
>>   2. provide something that allows disabling strict mode by namespace.
>>   Maybe when it is created there are options, or something that can be
>>   set later.
>>
>> 2 would be ideal, but that might be too much, so 1 might be enough. In
>> any case, 2 could also be a next step.
>>
>> WDYT?
>
>It occured to me that the problem we face with the CID space usage is
>somewhat similar to the UID/GID space usage for user namespaces.
>
>In the latter case, userns has exposed /proc/$PID/uid_map & gid_map, to
>allow IDs in the namespace to be arbitrarily mapped onto IDs in the host.
>
>At the risk of being overkill, is it worth trying a similar kind of
>approach for the vsock CID space ?
>
>A simple variant would be a /proc/net/vsock_cid_outside specifying a set
>of CIDs which are exclusively referencing /dev/vhost-vsock associations
>created outside the namespace. Anything not listed would be exclusively
>referencing associations created inside the namespace.

I like the idea and I think it is also easily usable in a nested 
environment, where for example in L1 we can decide whether or not a 
namespace can access the L0 host (CID=2), by adding 2 to 
/proc/net/vsock_cid_outside

>
>A more complex variant would be to allow a full remapping of CIDs as is
>done with userns, via a /proc/net/vsock_cid_map, which the same three
>parameters, so that CID=15 association outside the namespace could be
>remapped to CID=9015 inside the namespace, allow the inside namespace
>to define its out association for CID=15 without clashing.
>
>IOW, mapped CIDs would be exclusively referencing /dev/vhost-vsock
>associations created outside namespace, while unmapped CIDs would be
>exclusively referencing /dev/vhost-vsock associations inside the
>namespace.

This is maybe a little overkill, but I don't object to it!
It could also be a next step. But if it's easy to implement, we can go 
straight with it.

>
>A likely benefit of relying on a kernel defined mapping/partition of
>the CID space is that apps like QEMU don't need changing, as there's
>no need to invent a new /dev/vhost-vsock-netns device node.

Yeah, I see that!
However, should this be paired with a sysctl/sysfs to do opt-in?

Or can we do something to figure out if the user didn't write these 
files, then behave as before (but maybe we need to reverse the logic, I 
don't know if that makes sense).

>
>Both approaches give the desirable security protection whereby the
>inside namespace can be prevented from accessing certain CIDs that
>were associated outside the namespace.
>
>Some rule would need to be defined for updating the /proc/net/vsock_cid_map
>file as it is the security control mechanism. If it is write-once then
>if the container mgmt app initializes it, nothing later could change
>it.
>
>A key question is do we need the "first come, first served" behaviour
>for CIDs where a CID can be arbitrarily used by outside or inside namespace
>according to whatever tries to associate a CID first ?
>
>IMHO those semantics lead to unpredictable behaviour for apps because
>what happens depends on ordering of app launches inside & outside the
>namespace, but they do sort of allow for VSOCK namespace behaviour to
>be 'zero conf' out of the box.

Yes, I agree that we should avoid it if possible.

>
>A mapping that strictly partitions CIDs to either outside or inside
>namespace usage, but never both, gives well defined behaviour, at the
>cost of needing to setup an initial mapping/partition.

Thanks for your points!
Stefano


