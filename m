Return-Path: <linux-kernel+bounces-788609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DBBB38739
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 18:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D96024616BE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E031330BB80;
	Wed, 27 Aug 2025 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ql9NY+1r"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB1F307ACD;
	Wed, 27 Aug 2025 16:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756310430; cv=none; b=WMwERM1omZwG0v2Mj+lBq0qhT4EToZHe8+OKfvGsXbvB6xwwSQFULSfeAwluDNEh8YcXSuaWcsLZAE99gJZCGDrxhcdmSeWfaoENSMQFwBkYNsAIRwTCum6DJgRyC/u0v00XhXg/n4L6gl9R7/SmzR+SZiKcke9l2yg0Q3on5q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756310430; c=relaxed/simple;
	bh=5r476QMUTx3iKVF4BmVQx1be6z2MX0MNrxF6wHUQJHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hnEt0HXu+LZg0vO6ysUyIqCRkg34fVbkF+3qePQ1yC4XNI1pLTEG3ncsuP/dkwwvGh5RsCyrdg/RWhpq2OKed8enKmIHwZMiKFcNZPD26C/q5Y9TYymbl+BSi4a4YAIsg2S77/KPiwLqrmX547Lu+Z+FgOKFRPjhPAuZ4fV/By0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ql9NY+1r; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2445806df50so54906295ad.1;
        Wed, 27 Aug 2025 09:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756310428; x=1756915228; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lqLQY71E8I3ZKdEgscFFUwxTNKe9h7lOzan3Lxwg46k=;
        b=Ql9NY+1r4OmMclGSZp9qIVywDhF7d42J+azL3EZ4+x8oXdwLxaKNnwmYJss4yp2kco
         qck2QweKp4de/iNbGXsNGu09jQShWno7QtUERzK6C62e72h3bk743iUxlj4r4WQEwQF4
         Of0Oj7pDAgaQGVG/vuU6P5BQ40UzdCu7tOO4RJg44gDbgSz3duC1UPM8d9hs4HSSL9Xp
         j2s0MMMyG+DVLLcxPV/UOd49HSnz0qKN5HOrjrCW+zoCDPkntoJfom2jVYIf0nguacjj
         7yy7NBk92SGARmUAOo79bNm1pM5krLlX/k0Wz4EnLn5amTTd5R+uRoKt1L34VHG8LeqX
         cwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756310428; x=1756915228;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lqLQY71E8I3ZKdEgscFFUwxTNKe9h7lOzan3Lxwg46k=;
        b=sxS4yIiDpOPtYo0xHOhiMmiSA3bgYeCgGOuaESJv1otSKk71/Y+9zU7eyfSih6Drep
         Z+6uCzlxb5fH0WtR5JSZYDF2dzIy8Rosal/YVkMNYMdwIgM1pk0qhebV3vyQ5IEzkLuT
         /IBYGQJ1yO55dnE/V+7KBWlFkYQDcHJ/zFnLtGPfVFFpwzBfjYU4xggB4bgzV0oUCI43
         ry3VdQ9zzaflFdiz61i/CtqMw5kd5/SW5NiQMz0XwQNsqXSWvMFMeyBu8WDN7QQ/IQdV
         ry/EL8wDTQcqaXcNVTP3uJcp5RZ2a2nvjbysZIZiA2aoYNB15DgZjI37lYiXoW4ryats
         cKtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUko5lm24PyNQHc1EhTjVaTdtFKbX5FgR2q7+N8nMrq0wSMUpInMShSkUi5FRyo4pY+ydzIhuv7Xrf12EM3@vger.kernel.org, AJvYcCWQnvObFLCnleue/HE4hbkYssKyCkaWjvpJNsDK/XMuZ7oCBAMC0B+OAUjIEeU6/Gyv5Aa+uC/2PfA=@vger.kernel.org, AJvYcCXSRalwBqJ3yTVkd6V9m6E988mMN+s49xtvPLPr+xpq0y0wyn1eNmHGRdQp9SfomqG9d6j+70uuYQaKc/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPAjl7Bl9NCWems5GiyxeqfVdpTPEDu/4yMMWdZCGfOp/KAh/a
	e941LxKY8Y0LHTAUDcsm+k44ddyosyKhWZHplJGpauGTUYV+he32Kwz0
X-Gm-Gg: ASbGncvoPY3flAPnft49dcDa/PUL74/Q18f9o2hdqkV2wgLl0OZdaGQMOTPEoPe3LWN
	8Mjd44eWMDeRV+e4a30lYOPAWmi+p3HD6Dz7y5aXc6ndJejdnL/nLUDdNsUL43TekjZ5ozkIoxi
	wLVErbFWvguQYtf2nHxHKujPyC9auaHdldvQPCN9gpuTkcjzd+GHqkUKQRdSOmCvZbwbNIeeqxR
	u/s6XJpx/4AJNu04prNI/bRJyspYtrvmOCtkIrwv7/MBID5qCgAT0yLADVK0GRA+CR+1QCJPXsg
	oxSzfn4UP6ID3iZ4QdFd021BhzubyipUF+pwvfcDphdHPPG9pqQ7rvJL3bZ3s0h7jnwDk7lzNVz
	XrffbpPIhcvY2+hzHPTsVN5WRnnosM7jvnQU=
X-Google-Smtp-Source: AGHT+IFQz/HXmGEMAbpydvcRmEbPZ5kPQiz5oyNqxBt9FDFmtWDr2HxANuX2KR6mhMGolifQMhrpDg==
X-Received: by 2002:a17:902:f78f:b0:246:d383:3951 with SMTP id d9443c01a7336-246d3833b72mr154843215ad.15.1756310427975;
        Wed, 27 Aug 2025 09:00:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-248c97f2f96sm2609385ad.121.2025.08.27.09.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 09:00:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 27 Aug 2025 09:00:25 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Debanil Chowdhury <kerneldev@debanilchowdhury.com>
Cc: ninad@linux.ibm.com, corbet@lwn.net, jdelvare@suse.com,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] hwmon: crps: Fix typos in crps.rst documentation
Message-ID: <aef9db31-5504-49b5-8b0f-e776c27a5b17@roeck-us.net>
References: <20250822132836.5384-1-kerneldev@debanilchowdhury.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250822132836.5384-1-kerneldev@debanilchowdhury.com>

On Fri, Aug 22, 2025 at 06:55:02PM +0530, Debanil Chowdhury wrote:
> Changed a misspelling in crps.rst documentation:
> "Critial" → "Critical".
> 
> Reported-by: codespell

$ scripts/checkpatch.pl index.html
ERROR: Unrecognized email address: 'codespell'
#124:
Reported-by: codespell

WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report

Guenter

