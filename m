Return-Path: <linux-kernel+bounces-757874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3D7B1C7BD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 16:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29B8D621DEF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86D528D8EF;
	Wed,  6 Aug 2025 14:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GWVUKym0"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744A026A0D5
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 14:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754491151; cv=none; b=E8hYXu+LswHmqtcy7zIhXhVjr/pmdh/kNGA/v8nVncLIGp4VCp6/yFJTljAw3rrxyjFif8V9nTY/D0H/UoDFotXk7KECj5WOq7Oz5WZxAJsYUvuI3qCvYyuIDLEvlMin0NKb1dUioqTFL6svm6lzHlnCepupcEHRdoStJRVlWis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754491151; c=relaxed/simple;
	bh=YJ6mdEgeBoXcjvgJA/CR/fmtrg1zaUe1je1DWvu5qcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFfnmjuMoevadi6nyPOdAw3puvzMMBpc0XOODpovOH2lBTqim0KHWURUULsH3vZjLigjStdquc8jbJvb2nooV+e3jNqpkh8WZ9hROWZq44QZpbIHgV32gSHr07V4pOau2ErFFRvsVb1XSpZwRge6ELRjBP2fozcUgNvOpNMUZw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GWVUKym0; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b7892609a5so4537001f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 07:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754491148; x=1755095948; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t3HkDKyjugPotQJhu78AmOt2Qiqge9F0DpeQ381Qjek=;
        b=GWVUKym0fCODMVtov2Htiy382ptU09zcLmRrnQzQZng39OCVTQad3dv8dta3vohayf
         ch06WjgG+bm88zVBmGc0XuWVH9HU45ht1Gz00tV0XtGcA8YsjnE5rZwrInXI9CLqv/VW
         vx3C9olGUNxjq7Mnyoyv7m+nGalu2hx+0PkLjhB/SVxG7YD7Jb0tv7dDEhak7f+lwsNs
         +ohH+xBal9kRVFOFkt4FYFwKzOy2a4t7RikGnlyUrZ1mTxGvNBY3CNJkPuedQlGA2DE2
         2p0jt2RkHO8N52ey+BUApiuXncZ3jFu4nz3C4HTkIblcSrVUh4BO1c3Yd+5Z20NHfqR8
         0DRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754491148; x=1755095948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3HkDKyjugPotQJhu78AmOt2Qiqge9F0DpeQ381Qjek=;
        b=YDPtfKRY/qvpatCrru5gT2lwOCXc82ZOB28eKPlx3w+RpBhGbTShcyr2geaqhjIrIL
         m048zc/MeCtc0cKLoxooKG1vdCDMbiJsF44iMS0nhb5wn5VYjKuw4bBkC5fEqnCPO4nP
         iqdau5QUuhaQDPbETkdMALf2BDQWKWav5/Wo8mheftT4m/6DvXv+9Ik5nNSoTFLZ5JDE
         0m8wrMrtafO7mmrBvIUGI0wqeE7EnDEKZAvpN0zfK0LeLu8p/RUhvwrf7Y538F7GxCMz
         zKYDXZJr7rA6vV9AkzmV2Y8BOkwW1seSn/NQFfOZPTPu/RZhfcZbgO9siULwfOm7VSVt
         5cdw==
X-Forwarded-Encrypted: i=1; AJvYcCWmI3c3TLmSzQgcRI+qi9wTkLglEiinojhtNP678kb1zAG1f3PVEFS09WypnydY1iX+AuyuoeQmXoKvvI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEQEP6cW+0QNoKo1wmDNbC6zez975/PpL9gWgJQBA6C1iArUD6
	UPkM3mKtpQHttM/FSN4Ws9eGjpU17WlcxMgZwlVO4376dgwrtLiMtu/2Mt3spHrQU6E=
X-Gm-Gg: ASbGnctbwR2AMSqMZ8eJfctPhQOseX+wfS0pH0hKbpk7x/JvDiqP6VhMCfm7V6DIlkv
	0efBynmmLWJDb4mpeQf8s//JR7LFHmaxsHxATRgjnf2nGlc95522JgeT0NAUTYlNca8Z9kI/utR
	GT/kuqs7M1yeWZykYcwdyaFKHX5O6v1CW+wCeA3QXMjHevAecd4QXGWvJGus3HnnT3G1OJ644XO
	h840z/k5OshRAsZbfbl86s5Hu4pMYFphkRPVcn9JxJ+hsqPnTOps4o7iVvEBzWBlAxyBTMCvJ/T
	+wb/BfahMV5mv2/GJlVFblGdDTCRStEZfibSWMK5vOChyd6DwF15iuMADRy0P2dPtVih9JH6muT
	Y9E3P0N0FAHQmICCI0aeKM8QPEzPs5DSoi/8fGw==
X-Google-Smtp-Source: AGHT+IFXtbxOaD74GotqT9R0CD1sqY91sieSs3SIFRrIbH0jr4lRcbg1q493FHWof4NReZYFSRDp7g==
X-Received: by 2002:a05:6000:24c6:b0:3a4:cfbf:51a0 with SMTP id ffacd0b85a97d-3b8f41bbb72mr2459659f8f.21.1754491147334;
        Wed, 06 Aug 2025 07:39:07 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e583f9fcsm50543105e9.4.2025.08.06.07.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 07:39:06 -0700 (PDT)
Date: Wed, 6 Aug 2025 17:39:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Stefan Metzmacher <metze@samba.org>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] smb: client: Fix use after free in send_done()
Message-ID: <a1a0046c-f47f-4e8a-ae3c-85db58a6cb2f@suswa.mountain>
References: <aJNASZzOWtg8aljM@stanley.mountain>
 <ad2e9d94-2d95-4351-b800-627f20672209@samba.org>
 <87646c67-78b8-41c5-9b72-361cb3b733d1@suswa.mountain>
 <e291d925-bfd9-4202-b5d4-de5bf30ab870@samba.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e291d925-bfd9-4202-b5d4-de5bf30ab870@samba.org>

On Wed, Aug 06, 2025 at 04:17:41PM +0200, Stefan Metzmacher wrote:
> > > What was the test that triggered the problem?
> > > Or did you only noticed it by looking at the code?
> > 
> > This was a Smatch static checker warning.  You need to have the cross
> > function DB to detect it.
> 
> Ok, I'll try to integrate it into my build flow...
> 
> Does it replace sparse or does it run in addition?

In addition.  I find the Sparse endianness checks especially useful.

> If it replaces sparse I guess a small script would
> run them both?
> 
> $ cat mychecker.sh:
> #!/bin/bash
> set -e
> sparse $@
> smatch $@
> 
> And maybe all others from
> https://gautammenghani.com/linux,/c/2022/05/19/static-analysis-tools-linux-kernel.html
> 
> How often do I need to run smatch_scripts/build_kernel_data.sh on the whole kernel?

The cross function database is really useful for just information
purposes and looking at how functions are called.  You probably
would need to rebuild it four or five times to get useful
information, unfortunately.  I rebuild my every night on the latest
linux-next.

But for other people, I normally say don't bother with the cross
function DB.  It takes a long time to build and it only slightly
improves the output.

regards,
dan carpenter

