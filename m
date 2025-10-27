Return-Path: <linux-kernel+bounces-871545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EC3C0D9C0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F38ED4F92A3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79172301498;
	Mon, 27 Oct 2025 12:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fRjtJ3W1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555B930277E
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568254; cv=none; b=YdEwdNMKdRlbE+ovP5kuFxtDqmTl7Uo5kb1IU2Yzjz4GW29qSJBrpG2W0+GHSX1CfjkIsyTdybqci3LbDTe+4mGIsyOImsWnvR+4W3CGq7jqe9+SuveYZysTJ6DDmKcUrQ4K1YKS8By+PAGS89wHg/mNUQXRV00Q2O+ukCH+kpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568254; c=relaxed/simple;
	bh=h/EsNQAeyB/G+IQFkecZb+99buS8A6DJ2vzI+7KSK6k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lqCafIsaHTzNMoFH6EZ0dQFbHJYQ30giIVCZCN7/ycSbON2UU+SLdWvk50o43N6DbpUOYFYurQjwY7A8sBXzx9G6Mq9k1Xwfl6eQZai2c3Cucxth2HEB8WAAOEzgCsBd3ZS0JKfAdSTSRtYPJw4MvZw8Y3RM9qicNER+Sgh5Krw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fRjtJ3W1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761568252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h/EsNQAeyB/G+IQFkecZb+99buS8A6DJ2vzI+7KSK6k=;
	b=fRjtJ3W1UQKtDf3Atrg0O9MJjZl/UuhMarzti+jIkqlh2m4ZhG0ApRauv9g9nn4WM0NiWd
	ftSV1Md04ZG9gv9Np4OdW/looziZSHxPrx4MCweU2R0JCVQn5hMXfZDH+Iaty1eadi6lhd
	2yHLnWNJQF52Zv1a5hPoj07dfSfP3Qg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-bCa7Iio1P-2sbd0_x6jMUg-1; Mon, 27 Oct 2025 08:30:51 -0400
X-MC-Unique: bCa7Iio1P-2sbd0_x6jMUg-1
X-Mimecast-MFC-AGG-ID: bCa7Iio1P-2sbd0_x6jMUg_1761568250
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-88375756116so1751445585a.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:30:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761568250; x=1762173050;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h/EsNQAeyB/G+IQFkecZb+99buS8A6DJ2vzI+7KSK6k=;
        b=QFqSQ16khMLmTS5hTcMnj8eoVEn4Brl85Mm6NQqj/xjIVWSLeO0qPS2k4e7rjlmEpp
         UFLoQ8Bh0j5sEZNuYyQ6fKvUtYV/wxCMfB4DFz9/oukvFyTvvhfDYfboCUN05VYj29z+
         KqwCfLZYHD6t+/sMkGIQlPgQHQCcipOb08nWBRONgemb8V7oIA464QODZOPAWwNGDc+o
         EEmQylm8XB52A0LR3zpQ9+LAivhs92fbLGu4krZ+s8zGQ2I89kj66TLtqO8nNvmT72yr
         aBzcf/Z+l4S+KFTWb5FzWzCaBxUN9sf3t/r+KYtnQG+MUwwFj5qQQ4Xol72inwg10mhx
         x91A==
X-Forwarded-Encrypted: i=1; AJvYcCV/fioL0+EUasNtZenfQNKfKVSoi02XMdD6kHhbJ9H0byt2ISwRFz+bQ+JM64G0u4Gc+iHWQeNZNVvrU2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX9ZijR4P4/QFkQlz/1wvK6DV+/O2EsE+wIHIQktHEoc+szAkO
	EE3c1CR1Kb6uIfwUB8tksg8A2Vm2js24COV+uwlRwxoAtZ5GhXqK6mK96byywpWYjISuM4j0Afd
	dsKZ1l/uISnNWRaU/5wu2pHUQVFmK+eSpHiosItHlc1bGULn4jL90GCvQnv9YSXa+UhOtf9HJ0Q
	==
