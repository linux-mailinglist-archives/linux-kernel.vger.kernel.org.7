Return-Path: <linux-kernel+bounces-770249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD8EB278F4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61FD36003C0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 06:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A65721CC4B;
	Fri, 15 Aug 2025 06:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hD/UfmUT"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DAA31984A;
	Fri, 15 Aug 2025 06:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755238683; cv=none; b=ilmRHzugIget8elsI/3537MIaOXUb0rcPpuoAg8PWWVUS2+NgVTde/avO5Nw+DsOtAJ+Vl+pRQbzcxFoQeuf5dYTbihG/lfrlzjLciL/AkoyUIWobxTE2ZMI1dJbxKRy5R1VqohRAdLGHR1ECmBn7Bue2y4Fr9YhIFu6EUFKoow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755238683; c=relaxed/simple;
	bh=or1gFPD0V4lwe/vE2EB4NaLKRa35Pt7cFPpKpGb7EhY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=LpWB3+swWwDxNxAi7GZ1hxrDJblHT0F/g3pHs+7sSQJ9EU9zpSNuB8EXiiYbVZRxbMQVkCMbi0V2wiaixIDIw4MZ70c2KXfQ7wwfN5WgJ1to3FTo1u3lNuUjuhAv35xbS7t+2poXIhy5iShkzlabIJ3F2oVIuEaAR4qFi+0esCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hD/UfmUT; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24457f53d2eso20021085ad.0;
        Thu, 14 Aug 2025 23:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755238682; x=1755843482; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OZvYx3j5DdHLNXjIS+xh8bbsRGB+lm+tb1R0Is/CiNg=;
        b=hD/UfmUToiu51dWOgO8zztn/v/cs8uSRKZDMsEghJCiJRabFLQnGGCzxDqoxQP9hMi
         DVUA/6iVEcuJZ14J8OYeR/Na2z/1N39Cw8zwbv+w/RK7JTXRzNuRaeKnSTJRljOs1cUB
         Cf+pjvIM/fNzla8D04GX0Orx6oUIQjuTnQhmvDVd66F8m786SUZMi55r1E2O/ilopeSi
         B6cMc5CnRJXoZ0M7Ew/p9QmcZskf7xMPkQ42eW+sCODERZwZuVyV0voO1czuwED5NdXm
         inMYEx96YvZ0elr0QpsW8bVBK5f6GxPRY/zqMGXcdtswILORlgSmUzhbErJX6u6TVw6m
         FPrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755238682; x=1755843482;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OZvYx3j5DdHLNXjIS+xh8bbsRGB+lm+tb1R0Is/CiNg=;
        b=JHj+yytEEArcop9N+CXnmKEkFnCltClcN/+4zYBOmH34Ivf86v4CjZzMJgLC350a7A
         JFNnX/oe2p8TZieI/SgAauHSR/rupmbjrSq4vvfwDspW8/fI7h81XoiYpqrsQWiBMcuc
         AOjQRUFqz7EcCJkTJQ93oUfR60dqiyAvJm6GR8yHrUobzgOvYnnXh1ix9sET5Q6FuMSj
         G30Lz5DkBY+Zc5ebxXhy2djZ4fFyPrFzn48S1IZ1Gv3cfn+58BYCxDGle5TsZMoEQr66
         4SozFvqzK0DzyZkw418QFvXANE1v1V7A+lciTTXMOouBBXx130YR10I5cgvSPCa9zgoT
         kUYA==
X-Forwarded-Encrypted: i=1; AJvYcCXk875PgCUZSq7tBZqRP5U2fT/j7hsjdqQQLYSG07gfVNNP9puuiLJX08vxagXNharv17tpMkA1H4/N8IM/HqyftC7wjg==@vger.kernel.org, AJvYcCXnT6Iu6ATyHb+G9JQnX9PlNdl81MvhnBZYQ+HxYtAGtOZlnuFmTyld1NyKJvY5YE9iEj77E+uSpIUYhoo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk6V0SkSy7Pp4nJzwzYo6EaNv2ycc2CoqKiLvg6Xl6bTV2XRIn
	txGkMLLB9PCe0QPNZ2Xq2kHe06ZZ+HIBZ1k5qCH/NNbNJk7+TRAVlYE+NgnrIIYL
