Return-Path: <linux-kernel+bounces-873388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 53940C13D2B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 763F1502C25
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDD52DCF72;
	Tue, 28 Oct 2025 09:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KLIskD7K"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ED835B124
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761643676; cv=none; b=TmgpiWPe9ex9NOPiLVwg/Q/9OvLbhmsPwSe99sul+DBHaZ2XoUJi7/1ReGdJeTcuLy6+2xA0ZetYL6QB6vfz5C1AE0D6Sly02tDPR/NBvpZmtXXxiq8GHAA9sat1sm6CQ/Mw+ANRAbdG+ae/a5zCgQ2zY15eXxOamqrU+OBAX8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761643676; c=relaxed/simple;
	bh=vMgKcmUijk5xAxok1rWDuN0GhFwUXgOZN19QAh1dZS4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rJMOx3hbYIxL3wB5h/6KAwK2khh4+VV+vwHR8vS/o5vkYQKKgGh7Xu+zIJa6ubbnniQV4nz7E5ShQyZOkiSdopeXKX7Id3HCjeLplJzltNUVRZFQzySEPC82Fkq1bg2sTYippFZYZlARsKJceMwIz9eTfuUBhztnWVFJDY7mP2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KLIskD7K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761643672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vMgKcmUijk5xAxok1rWDuN0GhFwUXgOZN19QAh1dZS4=;
	b=KLIskD7K7wv48ryodqFyWPybWBnComZc5xRS5FdXo5XoSJFPgjIMefmbAgtb5u/yUPMTIs
	PcxK0e2vMaeQTFzHcqp91QvjFvMTenTtHVnL5Zn2Y/gxcfP6Zu+C1e2s71+74xuTBlTXZ7
	vUuMX35vQ/tqCa5JmM6bDuAE08SiAjc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-pQnvj3UNONGFJOI7ZEvVXg-1; Tue, 28 Oct 2025 05:27:09 -0400
X-MC-Unique: pQnvj3UNONGFJOI7ZEvVXg-1
X-Mimecast-MFC-AGG-ID: pQnvj3UNONGFJOI7ZEvVXg_1761643628
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-475ddd57999so25986805e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:27:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761643628; x=1762248428;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vMgKcmUijk5xAxok1rWDuN0GhFwUXgOZN19QAh1dZS4=;
        b=qo+P7pWSQkPH+jiE0xrB/56205MGO8hggRkY6cpul2BSJlyL41KoCaGtaEFgw92u+b
         fGO/IG4oexgI/HPnmEPKqTRtnQsdDVVvd2PB00tejDvvY+KhoxE1IlO/fQa6psQT9jBF
         X/8qlg8EbgrUlwPTbqXtPsog7zr5btst2gyKdAClvrwk0A6KzGsjOkChBHiaVlT48O+D
         7fTb4tmbcFHHGt8fDuY4ZTXUoHze8pip/4dIv6WEtxSCxBPqpdl2XSyylgXKpXhkI7xv
         kEUEwBI98bqEyoFZr6ymKURL1zPYigkkmr212hd/Yczm+C3EXrYzfmYKTc6Nq6V5l/nq
         9WMw==
X-Forwarded-Encrypted: i=1; AJvYcCX11HoAQuV/y4CwNCtJpqOkaexHbq6y3YOSlYu4luC7biAP6FQgZJuKWfFX34/lOW30M0+7fTgp/I6g67Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzybK8OcrlCs0qMqCTCaSjm8KcHNLP/fWCUYLLXbA39Gk7SLWWv
	yLnJQb0Hw/Y94sT3EIHTZ4na9sOg9fk/6gNsPbYjNwi3WrfnzwrjMZeq8OlefPSlEX4U4glgtig
	mF9zP3dVilLXWIRoDShuAwjHaS7LVY68KT4aKiZGOIBb5M0lFL0iNjV0s/FpJ5tfEpA==
