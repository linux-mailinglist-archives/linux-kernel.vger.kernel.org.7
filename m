Return-Path: <linux-kernel+bounces-658585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA8EAC045A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 08:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12CC9A20D4A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 06:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D448221299;
	Thu, 22 May 2025 06:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a/o7v4Zk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E0A157A67
	for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 06:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747893954; cv=none; b=gxDJIuAJOzy+4SiYWfiC5wOiIM8eKTeJ3D/M70yR8jUI0vMDFQv+qdYB+Or6bFbnzyzUDiiHyEmaZWZjQqEutSr9krWNjHv48Yuq0rEm2XqGbItnrlsLigvAdSswWBAV7hde41/fqd8EFZOcm64fhr2gMMJ5TZYJr9oMt7GZU4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747893954; c=relaxed/simple;
	bh=I+7T0XWA3psCI0S3YgG5g5cyv/Ez0iIKfqzxER3LdUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjzYeHU13LFS05SDVDOFaM3o30FzvMy27A/3QK0jQ20j9nPJCXcVB71G4Gweha8RE5JSjpCFjUHwcFy/q6aNyJ6wyKkiyXPe1Kd3CAo6sjcbRRTM+FVcGsZkn8X3YTpycumtoz4dGqKI5OUSPPXDqqUVW6gMJGfXzImyMG80kCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a/o7v4Zk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747893951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T5UcmE338HgvT5w4WTQ/s8ig0Q1beM5AA/bl1F3aF54=;
	b=a/o7v4ZkwmBXwwC5djpQGh5E3iE7kPwsGSehez+eqvdE1PI4tM0QCW4vxC1N52f80gzasr
	MFAPb0E4Ht7tTFAbYx1UlI9eMCArXgaGA15+l7sfAltxz2lTaO/YH84OIEJvt358qdrvh1
	+1Fs9b/FCcHmiWkB9tqKCU1eVN8EAGc=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-CdF6DqvHMuiXAR_1IN2xJQ-1; Thu, 22 May 2025 02:05:49 -0400
X-MC-Unique: CdF6DqvHMuiXAR_1IN2xJQ-1
X-Mimecast-MFC-AGG-ID: CdF6DqvHMuiXAR_1IN2xJQ_1747893948
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b1ffc678adfso4943800a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 23:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747893948; x=1748498748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5UcmE338HgvT5w4WTQ/s8ig0Q1beM5AA/bl1F3aF54=;
        b=PyE8wJeOt8OCcwnqcj9tWbLDMuMo4RFPIkptFEV7dewHbm0EUeGI/JQhrYAnOK54jt
         7s5fmMEpbQ1aEXo+vXH9M/GmLMFiURO2x0KxzGFPMAgqHpzqC53thoXj3Kt6Q2UjtSo8
         zyITSR2DBFExs7o5Cd7hd1wIpJ/KLvPm632A5FqBDhs8yCt/pmX3C1KFBHKM8vgfvVA1
         RI1Otrva6r6dIUbY7ltmqU83tKqW0XR3ChMqAkvy5hwazaXqYbR75PlBgOV7gsX+K+Of
         Ss06EXmtuYbQhztd91geG8Cy56cxDW8E6XA1WGgn4wMhu2J8sW5iIgrLVo1VbnPOe4GI
         AFnw==
X-Forwarded-Encrypted: i=1; AJvYcCUZf3AXFqDrpvJXPEa6+HVJgSmQJ+TT4jfDZnPMvhwO2DxwYSzsk+2NLd/LJTabqhbpgnTVWhdiyKotIdE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr613HJPEuAY5RL1f9YH7eFskGeF0fJHnJ9N9WXzfi7+ZFQszC
	wSpQu7rIn4DRFw6ENweOwumd23bObmqy51A9mPIQHK9XaOznlKisq1aP2cocwpkwcBm912gtyWh
	7p6XkB97uOJKepTeLiRfZE59gerPtTLs/EH1gJ0PFt+oL8l3DM3TsqJtseG21z4DM4Q==
X-Gm-Gg: ASbGncs60+13b2w7XEPCcx9KDIEsI7ODosVx40cbEWzCTRYTT3Nzz/3TMsFkyZcI4Vz
	JDuC6cA+1HgK9BzC6vUNuanyPcn+8Kb1OETwrVhPPo6QilnroQsMj7xOi/u5JZfzt7jnKl2TCpx
	qZVgVnascMVkN8+PEFUVVbY52AeQCZxy5HwAnHfHiME/GQLCN3qTfiPROxjY3TjblYgxdRO0Ck1
	vtq1A5R5zVQnm6oVA3YrH8o+GyCVLKWT1lfASFTxKpVKG7D1Fj0WkfjR5VfuxTlEqVctooYlPIe
	Ycs=
X-Received: by 2002:a05:6a20:12ca:b0:1f3:418c:6281 with SMTP id adf61e73a8af0-21621875ab8mr35263900637.4.1747893948575;
        Wed, 21 May 2025 23:05:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTFkdwaFGdarcTnLubzQX5o2FjgnhFMq7UwYkJHfRvH9tVaqvdnFp2FCz6WDEjhRKA3X+QBA==
X-Received: by 2002:a05:6a20:12ca:b0:1f3:418c:6281 with SMTP id adf61e73a8af0-21621875ab8mr35263873637.4.1747893948226;
        Wed, 21 May 2025 23:05:48 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb0a0b19sm10539159a12.74.2025.05.21.23.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 23:05:47 -0700 (PDT)
Date: Thu, 22 May 2025 14:02:43 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, pmenzel@molgen.mpg.de, 
	ruyang@redhat.com, chenste@linux.microsoft.com
Subject: Re: [PATCH] ima: add a knob ima= to make IMA be able to be disabled
Message-ID: <wzquib7u5sycaf5prdgztlcudvaa2kma6jv3zmyfw7krzgnbkp@x2u5vnumfl4v>
References: <20250515233953.14685-1-bhe@redhat.com>
 <aCaFNvHbYxrCaPbe@MiWiFi-R3L-srv>
 <1d2848fe45dbf58707cecf16c4fc46b179e24415.camel@linux.ibm.com>
 <aC6Y3S9hEB1snvwj@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aC6Y3S9hEB1snvwj@MiWiFi-R3L-srv>

On Thu, May 22, 2025 at 11:24:13AM +0800, Baoquan He wrote:
>On 05/21/25 at 08:54am, Mimi Zohar wrote:
>> On Fri, 2025-05-16 at 08:22 +0800, Baoquan He wrote:
>> > CC kexec list.
>> >
>> > On 05/16/25 at 07:39am, Baoquan He wrote:
>> > > Kdump kernel doesn't need IMA functionality, and enabling IMA will cost
>> > > extra memory. It would be very helpful to allow IMA to be disabled for
>> > > kdump kernel.
>
>Thanks a lot for careufl reviewing and great suggestions.
>
>>
>> The real question is not whether kdump needs "IMA", but whether not enabling
>> IMA in the kdump kernel could be abused.  The comments below don't address
>> that question but limit/emphasize, as much as possible, turning IMA off is
>> limited to the kdump kernel.
>
>Are you suggesting removing below paragraph from patch log because they
>are redundant? I can remove it in v2 if yes.

I understand Mimi's suggestion as the commit message should answer the
question why disabling IMA should be limited to kdump.

-- 
Best regards,
Coiby


