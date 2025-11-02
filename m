Return-Path: <linux-kernel+bounces-881848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 44901C290FB
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 16:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 115EB4E258E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 15:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A0E22422D;
	Sun,  2 Nov 2025 15:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcbQ0vlb"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA481E521E
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 15:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762096474; cv=none; b=F4ZYnWYDEedlhQ2ibHs7i7Lcm28fcc0VtCKlb4iP94X1w3Wd/wGdkyQCvLfUjdceRAgixpYHvIivmG5mAN77sM/7zSGDtHCqVw17MHEMGktL6VvM27XMMIKT0gLlkq+ALMozTS7+tw9TyrENWa/X4Ku5fEFKJ6TU/s1JQ7/c044=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762096474; c=relaxed/simple;
	bh=DH/e7zqZAn5aW+XdqAJw4teChyFGjZ0UfNvcB4iILP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AlHi8YUk+r15fDMPBML0xdaS1rq5ZYmM0h3S7LcVx8OaIm7ZjOjXXZNtrixtmigf51mEaDQzj5YrZrOf7N9uJ2sXniFWKe4p1wfpCTXW15GfGCAiP9CFAGEbkv4Y/tqvin+idhUbydtl/TR/MY2jeRY+cLwIxJAT9aKW1QDO2uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GcbQ0vlb; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29516a36affso23478495ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 07:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762096472; x=1762701272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bze7Pu1Q5jiroPk+WcGwRDVKrtNLhv0ax/B2LBPCx/U=;
        b=GcbQ0vlbmOk5sj2/ud1XAPXaPkjoYFj+mL0WeERpJxEce/V8ufQz+fdNi8x+OAZeRk
         P4V+cETzz7qQtFBSwQpqNAyQM7U8H98aj8mg1wQgJb0fyZQlf1MMx9+UPgiLFrgoue9A
         D9uo6vE5lqqRAA1pztsOj9YtjVdKrn/jqBTFwpbY5Bett+0JKQAg2jJ7tO7TAmobyHIW
         uwZOjjSoXO+xGRprA8EhUrT8bWwB3KpJa8mi63xPmhuZUPJ4sEocbykOGDVOfAr/S4Cg
         fA7jiBLzvcZ1Hui37wgIb91/pwIgwxfQDo2PD3me4dsHrAQZ1iyn2KRjdknBuQP1HlVP
         5LzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762096472; x=1762701272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bze7Pu1Q5jiroPk+WcGwRDVKrtNLhv0ax/B2LBPCx/U=;
        b=A13e2Fo2mZa/NNc2dsZoXloZAjID75eIvmEkPKJdcdpN8bzTd7h380YClP6NMnUmC9
         NePbbquWBihv+zF2bxWfsOiFCXOhmqlc+iwOMQpCaop0aFwYMuyb3pXMF+DdC3LvtoZD
         0fyJGofAGBqBv3ZcWfhkG+FMnICMGmlXWinX1fXqTCKFUyXjvHoTFzdvxEPIKSti3ZWc
         GYFRdnBm3/dUOcwUZK3i5QKj397W6g6TwXyVgahjibRiPt54n8EuDJlXkWqGUYFZ4nTV
         YwgSHz3hfh1GaFwKqkxYpFjp9JdJ6UNbrHIs4URS75S6T7po+HmJySUfhpViU1wTOkGe
         CGYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyr1T63ZIJzbwRfx39xlp0gF2yAM88kNQcsu+W8JGr90GEfpHB8Mx5QKcVogtX93B0ysC8e4bbMHUrWtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxReYeqTvKqua/kmjk5kRC/3bvwdKPfpk7IhjZmZw7BPUzfivyp
	OGj+I/HzgHvfAHrYCHIOMJ2njdqumSDrPkH/yL5nA8I+W2+JwvN7c0mF5nFZwA==
X-Gm-Gg: ASbGncsONakO3iZSAVqlyzz8IvHhFnz2sNdg9TFU23t9mpo1d/+xv06c3hKROFDbOJj
	tv9fu5rIIKVly8+bI18K837dF5HbbO+wLuDC5lrUnqAxSScVkkdYSOjovRIxF+6vsmM3uRcEyNm
	Jl9gRgdF76bpWUvj3Iu9MK1wf3dDVmCtKQ1CCcme51ZidhJbWnM5r0Vz3gUwStwvrg02+sQ0jhM
	ksSiY7/9TVH/uBbcltN2vdj+nsKChqErGJNOeIVaUhHqrNWRfTzfmywbID7sFswcUJLbPdgiZV4
	okQUk1WUrKfj+puJe+GKzhHJzG95TQFKpegqEl4AILqXphpjeCxt8AY+hkAoycf78o5JJd6S1D4
	8tfgl3KheIjDACeZ7mUOl6re9uNfKwffazmOHM4aDrsGkYXNRosq9rYqGKz+77h3k34FA8jhXf6
	YRoIG9rYBDMz3tPjd+5IZvyAk=
X-Google-Smtp-Source: AGHT+IG8wWnRxtd3UncXE06Ni2I7cYOWztoDXNF78/nv2l+HTNruSmDscdo1rwnVIAjgYb+/nbcYzQ==
X-Received: by 2002:a17:903:2d1:b0:294:cc8d:c0c2 with SMTP id d9443c01a7336-2951a3a7bf7mr136268075ad.27.1762096472539;
        Sun, 02 Nov 2025 07:14:32 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952699c62csm89792325ad.74.2025.11.02.07.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 07:14:32 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 2 Nov 2025 07:14:31 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: "Usyskin, Alexander" <alexander.usyskin@intel.com>
Cc: Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?= <marmarek@invisiblethingslab.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Abliyev, Reuven" <reuven.abliyev@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [char-misc-next] mei: hook mei_device on class device
Message-ID: <501acd49-b8ab-4fd4-85d3-79ca3deca034@roeck-us.net>
References: <20250826125617.1166546-1-alexander.usyskin@intel.com>
 <8deef7c4-ac75-4db8-91b7-02cf0e39e371@roeck-us.net>
 <CY5PR11MB6366B9836B306AD2A72BDDFEEDC6A@CY5PR11MB6366.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY5PR11MB6366B9836B306AD2A72BDDFEEDC6A@CY5PR11MB6366.namprd11.prod.outlook.com>

On Sun, Nov 02, 2025 at 10:12:56AM +0000, Usyskin, Alexander wrote:
...
> 
> Seems I've missed the error flow in probe (my test machines always have an ME in a good state...).
> 
> Below patch should fix the problem, can you confirm?

testing.

Thanks!

Guenter

