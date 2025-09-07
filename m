Return-Path: <linux-kernel+bounces-804537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74426B47931
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 07:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C4B47A779E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 05:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9C01E285A;
	Sun,  7 Sep 2025 05:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PolkGD4c"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CB41E1E0B
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 05:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757222996; cv=none; b=oCVCYNF1jpEhLX1l0i+3iwI30qTipuY4DWsluBpdkQCffCTBkXxchiPJxrWEdmkKi/kFJzhqMINPEzTyhbREB4A+mGakPEZsp29rszrQlFlbkugrQTqk3glkdBijNYZ05/djaWswec0wHoY870/JMS6wiT4QwCshbwYml1p/2E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757222996; c=relaxed/simple;
	bh=caTPKCkAvkuQGw3fUn3P6ZaPL/8hegzI2j/493ESBVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q7mTZYXQD/dlq0siPdo+vl3H9BwePcfm53tmuTlR8BIbrIlOLd+jRee6TbPKV3iNgdy9yG76bOJwNxWxhi4gtyaCRYHHZRyEGGfh032pKBfEI4lC8eaVwxzPVAyCG2iH7H2CukmHQNfdCPfvDZ8khAwmKzeQrd6ZEf82BOLs3C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PolkGD4c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757222994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NDSHjXOUY0OzHHbNYkSfv2EmWxAIktBkwdxNx3m1wgU=;
	b=PolkGD4cGblND3wX4mtTtgiLahJCTN4g9/wrHgJsxuYUc5/HgAUqntiJh6RYLqunrXaLZb
	KuwW3OWxThNVUYTLqpKY+qNte4azTrPHlP8Ck7vWX1sB3EICtrfHbe9EQbMSvx0NzbnspU
	MiSrA1K70HNRCXkh/BbhI6lsQ93NF0U=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-9yUfn8PqM4SvOZNjk7h-zw-1; Sun, 07 Sep 2025 01:29:50 -0400
X-MC-Unique: 9yUfn8PqM4SvOZNjk7h-zw-1
X-Mimecast-MFC-AGG-ID: 9yUfn8PqM4SvOZNjk7h-zw_1757222989
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-772642f9fa3so4281535b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 22:29:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757222989; x=1757827789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDSHjXOUY0OzHHbNYkSfv2EmWxAIktBkwdxNx3m1wgU=;
        b=u3caDCBOL88/lQUH+i/7z5OqRCSDWf4+G1yLlBS0VTz0GIuh/OfHU9/08V7O1myW47
         U43N95pIOzcbW/rFgHgOzRY8SYN+s76mnDynAr5wtF0ADK5mXYKQ/0rtPIu03sb9/Edr
         oZlLKyN5nH8ycdcCz6h0xylNCXxga6HKxa/qOpN18WZYTU+SRQ7CeGnZp/BYSf1tRm2i
         pp1CfDl4Dp3aY+4ewXlgvxUzA7jVi/FkONMup1BWeroKSzqamKr/RUAbGA7tkpjsAOs+
         Lu0oTyqY9vaZzcaENDmAkbjZ+1e8ASi/IT+Z1gAm2A05x73SeLbz+cuou/Z4i20gvxV6
         eDtA==
X-Forwarded-Encrypted: i=1; AJvYcCVoMBAqzZhb2kMh4d7ukKcwz2q0I72PVfI1oe5rfXe6kU1JFJb3UfxHj3KaKcV5k372Cu7gmqGHc6tTyvU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0m9+ZydAEgjz/cGxaIDD4hLbHwgoJD2I6oyBILac4bPgNjB//
	ZEYjJ6JdlBPpKiq9wVWfY40sxtEFiLRRJmPrboql0v5Ma0F2+CDdRteBVP0rlib4DBEPi2dFK51
	vvO4abI79yXGj7o8XWrntZ8AB2Sg72ZH98LVe/3XCHfdpSWKAcOm4vmsmmJ8Q+cxOIA==
