Return-Path: <linux-kernel+bounces-790773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4ECB3ACD6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 23:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD2AF5679D6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078E62C08A8;
	Thu, 28 Aug 2025 21:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/vkktAM"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B109D233149;
	Thu, 28 Aug 2025 21:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756417360; cv=none; b=sq6LP4Mi/KceWwLCj1vYr+41H9M3oQObaeE01NXCEe20BupYmQU/8OIstGi2+bFLZeYH4m2uh6Nnlio+FqwoBr3gdAU/I05/K3UvAAyGHuT7pn5eKdsuLmGHORdhInFJHRh7+YKzCYiGMmc3pxvWagV36qvB+bBw/ugG5yrB8TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756417360; c=relaxed/simple;
	bh=xjr5vpGJs1J/e7rC+/meiCErZfsT4MdioSkHrPuOXCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvdyorkTrxAPuBR8LqZUyG6U+3j/BBhiV5C3GSSvJ7pDyx3Bsi8SXtRleZSjz1bge228HREZMm+Rvf/9gUgJ81iQqP6kqnYrZtzvF1DkHpN+4oergZzg1mLiGCIwlIXLZ4yHpAcHaW4PFteE5KWtjEEXpP7vcCyhI0YPHI3eyqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/vkktAM; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-770593ba164so1247952b3a.3;
        Thu, 28 Aug 2025 14:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756417358; x=1757022158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UH9yk2TefOta60JYDpWqpgDhndjOgYlNivFhyfwD81I=;
        b=S/vkktAMBHQZsU/e1jhtjlvTwOInpCsTLoOoxcCOnRnVVjcJYoKnxEarC39aVLZT/N
         EQMMe7TOwjwalQErbS2P6tZt/SY/+6Ys0PfeoMdGPj1eZYgnvYKYdPqOyzQOYgy7XWJ6
         26NDb9smkpDcDFD1UBtK0ykVJeD2TEwQVSkn6Piq6ozkyDr5sBX41BT1UK5uV85FNnfj
         KcRZpaaqa59ejsm2vn75HzbP+sbEBEPdNFBfdNpu3zo8wNWoy8xMIEeLlyp4wrkEMFbJ
         uVouSfQg4OxJs83aPgcf7nwQYkKvAptOsNNAqyt++swuMdJW8QlXGmhJhsFueYGtSxL4
         sYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756417358; x=1757022158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UH9yk2TefOta60JYDpWqpgDhndjOgYlNivFhyfwD81I=;
        b=bgbMlDcySsllOKe913COrs5KFG//QUlB1bG4ONf5sS5iUV90+15ZwcnRJxAUvG/+Sn
         Z4tevBcEBn0goJQE4YT4AFFm2sEQ9GucU0x2xQITSIlKXzJqIm+RyoiTqb1pwVTrr+QO
         u5m8Qk83pnGbGBpjYJD9uMuf8gLDU6MGBsAxEF1jK/xQGkCxNpjq7KVjMAyS22hrzyoK
         VYuFvJpX3TKQsbQawLaN2hnjpMsIZyacCKl7QxzWISYxUJ18Z9TrlYgDPu/IMUUMGL+C
         efr5INkSrcecU0GHz7wkhSCfYmrF54kaMJP87cZL4TwX1yGwtGUAmcCi43cFXXrLu4W5
         V/iw==
X-Forwarded-Encrypted: i=1; AJvYcCUTcWRPTPtl5lzz5rNe5ZGBtUaHQ1xnLFdaLdL4Jwf025n0qH+CaIldG6QbvdG2W2bRLxPCEqwcbGKcBA==@vger.kernel.org, AJvYcCWM29rnZuzqhRwrqWVpV39A2uieAkP4ks+kCzx6+9SCFjqEX09gQ4hC0nepEkxRWN+juXOd3JXvft0HqbJk@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg7deuYNkiylgLlRY3PA3/e7SWMpDWJDCLUMRjQZrPb0X7VTFz
	KvdsPtNCpa/0aAQA3OYLVbmFn+W8mYxQY33QUO1nxZYBHrEx3wKCgoz1
X-Gm-Gg: ASbGnctN2zb/UqNKfNt1eF3XiE1tS6WR+2BpudptlwRhVYEr6edJMYS4nmOjiJWBP5c
	YDXdiI5WAR+ohS7DJjmdDe7alhbLodU5rgwvVVF3TAyXLn72StrsHEUNZmzByJpEyQ6lxTy5qzk
	u8nMxbWSRB6FXwEZZG0bFWb0Vbqe3wyG54dSFbtDisYfgAaSQUndmlaYqdfZVJtFQv3Y68E40+R
	LJbQsFEgAbI7PjXY4THo9KA2VmnMeQjwlZWRl4ROgJfjUw9qREBAv154i1dxX5X9YEB1ynbuMVg
	AlC0t3NyUsi2YB3LGYd8u/FyfrXm8UrMlcLrMQqtBO1sUazVIgoagqrpmel2dgkIfJ8aLJJA0xc
	tRiu93giwZCPtVGFvI9+6X4qZxppktIzSoMo=
X-Google-Smtp-Source: AGHT+IFbmPeOe2DEWj5n1YBIu2SCDkJ5FxtzV5CUXT9pOd/gpNsxXld2ouUQ9eJ48pUXXbLHarUVQw==
X-Received: by 2002:a05:6a20:3943:b0:243:a4de:d9a with SMTP id adf61e73a8af0-243a4de1259mr8475947637.44.1756417357923;
        Thu, 28 Aug 2025 14:42:37 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276fcd48cesm6119880a91.19.2025.08.28.14.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 14:42:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 28 Aug 2025 14:42:36 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, linux-hwmon@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] hwmon: (coretemp) Replace x86_model checks with VFM
 ones
Message-ID: <9f1fbf32-fd37-420c-82bc-a43e6d5ef57a@roeck-us.net>
References: <20250828201729.1145420-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828201729.1145420-1-sohil.mehta@intel.com>

On Thu, Aug 28, 2025 at 01:17:29PM -0700, Sohil Mehta wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> Intel CPUs have been using Family 6 for a while. The Family-model checks
> in the coretemp driver implicitly assume Family 6. With the upcoming
> Family 18 and 19 models, some of these checks fall apart.
> 
> While reading the temperature target MSR, cpu_has_tjmax() performs model
> checks only to determine if a device warning should be printed. Instead
> of expanding the checks, get rid of the function and print the warning
> once unconditionally if the MSR read fails. The checks aren't worth
> preventing a single line warning to dmesg.
> 
> Update the rest of the x86_model checks with VFM ones to make them more
> robust. This automatically covers the upcoming Family 18 and 19 as well
> as any future extended families.
> 
> Add a code comment to reflect that none of the CPUs in Family 5 or
> Family 15 set X86_FEATURE_DTHERM. The VFM checks do not impact these
> CPUs since the driver does not load on them.
> 
> Missing-signoff: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>

Checkpatch really doesn't like that:

ERROR: Missing Signed-off-by: line by nominal patch author 'Dave Hansen <dave.hansen@linux.intel.com>'

Never mind, applied anyway.

Guenter

