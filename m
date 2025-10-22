Return-Path: <linux-kernel+bounces-865822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D44BFE1DA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 22:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E768E1A072E7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F202F83C4;
	Wed, 22 Oct 2025 20:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="kllj+V2h"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502A32F7AAB
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 20:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761163475; cv=none; b=Wda3DBURQHt6bpmZ1E+knwgqgn1EJNAtQMBfRPbhWU73dBtS+X5N/Wa9/cr98+qwUUgqC5l8jjzayiyqkftO/QR3KFYiu3CgRsV+/f8nO+5bjGGng+xOaciTyN6lWvEkfu+T+J4ydhuRj25iwJq72qxWuK44nqg8nLp/1Lw2crQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761163475; c=relaxed/simple;
	bh=5kSHtqSMPLWq5WwPm/iwP1qje6tfTwJPD4eLVRFnRtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCg6vb6HcXPJKk0ysnYi76nXTy2mT/AM7l0xh+/XGLUi/APDAW8Dj9Mw9zmbTEtSYCbN9XxtJb3+IQ8hM0mPhd6pUfpK8gEivQSNxHK1FmA2jipvI7G8NyITSeEo0CUSlm326VP4GT2D8dLPG7HXCcQZ5awBU4WOmZKlUwRw0hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=kllj+V2h; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b457d93c155so12136966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1761163471; x=1761768271; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IVSmP58vLNDXKtZLSHsonVofaKm7gnshEKZbkuGHmnc=;
        b=kllj+V2hz+cgcU0J3DAos1Bm58RLUEJ+TntR5zdBxwI7zm65R3XteOkBMVT25rBdyU
         vNi2vs8WTjpg231qfYMhPBqxCv1MWnNAyPfYrcDmlKpqW+lzMe+JPl6wTnshyTaF1Kxe
         MGEJFquMcG1ZqiKp3oPQGHYRt4rFIfCP6pcVKAsWVlJkL2x2d0+yIgrJGoKSCANffrMZ
         MfNXTV6asSwvzx/X8mGreK3Z9y0L3YkgSfXkgtQtu0FmxBqclBu8o5uWjOUjCE85wvkR
         xAerf5MKeZvmllW+RV9bxT0RdBLo06W4sGnBvxZGGrNvPmLNGzL9CuRCucwvONZjgpAn
         QjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761163471; x=1761768271;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IVSmP58vLNDXKtZLSHsonVofaKm7gnshEKZbkuGHmnc=;
        b=hmKymeI7AFuDqBvmtZ0zOfWN/s44aqgPIKjx6CqXwN7yQp/s6asIjFkHucF1V4YCeP
         xdb/zbN5kKXb55dyD0m3j0zenYemhInDa2fEV4aU1s2e8mS09+WDh+fdgF5KYQm+RzOv
         gYx7FpMjJXFyfkfWXdtrxZOBBo0lMYqiNEoVas++coJlpVN51ykrRLG/+W/yO2tQkDRM
         UY+GYY9oJn+JwfC9hEflQIGfZCg7Dc7lDkdGDzqWJh3BPMIgSYo/fqrat7U7KJTOuc1b
         x7HQI8a4K/GKCNMbXKfhndBHfFnXpvKAi16FMWW4J1sAEkaK1IzJhWNnqEavuqZjvDX5
         8wQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVX97EVhIIzIe/m30UrsCYzg43BLhgjr8sy8lnrbyeUvueA7OXzFwkHJ0Mgg9bmSlwt8an9QNmAkpZzw1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWTnxFgXT4rvAGYt9wQVRtwu8Dh56hO/UPWahL7BBESjBPhm2m
	NH2XohwX3IbWBn48ZhBGt3tKiNj/WZWsWhmP8d1cW/b/8AXy1cw8ah/r
