Return-Path: <linux-kernel+bounces-795977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE30B3FA40
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 951EA4E202D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DAF2E7BA5;
	Tue,  2 Sep 2025 09:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HHKWzOqZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CAA1684B4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756805077; cv=none; b=jUWrM4iI+pL2xAlAfOB0zRMZ/ytlNoG3RgeAcqI+N9we424BSp3J/FRJl9a45f8XiAIrEijWt2VG9OhXpkuOnHioal9NyTRGUACE/NNR5Fz/8lIoD7OSNtVnU8LfFJlgYzFP+eLVlmZW3m5/jPBf258RofCZWVhGvQnBYtSVkO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756805077; c=relaxed/simple;
	bh=uzBs+Qui2RRPDhdSVqAOWMcbu+hUwsfTpSzL8NvRnCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PyGCUmGtjxSHF/CDH0QBVTmRPOtGUgD6XZf8+tv8i6wvyxKa8JZGJHKpcUFFUPGjrkZLDpTzYurBICFtD3Nyt05xuihkO69AwGvXY1QwEgl7EWLESgWDxFBFGLnOu0UM9Kp+JSWs9EVwZ2g8/zekszzBZmPQcyK0FKhMIslg7Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HHKWzOqZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756805074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uzBs+Qui2RRPDhdSVqAOWMcbu+hUwsfTpSzL8NvRnCQ=;
	b=HHKWzOqZvXj+gsdLOUE18xUkrUxw1mHzWJ5grSMQi0S/QrDzcLfcTRzt2Tq214LORC1LnH
	PLsYmw2wzRyOJcxuMG52r6Mc5Fd/fpRjGL1P04+CLSsn7L6qzohgH1/do9/XImJtbnhrxk
	1rqmNMlFDLWg79SZUn4In13s243qbSU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-eUlHUXqZPtyGvK2rC1k4bw-1; Tue, 02 Sep 2025 05:24:33 -0400
X-MC-Unique: eUlHUXqZPtyGvK2rC1k4bw-1
X-Mimecast-MFC-AGG-ID: eUlHUXqZPtyGvK2rC1k4bw_1756805073
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3db4cfcc23eso103457f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 02:24:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756805072; x=1757409872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uzBs+Qui2RRPDhdSVqAOWMcbu+hUwsfTpSzL8NvRnCQ=;
        b=ByC8SGDrWN1E56G6XEK/+Em/dUZaqFiTpu3uU2INM+x+nCEdK5PS5elsjDqNVhb6KD
         MFvqNYTmpHzKpj5G9XfGWIQYGTaQ8m+D6z78JfIIQUloZqc8BFJ6LSHfpGdKxbTORM4w
         M1v4xQ6gPEmyWegZJc9piS9P95gMfCk/axu/HaxKvNOyuaRDNQ3Xs2UV7Pe4IH1xEbUE
         ZtmRro3xBKsDd8SPX22np2Giby0g7/LYAegLXKxMNjNp0vxB6pJGWstP7+dm3aR0k0Nb
         Gq8nm2dNEbIZEKZy28viRfRU6mQc3I7e72yXgCDEMsKkj7r9taISlstPBD6gWHXjax3N
         Xbvg==
X-Forwarded-Encrypted: i=1; AJvYcCWhZmPQFRgUDVLv9Oy1dV95Zie9lMl8cMp3LdoFh8zsTDO9ottkjelq6vQpotxbfyfQLpjeToN0u/1WWQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUaaPNasqDxZkCht3yh8Nyxiz2/aFSFSJL3q+uFGCcb4qePEA3
	sDZbMYBGhH0SSOcNRb52EexBzgkEs03QTq3/2kFCvTp//0xH8BLz21RoxO4X4MQ+igMY/27usHr
	HI2W8oH8evHjJSb/SHteyyZOO3+z2rg1+PCE2AXDPsge3t14O+a7wefQAx5L5d9FH9w==
X-Gm-Gg: ASbGnctFp7eF4OUSoq38ITLT1vF9knMrL+z9iZYCssmaf/3aIX1adHr2gg6Xyr2nF3u
	8xHusQF9+qQfMvSRzdP0zu88Sq07PClaM/i6a7suyRDFnPH6Wmo8os+3rsULvCoelZwgagyzqRz
	a+lNtbHIVEPACOk99wgiu4zXIWB8xNRD+ZHRrZjoiK59J5lXCVd5c2JX8EcB4teOjYnHbAOd1P0
	e8snhnbyKCZdN7DETTAYHq+8DWLLvldhP3e57vTjFSv6Zy24zRAzQ2/DR+r/nIBWnFxaAdQG4qX
	bknlIxzgOPca1z0a0zBzJ0Zc2de0A7Pfbf3fKbGukAuf4Q+cgDsOR96Q3iCLSTyIzY7VI8o=
X-Received: by 2002:a05:6000:178f:b0:3d6:fe34:1178 with SMTP id ffacd0b85a97d-3d6fe3416c6mr4492388f8f.27.1756805072532;
        Tue, 02 Sep 2025 02:24:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJeHhRqRvctjBk0CPN84447EeQQk5RRdkOyMZFbvN/DASY9WsTZPMvuvpr+NeesoSAtc65FA==
X-Received: by 2002:a05:6000:178f:b0:3d6:fe34:1178 with SMTP id ffacd0b85a97d-3d6fe3416c6mr4492369f8f.27.1756805072056;
        Tue, 02 Sep 2025 02:24:32 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.70.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3da9a6470f4sm1750487f8f.36.2025.09.02.02.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 02:24:31 -0700 (PDT)
Date: Tue, 2 Sep 2025 11:24:29 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Yuri Andriaccio <yurand2000@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: Re: [PATCH v3] sched/deadline: Remove fair-servers from real-time
 task's bandwidth accounting
Message-ID: <aLa3zdmyKuRMy3bm@jlelli-thinkpadt14gen4.remote.csb>
References: <20250901113103.601085-1-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901113103.601085-1-yurand2000@gmail.com>

Hi,

On 01/09/25 13:31, Yuri Andriaccio wrote:

...

> This also means that in order to increase the maximum bandwidth for real-time
> tasks, the bw of fair-servers must be first decreased through debugfs otherwise
> admission tests will fail, and viceversa, to increase the bw of fair-servers,
> the bw of real-time tasks must be reduced beforehand.

Hummm, but now I get an error when trying to do the latter?

# echo 855000 >/proc/sys/kernel/sched_rt_runtime_us
bash: echo: write error: Device or resource busy

Thanks,
Juri


