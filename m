Return-Path: <linux-kernel+bounces-755551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EE1B1A846
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 18:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5BE37A1136
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 16:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B99205513;
	Mon,  4 Aug 2025 16:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a03HEvLS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDB7367
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754326745; cv=none; b=uNbPuxuu0pQU0ptb/REZwTiGRnbnGXBCfVWoMkhlc2ZTAC3cNTxmq4LILFWw1pZjwhsB79OcVbJGfRPVpNnEfETy6uDC6KZkjC4UJ4DtG4eoNfub8Xz8DpMNBuNFACZTfxeD7DTfFD8Jghj+xV/LYtjX2bQJ5yp0/flqE/JVq7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754326745; c=relaxed/simple;
	bh=mSKqow+Dp6TAnSZwSzE42iFAUePWX8xSgxo12KFlYJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOfSfbHEQYZZkx50NcfCDDaeMJ6ks0pcGUq+7BmhQD9xCTmz79xiyrehsouPRP0SSI47yes3cm9nWJUpkzUafeMqhCDMPuz94SYQ0jrkKJwEjT4h+0a2cbRjBTh6H8/PCELl++fYG+jxV3BMhhcS84yDAwDSkGB3uC5YRbK2z6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a03HEvLS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754326742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mSKqow+Dp6TAnSZwSzE42iFAUePWX8xSgxo12KFlYJo=;
	b=a03HEvLSlCA/Ks0Pz21imsjx9bZ+SZbt+J+7D3ttcnJlHBdOK9f120TnzOl0hWdRt/7GLh
	B/02NSiDNxvYSKVVYgov0BFXJzFc6rL8wwHEvn3Lwo2oW5zPL5VX08d9zQFkHkEUyL1tVC
	s6nrM5KiMybSX3HbQHHTJ5snJZ8tvfQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-ODJRRpwZPQqLsZeR07Zj8A-1; Mon, 04 Aug 2025 12:59:01 -0400
X-MC-Unique: ODJRRpwZPQqLsZeR07Zj8A-1
X-Mimecast-MFC-AGG-ID: ODJRRpwZPQqLsZeR07Zj8A_1754326740
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-707453b0307so77872766d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 09:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754326739; x=1754931539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSKqow+Dp6TAnSZwSzE42iFAUePWX8xSgxo12KFlYJo=;
        b=vR5ZNcusibiF60V5awyJwTKZ3BCXZP8XiK+w+7ZzdQNDP3Rv6p0zwPqH2RU5M48gKZ
         A34GNmjk+HfLh8fSRoN/R/XFVtPb+ifpW6zlrqUK9qeq3goxN5glSl3+sgfcdvugWHZ3
         +M/3R6yvaMjMpABkpL2OySEHpmPm9ZLaCEaXIgtwQLS2HNoCj1SuFgK3C9YF/6NC4xkV
         RnpyurTNe1dJfZbnMbiJzj7Z/DXpjv1LZ4OZVgHqztVWajwEJOK0Rhyf+n7HE59Jx5+U
         6MJEuoCrVc5IJ4l0UnkoWL99Fbxa2ymHQunPouP1s+ZnkoVS1XGJFim3X/hW9n0vDg0l
         Glkg==
X-Gm-Message-State: AOJu0Yy2UE5wQ8ExEtkB8y4OCmscluygybV+eXk1pRJnfHzq6WvWcb/V
	dHozGhWjV8qGLNZ7VGQ4YBlW6QssZPBXuL4Q/2FHKZuMQ+lkRz3k8jFnXZ2n8iACcsXXbMUXZKf
	dRcC4YLhzuSDL7pUdgQw2sJE5TbGHlRUAxDNORRC0a0oVX55+n0qMXLXcfQqV6N/XJw==
