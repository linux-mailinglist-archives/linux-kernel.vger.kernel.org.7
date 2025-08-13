Return-Path: <linux-kernel+bounces-766319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A85EAB24515
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22FD77B1681
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBB62F0C50;
	Wed, 13 Aug 2025 09:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g2pu3haf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DC7264614
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 09:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755076525; cv=none; b=NaKcv/tqIBXVJoT/hXh3mkNGRpBWtPsmXITHnN0EO1Sj2Ag631OXGgfFGYB1riatpVHf7ejJCOqTLxGvdS9LaFDzhYDRmdYA3945kTeT27LCcEGqwDeSFYhyixNjem6XNhFN+NXSzmYRcVrGMxmcdLGoGiehTzU10V+eh2fqOMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755076525; c=relaxed/simple;
	bh=FJ9S9xsVuGUMDuUEQIwBA9l7/TjDR/EkMLgbR+IWJmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlNumtvZSoaiq/HjOjzLbbhGxivocPuXCa4EDGZB9qX7oZumnaNe8yDu77M41phlj8R1E/sDa3dyQgqbsUoq4tReOo2sMx0YwnOQzYUD34Bmk3Qo7YM1aS8f39hdMuj4hCY2/fa1I6kwdSyZrHJ9bU62VURXrCGgjeFn9tja0RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g2pu3haf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755076523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FJ9S9xsVuGUMDuUEQIwBA9l7/TjDR/EkMLgbR+IWJmg=;
	b=g2pu3hafULZl2Gjy0QnotVZBXls4jmPUhmM36YVfpxeUlW4seUijqG1+AekF0h6ebJqVlt
	1w1wfe9XDfm8riW8pyi4H4LAuNwFjsEv9EErPojCYPJIJF4YdRQNDeuS3joZ702nDAL/bA
	jlK5P/TLkOVeITJ0nheNTHJAsvqq2sU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-C9fJHdf-N0CFPphXHZT-_Q-1; Wed, 13 Aug 2025 05:15:21 -0400
X-MC-Unique: C9fJHdf-N0CFPphXHZT-_Q-1
X-Mimecast-MFC-AGG-ID: C9fJHdf-N0CFPphXHZT-_Q_1755076521
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-709e7485b3eso12756896d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 02:15:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755076521; x=1755681321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJ9S9xsVuGUMDuUEQIwBA9l7/TjDR/EkMLgbR+IWJmg=;
        b=WZe8lJ3RCC2K0DmFMIcVLcfj3WLc9RmGiL+sObmgnEky6NP2H6Q+m388ytujyzdOGQ
         qETzvShOCFzSUivia2Eu5FJzu6Vw+Exr3TWgHmk7eGzEs6J5KpIRiBtYQzjiWigoWU79
         yt0VrO721U+MtqGqGIB/hk19XtiTekyLYCKb7HS1w3D45OaFUKIn7qnloISw5ZZYa9W8
         30TjhoSim0tZiSbSIIrgelTu8ReCitS0vdpuHs6Lzp2CAckUsARO866sc9v7hs95q4S5
         +phiOmtbsYy/WcUVAwHwqEPCx6w120+1PGcazod6AhJg7XOgb7tvkE2raVBo6z+cflnY
         Ngdg==
X-Gm-Message-State: AOJu0YyzgGKETbYBnoyP2IRKdGfUKucMQ66hMx8yCAPFYnJ7NoC8aTxq
	WsUWuXJ21D9P4uTAF4qzJhxma0l1Y0PWeWleiBUnHAMfxHUr3FL5JwFb/qatzJi9Mwxfy2gIkD3
	qrSC/lPNzXwjEInp8QAmzXgSUsoi8+53dh4Wrv/lb4J9a26igOe05U4R0JjS5Nf6HZw==
X-Gm-Gg: ASbGnctkQlDUC2b45ti+Ae0l6UoBLLfA1CGJDC5AhYephw0nyphNIpZVM1PZWBIPqLa
	WA1DwtVe2Ntd/pvoy1sDgCxcTxXzoA4nxAS8QbzrGqgiT8/RQ8U4sKvFIhghM6JqAl2GcTY+2tB
	aG6mNO6tMqbGE0N74/r/3ACOEbraSb59F3magFA9B6cT4+KYV3XzzcvR4dLLO7yIBEF9E3c2alw
	AEFbG2lU5RMXL8L5P6oYuk/BXhdu2fpsflshBM0m/fck/PxZzeVTUSF+ThjjVeHZxF/zjBoC8/T
	y2Y5Fq2gzVipa94sMTBA6sGGnmVmRDI9YbkaLlYbnzpkm8xRITQ2JvNlo/K0ueoHZBJm
X-Received: by 2002:a05:6214:623:b0:707:2b04:b038 with SMTP id 6a1803df08f44-709eb1feffdmr19627326d6.23.1755076520579;
        Wed, 13 Aug 2025 02:15:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEV/OQOwQfKOsKAz5wKdJV7tOoeeQil/sc1ZfgToMGixY0ksc6c2kTdU4P+wy3LssNk2AeWLg==
X-Received: by 2002:a05:6214:623:b0:707:2b04:b038 with SMTP id 6a1803df08f44-709eb1feffdmr19626886d6.23.1755076520004;
        Wed, 13 Aug 2025 02:15:20 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.43.47.41])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077c9da7dcsm190924776d6.12.2025.08.13.02.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 02:15:18 -0700 (PDT)
Date: Wed, 13 Aug 2025 11:15:10 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, bpf@vger.kernel.org
Subject: Re: [PATCH -rebased 00/15] Add a deadline server for sched_ext tasks
Message-ID: <aJxXnj4C2Nfp5mmI@jlelli-thinkpadt14gen4.remote.csb>
References: <20250809184800.129831-1-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250809184800.129831-1-joelagnelf@nvidia.com>

Hi Joel,

On 09/08/25 14:47, Joel Fernandes wrote:
> Just rebased on Linus's master and made adjustments. These patches have been

I failed to apply these to both linus and tip master. What's your
baseline commit?

Thanks,
Juri


