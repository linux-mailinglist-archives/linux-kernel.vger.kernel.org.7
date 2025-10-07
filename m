Return-Path: <linux-kernel+bounces-844251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2599BC1609
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 14:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 884FB189A7BF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 12:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612772DECDD;
	Tue,  7 Oct 2025 12:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qoD0JGKY"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D3B2DECA7
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 12:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759840701; cv=none; b=aZ51Zy2yrpU1YVAR8Tr6MZkXykMbh6oQMH1puOx+1yGyC8nGmUXWIRd+G8rJNuH+xOrKygH4FSfDfIc2Pc9V5bCVJVazdcf2m5cCd2ahKKb8kT6qjyxWSHuNKotd/Ax/1VtTUJ1wQRR29o7ZIg2nga42/WZVJ1VzGOFtOrbQmhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759840701; c=relaxed/simple;
	bh=gsIwM1rNa5iCNHH9dZX392s+eSfxnBIqanCsGLwT5lQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ap197vmaplnkja+g94EwQ/TnYmed8dbmedbJIASH3i0gmCDSuz/lbLTwa65W305PXkErjgrLiZ2D9bzEH/yuIog59uFrUmoNNcgsqSuavYICpO8RtnW27cN6JwPLyxt8nUcZdPJmv1XRjXzx07tubaOoTBKseh+5EN8v2FCtJlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qoD0JGKY; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-862cbf9e0c0so570949185a.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 05:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759840699; x=1760445499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gsIwM1rNa5iCNHH9dZX392s+eSfxnBIqanCsGLwT5lQ=;
        b=qoD0JGKY6XuQCF9nSwa21UqxAnRoP2zTjn4QeKHI8uIYQuyKbyJt6eMFCDRnMLDOMs
         F3zi1KC2F3+TXtB0gP0BpQdROWTAud9IvuOk6rA8IDsYF7b6rwQ4jflV3DmohBuL1+u5
         R8XTwyouFZYO5jUVifbKNKK7X4vC8Nbs/A8+W4E8bbFWMfl9At9McNdemx1A4cw+AloV
         4uJppeaYMqdhEY0lOStz2/bcXroyPBOmQ3IkPOcqmuTAcM5UExysmqvKgs7DGYRpOch3
         KOaEFa1e6Qu2GaRXxCgmy7111JILcLhcLTrfarvTZ6SnWU/6imYda7YHlGF9RWsh+G+A
         lYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759840699; x=1760445499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gsIwM1rNa5iCNHH9dZX392s+eSfxnBIqanCsGLwT5lQ=;
        b=kYIBnaiBdK16RopaBZ9Kd9QRIK7ohW+KbHowswQMnVYYIF3L5gItbPqzj1teF2iLlu
         488E1oxhuLH7x/2ML2junMT34wQmBXRZTSG6OopHBOLxw4n5WWsSm0gaM193dZQrMuXS
         5b6lFjXIJN/Jkbdq300AnwqYcDuLB5cibd/cTRe+gB25Tei6A30gQy1IAWXP0dFraxxL
         fefO8VfQKpSbvUSk0g4BEORKHiyULOvknp3ZX2tjpnY1ZTWSABrYYbYt795LOlcvo5Zr
         +rARq1uaAvfXxIjkLezYal3yUA2uFJladRVeh49ecMlBqQ0sLQtJbzCaa08paraeFpWm
         peag==
X-Forwarded-Encrypted: i=1; AJvYcCWIZwdi39QSWtvBlPNxz1ft/r5+ng0pWoY+Bj+4GOqP5olaqLq2gcN9xfhtBOYl4frYJxtWEPVQfjbOOZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEZZz4jeB3bbmkpwraH3ld9cWoGDwpn6cfPitK5yaq9RGmAdXP
	jZBSAlF1LMUOIYfaC134QcTeJhVVoZ7Ocn9+QUEVHTMDSGFYhEvWwelVXPMCejAj6ujd8q5A/6f
	P+izspK2JEfAQP2N3sCRDAd1sBBt5KPfRFSVg8oZO
X-Gm-Gg: ASbGncvEG9Ss42z6oxXfHxcz7T0BEgQEWDf7v7dqQmcl5h6nXJCrNcrioSHKDbBnvnB
	qjeo9zG6v9v7bFIb6vuR2EQ4EOnlnF4K//sK7DS/f5RJm7InQmqOeKds7+NHZrlFRrXPAFn6R/G
	iaYYn66bnFSPul99iPFptVuBoekHlqaGPUlnACxx19ecM0/ameuQRUpxijHdWBh8zhF6Yzhlnoe
	WOPzDEAtDcA2smVxZKeNbsjYB9cCfX/u0lkHHViLLH/nxXZdcowjiOY87jHsz56KXrb
X-Google-Smtp-Source: AGHT+IFTuvFup/6aRZOSYOgHMzmPKInOb2mM+AFT4eKtiR2dHo10cyPwLgW7Ut91zaMh96r475+Bo7+OYE3WJ5mO9ZE=
X-Received: by 2002:a05:6214:c63:b0:766:13cd:2988 with SMTP id
 6a1803df08f44-879dc87b72dmr223523866d6.60.1759840698562; Tue, 07 Oct 2025
 05:38:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007122035.56347-1-urezki@gmail.com> <20251007122035.56347-8-urezki@gmail.com>
In-Reply-To: <20251007122035.56347-8-urezki@gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 7 Oct 2025 14:37:41 +0200
X-Gm-Features: AS18NWCc4tz3b2pwcaWdYKFXsCEP1C_PqDgh6cK4we0MiE4kAuLKZX9YlRuuI8I
Message-ID: <CAG_fn=VguRD6+7oiiNKLXH6pGJr8Pzz5JE6abRbGGMBBt6Rgrw@mail.gmail.com>
Subject: Re: [PATCH v4 07/10] kmsan: Remove hard-coded GFP_KERNEL flags
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Michal Hocko <mhocko@kernel.org>, Baoquan He <bhe@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 2:20=E2=80=AFPM Uladzislau Rezki (Sony) <urezki@gmai=
l.com> wrote:
>
> kmsan_vmap_pages_range_noflush() allocates its temp s_pages/o_pages
> arrays with GFP_KERNEL, which may sleep. This is inconsistent with
> vmalloc() as it will support non-blocking requests later.
>
> Plumb gfp_mask through the kmsan_vmap_pages_range_noflush(), so it
> can use it internally for its demand.
>
> Please note, the subsequent __vmap_pages_range_noflush() still uses
> GFP_KERNEL and can sleep. If a caller runs under reclaim constraints,
> sleeping is forbidden, it must establish the appropriate memalloc
> scope API.
>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Marco Elver <elver@google.com>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

Thank you!

