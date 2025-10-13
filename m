Return-Path: <linux-kernel+bounces-851101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D40C3BD586A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AAF5189717F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE6B305051;
	Mon, 13 Oct 2025 17:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIwbLmOk"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3771018DF80
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 17:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760376998; cv=none; b=EJQvyNwh6K2j53TLdae+siUTKuWaXcdnWYQHsgwGJEibbh9XZLo+5I915kR5b9N9c7XVdgehutrxmOXGy06YBjoi9mh6ALPg9eHeOXGuNYPl0D5sJZTOWpAZ+vYvDr7h5krzEv9wfZ9Y2bGWf9iL/QqKSJWSfC95hcVkNZqfYH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760376998; c=relaxed/simple;
	bh=/DzNk9eo2hvC84o3yvnQwAIOYbrdJd0QnkiK4TyS6og=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LyHngp7L+CHUTrAixQm5VZpl8/J6fDm7alUrCe/yitnon/2SVWEzKoVLIsd74E2v+PgBTa55a9AF1gQakegOt3PiGqXk0JU9z2l6XXFNXmG05P/d/qSyXgF70maIa4oUTz2aJsL5quUs9hzXXLcGBYhg6qN9z/quxEvE3djbDNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIwbLmOk; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-27eceb38eb1so49461215ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760376996; x=1760981796; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JnDifAb/yM2sOw3dsFuYF6yVR1fy+kTBKbeq76ndcL0=;
        b=AIwbLmOklTi19/2uW0sOehKwqHQzHBT1IQib01z8VomyS5GKWIUNO3li8JHIXJ6+/1
         JKNFv0kZTbfvfUTWlJKA4oO82RfOgr8g9P+3WnMouyQhWCar9pav8WUteS1IHkShIIsI
         QG2moLSV6twV0I25+jVBJd3AvyGrNwP5f1pq8UPY9dk0M49WWyHzj1Ld4SnExWgL6XfE
         iOum1BqgUES1J/h8WzXLKrcH2sm1oB5GvALk1zgSosyAFkRfU4luqsVAsVpNMgswEISY
         Y4ggrOjlcjSsRc/oyP2GRjl3XwZH77hXu1nKJh+EqR5i+BjZtLNifDm50CvoPcMXuw4M
         /otg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760376996; x=1760981796;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JnDifAb/yM2sOw3dsFuYF6yVR1fy+kTBKbeq76ndcL0=;
        b=I23ALvsSeovJ+pvJSq6LPZu4xwta531blUtBUGJWfM4f8hLBl8ImTKQ6XMoqlQ/QJc
         x4eDj5k4xTcUF7YQLLQ7zK6Hr3ZQM35b5qbhl4VbaBo5L9wYACYJgvMUXp2lX1AvXrVI
         2+Ec4iiIcPeOK8NLET7nyBn+u3Uieb0bPJPbuY7cY3v4/CbxqwAtIvhrvsl1dsRB5I1Z
         mxR4BFH6bUce13VVnHZ81V9km4jBeM7l59VIZxuYYJvFMTESMxrmcJhrqWmNQZdavXC5
         w8BcYv6krE/tL8kRtqgatALi58mLK/CRM/kAh4TDCb/ndUxw0KSF0xGVM9k/dNk40o+r
         pL0w==
X-Forwarded-Encrypted: i=1; AJvYcCXnpLTT/8Ni/SX/0L1k8UFdK1ZI0XgJDGj1PmRRJwqjgqe/3FwkSIYXFhoADPCBSfUB4CY859JzoSt08DM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqzoWa5Y+PN56Jzip0VBhjT8Ygdp3iDg7zZnu3vH3foFRwYMai
	vP2QmrxR0H9TK0nkny6B0Baqat+HPipq//SI7i8genqQWYtrLuQ/8+pB
