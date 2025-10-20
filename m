Return-Path: <linux-kernel+bounces-860372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A3CBEFFC5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 670B74F0589
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BBD2C1595;
	Mon, 20 Oct 2025 08:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JE+T+XCA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8102EAB7D
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760949385; cv=none; b=p6EraYaDiJk/OR8EBn+sx1gNT51em01XRj7DocWdFNi0IZ5n36JzIOtNu7qxcurB9ET5xd0L2mQSr2Jp1NWeUpDrOT2yTZCXpv8BJAmjceyUVuETD2z4dRQg2ZZRHzCB5aAlv2smUV8B5eJWRZTCzfinIiMkY/98Qm/85oQvPos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760949385; c=relaxed/simple;
	bh=wzYeKe8llsS8xH05UqQBqkk5pJepcdnzGoYD0EgvANs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdW4vH6EQ7TeX4sLS+K6ri9vZtjyotRzpMtuENKa3/DJ0a7C92oGadLfrHO+9ynUu9BN0ys8/yXy/l4KBoSa0CI8Ya90oJhmu5+2+b/jS+/MTHw5gF8KDQ4IV4E59t1narZOoGFTQ092BFjQwd8lkTWhj1wI3szKI9NERfvBngc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JE+T+XCA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760949382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LDPZ0ul7eThbecq+UNdvM4KlBx5eDgTRibaStyKpTWQ=;
	b=JE+T+XCApnvv31aq5BvuV65PVpgUeen3+KaEzi97ptpHJn2BP9vaNG0j/Oqhx9GDWS1prq
	/FU/qLkRTRloi4Vae+1VlXRIvf4r7XdWqKsEIiiWs6sl1xxmZPZTHppEaNSLegqwQgVdM8
	G8DEBYa8qQsc2RANavpO+gntlW2gn5c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-ukOY4HeaNrqsumDUJpj57A-1; Mon, 20 Oct 2025 04:36:20 -0400
X-MC-Unique: ukOY4HeaNrqsumDUJpj57A-1
X-Mimecast-MFC-AGG-ID: ukOY4HeaNrqsumDUJpj57A_1760949379
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e4cb3e4deso14314375e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 01:36:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760949379; x=1761554179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDPZ0ul7eThbecq+UNdvM4KlBx5eDgTRibaStyKpTWQ=;
        b=H9YLjkNKdFX++3tzNZ6I+DKQOnmdRA/vXRq3LQZTTJ6+cEwLFZ6/R1JTw+aW5QUAKF
         dJAqFpavr3yXiNHy3HIXaWtXpmUMGvFqZZHhWrTKxFFPt3pe9HH53EkV6cYruJO943Yy
         qStX/mppX7VVVLjGNmbEK+QTQHIe0hnZIfjp5j66h47wE8LGHDt2hs4hBqNDRKx0B4o6
         3yyW6R3Pp7uhD0QG17d9iFZmX+IkGP/Wn97gWwybLoOyf7ViPgtgTyuo8nZ4tCZ2YxKm
         j5jVdbvYhjUTJxvKUXSRLn9sdG5E3zYIpIqIAECxBKvysKHoYY8/j2PBOgDuiCDzMh+7
         nx7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+4upoRYODUG23dPJOBcEtgi+26QuqaNMacgitZak66bihJuuNxO6qDmGp9e18PkKvU5QJoYBTYnmlT04=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbmWaWhbLdJvTpKNPuLbLV0adZdsCE0vxqK+1x/pTl62100Cij
	dwiyB8NUHFNt8qF8HnLo1fyXKEWfarMziK6U3sTg+bPYdHT7aID2o8Gprnb3C1PmdSfgl9dBPK1
	9CUGklW8+Z34ZDxwl2zqX8U7akJvQIzKHh1H5Bx2A25342ZTNvfspE15CY/R7G4X+dA==
X-Gm-Gg: ASbGncu/WRcBHXUI7xH4Vpd8Qfj+o9VAQEttH0OYAAqNWsYyGRXcZMnTl90K85XCCcO
	8e+oozE4zIkdku8CApACO8ov7uUslTTdL4Dhqylj9PkZaaLieIMzvAqPhOvW5Yf9MUbRgkeQJNd
	DDrxvI4DRFTDwk/mN8U4pKmp+ZeY/72zGPcqfDplTE9Lll4KlrQqwVPz9ea1/pxELB2h2ptd2bo
	HOWYC2n4xmgEw4xaeC/9rFVSKQpowEv74aIL3/8eaWhfSDCwSi12vXhGJz7sxO5OqC9km7BEnBi
	pz1WI7ea8BCH1MHcJj67/pPlFl9wgEY5bR5hQ+33F3798vfGn14RXdWXVf/oC8oW+C8MVV/EfLn
	q6I/wBix9Y0Cf+KN/Zl4caiHggOsWkcM=
X-Received: by 2002:a05:600c:6290:b0:46f:b42e:e38f with SMTP id 5b1f17b1804b1-47117345ffdmr107954675e9.19.1760949378901;
        Mon, 20 Oct 2025 01:36:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9PwoSk43ABFo5essiejYiBkUkNUIQWrYCuPXPAmRDQtUNGUR37Zqt6yI37QTO1Cp76s6VKA==
X-Received: by 2002:a05:600c:6290:b0:46f:b42e:e38f with SMTP id 5b1f17b1804b1-47117345ffdmr107954455e9.19.1760949378471;
        Mon, 20 Oct 2025 01:36:18 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.13.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4710ed9e7d7sm112564395e9.3.2025.10.20.01.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 01:36:17 -0700 (PDT)
Date: Mon, 20 Oct 2025 10:36:15 +0200
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
Subject: Re: [PATCH 01/14] sched/debug: Fix updating of ppos on server write
 ops
Message-ID: <aPX0fwMfPi1M9SL_@jlelli-thinkpadt14gen4.remote.csb>
References: <20251017093214.70029-1-arighi@nvidia.com>
 <20251017093214.70029-2-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017093214.70029-2-arighi@nvidia.com>

Hi!

On 17/10/25 11:25, Andrea Righi wrote:
> From: Joel Fernandes <joelagnelf@nvidia.com>
> 
> Updating "ppos" on error conditions does not make much sense. The pattern
> is to return the error code directly without modifying the position, or
> modify the position on success and return the number of bytes written.
> 
> Since on success, the return value of apply is 0, there is no point in
> modifying ppos either. Fix it by removing all this and just returning
> error code or number of bytes written on success.
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Thanks,
Juri


