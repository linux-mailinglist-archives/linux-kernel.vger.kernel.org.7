Return-Path: <linux-kernel+bounces-803489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EE9B4607D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2544216DAA6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339EC362988;
	Fri,  5 Sep 2025 17:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpsEi48V"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011C5352FC1
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 17:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757094220; cv=none; b=BlEyljz1dpL5Nqu6uaz3y9/dKNgc244WaO1xfln41LU5KPp8+AYiykdzcgx9iIP2XS4c8OAHCHxuz9E/wTCtItLLnFCI+5sFi2wOyvodhyVYhfmmapevrc+ZqOkmfgn6QzwR6B29t8l4uvFNahG0payMtZwnEs5BwiD27Y5OM5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757094220; c=relaxed/simple;
	bh=kX7LafMd4saUhwKwovwaWJvV+Slu/tL3gUdamtkUPHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a8TYzmClW3PC/zYOXtTnv1RybbqoV/i5KOjF/B55P5AJ9B2DzZodfhh1gHbtJvZDC0dHjk44WFT3HZ6Wj+DzDI5/YcHf6LYUDw9gKBmuyRN1it7eQQKFw9+uUgrNag8oxU3G3ZMy3ybfknm4onA3++CSw250p6VscdqyWXES4Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpsEi48V; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3f664c47ae0so13076145ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 10:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757094218; x=1757699018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYAcYUm2desKUIWjDcT5mJIRYDoJyqLayOEtv1fT6T8=;
        b=JpsEi48VArscAfMZkOkaY5HZDI1BzNPpHUZBYWkhscpfrriI1D2uaVR1FDV58YwDd8
         YW7poDpLwuxnMb8WqwaEgyXKpxCSKSouLI94Zp8Tgz5TjcY46Eu+dil53E/1PdteJEWh
         mJIL90PiSZwEqxbUtwqxPvIRyL89qbZlfC0AgwXyiGBePpXyEBqWyW/czy2RFpmCnJkB
         CSow7HKY52y5MBjnSbf6/h7dh+H3tF1rcr1Yg0fNZORWDCyNLPugwZXKRbTz3uY3qjAa
         7aOgFZ2wSxTv3sPdYD9aD1dxnp3tsF9rSpj0u89Mzr18Cddri9hoIxFVcAy52AM0OHTU
         HbNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757094218; x=1757699018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYAcYUm2desKUIWjDcT5mJIRYDoJyqLayOEtv1fT6T8=;
        b=Wnujp5Moftr4iVRT7hucC8DPNuEJHgPeLcI74HBqT88XipS3AWWD0rVqD+r977Yefn
         2bh+nAGjH6SmFuIVFfzpy5MC2EJ5dZ1QhAZ6Y900Ye+dos5KnX3qlkzEniSabw+ApEn1
         F7adG0wfp1sH71GTLQqs7yTC03dBKEGwiKto7wmoWVkvEqL+3jffvQOCCghi+UBZZaAo
         Z/H7ykOmnE2WpqG/D3QAqKbl7Dpx9V9h2Ls63Zz3mPbHJ71hnb3XclCDy+kj3hyr0gfX
         sotyjcy8ta6+K9BGwuROzZPD8puqldU29YOwd6gbYvqmYg3eCU477NIpT2ZUILwWdCYU
         VtpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRjxcfe/ya1DyK5NMVqsYz4gZRnxyM1Ti2Rv+TqhRcwEmE6gGD4EkzkCn7cHD4+LhoqNd3mSHvrUAF86U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1/QEgQWsItQuIsrQyIwGWZO67sMueIiKYTrwwq0wAJ5aO5hR+
	omJY1uwIGbu1o8oJVpfBiFaKYxj9+6+TdUQ96PE/a5XzAtg+En/okzdJcRJoiYnKz5zE5b4PgHS
	LQeZVOSFYkxsqc5C6l7qQPx8QdU5iNTU=
X-Gm-Gg: ASbGncvE9KfLSIstmJKINiztIRq9oFWZ/6n0IUzc9jdFDIiAZhi1pMafCWTHlIpwoqC
	VrAqGpd3lBGE70yjdMgoC90/0G4srL8U5J/4B1WiDAk1bOQjdhcceIpoqK6ANYnfxIREqPXSMCi
	NCcuRNotx9Rxlp9DzDzBIr9P3k5yXirYtiXvi3vewhYgUseADmoV8QPpUrToTBZyWOAZhvzJvs6
	81fr+h/O9j9BX0=
