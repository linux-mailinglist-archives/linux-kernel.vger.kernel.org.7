Return-Path: <linux-kernel+bounces-819989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A19DB7D1A0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 385D67A49C5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 05:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3FC266B40;
	Wed, 17 Sep 2025 05:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bhyrsogj"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DA5276047
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 05:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758086038; cv=none; b=luZoyUSCMHJqL/pt7CFbhklsKZwr4/nCY44vON4Z5VzX4pjj5MdhoHsrrVJkRtm3AhS6MbgUMNNAmXgmQJ0I3KF8onAB/S1QyYjyU2AOO1vtlzu8Tw3G0gWUIoo92lPS/Oc+TRIoS0+KMLG4DXX3WtDD6pJxWUEHEftCLuAIVNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758086038; c=relaxed/simple;
	bh=sPYx5AEOiKjmkdLNHabB47pnhMs4u/bilvZUHKYNgmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIAPD0y7Mga8Zs1FAWo/ojMez6NnCE2ipN+Y5AdE70iD+ufwo6ktmjK/X2XsUIe2wk44mAzR5GdzxyYFT5kkWsT9cgc1RhZUNqEOYtYHxWfghtEJS8MUKL345dVcLfuBQ6WNq9vW2x9t/42EDMFUvqCCVLdtuhwY71FOp627BJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bhyrsogj; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-263b1cf4d99so4858635ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 22:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758086036; x=1758690836; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eWYaoffWKIIQ1eAIMueoITKMYiLkj90T5d8Op1iUdtA=;
        b=bhyrsogjmjYNydXCIzxHlSWb6uTrIU7Zj/MdMESVLRUG7ATPtToKb5vU7vxYjtYXbQ
         +xXLid/E8wbvbqr0wr4QhbNmsHtQuX4Oxkb+lZxDP8I0BwR3nRJCCTBT955vC0PO66zF
         QKI0nbEdJqt8K5dHvQTOeBNSZ+zZ2yXhlhzWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758086036; x=1758690836;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eWYaoffWKIIQ1eAIMueoITKMYiLkj90T5d8Op1iUdtA=;
        b=WWori9cVQBPp8MPjOFBG95wahQigcF7YruFBo6sPiRDFgCoV0mQj2GxPwFZD95SAE4
         cd9Ls7NNExLTdVTw5ka9+w6TC7b6rNqsDKlF/Qf4K15kWNV5ytkVLCYtuAWHt4/zZPi3
         oWpYj6/hBXNx0XwgjA9Zyko2U7H5J0QWZnDhPDDdRoOOMO8mjhCXOgBNrxz8hRcQT6hb
         mrTAuPAvrtlYf5yUR7q0OihTkIu0iPraQcY3t/XFwwCA1/vu1gSXWW+Z8eL0+4ZB1+41
         qOC8/prApEIGpsPQA0rownnaztvaOyM19KZWYA4HYHNbY9SfCSvOlb5GYRBuR4dImRSM
         Nkpg==
X-Forwarded-Encrypted: i=1; AJvYcCXZM/2OrguJUeeoSLsZuq1I4agzrCP8zqReq0woQJmkFZPloSD8NgCqBLOz1Yo556bJ+oSwbkMmG2QVA+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnhbsI1a/F9ZHmGuEn9Dc6VyNETVVugU4GVlvca/0zj/+a4zDg
	Ljnna6dbXjdIiKfoqB5JIF8FurAKlmkpb9hlsHd7x9CQqC0ptT8uNMFRPcpg4fcWbQ==
X-Gm-Gg: ASbGncuvenxVlQ3yDEznNtbWdvQXL8Ars/5R77h5L2tE6zRYVSCz0rJQ2t+yjcYQhnD
	CHS8Y4LfHMWJVAciOkOjFVRVY4gw68eyxEJxqzq+//oSKjMslMiM2ysJTojVHn7T9RO39rb2JPR
	8tDamVvvoO5G5zVsev82exa22WUoJaehEmwU8mFCYfLVLKce9pSG4WLnyJCsrc6tBEVnPMLt5/L
	NDtWSAHLqKSCCO2yYldswrm7r9Z3HzGPVH/GdB6FNM/EdEetkSL45atZf2m5NYlVCWBhW+K8fur
	3rF0DiB3ofkfqJsIJ/AZxIPTCziFtr/LYvckJhDd7YZ6WvXnPKflsj1BdZDJDjCHEhf3CJTRodB
	bSDrXBdB1gcljsOwFrTEZ5EYgpF052nRo/jqr
X-Google-Smtp-Source: AGHT+IGcJYlYxaD1+nJ+rGBRpr6K7LDYr2yIFUEezr+8d9gx+crkPpfS3Bmpw1FsjBHG3Enags/5SQ==
X-Received: by 2002:a17:902:d4c8:b0:262:9ac8:6132 with SMTP id d9443c01a7336-267d160b79fmr59046075ad.19.1758086036285;
        Tue, 16 Sep 2025 22:13:56 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:383a:598a:bcc0:4cf8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2651ca21842sm86647835ad.34.2025.09.16.22.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 22:13:55 -0700 (PDT)
Date: Wed, 17 Sep 2025 14:13:51 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>, Tomasz Figa <tfiga@chromium.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] PM: dpm: add module param to backtrace all CPUs
Message-ID: <ren47plwmywfz3wmg2vjprknyfwzt7rkp4nppnqnnw4hqxdjxt@skmmbvfok3wt>
References: <20250731030125.3817484-1-senozhatsky@chromium.org>
 <CAJZ5v0jAdsyHKsfRtW+Crh_aDY_uryvNekTBivcdPVGAL4UyPQ@mail.gmail.com>
 <afspavnfnnhyttvxmcgdl76jwpawqp7v7g7dd5bnjfc3vv3hg7@g3zey3r3zqc4>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afspavnfnnhyttvxmcgdl76jwpawqp7v7g7dd5bnjfc3vv3hg7@g3zey3r3zqc4>

On (25/08/20 11:04), Sergey Senozhatsky wrote:
> On (25/08/19 21:35), Rafael J. Wysocki wrote:
> > On Thu, Jul 31, 2025 at 5:01 AM Sergey Senozhatsky
> > <senozhatsky@chromium.org> wrote:
> > >
> > > Add dpm_all_cpu_backtrace module parameter which controls
> > > all CPU backtrace dump before DPM panics the system.
> > 
> > This is exclusively about the DPM watchdog, so the module parameter
> > name should reflect that.
> 
> I thought dpm in dpm_all_cpu_backtrace explains that.  Should
> I rename it so something like dpm_watchdog_all_cpu_backtrace?
> Any better suggestions?

Gentle ping.

Rafael, are you OK with dpm_watchdog_all_cpu_backtrace name?

Or maybe we can have a bitmask dmp_watchdog_print_flags and
various bits can control different things to print/do during
panic.  E.g. dmp_watchdog_print_flags=0x1 can backtrace all CPUs,
0x2 can do something else, etc.

