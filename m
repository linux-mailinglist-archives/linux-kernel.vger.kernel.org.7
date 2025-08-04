Return-Path: <linux-kernel+bounces-754942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD666B19EE4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 11:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D447189B168
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 09:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9054B244694;
	Mon,  4 Aug 2025 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="Qo9K6/RH"
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D1223C8C7
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 09:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754300482; cv=none; b=R/Ej/0rgpxQ1jARJQBcKAF4iKUS9pHJO9X5zgMUrc44T5rkLn1EwzOI20LBRh7mzCOy352QJmyTi2dEl6Y3CJkoZLgyPBYgdMnM/yZShqabhE3q5YdMS1Y/oyIXJpKOIpl0EarUlxbm7tY7POP0j7EFsgHk4bqExzn2qQ/ZtYoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754300482; c=relaxed/simple;
	bh=JjbB3Jm5B9RQihNCMKSK+B8I5hhLMbxQKcU07xlJc6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ox8UN7agxePdE1vcNmCZhukD8tuXKsAl4tyoClf266dh6dpFspL4/THlyx9rbjnUxVLKgS1HlJZeQV+WviC1vKcnyL8bVGpE12+Lism2sTDaP22tBwYb74h3xGLFeWrxf1HC437vX26Zc+yfszI3ii5jnnVLPRs9qCSHuAFezFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=Qo9K6/RH; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5748c9qm011871
	for <linux-kernel@vger.kernel.org>; Mon, 4 Aug 2025 05:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=JjbB
	3Jm5B9RQihNCMKSK+B8I5hhLMbxQKcU07xlJc6o=; b=Qo9K6/RHGpbdoHXEsTCC
	4lgHR38vJx6A/fYq+9r70zqU8KQ5BWR4s8qkP5owJN1Rzx2AGT81eNV7YmuXKB2Z
	NFkCuuDF/AuBdAnf6/d2LyWRtzjsvZVVUp1ukSItfRwYe2wWSqzJDUsUL3toXqj+
	xaS2jVayqJ2lMP1lZKJ+8bwaLcbKjwOXoYkQR1Wax3Zd7RTcAxMZrk1D0Ule9e8B
	6qf072uYGmDZ9kWtdbJ7vB7d0WV4iFeSuDhEKcm8wSdtCdSfUfwDaSxIDEkF9Mlp
	YNnsEgk5XoFKttCFX8i9vob5+gMVKBB4z24F3leGupjciyntk6mbnWqpJBsFDPA3
	LQ==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 489c8thfys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 05:15:45 -0400 (EDT)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-71838151744so54185407b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 02:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754298944; x=1754903744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JjbB3Jm5B9RQihNCMKSK+B8I5hhLMbxQKcU07xlJc6o=;
        b=TGURk/rAhIyw5uS4n6IZ7X2zFOR/6Gxd61QfqJ5Y2UXl8FqDpbNTlmYxquJ4TrZh79
         fGm4nMBBWkAHLEy9Nv+mzpbmDrQLxrwpmrHjMmlUC6EC+83UalO2unCTNWQhRqP6jD9u
         HiY+zKt6rmhQNAiFkcGpHBHEYfO46m+WmxaNViTBmzO0CrR9gnqUS619SaCLrRzQEkYC
         FfFO7fCf0UT+QF4BPeErdExkSxWaWsrenL26nv4E9OW9FnvaJ/uhpLI76pVLinUgGX3c
         fnzY8ctE9NGN2g2GsBNG+olwHt9bYcX4O+irwYDhAFywudEQnesAej/Z3y0wUv4srZ9N
         cIVg==
X-Gm-Message-State: AOJu0YznewjfFmc7Fe2Vm22BAwSerw9b6R6SXyOQ7ToqekP4/Sethbp3
	O5W1MMh4+QtzEyB1lBYHXV34MtOnjcPqSN8F9Cs1kLnlQZedXkRX1OaknWvPT3f6pZwmv/IWO2H
	e/lOaff6r1lMohUOA58wlVGFffGfGaTmlpdlm29ATCJG0KR13X48LQxgFLFG2XiHpOGMTV3tZCG
	8hSwwaJiMiudrPJqxWTomh2q3mFeZPw48EaztJu0TZnvOIsAM=
