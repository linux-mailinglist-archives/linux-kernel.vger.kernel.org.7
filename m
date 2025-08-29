Return-Path: <linux-kernel+bounces-792340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53390B3C2E5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 21:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FCB8A043FD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 19:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55A4239E70;
	Fri, 29 Aug 2025 19:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O0QH6lym"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16894A23
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 19:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756494755; cv=none; b=YZvAoKzszw17NsrcPRfyGqHVf8+x+/9C6Z42TBBAQN0Z+dODFCAOGi2+mELWEWxhjgvJr3GfJnFLxXRpm7JPdhnIELksuZqbo5jJCEGC3+fegKuZ+poJEm1q3ealu7DXhbqOhf5sGwrwAEql+qiyA2ot+7YdTeh+v0VZQTeAJqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756494755; c=relaxed/simple;
	bh=V/m3x91BNGxXQk/xVbw01DnJgrBeVY3UssBVksdPu1s=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mgYcjgAtCi9J6I+YYxew2RPJxhvtAZOzU4jG4EKnv4HM2/AufUgshIXeumlscdkrccnRBRhbi6x3akhMNd2FG4NXdkBhLLmMXIsIqvqRzNva69rqB2aYgYdgRDBiJ4jeQRE/BlD74uwxAG5WBGlfcvhcjHPWmx1c8JTK2lEnA2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O0QH6lym; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756494752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BZm2cWpIstR902xrNzB24xS3rX1N5ZEznfpie+G8xH8=;
	b=O0QH6lymHCXnATFhjgqvlmHlgOZW/tigBPjM2ZRnenMPlVOV1DQA7+KDHrYHaDk3XhcL20
	YLi6f1uCoxcVULuof5u7ThO3rMmPNCqfPuGxI9/mv5ObYQWHUYX/aKN/15j+IWaYhx63Tj
	MGvoyaGymYRZ3BY4JxW5HB1naBRpGuo=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-YJwzhlzPPDagcI_-mb8Nsg-1; Fri, 29 Aug 2025 15:12:30 -0400
X-MC-Unique: YJwzhlzPPDagcI_-mb8Nsg-1
X-Mimecast-MFC-AGG-ID: YJwzhlzPPDagcI_-mb8Nsg_1756494750
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3f340e9b5c5so5215085ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 12:12:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756494750; x=1757099550;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BZm2cWpIstR902xrNzB24xS3rX1N5ZEznfpie+G8xH8=;
        b=TnC5uJ6U3PJqBRiSKOmNSwBlXc021xjRpyenSxgmdHAe/yjFOu8Z0vXYvdwpeN7RPL
         ldCVpmBsqElSsBqHFr7rO0HoQL4fOpRcV46ZeFXxcwW9peb2xzFM7ncVh6NvgFYom71X
         ZWHd8/z23guccnKBfsdcJZLCzqV60ScceBVw7ifJo1ouzd3RNJg4gMGOIQ5c+zfTNAj7
         8s1LGP3ctgoAMyEn0galvV5LV4axEyFh/BrY+1/4FdSGRsGhHiIfDTS/4vj1BDsBi+0y
         FLj4BbudlY5D/3R/RZb3c3JV+WHAkw4dvNcxDw8D/fZww2cAPAtF6y18e6aUeV4fL+0R
         xT0w==
X-Forwarded-Encrypted: i=1; AJvYcCU5EkuqeBSSfM4bWCTwtlbwuICR+WFoKQsZZuL2xbD4b4BZCiSn3MR38pzmwO7h/khbM16AXCXbvssiS5M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpn+OvHrtCX9KjgYJ7rkIR7HKlVjnh3iCLd25efSHn1dsJIK6p
	WIQJM8qOSdhpSiqMCesbJIHF6jTrEVBn1E8+oSwOdIxUlFxGGh+OL23wcU78CoUdWdoOAFnwvFt
	qiLP4EATWLsIUyPH7QFLh0jc/oz01Ifj8qmAIWF4YEQK0npXt/rJFgGfxYMEbFnhM7w==
