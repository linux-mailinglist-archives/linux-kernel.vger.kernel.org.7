Return-Path: <linux-kernel+bounces-751046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1093B16490
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C8CE3A6DC2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 16:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E1C2DCF46;
	Wed, 30 Jul 2025 16:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBbnRBXd"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12D52D8368
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 16:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753892717; cv=none; b=GhHjeYfi91Hxml98ZJOstbzhHMUkHcpn9GpOCUQ4Xb5B6AdDprz+Cew0Hy8XAMJvNSdzin9KTZC3leGOWJ2PRy+8Yemj4lpJTRv184zSQVO0E5+1HeC7QXZ6RJTDOoCSp+BeWH8/ly/Hv2lDXiOp3Z2YtwnW8Y1iqML5MzluTYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753892717; c=relaxed/simple;
	bh=EI0bMvYv5hSpvnTUf2HMOBA5DoaU+c0LboV5ElVAY00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=lx13isS9FUYqFylV/P53hi432GKeKmNOheXaXMBINP9b+Mv1nLyq2HW7YScorK3ZZe9PaWhHBbPr8ATkq6DWWG9dikWPb9QDqTurmj4yCnkchTOOK/iuP1y23mfocFdXm+va057H1bf2oEwO41QLOxIEI+9AGDV429QAC7c4YEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBbnRBXd; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2402b5396cdso312625ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 09:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753892714; x=1754497514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9XySPgRxGKmddhBeo4PW8+eY+WMXaAjgeL+q5qCHG4=;
        b=nBbnRBXdoZHjwYvmM+loUeIjj5Ln4jufldqxQg8o9YARYGKU9VN5kYRQtVrFy9Yyum
         LsUTVisxfAgrM3Ty4lfXqS8venvoPVYsncw8JBbQrvuVXyUX0MxTQ56CA0DWWf9unqcb
         BXT0Co58FVIMCbUrYoDoxkLgaxIIU2sLJq5O4fjInLhkJw+DKmVTz0z/QK4Oc5iYUdaA
         bdU8viCqX6yiH5AXngtU29uRa7Oom+FtqfMv35sUgAp5fOXymVcVksDSjQqzwDax8/zE
         WADO0F4Os9bTddILA8yaEp9TSLSXuU5gB8J24sKI0arufhfQvhhaVMYuzD0HJu1eeFcc
         GKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753892714; x=1754497514;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E9XySPgRxGKmddhBeo4PW8+eY+WMXaAjgeL+q5qCHG4=;
        b=oTuubNK3X9vQ1q6xiN/l2uHHVYwp8yoap9k3nMX3UOt+tG4di7fPVH8oDfeaZhP+YS
         5zPsFCOsXlJ+bfWzMehIIezvuuZ2dZncWOm7zpvd8PDXF5c9fO9bzkjkV+1pu11Z5fiv
         D0hbPK6ywfL0fuCzNZrM2RiVEOSxEOZwwW+plF0t8aWQy64P8fhSK2+oq8X3gHvZF60E
         z1ETmNYRUpNWve7I4OOBQzd9LpSGpy3BdmO5aeW4Ob3Jf3vawiwdVHCyT/aUASNRcuzJ
         Tf08PoNGIgz+rfEBxA27QrFs9aLNQUJhMuAkY7FFSk0a29OBzck4kU7eiWtWMXZ1yC49
         vj1g==
X-Forwarded-Encrypted: i=1; AJvYcCU0Wse6QGRU9fMFGvdLZ57SOOzsEzp0fHcddml5UzD9BLsyUCPkQr4ly5canzqqYm2rIbdam5kQCEAoUQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvBxVu789HktCd6XaFOd+XemXm+XomgRENhFNfgzuDTYCzrbXv
	3zcvdpCS4vuAIpVcRvIC/QyA6HxnmXLF3r0DncSm80JHhxW8GViDNS95UUBDsm76fEVZYIwEt8u
	/0ypjWEZGHUco29NX2mV36Ogkup6dsFnSnYFEwwBNCQ==
X-Gm-Gg: ASbGncuK0WEWqwZ44Q8FvIK/zbglLB67O/moe7zfUyZBVDNaG1J8fiXalUc1k9I1PNX
	g5VGDJZGlzB6R64SA1HA5tf2QsZHR4o08ZpKqoIYkm53jwYfn4yOOBd0G6hzvpqtqEupfJ7UnvK
	SGTuZjcRUqXuUINLKng/MVHPDgVv+UM6JUjNpzelVRbENzxJ8mRLV7335iLM3B9UKdqZKMRbVVj
	2IvMM9OAEbFCpZHnqY3PRNNon8tDlrJ2V0rbMM0rw==
X-Received: by 2002:a17:903:b4f:b0:240:92cc:8fcf with SMTP id
 d9443c01a7336-24096b34743mt53106105ad.49.1753892713686; Wed, 30 Jul 2025
 09:25:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722203213.8762-1-andrewlbernal@gmail.com> <ccac04ec-fe14-46bd-a482-b9cbb65fadf5@acm.org>
