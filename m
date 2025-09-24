Return-Path: <linux-kernel+bounces-830482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7D3B99CCF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E0624A4F38
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7034C30149A;
	Wed, 24 Sep 2025 12:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pu2t3hUk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC1830217E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758716256; cv=none; b=jzC6V2KykGZz29fvr6eKiUUsIJg4eDkQjK7yWehmelChatFwyLL9fck8Tt6zjs3cK4K2RhZE4yaMwVQNGKsASC91vcTtTnDuRYDmeuKLQTAjK0gQJ7LRPtnVno7cVeRAejzJt51xbr7KN9zBBZR76eCyNZYs/qSB6p4oq/mWA6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758716256; c=relaxed/simple;
	bh=43ScJy7wLNmjH2mCgKx92tBc1uX9OH2KD2Rx0nFjxzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rl5mJq8gY0sUrWhgJHJnG5wGFovbCwCbPuBbYRScrdQrQ3W0xmMtxp4Ge07zZpwQD9IUvl1waar4HlTI4xmF+/PSvgQzLN06Wu2ZDo7mt2CmgyuLMZ/tpwf6Gm3316nZXsjgCieeyxJwLvMG/BK1UEaAt5yerpcdQSmZz4x9N5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pu2t3hUk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758716254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=43ScJy7wLNmjH2mCgKx92tBc1uX9OH2KD2Rx0nFjxzQ=;
	b=Pu2t3hUkQzh6Vy2bUb//P8KCn7cOda9V0QX0hC8266uCae2peqeu4OvFt8vmtDHXELIkGb
	BZy9g6CJD/4/r/R8pthqbiFeimwBpAIAsmSVdgLY0A6KMMJ17eOvPU3at7pmP5Dx1yWSB7
	s/nO4pTSklfUKLbYsphCs0RBI9D4o6U=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-z9qD9ByFNtinQoRY6VUgPQ-1; Wed, 24 Sep 2025 08:17:33 -0400
X-MC-Unique: z9qD9ByFNtinQoRY6VUgPQ-1
X-Mimecast-MFC-AGG-ID: z9qD9ByFNtinQoRY6VUgPQ_1758716252
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b56ae0c8226so478722a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 05:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758716252; x=1759321052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=43ScJy7wLNmjH2mCgKx92tBc1uX9OH2KD2Rx0nFjxzQ=;
        b=RU5jUuiOzuTN0G6pQe6HDK0npX4wgFH7b82VvgTiNQhUkUo1qE9cP0yJsIjSE+/+CJ
         vXP+PGasRKF+lTFPsvF5G69Z6gC7glFSrweilUGENr1T//3HfbA9GrraULtpshm7h+dJ
         MlNWR9l0nFbnjAqotE18q6Ot2HcttGQsB9tSC+REHeFDK0wYX2U+YbHZs3FDuJmgzYhH
         FXj7QObIThGh+Eqtd4V4nj78gVlnjFUWJl9qFOdyp6lHfxTArFMsKsfIUYMjUJfpi+rc
         cRXz1uRkgMyXup6xA0YecBu21C0/hoE/JHiXDB7gbALof1zDkzkA43A4mu1tjAdGC6ro
         2y9g==
X-Gm-Message-State: AOJu0Yxc/vxnEjmGTBZsPkovccjqiklSU+sqvsjnTOVEtexqMipMIZWb
	yewKOLRSAKkTVQJ5Hi5Y9rXCBd8hZBGVwgiD32bVi/gcKNIA8T0PYx4+a5IiihGRPNc+yt0CtGT
	hZ8o+H+8XnFn1hqxRnsYAVuEBJSns2/VtD12H7fbxuCGg9owskYuK8tKYEOfXTT15oEcptCstNu
	WUgcUAiUGaJk97PN5PKQBg0aL4hqjpbXzdyjEUI15R2+y6qYiCPDDPJw==
X-Gm-Gg: ASbGncsX2xi8jJJBl9Fpa70QNIFkf4UXc+f+D88qPYewZxgX3Juk0iJNjYNDS6Xcvvn
	jFnVd3MyN80mqL0/EwUv22jkctA8nOtRu1jaTSUmA5OwOzDFPvWmSGQAPiPPQGwEvHr1aXcZb3N
	EAoMd1dtRLdoq2b/otEHk=
X-Received: by 2002:a17:902:eccb:b0:262:4878:9dff with SMTP id d9443c01a7336-27cc138187fmr67734695ad.12.1758716251941;
        Wed, 24 Sep 2025 05:17:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoX3VdI0G6Fizy/WK4dTtMB9Z+FLYoC7j5niExyF7Cu27KjJ3BZdLL6gEniI2B+Td+UYJGc6x0mdk5W9Gpdi0=
X-Received: by 2002:a17:902:eccb:b0:262:4878:9dff with SMTP id
 d9443c01a7336-27cc138187fmr67734465ad.12.1758716251606; Wed, 24 Sep 2025
 05:17:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911004416.8663-2-bagasdotme@gmail.com> <aNJ9yJ7XT4Pnsl9E@archie.me>
 <CAHc6FU7aGJZZzN8zhtnwDgXX9gVMh_fbi+sUpJ7tg1MWMa8XVA@mail.gmail.com> <aNMnSapfyfwga0Oz@archie.me>
In-Reply-To: <aNMnSapfyfwga0Oz@archie.me>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 24 Sep 2025 14:17:19 +0200
X-Gm-Features: AS18NWCa5jmffiBOp77B1fu-47YIJ8JwRk0Rn9UG9h-FDhgHGAvfBdeQ_JOjjPg
Message-ID: <CAHc6FU69a-R-u-Cr90aQMjb_75SChUa9BTSjL4AZKjuo_QVJQw@mail.gmail.com>
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

On Wed, Sep 24, 2025 at 1:03=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:
> OK, I will resend after 6.18-rc1 is out.

I have added the patch to branch for-later. There is no need to resend.

Thanks,
Andreas