X-Gm-Gg: ASbGncvAnWwnQmrUKiHg1Zle4mF27Nr+TSkHBdnpXgsHtZsvCSzaHakDQBoVgKufXO6
	0CUSb6KmRwfWbcW0HhWiV8ufJDbmr1pfwQNDeqCpEYKdt9W/VgPogIz0P+yG4mMq+Su1lRq0mKt
	itfpBzWrkNDLT3YjsTM9YilTwVFZf2+aKxioYWPQSGOz0UKdsrDUxP6KoeA2Dvx9bZhZX1cVI/F
	t1xBWCtJilAYCS5+WFDqbM+hKI+LcCEZ3Tju5eSEMYLyXMP9/79d81vWbktPMW6tB5GvTPbm+4s
	jwCKqgNs8+9e03g/Ie+zAA1BpjAGTXipyxkiuHU9HP33M+hOjJ50p0tq1qoqBLCDi6cYYBn8ucC
	YyjHyUVnnGdrDV41HYGVfL29vXnU0OKxIyueU3p4dXStr86I=
X-Google-Smtp-Source: AGHT+IH+ACi0IWROk9RO76JWIO72hBL92ShYEv9kD+tQWA+Qk/Yhp1y2PpWWxDxD++a8fYF/kyB1ng==
X-Received: by 2002:a17:903:384b:b0:240:678c:d2b7 with SMTP id d9443c01a7336-2446d72d0c9mr15244495ad.15.1755238681774;
        Thu, 14 Aug 2025 23:18:01 -0700 (PDT)
Received: from [192.168.0.195] ([111.94.128.106])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d53a2bbsm6572405ad.110.2025.08.14.23.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 23:18:01 -0700 (PDT)
Message-ID: <81e92b2d-825d-4455-9042-474c66c91120@gmail.com>
Date: Fri, 15 Aug 2025 13:17:57 +0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: w_armin@gmx.de
Cc: basak.sb2006@gmail.com, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, jlee@suse.com, kuurtb@gmail.com,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 rayanmargham4@gmail.com
References: <f5d8b82d-c711-4611-b257-b4297f172bb1@gmx.de>
Subject: Re: [RFC PATCH v2 0/3] platform/x86: acer-wmi: Add fan control
 support
Content-Language: en-US
From: Fa-Iz Faadhillah Ibrahim <faiz.faadhillah@gmail.com>
In-Reply-To: <f5d8b82d-c711-4611-b257-b4297f172bb1@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> > This experimental patch series aims to add fan control support to the > acer-wmi driver. The patches are compile-tested only and need to be 
> > tested on real hardware to verify that they actually work. > > I 
> CCed two users who requested support for this feature. I would be > 
> very happy if both of you could test those patches and report back. > 
> > I am ready to help you both with compiling a custom linux kernel for 
> > testing this series.
> Any updates from the two people with Acer hardware?
>
> Thanks,
> Armin Wolf

Hello, I've tried your patch on my Predator Helios Neo 16 (PHN16-72)
using quirks from PH16-72 and it looks like fan control works just fine.
On other note, can you please add PHN16-72 to the quirk table?
if you need anything to test please do notify.

Thanks,
Fa-Iz Faadhillah Ibrahim

>
> > Changes since v2: > - remove duplicate include and replace hwmon_pwm_mode with > 
> hwmon_pwm_enable in second patch > > Armin Wolf (3): > platform/x86: 
> acer-wmi: Fix setting of fan behavior > platform/x86: acer-wmi: Add 
> fan control support > platform/x86: acer-wmi: Enable fan control for 
> PH16-72 and PT14-51 > > drivers/platform/x86/acer-wmi.c | 298 
> +++++++++++++++++++++++++++++--- > 1 file changed, 273 insertions(+), 
> 25 deletions(-) > > -- > 2.39.5 > >
> ------------------------------------------------------------------------


