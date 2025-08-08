Return-Path: <linux-kernel+bounces-760138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F32E5B1E700
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 13:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7931A3BDD63
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0EC25BF16;
	Fri,  8 Aug 2025 11:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3mmWKTP"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C97145329;
	Fri,  8 Aug 2025 11:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754651652; cv=none; b=q5UZrHR2PZsIoZGOwIUuh4Zzd0XYzmUT+wPICGGaNMKulKtDZrTIi7tmAnaXBYz8hgkA2gm0IMJ1jhhn6BAqmAH9AzTrP/V+0bFD8WkJRbQn9+XKACEzOTLrju+hrEmd2EOHePyfRsIwaLuLStOCJe8CQJpi3HCMxyZ2iOOKD2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754651652; c=relaxed/simple;
	bh=mwiKNAZPMigvKlo1e247AZaIqKdLdwnU++ilG3Wst3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rv88neZjZbtA22AY19nRmfHTLug0693ShCqfrc6Z8cHtobo45NUpQnPtTQn43CiJh4GvOOnUb0MOjVqpplz7t7eHt1pFfl9X1hTD5wtlG1sLJMOrP/GdqDEuUkVoVMrGazG8eO2kiVBdVa7A+VFpEsrWieA2Nv9JVU1amdCfkHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3mmWKTP; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6156463fae9so4953776a12.0;
        Fri, 08 Aug 2025 04:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754651648; x=1755256448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3ct85s2LDNi/ABkkV8Ojfz0tKxakaJGHtxIu3LN6no=;
        b=B3mmWKTP6AWiP0akooCsijDF/IoJUEpjJWzIYAbKwCpKpnSmUHiMuaPRhfHGRg4kPS
         HWWxoJT/NkqXwAEEGt3oSS0mvl8V9vj0IiyfYK2nV+oaDTCIhcwn8Toxy3igeuklinsJ
         yJeLRitEmmv3bjTV3wZhO7Xtt0MBxIpH7oBM0SDHpmR8MFZVyxRte4pr1dwI3CEl/9eQ
         WhIKKN8u/oYOir6HJSJbxgazXrhWdihFSZzAeSphaOEHu9XS/DhUqOarEl4cWXjs4Rj1
         SjDyhJeNq2CxQONFhhQCyQ7eSsouIoKeHrFdOwjW0IJEMIv1z9mr84q/h/xb+nc4iHye
         hr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754651648; x=1755256448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B3ct85s2LDNi/ABkkV8Ojfz0tKxakaJGHtxIu3LN6no=;
        b=xJgK59Z9q9VsgTvgyE5eQimGGGqApZkinkxv+L0p3KUh273vo4cJD8RBCAtvlKlX93
         sU9KlUOfJ6qMzwWeP+TDM22SX4crwP5XR0pWb8t96feHUohnbiymk+ymKjvmlWokrQIA
         rUB1NKRWOy+qJkCffntc64ZUIbLCFpnItYcZ3duR/RkRjrZERzyf0sAVH9Z3ABh0syhO
         WOA5NxX0WmbmOp5fKJZu+K7Vwnqqgzj+nI9tHVX/RGFqAeGbLOf/ctvYC6+NJ0zBjwnC
         i9JqZjJvohrkB8vsUfviGgqVOeY4VoK9J/zk88saRkecJisxjWbHfiNFM/76P/3lwIry
         JHuA==
X-Forwarded-Encrypted: i=1; AJvYcCW5v+oyAatqE8wjMqrSHJSZd/CdDlwLS2/u08f1RDCeMW0Ot+voC5CZIGj61jzK7CIaO5N4l7xRx+h/7to=@vger.kernel.org, AJvYcCXVvZ4mNWcNVMykioeXjdGMCB/9ql+3XwMyD075fexHU29TsPsGgLQu5EQnNRDQXYpBOrxwt2CBCCyhC0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeIG6JZ4ktZqKHNsfjCIMv32GLy8CJkrVKiv8nDVJMm4bVSbkO
	mff4oHtJlag1EQCwl331hzHdrPw2FBuZ7BGJXwj14H65jIIpR8PqIoVM
