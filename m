Return-Path: <linux-kernel+bounces-856549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC8EBE470C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE5841A677C3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE2932D0D1;
	Thu, 16 Oct 2025 16:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUPbFIXF"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1777632D0CA
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 16:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630473; cv=none; b=MzE6al1a1YoA7sfBfdBytJ3hcuEir+X8mWS9DhKhTnl5oPsyJjRVR6oTT3KyCaLj9MhiINWpfzAt6HMiB+oBVIxCk66bmI4HeCDS1psUQ271DcwFUndajen/8JFvnJXn7Wj1GHy6p7TUZ/Ynfz1k8X2RVmPeBz2h+CY0XrD/pEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630473; c=relaxed/simple;
	bh=OkLmE1s7BCfavCRHWUlfiNzNqHQRLUNV9toLcXurg7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SOn58Ff41Qda3876MBHwObKGz8oKkAfyJkrhmjMypDYZgLS0BElMcTpr9UIXhB+4T11D6uq7E57C8EcCEIm81QIk9ct4wqpDERVjg+9I9W0hwIKhG1iW2G02X/ItNtpif5C1aNVVc5Koxybi3GItGbxIjLJs+HLoMSctBPltTNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUPbFIXF; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-87c0ea50881so18217846d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760630471; x=1761235271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFQ+JESL9UIjpR6PcV9P6XUYYp4yVYWVkfQwglpsal0=;
        b=TUPbFIXFhdmctjY+zWePfelAMI3NoubXrsoF6dFjQGnrMlEg79jj2uaVMCWRs5CRYE
         P4r0U7Emits0PxLuTWfLSN2zkgHreNV6lEW7UADi/gPB3b+t4sNZwnjepNLpyKUjY71l
         CC+cQdYo0rWCwSiUSJy0lsyXTwu3MNbdI/9hCk7nvrWlNiGpFYiuM+HNAs6GuB6EwKnU
         g6/owUto+TW+yuP3ASgLIkKdNRO9zR25ixi+LSYG2LE0zBFk4c82boGemQap0I5Ah4kG
         uKdpHccXu3gsJ/Lp2uC+AmVPYY7YtghUBaZXBTLWQEOS/M0hbmTH+TjriA2rPu75xoE9
         1sww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760630471; x=1761235271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iFQ+JESL9UIjpR6PcV9P6XUYYp4yVYWVkfQwglpsal0=;
        b=Ci5r0XLzDra9vFzp5BYApYn8ZEmvP0JdNCDcducnPH0/kC10V66cMTt7crWw6K1QQ1
         OWZHj6fLbtALygiebPSPxQuhdJeeJP3p4dNJ3IzrtDMWli41E04I2OjIycRZ2hqD78I4
         WhAWZf6r4VFoHPgafZJ1c09YIBItFU94LtJugBGbMViHprgI1NEUMsRDQxQooDAsrg6N
         nLQ0Us5ldxmCtmfGqKXflaErgjTEZvPyPkuPyL9NGZIwyYT63c1Crt2U2fCfIPwYNTXQ
         EH+uBcVyz1mbvTFt/5AobeNWcUVzeuu/tolXVgV+8Ue4SB/JjRTTD3DpXsbsiT1nmZsn
         C6Zg==
X-Forwarded-Encrypted: i=1; AJvYcCUnulrpHT0AXASkCiq6/CH+YFZB0p6j9GlXHgB0dlzpj1IAkUgnz2/iKDH57ABhNb52MD0Y5kgvE42kDuk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjk3TLI9DLE/xLXDVFAQc7nXIBKzr9Ton/7BnQMRxHfEha7hus
	EAAvhzuZ4FQWlFrW3ep/XHFg4h1NUxpQ3/tOu+652criPk0gnQeKXcBYOGO/RB+YCpCtqEPUw8e
	3TOnXO0YyuCvV9/SPY3fhLxoUY8Pa6Jw=
