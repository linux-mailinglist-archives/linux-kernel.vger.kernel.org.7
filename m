Return-Path: <linux-kernel+bounces-897780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A5AC53B9E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8654B502CA0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C7E341AD8;
	Wed, 12 Nov 2025 16:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SC8HyX6o"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DFC340280
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762966217; cv=none; b=RWB0kVlh8CRsDdAlirlenTARCsR039Hv4LUPHMXwFrmn5tto35Tj711DTnxeazBkBbipKan/+EdDerbYVi8MPp3vbYD9Fk2lzr7zhMCKvWbcxyRqfFyBeZuX9El7hCDGJBY5DzEbrrLXj05knptyG103TUtm1nxFPIQTodpV3ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762966217; c=relaxed/simple;
	bh=Tiwbde6lhRPpVFkuGMnOq1cdj+tm313o4sMRI6JbwIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eDnmRHWFCIfWdd5ylZrzPt8YpkXw630RwPxwfvwub/SdBOQzdMmdGuxdURAEXNI6c9Yd8gs5L1Y+mbb5RpxJNgXcOQyJCLNw8Ks56McPbvgqkZFGCPgihUkqlzwyV7uOiPZheHgHUcTpo5gnHiXXkdKltACCPH9qqFjgPQ6iWFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SC8HyX6o; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-295c64cb951so231915ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762966214; x=1763571014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=im8M93syO4Wdo1dQDINgUp1S7N0dhhvUu+q127lgjpw=;
        b=SC8HyX6ol1VS7yWQdw286KVJ2HzJk/P4NyrY+t/lIjSFo5wQeNL0ViuXlqUEBsj33T
         haoBOEJf7mMfhIAkF4hisuoPVktrIP7/wVRsoHraT3g9uZJIzQS1pSw9byeMzhtpegWY
         oW0Pf0G+IuiPChZm3j0Y3W7VPD9aq0DhH4q8DWFfJjGoA6f8cl4KP/Y9EuE/JPFSfwdT
         fSa07FvLuuUhLbe+5iN7HjphxyoZZDj12SvDsQbtF06SuDJMGfQ2SKw5L15WTNGugn4s
         rkhKC2OtkiPEOw1g7ToDNXyokxEAhpXlXm1eASemufSpfRvO5baEbRAdKXpren4fOavj
         Vqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762966214; x=1763571014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=im8M93syO4Wdo1dQDINgUp1S7N0dhhvUu+q127lgjpw=;
        b=DcwgEBOTgky8OTfTxT2PipjCOiK3HLsP08tx3FeRnUZBkg8VarcdOu6uYfdedtbV8f
         lFx3P8nxz7Z8I1Pqiii81a6fcu5Fh0jqcfnZHZf70cq7Np/a0hjXhwXG/xsHupsfcuXu
         LlgSJLPsEMultvGbQeZWIegDcMCcMp+5xaQpjcr14Gt6PWKtuEacjKFyzG3+eEzvqE1G
         pOOqCM/Benpw8hnrrQIlLpbUVEqj6+UZ2BImQrUH728XeqDeFLdWd/RFNJqPgWYUzBZM
         Y/eTQCo9d9ZTFX4S2y1gr71QC0mTOcpSuIPldec9D9OCHgjDGPxdQdZhEdOotlFOC8pI
         WEKg==
X-Forwarded-Encrypted: i=1; AJvYcCULTMdRpJQ+KExdvCyE9kSp0vz0djNkJemTU0tPwgQK3BoF565jtnnw1VSxaQovLYmILqYfpW0DlFw3isI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRHBw5cV8RFg9qOE46q/0+LtRs12xY2dXs+JP/ka99BYhKC5po
	s1m9k2tnUIu6Ci8BXCMVHpPVYVzLfQMudsgBYx+0FLAFENkhpSNq3rC8msdMEYLXd/2D/Op8w8p
	EApObVo/juhWQq/yETjtqqkqeLDxBGBx/YXu+PVMjV9bsoZYiXK9b5dE2