In-Reply-To: <ccac04ec-fe14-46bd-a482-b9cbb65fadf5@acm.org>
From: Andrew Bernal <andrewlbernal@gmail.com>
Date: Wed, 30 Jul 2025 12:25:02 -0400
X-Gm-Features: Ac12FXz0zlijZdaLwoj5plPalzSt0irQiMMJ3O6QVUPamPWsNCHOxHvejkCXcOM
Message-ID: <CAPj058cx390W=GE9fFXKY101GL7S=XNn=0YSTfojkvhybKEBvA@mail.gmail.com>
Subject: Re: [PATCH] scsi_debug: add implicit zones in max_open check
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bart,
Yes, I've read the real standard now, and I see how it clearly defines
the OPEN ZONE function.
Thank you for your reply, I really appreciate the explanation. Sorry
for the patch, I'll be more careful in the future.

(my previous reply was sent to the email addresses, but didn't send to
the mailing lists because it wasn't plaintext)

Sincerely,
Andrew Bernal


On Tue, Jul 29, 2025 at 12:19=E2=80=AFPM Bart Van Assche <bvanassche@acm.or=
g> wrote:
>
> On 7/22/25 1:32 PM, Andrew Bernal wrote:
> > https://zonedstorage.io/docs/introduction/zoned-storage Open Zones limi=
t
> > is defined as a "limit on the total number of zones that can simultaneo=
usly
> > be in an implicit open or explicit open state"
>
> That's not an official standard and hence should not be used to motivate
> this patch. Additionally, I don't see how a zone could be simultaneously
> in the implicit open and the explicit open state. According to the ZBC-2
> standard, these states are mutually exclusive.
>
> devip->max_open is reported to the initiator in VPD page B6
> as the MAXIMUM NUMBER OF OPEN SEQUENTIAL WRITE REQUIRED ZONES. From
> ZBC-2 section 4.5.3.4.2: "If the value in the MAXIMUM NUMBER OF OPEN
> SEQUENTIAL WRITE REQUIRED ZONES field (see 6.5.2) is non-zero and
> the number of zones with a Zone Condition of EXPLICITLY OPENED is equal
> to the value in the MAXIMUM NUMBER OF OPEN SEQUENTIAL WRITE REQUIRED
> ZONES field, then a command that writes to or attempts to open a
> sequential write required zone with a zone condition of EMPTY or CLOSED
> is terminated with CHECK CONDITION status with sense key set to DATA
> PROTECT and the additional sense code set to INSUFFICIENT ZONE RESOURCES
> (see 4.5.3.2.8)."
>
> > diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
> > index aef33d1e346a..0edb9a4698ca 100644
> > --- a/drivers/scsi/scsi_debug.c
> > +++ b/drivers/scsi/scsi_debug.c
> > @@ -3943,7 +3943,7 @@ static int check_zbc_access_params(struct scsi_cm=
nd *scp,
> >       /* Handle implicit open of closed and empty zones */
> >       if (zsp->z_cond =3D=3D ZC1_EMPTY || zsp->z_cond =3D=3D ZC4_CLOSED=
) {
> >               if (devip->max_open &&
> > -                 devip->nr_exp_open >=3D devip->max_open) {
> > +                 devip->nr_imp_open + devip->nr_exp_open >=3D devip->m=
ax_open) {
> >                       mk_sense_buffer(scp, DATA_PROTECT,
> >                                       INSUFF_RES_ASC,
> >                                       INSUFF_ZONE_ASCQ);
> > @@ -6101,7 +6101,7 @@ static int resp_open_zone(struct scsi_cmnd *scp, =
struct sdebug_dev_info *devip)
> >       if (all) {
> >               /* Check if all closed zones can be open */
> >               if (devip->max_open &&
> > -                 devip->nr_exp_open + devip->nr_closed > devip->max_op=
en) {
> > +                 devip->nr_imp_open + devip->nr_exp_open + devip->nr_c=
losed > devip->max_open) {
> >                       mk_sense_buffer(scp, DATA_PROTECT, INSUFF_RES_ASC=
,
> >                                       INSUFF_ZONE_ASCQ);
> >                       res =3D check_condition_result;
> > @@ -6136,7 +6136,7 @@ static int resp_open_zone(struct scsi_cmnd *scp, =
struct sdebug_dev_info *devip)
> >       if (zc =3D=3D ZC3_EXPLICIT_OPEN || zc =3D=3D ZC5_FULL)
> >               goto fini;
> >
> > -     if (devip->max_open && devip->nr_exp_open >=3D devip->max_open) {
> > +     if (devip->max_open && devip->nr_imp_open + devip->nr_exp_open >=
=3D devip->max_open) {
> >               mk_sense_buffer(scp, DATA_PROTECT, INSUFF_RES_ASC,
> >                               INSUFF_ZONE_ASCQ);
> >               res =3D check_condition_result;
>
> Do you agree that the current code in the scsi_debug driver follows the
> ZBC standard and also that the above changes would break compatibility
> with the ZBC standard?
>
> Thanks,
>
> Bart.

