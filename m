Return-Path: <linux-kernel+bounces-798857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1932B423F1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 934DF1BC3243
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DA521A447;
	Wed,  3 Sep 2025 14:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V4Mnb8+Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955891C862D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 14:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756910675; cv=none; b=J+4TqjE9J8u/ucfLrFSCVxPXDjg7+XuvlP0sx1qZBgiV3Pq+nXWtQ/gm8If39AWuxQq0wkybW1abuvErWb32MpckzTu4444urI/o5u076P8j1hySe/LD2LGwODa3O5+I4AjrsRhARB+vHXxYskr2DGb50LvhgXN3+1KGPI+l6/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756910675; c=relaxed/simple;
	bh=K1yuBMDpnPOt4/KeRFVE2CusvjBh1MGwKZHLk7xzD4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3ETHcLPUgUL70WMU5QhTFjXnrXBh9twdyPS/RXmeNao3toSfZypYd1g9IkoKa2ZmFl1FScp44QtPWMt5J6ZkfHNuNKAae4TfD5MsL5LQiAckFa/VL8XbZh0oppcOPBGPqN/+4Q0VbRbavqnjY88E5ciidZaZTykpY0mp8ZgnLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V4Mnb8+Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756910671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hJy/79mHdukukK/k7N0QCn2psTcagRNxoMm4TPphiNQ=;
	b=V4Mnb8+QfGMolnwkYgJnEZAdvY1uCo9FDDfds9MB/z+wm5XF7hB4SzhR25NHUS1GwaaeGa
	h/J2yI2EzuP82xw96t4h2resTtJxG3T+lTnUEXKK/Zo9EXKFnNUHjtCWU4kt749tFmjPKM
	gttt0cQkyYlJV1bui/A1uisgWJWtFf8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-4bfc_JWYOeyOy1cGgeSsSA-1; Wed, 03 Sep 2025 10:44:30 -0400
X-MC-Unique: 4bfc_JWYOeyOy1cGgeSsSA-1
X-Mimecast-MFC-AGG-ID: 4bfc_JWYOeyOy1cGgeSsSA_1756910669
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b467f5173so38425e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 07:44:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756910669; x=1757515469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJy/79mHdukukK/k7N0QCn2psTcagRNxoMm4TPphiNQ=;
        b=gVNOsZSdAjS9v1e81ZpNSPVcPWzH/g4zl85S6j554W3HDohgYAh26iqFovSCkD4Unl
         myYCeke1Nw927Ve25oSLNO1XV7tiQLO4iUhZnbBsR8L0D12nRELdSm+8EOy/uyl5bgpd
         NIbe/GVuwZ0T4gHFp2URWYjDl34rHLcAzf8Ztdf67Fl88F+Sc9QZ2gnJLxnP4aAdc/gU
         02vrT1PLKaTjLB7z+2+i6qzBDWSTvFsm6tScVcpjiGGAebRp6zmvK0U+furqLniaS7oy
         8DHSkiYDmN2oK4MiVNalH76ya2SN5uJy4iy9pwdrLkVMENadwrAPw47jxpFPfjnKBOxu
         jGqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgOcg2Frm5f2hr+0k+hBw9GL9RUGBkS3ux6/UpiiC9I6bN5BfbSee8dJ2RPnnxbjvCjA9fb75Y+7+6tK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCLaKejDnFln3D+gNy3DS0C3RSexPzYiulpUx6F/aKW1Y/y1cU
	WpMNwwdlBQH1YZ0F76DVrpKOkZTYjCXvAv1fumLAc7oJvurwQUtdjetL4iC+/wqxmUX0NJC3Ewq
	+kHka6zcRZpn7SKT/Jy9oxVwNhOXDQa+hRWhKJLlkrc3e7E2aGLMvbQBeTfxRF4v03w==
X-Gm-Gg: ASbGncuM/dbafvoJdY6BXA67lofV/66qOx7jJ65ee6e0jtIKf/bBEhsdI0wcSBEwTHi
	UxL6OLmnuIZ2bOXSfjNgqC9owsdhTYbZ/BJ5eKOyqMSfJrzNa2KjAgp4rDMB1UK6oWMllsYVsbo
	66GqIay2tmWEYQlh3l1IqQ4bh57sYEvRM/+IuydaUo0k8PpTrZfSQyi+J8dg+pkTIFo3go2ulLC
	f0g0ScaiOg5t7+DW6zapWzGRjwUTqQzyvIgvAGTotElJS9fFsGaQ+tNSUNFlFaWl0H9ZyYgCwQM
	bO0N8egKkC7KUZsUwTE5fAgKbhXlq5Sg+chSsWzABUEI+lPH/XtVQaXWRME/QvKXGG6d5gU=
X-Received: by 2002:a05:600c:1e87:b0:45b:47e1:f5fe with SMTP id 5b1f17b1804b1-45b855c0d3dmr110370935e9.34.1756910669125;
        Wed, 03 Sep 2025 07:44:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKbkCMZ4LvPme/EuBzwbZA95CEfK10pvDin+qYg4BSO4x2L+ewZWsEmuElBxgPinCjh7EOCw==
X-Received: by 2002:a05:600c:1e87:b0:45b:47e1:f5fe with SMTP id 5b1f17b1804b1-45b855c0d3dmr110370615e9.34.1756910668723;
        Wed, 03 Sep 2025 07:44:28 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.70.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e7d2393sm242270935e9.3.2025.09.03.07.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 07:44:28 -0700 (PDT)
Date: Wed, 3 Sep 2025 16:44:26 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/16] sched/deadline: Clear the defer params
Message-ID: <aLhUSknzOOOU3lKJ@jlelli-thinkpadt14gen4.remote.csb>
References: <20250903095008.162049-1-arighi@nvidia.com>
 <20250903095008.162049-5-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903095008.162049-5-arighi@nvidia.com>

Hi,

On 03/09/25 11:33, Andrea Righi wrote:
> From: Joel Fernandes <joelagnelf@nvidia.com>
> 
> The defer params were not cleared in __dl_clear_params. Clear them.
> 
> Without this is some of my test cases are flaking and the DL timer is
> not starting correctly AFAICS.
> 
> Fixes: a110a81c52a9 ("sched/deadline: Deferrable dl server")
> Reviewed-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Thanks!
Juri


