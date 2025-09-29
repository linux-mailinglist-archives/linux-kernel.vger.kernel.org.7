Return-Path: <linux-kernel+bounces-836462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C370BA9C3F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86ED41654EA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D373093CF;
	Mon, 29 Sep 2025 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sobuyq1T"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A275E301015
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 15:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759158837; cv=none; b=G9cwtoRkXBBwpyV2Hsu9hqORukf/5o0KgD7uRewh5v0ojrtCmzcqbxznrw37RTrlNdXjgDawjn0Ng8JNF1c55BcP4DEaoiBE54kYDN8Xgm/3syeKqnSCaTzaH+nVfJ1HJz80DC5ESx8zZdiMNY2O6a+46AB7/c7Q4Cd9GWLgU64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759158837; c=relaxed/simple;
	bh=Q5xpCZtgoUmeiOI3wsnnzH9U/v0JlgZLcFjeUxgaTkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UfYdf+AAqN6Vtk8VazWWHNUfQDcFHKaZDWvinDk48tQQMaQmXznxCMmqDIRvGZtBMjOapTS12jUhqS5zddk+GY6tyAAfKLlkkWN6zQL8vUunES11qnvZH7G5a2F3DtCt6PZuXrPDVFzLppxxDPQxJr1lFmTYYg8I3KCoyQzQimc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sobuyq1T; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8593bcdd909so504591285a.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759158834; x=1759763634; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o6mF9nQbD4LRSuancZRW+yv6VyfhCAoAUv0K8HNhZys=;
        b=Sobuyq1TTPOSp1ppry8MdGIH0EDaf0YibFBRcHfK/bFHhGC5IC1AqAT+UKqPH08wSG
         yKMBAArRUOCOW16yEP6bu6gxGV3OqFM4irM10e06q/j2ojB85WvW0AGhvSYH/O/XBgam
         dJLkBX0UJun/JDB0O4ikPzXc/9fyngnMZHnZxxiZBn1vv3vLx8MloGzXGIv/+kr6UlD4
         L75ngtKPZrp8DArcqwWWbQsCUtJdoQyitCqaNu9r+jB9yj9DXOlXt7vOwEipXsS/Q6lY
         0ozrrURlyClWlddvwnwoGZmUIyNECRNs7LYoYolPM7TUjlSJceKWhzM0KZ+BLvxalK7u
         Ai9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759158834; x=1759763634;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o6mF9nQbD4LRSuancZRW+yv6VyfhCAoAUv0K8HNhZys=;
        b=ggK8bvwR/A8/4gq0A6tfQCgNnuAoN4LmE9cof8nS6S5A36wubo5ZSlpnbjHPTokHbs
         aCC1w/QeoBMMs+zhglR+xxl/A6e6lVU9ZmpZfyN5+6VweMdVNnt+AbL5L5fy6mcjCG+e
         YZzz7csNyXLaWMfY4qvCEFyIiCYFIKx0e+Gm6auADrQgTzovsZXJeD0ESJtLHC4t46+F
         dDZC60oeWGkL21SCwRG8OCRZeHsxkp9H+83w9DMClx8lmiVAyoXTE3Pg8mNzf34FOHFa
         9nIBu6m14l8e+BX7zk92AMz4jMlAX2PrLRXR0FF0A+fxxxTyRZ4oXU1M80uTU0Q7k/cA
         InPg==
X-Forwarded-Encrypted: i=1; AJvYcCU+4UEnRPwGxLLyOu0xE8euLi+9QPUqhSTp6fJkczwCszvmdfbHcFGT2ul+Riip4FzbOn9QQoluhj2MScg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrjbtSH5wi0ymJ3wBgnXxHHEvgLhsbwXlaejkGfxUqdvxJp7QC
	aaLMynZZJ5Cybi1lvdPamdTloSS1q6w+eYXmu0jvwMcDo6dvDXr+97aeEgTk1Q==
