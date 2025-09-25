Return-Path: <linux-kernel+bounces-833171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72433BA1591
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AA927405EA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02E423B63E;
	Thu, 25 Sep 2025 20:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nq1H7LSp"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5960229DB88
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 20:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758831816; cv=none; b=LL5wnISyafIdOmNphZcnObGXpq6Inmw4xyW7U9T5SgWOtbPIBQHjGYawZ11guSRPLshVlDpJSJpcjNVE4ZJ40FrRX7coGiXQAHAXdkEO/EhJROTS97xwjf/DxnK93CZ+kS590cAioTy+Wqq21cG8ZkdRK2wkSFotkWunOSdqjZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758831816; c=relaxed/simple;
	bh=td66PIlhApSZ4D+Sp/TobwpEiSogFiaRkVnohZ+t+4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LdjaLvU39DKbl4cPrSek2I59F2ZF4t/VusVJesFvMqNlYPHOBtSDVJkc3atokPzHj5sLk/gA5R8cAUwJpbjytA6lpmUwM+fJyCjetsKlwrUuSqH6zvNHvzIcCU6vJ8/D2wzbhFef1TBtHdhaBSDVMdIG+isw2dIbvIBkv48fP9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nq1H7LSp; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-634a4829c81so1977608a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758831813; x=1759436613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s1bYAQWgh8lcWFAZmtY0iaXciP/sTuFCRFgS7NXhX+g=;
        b=Nq1H7LSpy15D7uk23LYrOZtakKA0r+OvFqqsasUYMf/25IFPdp7pU69MWIszIk+jY7
         6RXpezRBuRDMhKdeNsOY7WV+40soordkU3qSV2yWcV80wn7rqWBvfj+rCVOduolaSm1B
         2GVhfS2ETXCRloe0nnMvwEk0Uz++/cxmXJHRQ/2MJxSvfjyfspwEW4NuYALAnOd0GhU3
         IEjFdnnjjH26audVbuquJkVrCV/9OJ7bBJLBNn2GfYGetTKwGIMWmTKykZ0vvwfeSedE
         JDVVJCyJQ7s6M86mi18RkSOVjM0RwOO3xWFYtJ+W9lcVm4I2Mrho+f629WWJxY7yuXCk
         zHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758831813; x=1759436613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s1bYAQWgh8lcWFAZmtY0iaXciP/sTuFCRFgS7NXhX+g=;
        b=F1h/abLBbMjTTuYwug90TqvPhU1OATM5HMYLkGcnJR708FKxphgSue0zNC0srIG5d1
         fudur5r6N9GmdXcQ/UtREksKu7UZRa9kvjvTG9plThfN2d3PtGZmcZ79rV5JAOmxCtWy
         tpzRJF9PljI/UyQb8jSrbEXuYNB+fmO4AbXT05s2fqLVLcCSK4wU83LuCf7gpnStdEXX
         EYm9z9QfDk16HiqtHWGzNEv9nysZ5lGDZi6HqBanFTZTuqUUGmAdyj9aDX4DV/7HsnJn
         CN0UrPlP6k170wLya6TS+TBCNZyA+4bnzEnYzpVO2kd1MVkFUKZcLYsHouZBhpuE4LJV
         KrhQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8xujPnozrrU1Gv6T34CpFcMwOlkKNJKY2O9isfQyZAyOLBzIsb8iOHyGV6MRerBFnmczsTDHlFzp+PUs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4446WtTT1wkZ6PGa69ykH7YUfbGqYLmvvbwjXFuzwh+RRBcPV
	1MbZiVCUymHaxP9D2kRrwvsCM7fPG7S0MrqCKSyfjBiEE1rg0tsRYZaM
X-Gm-Gg: ASbGncvED6PpgoiA1k97q4vCFx5VBMDnzKQMAdiIT+pAyV2Pjjs1pFWsXuw2kGM5Fwx
	dPK9qv9sYzHw5DBNx+jjB5gF7YINQl8qdKYN86xsZ59aUazWDMeeEup0LOPCTUP9KulnA6M4j/7
	WaMQwhvAAdT7IQ9d7DyFcbym6jGrztoSdMiWeYqoBsFs1yT7wWD9jD4z+zZkN/mKTrcitOcWuzJ
	+/V4UbTej0yrkYxInzVJQVwo4zaDCsv1KKE371JvE9hevXzG8Hz2ceb4WL8bDDQMcNNIB5miFky
	mErYQoMdEY1YdVhbqf30wUPGBPoX1PcBiPiGt1dZ0mgnAWepJUdX493U/LZ6YCIBOhUoTgZmC40
	pI8Np4nFXNAu8cY1nteQC00FTeMxYf5FGt9L4aKVIr9w3vAD3QNmOSuIo
X-Google-Smtp-Source: AGHT+IGqvwLYaPf8rG1hxOPXGZojb1e4fn6NzWC8RmwxoyjdA7WNDhaFbcZDEpLG2UefoKTeaxPvjg==
X-Received: by 2002:a05:6402:35cc:b0:634:b7a2:3e8e with SMTP id 4fb4d7f45d1cf-634b7a24529mr145549a12.22.1758831812146;
        Thu, 25 Sep 2025 13:23:32 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a366116esm1729436a12.21.2025.09.25.13.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 13:23:31 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 4957FBE2DE0; Thu, 25 Sep 2025 22:23:30 +0200 (CEST)
Date: Thu, 25 Sep 2025 22:23:30 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: AlanSong-oc <AlanSong-oc@zhaoxin.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	CobeChen@zhaoxin.com, TonyWWang-oc@zhaoxin.com, YunShen@zhaoxin.com,
	GeorgeXue@zhaoxin.com, LeoLiu-oc@zhaoxin.com, HansHu@zhaoxin.com,
	Larry Wei <larryw3i@yeah.net>, 1113996@bugs.debian.org
Subject: Re: [PATCH] crypto: padlock-sha - Add support for Zhaoxin processor
Message-ID: <aNWkwiHk7sFkHEVp@eldamar.lan>
References: <20250611101750.6839-1-AlanSong-oc@zhaoxin.com>
 <aEpgKQ1I0VDSfhO0@gondor.apana.org.au>
 <0575ec9d-a6b8-4932-a1aa-9646813957a2@zhaoxin.com>
 <aFkdNoQFmr8-x4cu@gondor.apana.org.au>
 <bcaaccf4-4048-48a0-a9f9-64902a16a049@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcaaccf4-4048-48a0-a9f9-64902a16a049@zhaoxin.com>

Hi,

On Wed, Jun 25, 2025 at 09:51:56AM +0800, AlanSong-oc wrote:
> On 6/23/2025 5:24 PM, Herbert Xu wrote:
> > Thanks for the explanation.  There is no requirement to use struct
> > sha1_state.  Just supply a custom version of the struct for the
> > shash descriptor that includes the necessary space.
> > 
> > IOW do the copy in the rarely used export/import functions, instead
> > of on every hash operation.
> 
> Sorry for the late reply. Thank you for your suggestion and review.
> 
> I will send an updated patch soon.

FWIW, Larry Wei reported this issue as well in a separate Debian bug
report at https://bugs.debian.org/1113996 .

So far there was no patch applied to mainline if I'm correct. Did that
felt through the cracks?

Regards,
Salvatore

