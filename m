Return-Path: <linux-kernel+bounces-780268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FCCB2FFA3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D38A41CC1374
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B858C27FD71;
	Thu, 21 Aug 2025 16:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNDT6cSb"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC4F27BF7C;
	Thu, 21 Aug 2025 16:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755792114; cv=none; b=ZTeo27U8mRIq4QiaEhx6BwlF+5An3SjcXt97hJJUSts7wQILz/bVuk4eGm7LJgWz9FNQYBUOOA6antj3FOOsqKd4xCOhAWREemaKvFY2TXbNcm2jgvyna8T5p8SA/J9jXHu1hyFGK3LD2A00AM1CCi0NVfqY1D+RBuf2TmUrMu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755792114; c=relaxed/simple;
	bh=Sb2tmvyhA9kl4RDm1IjcNLqVSOU59BKXqAaqUHmoj7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fa5l576KXcSAxwkKm1V071shP0qHtrcRQtcTXBEfFfj0FhaM7JOYwtZIZbXQrwLADDaQcYkAMDkT1JqmjfskfvXRfHoV6CLv/vjABrZkJ8cfbaUXwXydHOTU4lgyFKC26GtjHCl2k/lMzDNBEWbO81qCwmumpLFFIAgAmtaFR54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNDT6cSb; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e2eb6ce24so1054061b3a.3;
        Thu, 21 Aug 2025 09:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755792111; x=1756396911; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zzsiqmbfqBkVY+f01p1NV6V6NJGQ87QW0Z5a0oYFHFU=;
        b=nNDT6cSb0HsTCeGho5RmnuPfCUanyNKgNH2U6DsfKxDNLW0G+sWJtqoCUg4Nuh8oO1
         TdWNFdh0+IvwWbc+QsThEMBzowXQrhmkubrDIzNctWF+h7ZZ6qOxltN2VCogeujVabzK
         QbwsGF0qLD5WAkdJtuezFDnTXR0NIoEgC66KCd/DmxBv6OXoFJdXE19xbrgiH8X21zEq
         RPnaK1gpjc7KcLKzd/MIV4mOv3NvPzMJIfBn80IZlAaSsFmb1g4FAN5bwOFGK9RZ8pxS
         yHdmBtfhgVGK4IGfcktsQsPoHKpS0BxEtt/XTKPr3BLf3iiEkjWSy8UP6A8WIx+6ux9w
         YTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755792111; x=1756396911;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zzsiqmbfqBkVY+f01p1NV6V6NJGQ87QW0Z5a0oYFHFU=;
        b=eqXv4WwvCMwqBaQJlBMGK1uBuKlS/XDPBc5xp6Y48Y/Fw9KZJxogzW6o9GAyB8Ycj2
         b/749ZS2Fu0tKfzLe3huNJFJCREky4sh2H1dpSn21RX88rVLc4V2kNx/C5Qn8a5nhTLC
         KZqKT3TfX16zUXbEvk5ox7MdUYF1MVYXMgahW2J+bJE576HFw1IOz+mA8V4yx0gnxY70
         778xaoO5fbYkjGDw7Wn8GzWE0uatJWPFjdqGDAQsWrMLeM3/CMAkyPRnGMm1AURaXFe+
         0deDabRR/XnFamJcUw+xCWZ3fYk932h6c4XqxI8uWxS3Sw5G4vFRVcf7lNWhT1TjNWNh
         If8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzzcs9AfuaDOvYrRhiJL4aBr20+m8RZyDddAFGwe7aKGrToBb6z3JISgIUK1FmdtzJMz7Pygema/E=@vger.kernel.org, AJvYcCVG7IIS4hRmwODbq/MCWcV7SVYbTACeqV5vVuSRo7t21WkneSun8xsI9Tl5/L+6c0j5XukZqT/aTCMl3FFT@vger.kernel.org, AJvYcCVaLieDQkL2156GdK4KUgxHIENKYChUzAsVwGeIjbXneenHwVXA5Mg5bVB6Z3AAPVMJV397KUWkW2bgHoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVHRdG18P4gg7G3FfQhbwBB0n9ZMp9V9MO4H9oF+jzNV4ElgXv
	SSSIe9M1RfJBpy+2JsuF+YmqwwvOGso0TRwMoLbIxDKX/DN3CQeRKgAH
