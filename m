Return-Path: <linux-kernel+bounces-830326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 796B1B99680
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F32D19C591F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F07D2DE701;
	Wed, 24 Sep 2025 10:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vZx+u1iD"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7DF18DB35
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758709288; cv=none; b=AcBj8gxqHVOuVlywRS/rXFIkkF06hMfmcC/ykoM8SDlkMiryyI/QvArrLetqLXjU18G/umM2kKtM7cUC0rBa23mqXVmFCsoB4U94nB9JJvoLIZl+Wtzwxi9hFFyqP14UznT8fVg+zUivb9SjsNDqauqhAe1SZXHWcYIMc/6BbHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758709288; c=relaxed/simple;
	bh=V85DAqeKF7uCVUFzQS25hzrawcaD1ltEEeO8PHPGUbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bjwIgRPxIlfIwvmiUeL4mGKLVYKnuVt+kPyBVqkFs+5cL2k3iJvp069fcV6ikpJNsrrroMrnddffSs+jwFjJEK3+aoGAh7IEwQc3FAzo7+qNTRUo+4AHe9I3vXPXk3EccbLN2eoFhp+Ta/XYtgrpaLc/gHHzpDvmYA/vSj+eaFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vZx+u1iD; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-32b8919e7c7so7528380a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 03:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758709282; x=1759314082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cEtxo1qh0vSZfiRMY7z3jrPAH+D2wK0pK7I8P4ap9/c=;
        b=vZx+u1iD307GpX0qy2PiL68xQ6PJzPQchWfU5dTCw1I4S65EUhQL2+b/+G1qJP/Bxw
         CX6EJglSQJOj9Y+yQ5eo4Pn9rOcOk57PHvR76h17+8qq98LYzaVYEJ1iuXuvc1hd0QOT
         Pf06cieTJoSYtF/6j2IMrXQyWA3jEcGeLbwEK+3bY8t3WTmtGaGfJvNyYQkWD6WGK/JM
         9q99wLrp8qSQ9j8xWmLAX5kASwSBxX1fihvlBB7lexpKnc5mkqfXU0iDQleBhL/TO1T0
         Lnib946oSzkciJ/RA+/UuMwUNzHKynkiBXGxapGIlKwO/DLvP/hiSYKg1luWdDFaN0qw
         hMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758709282; x=1759314082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cEtxo1qh0vSZfiRMY7z3jrPAH+D2wK0pK7I8P4ap9/c=;
        b=U1/ZtQP06+Sb25E2E8ohxDOfxD/Cfp4/h3NTNfmYIUHpc1EuhuwqADXPUjgFUWYqcY
         F/sbdjLtR5RzWUKg3O8Kv4J7T6++oYFRx/sMK+YZcGM+0Vo3lFcyDDLBG2/7vHqpSy8o
         6GGp0VlNJ7bkovcSVMe66odwJ8eT7Eh6btLAfeV6nUXMS2ceUIP3Gf7ZhWdlcFmaQFpV
         QfASne9E2O5m6HQaLk/vNN+i3pNIVclij/sUvfaGkgMxfD3EgmqwJJn43opGDvmAwVMv
         RU2egiCy3e5Pp4zILf4hT/Gfkypb4J1pgVe+B3x51PBQzfBPNrG3TYfs06pJo4fTMYkS
         QcUg==
X-Forwarded-Encrypted: i=1; AJvYcCW2PprU6qBKTt2zVfHGKUSEDz2UZ4/+LLQwsqvR8OWuNmeiC1PLFTZSxoSIpKMW9slLl0axEbk31LGHigg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY6VVnwHSiqtie1N1a0OciYnSRf5x+WoZpA7YW+fbRvvr/D9mI
	DFCnTJekUAP2gdyZmhJrQw/Svb0R9lFVL4D6q3l2J37AiGC2OJYNtCEkV/3t+OMQfHViGX5/Zsx
	TgMVcn9XPTMHWWHOwTKj6DIXWRl8Aj4nl8aAtm4vN5Q==
X-Gm-Gg: ASbGnctSiD/ZZIcgXc4tvwTDZmS006rXlOTTjLrDMDjQjt50+PJjU7QJx5eqnhK3s9U
	0ikSU5PHzobODKCwGpU3IJs6p0o3C7Zf3Y/x42HlQsnjKH8kazywnu7qYAi96KD/sR28A8GeYqS
	hWfTUA5WjUkYl4hgRVEoWH34r5SieIfXiJ88Aa7E1vyO8Dbd2bRssAHW8fQsfKbMUrxGl2Pa4Ce
	FLe/mjm
