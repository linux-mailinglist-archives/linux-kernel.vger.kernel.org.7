Return-Path: <linux-kernel+bounces-778715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65767B2E940
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 02:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 470E35E025E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 00:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBF745945;
	Thu, 21 Aug 2025 00:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivm+uGi/"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCCFAD4B;
	Thu, 21 Aug 2025 00:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755734987; cv=none; b=jKTeDyzfSnpjKW+6m7sA0A5Qx/VuTTwpzc6iEMyVjAM4A7H0R7EppU2ICUI1iwwecit/MtJD5zQys0NGdtDn3XNezCZmujmMbiVIRbR11CsMBJjT3SluTM7aVM9k/UkOD7ATBzJG0EEikWGA5iEoPff460Sb9S0Kr8WT5YDmBV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755734987; c=relaxed/simple;
	bh=5MWxCZ0qc6AwSKQedW8ZW40MeONje69jiz/f4mdl/gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o9aSmhYPONFN7ABLQJP0jz84K6yxNemxSMSe6RrhHkhU65FBT3v53wTvvhPGlCP8+dkEfPDQtj+DtVyFSD+NNpNXpgYpJKIi4Hp58uYbhbw6vVqCXZ5oLl4toHqeSfwa3syMjYCGs22rmrs101oxaCcFeCbnPLoYdX2b7+Pfzc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivm+uGi/; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-324e7600bf0so520236a91.0;
        Wed, 20 Aug 2025 17:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755734985; x=1756339785; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zvo4n11xsXKrL+Uzn2HtUGy5ePlSr6edRrpH8cwiIHc=;
        b=ivm+uGi/RBFBPKQhZqiZC8VR51V4o8EFTH+e7jnyeFW2nUkAU90x9xWVIxZhs5dnEU
         EMVdXptxqyXDB2/yOjoKuHkvGrbbPnirY7ZUjPVvDvVJ8OjM1tkxBtEvsvrr1idtWZaL
         WnT/H7yU42/eC0HVF1mtkMsweI0XKKpy/19Xp13JbxzzUFtw1hHvK71lLzVotH8Yb5He
         6AN4DU92KBt2HwMD5pk6ZIJOlBSFqltAPiypsdGHqu4A+dqzaaScNcCzJkxw5zCsPDiU
         XgGYDrh9PHNlFn3sQBsmgqxJ3Gf+2hsuaSkgYav1NbbWvDPHi4wXyI83WX7PemXytn9k
         8XEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755734985; x=1756339785;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zvo4n11xsXKrL+Uzn2HtUGy5ePlSr6edRrpH8cwiIHc=;
        b=eNU+7gkgXDW7Hnh7JTzNApE+X18uPkpIQVKfN87vGvFLGCwZ9TsFP/+RbcLKqmwg8V
         +WCSTl9hktyvI9flixBzCLkaJgNC4/ZDUEXUGbeDfVsTZu+ryJJvsQbv/Spi30i1/SfI
         aOHrjyDUfu+J7l/db7cM5dZX04v5YOCrhNlgy2iIQM6/7uGn0qLoScFdzqeGSTBAaBrw
         +TE86kY50v8R+MHcXnP29Q5LHGAQnN+FdEBO8pf75VaGjBytTpHtnGzDUQsbDm6N315u
         Vt4wofgLOnM27joMVy1lu7BR7H83G2gEhfZDNBZL8Bzq/HPHn32miDdxo+30N2lk3HkD
         b4cg==
X-Forwarded-Encrypted: i=1; AJvYcCV5Xgc+az3m5fs8nBx5pkGdmzRL+GzPuTioMN8SPE520fImbbw4VzqUqVU/Xw9mWYFKAM1ix1DR9gBk9MK7@vger.kernel.org, AJvYcCXaQRzhz6yY1JmRa1d07Lib1ZVyHe3F35WQzgU43TzztIVNuJpgsTKhxWBzG5m1CarkdkfC9GpAO4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnTr1oN5DJmI5/St52vVE4QQ+JTS13L4UFw6IATI1acdM00UUQ
	ykxsjCpLnqCRvuHvWWfhVpYqOLetWTjuYsqEJjOtRnqc3r8lprGezATl
