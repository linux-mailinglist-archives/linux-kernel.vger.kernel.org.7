Return-Path: <linux-kernel+bounces-871499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B46C0D774
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE5501893667
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75112417C6;
	Mon, 27 Oct 2025 12:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bt0WeLtF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9D034CDD
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761567435; cv=none; b=qGMIzyVcwJemLdFvPPCc+bIMlmbPkhdQc6KFqqSE+LXPj6umMoLYqHALAQICgjGxl/urqdy9bslvSO+hi7SLtmlHcdzDFWWfmvMnLbfguuGwjGkIbH63oh9aWAE9YJvtMG/J9Y2zqfSqZ2IOy7GMxqdlwSFj/T/7oDH/rbUVJ2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761567435; c=relaxed/simple;
	bh=YR12sKGhRONVq2yXxm2TAPaIMnUVBplChfPxGJDFMAw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OuhgiZpv+n2Sna0UhdbmCDxnQKApZp0wb8IRFvzfIp0cn2FnI/FDw9ogZdDgGja3/dEZvnB/IIpMiyM4AcRz93mgr2eqA/VFsUrOKq/JffrBo8ije7pQ+ABo0k270ufgajCVpG9/3oikmDFi3kaSRb1cSde6TvTFmsbl2bE0bl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bt0WeLtF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761567432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wll0xmsacByMeT/hOTkkX96EzOS2Mn1ybFdnjeQhq3A=;
	b=bt0WeLtFHkOXDyowdpESW3ULcjZ7w0V2ZG+/2qKEPXUK5XzkZkoegBKi9ffMhw9IgsIliN
	JZhkR3nM19+Z+CHQQqvGs+IoIB97cjJehkXBWB8z8wzSy0JC2xhc7VvWPNxtlp/5T/z/6O
	sbic1n0y5MB7eERKqDjoCZ8HRl9C1EQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-q47BJ0dHN5WSIlp6G0wT4w-1; Mon, 27 Oct 2025 08:17:11 -0400
X-MC-Unique: q47BJ0dHN5WSIlp6G0wT4w-1
X-Mimecast-MFC-AGG-ID: q47BJ0dHN5WSIlp6G0wT4w_1761567430
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47496b3c1dcso33754505e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:17:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761567430; x=1762172230;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wll0xmsacByMeT/hOTkkX96EzOS2Mn1ybFdnjeQhq3A=;
        b=iec/BmwQrtIf1nTFCEWLHtBRLMUK58FP/YXuhNppmE6xIGhmZrJKFOA4CTexYs/2fJ
         xuE9o1X/WCbN0rR/puaQ32LeinwcjN7y4UwmM7lhkHUNAHlNTq56ihtGper34KqDxLOj
         49vrh7/KBHois10BH4yK0xMwmIviAgEL5Hay67GIjwHq/smAQrpyHGAPwqWX7I8lzxry
         bn4mtT0QmcaP6UiKlo1BewQKuD2qjETkRtKgLfYOb65MsunHPCdDVItoExUZXD1OsuyX
         wB2+2ev76DyMGREKf5onpW756sVE9kZpH4aQE1cBS2SgAvLEjjdPSfzSCPiBY2et4aCX
         d12g==
X-Forwarded-Encrypted: i=1; AJvYcCUh/5Zev3kCCASbH89w097QjYqd677DYBCIWabJdtJhd4VZylnUhNgE3RUUWvSQxEEmbp0+7FjrsS68f2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXEZwmpt/d3CSCMXZz9uebsomvTU5IXVI3NYV5Zy8kgoCWdz1u
	rpW8VtCXFBX/N2RXlJ9cGhqp+FyiLRo8HrEvKbDgQz8CaK3CyIKh3aLiCVeQ33NDEyxhs4zzv8p
	kTbk5q7BWXYsX2zI1Ttq+byimbnDAyFldjuC4fZaib71IaT9qkoxzc/n8G2euR1JKaw==
