Return-Path: <linux-kernel+bounces-730692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB37B04837
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 22:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 084981A68229
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 20:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7258C233127;
	Mon, 14 Jul 2025 20:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MLQ13Yjt"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A2022127C
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 20:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752523394; cv=none; b=bBdw3fibm8xX5PCsAGo1MNNMpE2mdu0WzbZlBUHgTrsnlEUqqcgY0DCVQzs5gI7oPzoUKRG8GjoHBUpiD5AtHB2sAYrHJ3FTxgpBKV2cuAgbMQEb5NoLBe8f2CEoAiZkPUsqOKRTWd7KtFaTO8tZj2p3RZb3FPqqcdH5B8CtVTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752523394; c=relaxed/simple;
	bh=fsY0jmWeabMaOs7WYAbvvKt/bg2MxbBb0lqnAAU/TKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EHa3UGsLJOU4UF3j9ilYAaJareWzm+DyKN9CednqtB7AqiEBbrn6FCl/DV0X0hCGJ5VFRG+IkjtofCxLwoIJ6L68XDro0mV5QbbJgz4k3+bczr989EnDdQHu9H98SBRI7WtBZeEhxIco87j6az5mwfJW/xk4u3iW4DQgeFJSm5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MLQ13Yjt; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4a58e0b26c4so71486721cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752523391; x=1753128191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e05D0/DQz0T/VtfT27OBXGtPxndXar2Bry+kzVT5CP4=;
        b=MLQ13YjtD0kqyqnsTsmiZImaIL55Gzci0Xhq9cIRcw38GmdHVgS4s1zh+UMqkrpAM6
         fzvZNOQZUDOTsXZMiI23/QSvOt1Kg2Mb1QDOp+ou6fL4vYfduxesw3+5JfXVih33DMGm
         Jld/8a1LIvCaeBwy5skJbXltzhTrAxry5Rgks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752523391; x=1753128191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e05D0/DQz0T/VtfT27OBXGtPxndXar2Bry+kzVT5CP4=;
        b=ft1gX/3xzKjUHfTbE4c3NrttnIhRzLoctoz8c2dn+m6zAUssuezpsQHb6yCZOKd2Dc
         9zNsOkhrsjjJ6pXjC/5NVd2LMDEhQ8LWEMK2VHDz7DR6f1tORgUpd19T/Yjf7CsYhBdA
         oGsABJvWDhqSKMt3JvyRH2HKqH4j0fFQN0OFDjWtgnfykkefBytaZvwl/jWVLuC6onZN
         waE+EwFSbd9+/x4lGscbGk6G+vqcI87qPHl2fHqfTxd/visAgoAdfiNRlnQ8v5wI5Ayb
         z5Fh3NiX6tGtyFCW14qvazEjWFgh0HdPjila8PIPf27Ap4pjXGtroIhQjiGt2kEjClad
         eZmg==
X-Forwarded-Encrypted: i=1; AJvYcCUFHUzeUhZCAELgltP1n7ZTBFBtyviNDwxh8l+28//tDnhJtP4TxrXH3maJVXs3rdZl1nM8T9Ea4VFHRQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YygUN6rfOFLZG8bPK+a2e6SZ2ziDt1VwWy82rOoOaBGEncp+RW3
	HkdO06NQx1joHU08+b41eY7na5SUUY/NvKWjaO+bC2zBzOw8zco90SE5q8T5+Q08S8PvklqYJor
	IjhE=
X-Gm-Gg: ASbGncu5ZYC9YAljioFGWhK2UWLRhtfK2wGTeoQvhakv4uaENwU7GaWBus+Hcx+gkr0
	o3TVJGnBzIlOLYQc7aMmg4gNjUUPSaXeuySo8F2MTEaAOZIydAjxQ+DrMKObJHxDDF5+N8RTu4N
	yFszP5IKBH0p7km0Xi8YypKcLojl6DeaU6w6qSFoHVJKuWZNFL7Sejowzl8pIZZwC36VPEE4Ddx
	KzC7IiTuuFtEne9B2Zunrf9cZbW5D49VYWevMqhyfjvlNPhmtpP6lpy41+McX85hJ368BIl+tLm
	5PrSLgj5CUNdBLJ1W4dRq2ALHQDSkzhlAidKxeaX4yFaOz+YlXdxgQMxAy8JfFFkQBCSCT7DdEA
	Q00ysYlAHlclbNmvUNrKPeVI08plMtjXn26ziP12MSC+1jYJNF9qdhx/6Q91oem7uiB1JYyZ9A/
	lk