X-Gm-Gg: ASbGncsljd48uImqzrAPoCVuB1XuPJolavWExVGNIOvr7C3ywxEGH4H1jGtwCuOHgGX
	Ap182oWskSQXl1ZtMm+L5rpmBF1K5uj3H68aNQaTVBG0c+j6t4ohyQryejey/a04f2Ml/emhkKu
	COw5YCVqRQQ6jASs1dJX4XZ3Sp4DzcG8p6T8G7CtTBtWWPmDBO8yC2uFjaLLY3jigF5szIVjvmY
	ru1OeJIL1hAFKoDtXOHkjO2CV+TiYZPZo8RHoqWcjizumX1Ym5h7NM+naRaA4Nr53EH7I5rsGZi
	NzppbzOFB/rhbLhcaCYntxPYjbNBUyLe/7DfuQhdG8uq2tHSH64z1GN9mkIg5E9nV5Ly
X-Received: by 2002:a05:6e02:1845:b0:3f2:102b:bb3f with SMTP id e9e14a558f8ab-3f2102bbe6emr94593485ab.16.1756494749722;
        Fri, 29 Aug 2025 12:12:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEp17PYTjscfY9oa2sbWXEFfqHk/8rOHgt2sJktj1EO4noupiV57kW7xO47q2rgyKkjnPt3LA==
X-Received: by 2002:a05:6e02:1845:b0:3f2:102b:bb3f with SMTP id e9e14a558f8ab-3f2102bbe6emr94592895ab.16.1756494749273;
        Fri, 29 Aug 2025 12:12:29 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([50.145.183.242])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50d8f3e6c3asm38211173.84.2025.08.29.12.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 12:12:28 -0700 (PDT)
Message-ID: <3b9bf6e435b2eb85b44557d474a003ec6d2c0c1c.camel@redhat.com>
Subject: Re: [PATCH v2 2/3] rtla: fix -C/--cgroup interface
From: Crystal Wood <crwood@redhat.com>
To: Ivan Pravdin <ipravdin.official@gmail.com>, rostedt@goodmis.org, 
	corbet@lwn.net, tglozar@redhat.com, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 29 Aug 2025 14:12:28 -0500
In-Reply-To: <9394c039d5c957bd8417669148391e20fa1276ee.1755018581.git.ipravdin.official@gmail.com>
References: <cover.1755018581.git.ipravdin.official@gmail.com>
	 <9394c039d5c957bd8417669148391e20fa1276ee.1755018581.git.ipravdin.official@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-08-12 at 13:21 -0400, Ivan Pravdin wrote:
> Currently, user can only specify cgroup to the tracer's thread the
> following ways:
>=20
>     `-C[cgroup]`
>     `-C[=3Dcgroup]`
>     `--cgroup[=3Dcgroup]`
>=20
> If user tries to specify cgroup as `-C [cgroup]` or `--cgroup [cgroup]`,
> the parser silently fails and rtla's cgroup is used for the tracer
> threads.
>=20
> To make interface more user-friendly, allow user to specify cgroup in
> the aforementioned way, i.e. `-C [cgroup]` and `--cgroup [cgroup]`
>=20
> Change documentation to reflect this user interface change.

I know these are the semantics that --trace implements, but they're
rather atypical... especially -C=3Dgroup.


> @@ -559,12 +559,17 @@ static struct osnoise_params
>  			break;
>  		case 'C':
>  			params->cgroup =3D 1;
> -			if (!optarg) {
> -				/* will inherit this cgroup */
> +			if (optarg) {
> +				if (optarg[0] =3D=3D '=3D') {
> +					/* skip the =3D */
> +					params->cgroup_name =3D &optarg[1];
> +				} else {
> +					params->cgroup_name =3D optarg;
> +				}
> +			} else if (optind < argc && argv[optind][0] !=3D '-') {
> +				params->cgroup_name =3D argv[optind];
> +			} else {
>  				params->cgroup_name =3D NULL;
> -			} else if (*optarg =3D=3D '=3D') {
> -				/* skip the =3D */
> -				params->cgroup_name =3D ++optarg;

If we're going to be consistently using these semantics, we should move
this logic into a utility function rather than open-coding it
everywhere.

Also, theoretically, shouldn't we be advancing optind for the case where
that's consumed?  Not that it matters much if we don't have positional
arguments once the options begin, and if we did, then allowing
"--arg optional-thing" would be ambiguous...

-Crystal


