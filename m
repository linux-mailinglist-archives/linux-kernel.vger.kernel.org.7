Return-Path: <linux-kernel+bounces-725227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9EFAFFC2E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 824395A69B7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E81E28C5D9;
	Thu, 10 Jul 2025 08:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2TM3yYj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DB928C5AF
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752136013; cv=none; b=Fovl0tXC3fmalty4YZrnOnE0+zupt/tC8mbrJpFjU4ncKwW7qJ8mXmjIMSE6u0bjE63Q7gD9lyhHYBUzb3DkQPyUrm3at0aNfTfONvz/Pb4h1Rf7hwSSg4cpP32LnS1jIKqCYBZZNlwtk72vz/W9OmBOY5ueEu2kwfrigUqsAV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752136013; c=relaxed/simple;
	bh=U//+v5a0o9qHscjeOG2Q3M9nP3v83t9bSkJ2x+NQAvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BsMRZeTGGf7ojp7PeN6iLo5MOGMzb6wDNM+48fRBhnhVfed+A2KeUMWq1NSMRgGNyXbPgDNj0h/39LURhDa9nkcLz0PFfp+B5kKfmzJt9aIugrudWkpUAvpdiH4Wkj5Pzq2uIcEysaz64KvQFSa1VbSwDfZYQtZg4yMUcmVzjzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a2TM3yYj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752136011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sza+IKOP5j/hxMGakskkrB4XI5GsufRQhspoUE9PIl4=;
	b=a2TM3yYjxobPkAbXkPyQcDWhtyTWl+T/OrC/BXFyMq9m/khx4hl2/sX+CWWun+kkg4IdRm
	4k3t2fDa2+zLAu96Va6GDTCuTgVjjbZ7qpVSbb/dEP33efF4+2c/J7Xr7HhylU0XH10NHS
	yiZk777Zkv0ix7pQQE71zzbCsKzIjbo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-AFr4jj9aNuaiFvVZ3ZhgEg-1; Thu, 10 Jul 2025 04:26:49 -0400
X-MC-Unique: AFr4jj9aNuaiFvVZ3ZhgEg-1
X-Mimecast-MFC-AGG-ID: AFr4jj9aNuaiFvVZ3ZhgEg_1752136008
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f8fd1847so369277f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 01:26:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752136008; x=1752740808;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sza+IKOP5j/hxMGakskkrB4XI5GsufRQhspoUE9PIl4=;
        b=bUv57nxiqyk0KrqCwR6/JcT5Cc3jz8FC3RMT72m/frDgP9KCl2HjjC0qohzDxOflmz
         S67H9xS1OtoHM/wIaycQfAXfMAWWfVe3/6iJRaYx2LioK5ITS041zI7BbHAM1evrXQoo
         eQU/UhewbusdY3VR7O3o0yKH6fsWzXpUfGGdmoTZBP7zMoQCqYuUzUUo9NejWmJPBYhP
         ++aN7oRlW6r5ymduTXal5/bWCESCa+Wlv1ugr9vhukY6MwvdoA+cFS1OQQJJQd6u4akB
         TGcgjKQo0zmGKhYvTNXCrtLmecxVElbBndvhS31R4QjOx+vHcAm0jud+CfKuUTuCmy+m
         3KzA==
X-Forwarded-Encrypted: i=1; AJvYcCUMHCGQIvMooUse2+2HfXsEDZdxOikZW3yuyCddnSG+QKMwBeW0M41J2/7tp2w72DtR234SSgEyEhnmin0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6xYplcsEk7DXyRBPAbf5CcPu+QwyshPxDQ9ltcvcvIwuwEjOY
	OoOYEMBVNxSkPGOtqwI5l2+DJ4d3/qIS+l2clly1WASQA9xzbBoNqo05FONIRLjOG92Zt60HXW7
	2HaV/uuC4tU1nx1ORG4L5BWJK+8zNrG7GcTK171q2vjrZyTgxohh5GOyaBbSqF1BT/g==
