Return-Path: <linux-kernel+bounces-879403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A8608C23075
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 03:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 536C93451AB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 02:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7242D6612;
	Fri, 31 Oct 2025 02:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OQdoyYJ8"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B0A2E889C
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761878042; cv=none; b=M+5v1I9pDkQBRLqPfmPh4cGWFOu2XVUlLsIAx7lFvRgMx9i7CXTVlNFVAy+imen2lhRp9/Itsq/PS7QvDfj7fcTBhTVwwzokB1r/c80TTTINrjF1uzKaePyNUSjSf/KBzv5X1ZFw5E9QQm2GQRma6DeYLVZebcHDqZpyZVYZLak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761878042; c=relaxed/simple;
	bh=64JYB4DHZTuzDjFXpfrzIZgXbdT5uWvgDU8kavKrSIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TIqCoFGVcr6cKY0NgAHiUfikKEROzzvCpE6OQ4Qv+8ykSQGjaaI4B3kIq4ZtahmXdaTDS0WoUlczSjWybO6cyUSwsVynHi7yrzuqq0uP1IavxeQTk5VSk4ahQZ9/FIj5chKOHkt1ExiwQFOQuHn5I/dM4UcQ0iJqYqFw8m/Z6rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OQdoyYJ8; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33d463e79ddso2160062a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 19:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761878035; x=1762482835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64JYB4DHZTuzDjFXpfrzIZgXbdT5uWvgDU8kavKrSIw=;
        b=OQdoyYJ8mTu1wREPzmtxsdiGS+FsyyY3Fp4xwQ/il1Vcxd8iNn0VWE8yLWHb+zuCql
         ezkUto6rJWxNt6YogvvAdfFCVuVQOkZIxpzRLYFF6v2IGSp2/fSgtzZa1uyDSFCKvNYr
         iAV9Pn1KHJG0gvno7eJGv4txuQIDoYAzcMKMPpC4rP4qAXPh51cu4Ywl0c2GyxEaApC6
         Wba+cAhrLlPhNyYcY9EkXVFuMZHmDyx7TlSMupTrJHhbXEmB8BwWzK/wp1me9+589RUW
         ITgbR1PXxb/QbfkgJ02oDoK+hy5G9SDQ/aXmZVumGEvTA/FhxPWjwg6Ex9FoCjPsHxsf
         7yEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761878035; x=1762482835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=64JYB4DHZTuzDjFXpfrzIZgXbdT5uWvgDU8kavKrSIw=;
        b=wMKURNjedaAOj72yeFbmesacvduLa1RgzkOR45rHI7h9BUSdiB2S08gdDBuDNs8Efh
         BeeQ1H8tCCgGMMNtuik8JqtPNU4LgvFTT1J7kDl4whY1FzQoudbOz8d72DOOCEHulTJ1
         wnV/onD679yJB/qepcniduCOpac42uo1JZWW67ZMYbR5TY1cEKZufDjdm6jhJTSeGQcD
         rFpCUSYbM8BKfwg3ERCmgAbVnBvAlBHNaH02ah79fjM/kcwwOQKSkkUUSXncklW+LsOh
         xtWvtwgI09JhGE6OiyAh6AsPtT+0NfdUvfWEbGmi833WExCSSD0gig5qgcilf9lXV04J
         SivQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8W6zsJPqLuL8CW+qXLCWLm+334z4lt3GGqq2EMiNVAVhukciTlit0PrD0mWLVnhD2Hu0ZWRTfQnpvx1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt+JJvzm3m48VKwKGw8JGc4OWc3b1B6SeInymrCkC3KWPvi6Jc
	hC/KeuKaGORxyolS6usOo41a4lDlE3cPog2giMTbN+1fdgkOXn/bt6z100LdOVIdL5/9OLMXSLA
	TtihF3AqMWjdrOResb5JVI9MBgVVrchz2pOJOtzgz
X-Gm-Gg: ASbGncua2m7ujU4OPl+YUsv3TKocoJBt6MyZ5weVbHXGQcFlN1B/JR0MXwsacJG2CJY
	GLAIgrVfP5UnbfCks5KQBFNuVZmaP68m7hW7TMK28UAeiajfuhRdG2uB/AlYF3yiQ34B6VPuMwe
	XVtjjqoyyheZWhi59x8J4VF2hSWFHOxp4A1PytPccka0T3iqMxMi1XxC1yDQ80UFYJn3DS2P3IJ
	qOb0KNqClbDnXUH3ulk039qhxijiIXHjzbyedxhexGxsvwnJb1bgtNpeZYHDWz0HW4hdPo7
X-Google-Smtp-Source: AGHT+IF1L5LfETuJY3fRNGNZWBg790ZqhCdeqmVXikkzD/x6BL82G2EbGGctb/NAtbNB4bEqy125S//o5Iz1XrH+1uU=
X-Received: by 2002:a17:90b:1643:b0:338:3221:9dc0 with SMTP id
 98e67ed59e1d1-340830897fcmr2636606a91.37.1761878034541; Thu, 30 Oct 2025
 19:33:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030100025.95113-1-eperezma@redhat.com> <20251030100025.95113-7-eperezma@redhat.com>
In-Reply-To: <20251030100025.95113-7-eperezma@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Fri, 31 Oct 2025 10:33:43 +0800
X-Gm-Features: AWmQ_bmuXsrv-EaQgSGxrjM_8sqXlKCig3_hlgODjOMZx1KJxhUrOhWkug691dU
Message-ID: <CACycT3vHHSuWkkTZC7GK-T_nhUEsck-YPf6tfOsTC2R0SPbgNw@mail.gmail.com>
Subject: Re: [PATCH v8 6/6] vduse: bump version number
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>, virtualization@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 6:01=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> Finalize the series by advertising VDUSE API v1 support to userspace.
>
> Now that all required infrastructure for v1 (ASIDs, VQ groups,
> update_iotlb_v2) is in place, VDUSE devices can opt in to the new
> features.
>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

