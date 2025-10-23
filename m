Return-Path: <linux-kernel+bounces-866388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 408F9BFFA4D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 41BCC5674E8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0802A2DF120;
	Thu, 23 Oct 2025 07:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LggMQque"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA472D12F3
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761204446; cv=none; b=gBR00dE/FP+sGzANvKqf9Nb5/5eKOiCkllqThTPbXAZXFM1SH7MaABsZHDyVrxFerRyiPliw3m48wZYhFymq8zcHmNhD/xaTn4Ae1QXNAuI0nn1mazuAWhSpPnJZf5XfPFdk+UIQy20OyPx4wX/o2dRHLUTN1Hnr7z3S9tfuMPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761204446; c=relaxed/simple;
	bh=8/5K9eAYciCjEruM5Zibg8pGJ3jERfSSQATfRjIM+9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ab5KHG5IxGUJFCYwvOA2B+oWIoEpMK6MJRlnqprDF32i7G9t9FY9UT1/vF2gNq98BZZGyHFLIokXp+syuD7FEv0WwbTJEmJ3+J6vL79kzxhthoewJMAChhQVgX57V5D1Z2mQq+xPrF/8TWYPpgjmcX7sroROJSPVs9lp++uRLRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LggMQque; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761204443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DG8PNGqN9vkrYVCbE8yOrVABvVSKGUm+P1uN2AY5Umo=;
	b=LggMQquecImt1qHp6nv1VsVfDabyZHUztylFjq4NYgq8xgW9k4fweLPUeLM2bsm96q/gcZ
	B5eNJNds3zIF6DcJ/O2Imxcn4dFWoKSRj5mKTPLR5dnHpOcfXPL5j6MwMk0CTbvRZ+o1nc
	AHosp02Cl4NSsPXX/EcEy9V66RCHiU4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-nDrVEn9RMq6-rtB0gR-yyA-1; Thu, 23 Oct 2025 03:27:22 -0400
X-MC-Unique: nDrVEn9RMq6-rtB0gR-yyA-1
X-Mimecast-MFC-AGG-ID: nDrVEn9RMq6-rtB0gR-yyA_1761204441
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b2d1072a9c4so40165866b.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 00:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761204440; x=1761809240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DG8PNGqN9vkrYVCbE8yOrVABvVSKGUm+P1uN2AY5Umo=;
        b=OY7aiSCngV54R1qfTd/kERnKJZ1vwEl18rOw0L0INag/fk6hOkWviJvAFZJ/3uJEqy
         l6teUSd4+rWGZlDf25VNJNXOZB4usJz9fm6fF0KuW8EiT2Oct+kesnCQvICUVnB7at8Q
         7keltwIL65i0Gnir945THpC0XNc6vENyUj5oeEZbHDBlS4R02wPLm3kD4LWWhT02nuLD
         bBpMdndthZZjrwXZYnm910TrlUINJ1NBcwthPTyF5b9CKdPOsbQB9+Ms2qxPsEwJP0Dj
         fKLfs9PVfZ6a62yNeWiCIYA2UbhjHxykz05oen3l0cmWSkl5r9YWYCa8LH1/Yacew050
         iIGA==
X-Forwarded-Encrypted: i=1; AJvYcCXhMU9a5mkzZl3wCHZmG5inHWRu+OGrJiiVpQD1GgwV0YM1+KKZC+jfNPONgjWUGw6wp5WxzEnqAn+RJEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa7Xn1ZEtB+fqGeXFs2IOq9mRy9MKMuUtufynRgXpPqUg/Bnqq
	ngpmD0AhjbYYhcQzgt5EGZi+xEYW5B+u2AAEgTxzrc12KCZgoeqYiAbITqXbfdwLtUfYMPlWJF6
	VqKtZTIx+5BjOuBym//YHLHUjIL2JPqRbHuLw6kNGBSRsbHWA2g+0o1RgtTdjQAdF9/QJHJ28jq
	UbfqKYsAvZbvo0/csvX+jmGbuBRCC+2CrSolSBmlBLJTFhzGr9wW4=
