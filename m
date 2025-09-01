Return-Path: <linux-kernel+bounces-793673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF59B3D6A9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 04:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5925D7AA546
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 02:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9787F1C3306;
	Mon,  1 Sep 2025 02:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V/czGQT+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6040E16DEB1
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 02:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756693690; cv=none; b=k5p9Ym/5NvuQTXGJRHoE4lKweFXpoSqULqO97V8mujJkBLFR6/75forT3IaRrw3qCQEUn6HRE9RjeyMaotGvIFSt6z7Dbby6MPZELoML4SlkF2eXfueEQ2a6QvwgWFwfGVzljokkF7oHi2ta8gpv7nro2NtuPaHI5okSjlY6VP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756693690; c=relaxed/simple;
	bh=Py2A8RiduT0WX3K9RjBXxRcDBRvzu01D05c+OGIsoNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FIKYKHjBIJCF45reeQOzqP1Tnaf1cPmQeDTTdLCCvEcv+a0F9hlpkDuxYYKdgewNCPwDgRwwjANMllpPNwItR6bKEttA24Nzq4xH/uV6s3ImPUTIdp+00ASONaSCZoZ7IZpqm/Knf3djt82AD2D6YHT0qgGbEAhGn9HkNG8j+ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V/czGQT+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756693687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MXJokDPos0nKm1zfHnhLzwyRYR4oCXMJNHGtY+hKQ1U=;
	b=V/czGQT+RPb+Y2TfWzXKRLUNvAXxU8e7Lj0ix5SxPsi/6SZ6wRnQhYwUxcA/lS+WN5eNtI
	b38/XZGN3KzmASWZfEQtY4zvGtCpiJS1+VeBa/lwEMhJNlpmgFx+JNqZOSdxLpTb2Z6EAE
	Wrn6/U8UP+ANAHWHV1EENZpQRENHk98=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-akd-T3QqOAyCxTF3DNrB3Q-1; Sun, 31 Aug 2025 22:28:03 -0400
X-MC-Unique: akd-T3QqOAyCxTF3DNrB3Q-1
X-Mimecast-MFC-AGG-ID: akd-T3QqOAyCxTF3DNrB3Q_1756693683
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3280d0d4d11so2465158a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 19:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756693682; x=1757298482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MXJokDPos0nKm1zfHnhLzwyRYR4oCXMJNHGtY+hKQ1U=;
        b=b2pjM6i+eZ27dxTcwn6NTnBIdsstIl6OK2xYH/n8wwPHTwklWEAP0Y890dN2TfUvHd
         r7/ZG5Ngn8OGoAWb1NEUm0oWnPlXF/biDPW+4DySag5VoQxvgpUgz+z+nETo1UyNYfF6
         swNKx39aPmkoPV1f0StsWUtf4nisZ1DZJjzbC90Hy9SLlxQUN7rV7P+aM7kaVJeU4vgV
         gyUreTAo1Vv4XA+H5XsTHG1D8oj8lIeBgFTdRQS5t02LA5E/nXEPMOM65ZdFTix+rbx6
         IBPKRYRFaIYYG9jyDe8evRZIRB9hMgQJ1Ld3PIfQpkIfbxrY9EhUkvbHUNE8fxilqezQ
         nv6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWNcYhOc5siP44Pbo3Xm+ZV1uc8S8xrsgux2VABTWQK7CSZxcMZKnn3fwriOiVUwJ/vuOt9iUTHnUwh/WQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP4POv6A5+8wHFHlFLvP/97vtSfuWuJRzAk8o2G34fR7tnN5+U
	qurHFT8RtchT6icdZs1sWfoMwAParwUr7J7VzzaHXNa67uWpXU6b54PyR9QeboMO6qw9MdJdFEa
	BN3O11EP3aKrgcyggDjN2ed5ZUaabpiVBW34sX+UY7Tnda8CBeli1OHQ+uFq6d8FrnCeVsOBZv0
	orj5JD/ABa69qBzbPyh/rQkwTjQ0hiU41NPTzpNwPA
X-Gm-Gg: ASbGnctcnO3USwpZAbFDot9yHxEgh+2WkiB9PXkXZ2a85pMdXhGJSts6Nsil90vI5Oj
	REtsdYchBoDCNNSRlbVTVG/m1szuJyNW3o8DnXORBUDIMODOfOEXOBDZa4J8bJwBIEI4PRjgCGb
	ygZkVijmy5X7lGrseW+hUljg==
X-Received: by 2002:a17:90b:48c1:b0:325:42ad:29d2 with SMTP id 98e67ed59e1d1-328156e3815mr7104442a91.31.1756693682648;
        Sun, 31 Aug 2025 19:28:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxUaKN6UXluy29/F+dllwNkQH5s1R60oXrZmMH950RWWU803/YD+qBnqlF6FdoKrHFnYLN6xdG1JqlH061AyU=
X-Received: by 2002:a17:90b:48c1:b0:325:42ad:29d2 with SMTP id
 98e67ed59e1d1-328156e3815mr7104413a91.31.1756693682199; Sun, 31 Aug 2025
 19:28:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826112709.1051172-1-eperezma@redhat.com> <20250826112709.1051172-5-eperezma@redhat.com>
In-Reply-To: <20250826112709.1051172-5-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 1 Sep 2025 10:27:51 +0800
X-Gm-Features: Ac12FXzdv-h23IXc14dM4bQKB8o4sC_53xLf6KUcXeaogY5iF9KPgzgWOswds0g
Message-ID: <CACGkMEshp5HaRPchAkYGD2vi7xPBBi=w0H4DaUXOXas4SQ3WDQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] vduse: create vduse_as to make it an array
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Yongji Xie <xieyongji@bytedance.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 7:27=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> This is a first step so we can make more than one different address
> spaces.  No change on the colde flow intended.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


