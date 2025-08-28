Return-Path: <linux-kernel+bounces-790484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25711B3A832
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 19:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6FEB17759D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 17:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C113375BC;
	Thu, 28 Aug 2025 17:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksKFejb7"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8989C2C11C3
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 17:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756402499; cv=none; b=Owtn45PzAOh/rUJAp3iMcI8jrh0lbgpj/VCumGaX3RKq9Jo8NsmnXhv8UOgIjeouuGOX3QFbYr+24yvbbEK6cCpnsddtZ6X3JtawJMkvag5m5zKFGOGPzJAeXOHXbFEB512wkWPcSVWqeSwNecwpMfRBJBxytS3bgKfncX4mV4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756402499; c=relaxed/simple;
	bh=RxxlhMbqCVmPQF6CYm26h7MTGndso2Yj3/19qfKfhWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9xlRGvFki92JpPeOSXpsSvu2oc+0v3+J4Juf8Tqvj43V4lYC+UzGKi3T7eI5IZMc23JZCnmoCrwrxX3bmSmeOsbNqPTw/ND+BbpeieUn+F5YUraW3APovI81Zi9b+a9pxbO97ejSywCmrvapIWPQLjKU+FYfpwt5Ay44W4AjLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksKFejb7; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b471737b347so851197a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 10:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756402497; x=1757007297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7jzooyrGq8Q3hC400QB92gKo32hfa5e5bnW66dvTn2g=;
        b=ksKFejb7OQ66QTgRDdO+y8LwgfPRMC3EUf8VdqdWWkbaA00iAD4EQZ5YR0AFd+9yz/
         H397tv8pykeznesu7vrDXQUBM6tiQFsdPQJP8LnMn1kEROK3dYDnnMSgFbYwnndo9gpZ
         NqxpypjmqAmXzuU0i+Dj3g3AiO0+q4zdLtylT0o8EfJjGON5oAxkDrYDBLY++wfl5jCi
         zfOzdbUKNzTwEqI3gYChl5IP5uWKGvCxCtesJD8ABfZ9SnWBxctIefXF82KcIhDDjNRM
         nIJZ6Pmtj88QgyoekcBUq4QOFyzQ9SbfcUObDo96aMfkSCoDHYFyiGqPMB+1YIPqrBz7
         eFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756402497; x=1757007297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7jzooyrGq8Q3hC400QB92gKo32hfa5e5bnW66dvTn2g=;
        b=S0AIoYfrGzw4+LCcJe4beRDKkA2yP/qFL2aqLhaZlnuC+K9jDyuo+xI307+6VcaXJD
         uGN2XlLu2O61oNsaF4RrIio/Iehg44CNlNFtDr1G2HKNmdNGCdB71B7Ukfwf8Tjry8Mj
         fTZ1J7XqTUwvRvuyxPogs+QlWGpeccDQBfZMRG3LSK3fngEVjNFEav5aDzA+bppxWkdU
         tjJDXRfqHxltjzHFjUeES/BrI6tYIBB/3Rp6tJ8pBUJ5HdnN8CYyBDJT8GVGgK5jDyGe
         LLtZIzlYuiR/pYGN6uUYKoKTA/lvTzihkVw4qtTypdc9JAES1KD+67tXepT91Th9U+Xn
         CUWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtv3l7C/d7pOsZMv4yMksUwLBpeRQMx1/DCvu+pbeXIWfHVsJ6h1vrJo0oZ52YHpsWTHyo5gpZk4cNvM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzipwXWSYf/w3Pu0puvobgml9mk2n0dwZlrw+e1Cwgb9qc0iE6z
	Kr0o6pFMUzU04+pESNzfYLT7TkIksV8zW7aHo4F7iSdF5kbNepeoiw1VXxq7Cs5/
X-Gm-Gg: ASbGncv+sxR1mS+QxONkLJzK0UaD+5y5YV3rMjpwFEnB4U0ostiKt1FP1TW9t5w49Hj
	eFA2kvOklLDZG9Vf1Z7nNqiw68cy9gLU8eH3hYwPOsyK4tYEBPsGDWXUbdSeJvTYfykurUP+EBH
	CiWkZayCCz7X6olipTk0YBLa9uRA4udazWZOEfBjsd2WSIM1EHM8IepIs0/eDTj8YXLGEwsx2Mw
	qai9XhjwJMeQxafT/jKyvDNeqq7vOnTUX0665azaFkxjSRYHdorDuX5R/kenu2NkR3rgOP52DSs
	4oWKjP9SixRPHzjSaLbjnTUvT7V6JBTDvsCl9W9wsju+RJkJVMiusVfGuzmUeuvv11uHP/0OpmW
	tNhomIzRl3qV7cTZWUj/6wJf7YwvCk/SExNT4Jid21HKMxvYAFUItLJHZ2MCu
X-Google-Smtp-Source: AGHT+IE2v1cjhr0Ge2Fn9olB5eNVoxLu+9Ss29SSkjw0+8RfmtmyA76nfioBQOp5HCk1PrQBcf3ihg==
X-Received: by 2002:a17:902:c951:b0:248:b2a1:46a2 with SMTP id d9443c01a7336-248b2a14871mr83029145ad.2.1756402496571;
        Thu, 28 Aug 2025 10:34:56 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249037021f8sm1295225ad.16.2025.08.28.10.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 10:34:56 -0700 (PDT)
Date: Fri, 29 Aug 2025 01:34:53 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Guan-Chun Wu <409411716@gms.tku.edu.tw>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] btree: simplify merge logic by using btree_last()
 return value
Message-ID: <aLCTPVUQwr+Sc7Wz@visitorckw-System-Product-Name>
References: <20250826161741.686704-1-409411716@gms.tku.edu.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826161741.686704-1-409411716@gms.tku.edu.tw>

Hi Guan-Chun,

On Wed, Aug 27, 2025 at 12:17:41AM +0800, Guan-Chun Wu wrote:
> Previously btree_merge() called btree_last() only to test existence,
> then performed an extra btree_lookup() to fetch the value. This patch
> changes it to directly use the value returned by btree_last(), avoiding
> redundant lookups and simplifying the merge loop.
> 
> v2:
>  - Update subject to clarify this is a simplification, not a bug fix

For future reference, please put version-to-version changelogs
(e.g. v1 -> v2 notes) between --- and the diffstat. [1] That way they
are not recorded in the permanent commit message but still visible
during review.

[1]: https://www.kernel.org/doc/html/v6.12/process/submitting-patches.html#the-canonical-patch-format

Regards,
Kuan-Wei

> 
> Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> ---
>  lib/btree.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/btree.c b/lib/btree.c
> index bb81d3393ac5..9c80c0c7bba8 100644
> --- a/lib/btree.c
> +++ b/lib/btree.c
> @@ -653,9 +653,9 @@ int btree_merge(struct btree_head *target, struct btree_head *victim,
>  	 * walks to remove a single object from the victim.
>  	 */
>  	for (;;) {
> -		if (!btree_last(victim, geo, key))
> +		val = btree_last(victim, geo, key);
> +		if (!val)
>  			break;
> -		val = btree_lookup(victim, geo, key);
>  		err = btree_insert(target, geo, key, val, gfp);
>  		if (err)
>  			return err;
> -- 
> 2.34.1
> 
> 