X-Gm-Gg: ASbGncv6mODZV1+kD2gfh9fWd/+p9j2iw3xl9akryhEmqamYFgks/BRyfEzUVmWXL1A
	va3DsfHVMNttV6fv6nvELqH/tnzPH5HxeiSYf4nUIzZrx4dv/qmQwnOj1ur0iWzC/i20FslL2Qp
	eyzc5XJm/IOBp6lohoxb7xX3fkHaNUrNgTDeV0V2bkVtvH2a978nn+zMdwunmSt8mcEymQ7b0YN
	2SMZMgPFjZ7HwsMUlPfOUpzM8yJMuMfm7VO7gXZgwgnNDhJh/i4B4OoQojH/cGlPX4QOCakno6J
	kFHRC0MLDdQYFo/hMDDoJX2F8bhe570MbR4wtIuWPCeoqp3xY5084LtM5XfQJ5421Bgoog==
X-Received: by 2002:a05:6000:40c6:b0:3a5:5270:a52c with SMTP id ffacd0b85a97d-3b5e4472ec0mr4778861f8f.0.1752136008361;
        Thu, 10 Jul 2025 01:26:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgdcEh6q1I/GWA+mA5Eoi9m4dRrWkS+fzEiavqUBfv1TfrFfEGRZ2MyEm9+svQXhsbkjE32w==
X-Received: by 2002:a05:6000:40c6:b0:3a5:5270:a52c with SMTP id ffacd0b85a97d-3b5e4472ec0mr4778832f8f.0.1752136007886;
        Thu, 10 Jul 2025 01:26:47 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:271f:bc10:144e:d87a:be22:d005? ([2a0d:3344:271f:bc10:144e:d87a:be22:d005])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd464011sm12416395e9.10.2025.07.10.01.26.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 01:26:47 -0700 (PDT)
Message-ID: <9ea58b38-921c-45a0-85cc-a586a6857eb1@redhat.com>
Date: Thu, 10 Jul 2025 10:26:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: This breaks netem use cases
To: Cong Wang <xiyou.wangcong@gmail.com>, William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, victor@mojatatu.com,
 pctammela@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
 dcaratti@redhat.com, savy@syst3mfailure.io, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 linux-kernel@vger.kernel.org
References: <20250708164141.875402-1-will@willsroot.io>
 <aG10rqwjX6elG1Gx@pop-os.localdomain>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aG10rqwjX6elG1Gx@pop-os.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/8/25 9:42 PM, Cong Wang wrote:
> (Cc LKML for more audience, since this clearly breaks potentially useful
> use cases)
> 
> On Tue, Jul 08, 2025 at 04:43:26PM +0000, William Liu wrote:
>> netem_enqueue's duplication prevention logic breaks when a netem
>> resides in a qdisc tree with other netems - this can lead to a
>> soft lockup and OOM loop in netem_dequeue, as seen in [1].
>> Ensure that a duplicating netem cannot exist in a tree with other
>> netems.
> 
> As I already warned in your previous patchset, this breaks the following
> potentially useful use case:
> 
> sudo tc qdisc add dev eth0 root handle 1: mq
> sudo tc qdisc add dev eth0 parent 1:1 handle 10: netem duplicate 100%
> sudo tc qdisc add dev eth0 parent 1:2 handle 20: netem duplicate 100%
> 
> I don't see any logical problem of such use case, therefore we should
> consider it as valid, we can't break it.

My understanding is that even the solution you proposed breaks a
currently accepted configuration:

https://lore.kernel.org/netdev/CAM0EoMmBdZBzfUAms5-0hH5qF5ODvxWfgqrbHaGT6p3-uOD6vg@mail.gmail.com/

I call them (both the linked one and the inline one) 'configurations'
instead of 'use-cases' because I don't see how any of them could have
real users, other than: https://xkcd.com/1172/.

TC historically allowing every configuration, even non completely
nonsensical ones, makes very hard to impossible to address this kind of
issues without breaking any previously accepted configuration.

My personal take would be to go with the change posted here: IMHO
keeping the fix self-encapsulated is better than saving an handful of
LoC and spreading the hack in more visible part of the code.

@Cong: would you reconsider your position?

Paolo


