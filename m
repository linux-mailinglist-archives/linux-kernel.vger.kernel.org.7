Return-Path: <linux-kernel+bounces-759341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0793EB1DC57
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 19:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E89158214D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 17:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAAC273807;
	Thu,  7 Aug 2025 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCiHyeJw"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CCE26AAAA
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 17:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754586777; cv=none; b=pLRfHimOy5dM+3yZaW3h4cPCv2oKHJACzq2PKzjgl3ri5Oeyq/Hp+IeDp8jjC6eFHH6FcVvk7DvuPbYEx1Kecsw8VPUT+mAxzydcr/o3DyNTWdUhb2pv4OfDXOLU/5zXoglnQqSQzgKjwciWCDa0vWNAt4J5XKV00/aw+jb9Glk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754586777; c=relaxed/simple;
	bh=jlOjZBPKweewocjmtxpybw/jSSUmluijaU3fqDFaBi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=idrKPkgHF+DxzhzPTXOwgWcOJdA4OYlBeJaC1pFxQqGl5SfmIXlae6NreGWfW+ZkDJgRvNN/w24tp0A4HqA5AsWN2l2hYpg9PS0e3MkgbO3EcWuNRNFHf3+EKAxWMi73Ac0RV5Ob0cmLgOe42yGOMYrGdpb16wXCsDN7h3M87nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCiHyeJw; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55b9f77f6e9so33158e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 10:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754586772; x=1755191572; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yEUJrNTVfNIvacBySzD/xtaOi3Go1shw4gqk3/yKQ60=;
        b=eCiHyeJw72XrnvPp+WI7INy+VK+1CM7FWnn2ylizjYhhlqpxACAhpSNchnew4sTe/5
         qVz3U+CU0a00xleg2pElFlL97IKgzTHVYogZINeHLqfFzB7q8Vutebvz/nWHGI0MRct3
         eR9R/I3uPHypoGNFQzdDrWkA2hAaMGCYjwGkfRnkcVNcq1/NH5wxIfVSPQbEMRnOE3ya
         a7sqm9dnZz73niar6wRrXZgAbxr2cvvNofp1e4XtORaa8iTQiiqSj/EzZxztbpj01Nwu
         v1lz2U0geM68GFFlZkyk8qQXiFDahDG1xQNlA6xwGNgfUuYkqHsWTJiesUmHNzd/74gA
         kD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754586772; x=1755191572;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yEUJrNTVfNIvacBySzD/xtaOi3Go1shw4gqk3/yKQ60=;
        b=neJ0nv9kRU0mibvLKBV4jbUBZtxC+nUfaQbP0FSTAIpDIxQat7+VpvOtW70jYyMudL
         FpoQL9u9K/KNV35WvoTS+T7lin6CYrbJLD2TxItNZeAKYaiLIeEOOqybiwLG20guaer5
         Op4Kxav+wk+WfY1iguce8HEGRyurEPirN2n/QlpsZt/eeGZSbQHMsjBWBRNJ/4O5SQVw
         4klMlzBKyNcmyoKBA+gLvy1bY8zcFQ1cTgSgJSAJf1VKoa75jykd7BJoZp9GTQ1oG1pZ
         hI9RDAnkS8Zv58CFCyL28YB0WytRNh/bZ/ru3ftkHSnIZGsAKXBQpCasRn1ZiC+XrJ/o
         nR3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUaURYbc+uP2d9cx/Ms8sJUBsd+fm4iBxxKcWNCZjYTeLYzufksQRNEg/Z+H0YSuAj5vaWdJr3g7oj1Y0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqckFpvYJP4H8l92SnChR5r79QnsexLUAlNC7ypw1a3j/srvLJ
	RwsDPBI686xPFzRNIW8OXBE61P79t4P4E2MGCppn6q1cZoSn2VRsX+4R
