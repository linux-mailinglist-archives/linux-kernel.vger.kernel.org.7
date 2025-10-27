Return-Path: <linux-kernel+bounces-871342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA60CC0CF9E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76F6718914F8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02EE2F693B;
	Mon, 27 Oct 2025 10:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jSOGqmRS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2732F2609
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 10:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761561294; cv=none; b=cJfGzrKk1JoojLiBlPN4q6p7h0+0R0rTQnYR73bi1WYXuV5BryRPPUzMfOcO0tesTWjfLF02MH0jY/DMaISvngxWprIUEMDXvbcAqvNDUPXR53FJhTbL6xsJIgJLHIqV2HN2Rforcisyi/vFm4bGL8d73Gx/bMrWMNgPqj8Ezh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761561294; c=relaxed/simple;
	bh=0zfQEgX62c0H2fOQ9iB6Cl5Nh9lHz1NMVAjMrWxNOMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p3o13pQ2QMQODOiLqiaTT9IMcviyPrWaKMzsgxfn0Fptwwod4g9AASc8YIhSMEJnvUQLY4ShhUhBvO6Vk4pRV4Jq5Dkjo29VWteGUu2lA79PwAKie6WsrAkSWfK8MOYuq2y2n7J4CytsioVO7EU5zcjFDBoNfjCVUzxmstQOgoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jSOGqmRS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761561290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0zfQEgX62c0H2fOQ9iB6Cl5Nh9lHz1NMVAjMrWxNOMY=;
	b=jSOGqmRSqqOechJ8OzUt3h5hyWUQ4+/kqeGp6BdE/Sov8+hfRdEGCxuv+flTv8VZNB/n3w
	xnu448uvraqdqMfPxw7cKzLZetO94hTt6I/yhW3kuVTVfhsJlD+GY9C/BFoSvzqvtyCwfS
	KsLPVi1ZXZeq1YJfTww1Z/OBa0QlR8U=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-myYWsG3KMrGQ7ZEZX_VgqQ-1; Mon, 27 Oct 2025 06:34:49 -0400
X-MC-Unique: myYWsG3KMrGQ7ZEZX_VgqQ-1
X-Mimecast-MFC-AGG-ID: myYWsG3KMrGQ7ZEZX_VgqQ_1761561288
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b6d7405e6a8so276392766b.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 03:34:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761561288; x=1762166088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zfQEgX62c0H2fOQ9iB6Cl5Nh9lHz1NMVAjMrWxNOMY=;
        b=BaWBdCmtH5WjLZeqXfFTVKs01fq5IfnSKSsHqKgAxQfhiJZIGj4jZgoA3MaUOpZtqT
         G2/JpUEzqURomwAnI6ftfInyu2y//fOm65SaEWqhg6TisucNXfs23GjpHyS3lcvXMLSp
         HQsSVxRuJ1uS6ikYVGcc0ckcmcvEGMSKTVX+QvOFAw6BGFNtNuUXEUsgGPDaxbL1ISeN
         ivKyHEWB7PwL7De9vDP2Sx2yyKS3kaWt5OTRdMtofJyvEhkS6wYQRR8r5ddWBQx2aNql
         harunCDPdK3orOXNj3Jq3HFr4K4C3gGND/H9DeeHAqOsxiaOLBQ3VO+IlIQY0jAwqKDw
         IcjA==
X-Forwarded-Encrypted: i=1; AJvYcCUM2oEls7pPcDjfCwi+1SUa8K1NfGs98T7iGerFBl2DUYRMH9VkBffgsWs09hdCK2W8njHssRYkNPYDzOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTkNtBQCQfyN5bGbvS4kNI7ebBOhRBIcnZbDTUniCMyhBfQ9EC
	WEIIrCdJX0LHa//I9UksrRRRIRyFFYT23Fala2P8SEeP3/ExLm03Wc1sd0lCfV3KaUl/KKRMEQl
	b9DqIAFGR8lYhhV3NU9pX6vGS+Uk92uabeAqABFa3bMsnPi3+upgQ4FxTBxETopxCRm65wtLABK
	ErE7OSNKhdaGHU7louyKzJ31CPjoHHM5rgCdbDNCF+
X-Gm-Gg: ASbGncsb47GVzLDW75OSbqpL0k/akTYSFqccWJle+S6L7fVERb9CjQTjY87WeA09Ecb
	DiPSF/YI0aiFnLkOTPKn7TKvmKhWKHdWuIc2XJlfIoeNVrV88tS4JUWewoAPdikiXX9rasQnn/o
	Ws+2Ph4CsM1R4vTir04VmjshFcJHgQ17wEao5PbaIML8XmLm2VCCjQS983j4tfqaQCh72PI3PdU
	aS72Zd69u4OEw==
X-Received: by 2002:a17:907:9725:b0:b6d:5338:f6e6 with SMTP id a640c23a62f3a-b6d6bcfbbf1mr1050211666b.18.1761561288055;
        Mon, 27 Oct 2025 03:34:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHibjOYCk2sKkZzgs00m9DngU0+qufH2rg1LAx0LsarP6NwDbhgx9VF+0BCzU6yodoPha+MLbmyZv8fOXt2cn4=
X-Received: by 2002:a17:907:9725:b0:b6d:5338:f6e6 with SMTP id
 a640c23a62f3a-b6d6bcfbbf1mr1050208466b.18.1761561287510; Mon, 27 Oct 2025
 03:34:47 -0700 (PDT)
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
 <CAP4=nvQGM_L3dpVpb36umrwZiCT+S4kGQOfENHBXRRNcy0MA8g@mail.gmail.com> <ecedb0d1f2d0e51c56e462adf75df47e8d593a8c.camel@redhat.com>
In-Reply-To: <ecedb0d1f2d0e51c56e462adf75df47e8d593a8c.camel@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 27 Oct 2025 11:34:36 +0100
X-Gm-Features: AWmQ_bnyHDmK7R_EUxRmXlMxvG0jeeU550EUjV6zxo81kllIiout1FznW4JnhgE
Message-ID: <CAP4=nvR86-pmQWdx8rCksp9Dj1mRvgS4961C6my0sVSj1h01Sg@mail.gmail.com>
Subject: Re: [PATCH 3/4] rtla/timerlat: Add example for BPF action program
To: Crystal Wood <crwood@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Wander Lairson Costa <wander@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

p=C3=A1 24. 10. 2025 v 3:49 odes=C3=ADlatel Crystal Wood <crwood@redhat.com=
> napsal:
>
> OK, but as far as I can tell there's no way to get the non-BPF "stop
> tracing hit" messages without adding a call to trace_array_init_printk()
> into trace_osnoise.c.
>

I'm not sure what you mean. The --bpf-action functionality is
exclusive for BPF mode, bpf_trace_printk() / bpf_printk(), as Steven
clarified, is a BPF helper that triggers a trace event, defined in
kernel/trace/bpf_trace.c and kernel/trace/bpf_trace.h.

Either way, it seems that the event is not always recorded in the RTLA
trace instance due to a bug. It might have something to do with the
trace instance recording both osnoise:timerlat_sample and
bpf_trace_printk, and failing to record a trace event generated during
the handling of another trace event. So this is not a reliable way to
test the BPF actions feature, and I'll probably have to use my
original idea.

Tomas


