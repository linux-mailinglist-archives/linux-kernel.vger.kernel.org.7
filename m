Return-Path: <linux-kernel+bounces-895720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E3520C4EBC1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6883F34C8D5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B91363C7B;
	Tue, 11 Nov 2025 15:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YTE2bqLE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oBhy4I44"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D858361DA8
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762874201; cv=none; b=t/KhvvvG+nBUX3qmHmIwMXfAWrKtRobM1soG5OgeseN8RD9eilBTEbFLrkYU4VH7R+4+JCD/Ft2N7swyW8/qyY7OPV/wl56XuX2s7AceJGf5RGrOxdcLoRjAjjK6sYwzwLmnUXUIkqPh0s02f3/V2w8uNe/+B/FRtIW2XnoRTWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762874201; c=relaxed/simple;
	bh=4W0pTQfMu9etHjodXoCYPTbDHsUcSu0s/ucskpokDRo=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hvBmxO/nyazgDlgwUHTiLfbZoKJXWp4iyGO56LqJ6oL/CWJriwApppTVMz+1ERYf7Ub+6CfE4JHNhdRqCVFCtThIod+q/Kv0dKZZ4jjnOeatdbHyAauEKZOyMb08jfeenZFVFDIAVIl+nbdepHCgGfnNM6MTmkdrdSxZpSibr68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YTE2bqLE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oBhy4I44; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762874198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sZo1AQWSnfv43DTha1xkrKb3ht+B4Kvjw3ow7j9JdtM=;
	b=YTE2bqLExx+eA4/bjuV4uqB8SlhsEsD9oTMjrQ9+5XeYZfKi/sI9F6Kz/d9PrF2vXlkO8z
	xpg31NNQHyu/G4opy0wHZWRT+aM81T5GnWvzBkACoN8xuSbZe10su7xOn8p9UEda67gAoa
	jAwoqXrvhnzJGDhOPeY0pGufWmZo+AQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-lMMJvohXOqObu-D1q0D6XQ-1; Tue, 11 Nov 2025 10:16:36 -0500
X-MC-Unique: lMMJvohXOqObu-D1q0D6XQ-1
X-Mimecast-MFC-AGG-ID: lMMJvohXOqObu-D1q0D6XQ_1762874196
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-88239fa9ec9so95686316d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762874196; x=1763478996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sZo1AQWSnfv43DTha1xkrKb3ht+B4Kvjw3ow7j9JdtM=;
        b=oBhy4I44+BEFsNbrk0LOs5e1i+FX04N1hI/FeKbcO+qSgUMQdsTHTUZETs8kH0q044
         8uRfehvVotH0p3njLffUU3Vz/GkNgBAth36bRbVa9PXf8GONBntHZkNdQRP+iZDyoJbS
         4gRGiP5rAozZZlH0RYdORC+Lp7GFclvzaZkMOtuOvxvBU1J3dgESFhjgkCPdfgC+krp9
         LBh7NEDoFI3VtUBMmiCILfUxywpfnccDdamiovi3FhIOXtmZblLD4rbTCsLTlQD5yizT
         8z2olZMNUkkMWMNyd5d4PJAccJTTQycDi5iNmbnd/9IneQLWsDG1jY4YyO8yBRutHsTZ
         xjHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762874196; x=1763478996;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sZo1AQWSnfv43DTha1xkrKb3ht+B4Kvjw3ow7j9JdtM=;
        b=FjfHGkRLzat4PYR3jy40yS+iPZXvj66CC8CXeIV11W0u4roUckFXmZ/HyZlkw6OM/k
         F7T0SPR/e/F5NciXzImgswbM9yCIZemePhknQ+rgk6q1uuFZu0fhaSnn6Mn9YYeZIL+t
         wHDJO2VUWDiKrHCRi1KlHGSX0CXy1Ut7CurXcZ6fqVza9Yf4SBEQRo12x/rw6bB4Zu3M
         skUqM+RB25xaO+JmaypoanVyNA6+6UR3eOKsd8u9L3RNs6zU2iUfheb/CACzB8483x9/
         77Zu9YHLtzocMw3eBcTGjUHnGvoOuWAttMOStVYmmvNll4rYS8IoZ5SjMO8zFgwG3MeJ
         tcsg==
