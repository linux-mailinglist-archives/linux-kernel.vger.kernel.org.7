Return-Path: <linux-kernel+bounces-755035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EC7B1A064
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 13:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2420917BADA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 11:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52D8248F7F;
	Mon,  4 Aug 2025 11:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JCgrTyYF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F5E22F389
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 11:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754306295; cv=none; b=YwL7AVj8qa9Stuf3YMCavtaZhrT9sTHscieoJ102H9IWvPl+LYwTPMy9uIC3ojqxOHEN1r0IFSEyDRvkC8l1J6Oh1vimyxHVSRHFKjMwRayieH4lsMGd1fDXocZYikP939yEK5kJe+q2bL+0OlGAv2gfTmgcTBCjdqw3rLoE2ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754306295; c=relaxed/simple;
	bh=rNIhMm1eO7HxaUop0BPQxJ7uenLWpMoHB3clUSIujBg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EazUTyGgph4dvL2htblCxRNBBBJIcz+s9xing2yk9dIyT/N+VadQNNh67f4T55mdziOUN9S/qyD1vbYpZ6l0kDB4olW+9EYO5kOvdHgXpKuJ+yOszz0csbZlMZ5rO5NHzdaxQGZASu10FAIwNtk1gtxG3jZlr8as23hEiUWohlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JCgrTyYF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754306292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rNIhMm1eO7HxaUop0BPQxJ7uenLWpMoHB3clUSIujBg=;
	b=JCgrTyYFkP0t3L52elOxsk9eHVdAJ3p3K4GPlV+o19WOClyMtA0IlPvA7T5XdLQkmmpRNa
	FsgCHEjDXiBQhOgmJ0+U/4vlqkptgTZO+QOQ070a63mUzahxNR+xQgsXv9NmsWkU0QDS+m
	ADA6mJbujLcKkDcImDeegqGEQFsWI6Y=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-ZxxO1b5ZPDSkjwycnMliHg-1; Mon, 04 Aug 2025 07:18:11 -0400
X-MC-Unique: ZxxO1b5ZPDSkjwycnMliHg-1
X-Mimecast-MFC-AGG-ID: ZxxO1b5ZPDSkjwycnMliHg_1754306290
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e69d69691fso130623085a.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 04:18:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754306290; x=1754911090;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rNIhMm1eO7HxaUop0BPQxJ7uenLWpMoHB3clUSIujBg=;
        b=ul7Oy7jrYaeeEkG+MBU0XSTaKOX53mq2CV1zK8o+Vcwv/SNlQnVKmMyXxTMYAboFtT
         V8nXQY7h9Bgt6mwflKcj22lx7/VWeyTQe8RIKI+4BJsq/BEivICkengpKsjSPQn8e/V7
         BbolEKUO2q0A3BOwnJi1LstSlmJD3k6OTN3DTKyzUTWI5TWwksSwCE2iTvIKtCmy6T4F
         wCzxeTVNrJwvgXs3CXyb2iGUc4ATnPcghkJ/QYeC0fPnp+DaJVjddGM7h1Tp10GHdtKZ
         fekNG5yMrFJwKJCA+wAtSqxvFcaT9wvvZEWMXusQk8imJZt8ojgSwjAiQSvtk+cdgqhp
         SGfg==
X-Forwarded-Encrypted: i=1; AJvYcCVmoJIpQwkxvsG4Eiz8pRb5pAVoRjwhI6vniMU1gPxZ/bu0HJSU2otZSBYU7yirH9G2cp/svfPKVdGKXbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYggFNq6a/dcoNy0KlErdQADeqbRz3GcMP5JNdiT+UbGFTvnZa
	SKHsjy8nlogUTd0m9EeMFhbtKbpAUdOv/9V2jUx0o3p5vYAk1NSgDHKM56Bj3S+e4Hw+FR7aVf9
	5KsywJ5kVM8C0cwRaGTdW+SdQNJmSPnqdHJLFDUgIMdUBVF5Ewq/IeNtcyra4Mi5+fg==
X-Gm-Gg: ASbGncuds7aD/2Vp3gG3X2l1MFH76gmGaFfVOlUrNnxzQyC+6Stt7MFwCmd+Btjr0S1
	Cg3e5q6C5T6wBr+vLHEdZdQNis4Nb+07YgeHDrVtMlJHpZcZ+kmfN7R1u8ZGigZ1SrnYRYNoVgm
	zkIwjZC7VYIOPPVGQHq0BgiQHjhCIPLktbhz09zErkZu6VO2ncxxEtD8Xqn+SJwZ5599B2wwPh2
	4VtEjui4sCLGpZkw7Cu8oNYMMhfxDztBph6r+ZHw+A7qCQ0WNNwGoYtmfzYth5vcZrMfAuJeI1y
	tiOgPDqoD8cUBkdUbYKXd4Boc5VmP6fkWHS1axfKwpodMdwFrTftsfMa17SNLharP18wrvjgxVc
	nkLAJHuYruxKO7EOZbg0sudAg
X-Received: by 2002:a05:620a:2907:b0:7e6:9cbf:7f41 with SMTP id af79cd13be357-7e69cbf80c5mr884629685a.21.1754306290387;
        Mon, 04 Aug 2025 04:18:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyGoHsyUPKOgOZHBXU4aYEjFjhjQj5Bw2+XAkZjBPoFITnaVJz3l6UfpEktxHb9auEhdPLoA==
X-Received: by 2002:a05:620a:2907:b0:7e6:9cbf:7f41 with SMTP id af79cd13be357-7e69cbf80c5mr884625585a.21.1754306289952;
        Mon, 04 Aug 2025 04:18:09 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f598a0asm532925985a.6.2025.08.04.04.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 04:18:09 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Aaron Lu <ziqianlu@bytedance.com>, Matteo Martelli
 <matteo.martelli@codethink.co.uk>
Cc: Ben Segall <bsegall@google.com>, K Prateek Nayak
 <kprateek.nayak@amd.com>, Peter Zijlstra <peterz@infradead.org>, Chengming
 Zhou <chengming.zhou@linux.dev>, Josh Don <joshdon@google.com>, Ingo
 Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Xi Wang <xii@google.com>, linux-kernel@vger.kernel.org, Juri Lelli
 <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>, Chuyi
 Zhou <zhouchuyi@bytedance.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>, Songtang Liu
 <liusongtang@bytedance.com>
Subject: Re: [PATCH v3 0/5] Defer throttle when task exits to user
In-Reply-To: <20250804075204.GA496@bytedance>
References: <20250715071658.267-1-ziqianlu@bytedance.com>
 <a3b3eefb208f06b0c55f889495376248@codethink.co.uk>
 <20250804075204.GA496@bytedance>
Date: Mon, 04 Aug 2025 13:18:05 +0200
Message-ID: <xhsmhy0rzz66q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 04/08/25 15:52, Aaron Lu wrote:
> I'll rebase this series after merge window for v6.17 is closed and
> hopefully it's in good shape and maintainer will pick it up :)
>

FWIW I've had this buried in my todolist for too long, I'm bumping it up
and will do a proper review starting this week.