X-Google-Smtp-Source: AGHT+IEwEjYO6pbdTzpOQwwF5PJX1YyD+PzcDAA6tLXdH03HNNfX60nXN+2m4+GA24ynohbZGrQKBMcpA2LhAMJI9yA=
X-Received: by 2002:a92:c267:0:b0:3f0:70c1:2ca9 with SMTP id
 e9e14a558f8ab-3f3fd18b311mr363966335ab.0.1757094217951; Fri, 05 Sep 2025
 10:43:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902-show_mem_zspages-v2-1-545daaa8b410@igalia.com>
In-Reply-To: <20250902-show_mem_zspages-v2-1-545daaa8b410@igalia.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 5 Sep 2025 10:43:26 -0700
X-Gm-Features: Ac12FXzDLYaqMKpvmLPOXMb7wIRAdgl5L2hjUr5ikag9JEtMKW0UJSmOz8j3uPA
Message-ID: <CAKEwX=Pa7p-BvHCj_JGkT2BcJsLpw+AMn3zvLjoZEGxZ=x3M1w@mail.gmail.com>
Subject: Re: [PATCH v2] mm: show_mem: show number of zspages in show_free_areas
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
	SeongJae Park <sj@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 5:50=E2=80=AFAM Thadeu Lima de Souza Cascardo
<cascardo@igalia.com> wrote:
>
> When OOM is triggered, it will show where the pages might be for each zon=
e.
> When using zram or zswap, it might look like lots of pages are missing.
> After this patch, zspages are shown as below.
>
> [   48.792859] Node 0 DMA free:2812kB boost:0kB min:60kB low:72kB high:84=
kB reserved_highatomic:0KB free_highatomic:0KB active_anon:0kB inactive_ano=
n:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB zs=
pages:11160kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_p=
cp:0kB local_pcp:0kB free_cma:0kB
> [   48.792962] lowmem_reserve[]: 0 956 956 956 956
> [   48.792988] Node 0 DMA32 free:3512kB boost:0kB min:3912kB low:4888kB h=
igh:5864kB reserved_highatomic:0KB free_highatomic:0KB active_anon:0kB inac=
tive_anon:28kB active_file:8kB inactive_file:16kB unevictable:0kB writepend=
ing:0kB zspages:916780kB present:1032064kB managed:978944kB mlocked:0kB bou=
nce:0kB free_pcp:500kB local_pcp:248kB free_cma:0kB
> [   48.793118] lowmem_reserve[]: 0 0 0 0 0
>
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> ---
> v2:
> - fix build when CONFIG_ZSMALLOC is not enabled
> ---
>  mm/show_mem.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/mm/show_mem.c b/mm/show_mem.c
> index 41999e94a56d623726ea92f3f38785e8b218afe5..c563d9adfa87765a8736e91c1=
f68d824b03eaea8 100644
> --- a/mm/show_mem.c
> +++ b/mm/show_mem.c
> @@ -310,6 +310,7 @@ static void show_free_areas(unsigned int filter, node=
mask_t *nodemask, int max_z
>                         " inactive_file:%lukB"
>                         " unevictable:%lukB"
>                         " writepending:%lukB"
> +                       " zspages:%lukB"
>                         " present:%lukB"
>                         " managed:%lukB"
>                         " mlocked:%lukB"
> @@ -332,6 +333,11 @@ static void show_free_areas(unsigned int filter, nod=
emask_t *nodemask, int max_z
>                         K(zone_page_state(zone, NR_ZONE_INACTIVE_FILE)),
>                         K(zone_page_state(zone, NR_ZONE_UNEVICTABLE)),
>                         K(zone_page_state(zone, NR_ZONE_WRITE_PENDING)),
> +#if IS_ENABLED(CONFIG_ZSMALLOC)
> +                       K(zone_page_state(zone, NR_ZSPAGES)),
> +#else
> +                       0UL,
> +#endif
>                         K(zone->present_pages),
>                         K(zone_managed_pages(zone)),
>                         K(zone_page_state(zone, NR_MLOCK)),
>
> ---
> base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
> change-id: 20250902-show_mem_zspages-d090ea0bd1d4
>
> Best regards,
> --
> Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
>

FWIW:

Acked-by: Nhat Pham <nphamcs@gmail.com>

