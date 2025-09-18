Return-Path: <linux-kernel+bounces-822339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFA4B8394D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 758DD2A71F7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889EB2F5315;
	Thu, 18 Sep 2025 08:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0cR9NE0"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266532BE634
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758185253; cv=none; b=CX5GfbdNGsRPu52rJuaiQAzlXvaT5C4FSKhB+BuJiDFIHNNxI6zRXI9M4FfpGrscDj8B2MIbrkvxZN/R/T6k1kD7zxBOQvQT7W4FVMnt1NOoipZZmfUsV7b3hOU1vwnvoLvWqlLhiEOrnKypXAvYZAPJtx1sBx1WXgMeNXKt9Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758185253; c=relaxed/simple;
	bh=L45ZHUW76JMrGXCpZTDkbXpqy+oHe8GXZEgOVfexB8o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZlH8nEEeoNL8UHZA9MUVuGLONqmAp6XmTPOUa9EF0FbJavaRP6amkpRVzjtJ+5wBHjktoxaxYgUh+eN5lxBF4/zP8NHSfcSEVWoPRQ5OSE7aHKN3xvc3b2bx/5D5MPH/g6lFsv859HS9y2pb1jgLK97Xl/mQOJSaIqLO/um6VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0cR9NE0; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b0411b83aafso108313866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 01:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758185250; x=1758790050; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4dUuZLCrIMKFDhECHW6CRsaOlZAc9dyj1qs/1GGZce0=;
        b=M0cR9NE0W9Y1xN7+c4xlGTZwwhVigM/FIVmgKAIyZvwqF3Np4p7DxnWa2VF+gezaFy
         svZvKYCwUdmmAyap3TRZCZTt0eHvCqiX+5uMjpoX6Dp9KLOLcH/pD5INZwpurGQ9ZbXP
         vRobPnSAwwQ5I/V+z3lQ32nk0GeSoJHXbVB/WZrUX8WinuxqUdZdp4HcG2rvvVNfLnrb
         X+HxqJhjEPs9oHLaKCYMB6hgsPHKB3DMzSWKIM/MHV6GHofzL6XA/3RRzGQLMxlLtAw9
         aOS2FP2noNdiE/Zlk8JvO0Zb8Erbwee2waGIetr0UyAVy/whOhE8sSBQ/qe5zt/hJ6kp
         TgHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758185250; x=1758790050;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4dUuZLCrIMKFDhECHW6CRsaOlZAc9dyj1qs/1GGZce0=;
        b=fBi7msLE9n7KsQo0eIW+ec6wZECFu5Me0gA7ANAtTaXznOszuIQcVeFI16NLaFh54I
         0eIA0DpufR+D8+eLg+X4BoWTDyiUzJF1hjM85bl1tz5nylfCXUx2Q6KWUokM5gCjt0NU
         63WXwqi0BWhshIP7tAUVFuho+KkzOc7KpM7mrXRW6lOvn4DAn+j8W9jURQAR3q4BeLky
         /4XtYn8AfVg0l1mpCVdpBxzKfUSKO6rasomwru3ItpGgEWphwiUSqI56kCuZff/HrcU2
         DR3CVglyKZy+tBsi8rqGotQh4vAccS/nK0i186S3bJSUDVvL+1W3YVV1n1bIunYBHbJS
         CCew==
X-Forwarded-Encrypted: i=1; AJvYcCVu/7GgQHkJY5J57i8JOLmkri+c32nyHm/n/Imv63WmID8uKGFPzoYIqZRKf9n/Xt1/SbyCknaUT3BY4Uk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKNiv0WvJYtKWEN1LDl4qQkwCBy1iAQlgUvSjbX09ZEl3+Cuz/
	w97dljYj34hD0lgN9l1xiy6V4l/OIijjClb+BdWl8ZMwYTc7dUVuyJWU
