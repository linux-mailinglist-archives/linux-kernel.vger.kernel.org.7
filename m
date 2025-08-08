Return-Path: <linux-kernel+bounces-760656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29720B1EE48
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 20:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBD627A4564
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 18:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FCC216E23;
	Fri,  8 Aug 2025 18:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0ud/DRI"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4421B1E7C18;
	Fri,  8 Aug 2025 18:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754677109; cv=none; b=gf15FYokEQN1UjWShcp3IVpeUYcyuzLCLkTsdkhg/aHNt+uW6abNkh5mT+R3DLm4yCqDMXAHGX3punYfy/8oYePrQEh8jVy8ic2n4zgaSRcHIwKEXE50NX2nXyo1DPwQIot8C/0KNFrWrfQk8mkaW6gGxdIqsEgYT/wrGka8UbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754677109; c=relaxed/simple;
	bh=ArOUiTIEqxs9S6T1L5MLv90yQBn6hawmKho6rJx2Qwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shSattq0qn4KYJlYPvTdl0dyF8nF3XRCfKU2+CH2L8GkLDjEwCr5LGcXfLRdVU+8HJdu173D9+1KrDLvDmGpeW4AUzgWibapLufiBB8vthxoOv8QUmlLg5JKyAZby6ov4I0pmSo3O3faYYPX6GvSdP8Whwzgxmdv1H7nIp0ISNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0ud/DRI; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2402bbb4bf3so29425745ad.2;
        Fri, 08 Aug 2025 11:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754677106; x=1755281906; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kFLfuaFEybAHsFHCBk/JWdW4OTRk7QE5kqrw1eDTxeM=;
        b=F0ud/DRI1Z84j20JRtQ8i9KF/E0FJo/DbffoeiYEm8ygEwlKfysb41fazYALEHB5Z1
         n8HeIddCAF6TOmk/zU3p5MXsl9Ra7IK+ADcLBMo1Ecxt+Em1HaOi79Qvcw4QIW+Gd86L
         mfYCgZALbpBb+y3fBZnAPF6pzs8CNxH5oSLBZFLug5ApQK82536I0/JVmg3wNVr2HTZL
         UK2GyxEvxBbxpx6etXta8b2Wnz9vmIV28eEgz1+467PKjuissCRqY669CuVQkJsSObZA
         Vy+w/soQ8nNm3/Oa8r4NI+FIx2oMmIQX90Hw0kH0ZIVHwm7gaedputHg0PFY0Gom4bSB
         eU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754677106; x=1755281906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kFLfuaFEybAHsFHCBk/JWdW4OTRk7QE5kqrw1eDTxeM=;
        b=MQFMcw9xqFwtrK8ItA/Gi7RAmUEiiJdARONDm02K/xsmt6LLdXni+kxtpr0uUq9bAK
         ACfFIEIsLnaPh2ivu2pKSe5QsewVUOcIGC8dHXD1/YKrDSgVTliaUfnmjXDEpjIzXVco
         t48R+sv0F4sdnZ7dH5EvkU2CRNZK8N8L0yxk2ycdtsAprYPDZyyZqSM3YNOP++vCppET
         fd2fceHDJnetzSUJpE8cVfIrMXmmogq/uqV502/pljJqi/4KgmLG33yqL60E2rDiwn/e
         U/bUCHcJYRXIvYrH41r333yBMj+JS6nXZ3N+sBG4D9+uqZlw/KNJzOUwJSzaQUdGSWPS
         lT7A==
X-Forwarded-Encrypted: i=1; AJvYcCVY0OCrzcjrinlyU+hW3usNOGiizO3MKF0dDDgBVFeXw+iRU3n1V5vA4qqQ4VKpCNGr4Cra59aA1kM/1g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDMqZOyhj7urxGwH8VyB8LmZvMNly84j8FRaT+eQZowkXE7t8K
	c99oNUF00PdvOCgFQ1mx5IuwbO9odTjvLaZ7Vu+tBrK+7UWdusQC1C6U
X-Gm-Gg: ASbGncvymDTaOG0kcoWtSFE0pzbQS++oBMbLTvmIkjYLYeWIxRUo9AOPOhpXTH0aZqk
	fIRSqhw/WrY7QHJh470zmeFZgV8NEZgNqwBaSx2UP00lguRCRBRh7EJAH5rpv0HsfnM2Vi1rHf3
	XB5mV8qKi0Gdrulmsw5zqM5nDXPERseQ1vSZje0IBURx5WkcF9XalOA8Qu0Eri02Pd3OrXrU5Hl
	QysHefygunGlQ8afYgm18AfcLz3zFsp7aTIKA862TrwuklXtpdIW6Gc+Ja4bwh1zT27LiyFPlDS
	jgQrIRomjkrwHuf9iYCRysJmk/9OB9ZUdAKsEVEbIYHJu8q23oV0QuCznCq7oxk26zljWHDFNii
	NYgVfs69jSEWMLnj/3XVC1bGwb70TxXoHGEw=
X-Google-Smtp-Source: AGHT+IGTY5Nj1ElL3ESL9jmIwV+I1va0395QkMsWxWEXqBuRTRvA1OwBz+wJIm0Wuv0/bDEBSX4Wpg==
X-Received: by 2002:a17:902:e5c7:b0:240:671c:6341 with SMTP id d9443c01a7336-242c21fe648mr66045945ad.26.1754677106380;
        Fri, 08 Aug 2025 11:18:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e897716bsm216551795ad.112.2025.08.08.11.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 11:18:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 8 Aug 2025 11:18:24 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Mark coretemp driver as orphaned
Message-ID: <52f77d72-adb6-4977-a5ad-d6e69945daa6@roeck-us.net>
References: <20250808173807.96D134EA@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808173807.96D134EA@davehans-spike.ostc.intel.com>

On Fri, Aug 08, 2025 at 10:38:07AM -0700, Dave Hansen wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> This maintainer's email no longer works. Remove it from MAINTAINERS.
> Also mark the driver as Orphaned for now.

Normally we would just remove maintainer entries is such cases, to let
driver maintenance revert to the subsystem. This is coming from Intel,
though, so I assume you explicitly want to mark the driver as orphaned.

Applied.

Thanks,
Guenter

> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> ---
> 
>  b/MAINTAINERS |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff -puN MAINTAINERS~MAINTAINERS-20250707-2 MAINTAINERS
> --- a/MAINTAINERS~MAINTAINERS-20250707-2	2025-08-08 10:36:09.028985285 -0700
> +++ b/MAINTAINERS	2025-08-08 10:36:09.043986599 -0700
> @@ -6281,9 +6281,8 @@ F:	tools/testing/selftests/cgroup/test_k
>  F:	tools/testing/selftests/cgroup/test_memcontrol.c
>  
>  CORETEMP HARDWARE MONITORING DRIVER
> -M:	Fenghua Yu <fenghua.yu@intel.com>
>  L:	linux-hwmon@vger.kernel.org
> -S:	Maintained
> +S:	Orphan
>  F:	Documentation/hwmon/coretemp.rst
>  F:	drivers/hwmon/coretemp.c
>  