X-Gm-Gg: ASbGncv8nYBEWnfB7yo5XfjUJIU6927bDAQWYUT7xKzur1cZqUL7qFmF7ZUOVaQHehB
	05AKdC9xQxRjNV/N6QrXvAsnMFvOwhazDUJVnQEjCicSB6sCoRi1cIueu6CqQ/WvtZh4HRL9xjy
	fwFKk2dbDr46G5nOP6nbVrfVXjN87EevV5/AP3C88DaccnVb2+1KBVZoE8CG1oA82GmcEQfT6hO
	LzJgRQ7QaRsaZRVo4TLgVvxcsj80j6ZiYgbcO610p8fcgunmh/g59lPnLz3veJF3eS6frHCGnBs
	ytRbBG3VTI7k3M8WZBP/T+y5eRgW4hIptmxN+bwYlU8oDOCyEtDtjDnElE9NmBvwGOyCfSt9tlE
	0yeFk8DJ/NwSy8PhiYus8kPkTCTyz0ADzFq0GbrxxmuAytTN1uy5E8iFv
X-Google-Smtp-Source: AGHT+IE6uLjtZA+NsA4etmBGRhXqOtbKJrOEJL92MfF6Uthlu2MOjaGFDFnyQtI4j943jND6fmZtZw==
X-Received: by 2002:aa7:8888:0:b0:76e:885a:c3ef with SMTP id d2e1a72fcca58-76ea325e544mr3700074b3a.27.1755792111050;
        Thu, 21 Aug 2025 09:01:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d0d14efsm8849369b3a.2.2025.08.21.09.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 09:01:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 21 Aug 2025 09:01:49 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Debanil Chowdhury <kerneldev@debanilchowdhury.com>
Cc: skhan@linuxfoundation.org, jdelvare@suse.com, corbet@lwn.net,
	linux-kernel-mentees@lists.linux.dev, ninad@linux.ibm.com,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Fix typos in hwmon docs
Message-ID: <bcfd4b37-599b-4797-b3a3-6c4ae34ebaf7@roeck-us.net>
References: <20250821125539.58313-1-kerneldev@debanilchowdhury.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250821125539.58313-1-kerneldev@debanilchowdhury.com>

On Thu, Aug 21, 2025 at 06:20:24PM +0530, Debanil Chowdhury wrote:
> Fixed some typos ("Critial" → "Critical") in hwmon documentation.
> 
> Reported-by: codespell
> Signed-off-by: Debanil Chowdhury <kerneldev@debanilchowdhury.com>
> ---
> changed in v2:
> - In previous patch "From" header did not have my name in it. Fixed
>   that.

The real problem is that the subject does not identify which documentation
is being fixed. It does not fix problems in "hwmon documentation", it
fixes a misspelling in the crps driver documentation. And responding to
this -and having to look at multiple versions of a spelling fix - prevents
me from reviewing patches which solve _real_ problems.

> 
>  Documentation/hwmon/crps.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/hwmon/crps.rst b/Documentation/hwmon/crps.rst
> index 87380b496..d42ea59d2 100644
> --- a/Documentation/hwmon/crps.rst
> +++ b/Documentation/hwmon/crps.rst
> @@ -43,7 +43,7 @@ curr1_label		"iin"
>  curr1_input		Measured input current
>  curr1_max		Maximum input current
>  curr1_max_alarm		Input maximum current high alarm
> -curr1_crit		Critial high input current
> +curr1_crit		Critical high input current
>  curr1_crit_alarm	Input critical current high alarm
>  curr1_rated_max		Maximum rated input current
>  
> @@ -51,7 +51,7 @@ curr2_label		"iout1"
>  curr2_input		Measured output current
>  curr2_max		Maximum output current
>  curr2_max_alarm		Output maximum current high alarm
> -curr2_crit		Critial high output current
> +curr2_crit		Critical high output current
>  curr2_crit_alarm	Output critical current high alarm
>  curr2_rated_max		Maximum rated output current
>  
> -- 
> 2.49.1
> 

