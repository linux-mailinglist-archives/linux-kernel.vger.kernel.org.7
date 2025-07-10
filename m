Return-Path: <linux-kernel+bounces-726096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0F4B00805
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 508653AAF11
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3A52EF2BA;
	Thu, 10 Jul 2025 16:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B9blc9KE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814DD2857FF
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752163452; cv=none; b=k6Mlx3VPmReMRN6hpwg7SZH4XrvBb9OECyrpJyPtoXyHWjA1qHcwdZKwre4X6U5oHt6xWN6bRR+gVCBrW45zAe7xqsTTNpvXSKNmZNUoDb27W1a/lH7FmTo6lESmQ6YN09A+Onx7qBeI6KzpEi2SpH7Lkp+S7G4F/4EWMp1mvH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752163452; c=relaxed/simple;
	bh=45SIG5rPi31Du7cZARxkbmyB/fEEYfkUbHU85m7Yd/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rjoV36W8OJwaYxfG1buEzItoLZls7NouTJpZpQN12u5hqbCfNypo4U1FU2aI1Wx2Bsf1LjtNnOyF+iHNKULdhF3FT3pYq1GD68sfyxmC9PFt73D5Bu2FqdnpyE2M7COAkVRl9qANCDVVkbmT4NXfWsnuhv+ICUNojEVwllMNtsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B9blc9KE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752163447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NSCoFxZmQFbdN64FGaIzAmf+ZfaD0SDOkGG3PDCYahE=;
	b=B9blc9KEO6bp7K2+dwPtdUO1mhGx8MfnhwTSEfSt0SjAjnsYbxc7GBafqoBHOAjBr5HFVi
	6PTTyaUuniFRgz/Zt6EVjZyE7WDwCN6+2B3mlEZigy3JysaM/fzDnNSWTXb7ttvGspCe7A
	YiH+H3Lo2SO+8jv1+jRmcHH/OxoxoNg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-VSdjvebxOpmee4f3yln7SQ-1; Thu, 10 Jul 2025 12:04:06 -0400
X-MC-Unique: VSdjvebxOpmee4f3yln7SQ-1
X-Mimecast-MFC-AGG-ID: VSdjvebxOpmee4f3yln7SQ_1752163445
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4538f375e86so9037405e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752163445; x=1752768245;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NSCoFxZmQFbdN64FGaIzAmf+ZfaD0SDOkGG3PDCYahE=;
        b=mcC1Syrt/49/CGJbJzJQ1SM9Jdp+zPcS7hWmIoTJZTfc6TbUqllSjQc+PEBotC6tdS
         ONu1f3vXk4ces8NfB7YrlwXECNsdWR07d+5aN9b9i/dPoPDDGcztJ6NRFgV8IAUcEu5m
         mW93e5JDtca50+9UI11HrHLmp59YJ5Vavj73xn5oSlk+icGjEHQO+hp2eICXEhxch/02
         OY+4st52/5fCRhABF/VjM2wmjKpTYM7XBdb3LnPjH87gaBlLPLN04Grzglqc5GiOUQXP
         4m1KS1fYHsdZU/n7E1D8voExwQ0I3xewAarkrbA/ygEktKUfLVDlMc52qIWy0QWRZt0o
         lZfw==
X-Forwarded-Encrypted: i=1; AJvYcCVyyEMP6mtbXE4Mp5/65eVQzhHHsmYXmZLH2/WXxb6ICXCbxMw3m2tGGAsN9uw4AJZCEOvIi/wAzfWOVbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoQKbIDJxT/mYE8+0VwB09JfRTJBFElNRsGHRqrqtCj3FLa7Bg
	p62U+Z+BBNufAV4RNhaQCDGv0BchkTit9R9vips3cr42/WyHsyIgcmlSJXrdmw/raO45+831jZU
	Dz7bUX1YCXx31sCQ40KA88zW9Dyg8WfJCdt6c4XdgwZk6heTZHt2qEmQm4gre111O7A==
X-Gm-Gg: ASbGnctw6SrzqcMK/TbB9waHa/mNVW44Ih66fMa6ldsSaoitaRbCOc4/maFw6rRhel2
	oTUcaMa8N14c3FLUOcsFhQ/+LUB42GhVpHqtcu82LIcjSUngqm0sxhcU7AyTfpkwikOPgV+U9by
	jXP4hm1T6LFvYI+u5Hrv+jImpXR5HezgrxFaO8DX/H6tYuxEZb+URzeiiRE2SBLFjD/NjIICSBm
	/Ai9WDJtmCk1TqorO0AC8AU747Hx6noEDdZi0BlFmu+h62R4b8G7yJgMx1XDas4a0K7j3BuZlE4
	21TdVMPP4obS8HbDpRgEeLnsH7YxDV6H1C6ZR6oqW+chzTItQ6zdYACvFtnnOZ1hqdmoRA==
X-Received: by 2002:a05:600c:8b07:b0:43d:fa59:af97 with SMTP id 5b1f17b1804b1-454d5404715mr63093135e9.32.1752163443509;
        Thu, 10 Jul 2025 09:04:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwQsXap6CXeZtb932z9EyvfOv6madp5+KBeR3+NEb4XXN6+C92DcDbsyl7FzhVwLWiFi+d5w==
X-Received: by 2002:a05:600c:8b07:b0:43d:fa59:af97 with SMTP id 5b1f17b1804b1-454d5404715mr63092535e9.32.1752163442931;
        Thu, 10 Jul 2025 09:04:02 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:271f:bc10:144e:d87a:be22:d005? ([2a0d:3344:271f:bc10:144e:d87a:be22:d005])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5032e9esm62029605e9.3.2025.07.10.09.04.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 09:04:02 -0700 (PDT)
Message-ID: <e0f9befa-d29b-4cc4-ba41-e38f398a6589@redhat.com>
Date: Thu, 10 Jul 2025 18:04:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [lsm?] [net?] WARNING in kvfree_call_rcu
To: Kuniyuki Iwashima <kuniyu@google.com>,
 syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
 paul@paul-moore.com, syzkaller-bugs@googlegroups.com
References: <686da18a.050a0220.1ffab7.0023.GAE@google.com>
 <20250708231926.356365-1-kuniyu@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250708231926.356365-1-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/25 1:17 AM, Kuniyuki Iwashima wrote:
> From: syzbot <syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com>
> Date: Tue, 08 Jul 2025 15:54:02 -0700
>> Hello,
>>
>> syzbot tried to test the proposed patch but the build/boot failed:
>>
>> net/smc/af_smc.c:365:3: error: call to undeclared function 'inet_sock_destruct'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>>
> 
> #syz test

Please, strip down the CC list to strictly skyzaller related recipients
while sending this kind of test, as they may foul PW and the CI.

Thanks,

Paolo