X-Gm-Gg: ASbGncuV7yh5d62SFlz+ELnOlao3yn3Ld/9AEcXvfD5Wa2DZU95xRHnFHxbchzh1ZhD
	1e8gIJ2iT3OUu5J1rOqE6UPKFQBfmFpaIbY5C1NpVOm7xTZQa4a54ozme8b6hkR0Cnebv4e/FbD
	QBvqKEP/WAl/0c0K5xm2Fl7rm/vpNs4EA1qC0VVCQoOgLa19d0PciYA46PpIkUx3FtpFuKA4piD
	SEgbuJVEcz0puujWxLm9rkA3G4WkeKuS6hHGhcrtfrw0aKLwRp5qb1xU4wfSOKMhNRZlKO0lzPh
	1+PlTWBLkPvasTzk6aSWl78OKQAnpBR5SrXW
X-Google-Smtp-Source: AGHT+IGwx5bn7xQydBmWpG2XwjQli5nNX+W9qsqwOXGCIONZx5bVCiDz/zbGXu7F7IfB1kae8B/JhUVm1uX9/31LFp0=
X-Received: by 2002:a17:903:1a68:b0:295:5138:10f2 with SMTP id
 d9443c01a7336-29850761942mr2821745ad.11.1762966213583; Wed, 12 Nov 2025
 08:50:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909-perf-pmu-cap-docs-v2-1-3c451f7b0b2e@collabora.com> <d01d3f15-c144-4e2a-9aee-6308a897f3f2@linux.intel.com>
In-Reply-To: <d01d3f15-c144-4e2a-9aee-6308a897f3f2@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 12 Nov 2025 08:50:02 -0800
X-Gm-Features: AWmQ_bl2JhgUXo9a1z19NSTipK_Tr2OyLPJE-WcM9aaK9x3Mjo8BIxtSG8U4n3s
Message-ID: <CAP-5=fU2=s+88RQE0iq8DD+mxjMUca4UHkSM3TjkS8T_7p=KKA@mail.gmail.com>
Subject: Re: [PATCH RESEND v2] perf/headers: Document PERF_PMU_CAP capability flags
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, kernel@collabora.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	James Clark <james.clark@linaro.org>, "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 8:11=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.intel.=
com> wrote:
>
>
> On 9/9/2025 7:39 PM, Nicolas Frattaroli wrote:
> > Over the years, capability flags for perf PMUs were introduced in a
> >
> > piecemeal fashion whenever a new driver needed to signal to the perf
> >
> > core some limitation or special feature.
> >
> >
> >
> > Since one more undocumented flag that can have its meaning inferred fro=
m
> >
> > the commit message and implementation never seems that bad, it's
> >
> > understandable that this resulted in a total of 11 undocumented
> >
> > capability flags, which authors of new perf PMU drivers are expected to
> >
> > set correctly for their particular device.
> >
> >
> >
> > Since I am in the process of becoming such an author of a new perf
> >
> > driver, it feels proper to pay it forward by documenting all
> >
> > PERF_PMU_CAP_ constants, so that no future person has to go through an
> >
> > hour or two of git blame + reading perf core code to figure out which
> >
> > capability flags are right for them.
> >
> >
> >
> > Add comments in kernel-doc format that describes each flag. This follow=
s
> >
> > the somewhat verbose "Object-like macro documentation" format, and can
> >
> > be verified with
> >
> >
> >
> >       ./scripts/kernel-doc -v -none include/linux/perf_event.h
> >
> >
> >
> > The current in-tree kernel documentation does not include a page on the
> >
> > perf subsystem, but once it does, these comments should render as prope=
r
> >
> > documentation annotation. Until then, they'll also be quite useful for
> >
> > anyone looking at the header file.
> >
> >
> >
> > Reviewed-by: James Clark <james.clark@linaro.org>
> > Reviewed-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> LGTM. Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Ping.

Thanks,
Ian