X-Gm-Gg: ASbGncsdp8BiGVvOw3sOgg6LPv19vfzqt0THHm1rHqH+X+nM9v6KI6p2+dxmLnKB5lk
	sd6geALpmC5h3jtn/9XTiVYSj2SA/BzxK//twZvgFiDE3vlaGCEqtGROqTcXgtHA8PhU9jWNq8B
	pu1GIhNDhqRZPZrmz2rzNf2s21thzpYMic5sGb50uxdgxx5hiZbmqMxjzRBzpFckPU4KNsinw0D
	4/uF1QTru9RG/dLlXnZ6x3zVkpAseSE47Ik8mGNUfrxc6kIAH7/G2VXz6jn+jTWb7PyyIidPD3e
	iTemha0O0kKeGZQeErD/vGKJaXdhSp6Q7dcbLYdVibzT3BKrYXCEjliI40FgLi6yUyWO5RjPKyx
	16LGZOekUNJwyX6zxzeKgMjYgKI2L5hmAHSvMpfkYZUyOEW6bM4p0yoLOECn5GWHCr356HUceUD
	W7pRgbuOPW
X-Google-Smtp-Source: AGHT+IEjNzMcEiWFAsmyuj/Yi6bdGpUfk6izOvZ1EcmWMdmqpXJOOCJ14NVAuKFiY/6bCaKVNofLoAP/TbJKGrstSkg=
X-Received: by 2002:a05:6214:460c:b0:87c:21b0:79e9 with SMTP id
 6a1803df08f44-87c21b07fc2mr1201866d6.60.1760630469114; Thu, 16 Oct 2025
 09:01:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aPBeBxTQLeyFl4mx@chcpu18> <1f9e946d-91e3-4f9a-b26c-e69537cbbd4c@web.de>
In-Reply-To: <1f9e946d-91e3-4f9a-b26c-e69537cbbd4c@web.de>
From: Steve French <smfrench@gmail.com>
Date: Thu, 16 Oct 2025 11:00:57 -0500
X-Gm-Features: AS18NWCxy8CAvRIZM1Ad_Rzkx26Gk4ZxkE8KTaqrRNxF0A5mEjrWE1pFjeru6T0
Message-ID: <CAH2r5mvKpoaD3DDPAc=xUpbcF4TH4nedNdvZg6LBiETG5x3-DQ@mail.gmail.com>
Subject: Re: [PATCH v2] smb: client: Fix refcount leak for cifs_sb_tlink
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Shuhao Fu <sfual@cse.ust.hk>, Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, Bharath SM <bharathsm@microsoft.com>, 
	Paulo Alcantara <pc@manguebit.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
	LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The patch looks fine.  More important is focusing on the fixes (and
missing features) - minor wording of description can be helpful but
MUCH more important is focusing on xfstests, new test scenarios,
automated analysis to find places where use after frees possible etc,
fuzzing (like the great scripts Dr. Morris created for us to show some
potential security issues), fixing the various known bugs, adding the
missing features etc

On Thu, Oct 16, 2025 at 2:22=E2=80=AFAM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> > Fix three refcount inconsistency issues related to `cifs_sb_tlink`.
>
> I find such an introduction sentence not so relevant here.
>
>
> > Comments for `cifs_sb_tlink` state that `cifs_put_tlink()` needs to be
> > called after successful calls to `cifs_sb_tlink()`. Three calls fail to
> > update refcount accordingly, leading to possible resource leaks.
>
> * Can it be preferred to refer to the term =E2=80=9Creference count=E2=80=
=9D?
>
> * Would you find a description of corresponding case distinctions more he=
lpful?
>
> * May resource leaks be indicated also in the summary phrase?
>
> * Would it be helpful to append parentheses to function names at more pla=
ces?
>
> * Is there a need to mention change steps more individually?
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?h=3Dv6.17#n94
>
> * Will development interests grow for the application of scope-based reso=
urce management?
>
>
> Regards,
> Markus
>


--=20
Thanks,

Steve