X-Gm-Gg: ASbGncv5Wc331/fiu3zTa6GxrC5lniZ/42/XZWJEM5Dj/+TXGypRwux14tSq9mNVEPv
	p7NH80XJXk/B6Vih0UEoA9/9AohvBt/AaMSPlQQXbUOPbeZviUxasQWuy0A1NCOojt7i5a0CH+2
	YRAqdDq521SXrNyTrLTK3zlirL+3Z5WinFI8hsXZq1tNKl7JD/GTTGPl1DjnipBZN1ZWw6QuXmQ
	lb8RVnLN/knxoTG5YbfRsdTLT/Ej7tbnYbvcWQTaMY6AV2a4CUrzrJ0mXyiwbOnFjR1yn/GdREv
	CFKNMPrA42y/KhtvUOjl4NHDsbZwifMVSSnaIcU52TH6nq9tfFVmrVcwoN/fX4c9kOljC5xjkti
	IPY7GOztTyF9F3nwo1V9tTh0=
X-Received: by 2002:a05:6214:2426:b0:707:45dc:c36 with SMTP id 6a1803df08f44-709362716f7mr133469996d6.29.1754326739591;
        Mon, 04 Aug 2025 09:58:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4oWP0cG7esuJ3rkrVZ4uk42RBpM4AfhIQqo0OaVSqq7FYm3r39Mn7WIOTpYLsvWo+7hjR/A==
X-Received: by 2002:a05:6214:2426:b0:707:45dc:c36 with SMTP id 6a1803df08f44-709362716f7mr133469676d6.29.1754326739084;
        Mon, 04 Aug 2025 09:58:59 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-2-102-14-151.as13285.net. [2.102.14.151])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077ca2ee44sm60159476d6.29.2025.08.04.09.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 09:58:58 -0700 (PDT)
Date: Mon, 4 Aug 2025 17:58:55 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: David Haufe <dhaufe@simplextrading.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 6.14.11 dl_server_timer(...) causing IPI/Function Call
 Interrupts on isolcpu/nohz_full cores, performance regression
Message-ID: <aJDmzxq1mB_DxIFV@jlelli-thinkpadt14gen4.remote.csb>
References: <CAKJHwtOw_G67edzuHVtL1xC5Vyt6StcZzihtDd0yaKudW=rwVw@mail.gmail.com>
 <aIsUwT1Ai0zcMRpT@jlelli-thinkpadt14gen4.remote.csb>
 <CAKJHwtOZkrR9kEj+tffq=o0i1fPi3P+8BTHz3RyPDmn=uDOF7g@mail.gmail.com>
 <aIyDfs1Dh0OGJEgM@jlelli-thinkpadt14gen4.remote.csb>
 <CAKJHwtOdiFTenF=zCL7_8c148Qs37r53k9uAKURLjq1JFJGeXg@mail.gmail.com>
 <aJDIZNyoehnzIqS2@jlelli-thinkpadt14gen4.remote.csb>
 <CAKJHwtMker+LXNk9L4Vp6nAKjW1P-T0n1VXSLn3piMwHsTWmqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKJHwtMker+LXNk9L4Vp6nAKjW1P-T0n1VXSLn3piMwHsTWmqA@mail.gmail.com>

On 04/08/25 10:44, David Haufe wrote:
> My apologies, I see what you mean now. add_nr_running() is not being
> invoked if it is the dl_server. We are still trying to get this branch
> to boot to verify ourselves. We will be on the lookout for this to be
> merged for release.

No worries, guess I wasn't clear the first time. :)

I added a very much experimental commit on

https://github.com/jlelli/linux/tree/upstream/fix-dlserver-1

that seems to be able to remove the one per second dl_server_timer and
start it back as needed. But, I just played briefly with it, so I am not
fully convinced is what we want. Anyway, if you could test with it as
well it would be a useful data point. In principle you could try porting
the following commits to your current tree and check if they do improve
things (in reverse order starting from the bottom from the branch above):

f237e524f3c7 ("sched/deadline: Make dl-server nohz full aware")
219a63335b67 ("sched/deadline: Don't count nr_running twice for dl_server proxy tasks")
7620177e8108 ("sched/deadline: Fix RT task potential starvation when expiry time passed")
cccb45d7c429 ("sched/deadline: Less agressive dl_server handling")

Thanks!
Juri


