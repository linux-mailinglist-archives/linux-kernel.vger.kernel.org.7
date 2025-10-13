Return-Path: <linux-kernel+bounces-851521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D3DBD6A63
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 00:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9210C4EB5F1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DA83081DF;
	Mon, 13 Oct 2025 22:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oP1GiRKQ"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4F22FF148
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 22:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760394936; cv=none; b=Ke4HQ1RObSlNmf8EmXICkyN+Ta+sIbDQPLvvmZ3c3MwpSYs5TtOI6AbS3SeGqduchKVSLHK7RzoQTrtSZ1tZH2wtA/zZW7DXfxsNozZxD7NKw92n07MZw6iKXobtr5dzSqGrNj/zk2z/wwVtZydos32WxDzCZNtuzikGRelliCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760394936; c=relaxed/simple;
	bh=6B3K1VEohuDa2fuwXUpyKZdV1UfNnP+FFNPVNqcF+uY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dcm4ghiSqa7RGe4JQbkOiHS+e5YWCSU0vB1oS8oV87Cxm2SsFQgqXNCybjkN5auRZgt1+ySmuwijElPMJ1ugYKQnltT6/EiGh36lJEkrbZMo0yNc74/vRKnb3UWLy3np1TAT3Xm5CpgW+qq7HkbKfjXLIoSnqQ9AXq3QGDhvmGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oP1GiRKQ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77f1f29a551so6039254b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760394931; x=1760999731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtxL+uYHTrxBSaf2VJ6n4z+smdSSDd5JBl8pS6dLFSc=;
        b=oP1GiRKQ/aj4nhTWbkKvuD/Fkur+jeiJSk2bx2eqFxqLow0PVx5VqLunVYyqHmyNXS
         9oYkdXlNFMz0FwhxzY8tMgLPipJDKG/NOUsRSOeb1hrlY4aTDLMEfA5+lAQ3aYKFY8m4
         URvejRMdQOxsVEUD6ZBZL2cbVpknv+NZPab98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760394931; x=1760999731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gtxL+uYHTrxBSaf2VJ6n4z+smdSSDd5JBl8pS6dLFSc=;
        b=IZkHmUKJIoW64NBkFPlkF5No6ngFDLl4FRexooQmheM03jFs/wzmlUckuhJK6MYWdt
         Wc2pKx+MuEVEZO3GyY3MpWMAvAQQvpS5IBkSOOD1qnWwUxHN+DITmmQ5RjUNgiRFeAIL
         ENXvhfJUsy5ZsTnMAKUBraRIpth7iqH27LzzLPQ+dRwBPtrAVGDMzt3MbwroNM3L9Eec
         1G00S7P7AwW75TltnMkG+qsbdh7m0bHp9VVvaCTYtwVEnxnexd8G/56US3smdcSOKC6g
         Kq0f66io+4mAWG+EVkb1Y0VdfnHWoPsmUmnIdj57L9KDx/KMas/pcz6hRXSabSuP0qS+
         x32Q==
X-Forwarded-Encrypted: i=1; AJvYcCWG0llG8KdgVxaKkGSTP1Y//dffL8iLMP/S6uPPGzKo5QDo8Wys+AbfCLzqXCh2da+cN4j9Uvqfg8HTAFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXjhsMiJCpk5lSS0bHhToUJiS3R5qYj9qbA+CE1Zfnp8xyEuky
	xwe+N7hdtqdhkJyRfWChcho0B4/17NPr+1SJnR7AvDdYiBGWMsVkJkxrDC5sQDKOyhEOGGSNz+u
	/ECE=
X-Gm-Gg: ASbGncvIp/CSMDHBkaWVkpxRu0OdwdxegS4m3lpYY48oWj1q+YMQaZUGVkXmwGF28ay
	8VWKuO7DzVch9MZdJ47QNl3POF4OopDa8KSV3ebJwFhppr4DMzdrqvLd+ub9H8vOZEt/fPjsWKK
	j0uTnxasu/3oDnpjcfQ+So/2pHyk7NRO1jbIqXHJvZyyb3RVQMaaxUZlM2JDY0AhfCTrpKf1O5l
	GwsaQWUJDy727DDD48RyXBil6PJEbbxEnBpXVlI1Vsmh4YYXN5amT6u0oXYKqg3gPRTfu79GzBy
	OgGXhJutEibBoI0xecl6W4v/Ct7Y0L9XOxbkgFCBIKMtgG/NSm8hvEAmHMmAMMcGGLe0dO5vC93
	A3StGpGwSB0e55DUIpNXwBy+wYf+7OgrvSdyTvfMMb6WBAtrdtUD74ed6oq1KeC7a584cbfPIhf
	U7brleZRfqSQwCCkYkYw4=
X-Google-Smtp-Source: AGHT+IFFcuOpiOLQbGlQ4RgVIEyXxwoMuC5BYwMHklTKrlBLZ6qyTqRoEkJCRumVaRucmzCHEd0h+Q==
X-Received: by 2002:a05:6a20:729c:b0:2fc:660a:23f0 with SMTP id adf61e73a8af0-32da845fb62mr31805045637.46.1760394931187;
        Mon, 13 Oct 2025 15:35:31 -0700 (PDT)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com. [209.85.214.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61aab6eesm13661479a91.15.2025.10.13.15.35.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 15:35:29 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-271d1305ad7so75609305ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:35:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+PB0YvLxWpTEWvQZB4pkvD0Bz1FoWzEuNGeU7NKIc/SvU9gadqYKchuc4sbsXvP2ttplTuYnVlhPdP+g=@vger.kernel.org
X-Received: by 2002:a17:902:ebc5:b0:267:bd8d:19e with SMTP id
 d9443c01a7336-290273799f8mr248133945ad.22.1760394928761; Mon, 13 Oct 2025
 15:35:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009032838.63060-1-cuiyunhui@bytedance.com> <20251009032838.63060-3-cuiyunhui@bytedance.com>
In-Reply-To: <20251009032838.63060-3-cuiyunhui@bytedance.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 13 Oct 2025 15:35:16 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XRp9=5yxR3Q1UhJhBS-wm59yssozKi55W7HGk+S94AjQ@mail.gmail.com>
X-Gm-Features: AS18NWD-PlH4jDf4beOYtPWdSx7chQ77jPK1vKggaxR4OltLXyHgtJF5jyN2qPw
Message-ID: <CAD=FV=XRp9=5yxR3Q1UhJhBS-wm59yssozKi55W7HGk+S94AjQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] riscv: add HARDLOCKUP_DETECTOR_PERF support
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: akpm@linux-foundation.org, alex@ghiti.fr, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atish.patra@linux.dev, catalin.marinas@arm.com, 
	johannes@sipsolutions.net, lihuafei1@huawei.com, mark.rutland@arm.com, 
	masahiroy@kernel.org, maz@kernel.org, mingo@kernel.org, 
	nicolas.schier@linux.dev, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	suzuki.poulose@arm.com, thorsten.blum@linux.dev, wangjinchao600@gmail.com, 
	will@kernel.org, yangyicong@hisilicon.com, zhanjie9@hisilicon.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 8, 2025 at 8:29=E2=80=AFPM Yunhui Cui <cuiyunhui@bytedance.com>=
 wrote:
>
> Enable the HARDLOCKUP_DETECTOR_PERF function based on RISC-V SSE.
>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  arch/riscv/Kconfig           |  4 ++++
>  drivers/perf/riscv_pmu_sbi.c | 10 ++++++++++
>  2 files changed, 14 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