X-Gm-Gg: ASbGncspij2t7K6tX4J6v5Esjbo33qAJGn0PGxgoWH7asf8nMfDwc0FEqG4aT1o4Mhj
	robeJZvh4pxYZ2NsljJV2hKhKWIQmXVrPvmUiSvf1dbsNfft++t05k+Znnvr7rCCcV6K2hZ3ZD5
	xdekuAKkwox7GVuua88nfqR8ixrRHouoOP8Gpl2YvSjcUdaBVjftm++45lkefzCJopmwBbS9CZB
	4DqrHRgzSwZmS0U21G7tGD35gK3xjMrpOcv4xI1r1SxnE7DHCZQajQ/RUxKH1RD/4+hoLsIAtOq
	0eES4hwqkPk2bLI2KU+jfS+fPy/pskni4idTdhbCIkdqxwI21lJ5NrdWGzdppkZTVjhnG9A3kXp
	cMCl6IoOEqnpdNeqVaMlTfM/n+hLXv0eDokM=
X-Google-Smtp-Source: AGHT+IHcv3ftyH9hMXSkvfjyOuO+c5Je5bR/mBSz77yt6PmvfNC1qaPGB+c7uga1oDOrqUh5Arr+tA==
X-Received: by 2002:a05:620a:44d3:b0:86e:21a4:4740 with SMTP id af79cd13be357-86e21a44804mr227342085a.86.1759158834494;
        Mon, 29 Sep 2025 08:13:54 -0700 (PDT)
Received: from ideapad ([130.64.64.34])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c2718e1basm882498785a.1.2025.09.29.08.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 08:13:54 -0700 (PDT)
Date: Mon, 29 Sep 2025 11:13:52 -0400
From: Ivan Pravdin <ipravdin.official@gmail.com>
To: Tomas Glozar <tglozar@redhat.com>, rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] rtla: fix buffer overflow in actions_parse
Message-ID: <gtchr4tuxau4gh5cfsm2rafyni77uuak2orros6byvw5dlzyyp@z6j7jojwegux>
References: <cover.1757034919.git.ipravdin.official@gmail.com>
 <164ffc2ec8edacaf1295789dad82a07817b6263d.1757034919.git.ipravdin.official@gmail.com>
 <CAP4=nvRPXq=_WterXhaxk1ZwDSPwkJbVJP0L+ze-Cjw1foqK+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP4=nvRPXq=_WterXhaxk1ZwDSPwkJbVJP0L+ze-Cjw1foqK+Q@mail.gmail.com>

On Fri, Sep 26, 2025 at 04:32:52PM +0200, Tomas Glozar wrote:
> Steven,
> 
> po 8. 9. 2025 v 4:06 odesílatel Ivan Pravdin
> <ipravdin.official@gmail.com> napsal:
> >
> > Currently, tests 3 and 13-22 in tests/timerlat.t fail with error:
> >
> >     *** buffer overflow detected ***: terminated
> >     timeout: the monitored command dumped core
> >
> > The result of running `sudo make check` is
> >
> >     tests/timerlat.t (Wstat: 0 Tests: 22 Failed: 11)
> >       Failed tests:  3, 13-22
> >     Files=3, Tests=34, 140 wallclock secs ( 0.07 usr  0.01 sys + 27.63 cusr
> >     27.96 csys = 55.67 CPU)
> >     Result: FAIL
> >
> > Fix buffer overflow in actions_parse to avoid this error. After this
> > change, the tests results are
> >
> >     tests/hwnoise.t ... ok
> >     tests/osnoise.t ... ok
> >     tests/timerlat.t .. ok
> >     All tests successful.
> >     Files=3, Tests=34, 186 wallclock secs ( 0.06 usr  0.01 sys + 41.10 cusr
> >     44.38 csys = 85.55 CPU)
> >     Result: PASS
> >
> > Fixes: 6ea082b171e0 ("rtla/timerlat: Add action on threshold feature")
> > Signed-off-by: Ivan Pravdin <ipravdin.official@gmail.com>
> > Reviewed-by: Tomas Glozar <tglozar@redhat.com>
> > ---
> >  tools/tracing/rtla/src/actions.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Could you take this simple fix? (Might require tweaking the starting
> letter "fix" -> "Fix", I don't care that much about it, but as you
> said, tracing requires capital letters there :) )
> 
> The rest of the patchset conflicts with [1] but this one doesn't and
> is also more important.
> 
> [1] https://patchwork.kernel.org/project/linux-trace-kernel/list/?series=999703

Thanks Tomas. I will monitor it and rebase my patches once it is merged.

> 
> Tomas
> 

	Ivan Pravdin