X-Gm-Gg: ASbGncuqyf6aDrzRyd2Vnmmov8ieqIKpA6Kv3JnLq9b/DfXspLULaWseB9VWLsZtljD
	PWYMc+GdEIbUgG7r51pXxj/2ebNIP0m3TThW5JRB6xCP5N04WPZoAo2j0/OzqcdjC6La744weyi
	wJUdzn6k+RjlLj951EK6othwbPp0LWG/22pzpcFCj6JMp24mgCqntcng==
X-Received: by 2002:a17:907:7fa5:b0:b2d:a873:3a4 with SMTP id a640c23a62f3a-b647254f787mr2878744266b.2.1761204440586;
        Thu, 23 Oct 2025 00:27:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZ27BIVOiIIKoESU6vX18AGL0kiF+RteeOVJzjmhHSY4SfVh7aoV66uq3hLQBa2bdzRqLQNgC+AzIxCnDqx8g=
X-Received: by 2002:a17:907:7fa5:b0:b2d:a873:3a4 with SMTP id
 a640c23a62f3a-b647254f787mr2878733066b.2.1761204439185; Thu, 23 Oct 2025
 00:27:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017144650.663238-1-tglozar@redhat.com> <20251017144650.663238-4-tglozar@redhat.com>
 <c52490c9c2f682fd3c30d6f8a198be2ba408c4fe.camel@redhat.com>
 <CAP4=nvT8VGpYrqQDztmB1WJPEb6JXvUuL201ksWq6eSV7kn-oA@mail.gmail.com>
 <aa0bbfeec78bc90966e660af91eb39acccb77d73.camel@redhat.com>
 <20251021130232.2ca75863@gandalf.local.home> <321181e1e5060f0c68e0430d69e0e89688b08235.camel@redhat.com>
In-Reply-To: <321181e1e5060f0c68e0430d69e0e89688b08235.camel@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 23 Oct 2025 09:27:08 +0200
X-Gm-Features: AS18NWDdem8rxzJpkw1zU1ZUIDezEHdLWHqSYOhrxty7K73bR0FqOQHxEIBAHfk
Message-ID: <CAP4=nvQGM_L3dpVpb36umrwZiCT+S4kGQOfENHBXRRNcy0MA8g@mail.gmail.com>
Subject: Re: [PATCH 3/4] rtla/timerlat: Add example for BPF action program
To: Crystal Wood <crwood@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Wander Lairson Costa <wander@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 21. 10. 2025 v 19:32 odes=C3=ADlatel Crystal Wood <crwood@redhat.co=
m> napsal:
>
> On Tue, 2025-10-21 at 13:02 -0400, Steven Rostedt wrote:
> >
> > Note, trace_array_printk() (which trace_array_init_printk()) only works=
 for
> > instances and does not print into the top level trace buffer.
>
> Yes, it's for instances, such as the ones rtla creates.
>
> -Crystal
>

Right, it actually works with the trace instance, when set up properly:

[root@cs9 rtla]# ./rtla timerlat hist -T 1 -c 0 -e
bpf_trace:bpf_trace_printk --on-end trace --on-end shell,command=3D'grep
bpf_trace_printk timerlat_trace.txt' --bpf-action
example/timerlat_bpf_action.o
# RTLA timerlat histogram
# Time unit is microseconds (us)
# Duration:   0 00:00:01
Index   IRQ-000   Thr-000   Usr-000
6             1         0         0
21            0         1         0
over:         0         0         0
count:        1         1         0
min:          6        21         -
avg:          6        21         -
max:          6        21         -
ALL:        IRQ       Thr       Usr
count:        1         1         0
min:          6        21         -
avg:          6        21         -
max:          6        21         -
 Saving trace to timerlat_trace.txt
    timerlatu/0-47791   [000] ...22 863353.286497: bpf_trace_printk:
Latency: 21282

Tomas