X-Google-Smtp-Source: AGHT+IEJk0J5ZmyCMSvmAxARr8qdz9CAQmC4S+z8XpMdD/DjcwYH4dxvBWarCfs7YZcAwfZoyrg1cg==
X-Received: by 2002:ac8:5708:0:b0:4a7:234e:6c00 with SMTP id d75a77b69052e-4ab7e158773mr18011961cf.2.1752523391503;
        Mon, 14 Jul 2025 13:03:11 -0700 (PDT)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com. [209.85.222.177])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9ede76d33sm53189891cf.51.2025.07.14.13.03.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 13:03:11 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7dfff5327fbso423419885a.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:03:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWDW/y7Zf4oSpCBIm9+R543eIvOJZ4qxIk1rejDKNqQzPaqn8EbF3bC4GOm23f2TBBDQmxQ7/SmxGBeQuE=@vger.kernel.org
X-Received: by 2002:a17:90b:1b0c:b0:312:f88d:260b with SMTP id
 98e67ed59e1d1-31c4ca8484dmr22759292a91.14.1752522980950; Mon, 14 Jul 2025
 12:56:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250629135843.30097-1-robin.clark@oss.qualcomm.com>
 <92314f06-e6a8-4882-a31c-914438d7761d@oss.qualcomm.com> <CACSVV01AUOp7vZ7kLt+gwxvfv4CYLtAQg6MhUccygbi1NpVJMg@mail.gmail.com>
 <aaaa42ed-989e-43ee-8d45-2908f52e8584@oss.qualcomm.com> <d323ceed-19e2-4b17-b97e-0833f132be16@oss.qualcomm.com>
In-Reply-To: <d323ceed-19e2-4b17-b97e-0833f132be16@oss.qualcomm.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 14 Jul 2025 12:56:09 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VV_xvcWwdpi88wSYWXyftUP5eP-SQVkgEBRQgfwDN+zg@mail.gmail.com>
X-Gm-Features: Ac12FXxRHKFdz1WEnIQ737ze8ocdQTtdcG6dsifTSijome0hozAkI0iK1xwhErU
Message-ID: <CAD=FV=VV_xvcWwdpi88wSYWXyftUP5eP-SQVkgEBRQgfwDN+zg@mail.gmail.com>
Subject: Re: [PATCH] drm/ci: Remove sdm845/cheza jobs
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, rob.clark@oss.qualcomm.com, 
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	Helen Koike <helen.fornazier@gmail.com>, Vignesh Raman <vignesh.raman@collabora.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 30, 2025 at 9:15=E2=80=AFAM Akhil P Oommen <akhilpo@oss.qualcom=
m.com> wrote:
>
> On 6/30/2025 9:26 PM, Konrad Dybcio wrote:
> >
> >
> > On 30-Jun-25 15:46, Rob Clark wrote:
> >> On Mon, Jun 30, 2025 at 3:34=E2=80=AFAM Konrad Dybcio
> >> <konrad.dybcio@oss.qualcomm.com> wrote:
> >>>
> >>>
> >>>
> >>> On 29-Jun-25 15:58, Rob Clark wrote:
> >>>> These runners are no more.  So remove the jobs.
> >>>>
> >>>> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> >>>> ---
> >>>
> >>> Do we have anyone using cheza at all anymore then?
> >>
> >> Probably not
> >
> > Adding +Doug +Akhil +Jessica, if we don't have any users, we may
> > get rid of it upstream, as it never made it to the outside-outside
> > world..
> >
> > Konrad
>
> I am not aware of anyone using Cheza boards within Qcom. So it is fine
> with me if you plan to remove the DT bits.

As far as I'm aware, anyone at Google who had a cheza gave it to Rob
to put in his lab. If Rob says nobody is using it then I'm 99.9%
certain that nobody at Google is using it anymore. There were a very
small number of external developers who were given a cheza prototype
but I can't quite imagine any of them still using it.

-Doug

