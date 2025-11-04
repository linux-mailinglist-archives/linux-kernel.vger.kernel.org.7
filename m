Return-Path: <linux-kernel+bounces-885091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF291C31F7A
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 17:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DA041887E94
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 16:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC450267B9B;
	Tue,  4 Nov 2025 16:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jTXPzDeU"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3FA2E5438
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 16:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762272273; cv=none; b=FjkwgM+IKZE4mTab8Dzr3v4v6M9j78JgH9mksYag+MHL/byUrG4Zkujl6u3xD2RWit8Wjntydsc6FopFwvTCcgm8lN85wDWFHc4V1jejQ2u90nrSWTaM4aRSomud25y275Lz0g9TZkG18iOa6wX2JKaBeFTiF+cuUl5ikDIx1aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762272273; c=relaxed/simple;
	bh=cQsbTTP0VoK4R1L4J+A3IZgU787+pdz4knMRsMv1nqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P9YVdzm5+UDsTX/kWIjufX9ylRWXgkt3Fg8hliZujP/AsY//9xRdiiKkU5/i4BB/eP21GLfnonfvg64QIfGKKH3h3jvNsHt52J8OHbbYRaJTCXLrPsBeXrr7owjR0PGM2gKKvhkbu9m8QyGJp3/g6JFECUXYWYI+Nyw2H3mxVDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jTXPzDeU; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2959197b68eso205535ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 08:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762272271; x=1762877071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/PHhKT2Znwu9HseVZHKFx2b7TcR0iwcE4g9dNET83U=;
        b=jTXPzDeUBqDqPIzkgeOcKqp8HNfHEkrm7vHMGGTfhjd/9Eix3tovyLh0SoFFlANoXr
         KmtgxXJsGPMyuHOvDAx608hUlVNlq/Oc79S7AJD571lmLGOvvWj/bEtFbqM2Crq3WcmL
         tXUmsha5u/jxIy7P7NM/WIjMwHbGBHUwq91gOD5rku07eQ2i1eKx7P9sBNe0eA6ukZVG
         kpSSd1+7DjtAYOCVnzDpUJu7Zos2yKITET7IgOkIE0XSb6WD479ShNFeEtf3PSwM7gN2
         8mRsO1VRfQZHJxb1F7l6FRYDrWsVrydgPJomhpktTFNSGHTsSX+AQJA2HJVp/wSQ39ls
         lC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762272271; x=1762877071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/PHhKT2Znwu9HseVZHKFx2b7TcR0iwcE4g9dNET83U=;
        b=II6eouCedlknjOQnmIoTV5Fu8y5iOIhKoBoE9cAxAkMXjitovH727sb5U/kcehH80y
         1/zcBkjy3xhuUcwM0S1h6l7FpRc5TqYXQx15ULhUuGInmVvc72kViYrbf04zEoHH8xR3
         9UL0PKr3qq0c8fuZ0QuZBXNSNpg4bbcDvugISkAR7pdixbL2/TDV3/E6MfO1n1yUlxw/
         BJ/GjD2uiMydlZIFL+2yWvHUkcbXqfQl9biHVRoUGP2d8siNCFvCcBd/VF2ZODUozXny
         ZM75PEH5v30GeZkY4W0pPVfES1vqQ/xdXby+fB2RZvaObK+Yhk60kpKFHlb8LyyEW0eY
         Bi4Q==
X-Forwarded-Encrypted: i=1; AJvYcCW8xYSfcju/q+utFaeFdwZCpoQHL5gd06iZt7fvKohL8f05q4QYOl7wx3Or0YpY60K79YDmtVR9OrCnweU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHWqwqhy61p9HWV0S0bT8OP7906IhQceNjXM8OankDMmWNBFok
	mV+OUzD2fljaarFZrsuqppcSQGRwOSjMJQhzLExac/GJV0bINjnxox8n9Itoe5FI04H0Ptr9OoH
	u7bH01yIM2KN5lfvUdj6e5YOvYIEOIqRkDwrEgGml
X-Gm-Gg: ASbGncuac4QjJ0D6aFNb6YfzH33I3VIODAzQnOxDgyJfewlnJnGZ1Gwrafjma3VvsOz
	wkTb6ZlSOsFWrF7zww+86u8dyAnraVCgq0zmdpPX4g8AJL1041CJy19+MzZQQLEgLnZFMCchjek
	8LJeCTJSUSDNIDdb2x24LYz8JkVG6ZFkI8iWbJ9RRYxjnSHnCKRnc9YOq7NKnN04fFka5LJLFkD
	v+EDWlY4w7+eOV8ShPdl1Ps7aD6FfDF5wx7oB+k+2YTuPOspp6VSM8mIu4jjkwJXCd7AJWXIUI9
	JWagrTZkDdJLc1Fp3G64OoHTEQ==
X-Google-Smtp-Source: AGHT+IGjXe6tai+L3bmj9S0kG8kMQn4+Mnswy5DvtApEzkYyuOlzI93nG7iDt8pZcCkMsglV8Abhd8Un3qRdwGulsuU=
X-Received: by 2002:a17:902:e747:b0:294:faad:8cb4 with SMTP id
 d9443c01a7336-295fd8dc897mr4890515ad.8.1762272270004; Tue, 04 Nov 2025
 08:04:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104092740.108928-3-jingxian.li@shopee.com>
In-Reply-To: <20251104092740.108928-3-jingxian.li@shopee.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 4 Nov 2025 08:04:17 -0800
X-Gm-Features: AWmQ_bmkiyFkm8Ccoecp58xI6r2HcrYx5G7YNLVKN7p6ZhL_b0r46BqKLgo_c3U
Message-ID: <CAP-5=fWvawhzhXx72L4iEPpNqeNW+oHQOTkAOy53z0r8UXnMSA@mail.gmail.com>
Subject: Re: [PATCH 6.6.y] Revert "perf dso: Add missed dso__put to dso__load_kcore"
To: "jingxian.li" <jingxian.li@shopee.com>
Cc: stable@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com, 
	sashal@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 1:38=E2=80=AFAM jingxian.li <jingxian.li@shopee.com>=
 wrote:
>
> This reverts commit e5de9ea7796e79f3cd082624f788cc3442bff2a8.
>
> The patch introduced `map__zput(new_node->map)` in the kcore load
> path, causing a segmentation fault when running `perf c2c report`.
>
> The issue arises because `maps__merge_in` directly modifies and
> inserts the caller's `new_map`, causing it to be freed prematurely
> while still referenced by kmaps.
>
> Later branchs (6.12, 6.15, 6.16) are not affected because they use
> a different merge approach with a lazily sorted array, which avoids
> modifying the original `new_map`.
>
> Fixes: e5de9ea7796e ("perf dso: Add missed dso__put to dso__load_kcore")
>
> Signed-off-by: jingxian.li <jingxian.li@shopee.com>

Thanks for triaging this and the backport fix!

Acked-by: Ian Rogers <irogers@google.com>

> ---
>  tools/perf/util/symbol.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 4f0bbebcb6d6..ea24f21aafc3 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1366,7 +1366,6 @@ static int dso__load_kcore(struct dso *dso, struct =
map *map,
>                                 goto out_err;
>                         }
>                 }
> -               map__zput(new_node->map);
>                 free(new_node);
>         }
>
> --
> 2.43.0
>
>