X-Gm-Gg: ASbGncsPv+DTzZ/3BZugckI5IykrmEKlDYBAqO+Of3Db/6RZ6HBAGYfH/+jhQHMVUD5
	VM6x7ITsADtNsvm9hzhbln/oRC83f6zQOGTDAHqylQU4TvyQnk8d55R2NIbtCkiRGGtIXwL+Rbt
	MBvFsYyiqyiA/3l0aL0q4QUzfbRdolfXcWxm/KTsuHSkRFmt1xjfHpQkg1ZMBTY9bgL6wPB0FhS
	Q0dD6kv9pF573NA8PmT7nsjf3NfWjufWxNVzuC6/qpK8qQ0t0/XBIcvCBawHHvDW9vHafHNsyjc
	w2ttpf7XkRcYDQsL85lucNPd/MrobxY68wUKo87nixvFJ1cE2PZkGRZuXK/m3ONfWwxqiJX/BVr
	G64eSJ2D5aXERIxJrJEgsHKWTQH8eKxQz3Mj6NbQn0Y1E6z+Q
X-Received: by 2002:a05:600c:a02:b0:46d:5189:3583 with SMTP id 5b1f17b1804b1-475d2c2ffaemr87848385e9.0.1761567429921;
        Mon, 27 Oct 2025 05:17:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8Kt+sgYwnqm/Q4piYTRL+0NmhLKf29X3f9k3CyMYQpSiUpxteFuRbA1s4pQkL/YU8wr6E4Q==
X-Received: by 2002:a05:600c:a02:b0:46d:5189:3583 with SMTP id 5b1f17b1804b1-475d2c2ffaemr87848105e9.0.1761567429402;
        Mon, 27 Oct 2025 05:17:09 -0700 (PDT)
Received: from rh (p200300f6af131a0027bd20bfc18c447d.dip0.t-ipconnect.de. [2003:f6:af13:1a00:27bd:20bf:c18c:447d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dcbd243csm65775805e9.0.2025.10.27.05.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 05:17:09 -0700 (PDT)
Date: Mon, 27 Oct 2025 13:17:07 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Sascha Bischoff <Sascha.Bischoff@arm.com>
cc: "maz@kernel.org" <maz@kernel.org>, 
    "oliver.upton@linux.dev" <oliver.upton@linux.dev>, 
    "yuzenghui@huawei.com" <yuzenghui@huawei.com>, 
    Suzuki Poulose <Suzuki.Poulose@arm.com>, nd <nd@arm.com>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, 
    "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
    "will@kernel.org" <will@kernel.org>, Joey Gouly <Joey.Gouly@arm.com>
Subject: Re: Failing no-vgic-v3 test
In-Reply-To: <985e9c0d9079ea2a27114a8b088ddf10482e1f37.camel@arm.com>
Message-ID: <ae15bf83-df34-59a3-712e-6102bec59801@redhat.com>
References: <f9c7fffa-53ba-a506-b48b-07e3df2d1d5a@redhat.com> <985e9c0d9079ea2a27114a8b088ddf10482e1f37.camel@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463806286-1316213544-1761567429=:13240"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463806286-1316213544-1761567429=:13240
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 27 Oct 2025, Sascha Bischoff wrote:
> On Mon, 2025-10-27 at 12:37 +0100, Sebastian Ott wrote:
>> on an ampere altra I've got a sad selftest:
>>
>> [root@virtlab-arm11 kvm]# ./arm64/no-vgic-v3
>> Random seed: 0x6b8b4567
>> ==== Test Assertion Failure ====
>>    arm64/no-vgic-v3.c:66: handled
>>    pid=3793 tid=3793 errno=4 - Interrupted system call
>>       1  0x0000000000402feb: test_run_vcpu at no-vgic-v3.c:128
>>       2  0x000000000040214f: test_guest_no_gicv3 at no-vgic-v3.c:155
>> (discriminator 17)
>>       3   (inlined by) main at no-vgic-v3.c:174 (discriminator 17)
>>       4  0x0000ffff873eb587: ?? ??:0
>>       5  0x0000ffff873eb65f: ?? ??:0
>>       6  0x00000000004022af: _start at ??:?
>>    ICC_PMR_EL1 no read trap
>>
>> This is a guest without VGICv3 on GICv3 HW. The test expects UNDEF on
>> reg
>> access - which is not happening since:
>>
>> 3193287ddffb KVM: arm64: gic-v3: Only set ICH_HCR traps for v2-on-v3
>> or v3 guests
>>
> I posted a fix for that the other day:
>
> https://lore.kernel.org/all/20251021094358.1963807-1-sascha.bischoff@arm.com/
>
> Could you please try the fix and confirm if it works for you?
>

Yes, that did the trick - thanks!
Sebastian
---1463806286-1316213544-1761567429=:13240--