X-Gm-Gg: ASbGnctsZ5tBiZ4xc5Ff5jWIZTMg4HlkJrb4UDj1HrLY5TTi4bMuXxXMUxqqhMI2odc
	coSzs/rwCoRtZR+soEAlghhTa2kG/YB47X+dhUAdFxhfuyNaHmTq1dmoOLmRlFShMJCmcKZ9+x+
	qG1x5fJdZzrnGV67tVdWieZC7PoXgNvf3KKmHP5sOPfRza5u/95TixeZFMy9jaIyrdCQgZ9BhLP
	0ZYf/zAhOBjCBxkpU2IioQDwTjW7Owrid0luAtCVyRSdt/SDWNBO82barAGXPozhOigoIn8NZYV
	c5WNaMIn5CotYZKuGdUjDONrRkBVMM4CBiiCbmeI6pTPFXwm9pVTXmPdT6k9Yb08DHLtOHxIrm2
	JGDE+e/VbSRLmG3Z2Ovjg58EyyiQwttMwdmX6iHWO+/9B963CeDHWYamQnKwVALCxr+OQCi9Ep8
	WzGZTIqQ==
X-Google-Smtp-Source: AGHT+IERjIDD9lvjWCEMnBtx1QDXOlHZJrcDHzH9a1VHfbHWDgCJi7ODaoELgPxcZxykKOYFOH7C7Q==
X-Received: by 2002:a17:907:d8c:b0:ae3:c72f:6383 with SMTP id a640c23a62f3a-af9c6fd8b38mr233173366b.17.1754651647872;
        Fri, 08 Aug 2025 04:14:07 -0700 (PDT)
Received: from localhost.localdomain (93-87-121-223.dynamic.isp.telekom.rs. [93.87.121.223])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c0a4sm1477797966b.109.2025.08.08.04.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 04:14:07 -0700 (PDT)
From: =?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
To: tiwai@suse.de
Cc: arnd@arndb.de,
	broonie@kernel.org,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	quic_wcheng@quicinc.com,
	ramiserifpersia@gmail.com,
	tiwai@suse.com
Subject: Re: [PATCH v3] ALSA: usb-audio: Add support for TASCAM US-144MKII
Date: Fri,  8 Aug 2025 13:14:06 +0200
Message-Id: <20250808111406.4074-1-ramiserifpersia@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <87jz3eywak.wl-tiwai@suse.de>
References: <87jz3eywak.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Takashi,

Thank you for your reply and for taking the time to review my patch.

> - The sysfs file should be dropped as Greg suggested
>
> - Try to use guard() for spinlocks.  (I know other USB audio drivers
>   don't do that yet, but I already have a bit patch set to convert
>   those.)
>
>   Of course, there are cases where guard() and scoped_guard() don't
>   fit well (e.g. the loop with temporary unlock/re-locking), but in
>   most cases, you can use it well.  If it doesn't fit, it's a good
>   chance to take a look at your code again and reconsider whether the
>   code flow can be changed better.
>
> - Similarly, try to use __free(kfree) for temporary buffers.
>
> - snd_pcm_lib_preallocate_*() can be replaced with
>   snd_pcm_set_managed_buffer().  Then you can drop
>   snd_pcm_lib_malloc_pages() and snd_pcm_lib_free_pages() calls from
>   hw_params and hw_free callbacks, too.
>
> - Most of enum info callbacks can be simplified with
>   snd_ctl_enum_info() helper function.
>
> - It's a bit big code and it'd be great if you can split the patches
>   in a logical manner.  But it'd be OK-ish to have a single patch if
>   it's not easy, too.

I will implement the suggested changes.

Regarding patch splitting, since most of the driver code is new, the plan is to create two patches: one that removes the US-144MKII device binding from the existing `us122l` driver, and a second that adds the new driver files under `sound/usb/usx2y`. Please let me know if this sounds good or if you’d prefer a different approach.

Best regards,
Šerif Rami

