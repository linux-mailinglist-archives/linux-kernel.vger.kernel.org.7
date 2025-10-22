Return-Path: <linux-kernel+bounces-864917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B4FBFBD95
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2295018C7FF0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029BC343218;
	Wed, 22 Oct 2025 12:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3BVQuZy"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A60285C8B
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761136191; cv=none; b=oNnu+RYjBmXLrcFpaSFnBQesNapdh2SRinIVkTCKiw4CHVB/iHcakHRmTYFws50NbbM+QkSvQom7xWDaPlYnCcohfQ9jwT9UVazqy0PlRMs4R/ct+c9Mg2aNDFw23dzi6WlXeoIxN1SLaQmzevn+dWbvLhmSzWY3Bl/Jx1oHw8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761136191; c=relaxed/simple;
	bh=vgC3n0OZ1bnLi7NXIKoKa5wMxZUzOLDPYVTIZbfJmj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kQxdsy1NdvORFKXN7vnKNlO6DgxIzZlgVjzjIgtj4weIJiBUqFZ57AVA4WS5m/liWAozGAmY6LRd9Vx3mJksc4WtNeGzJjwximimYDWFmffmZc1CrR+uXSh0YYrG7G4twAEEZrWUmC52xqakszp8IK5xZ2l0OrHSJBH5pa8VJQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3BVQuZy; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-33db8fde85cso3392166a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 05:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761136189; x=1761740989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgC3n0OZ1bnLi7NXIKoKa5wMxZUzOLDPYVTIZbfJmj4=;
        b=S3BVQuZyQDMihY1DiOQhTqoHrc0JSezF+SrIm/6crpMEl2SBzFHXrEYHDNsL2CkGQu
         MwogX241XB9DVfcBpWxIRvn0mGp4wPYlxyt4GQA/iBhzSPmzYupj7wo76NqEp4aH/I4A
         f/P7Lj6kJM+rjp+4hvqZ6AnDRp71DjmYTu0t3DJujtdDa+aq8XNBdwHLeOzQuDUKOmkU
         5HXtspHgRVPpsMILr9J2avxLtphr++dNgPS0dtUntattN5Z5j3WX7WThhy+8gK2KYTq6
         NEJBRayXi/ZicMZ3+GZudY7v59gp1b3sy401Xl6ePDjajXfEzma4cqwjioGuieHWuOEh
         lZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761136189; x=1761740989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vgC3n0OZ1bnLi7NXIKoKa5wMxZUzOLDPYVTIZbfJmj4=;
        b=C8s0oiXeM35HG4r/huc52Y98sf8ZC/JvgztGJGu/dOaNxYP0j64r38Z6Fp8m40A50x
         4A9dN9K9fDEHOPNjvKyxAQYcp1CopNaKTsOrvKfM2knWXC55sLv2HyLbmkwfvLJEoErD
         4/LLMDFpYdfLFThC5lTD5JKSog0BdsWsWwqkNB/r7uQE6FPLdGf965Hx9NdLZb/PvjCd
         0fw0aazE6MOdw6SoyqWa/ZfdLhitO/CVa6WR7x/GNfM2IU84ZUWp6FRNm9G6TYOIbR0K
         af25Oia8po4AH8nkwcVjFUaJGUNkzeiRyh2pWE8oZBGEnZ/Oy1RUVr7D2mMX9WMrzCWl
         vH/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU9Ywh61N8X9ZqRPHbCTIcspwSBvxrXGPN3baAnZdQ1uq29NdpNNeCKOd9S7pfC/1EqZNFIJ1GV5snFr4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5V/YrPY7ql4S8j9cPzwiprV0Oq9yECK4329WcYFzTHm1XSSkE
	mPWD2KUBCXp7Nh2EsOlpHPsGnvPgJbhNXNIgvlPNb4RlzIsAfv91YMNbkuXyDPwwLytGIeZlONU
	uEHZj+eHFXVFm1O7rB1cGyQMJTsYsibQ0bQ==
X-Gm-Gg: ASbGncvDDj2VeARm7WgCuV1E+cDPCtemx/4QNS6RsMFVOEXJvBR7BigjDQFZqOJveIZ
	HhJmLUt1XUb+JFtdTl8Ad4SFrVNvcGVWA7OXRsdQrMhmIAs4GKxkjSkb/vSd3A23ve5LGMQznjo
	K4IxJ5KYPTwfzrF6KMBqqeK+TCeyNNHiL3oCEDVkiMM84SPzspjvpXBO1APybVYHT2Wzd6NqwSR
	dgXB0iOm1bq8aLtdl7ew+UJeaVqCIA8SyQFEmqW4a/pQRUcIkCsRjD+g60G