X-Gm-Gg: ASbGncspIMWFUpf2oqFeueXxwBGy4p+kebaaz3NpbTIiworhrIHg20WvEaT3geAAREO
	JYaURo90lm6NvYfQaPFvwYUDNGuluyXF65zbnMan3/4LwWDsoxAIc/5iSZc/eiXl+bKcrGp/RX6
	sp2WORnSl4c8wLNNtyJTVwHkSjsbWDoJ69fuOHnsQwIP7wVGTqep+7oWb97R7gbSfTnQq4Mqu1P
	8jtzlWEBTRL0nIyrjqmbgPndYYTaqmxpHBpCs6o5JjRvXyqZWXuvcswxCsShPsGP2lo29kBpI4V
	eXj3Askyyr7t2blUGDO8fNftqaSAjgMKkjTw/v6fVUSPFDQH0U1CR1EiUV++hK2jQOHM0suyDvr
	sq1AlYFpRtTp/+vODbeH32Kb/bTSqXx45SIiTO3JJYY4WoIHkjyZ5UPAypLf3z87V
X-Received: by 2002:a05:620a:4443:b0:8a3:c4fa:9b75 with SMTP id af79cd13be357-8a3c4faa19cmr416254685a.16.1761568250140;
        Mon, 27 Oct 2025 05:30:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqG5ztW2QIF+ciOz8i/ASp+0t14nx+Sd6eK4WMCbAHgbOxkbgLtidRWt7KAhXpF+9VBgA4Dg==
X-Received: by 2002:a05:620a:4443:b0:8a3:c4fa:9b75 with SMTP id af79cd13be357-8a3c4faa19cmr416233885a.16.1761568248225;
        Mon, 27 Oct 2025 05:30:48 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb (syn-050-074-019-099.biz.spectrum.com. [50.74.19.99])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f24dd5ad9sm595808485a.22.2025.10.27.05.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 05:30:47 -0700 (PDT)
Message-ID: <17528ec0b9f6c8ff2492beea672d4b7950ef72af.camel@redhat.com>
Subject: Re: [PATCH 3/4] rtla/timerlat: Add example for BPF action program
From: Crystal Wood <crwood@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,  Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, John Kacur <jkacur@redhat.com>, Luis
 Goncalves	 <lgoncalv@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>,
 Wander Lairson Costa <wander@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>
Date: Mon, 27 Oct 2025 08:30:46 -0400
In-Reply-To: <CAP4=nvR86-pmQWdx8rCksp9Dj1mRvgS4961C6my0sVSj1h01Sg@mail.gmail.com>
References: <20251017144650.663238-1-tglozar@redhat.com>
	 <20251017144650.663238-4-tglozar@redhat.com>
	 <c52490c9c2f682fd3c30d6f8a198be2ba408c4fe.camel@redhat.com>
	 <CAP4=nvT8VGpYrqQDztmB1WJPEb6JXvUuL201ksWq6eSV7kn-oA@mail.gmail.com>
	 <aa0bbfeec78bc90966e660af91eb39acccb77d73.camel@redhat.com>
	 <20251021130232.2ca75863@gandalf.local.home>
	 <321181e1e5060f0c68e0430d69e0e89688b08235.camel@redhat.com>
	 <CAP4=nvQGM_L3dpVpb36umrwZiCT+S4kGQOfENHBXRRNcy0MA8g@mail.gmail.com>
	 <ecedb0d1f2d0e51c56e462adf75df47e8d593a8c.camel@redhat.com>
	 <CAP4=nvR86-pmQWdx8rCksp9Dj1mRvgS4961C6my0sVSj1h01Sg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-27 at 11:34 +0100, Tomas Glozar wrote:
> p=C3=A1 24. 10. 2025 v 3:49 odes=C3=ADlatel Crystal Wood <crwood@redhat.c=
om> napsal:
> >=20
> > OK, but as far as I can tell there's no way to get the non-BPF "stop
> > tracing hit" messages without adding a call to trace_array_init_printk(=
)
> > into trace_osnoise.c.
> >=20
>=20
> I'm not sure what you mean. The --bpf-action functionality is
> exclusive for BPF mode, bpf_trace_printk() / bpf_printk(), as Steven
> clarified, is a BPF helper that triggers a trace event, defined in
> kernel/trace/bpf_trace.c and kernel/trace/bpf_trace.h.

This was from a tangential comment, not about --bpf-action.


-Crystal