X-Gm-Gg: ASbGncszUfFMCS/jvwhsWnSUv+96Fn1A3qVpi59UrJhSVgX6Pn3/FASHVyFw+d3WzJf
	aoUehF44XMjHx5rPYUSqOqbeuBNk/9pYOI1/Sssy1WP+IygQEQrSJjpCKMIniba5mEc3y8cy7yQ
	5ZIwR9YwXXsPCxf8P5ef/XC0WnOY5U3cEbaXCI00xkdfgllGBbevlWY/zwItgd+dzJjQPes60T1
	idWtl32NiAWz9ajokRjizbh6+L6uIgHYnPoifrE3TtWVUsSjPrnUmCwQr2FtrifrgtLAEhmtVV+
	VJDzZ7eXrYd9kHH0gEMYF6rJI6+56mIT9u58hz55ZjdGFWr7BaOjCrG2MDzfSVWaTIECQMLuuOH
	jTy/YcgqYGvk5vKM8ony6zcvOqqMC7tQ6ay9qwcA3zoXGv1hV234l7/xR8NpxZIHPbYpo
X-Google-Smtp-Source: AGHT+IFnSykHuWR8Y1fETrEFqFcMDCOiKWU+B7Jgndk2MICynfpNHTD1olf/T/gNMAmVns4hdNRyxA==
X-Received: by 2002:a17:90b:3bcd:b0:312:e279:9ccf with SMTP id 98e67ed59e1d1-324ed07ee74mr846498a91.5.1755734984777;
        Wed, 20 Aug 2025 17:09:44 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324f2bda028sm166645a91.19.2025.08.20.17.09.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 17:09:44 -0700 (PDT)
Message-ID: <5fb6ce64-747b-46e4-b135-0d987334a12c@gmail.com>
Date: Thu, 21 Aug 2025 09:09:41 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] Fix PDF doc builds on major distros
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <20250817154544.78d61029@foz.lan>
 <b6d18aa7-de85-4fd2-8456-c2f6342f1b06@gmail.com>
 <87y0rg7e35.fsf@trenco.lwn.net>
 <16b48826-6634-4ec9-86a0-7ddb59ce3bed@gmail.com>
 <20250819030239.41a2e97f@foz.lan>
 <142b209d-613a-4659-a0f7-27efa8c6be85@gmail.com>
 <20250819153200.3c2b2ff6@foz.lan>
 <08c3a7eb-0425-4709-a3ea-6d1d726fd3c8@gmail.com>
 <20250820091530.068c4b62@foz.lan>
 <3990f1c5-2108-44fe-913f-97ae3bb1ff42@gmail.com>
 <xik6a2kb3mge5xh2mbdtc4p3ikbr4mnjlkk4ujc4sfztb3iqnr@tc76jva4smpm>
 <526d1aee-d401-4f04-8ddc-122f1fef7905@gmail.com>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <526d1aee-d401-4f04-8ddc-122f1fef7905@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Let me do a quick follow up.
I messed up the table.

On Thu, 21 Aug 2025 08:53:04 +0900, Akira Yokosawa wrote:
> Hi,
> 
> Commenting on your observation quoted below.
> 
> On Wed, 20 Aug 2025 18:48:10 +0200, Mauro Carvalho Chehab wrote:
> [...]
> 
>> If you want a more comprehensive answer:
>>
>> LaTeX is highly dependent lots of packages, including fonts. The
>> reason why you can't reproduce the font issues with Docker
>> (I wasn't able to reproduce with Docker here as well) is
>> probably due to either packaging differences between the
>> two containers, due to different environment technologies
>> or even due to the way Docker and LXC handles OS virtualization.
>>
> 
> I'm not saying there is no difference between Docker and LXC.
> 
> Can you fill in ???? cells in the table below ?
I mean                                          with this series applied

> Docker column is my observation of "FROM ubuntu:plucky" podman runs.
> 
>  "make SPHINXDIRS=gpu pdfdocs" under Ubuntu Plucky
> 

I meant:

     --------------- --------- ----------
     SVG --> PDF     Docker    LXC
     --------------- --------- ----------
     imagemagick     FAIL      ????
     inkscape        SUCCESS   ????
     imagemagick [*] FAIL      ????
     --------------- --------- ----------

>     --------------- --------- ----------
>     SVG --> PDF     Docker    LXC
>     --------------- --------- ----------
>     imagemagick     FAIL      FAIL
>     inkscape        SUCCESS   ????
>     imagemagick [*] FAIL      ????
>     --------------- --------- ----------
> 
> [*] after installing both inkscape and imagemagick, remove inkscape
>     with all its dependencies kept.
> 
> Do you see any difference between Docker and LXC columns in the table?
> I'm all ears.
> 
> Regards,
> Akira
> 


