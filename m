Return-Path: <linux-kernel+bounces-785124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D28B34649
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 305EA7B4B19
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6DB1DE2AD;
	Mon, 25 Aug 2025 15:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MaJuc4wA"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3B22F2914
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756136991; cv=none; b=Qaqiy1OOBBI0x65Dppo8M7FVUCuqaQqXV0g3saEPhZdrfhJQrkbIdP59w6DUDCAZVnp1bKAhP4FN528fzrgYxW2h6vXK++uGZGgIkXwR0UMhPmO8coSjfDRUT1PoaCBDvvlwCHTtG5AdvwLP+brk//UTuyXvcaD0I1m3y5tCP/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756136991; c=relaxed/simple;
	bh=oqtWjKsKQfNBXkoelma6YI1maHK6eWDNffksSw4nS0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=semK68NDgkYKShVFdmbR9NUBsCBbn17QvRozQf8MzK/Xs8Ogx+kTen3BgHrWNL1vd1N2xWI0fgbZN1SwrDntKRvHUcPHLTf4cfNYoNYPhUiBke1BTXXi9Y/Yu9ifyqXR88QPyzX0pN2d1offVrjaWyggw9H19wuaW6vob6hzuJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MaJuc4wA; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24611734e18so339395ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 08:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756136989; x=1756741789; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k+sdNCtHEDTDeDcug82C4JMMO/tNuG8fyuseyldRdnM=;
        b=MaJuc4wAzE2yjaMJqh8cZuSozdOK5EUuxnh7z9drr7SJEo+2GZW35qt1sdpg2aDFEt
         n40eRpaD3Pf4mFFxjybS7I9aVmH/jumnUPu+pyPFTKcBGADLpTs1x7TgRC9NSodFnOdP
         NUomNA90dhGUskQO1yHa9NW4q+G60+8CgQPPWOPZQ++uBz6jfH6iiqcY4EYIp52CR6fm
         /faWlqagVIdQTxj14shIuDhTg4aKQkTQ3i2vf0fHWQjaJKOYpbIXcxhw14nWIQrk65SH
         j6lpjeq1uQfsyWlnJvh2VjGzyxvN6hDU8z4/EFe6IOcI37tyBJjlduhR+c3fAzuK2vm4
         G41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756136989; x=1756741789;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k+sdNCtHEDTDeDcug82C4JMMO/tNuG8fyuseyldRdnM=;
        b=bkH0H5maAo/NcKx0BdxjV5ohStVFz7Rhd2Ukrewo2Z/Es1Hed7pK3Xkh6a1l77PDlh
         uzgZPXgw/uV3mMp5BA9CtCt4e7BulU/BJX8B3q1xDyw74g4xvMJNth3u4uopiJr7fn6Y
         EHqxLKWa7AAtwVk0ICqabLd7BaFnsIODzhsQD3KPhUo4aK0hQsWdJqdg721aKxpPKRN+
         aMbXe4qiTNcG/XMOX5eoNhNYQdWp9nfHji5fSd5+un0dFqH7h/gDH1Y/lwqXoBGJv5za
         vewbgxeC3Ipw6t7HtHgiD7iR+RmKBDsn/oyXU+212JTs2ULPDleAOW/thKPkQQ9c2gKR
         J+VA==
X-Forwarded-Encrypted: i=1; AJvYcCXPiQWgptpL8PRYFAKSat5GOCJj6Ho1WLhqu7pdJ3SE4dnHQM5JYI6VV71UYrRcQz0twKcamh4tgLMIhQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUARqejzBPkDx6WaWdmlZfI6ssNW3I1gFjKQ/n127TSP1IzAP5
	w/P30UqNbHv1RxJ3IWPfxcIwRob2jysh+VHqUhdvRdMmx4YKXh55A1d2UyBWjsz6FSRdpx/9qCv
	Cwu4Yxw==
