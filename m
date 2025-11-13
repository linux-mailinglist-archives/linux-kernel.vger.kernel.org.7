Return-Path: <linux-kernel+bounces-899314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC15C575EC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC0553AFC2B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F8134DB68;
	Thu, 13 Nov 2025 12:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lo5USDGo"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FDD27B4E8
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 12:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763036563; cv=none; b=QxmIkDjHxtAViPAlwFXJ89czqj58/BVuPwH/M24lHphnAtHG5RZoeHbP9/TD7fGRsS/Ne94OCb7uulECIX/KL0vmf4N9LyDuShNMBYUhjrlXOd+W66QRWT8NQR43CgCVgozxPsZpHPLcS2GR4Q0mCQKjqT1b2AnggvVVcBjAJpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763036563; c=relaxed/simple;
	bh=ZYqX+ZLRuN0c7Bk/ICAa1u2V7Ht3w8x6fas785R2TSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BdeJEjqAeQyfgQ/qExP4nIRkZKVxuSrwR1EF9BgS/aeRE34ZvZmMLmYgc/lBXL9jdXd1LMM1OoMpRX8B3RVfHZ4jRVO2i1NN5aAe/6P0w6Baf6xP6+viyzszA4tWuvoVCGhSpse+tnGQS2t81oHwYBDIUAXe2oRn2HsqPs9Ti+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lo5USDGo; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b72cbc24637so129624766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 04:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763036560; x=1763641360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3p5IabBvXdkXZ7+EGubMbHl6mikKS/LG8xMUC3eAH00=;
        b=lo5USDGo0QbA5ijZAnqOGITfz98y/RZVJBWwBz6K5hTJ+x57A1VOa1oAYut8V4doWX
         7JCwqg4qm9lBJxnsw5Lag9f9hqG4RdGoXQZ9VP2x2LwYeQT1BBE1cvzzENDjzaGmeU03
         drpRmbvK7T0IvI70cgImIp2VqD9ABjUe1UuIkAyY4iQ0oaXsNkSqLdxvvKzeVWJS2k/o
         SQuKyum5KLVQZpmZO9yarACycpNAAdzZkAoTixNpcKdn2GEB3oxxdN217b5saPCInJRa
         PfO0MpAyaqac+gb2TIZje7zOxcxxEF6Rwx2z5Io58nnAIcW+Qj58Uy0xX2FTh85ctfM+
         gzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763036560; x=1763641360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3p5IabBvXdkXZ7+EGubMbHl6mikKS/LG8xMUC3eAH00=;
        b=Xxo3up2ALxeK5mfQa34dvEirZwSPsKkqjNAOuafoT+qqVlqmCjpVqlId9dZdotz04L
         uPtQNHAAjg8+IsNudAyEQHYRoZw1yOKt4Vbm8x3hFlj2Ik0kOn84/03oT36TyIqZyuot
         5atIsP1nKrK/o/P5aqNijP9Xm2GDMuvhDkJHYXsjnvd1fYmMObQr+SUDHospcs6qhxXF
         jvV58NG0H8RG26vli+VPHCqPqJCGB3bGI7Gtxm+gWWu0mzFyqjmuvwQNqDLRPRku3/O4
         UinG8c705BXEHj2J20guAEqioaKurh+GRG9xXGZWQz48zduSuw5J5ZfapIBkMFPTH1Wf
         FbqA==
X-Forwarded-Encrypted: i=1; AJvYcCVEa1D9/YYSB91OdWD7Hcl7V5EhnUHDlROjVH84Jiua98ft5jurbF6v2Qp0ZOpLt7ofvvD7rmaOCatrSYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCdHfetlVjI+RZ4PwAJ2q9Am3eq24DSoL7EOlHTtleEeAv0oXW
	A2gT7tT7tKLumOj7ZZGg7OWkoUKPQvWWK8DWq3GnVF75/D/eNC+EQDg4fkBMBEWUkujwDp5ZE/K
	SQTiUcBEdQ59OuK5whsjBCf4nkgPMfSw=
X-Gm-Gg: ASbGncvtY4AmELoS7Yaq17Sn9ZS4RCw0YdUe6i5HPUx1hTZTW+V8AJ3dxYXAWaCGi2H
	y8vLsptUX9ctdLhbRou0uC7y04Ht7RA7CfvoSE3e0i7TMSLKejR1IvT6t4mN4BlCDy95er/AISP
	MKinZwCH1vfRl8iz3lq/6DjQKVjiJg8YbvbdvNJu+bDX7g1R+hKC9ZQmrVuXRIM2yv7psEPmLIC
	m8GAbWXkOpSCcnOMmghlhjB14hoZrnxp5kSQdc2mXPkG3ITv5zY2DdFW3k1F9CQhQjuG/DDM3Sc
	2VJy6xf/Cq6wWXrjGujlzVXJXQ==
