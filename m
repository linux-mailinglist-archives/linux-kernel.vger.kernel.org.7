Return-Path: <linux-kernel+bounces-861474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46047BF2CFE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE6684206A1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FAE3328EB;
	Mon, 20 Oct 2025 17:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bzs+u2Bv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02F53321C7
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 17:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760982808; cv=none; b=nzmfyg3guH9L5ErLCXjC31eRENrA5NvN1yhznp3qm1l4oYnV5P7Ky5uLTsevE01WThvhyIYxM0ZraJ+TZktAbyF18PvcPkZmSfNbgVlnVEA1clq+Juv26NPg5WzA/BsU35HblfSUkKMLiy/IrKhnHTrFoTYqvxp5hAo1H5ef1dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760982808; c=relaxed/simple;
	bh=V3kRiDp3vGAbgzbMZzOlHpq/3CkSZTRqr/w7qVw8RIc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=urYIvX6Kj0iNIuJifTHDwol1NOtxQ70vcegIpGYDHoiBARZAGjIjtwm/GfBSZoKjmjOvnAsnunnfdD3992SAQXKZF3D1iJEa+F68xIc1tb4OLICFlKDTTkYyAE5KPtq2GpWLdqJrhlTTOyDUALtGMv7wFPGtlMFSdWqS0IMU+4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bzs+u2Bv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760982805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pxRCI9w0vwrChU6QN7Ie6ynLJhcqQq78vhMcRvozwhQ=;
	b=bzs+u2BvKipOYveJKbMatLsaF+E67qWph13cjbeB7Kw+9XtwKF4uutLHPm5x0+z9AS5OFU
	UWtJMrU/SROUK1+bCnE+OpPbtAoz9jfs+PnPo57MEPeEnaJcIB3KQf0/Pj0cqZZ8fPGVzr
	5vL6pSz5QaU6z89NhFN448e4JJVbarU=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-aCs_Kp6HNQSsLfQ0gsm2IQ-1; Mon, 20 Oct 2025 13:53:24 -0400
X-MC-Unique: aCs_Kp6HNQSsLfQ0gsm2IQ-1
X-Mimecast-MFC-AGG-ID: aCs_Kp6HNQSsLfQ0gsm2IQ_1760982803
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430da49fb0aso40961395ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:53:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760982803; x=1761587603;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pxRCI9w0vwrChU6QN7Ie6ynLJhcqQq78vhMcRvozwhQ=;
        b=e3j026nH/C1/+yXW3HutUFVTEd+oKKIHOJ4YOYq2/mOjD9CwSVe/MeTKSz/Ys5KvJo
         ynKzaDzSPQhs8o+MOwNLDArgCLV/HeFZ59aOQJNd7efLzLrBve4N44vM0wHTaL7Lhnb6
         VJzZQ1AagEy0O9TZyIf3qFkXeSpWqGoaFoROI7aA+4qPAoljiwe04aQ0L/jMvZLFmj+G
         8i2hFuv8NeqMsHAOneJWuRhuNxsATi4rzjgt3FIrvFwh6AhNGzOh/TzBh/TI5W4lpJI2
         UHxjp3qDLEOKq+4gLG11FuOyXLrAgQRvnaDhccQvbpSsNK5kYQES6cpjxhcl74mDI0bE
         U3hg==
X-Gm-Message-State: AOJu0Yy3xQKaBXJNOR7J3OaSBjZD+67PBz4lo2f9XcnE2JSDxaL8PWHl
	rxnVT2Rgg2iWEGkNe2DvSR6OmE1OTcjURYV4SeAOpMxyDMNOp8AN/vVBRQ3cbNFSfL0oErSQShY
	KVENszruDF8+HfZR50JRlLcs+F4HeIokXG+M2XRn3kQDjGLDfz95t/+gmlUJF9dZ0Hg==
X-Gm-Gg: ASbGncuMgZjRSDDK4t748RPPhgHEzinleb6HIOcqhndHdi2V47sPzkRKwtGvcLu0gAF
	VqYAB6lnfa3Y/praFExPD+IS6CqtPXhzx5vCxnJnOCuz3hdVd2d/irtNifQJ4ajvHoOL+c3H7yX
	E6KbLSHjAw2l0HNVtUPrETt2p3JcI/fgwsGkTbD4xG20LpregdOjukaSaJdBcZ7vQwM5oBVPXPD
	VRKup2r8crJzgfIo0FxPZ4emom3wRmsM6MSV7LXGvr145PMT19Y5PYC2rIHFuFbowwgv5nHGa13
	oiaLwEJx6hQutItqPABlq0sODgeizkm4BgQTvVerNtOMt4eBG9MwbhADgvzv/FFvBsULexOULr1
	7GThRvD227lUAgtYQrM2agGfiVymL
X-Received: by 2002:a05:6e02:198c:b0:430:c461:34c1 with SMTP id e9e14a558f8ab-430c52700b2mr217742095ab.12.1760982803580;
        Mon, 20 Oct 2025 10:53:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqwALrZUWSrj+qkHQDwlvuffP7O2IVQUJ8UI8LIOpTC0/ScUChcalQi5vBXtjffr1HHB9a+Q==
X-Received: by 2002:a05:6e02:198c:b0:430:c461:34c1 with SMTP id e9e14a558f8ab-430c52700b2mr217741695ab.12.1760982803100;
        Mon, 20 Oct 2025 10:53:23 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([50.145.183.242])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a976a58csm3127747173.47.2025.10.20.10.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 10:53:22 -0700 (PDT)
Message-ID: <c52490c9c2f682fd3c30d6f8a198be2ba408c4fe.camel@redhat.com>
Subject: Re: [PATCH 3/4] rtla/timerlat: Add example for BPF action program
From: Crystal Wood <crwood@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel	
 <linux-trace-kernel@vger.kernel.org>, John Kacur <jkacur@redhat.com>, Luis
 Goncalves <lgoncalv@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>,
 Wander Lairson Costa	 <wander@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>
Date: Mon, 20 Oct 2025 12:53:21 -0500
In-Reply-To: <20251017144650.663238-4-tglozar@redhat.com>
References: <20251017144650.663238-1-tglozar@redhat.com>
	 <20251017144650.663238-4-tglozar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-17 at 16:46 +0200, Tomas Glozar wrote:
> Add an example BPF action program that prints the measured latency to
> the tracefs buffer via bpf_printk().
>=20
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  tools/tracing/rtla/sample/timerlat_bpf_action.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 tools/tracing/rtla/sample/timerlat_bpf_action.c

We should have the makefile build this, and add a test that uses it.

-Crystal


