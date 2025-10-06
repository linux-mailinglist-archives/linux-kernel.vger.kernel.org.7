Return-Path: <linux-kernel+bounces-843169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD1EBBE8E2
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 17:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E13D1189841D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 15:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C94C2D6E71;
	Mon,  6 Oct 2025 15:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fsq2iuNw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409E23BB5A
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 15:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759766091; cv=none; b=tLuFmAh0wM14seazM8TM1pj7X7jpb5yzvjkTipX1y4GDYirLU51Dc3i+6Zsw+czHjzERUbMkvRFv4vez8Y5HT9srmIwiHi3PMFIdzM4p4ukNJay+6CL2GjQX4w3Jr5Kvn7XLICt5yRMUahvAld3X++CIBwbVmfnHiSNFNPY+7hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759766091; c=relaxed/simple;
	bh=AfkNdgNia/Q46rjV4t/U5RcAXDsYoGIGx61PKRuU3dk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vGDc3l/Du+Gx5IyFxk16h0gB/da6CvnWEtUgkFcX48DN/auQMMtFXKUgukNeAMQdD9MMLGB00qjnZglHiYE0C60xzlMAlxk611poyK11XDAwyRO4BUonZms2tiefOry/4A37s8Kq5cDtbOS/FxmRJvCrbPOd4egf1i0sJql/638=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fsq2iuNw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759766088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O29nBnuJdm1Dd2mtkKVi5j87G2aDHgLgWODowi64nXE=;
	b=Fsq2iuNwgWTjsebOF8p4HmjRr45WUfYidDPvIUqv6CwmN6oLImr8Cbr5rFFyxIbd27XwBK
	JBFkVwv5xM2HItdDg+JHtD7xPaaYcSWQb0CG/A+gVVJlYz5pYKOkEa3IjWlmWT7quAbyiC
	7+55lVBdeUJY4ionThSmhepvB+dcyGA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-9i_nyFnGP5uCppL_FpVF5g-1; Mon, 06 Oct 2025 11:54:46 -0400
X-MC-Unique: 9i_nyFnGP5uCppL_FpVF5g-1
X-Mimecast-MFC-AGG-ID: 9i_nyFnGP5uCppL_FpVF5g_1759766086
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e576157d54so81787231cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 08:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759766086; x=1760370886;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O29nBnuJdm1Dd2mtkKVi5j87G2aDHgLgWODowi64nXE=;
        b=uJHxveEuZwCxpg+kiWHyrH/ugJKCwRDJzXQDrZ/Xs4xp5/hPaVCmNaE4XrJONzBOF9
         WlttfffMwkPvhvRv5h6qzh7/uOAXMZPLZVnFWSBIezIQD0xFAJt+v6XbgBkiTiyEa14W
         WIiwc+FteqWnCVvHw4p8HBXVDJH3T4GuxjqMPCnI9i3HlmQv/rhp7K6BEG9opYd0jJGM
         qwlb6TNim/eCGaHRiInp9PW2Io6bZNB2mEg6/Uno0l1GZ1IUcMz/8MTVSGjcStLX/Zqa
         OyJIiTUrlDxcDBJpDPVvU4R3m/HXkR4d/faWgh9uTHW2f17/iu0XD794jnrBVwW6cdYw
         svWg==
X-Gm-Message-State: AOJu0YyXyI4r0oP/fNLGunRnzXhodfGchZ2wRxfisqFKsiaFYUiWTyrq
	DKVDl0twBufvBxCoFZidD8IZaeZu5nmxdT6ECqVDx7YLvDbIf1psqkgCB8kNpKQdXGznaLygV6S
	UCm3hp1pJ44alkMNQVqVJcN7Ro8BMHLKiwo6gYLuEqgZoc/XQLUISrxHljgMdVfDhHA==
X-Gm-Gg: ASbGncuESEnFHdUCIdPK++3wWLl6Ffww6s+yFWb7U3ObiMQW24kzD277UDiwXgGP9GH
	039cEgYFmi4K4J9VzpCH3BbJfqMpbhwEMFey7CM4EqcJHoQZiqk9MOnQaMxP4en4UvAdxLYzjA5
	iHjJnIaXvPsxGt61rK3RT5Ss18l2u+xZp3QFrlBe2Vrb0L+VuDryvDwn5wjJWB6Qs5yCevBWbzQ
	EQcmoZWvznXwkKELDzoJg2LIj/bhpNBZTSCJHMgSK5RFz18/tZYAJ1VFTTnb7xm4gh8c3bvyfxG
	94kIchS7eUb9c5ezk1G/U9y72LcIYtLnLS7rs1dB1X+2E188iBUpNuZ0Hr8FG1XkxvKwYcCB4tR
	cVg==