X-Gm-Gg: ASbGnctgPclOUyfnGj857mJdgcDgnltFBNVE8Fa5EWxE7o7IVRhMsjOBsmHDjoU2YoK
	jFuTwO+Gm1smLyb5dRj/oEIlgBPulIZuejyKcbf3JuUYL2MIoHKuveXlXFhtKoo24ZDvVUOOylH
	uXblIGAdyeD4BKo8hkmsb5Qrbeh2Gwy3ut4bWczxX0zdgYK/DSl1d85pT564Tacc9IhhYHq+JIY
	DFIgQ4MSgmR4cNyZUeTq0FRMDHcttuv3C1zF0pNvBqNXQ9denCmr2F622xkAfjZWysiFg/v/iis
	wo1FwYrgXoLnUw2NzMK7qWrVRSZoYQ23amRPLLKYJCVQU+e6oyMXh6/5tCXYsrIemM/FxhcFhw4
	xF/jz6C/5LKg4cZ9rNb5QnhGlOkGdza3IfoNSPmR1uqJ5nzgmLNY5dg==
X-Google-Smtp-Source: AGHT+IGSY6T0zgBstKzdppw+beER6+Ou6Xf+HZr5uZODjknR4sf0RTrkDM+Z+jzltMePgD/ZZBp0rA==
X-Received: by 2002:a17:907:3e8c:b0:b04:76ed:3ff5 with SMTP id a640c23a62f3a-b1bb6802513mr591131566b.40.1758185250193;
        Thu, 18 Sep 2025 01:47:30 -0700 (PDT)
Received: from krava (37-188-233-225.red.o2.cz. [37.188.233.225])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fc5f44bb1sm148036466b.21.2025.09.18.01.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 01:47:29 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 18 Sep 2025 10:47:15 +0200
To: Fuyu Zhao <zhaofuyu@vivo.com>
Cc: Song Liu <song@kernel.org>, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, yonghong.song@linux.dev,
	haoluo@google.com, eddyz87@gmail.com, kpsingh@kernel.org,
	sdf@fomichev.me, rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, shuah@kernel.org,
	willemb@google.com, kerneljasonxing@gmail.com,
	paul.chaignon@gmail.com, chen.dylane@linux.dev, memxor@gmail.com,
	martin.kelly@crowdstrike.com, ameryhung@gmail.com,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	yikai.lin@vivo.com
Subject: Re: [RFC PATCH bpf-next v1 0/3] bpf: Add BPF program type for
 overriding tracepoint probes
Message-ID: <aMvHE-iW5eAwf4km@krava>
References: <20250917072242.674528-1-zhaofuyu@vivo.com>
 <CAPhsuW47BVGsszGU=27gKa1XOYLH+de1FgrHPVL4mftB2CvX9g@mail.gmail.com>
 <b23ef4e0-afa1-4d94-b4aa-28c02c3499c6@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b23ef4e0-afa1-4d94-b4aa-28c02c3499c6@vivo.com>

On Thu, Sep 18, 2025 at 04:05:51PM +0800, Fuyu Zhao wrote:
> 
> 
> On 9/18/2025 4:02 AM, Song Liu wrote:
> > On Wed, Sep 17, 2025 at 12:23 AM Fuyu Zhao <zhaofuyu@vivo.com> wrote:
> >>
> >> Hi everyone,
> >>
> >> This patchset introduces a new BPF program type that allows overriding
> >> a tracepoint probe function registered via register_trace_*.
> >>
> >> Motivation
> >> ----------
> >> Tracepoint probe functions registered via register_trace_* in the kernel
> >> cannot be dynamically modified, changing a probe function requires recompiling
> >> the kernel and rebooting. Nor can BPF programs change an existing
> >> probe function.
> >>
> >> Overiding tracepoint supports a way to apply patches into kernel quickly
> >> (such as applying security ones), through predefined static tracepoints,
> >> without waiting for upstream integration.
> > 
> > IIUC, this work solves the same problem as raw tracepoint (raw_tp) or raw
> > tracepoint with btf (tp_btf).
> > 
> > Did I miss something?
> > 
> > Thanks,
> > Song
> 
> As I understand it, raw tracepoints (raw_tp) and raw tracepoint (raw_tp)
> are designed mainly for tracing the kernel. The goal of this work is to
> provide a way to override the tracepoint callback, so that kernel behavior
> can be adjusted dynamically.

hi,
what's the use case for this? also I'd think you can do that just by
unregister the callback you want to override and register new one?

thanks,
jirka