X-Gm-Gg: ASbGncuKFFiyiuJG4xm4jpoXdE7RArh4Jfh4S7YI4K4JbxC7p84Ye8u06K8dmzIqyUW
	VCw9AjFOk8D3AVnAhbXFuwxz17qFSEhL7G7VInqbCB1Jz8pD8072p1iQCvWcnnbhzw6aAhjWAMQ
	QxxUp6eHanMH6ilRSJgjC3BMMxSJcEqi3btlW0ocmL7CGxo5sLoTLWSqx01ugTyDMA6TRXy5rmb
	SuvZVkRGsDbj6VcZHff16vXuSlSCtcpyGz7R24bHuBpOY0rzTI7kMBZaLcPUaoY05Cj6benlGSa
	qT2em8dpRlakQODjINOWxQdXnZoYf+kX9MU9aeyE4XXO/1PKJg0go60KaCxsf2x/4A/zOMpoR8d
	4dMRqfYHatrnUnq3YDju2L6Q7zw==
X-Received: by 2002:a05:600d:4382:b0:475:da13:257c with SMTP id 5b1f17b1804b1-47718fc881dmr9599705e9.27.1761643627784;
        Tue, 28 Oct 2025 02:27:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9RzPzsWtqqUXoRcJrXn1UN+3rD5haW59x9hIYul5AJHvof/tfSMf4EIcxnGzRQ1Zzzg8sdw==
X-Received: by 2002:a05:600d:4382:b0:475:da13:257c with SMTP id 5b1f17b1804b1-47718fc881dmr9599455e9.27.1761643627335;
        Tue, 28 Oct 2025 02:27:07 -0700 (PDT)
Received: from [10.200.68.138] (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b79absm19048542f8f.3.2025.10.28.02.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 02:27:06 -0700 (PDT)
Message-ID: <d4b7c1635aee89c49416e26ef482238f4ee1fafe.camel@redhat.com>
Subject: Re: [RFC PATCH 3/3] drm/sched: Prevent adding dependencies to an
 armed job
From: Philipp Stanner <pstanner@redhat.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, jiangshanlai@gmail.com, tj@kernel.org, 
	simona.vetter@ffwll.ch, christian.koenig@amd.com, dakr@kernel.org
Date: Tue, 28 Oct 2025 10:27:06 +0100
In-Reply-To: <aP+kJeOEghD+sEsg@lstrano-desk.jf.intel.com>
References: <20251021213952.746900-1-matthew.brost@intel.com>
	 <20251021213952.746900-4-matthew.brost@intel.com>
	 <537bdebf2112a080ae92526ecfa41d63668d90a3.camel@redhat.com>
	 <aP+kJeOEghD+sEsg@lstrano-desk.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-27 at 09:56 -0700, Matthew Brost wrote:
> On Mon, Oct 27, 2025 at 12:13:58PM +0100, Philipp Stanner wrote:
> > I've got a kernel.org addr by now by the way
> >=20
> > On Tue, 2025-10-21 at 14:39 -0700, Matthew Brost wrote:
> > > According to the DMA scheduler documentation, once a job is armed, it
> > > must be pushed. Drivers should avoid calling the failing code path th=
at
> > > attempts to add dependencies after a job has been armed.
> > >=20
> >=20
> > Why is that a "failing code path"?
> >=20
>=20
> I noticed this after I sent - it should something like:
>=20
> 'avoid calling a possible failing code path, which allocates memory.'
>=20
> I can make this a bit more clear.
>=20
> > The issue with adding callbacks is that adding them to an already
> > signaled fence is a bad idea. I'm not sure if it's illegal, though.
> > dma_fence_add_cb() merely returns an error then, but the driver could
> > in priniciple then execute its cb code itself.
> >=20
> > And even if we agree that this is a hard rule that must be followed,
> > then drm_sched_job_arm() *might* not be the right place, because just
> > because a job is armed doesn't mean that its fence is about to get
> > signaled. drm_sched_entity_push_job() would be the critical place.
> >=20
>=20
> I think this break our rule once arm is called, push must be called as
> adding dependencies can possibly fail. This rule is called out in your
> documentation patch too. I've seen 2 driver posted in the past year add
> dependencies after arming, so I figured lets catch this misuse in the
> scheduler.

We can establish that as a rule, I'm OK with that.

P.