X-Gm-Gg: ASbGncssYcc7GOFE8Fe3v1xE0QDzA3V1Hu8HM9PpUSQT8KJ3nk+X7ez7F6zkSkBdYB+
	aFVAB28KPh9jwJHpD24XaDoJb9usZU0trP2p0IT/IWTjuleyY+IXv3EqqSRJ/zg4UUO3xR5ss8C
	Sz43maEy1VWEPtbVFSuKnvmO8PgVmtR1s/WOjG+lZXhuMZMfw4JqVvXEgx4VrcwMLr0pInnjo+y
	UFhOGeGEVe39HOsY4S57fYEKzfKVJRaxoCxWBtl6KMvsrlkD6VHIqEdxSWyNqDsUzrGiMJGHRru
	k8VQoNYiQOvBSPV3U5J0DCCx9BRGBXz9ssWqTzoa7aH9Febl8xZBFjdrR8fSKAr74LyXfR8ewQT
	VnYKo0HZCEI6Rf3NJYFJzpcelAV8PSOpFnqJhX0w5k1CryFj8Qocbht9oeiebdjAUfwAYf5aS
X-Google-Smtp-Source: AGHT+IF/UUO3cGwP6E0MsYUN+8MvrQxpywYseDCjgMMrOlXWFlEY29LQ9QYboUALl8xCpqDFKif5XQ==
X-Received: by 2002:a17:902:e548:b0:240:6076:20cd with SMTP id d9443c01a7336-2467a3cf14fmr5259605ad.15.1756136988608;
        Mon, 25 Aug 2025 08:49:48 -0700 (PDT)
Received: from google.com (3.32.125.34.bc.googleusercontent.com. [34.125.32.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24668880368sm71312425ad.109.2025.08.25.08.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 08:49:47 -0700 (PDT)
Date: Mon, 25 Aug 2025 15:49:42 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Matt Atwood <matthew.s.atwood@intel.com>, kernel-team@android.com,
	linux-kernel@vger.kernel.org, Tiffany Yang <ynaffit@google.com>,
	"open list:INTEL DRM XE DRIVER (Lunar Lake and newer)" <intel-xe@lists.freedesktop.org>,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2] drm/xe: switch to local __basename() helper
Message-ID: <aKyGFnCJjlfsPU08@google.com>
References: <v5j6nxynzvvlcxu3m3mkeyjv5dlozzp7ixkgc6u6hdzh7en6jh@zvzqm5n7njfd>
 <20250821220054.3700783-1-cmllamas@google.com>
 <w4j3kzezrd4xqc4q4vkpbbxqvqxitam5htkex6rj6dguj5kbw5@27gqnp6veuu4>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <w4j3kzezrd4xqc4q4vkpbbxqvqxitam5htkex6rj6dguj5kbw5@27gqnp6veuu4>

On Sat, Aug 23, 2025 at 06:56:30AM -0500, Lucas De Marchi wrote:
> On Thu, Aug 21, 2025 at 10:00:53PM +0000, Carlos Llamas wrote:
> > Commit b0a2ee5567ab ("drm/xe: prepare xe_gen_wa_oob to be multi-use")
> > introduced a call to basename(). The GNU version of this function is not
> > portable and fails to build with alternative libc implementations like
> > musl or bionic. This causes the following build error:
> > 
> >  drivers/gpu/drm/xe/xe_gen_wa_oob.c:130:12: error: assignment to ‘const char *’ from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
> >    130 |         fn = basename(fn);
> >        |            ^
> > 
> > While a POSIX version of basename() could be used, it would require a
> > separate header plus the behavior differs from GNU version in that it
> > might modify its argument. Not great.
> > 
> > Instead, implement a local __basename() helper based on strrchr() that
> 
> double underscore is reserved for libc in userspace
> (https://www.gnu.org/software/libc/manual/html_node/Reserved-Names.html):
> 
> 	(...) all identifiers regardless of use that begin with either two
> 	underscores or an underscore followed by a capital letter are reserved
> 	names. This is so that the library and header files can define
> 	functions, variables, and macros for internal purposes without risk of
> 	conflict with names in user programs.
> 

I see, xbasename() it is then...

