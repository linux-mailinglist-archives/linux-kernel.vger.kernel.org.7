Return-Path: <linux-kernel+bounces-828879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0DFB95B97
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F58D163413
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13EA322A38;
	Tue, 23 Sep 2025 11:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J+ZVJ6EZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA65C322A39
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758627875; cv=none; b=SX0Kag25iEUsP7FlMmdqw4m9RXu3VfBbJa+n8taexivp6NqD1WYFUNOIi1PrxDdc4XyqW8sZNnlKsxFYCNJAT1uQ7Bwbbdk42aeTqIUqp2yXmpH6Abumc5XyEAR87A3SOW+jjAE0gdnuSB/a+mvQPf2Pe+6Lx8x7R0An7SNiWas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758627875; c=relaxed/simple;
	bh=IrwBtr41Ejbc9u6SFXsWNUvjyVGHc3eeq1h2neY22mQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=akhoPs2CLy9t7gWikrttdivGjj3AoAMpvR65J30PPofDM35jFreMvUcEmnkk+x+HUKr2cd0hJH9bn2ClFhKFgDz5ihwspvL48BlK2DOgtu0L9NFI0SuRCD3JpTIOZS0kRH/mFDZ+WVrYaCoykqxTM5byPgR8u825sL4PTnxWdFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J+ZVJ6EZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758627872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IrwBtr41Ejbc9u6SFXsWNUvjyVGHc3eeq1h2neY22mQ=;
	b=J+ZVJ6EZk1KU1FPzRJDxh41L5HoprE7Yob0Cc40Ss3rdV54UvxwXyY7+QPE0jP1QBRBJ0y
	cmPG2v+wy37ubWAdTSahePq7YdlynSem2lbYa1oux4qD62agSO3Okn7VA5RVJpn2gMJjoX
	/QGY9QcvLGbz/yAy2qGFBejOJSxiYII=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-n5OZDC73PKySGT0_DHwVKA-1; Tue, 23 Sep 2025 07:44:31 -0400
X-MC-Unique: n5OZDC73PKySGT0_DHwVKA-1
X-Mimecast-MFC-AGG-ID: n5OZDC73PKySGT0_DHwVKA_1758627870
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-25bdf8126ceso106344425ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 04:44:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758627870; x=1759232670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IrwBtr41Ejbc9u6SFXsWNUvjyVGHc3eeq1h2neY22mQ=;
        b=mX/k5sEg8H+Ndx47wJDRYko/+BvdY7oRnDSA4E93kpCwjwOIC2VwsS1cC2oxgkrQAE
         DUiuAGu/B5ackCdtw07ifszIM5L8sxSpf/q8JcNhqlt6OcNmHxzkt4QIY5xdul4Wsu1t
         9RmXl18TEi/ZXJyaK9T1C+/Y/A40gMCmqJvMu8jExX5u3T8oeRVP/ZEPBP9q7JchQS+l
         sQM9QLUfDpnpBTNwdZ4GDlv8U8s3r9E42U+1HMmMDDdJKaQWpmzxO/Qljdw8Yo521XNG
         UrZO8GAKWGC4R5VmSHBu6ZPFH2Qe2mKql2PBVNrg2qTbK8iyxkzUnVB0FeH6D/U95nFE
         kutg==
X-Gm-Message-State: AOJu0YyKXajxBRxmTIacXgON3hjRtJFPMWQ4hZxw9KjrvM4bMzYCamHO
	dcayGFSRoTCtJv/2wOHo9vqxb3fyTvbqXRjyapJ+lL2dLusGm4wh1EtSOZ09V0zAcAgjGbcbpZU
	8SV6nWYw2SUPp3GvbP4oZl25S/cssgDlW+aQdIUYEKZrj+aZYiyVQnCE06Z3fizrBZItk2Zi0K8
	L/fqB73q5EuRf/QDVDYN/Mbn4eBOsv0odExm9wgyka
X-Gm-Gg: ASbGncuSyAuKRmcKg/1JJ54l0H/XIqCQq3VgSkiS7XVtyJulQrhAgOnGD5+Zzt5lnbb
	HGM9Agf+IX6v1k2JiOIlDInIUVc/E/vnZV0RZs787/mxFTUhXERO5pT+QHzrdGtpX7OmwBte4gT
	iLQGYkAM4m3f1w5EZjQK8=
X-Received: by 2002:a17:902:db12:b0:269:b2ff:5c0e with SMTP id d9443c01a7336-27cc836bddfmr30428295ad.46.1758627870530;
        Tue, 23 Sep 2025 04:44:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1Cwvw/2PZwtxl8crg/RvgpXu5cRzWVpQOiAlxqRp7folePTOl9sm88fsN+QGl4BwCYWwIjf0V3FoMcSkSUdA=
X-Received: by 2002:a17:902:db12:b0:269:b2ff:5c0e with SMTP id
 d9443c01a7336-27cc836bddfmr30428055ad.46.1758627870158; Tue, 23 Sep 2025
 04:44:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911004416.8663-2-bagasdotme@gmail.com> <aNJ9yJ7XT4Pnsl9E@archie.me>
In-Reply-To: <aNJ9yJ7XT4Pnsl9E@archie.me>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 23 Sep 2025 13:44:18 +0200
X-Gm-Features: AS18NWBFz-QDudfkmwzdBEDlcV6uLY5XJ2s6wSqGZELeCos4n-LXvCn8eGBJ-fE
Message-ID: <CAHc6FU7aGJZZzN8zhtnwDgXX9gVMh_fbi+sUpJ7tg1MWMa8XVA@mail.gmail.com>
Subject: Re: [PATCH v4] Documentation: gfs2: Consolidate GFS2 docs into its
 own subdirectory
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Documentation <linux-doc@vger.kernel.org>, Linux GFS2 <gfs2@lists.linux.dev>, 
	Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jan Kara <jack@suse.cz>, 
	Christian Brauner <brauner@kernel.org>, Miklos Szeredi <mszeredi@redhat.com>, 
	Jeff Layton <jlayton@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, 
	James Morse <james.morse@arm.com>, Bernd Schubert <bschubert@ddn.com>, 
	Chen Linxuan <chenlinxuan@uniontech.com>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 1:00=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:
> On Thu, Sep 11, 2025 at 07:44:17AM +0700, Bagas Sanjaya wrote:
> > Documentation for GFS2 is scattered in three docs that are in
> > Documentation/filesystems/ directory. As these docs are standing out as
> > a group, move them into separate gfs2/ subdirectory.
>
> Hi Andreas,
>
> It looks like this patch isn't in 6.18 PR [1]. Should I resend it after
> merge window (and for 6.19 instead)?

Ah, I was already wondering what had happened to that patch.

Can we just put this into the next (6.20?) merge window?

Thanks,
Andreas