X-Forwarded-Encrypted: i=1; AJvYcCUZ1Jn3C71WTx0SjluiyPKH451XXRnAI0LNCHHC+lWi+SZNT3mfTvBIZOM/6TJdpLqLWoo28iUrTidP6zE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGUlpQ67Pexvn5rplnXslpZl9oG3mzyYsu2LiQDjxNAPAbMDSh
	PwQ77oxj1Ykdp8itWM2OlKGR125pn0UmDB2QiE6dRHy3wQ6vbU8zhpV0/rohz19Ai0J7EMxXuMi
	ucO750AEORnhr5Y0yjVoAnRdS76Eh9FdTzO2/1wcm35nCj/Ak6dcfJ+0XD3fcD/6Dag==
X-Gm-Gg: ASbGncsY28OGYQXJbsNVU7hr5eGW1DooIPcnO6yVCHD7WXcOhNypIRdemSoTsfPshW9
	+Q2UPY296qtx6gPMnsSYVyHYRaKT3HDVPNN/7D8mcRQFnpoxLQUePRAcH0OPQk7qk0d6TQ7IMjZ
	QS5zgsi+GkW2JDN/u3uFk0p27dy6JlD5fgWjKlhkZ8EYKeeEDwIE6ulDKdkVPF70yG3WITNXhm/
	gPJZaJ/iCfUaB5vk3ll2mAeo5pxrLZ55Kc0HTb5U8X50FOIEp3RyNmIrdGmWpLto6e+pyS2I8Nm
	PCZsIkYCsqu+LmzfteEf0CrVOLosqedxdVbM6FoO8HiX/zGSJstG4ttLeuz74+llzScsIfnUV0j
	sTiJ9jdkBME9OjsT+ut1FnROvt/u52iAsYTV+xMP+WA1Quw==
X-Received: by 2002:a05:6214:1c0a:b0:87f:fea5:876e with SMTP id 6a1803df08f44-882385b834dmr149269566d6.10.1762874195785;
        Tue, 11 Nov 2025 07:16:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3NeH7/OIy+qUuqaSbJt2jgTZ6sJYqaG6aRRBJNwlPaRrbHA+xi9PkUix176w8VXhHJRIKlQ==
X-Received: by 2002:a05:6214:1c0a:b0:87f:fea5:876e with SMTP id 6a1803df08f44-882385b834dmr149269136d6.10.1762874195393;
        Tue, 11 Nov 2025 07:16:35 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238b75896sm73149916d6.49.2025.11.11.07.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 07:16:34 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <fed9367d-19bd-4df0-b59d-8cb5a624ef34@redhat.com>
Date: Tue, 11 Nov 2025 10:16:33 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] cpuset: Treat tasks in attaching process as
 populated
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Chen Ridong <chenridong@huaweicloud.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, lujialin4@huawei.com, chenridong@huawei.com
References: <20251111132632.950430-1-chenridong@huaweicloud.com>
 <dpo6yfx7tb6b3vgayxnqgxwighrl7ds6teaatii5us2a6dqmnw@ioipae3evzo4>
Content-Language: en-US
In-Reply-To: <dpo6yfx7tb6b3vgayxnqgxwighrl7ds6teaatii5us2a6dqmnw@ioipae3evzo4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/11/25 9:01 AM, Michal Koutný wrote:
> Hi Ridong.
>
> On Tue, Nov 11, 2025 at 01:26:32PM +0000, Chen Ridong <chenridong@huaweicloud.com> wrote:
> ...
>> +static inline bool cs_is_populated(struct cpuset *cs)
>> +{
>> +	/* Tasks in the process of attaching should be considered as populated */
>> +	return cgroup_is_populated(cs->css.cgroup) ||
>> +		cs->attach_in_progress;
>> +}
> s/process/cpuset/ in the subject
> and
> s/Tasks/Cpusets/ in the comment above
Agreed.
> Also, should there be some lockdep_assert_held() in this helper (for
> documentation purposes but also for correctly synchronized validity of
> the returned value.)

A lockdep_assert_held() is certainly needed if it is an externally 
visible helper that can be called outside cpuset. For internal helper 
like this one, we may not really need that as almost all the code in 
cpuset.c are within either a cpuset_mutex or callback_lock critical 
sections. So I am fine with or without it.

Cheers,
Longman