X-Google-Smtp-Source: AGHT+IFk5lUB3XklutyN+j9IdIuo6/klqXs33Xtsaz01xAhHZvg8eDzK6DGwTKzo99rOs65RxDj4T2Swtuqtu02nU9M=
X-Received: by 2002:a17:90a:e7d0:b0:32e:5d87:8abc with SMTP id
 98e67ed59e1d1-33bcf9146e9mr23394414a91.36.1761136189075; Wed, 22 Oct 2025
 05:29:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022072729.14820-1-xion.wang@mediatek.com> <CAFqZXNuPqwfqA23LH8NOG6KM1Nb7WvW77wnpp-vZ5omU40j_qQ@mail.gmail.com>
In-Reply-To: <CAFqZXNuPqwfqA23LH8NOG6KM1Nb7WvW77wnpp-vZ5omU40j_qQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 22 Oct 2025 08:29:38 -0400
X-Gm-Features: AS18NWDSicEYx03TrEtOYVQuMO2BdGJlpNak_oI6vlqZpLBKSoJCcwBSCBuNhu8
Message-ID: <CAEjxPJ5BWjvDmQ37PPLHrmcTwRnOy6eW_uNoKG=ERZqRMAc3dw@mail.gmail.com>
Subject: Re: [PATCH 0/1] selinux: export current_sid API for use in other
 kernel modules
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: xion.wang@mediatek.com, Paul Moore <paul@paul-moore.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, wsd_upstream@mediatek.com, 
	huadian.liu@mediatek.com, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 4:08=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> On Wed, Oct 22, 2025 at 9:43=E2=80=AFAM <xion.wang@mediatek.com> wrote:
> >
> > From: Xion Wang <xion.wang@mediatek.com>
> >
> > We have a kernel driver designed to monitor the status of the Android
> > userspace watchdog. The implementation works as follows: we modify the
> > Android userspace watchdog code to periodically send a "kick" signal to
> > the kernel driver via ioctl, so that the kernel driver can determine
> > whether the userspace is still responsive. If the kernel driver does no=
t
> > receive a kick signal from the userspace watchdog within a certain
> > period, it infers that the userspace is stuck. In this case, the kernel
> > driver will dump key process information at the kernel level and trigge=
r
> > a full system reboot.
> >
> > To ensure that only the legitimate Android userspace watchdog process c=
an
> > access the ioctl interface and perform the kick operation, and to preve=
nt
> > malicious or unauthorized processes from spoofing the kick action (whic=
h
> > could compromise system reliability), we want to identify the calling
> > task by its security identifier (sid). By checking the sid, we can
> > effectively prevent unauthorized processes from sending kick signals.
> >
> > Currently, the current_sid() function in the kernel is defined as
> > static inline and cannot be directly called from modules or drivers. We
> > propose to export this function, so that the kernel driver can call
> > current_sid() to obtain the sid of the current process and decide wheth=
er
> > to allow the kick operation.
> >
> > This change will help enhance system security and robustness by
> > preventing the watchdog mechanism from being bypassed or abused.
> >
> > I would like to ask the maintainers if there are any additional securit=
y
> > concerns regarding exporting current_sid() as a public API, or if there
> > are any alternative or more recommended approaches to achieve this goal=
.
> > Any feedback or suggestions would be greatly appreciated.
>
> Couldn't you just use security_cred_getsecid() or the new
> security_cred_getlsmprop()?
>
> Untested:
>
> u32 sid;
> security_cred_getsecid(current_cred(), &sid);
>
> -- or --
>
> lsm_prop prop;
> security_cred_getlsmprop(current_cred(), &prop);
> u32 sid =3D prop.selinux->secid;
>

I suppose the next logical question would be what will you do with the
secid - you can't just compare it to a fixed value since they are
dynamically assigned.
Normally you would instead just pass it to a SELinux permission check
to see if that SID is allowed the permission required to perform this
operation.
But this too would require using a LSM hook to perform the permission
check (in which case you don't need to fetch the SID separately; it
can all be done within the same hook).

