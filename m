Return-Path: <linux-kernel+bounces-884406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DDFC30212
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 10:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A40E4602C2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1A52E9755;
	Tue,  4 Nov 2025 08:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="H34Il7WF"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28E02BF012
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 08:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246372; cv=none; b=KxIo7R/cD0HzeNfcUAqwqVufx8FbfnrJuM08cUUro3r8CtjbVNU4vLOgkNMmJAqICy10ijpc8eloJxdPDvzmNxiFY9AyKJn+I6u5VtbHn4L3++dZY7FC30uD5iEwXiH3+6BJuY0apuGYNbgM+5Ol6Mn3n3VWMa/FnYeCq/MlTGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246372; c=relaxed/simple;
	bh=HI7+rpZeec/CFooIPQ0R6s6hxWdGC9RE3ZH35FZIEZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z/ARI/p3XXIka1tyl4OFegH8gzj2mZxe/IMMgJaNQVhJIPIydRMLkmWl1RJelHY/mvxn/ns6dqbyPyfDLe5A5gatrVN1+AIxn/3pFIfLWUfgAkoHjnz61YCv+6BYPolwhxfb0Y7tHLM0VGokiOiosjw5TRIxz4wlhCxKIeYTBrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=H34Il7WF; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-591eb980286so5013570e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 00:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1762246369; x=1762851169; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z75IjBPhT4kst0ejXkiZdr4y608GAAjYfVhWlec6GjE=;
        b=H34Il7WFs0mHCBKgXj0oDgT8n2snvYmESP5TfK84737DvX/ln/coIwJ757rT2+1aap
         oMJL0qRHsmcoi+VK/rEZ0bJrSLeVBDHTMahYNTXqOpxYMsYsN1jfYAhAqoNnvjFvjL0r
         kDfsPZkL6SXeWFNBF4Nut/7SkfP4VWeu+XCRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762246369; x=1762851169;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z75IjBPhT4kst0ejXkiZdr4y608GAAjYfVhWlec6GjE=;
        b=CAtmYIjbuBeUIm3TKIi2TsO+p6MhANyQ6KRGT9n8ETklKZWBZrnZeWmetiK98n+QYC
         Y/iH1+YTPZAxu3/5bj23JZbP9SRXajGpQjo/lXKD1PBLkGiinx45hHgEzKvS0mm2vSgx
         /biatJS+QLwIqhtZ5p38wchzUdaSr7KRnXSFfAUoREcmunj3H0kOuaknT2K7CiWMT9tX
         zxl74diKqoyJWdi2lyfn+e++sp1Y3wSvt372rvNYt/7WCvx9Q33Efn+8g+8J5yJXWMV3
         eXcXp5/h7wbZFQOj9aCb2j7hWTD95rp0xZsbuoXaHNhtvAGKz+fjHdvjUEY0tqPLdzkt
         3atA==
X-Forwarded-Encrypted: i=1; AJvYcCWQmk5ynMS/jHwS7ygTO4cD8GhZSd1AFpyRPOfuDZ68+hwWFSu6XncBqQLBVRhBUG+Hi974XnreA6E8z5w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc4VB6f5x6w1UdW7rA//WkqdfoH3DEi/lw1C7pqs5KSigmEgYt
	N0Gn8JYrFrTaesBrhPRUUUsL8Zk3olN5dNvwcwZjAzyyzFTE5qmIYgX6XPsgLZyhcLki1u99UXO
	709HmMmt73yMP/cEx1oVJJXcjAdWWSgQ89/gu6TtTkA==
X-Gm-Gg: ASbGncu2KkIZ+xrpL/mvGNS2GPicIhcYOBqmwnKm9d6NwmgPPD3e8wIIr7wN07N5Yg6
	YObDpnrP2TLBcN33hmhxAg7AD2dIIkQ0XbohxUWJcP9lVpcNBENohYKt+gIgFx5QNPAVKPaxncQ
	oyMyZFIBsEDyTHLCNRAdKBwv6etkUCtbYGslQJ/V05SbEGiKLPRzs3koab6vwbE9JG1q/tBp40r
	ytrYq3PmRafvIiZIf23i3Joe9yLU4sumNYwmmq2I2AgzYnbluVqAItC06Xr
X-Google-Smtp-Source: AGHT+IEXt5TElzzeDxQk6jhIi0O6CoCze9GFEKIHI2MOuwfGUwhweABKgWr/yMYr+zIT72QAwZRH8WggMb4bQWYILRc=
X-Received: by 2002:a05:6512:696:b0:592:fb56:f2be with SMTP id
 2adb3069b0e04-5941d55163emr4939379e87.49.1762246368888; Tue, 04 Nov 2025
 00:52:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org> <20251028-work-coredump-signal-v1-9-ca449b7b7aa0@kernel.org>
In-Reply-To: <20251028-work-coredump-signal-v1-9-ca449b7b7aa0@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Tue, 4 Nov 2025 09:52:37 +0100
X-Gm-Features: AWmQ_blKnrbsoabiuwCBaSwhOYeiHusMzgCOkxvPifg31ZhSyVcGEctWEkRCKzw
Message-ID: <CAJqdLrqf9Y-qO54Ov2m15W05X2-kZugk68Wm_4Ep2Rn6OG8Ygw@mail.gmail.com>
Subject: Re: [PATCH 09/22] selftests/pidfd: update pidfd header
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, 
	Amir Goldstein <amir73il@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Yu Watanabe <watanabe.yu+github@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Jeff Layton <jlayton@kernel.org>, Jann Horn <jannh@google.com>, 
	Luca Boccassi <luca.boccassi@gmail.com>, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Content-Type: text/plain; charset="UTF-8"

Am Di., 28. Okt. 2025 um 09:46 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> Include the new defines and members.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>


> ---
>  tools/testing/selftests/pidfd/pidfd.h | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
> index f87993def738..d60f10a873bb 100644
> --- a/tools/testing/selftests/pidfd/pidfd.h
> +++ b/tools/testing/selftests/pidfd/pidfd.h
> @@ -148,6 +148,14 @@
>  #define PIDFD_INFO_COREDUMP    (1UL << 4)
>  #endif
>
> +#ifndef PIDFD_INFO_SUPPORTED_MASK
> +#define PIDFD_INFO_SUPPORTED_MASK      (1UL << 5)
> +#endif
> +
> +#ifndef PIDFD_INFO_COREDUMP_SIGNAL
> +#define PIDFD_INFO_COREDUMP_SIGNAL     (1UL << 6)
> +#endif
> +
>  #ifndef PIDFD_COREDUMPED
>  #define PIDFD_COREDUMPED       (1U << 0) /* Did crash and... */
>  #endif
> @@ -183,8 +191,11 @@ struct pidfd_info {
>         __u32 fsuid;
>         __u32 fsgid;
>         __s32 exit_code;
> -       __u32 coredump_mask;
> -       __u32 __spare1;
> +       struct {
> +               __u32 coredump_mask;
> +               __u32 coredump_signal;
> +       };
> +       __u64 supported_mask;
>  };
>
>  /*
>
> --
> 2.47.3
>

