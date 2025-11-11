Return-Path: <linux-kernel+bounces-894878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A095C4C5C1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 35BBB4F0F16
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E55D2FB990;
	Tue, 11 Nov 2025 08:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGbssLNl"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676D82EA756
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 08:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762848859; cv=none; b=WukZyHheZod2b1nGxLpY5UyyySpAGd761Sz6Btp0+gi9MsD8h4RGvI5tMcZkKMfHnjEKZ0kGlWmWCbLZfrihoUm2Qw3BG4DvTDEZsuxieyfCcrvSiYDLabVk5yYNy7dy1Dly2t8aJiiW9y4hPTV13tIbX1qACrFpIdq2N2Ez6yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762848859; c=relaxed/simple;
	bh=PIVbeP4t8n8Ng4FTu7PKo/Y/zpdVBL6TpuyK0ff+Htc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FAm/ZgLY7tN+3KkKQ8UgbHcvBgz1aXZ6NrINNBgG3R4IYxIwJyA8IyT2vNhBQ30gZ+lZdzGsM/MIbhkbLwOfJsvbVnL7qsS3iKAt429vr8Wn4emf5EA7ZVheIxM3msPhpOIAPyKi+QUSgBEqHovalG8TguIO0upOpLUOtdctAME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGbssLNl; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-295548467c7so42804725ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 00:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762848857; x=1763453657; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ki+EdCwrqCwLTvI7nFeDEfQqruCfE/WB29n1X4H7FwI=;
        b=SGbssLNljTTVs9BPX0os//BvFsZvRp573bHZR1dVSS2OZltDQN/qkXmIqMcTdKC10Y
         Bj46z5hUUIydOkTZ6MQNW1NCwR5HsKvBX0T1X8m/CRYSCr2io82y8XJ0nRJEw+KwGjJ/
         DFX40/nSzZHIF9NoLbd+fFIlrJzCrF/96AG0VhtqZolz4wNlmadJFcukRqR3zSgLuKj8
         uRN2LivYbZcgkqdIXphEqSpfAIFujd3i40C4jF8KznaUYMIFb8vjVFxrfRGRFbFpQ0Qr
         mPD/v32qVgMI6TvcwCkuEwkDct6Ln0ZM+T5wmB5QOjNqmS6bHP+LeBJcfLpbz7jkMVZZ
         djuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762848857; x=1763453657;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ki+EdCwrqCwLTvI7nFeDEfQqruCfE/WB29n1X4H7FwI=;
        b=UMs4kPShaYMDokpZ9z1UQRPIqec8FdlGX5KVnXkXMQAtFohB9aoVTataH1n8LYZsqO
         DIlAWlHjLRmA3KQOC+xRHq/d29LdMU30a9BHubtQg3/3s2q7jWvnHUO3GqikMy4ltv/+
         biEq8toYZJLUxr8ZoBwLzk9Bik3Uf1XCXRTUFhJ8h56ZQzppscD0rfSbpkL3SNNnklC7
         RTZUjChvL0fmyjexz7NWhWN8nIa0FLNURTw8vwbOyjaPr3eYNZyuua9l00ed8rIufzPd
         lU4m7L0X2m+KI4KJPwK4Ez7Dz8ILKNG/xmUCRQ9QXNWryaZqssVEeYRAodWMshHAxQFH
         RSuw==
X-Forwarded-Encrypted: i=1; AJvYcCWKXu4WmFitoeZRRirxA07V8A9N8ynmXSGA5W30GWac1r2r8aqXWkcS6eTvV+zm0kuHt2o2/ZGFYgSKEwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT/h6CRFqO5rcZXsY3y73d316BzK89j9+3dJOyTuwNzFIQ89mu
	ZbhFu0VatooP2tVjbr49/M8kCPm3lOH5+Jtkvy9i5sc9FsFe3C8pJO08
X-Gm-Gg: ASbGncu7umxPchJDtq0l+REi1GDhzc9qhQ9oHAY6OsR9j6mNFJNtsWeSwg94Hi7EYpA
	F6vFAHWgXFQSjT5CpnAwpu/WBXC7tWR8oxD8zWXJxDlzyS3dCyMCUKeTDRbSVvQ1LRaY5+p9r1y
	Ajy4Ce3pU9vCR4kNuE+PoyNf+NcziGeVsGaGnKirzRrwj/9PGRPjUCMxXRFwoqQ0zqO59optxW1
	uQRlY8CaVN9tFyYJRDLYcCBKqtTA/BZj1C/5XLmq5Ho0H5yvvnd8V2cjCzIUE4RXjvuDHBjnyXk
	07+PzaAqPo7QufXK0uFASZ+qJvKk+bL4P8OkRtyRzQtQeabJAjPHhc3RnsxhcRE1aqU+z8m8fKb
	FVHeSRUwJ/R8nT3MSkiOcJ6mHd7wLB47InB+DQBPvi7nWr/339cZUT3WhvIi2qfhV/bsWFVCW5j
	KcyhA=
X-Google-Smtp-Source: AGHT+IEXbokiRMdzLwroLqxNwuaDg7sJCWR9XTrjrkrTQw3iwww5gG1R9bB24Xe5cDdIPIMJyxNYQA==
X-Received: by 2002:a17:903:2f86:b0:295:596f:84ef with SMTP id d9443c01a7336-297e56be204mr131918645ad.31.1762848857508;
        Tue, 11 Nov 2025 00:14:17 -0800 (PST)
Received: from [10.253.64.201] ([47.82.114.92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c8f07csm176195655ad.78.2025.11.11.00.14.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 00:14:16 -0800 (PST)
Message-ID: <da38c720-02df-4e3e-ab50-8fe84bdccf5d@gmail.com>
Date: Tue, 11 Nov 2025 16:14:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/1] KVM: x86: fix some kvm period timer BUG
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, Marcelo Tosatti <mtosatti@redhat.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, yu chen
 <33988979@163.com>, dongxu zhang <xu910121@sina.com>
References: <20251107034802.39763-1-fuqiang.wng@gmail.com>
 <aRKDLo_SFJxyQWG5@google.com>
From: fuqiang wang <fuqiang.wng@gmail.com>
In-Reply-To: <aRKDLo_SFJxyQWG5@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/11/25 8:28 AM, Sean Christopherson wrote:
> On Fri, Nov 07, 2025, fuqiang wang wrote:
>> =================================
>> Fix both issues in a single patch
>> =================================
>>
>> In versions v2 and v3, I split these two issues into two separate patches
>> for fixing. However, this caused patch 2 to revert some of the changes made
>> by patch 1.
> 
> FWIW, my initial reaction was that I liked splitting this into two patches better,
> but after digging through all the angles of this for a few hours, I agree that it's
> better to skip the "don't let the delta go negative" patch, because that patch
> really only addresses a symptom that shouldn't happen in the first place.
> 
>> In patch 4, I attempted to merge the two patches into one and tried to
>> describe both issues in the commit message, but I did not do it well. In
>> this version, I have included more details in the commit message and the
>> cover letter.

Yes, the reason why I issued the “don’t let the delta go negative” patch
separately in v1 was that I hadn’t yet identified the root cause of the
hardlockup at that time...

