Return-Path: <linux-kernel+bounces-833916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE0DBA3555
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E7D37AE02B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070112F361A;
	Fri, 26 Sep 2025 10:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SsSY7qYw"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB162F291D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 10:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758882082; cv=none; b=D/x02Pm6HV/zc1VTuNclFUcyUQTzWP5VH0D4qRSGwVmfUYGzMWPox7HS/vbLOAlRy85mBR5wjYmCy/a7Tbl++b9IzRRUlxGl+hMyUzp1XdiJgBbU5zx/qG9z3Y9+xSRbI/l/mA2XXEsS0q9HkR9e8Yp2QU3CQfW7Rojx1NEK5q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758882082; c=relaxed/simple;
	bh=2Gr32EHP/Avf8Nz8WrRodJKQQ7gJH9zexTW6nxxUIDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wmnt9c/IBBIoL0JQ4DJ1HD2sfi3+BIGGgj5clhF++C6A/5tHRUDCyEgKKJCiiKjsJB2PfTNxjdqF/xgndB3MBkvDvbEyrYo9Y9egO0bwr33Ollq204ISv53VaLqIkmNqpMEhalfuEYscgvEQO/R1ERGhAgbijmbNIWH4cNe9J7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SsSY7qYw; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3352018dfbcso1297590a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 03:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758882080; x=1759486880; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2mr5aJwW4wAI2vyKBRO1R/nq3zNdsUd1leNYk/2x88o=;
        b=SsSY7qYwT9QM87aa24GqHNRcn+MFJABoXms28/Y75SWU9h4qRVtr9/tmWnAGkxQviJ
         kpBBH8t94r/vwHqphGvoq5KVCxABP33PgE+yPJDtQK3XQpa409Kyz+u7wGfvm2a68Tim
         tbRiV7R+mX+tNHnUdRc9pVMnE3sACrkqNA+5XxRF7uOloddk+NmDyNZEFYTRXR8UBwyp
         EMc4FyOXUeF/l3/rw1bX7zp5JYKeSq5lUCyqQjv0sLIEBfqQlRzvqRj8rsWJbsL4laJe
         l1xe/Y8JZtMBLKg1w8wyXVDymJdJmfhic+hZx7G0KNYuJGKmdnjVPrminjERfRdTE16Y
         K62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758882080; x=1759486880;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2mr5aJwW4wAI2vyKBRO1R/nq3zNdsUd1leNYk/2x88o=;
        b=QKhrAh9L0ileoMdmWVpmViFyAqHTPGJ3Y8WWoaNIz4cx6IseW8UZ0GWLbz9BHKwp22
         YAaiYp7NxkWGo4LL8NRzkdudSZmuMaftx2FBzpD8DvrV/FzapLNo+4GWT2gHEcgu4Ahz
         ZN6UgaywBkEt+cTkHtkzF4hmkyEk/QlCDHA4yE+Z8FaaU5Vxx7DCJslH/wOv+lq4P1VL
         1lj1zSS5LOuE1kB4ouFvLteM8mE0VP3Sc87P3T431H+/ffV33wySHFg8pbGAxqSWxY1S
         hOrwCjD0D0cVDFcx0rZJVLK0ff3IAlzl+XGp73ogWxRoMHKahpQXc5Tibtq68wj9qgZ6
         qD9g==
X-Forwarded-Encrypted: i=1; AJvYcCXVsXsuLbvtJ+90vf4PpCVPcA9ijMXaN1zuDWB3ChcFAUHcExGkq6zst0PViPDBgOFjDE0/w00veV6b7/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWrf2ivMCNLRtYxLl0JVfdXnAo+8sfeKWOwsbPaXtEmqP8S+dP
	rXk0mdU4uIApP4a2Cj0Cfb2Ikmim7Ay8v08PgJ/g3HJURQviwyQOFxHeuDQ6UqMD2//dOdz/znd
	h46fBgdYGv/pa1rG/KRRIBNMn3mu8Yy6ILB+sYmmkqA==
X-Gm-Gg: ASbGnctOsiSfk1q+ioL8KiRlWzlr6t9critKCiDXc2qSr3pwGwCx0tnOFFPdM0Vtrix
	R9E0drvZRPz7TSW1/hoA1iospMeyb4DkOuKsBY+Dia+IPWDhuhoN1gec3/j7zQvdWtYYekQ9n1g
	Tv8sCmUthZsq3BWbTXJSCKcl2fQp68IiDvaLCk/2kdzAeLazjPeJgnr7ckC07Y2xnM/j88cJrAG
	B76fifn
X-Google-Smtp-Source: AGHT+IGx5TQff80QO0H+uGd5EVhVYxJCBwFurE7WVV2W6BaaOB8VqMiaLcn0gpb/TEw+CJaxPeEGQwapz1T31R+d5qQ=
X-Received: by 2002:a17:90b:3d0d:b0:335:21bf:3b99 with SMTP id
 98e67ed59e1d1-33521bf3e0dmr3939591a91.32.1758882079945; Fri, 26 Sep 2025
 03:21:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925150342.1845615-1-sean.anderson@linux.dev> <20250925150342.1845615-3-sean.anderson@linux.dev>
In-Reply-To: <20250925150342.1845615-3-sean.anderson@linux.dev>
From: Mike Leach <mike.leach@linaro.org>
Date: Fri, 26 Sep 2025 11:21:09 +0100
X-Gm-Features: AS18NWDJehMnriuMz3z_2Gkv2PoEZlCnJuZatZK4VbOhtcC_WJxBmY3Hkz6rCyo
Message-ID: <CAJ9a7ViB1GC4d9D01KPdJTtkxc4EfvQgHAzh8uDU6Dwim+zGBA@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] coresight: Reorder coresight_device_release to
 match coresight_register
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, Leo Yan <leo.yan@arm.com>, 
	Yeoreum Yun <yeoreum.yun@arm.com>, Linu Cherian <lcherian@marvell.com>, linux-kernel@vger.kernel.org, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, James Clark <james.clark@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Sept 2025 at 16:04, Sean Anderson <sean.anderson@linux.dev> wrote:
>
> To make it easier to determine where to add new release actions, reorder
> the actions in coresight_device_release to be the reverse of
> coresight_register.
>
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
>
> Changes in v5:
> - New
>
>  drivers/hwtracing/coresight/coresight-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 022c8384b98d..305b1773cfbe 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -1046,8 +1046,8 @@ static void coresight_device_release(struct device *dev)
>  {
>         struct coresight_device *csdev = to_coresight_device(dev);
>
> -       fwnode_handle_put(csdev->dev.fwnode);
>         free_percpu(csdev->perf_sink_id_map.cpu_map);
> +       fwnode_handle_put(csdev->dev.fwnode);
>         kfree(csdev);
>  }
>
> --
> 2.35.1.1320.gc452695387.dirty
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