X-Gm-Gg: ASbGnctLsUq04ipnGwB3jkz/lol5fqZ9rtcpEmmDzJbxKovoQxfFRsPY3VIS60l/vbl
	Mey+UJ1AWHV9KIvJgwTUrahrz+j4I4KJ1dWHw4LSxKaTSYF4EfKUspFiMF+DuyAdP/3TfUBU3An
	D3xbCCgMYKAAKklR4bYb7s
X-Received: by 2002:a05:690c:4609:b0:719:53fd:79aa with SMTP id 00721157ae682-71b7f84a212mr77213037b3.22.1754298943833;
        Mon, 04 Aug 2025 02:15:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+UZiZI74WScdHweh6AGanV37GHLhD9Nzf23TmEE2bGp8nqgrqm6GaV8J3VbW+KzNd4CNom3Wtj+ghqdeWtRM=
X-Received: by 2002:a05:690c:4609:b0:719:53fd:79aa with SMTP id
 00721157ae682-71b7f84a212mr77212667b3.22.1754298943210; Mon, 04 Aug 2025
 02:15:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528-tlb-trace-fix-v1-0-2e94c58f450d@columbia.edu> <CAKha_srZTXfQkizBzvrdpWs6Txw2PSgRAqT6QC8gom=PaitYNg@mail.gmail.com>
In-Reply-To: <CAKha_srZTXfQkizBzvrdpWs6Txw2PSgRAqT6QC8gom=PaitYNg@mail.gmail.com>
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 4 Aug 2025 12:15:32 +0300
X-Gm-Features: Ac12FXwhQmrmOOkID7nOJYCapFm0MAKFQQ0J4rVnNl_CTjL5U175u7m4uf07P64
Message-ID: <CAKha_soQ7VUvHk7cz0SmX8_GYdWS3nrPm-e2NyU=AH1qXiKqgQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] x86, mm: minor tlb_flush tracepoint adjustments
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-mm@kvack.org, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@surriel.com>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 9qYjdt_tbBRtPoXG6lksVh4TjZv2sZ5_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA0OSBTYWx0ZWRfX+QWwfXPOAWrD
 UARcZdZ128oIBiFoJCKn6G5SBHBa/eKrqE/HNNxpJfWi8y2nsV+/e0SOM+32EKUsbMm4OU1x/iv
 FeAMZ3ZH54yBGAHRUB4AKQPoUKJuz3pk+7u2O60c3cWbga9xr+OT8TMRKPIv7hTTseWwVx5lQJe
 RV4SpYPzqgfjhzlNXIULjz3xJgbypSAH35y4mmRLOxLuxikLjjw29lZMgKTXv7p8Sf+MO7PhkMa
 ibDqxI911ZQSwcSVmMdOch0ls7R3sPK24kBzYHCAfnCcqJeAJYMU/mKns5AYDB8KyXol/zevRNE
 WnMfS5lbTYwQp9Cn4cHt76P4at177lo98T7e07QL69P32GsZhffEjf6PX5aK71H6DqA6NxutDQc
 ygE7ugFn
X-Proofpoint-ORIG-GUID: 9qYjdt_tbBRtPoXG6lksVh4TjZv2sZ5_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=10 priorityscore=1501 clxscore=1015 mlxlogscore=767
 malwarescore=0 suspectscore=0 lowpriorityscore=10 phishscore=0 adultscore=0
 mlxscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508040049

Hi Andrew,

On Tue, Jun 17, 2025 at 11:43=E2=80=AFPM Tal Zussman <tz2294@columbia.edu> =
wrote:
>
> On Wed, May 28, 2025 at 1:35=E2=80=AFAM Tal Zussman <tz2294@columbia.edu>=
 wrote:
> >
> > One minor fix and one minor cleanup related to the tlb_flush tracepoint=
.
> >
> > As an aside, include/trace/events/tlb.h isn't covered by MAINTAINERS,
> > along with other mm related files under include/trace/events/. Flagging
> > this since I see there's a recent effort to overhaul the mm MAINTAINERS
> > entries.
> >
> > It's been a while since I've submitted patches to the mailing list --
> > please let me know if anything looks off. Thanks!
>
> I don't see this series in any of the mm trees -- anything else that need=
s to be
> done to get this in?

Just wanted to follow up on this, as it seems like this series missed the
-mm branches for 6.17.

Thanks,
Tal