X-Received: by 2002:a05:622a:4a14:b0:4de:e0:de78 with SMTP id d75a77b69052e-4e576b09856mr179817091cf.71.1759766085844;
        Mon, 06 Oct 2025 08:54:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIkw89j8ytLrtstbciVHTMITKqTFOIhKtXwbXqgefktZrwuyNarF/iEuUpfQ4eAp4zAHtsQQ==
X-Received: by 2002:a05:622a:4a14:b0:4de:e0:de78 with SMTP id d75a77b69052e-4e576b09856mr179816741cf.71.1759766085398;
        Mon, 06 Oct 2025 08:54:45 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-87771129478sm1234469985a.1.2025.10.06.08.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 08:54:45 -0700 (PDT)
Message-ID: <7359e1e99d715e19db1b1c9e45d28f0c12f0f44e.camel@redhat.com>
Subject: Re: [PATCH 2/2] rtla/tests: Extend action tests to 5s
From: Crystal Wood <crwood@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel	
 <linux-trace-kernel@vger.kernel.org>, John Kacur <jkacur@redhat.com>, Luis
 Goncalves <lgoncalv@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>,
 Wander Lairson Costa	 <wander@redhat.com>
Date: Mon, 06 Oct 2025 10:54:43 -0500
In-Reply-To: <20251006142616.136296-2-tglozar@redhat.com>
References: <20251006142616.136296-1-tglozar@redhat.com>
	 <20251006142616.136296-2-tglozar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-06 at 16:26 +0200, Tomas Glozar wrote:
> In non-BPF mode, it takes up to 1 second for RTLA to notice that tracing
> has been stopped. That means that action tests cannot have a 1 second
> duration, as the SIGALRM will be racing with the threshold overflow.
>=20
> Previously, non-BPF mode actions were buggy and always executed
> the action, even when stopping on duration or SIGINT, preventing
> this issue from manifesting. Now that this has been fixed, the tests
> have become flaky, and this has to be adjusted.
>=20
> Fixes: 4e26f84abfb ("rtla/tests: Add tests for actions")
> Fixes: 05b7e10687c ("tools/rtla: Add remaining support for osnoise action=
s")
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  tools/tracing/rtla/tests/osnoise.t  | 4 ++--
>  tools/tracing/rtla/tests/timerlat.t | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/tools/tracing/rtla/tests/osnoise.t b/tools/tracing/rtla/test=
s/osnoise.t
> index e3c89d45a6bb..08196443fef1 100644
> --- a/tools/tracing/rtla/tests/osnoise.t
> +++ b/tools/tracing/rtla/tests/osnoise.t
> @@ -39,9 +39,9 @@ check "hist stop at failed action" \
>  check "top stop at failed action" \
>  	"timerlat top -T 2 --on-threshold shell,command=3D'echo -n abc; false' =
--on-threshold shell,command=3D'echo -n defgh'" 2 "^abc" "defgh"
>  check "hist with continue" \
> -	"osnoise hist -S 2 -d 1s --on-threshold shell,command=3D'echo TestOutpu=
t' --on-threshold continue" 0 "^TestOutput$"
> +	"osnoise hist -S 2 -d 5s --on-threshold shell,command=3D'echo TestOutpu=
t' --on-threshold continue" 0 "^TestOutput$"
>  check "top with continue" \
> -	"osnoise top -q -S 2 -d 1s --on-threshold shell,command=3D'echo TestOut=
put' --on-threshold continue" 0 "^TestOutput$"
> +	"osnoise top -q -S 2 -d 5s --on-threshold shell,command=3D'echo TestOut=
put' --on-threshold continue" 0 "^TestOutput$"

Not related to this patch other than noticing it via quoted context, but
I spent about a minute trying to figure out why "top stop at failed
action" uses -T instead of -S here, before noticing that it's also
invoking timerlat. :-P

-Crystal


