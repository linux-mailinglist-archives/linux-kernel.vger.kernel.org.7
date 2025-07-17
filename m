Return-Path: <linux-kernel+bounces-734523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93568B082B5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 04:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5506D4E7BBD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 02:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C28E1E47B7;
	Thu, 17 Jul 2025 02:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PtSbdefn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EE31C8605
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 02:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752717796; cv=none; b=cUMI+L96RnGx5bgtzcBodkaotBFH+wdPqGzRwyUGhK1FZ5pJEIEefiRKtkthKXT0QN36wY2u8Wve0Q0klYYbZo9m8x9hauO4yrYQiTVGXzoZEikM0hjjgUYJebmchF8jRCcgIAA+3uybFiJ6flkkvbcIZtIV8vgFgDO1o91CTms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752717796; c=relaxed/simple;
	bh=nk+vMLXGoyUcWn2gdQ0TtZDnbeL6g7uxU6L7y4/AI3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K7+6uQWmBmq6zRUN5q485FBDIHgWWTpf8uvdDkZB4TdADRZknr1r7SNsaqV8De3CskYoool36eOICYdkP0K6aqyhdTbPA/ixFD5JYwtJF+LEXydNnU/Wxal1qFgEOqRbHoWMqSXooonQKlXQTVBSbYkExeenzaNziJOG5yzdHcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PtSbdefn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752717794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nk+vMLXGoyUcWn2gdQ0TtZDnbeL6g7uxU6L7y4/AI3A=;
	b=PtSbdefnu9UH02yhsvHlbfjeiyqG3WsRKPWxZbilyCMkYzB8FmToWbhjhpjtNLtMRHcAkS
	Qzo7/sV02f154kgtpNiyEyXXMTs6q1ab/1DU3uj9zYO1AAzxd3eckDjyTThRfCP7ntOd/D
	heYxYak4hvt4GFa0Wg1PRZdlsxG8SSE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-UKDIA8YdOpS3w6V49cWgJw-1; Wed, 16 Jul 2025 22:03:12 -0400
X-MC-Unique: UKDIA8YdOpS3w6V49cWgJw-1
X-Mimecast-MFC-AGG-ID: UKDIA8YdOpS3w6V49cWgJw_1752717792
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3141f9ce4e2so678576a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 19:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752717792; x=1753322592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nk+vMLXGoyUcWn2gdQ0TtZDnbeL6g7uxU6L7y4/AI3A=;
        b=PjahfnMs0dZOFI8aYEaTCosI6ZHZ6yEi9BOPiIEMiCIi1yfPG1rfqMIaINr38Xhb55
         RzRGJWZ83HQW1WGitOCMoepFRgGpsdRhOTTbUdJTGTYRu8gYV1ksa7AwSlpK2LZA+qs5
         hU9Ks4j229uHOm96GYVGENo+MGzvnn5STlGe6nYPgaSNLORAin+uauNk+IYTSm1nQCV/
         zD0GdZNt2GqA3R/iPXB3rpi/CCBmCZqqQgFoS/uqutOTABXHfKPVZLFfIRdji/9Fq1nL
         XAt8VIOvg94YFgUDByuF8A8dLeuSvNEkcYZQeAc8r2t8z6z+mE75szgO4e5BSyBvXuLK
         d3zQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEmpPXN1AyEYWgZ+xopsDykNMwYEyUkPFmy3bb0BrVuxpg21wKt1l14ia0Ouwmu+kgPUf7//Gus3fibfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQOgsnVB40Kc48HUWOad+xjr0pzg9Yqf+fVVXGmWz/ANYY6CEI
	I73aqx2E0knLdnhlafZlQtpnDEPBFXcXlXkXLcUl3L209cafkEUOSln9wUoy78FoYseQxUKU3vM
	JwPdFz4YlfMNpJpVc+sXgKa259DNWzhJS+ZJXIi/36pqFXWoEQ9keRYYg2Nbae70Tee6Mq01LBB
	Y92YgKrpK5Q6FgYUfS7WtRJ2HcNYw+DaBrcIgAQpc6
X-Gm-Gg: ASbGnctUkwUFVyu2g+mO9sXVV7OzqyqXh8qDQcYGOJ1XBZ5iBTN5/z3tbI06tLpKSS3
	6iBmhdEjYKI0ixgBsiBtN+L36kqWLSMYbDTxBwjT0f117uKmdExWl66dSDjRDfB6EU7li9FhnF7
	tovmeZE3lHczplyJSNYrkE
X-Received: by 2002:a17:90b:55cb:b0:312:959:dc41 with SMTP id 98e67ed59e1d1-31c9f43747emr6022351a91.27.1752717791916;
        Wed, 16 Jul 2025 19:03:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPKGtWTF3J+7pKYaN1LISu1DbprEzZA/aztw/7OAnQNJPFUO3gk780cKvvzbWsO46X8xOSSRM1m2KLbEldd7Y=
X-Received: by 2002:a17:90b:55cb:b0:312:959:dc41 with SMTP id
 98e67ed59e1d1-31c9f43747emr6022312a91.27.1752717791421; Wed, 16 Jul 2025
 19:03:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714084755.11921-1-jasowang@redhat.com> <20250716170406.637e01f5@kernel.org>
In-Reply-To: <20250716170406.637e01f5@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 17 Jul 2025 10:03:00 +0800
X-Gm-Features: Ac12FXyE_9vIZMY_ERg2TY_jtWvI4UypN_DhHze9LSPtUt7pnoEDW84dnljw5VE
Message-ID: <CACGkMEvj0W98Jc=AB-g8G0J0u5pGAM4mBVCrp3uPLCkc6CK7Ng@mail.gmail.com>
Subject: Re: [PATCH net-next V2 0/3] in order support for vhost-net
To: Jakub Kicinski <kuba@kernel.org>
Cc: mst@redhat.com, eperezma@redhat.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jonah.palmer@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 8:04=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 14 Jul 2025 16:47:52 +0800 Jason Wang wrote:
> > This series implements VIRTIO_F_IN_ORDER support for vhost-net. This
> > feature is designed to improve the performance of the virtio ring by
> > optimizing descriptor processing.
> >
> > Benchmarks show a notable improvement. Please see patch 3 for details.
>
> You tagged these as net-next but just to be clear -- these don't apply
> for us in the current form.
>

Will rebase and send a new version.

Thanks