X-Gm-Gg: ASbGncs2Z0waUFLpm8eiyKnmUx4LmRbQ8yVecfYjY/WkpcmwV3LYs/1n0o2Ox19HsTt
	6nGQvC+OhXz2FbRhcBfqYtW4TeLhX9jakz+81vAQERlGLgbi1FhMWPfN0piSYAM3WNAf3FuSb8f
	eZssXbDu1pnCkPyHBlWWiUOztrZQMidIpwzjNvYGJHIjmz0FMBYDPWm3m8C6HFgAZfNeqSraj2N
	jo9AB3cRRSH9S/o1pVDL9j+7cL+217GuY8SJRUTMT/cLSp3ghodZhRFOBTqVZO/J7z8s75WmNwI
	dtT+yygetdzAjk3JJFA0bMAr97Mw+lqfuQTM88ycmnhvrmkEZje8XzqSTxLYrvR/wCmvvuq7nhL
	uaoo/8r+ltzQt7TLS4ST2Cuq9ec1CwJb3K1p+cn2OyEvEAep0i+tA78nSxI4Mzw==
X-Google-Smtp-Source: AGHT+IHCAXlGLFQGE7nq3DxlfqCvMe0ghMNIyNBqQt1gHQW5F1/alSGk8I/YKWg0yty+IIt/e1cxag==
X-Received: by 2002:a17:907:2686:b0:b42:1324:7986 with SMTP id a640c23a62f3a-b647254f3afmr2358003466b.6.1761163471460;
        Wed, 22 Oct 2025 13:04:31 -0700 (PDT)
Received: from hp-kozhuh ([2a01:5a8:304:48d5::100])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c4945ef49sm12525863a12.29.2025.10.22.13.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 13:04:31 -0700 (PDT)
Sender: Zahari Doychev <zahari.doychev@googlemail.com>
Date: Wed, 22 Oct 2025 23:03:23 +0300
From: Zahari Doychev <zahari.doychev@linux.com>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: Jakub Kicinski <kuba@kernel.org>, donald.hunter@gmail.com, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	jacob.e.keller@intel.com, matttbe@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	johannes@sipsolutions.net
Subject: Re: [PATCH 4/4] tools: ynl: add start-index property for indexed
 arrays
Message-ID: <3hlrcm2mvwhtpeuq67vrqupjabuws7o64lh5xoks3cuyyrfpsj@vcuuwazenoys>
References: <20251018151737.365485-1-zahari.doychev@linux.com>
 <20251018151737.365485-5-zahari.doychev@linux.com>
 <20251020163221.2c8347ea@kernel.org>
 <75gog4sxd6oommzndamgddjbz3jrrrpbmnd4rhxg4khjg3rnnp@tlciirwh5cig>
 <e9cd34d4-2970-462a-9c80-bf6d55ccb6ff@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e9cd34d4-2970-462a-9c80-bf6d55ccb6ff@fiberby.net>

On Wed, Oct 22, 2025 at 07:37:10PM +0000, Asbjørn Sloth Tønnesen wrote:
> On 10/21/25 5:50 PM, Zahari Doychev wrote:
> > On Mon, Oct 20, 2025 at 04:32:21PM -0700, Jakub Kicinski wrote:
> > > We need to be selective about what API stupidity we try to
> > > cover up in YNL. Otherwise the specs will be unmanageably complex.
> > > IMO this one should be a comment in the spec explaining that action
> > > 0 is ignore and that's it.
> > > 
> > 
> > I am not sure if this applies for all cases of indexed arrays. For sure
> > it applies for the tc_act_attrs case but I need to check the rest again.
> > 
> > Do you think it would be fine to start from 1 for all indexed arrays?
> Yes, AFAICT it would. Most of indexed-array attributes that are parsed by
> the kernel uses nla_for_each_nested(), and don't use the index. The TC
> actions are the only ones I found, that are parsed into a nlattr array.
> 
> Disclaimer: I have only mapped out the indexed-arrays that are declared in
> the current specs.
> 
> See patch 4-7 in this series for the full analysis:
> https://lore.kernel.org/netdev/20251022182701.250897-1-ast@fiberby.net/
>

thanks, will try it out.