X-Gm-Gg: ASbGnctsyxscckLih01AcZXqjRyFUXBvqR0drUX9oMTTcX6bywbbv4cfk1VZU0l4GyE
	VeAX/D3miafcOtvFe2Pm7Ar8JFUv7ZrZcwbtl7qNv5+/jF7P1tUg7RuUc+CTsHLfxrJEBCIgMA8
	gRIxAo6cju+uxRSXcZNeyeHDy55IusNKWHhLd6gRe2AwxKydmsdyLaOjzruouz4uvvsxAvupGDS
	hloCzvOOkRoeRrIr5OB7iAPZIQjYQ73v66eqofnCTGwBntkhm1xcRYEvIab7YRuYANn5iiXnlGQ
	Dgh/OGD7+jJ7ceZObdn0J4DvX9Gz+XwvcpvSdOKluhaE5YiJjZ3aM844cpjN4rk5/X1o2VCFwds
	B8f3uO5RoC523I8Wbi5nwSYS5UoTD
X-Google-Smtp-Source: AGHT+IFDp/pH+iVJaWVs5CYee08Thd88h164T2tOnvjWqZ6T+8QyA37ORG7NjbZDbwdSaJmL+/ye8Q==
X-Received: by 2002:a05:6512:3d8b:b0:556:2e02:6957 with SMTP id 2adb3069b0e04-55caf35f712mr1032543e87.9.1754586772390;
        Thu, 07 Aug 2025 10:12:52 -0700 (PDT)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88cae595sm2715631e87.155.2025.08.07.10.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 10:12:51 -0700 (PDT)
Message-ID: <c540359d-b609-425f-a921-c7dad3213811@gmail.com>
Date: Thu, 7 Aug 2025 19:12:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] mm/kasan: make kasan=on|off work for all three modes
To: Marco Elver <elver@google.com>, Baoquan He <bhe@redhat.com>
Cc: linux-mm@kvack.org, glider@google.com, andreyknvl@gmail.com,
 dvyukov@google.com, vincenzo.frascino@arm.com, akpm@linux-foundation.org,
 kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org
References: <20250805062333.121553-1-bhe@redhat.com>
 <CANpmjNP-29cuk+MY0w9rvLNizO02yY_ZxP+T0cmCZBi+b5tDTQ@mail.gmail.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <CANpmjNP-29cuk+MY0w9rvLNizO02yY_ZxP+T0cmCZBi+b5tDTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/6/25 9:16 AM, Marco Elver wrote:
> On Tue, 5 Aug 2025 at 08:23, 'Baoquan He' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
>>
>> Currently only hw_tags mode of kasan can be enabled or disabled with
>> kernel parameter kasan=on|off for built kernel. For kasan generic and
>> sw_tags mode, there's no way to disable them once kernel is built.
>> This is not convenient sometime, e.g in system kdump is configured.
>> When the 1st kernel has KASAN enabled and crash triggered to switch to
>> kdump kernel, the generic or sw_tags mode will cost much extra memory
>> for kasan shadow while in fact it's meaningless to have kasan in kdump
>> kernel.
> 
> Are you using KASAN generic or SW-tags is production?
> If in a test environment, is the overhead of the kdump kernel really
> unacceptable?
> 

kdump kernel operates with limited amount of memory, whatever was provided 
in 'crashkernel=' for the primary kernel. So it's quite easily can ran out of memory.

By default kdump uses same as currently running kernel, but it can be configured
to use a different one.

At least in fedora it's in /etc/sysconfig/kdump:

$ cat /etc/sysconfig/kdump
# Kernel Version string for the -kdump kernel, such as 2.6.13-1544.FC5kdump
# If no version is specified, then the init script will try to find a
# kdump kernel with the same version number as the running kernel.
KDUMP_KERNELVER=""


>> So this patchset moves the kasan=on|off out of hw_tags scope and into
>> common code to make it visible in generic and sw_tags mode too. Then we
>> can add kasan=off in kdump kernel to reduce the unneeded meomry cost for
>> kasan.
>>
>> Test:
>> =====
>> I only took test on x86_64 for generic mode, and on arm64 for
>> generic, sw_tags and hw_tags mode. All of them works well.
> 
> Does it also work for CONFIG_KASAN_INLINE?
> 

I think it should. Because we don't initialize init_task.kasan_depth we always
bail out in kasan_report().