X-Gm-Gg: ASbGncuy+zCW3aGV8DVh/5OJ22AlWdPkAd3OjKEznjCPBqIgwA8gZ0NWsXAyI4uAg8z
	PWJQJoiMLoPFlGb3CceIn6qEOJqrd8xfj/gRzZQQsZRfMW2FQvOCEKnHptbK1IH4DlsYbFcpS91
	cHbXZxG1KgmBv94MQBy0zgcoEVeG/5QZNr1E1iDGsCdcpuPVGYwFUCUciAGRG1m+m3ssBPUCet2
	vXT+c+6bnlTLm0UjAKgfSlYTUmaMGoib4wEFLvDsq84CPQjpLuNbeX/5q8QCSVxDCeQ5KeLtdkS
	jaICNJPNhYM1t++0tUuviH7yaNcFmppgU2pZroKUFv3DVxWlm5mspse15Y6bpkAZa61oq+2ntSJ
	RH6NC
X-Received: by 2002:a05:6a20:4303:b0:245:fc8e:ef5b with SMTP id adf61e73a8af0-24e7cc230b9mr12289010637.5.1757222989277;
        Sat, 06 Sep 2025 22:29:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvhkV+C/ngmYr5b9L+PxjVes3H9Tvgst7PxAuC8Mh5uWsBWo7Hp8B67gRI5Mjyth4C7Hk8+Q==
X-Received: by 2002:a05:6a20:4303:b0:245:fc8e:ef5b with SMTP id adf61e73a8af0-24e7cc230b9mr12288987637.5.1757222988895;
        Sat, 06 Sep 2025 22:29:48 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b520eaf013esm5307355a12.52.2025.09.06.22.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 22:29:48 -0700 (PDT)
Date: Sun, 7 Sep 2025 13:29:43 +0800
From: Zorro Lang <zlang@redhat.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>, fstests@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
	tytso@mit.edu, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v5 02/12] common/rc: Add _require_fio_version helper
Message-ID: <20250907052943.4r3eod6bdb2up63p@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
 <955d47b2534d9236adbd2bbd13598bbd1da8fc04.1755849134.git.ojaswin@linux.ibm.com>
 <1b12c0d9-b564-4e57-b1a5-359e2e538e9c@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b12c0d9-b564-4e57-b1a5-359e2e538e9c@oracle.com>

On Tue, Sep 02, 2025 at 03:50:10PM +0100, John Garry wrote:
> On 22/08/2025 09:02, Ojaswin Mujoo wrote:
> > The main motivation of adding this function on top of _require_fio is
> > that there has been a case in fio where atomic= option was added but
> > later it was changed to noop since kernel didn't yet have support for
> > atomic writes. It was then again utilized to do atomic writes in a later
> > version, once kernel got the support. Due to this there is a point in
> > fio where _require_fio w/ atomic=1 will succeed even though it would
> > not be doing atomic writes.
> > 
> > Hence, add an explicit helper to ensure tests to require specific
> > versions of fio to work past such issues.
> > 
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >   common/rc | 32 ++++++++++++++++++++++++++++++++
> >   1 file changed, 32 insertions(+)
> > 
> > diff --git a/common/rc b/common/rc
> > index 35a1c835..f45b9a38 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -5997,6 +5997,38 @@ _max() {
> >   	echo $ret
> >   }
> > +# Check the required fio version. Examples:
> > +#   _require_fio_version 3.38 (matches 3.38 only)
> > +#   _require_fio_version 3.38+ (matches 3.38 and above)
> > +#   _require_fio_version 3.38- (matches 3.38 and below)
> 
> This requires the user to know the version which corresponds to the feature.
> Is that how things are done for other such utilities and their versions vs
> features?
> 
> I was going to suggest exporting something like
> _require_fio_atomic_writes(), and _require_fio_atomic_writes() calls
> _require_fio_version() to check the version.

(Sorry, I made a half reply in my last email)

This looks better than only using _require_fio_version. But the nature is still
checking fio version. If we don't have a better idea to check if fio really
support atomic writes, the _require_fio_version is still needed.
Or we rename it to "__require_fio_version" (one more "_"), to mark it's
not recommended using directly. But that looks a bit like a trick :-D

Thanks,
Zorro


> 
> Thanks,
> John
> 
> 


