Return-Path: <linux-kernel+bounces-672711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A04FCACD69C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 05:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C7F77A9281
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 03:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19605231828;
	Wed,  4 Jun 2025 03:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gY7sp7M8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61F515665C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Jun 2025 03:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749008126; cv=none; b=Yvr6DaUkmPs6RYBBkIgtRyS9XuERluDtJ5VL4t0GAgHPdF3WRkyeRW8IZ8suIX8uj/tJD9QQq9it7z7t07voczxrXWw9xUFyK4OYSBeTdW9B3qNMVffczMEoNisIFQ5L1G6x80DFqeIu8ZczP6IyEbVD62xKmojTDu8mCCO+h2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749008126; c=relaxed/simple;
	bh=hgsoK6RQCmY70/2eE5JluAaKNndCfa8R+nvWxZE+fk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LoE2PcGYrINi9ycz4BJ4m25GzcRELhpcTeFOgrbPgsC29OAXspbLmHntm7bXpVBmRf2ue3P23oEmbmTipFc2bVVGOb5I5po/2cVQ9TbklahzrObeyWTQZajDuZFbD5zefY0HpSm7yr4fjPe/KSFLIJOHDWGpfEFpkAKZkFdaQ4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gY7sp7M8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749008123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PO4T1rnPlmKykDehCYP0m1kIchCQnr8l4c6LLtP6l80=;
	b=gY7sp7M8Tj5U0LJ3MQPILuos0ZA9bLX4/nw4w/SbugYOMNz3J9rLc6IaIYCSdqjRxrwIsD
	tZBKLBUzb+rQ/gCy/y0gDu3glL8b+W36czQasmY8QNX7VtV0hbJnJKNARzu2MzKVCQQIrg
	9Mn1LHKVwRUtnnu3gRdy3kwdkS7Kh6g=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-_P7QOU3DPRufc4fMiPje9A-1; Tue, 03 Jun 2025 23:35:21 -0400
X-MC-Unique: _P7QOU3DPRufc4fMiPje9A-1
X-Mimecast-MFC-AGG-ID: _P7QOU3DPRufc4fMiPje9A_1749008121
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-231d13ac4d4so90640155ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jun 2025 20:35:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749008120; x=1749612920;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PO4T1rnPlmKykDehCYP0m1kIchCQnr8l4c6LLtP6l80=;
        b=T3hBrflXK7KJFRb2dNu8EVwcm0S6znLArevLerZoZe/3D1l9bPeYqL1HREL5njfQgU
         P0a5FBNXgG6xNbVphZFDXHHHjUxDa15/qGv97XCHRi4kRjkyEfFOGFjQpuvR/AdDjyc2
         PpRmDx9yZ5bKKHzUZRvyI6n+COqoE0Z+p6h0NyTfFzh/32ermQxuJa+44NmxPnPMsiEn
         LC1g5Hvh/MmXts9f2hJxr3q8FjS64Lg6XTN39/sBgkfOKhevA0WCRJuqszk5nit2LNwb
         xEnUrW49rOaLstv/qay7hMemIZ3OYuDrBMwZvs+YoQP36v0WJFDP24UfrebBa3a6k6Uk
         esQA==
X-Forwarded-Encrypted: i=1; AJvYcCWkb7ULpW8BVTrSryeBaJJi5PHBQNFEo6Ot2tT8wYzRXVhuYXfKqPKTf6zBVn+oGOJ1l7xOkKNoVFgnB9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy147PXCkgxalxYp5F7XPJkKd1JNv8+Wy/SmgieN4gyKhL2pTlf
	yQ/Ho9vbsUX4dIy53j45gvnWDGRUVTx+GKTcrvIqh7U6SCVQG+8HhsLoIGcoGWVKIukRqdCSmtM
	ZMUUKkUWUTv9VJzHtCxvhRbYgTJpmh9RefSeClvon/Kz5Fv71sHqrfKk/fbkE5+wSvQ==
X-Gm-Gg: ASbGnctqaFNz4c4i5WABF8RN3DO4TVAOAp2mB1xVbDaw7H/Xs2RE7I3+fWXzJQkSifv
	+TL6qPMhNu3+A5Lo7Cq9gmZKkCXhVeBVwXMRESyzldp/JBMqw3dI8MBKLEquLkhSqzhGJVcNANK
	Nesiv3sIjnR/Pty0mQ7iKLSqWBDz0aL7bzPL/LGzi6LPKhydBKV23eduqhaI+fdIpYPOjH5lIdt
	ReM9iwiMPPbnDLqbMeQLUj8ltqQc0fwOBLl1qAY5NbfYIIDwdqb+MD8FOk7UDXHM3APOoz4n6Wz
	eDjyFhCtUHEy6g==