X-Gm-Gg: ASbGncsVeDJSLL5ZRZuwrfCeNLJnbT/951QDf/XBJYzSa62vd5B8jfaBjvbj4lRQ9y8
	OtB9EQWcwez9tRwOvBjBF4ZGMtiI+1cTG5BFOP4evGlgMUMhIuQ97jyJI8R6VjOGPjjCqHYMJig
	3YmbtYB+vmCpd4GLObF3XdbITDMQLBX4d9OiF6yHZR5NNnNLxfVQlvz93eDA90mRZciH7oBO6Xy
	KAU2J9dAfpa1w49S+pxTMeOkic6bP6riQXNhiYOFI3f23ECri7Qq81IJ07Owfwz24vEvD66QcDL
	h5FUqVmdFbREBdk51BI/I4UQscjw1DLmCYxDTGgwNvWfqShCyMEkI/M45zaNFNlGG5t2UNnXH45
	IPrcKqf0Idu8IDDOW4c9yd72Tr1D6mhppG5sY2WiaGdW6NnObODtqd7zf+H9cfAdN0E8zTZRfms
	8wAdJX+t/kRlb/vbzw
X-Google-Smtp-Source: AGHT+IEH1PSDchS8WSq6REC3/+6SHp/Km2QpXe16lj4D/IR29cmoRw0+Ti5/0BrJ3xzaI/HBLIafwg==
X-Received: by 2002:a17:903:2ecd:b0:265:57dc:977b with SMTP id d9443c01a7336-2902741e47dmr251353315ad.61.1760376996455;
        Mon, 13 Oct 2025 10:36:36 -0700 (PDT)
Received: from ?IPV6:2405:201:8000:a149:4670:c55c:fe13:754d? ([2405:201:8000:a149:4670:c55c:fe13:754d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f3c700sm140037515ad.103.2025.10.13.10.36.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 10:36:36 -0700 (PDT)
Message-ID: <56075d23-8bae-4a11-b5a5-9ed251fc7707@gmail.com>
Date: Mon, 13 Oct 2025 23:06:31 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib/xz: remove dead IA-64 (Itanium) support code
To: Lasse Collin <lasse.collin@tukaani.org>
Cc: skhan@linuxfoundation.org, khalid@kernel.org,
 david.hunter.linux@gmail.com, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev,
 Phillip Lougher <phillip@squashfs.org.uk>
References: <20251013115136.16773-1-spyjetfayed@gmail.com>
 <79cebb23-5232-49f1-a0ac-b401707c2b52@gmail.com>
 <20251013183800.7af293f5.lasse.collin@tukaani.org>
Content-Language: en-US
From: Ankan Biswas <spyjetfayed@gmail.com>
Autocrypt: addr=spyjetfayed@gmail.com; keydata=
 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
 TRpGew2ozniUMliyaLH9UH6/e9Us
In-Reply-To: <20251013183800.7af293f5.lasse.collin@tukaani.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/25 9:08 PM, Lasse Collin wrote:
> On 2025-10-13 Ankan Biswas wrote:
>> Support for the IA-64 (Itanium) architecture was removed in
>> commit cf8e8658100d ("arch: Remove Itanium (IA-64) architecture").
>>
>> This patch drops the IA-64 specific decompression code from
>> lib/xz, which was conditionally compiled with the now-obsolete
>> CONFIG_XZ_DEC_IA64 option.
> 
> The commit cf8e8658100d ("arch: Remove Itanium (IA-64) architecture")
> unconditionally disabled the IA-64 filter, which effectively dropped
> support for mounting Squashfs file systems that use XZ with the IA-64
> filter. I wasn't Cc'ed when it was committed because I wasn't in
> MAINTAINERS back then. If I had been, I might have commented that the
> commits [1] and [2] and the discussion [3] showed that keeping filters
> available for non-native archs can be desirable. But now that time has
> passed and no one has complained about the lack of IA-64 filter, it
> seems fine to remove it completely from Linux.
> 
> I won't remove the IA-64 filter from the upstream version of
> xz_dec_bcj.c, so this change will make those files diverge a little
> more. That's unfortunate, but they already differ by a tiny amount
> anyway.
> 
> xz_private.h line 106 checks if XZ_DEC_IA64 is defined. That line
> should be removed too. With that change:
> 
>      Acked-by: Lasse Collin <lasse.collin@tukaani.org>
> 
> [1] 5dc49c75a26b ("decompressors: make the default XZ_DEC_* config
>      match the selected architecture")
> [2] bf4d064d89ae ("lib/xz: enable all filters by default in Kconfig")
> [3] https://lore.kernel.org/lkml/20140228230017.GE14970@merlin.infradead.org/T/
>

Hi Lasse,

I have sent a v2 of the patch with the required changes.
Sorry about having to make your work a little more difficult.

And thanks for retaining support in the upstream for IA-64.


Regards,
Ankan Biswas


