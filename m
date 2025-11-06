Return-Path: <linux-kernel+bounces-889052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3285C3C970
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EB053B19B8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F3B32D0E3;
	Thu,  6 Nov 2025 16:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A3SYUcM3"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03E61E3DE8
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762447488; cv=none; b=JgqSN2BEaSHBzkXx8D2S0+k0vBt/W31TWE4NQaR9QqYup/BiweFGD2WQQkVeZa5yFmYw/xu9Rui1b0/fhG1y2i+9K9E0zKecsrCez1DUbIPPHuw6xbZgoH4bKig3C7Ksl6G+5Iyfk05UIeqJaoRTVHEHn3vLgNrR3WvU0X9PRsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762447488; c=relaxed/simple;
	bh=rEUjsRVYzdi3XI1LFM54/o+nJWhRShVbyXSOqbKmxsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=omJ54TY3Q7692J4Zi9pZFqHftZsJAu+xP1NstyOp7NoDDlXCtiPDiz63hfGj0oq8QuLEIi3llr8kQyjtBLS50h6QNsjTFBh0mKHlcBcrK6zC+PePB8u9BX4mdwUaTCnemTdBVDQTQZS++o23P5jl6l2psOff3Tw5Bpl59+Ah9rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A3SYUcM3; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ed67a143c5so397581cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 08:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762447485; x=1763052285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rb0xQ7azPtb5R1c1dFfey4+Gdz93xWujtr+XNfeYFuM=;
        b=A3SYUcM3OADG2bHWnjroLM1+o0xLGbQDNBfwsHqoeNOIhVahSK2vQdh+J4oUaGwdBk
         k9Gs9YLL73EIl+IxcO/SXu/nYkVMEikBEMF8pUgV0mEaV3bjs3oRrpTLdhFy8qKBsSG7
         B0adkbWuCZuszKqHbAGNtx5PPgs9QU3EwFv2JezToAnq08fYVUqaCmEgWrlzysDeVCwi
         +eGY1ZCwmhkiKhtKaLbEhS/Ys1aJQJuGj1kICi8DwCxMPA8oFyyBCrpeVbUBqryTIMm7
         U8TWgvob3JG6QMgyALpFKSEEncuOxDkazNxuxzBss+NGssKZdLAtt5WAld1maX+5JDAC
         kLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762447485; x=1763052285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rb0xQ7azPtb5R1c1dFfey4+Gdz93xWujtr+XNfeYFuM=;
        b=SZmIlpGhUQTmv0gjEOG62lkuslwa0YBQdcUx9TVEHFZpHdrpGP8uKOZftEaYd46Y/K
         JaSAyPuNkX9N+8VZSg5GDQibqFmSEZRTSug+TlbGruG9lz3mmj/IZPYUN3nG4XBmFvg2
         tSJS268kXNNHbo2g0NYkyrve88M63mFm++EfTgXpZsIWHpXrIJnWifh9uHPmQEk4YpZF
         /+YiyaGjOuhHz5BxCmUIBe0lzhJpRIasqv/bQm0pWnO+efDqaM7YBdT++0bcLkdUyBvx
         L7ZPV9dN4rIKDqIfd3W+2np4U5SbXSDnCRtf78aQxsy7EtUHMxqGJZ28kmaGnP9v2MeL
         L97w==
X-Forwarded-Encrypted: i=1; AJvYcCX+4HYGNgG8/GaqH4vXaOKgnRsGDWkt6qt1lNoBDafMXUpoSHFnKopOAxluXwSYFMh3lt9xY7ICjAVePwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqB4mCRX8sJkpmujlW5u4+M61U3yo49WPju2BMF/NN0+swLe/F
	ADOKviL08SNq7BiSipYKFZ4bZ23vqAFW1wy8c2kcI88E+5WHS2quXXWgdbrN0EWpgsKmiieW9s+
	WCEtR2TWEO6xgntE9VPbv3DlYO2DkqvWtYUaHX8Be
X-Gm-Gg: ASbGnct3/q/4ocNp8sB4ZU7ysTwDYJsosR1omMFKolSqPIRdptxVa8Gb6aaz4YQ1Ch5
	OjvRVdqIPvz7LVPQnonHlKjRyoNzhw6JywJZ4VOKO4zQ2612GCCxJ2dVbzKmw5cNh4reUXlr8oe
	zoFbgIJTCzd1ZCP4yeU6byAfI3JrDIQE2hxbhWfFPgy9bJDrj6o/gcaS3jYNn+BpiBV/vdmojh/
	gkVB0kcQnP5PFiBfaILA5M011dZDLKe0fiTOsa8nJe+j9Yh+sj0mFKzTh/7k2Zq1Wp9O+Q=
X-Google-Smtp-Source: AGHT+IEcLrlYbh4mCr4c1Dl3FMnHNJ8BGbv+8eVtdigWkONCN7ekj7UeCPoYuiSi/E3ZLOfRY4zNtnzunYFejtXPYzI=
X-Received: by 2002:a05:622a:1105:b0:4b5:d6bb:f29b with SMTP id
 d75a77b69052e-4ed81475fd7mr8177711cf.8.1762447485338; Thu, 06 Nov 2025
 08:44:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104003536.3601931-1-rananta@google.com> <20251104003536.3601931-4-rananta@google.com>
 <aQvlVzljJhKQQ2ji@google.com>
In-Reply-To: <aQvlVzljJhKQQ2ji@google.com>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Thu, 6 Nov 2025 22:14:33 +0530
X-Gm-Features: AWmQ_bnqsBhfkU0Z8CSVpXkdXubHfrNkA7o_iAWY9Mzo7gnOb_3JOEiFi4oC96M
Message-ID: <CAJHc60yVkMUW4C7i5WAb37AixEd1xL+oK=NUnFbqA2PGgHN0Pw@mail.gmail.com>
Subject: Re: [PATCH 3/4] vfio: selftests: Add helper to set/override a vf_token
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Alex Williamson <alex.williamson@redhat.com>, 
	Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 5:31=E2=80=AFAM David Matlack <dmatlack@google.com> =
wrote:
>
> On 2025-11-04 12:35 AM, Raghavendra Rao Ananta wrote:
> > Not only at init, but a vf_token can also be set via the
> > VFIO_DEVICE_FEATURE ioctl, by setting the
> > VFIO_DEVICE_FEATURE_PCI_VF_TOKEN flag. Add an API to utilize this
> > functionality from the test code.
>
> Say what the commit does first. Then add context (e.g.  compare/contrast
> to other ways of setting the VF token).
>
> Also please add a sentence about how this will be used in a subsequent
> commit, since there are no callers in this commit.
>
> > +void vfio_device_set_vf_token(int fd, const char *vf_token)
> > +{
> > +     uuid_t token_uuid =3D {0};
> > +
> > +     VFIO_ASSERT_NOT_NULL(vf_token, "vf_token is NULL");
>
> nit: The help message here is not needed. It will be very obvious that
> vf_token is NULL if this assert fires :)
I'll apply these suggestions in v2.

Thank you.
Raghavendra