X-Received: by 2002:a17:902:c944:b0:234:ade3:dde7 with SMTP id d9443c01a7336-235e1129185mr15703645ad.13.1749008120634;
        Tue, 03 Jun 2025 20:35:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGR2MuyzmZwUzZOpzOGpfnKsGH/Q7AqQUA7K47C8uCXumRKpRcoVETmeg7zWutgFqvbeD0vDw==
X-Received: by 2002:a17:902:c944:b0:234:ade3:dde7 with SMTP id d9443c01a7336-235e1129185mr15703375ad.13.1749008120217;
        Tue, 03 Jun 2025 20:35:20 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3130690562fsm743828a91.17.2025.06.03.20.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 20:35:19 -0700 (PDT)
Date: Wed, 4 Jun 2025 11:34:34 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Baoquan He <bhe@redhat.com>, linux-integrity@vger.kernel.org, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, pmenzel@molgen.mpg.de, 
	ruyang@redhat.com, chenste@linux.microsoft.com
Subject: Re: [PATCH] ima: add a knob ima= to make IMA be able to be disabled
Message-ID: <hn455nyrp65bb23ltub4tet6ixfcggshgerxm2bhun4ubv2iau@eanh3ka67irf>
References: <20250515233953.14685-1-bhe@redhat.com>
 <aCaFNvHbYxrCaPbe@MiWiFi-R3L-srv>
 <1d2848fe45dbf58707cecf16c4fc46b179e24415.camel@linux.ibm.com>
 <aC6Y3S9hEB1snvwj@MiWiFi-R3L-srv>
 <c0f1df02160138d0782cb897eda844287b3d7792.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c0f1df02160138d0782cb897eda844287b3d7792.camel@linux.ibm.com>

On Thu, May 22, 2025 at 07:08:04AM -0400, Mimi Zohar wrote:
>On Thu, 2025-05-22 at 11:24 +0800, Baoquan He wrote:
>> On 05/21/25 at 08:54am, Mimi Zohar wrote:
>> > On Fri, 2025-05-16 at 08:22 +0800, Baoquan He wrote:
>> > > CC kexec list.
>> > >
>> > > On 05/16/25 at 07:39am, Baoquan He wrote:
>> > > > Kdump kernel doesn't need IMA functionality, and enabling IMA will cost
>> > > > extra memory. It would be very helpful to allow IMA to be disabled for
>> > > > kdump kernel.
>>
>> Thanks a lot for careufl reviewing and great suggestions.
>>
>> >
>> > The real question is not whether kdump needs "IMA", but whether not enabling
>> > IMA in the kdump kernel could be abused.� The comments below don't address
>> > that question but limit/emphasize, as much as possible, turning IMA off is
>> > limited to the kdump kernel.
>>
>> Are you suggesting removing below paragraph from patch log because they
>> are redundant? I can remove it in v2 if yes.
>
>"The comments below" was referring to my comments on the patch, not the next
>paragraph.  "don't address that question" refers to whether the kdump kernel
>could be abused.
>
>We're trying to close integrity gaps, not add new ones.  Verifying the UKI's
>signature addresses the integrity of the initramfs.  What about the integrity of
>the kdump initramfs (or for that matter the kexec initramfs)?  If the kdump
>initramfs was signed, IMA would be able to verify it before the kexec.

Hi Mimi,

I thought you were asking that the commit message should address the
question why disabling IMA should be limited to the kdump kernel. It
turns out I misunderstood your concern.

Currently there is no way provided to verify the kdump initramfs as a
whole file or to verify individual files in the kdump initramfs.

As you have already known, the kdump initramfs is always generated on
the fly and will be re-generated when the dumping target changes or
some important files change. We try to generate a minimal initramfs in
order to save memory. So yes, it's impossible to sign it as a whole file
beforehand. 

And since xattrs like security.ima are not supported in the kdump
initramfs, we have no way to use IMA to verify individual file's
integrity.  In fact, we have to stop IMA from working otherwise it's
very likely kdump will break.

So far, I'm not aware of any bug report that complains kdump stops
working because of IMA. So it indicates very few users are trying to use
IMA in kdump.

If users do have concerns on the integrity of kdump initramfs, I think
we can advice users to make sure the deployed IMA policy will verify the
integrity of the files while they are being collected and copied into
the kdump initramfs by tools like dracut.

-- 
Best regards,
Coiby