X-Google-Smtp-Source: AGHT+IELzzr59iWDFLuLUlnodmKRzoKN3FELPWASFS/xO49v4Qy3nq0EpzogKfl7Z5fEFAlvjSXdLYsIE340jGGlCfo=
X-Received: by 2002:a17:90b:2ecc:b0:32d:db5b:7636 with SMTP id
 98e67ed59e1d1-332a9705134mr6815232a91.27.1758709281426; Wed, 24 Sep 2025
 03:21:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922-fix_helper_data-v1-0-905e8115a24e@oss.qualcomm.com>
 <20250922-fix_helper_data-v1-1-905e8115a24e@oss.qualcomm.com>
 <874isuo0m2.fsf@rasp.cworth.amperemail.amperecomputing.com> <f7be3833-9b33-4935-b821-a2e0000a2557@oss.qualcomm.com>
In-Reply-To: <f7be3833-9b33-4935-b821-a2e0000a2557@oss.qualcomm.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Wed, 24 Sep 2025 11:21:10 +0100
X-Gm-Features: AS18NWDFNIL7VglMmSBole_iUD49ro8jRAt-S6snaAybCp3PILujr8-kdaePfko
Message-ID: <CAJ9a7VjaUE+iy=FFwPhCdfXgoGR3rP9WSx-ZkKYeCHhqJ2yzMg@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] coresight: tmc: add the handle of the event to
 the path
To: Jie Gan <jie.gan@oss.qualcomm.com>
Cc: Carl Worth <carl@os.amperecomputing.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	James Clark <james.clark@linaro.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 23 Sept 2025 at 02:49, Jie Gan <jie.gan@oss.qualcomm.com> wrote:
>
>
>
> On 9/23/2025 1:31 AM, Carl Worth wrote:
> > Jie Gan <jie.gan@oss.qualcomm.com> writes:
> >> From: Carl Worth <carl@os.amperecomputing.com>
> >>
> >> The handle is essential for retrieving the AUX_EVENT of each CPU and i=
s
> >> required in perf mode. It has been added to the coresight_path so that
> >> dependent devices can access it from the path when needed.
> >
> > I'd still like to have the original command I used to trigger the bug i=
n
> > the commit message. I really like having reproduction steps captured in
> > commit messages when I look back at commits in the future. So, that was=
:
> >
> >        perf record -e cs_etm//k -C 0-9 dd if=3D/dev/zero of=3D/dev/null
> >
>
> Sure, I=E2=80=99ll include your commit message in the formal patch series=
, I
> think it's V3 since you have submitted two versions, if you're okay with
> me sending it out.
>
> >>   /**
> >>    * struct coresight_path - data needed by enable/disable path
> >> - * @path_list:              path from source to sink.
> >> - * @trace_id:          trace_id of the whole path.
> >> + * @path_list:                      path from source to sink.
> >> + * @trace_id:                       trace_id of the whole path.
> >> + * struct perf_output_handle:       handle of the aux_event.
> >>    */
> >
> > Fixing to "@handle" was mentioned in another comment already.
> >
> > Something about the above still feels a little off to me. It feels like
> > we're throwing new data into a structure just because it happens to be
> > conveniently at hand for the code paths we're needing, and not because
> > it really _belongs_ there.
> >
>
This data is perf specific - not path generic; so I agree that this
structure should go elsewhere.

I would suggest in the csdev (coresight_device) structure itself. We
already have some sink specific data in here e.g. perf_sink_id_map.

This could then be set/clear in the functions coresight-etm-perf.c
file, where there is a significant amount of code dealing with the
perf handle and ensuring it is valid and in scope.

This can then be set only when appropriate - for source / sink devices
and only when in perf mode, and avoid the need to pass the handle
around as API call parameters.

Regards

Mike.




> The core idea behind coresight_path is that it can hold all the data
> potentially needed by any device along the path.
>
> For example with the path ETM->Link->ETR->CATU:
>
> All the mentioned devices operate by forming a path, for which the
> system constructs a coresight_path. This 'path' is then passed to each
> device along the route, allowing any device to directly access the
> required data from coresight_path instead of receiving it as a separate
> argument.
>
> Imagine a device that requires more than two or three arguments, and you
> want to pass them through coresight_enable_path or similar functions...
>
> For certain coresight_path instances, we may not need the handle or
> other parameters. Since these values are initialized, it's acceptable to
> leave them as NULL or 0.
>
>
> > Or, maybe it's the right place for it, and the cause of my concern is
> > that "path" is an overly-narrow name in struct coresight_path?
> >
>
> It defines the direction of data flow=E2=80=94serving as the path for tra=
ce data.
>
> Thanks,
> Jie
>
> > But if a renaming of this structure would improve the code, I'd also be
> > fine with that happening in a subsequent commit, so I won't try to hold
> > up the current series based on that.
> >
> > -Carl
>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