X-Google-Smtp-Source: AGHT+IHajWmOUi5tVirqZttadrxPuDW8EgmHs+9YBUIXUMLLZEAk7AvCdaI53LFV6WjAMP90FcJnMv5O+DsAooIz/88=
X-Received: by 2002:a17:907:3f23:b0:b42:f820:b7c with SMTP id
 a640c23a62f3a-b7331a6c6d3mr650622166b.41.1763036560109; Thu, 13 Nov 2025
 04:22:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111234519.3467440-1-alistair.francis@wdc.com>
 <20251111234519.3467440-4-alistair.francis@wdc.com> <caadfcbb-8964-4447-a93d-8e49b4c14c7e@suse.de>
 <CAKmqyKNzi7OAq49b-aa1H8++ReTvWnHKBDwA88ionJshhOVp9g@mail.gmail.com> <2019e372-c079-4230-97ba-a3299ced0474@suse.de>
In-Reply-To: <2019e372-c079-4230-97ba-a3299ced0474@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 13 Nov 2025 22:22:13 +1000
X-Gm-Features: AWmQ_bmAssFXEqhTauCGTaWw-0uu2B0mXfE1GiVBD99ZnIinb6qgcFh4JAAHSvY
Message-ID: <CAKmqyKOBr2eV6AeWH6SHz_UX4ciKgdf3zGJ9LMHEOuFz55kO+A@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] nvme: Expose the tls_configured sysfs for secure
 concat connections
To: Hannes Reinecke <hare@suse.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, 
	kch@nvidia.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 5:21=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 11/13/25 03:08, Alistair Francis wrote:
> > On Wed, Nov 12, 2025 at 5:08=E2=80=AFPM Hannes Reinecke <hare@suse.de> =
wrote:
> >>
> >> On 11/12/25 00:45, alistair23@gmail.com wrote:
> >>> From: Alistair Francis <alistair.francis@wdc.com>
> >>>
> >>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> >>> ---
> >>> v2:
> >>>    - New patch
> >>>
> >>>    drivers/nvme/host/sysfs.c | 2 +-
> >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> >>> index 29430949ce2f..6d10e12136d0 100644
> >>> --- a/drivers/nvme/host/sysfs.c
> >>> +++ b/drivers/nvme/host/sysfs.c
> >>> @@ -838,7 +838,7 @@ static umode_t nvme_tls_attrs_are_visible(struct =
kobject *kobj,
> >>>            !ctrl->opts->tls && !ctrl->opts->concat)
> >>>                return 0;
> >>>        if (a =3D=3D &dev_attr_tls_configured_key.attr &&
> >>> -         (!ctrl->opts->tls_key || ctrl->opts->concat))
> >>> +         !ctrl->opts->concat)
> >>>                return 0;
> >>>        if (a =3D=3D &dev_attr_tls_keyring.attr &&
> >>>            !ctrl->opts->keyring)
> >>
> >> ??
> >>
> >> How can you have a configured TLS Key for secure concatenation?
> >
> > I'm not sure I follow
> >
> > `ctrl->opts->tls_key` is directly set at the end of the
> > `nvme_auth_secure_concat()` function, so it will be set for secure
> > concatenation.
> >
> Right, sorry. Of course you are right.
>
> But I'm still a bit unsure about the interface here; just writing
> anything into it doesn't feel like the correct way of doing it.

I'm happy to change that.

I was thinking a bool, so basically write 1 to trigger

>
> I would rather modify the interface to allow a key serial number (or 0).
> That would allow us to modify the configured key, which currently is
> fixed for the lifetime of the connection.

Wouldn't a configured key (`tls_key`) be changed via the tlshd
interface, not writing a key serial to sysfs?

> And writing '0' would reset the configured key, reverting to automatic
> key selection.
> Having such an interface would actually be beneficial, as it would
> remove some limitations from the current interface.

Anyway, I'm not sure your vision conflicts with allowing "write 1 to
`tls_configured_key` to trigger a REPLACETLSPSK"

Alistair

>
> Hmm?
>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich

