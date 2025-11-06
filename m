Return-Path: <linux-kernel+bounces-888688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C31BC3B9F1
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BEE444E3253
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4076332ED7;
	Thu,  6 Nov 2025 14:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OnMqOlUp"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4BE303A1B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 14:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762438458; cv=none; b=KcfpEy+rnOk42BgAYxRJg/XtBX4XyROKNu/ZplQrJEJMp7KUP/OmMacb/X3jbql+6XExwZBkSuw2w0F9/UvjW7uPyUadeRto2DEZWglIlYjKz56SPB67yFfwqZX8edG4x8M10aB9otONXSa78mewLRmkVmIX7BQxKXU+jNWu20E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762438458; c=relaxed/simple;
	bh=lCOepWET11/2RBMZIVz12tIfpVzBbtaCqJMFPlkyEcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DttzCupYDIU+GRUFL3r4n5E1MaND42Icw3Asb0flod3zV0YygUGHDWT4RfPG4yw9q/WcxtWdrw4AP2nW8QDJ4nUUUXfoskI2BAuBdv0LXb++xbXC7ov7vlBmEPsyj86DMKNuy3pRtKulM5PeRWe1ZWYz0BDE69q8Ita4juXPyUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OnMqOlUp; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8b145496cc1so137379085a.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762438455; x=1763043255; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KYFaoUaPqBFs4zpnq3Lm30Kel2vQ+Isi1f4CetV78uY=;
        b=OnMqOlUpSlS2kkoohRdyrIYKjnUGc3ItnqCh7QEhZpVOiCErn7/WgXeIVHFbJeh5Ch
         2gIYYQJOAMWayHqr7y43BGxgq1a8gR8MjqvJswBwDtpe0dUeML//25fnJ1HMj4IUnRhB
         F/CHFw2cgUhj6rbkDx72TqygnArYlItEYS35MFoeSpKEWLcEt3UbUzSwU35Aawyw/1Cf
         9ylv0FY4t+44OExFWbSrMEOvoWul+P2gz80/ryzL1fh+NGLJzfWm4de1C0HC/0pATuGK
         6jTFI07ukE/1BODe/2E8JeNAguCaTA2+KKAulRyNKAKf6R8epMA+eXYQjeRYV0WdgyXU
         +muQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762438455; x=1763043255;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KYFaoUaPqBFs4zpnq3Lm30Kel2vQ+Isi1f4CetV78uY=;
        b=j+Nxc0x5AXFTbI2M6IZE7WtEoMr3kl7V9e+3oYJtZqPtWBWh2C2rEC16GkPgrHtgEQ
         k0y83e9YKo+ETlxOH9wx8ue0jrTyJS8M/XtrInUU62LRGxuLoAebceHhOh/sKMKjjdFO
         szMSmQGOIN8zaQH03TRPerlFvaA6ySX18YX20He3NV2IgI674zDIjRq5exxqEz6xsfzw
         yeeg2dIEtRt8VXO1arhu9U7YIkq/daE45UWGZT2zzmjuZE/JtfCuKjvlM82nYX2tRGQy
         DcUrT01yrtkrN8JCJE85EQs4uOyeOydWTWC2XGR855V5imzrnDUBJG+P6ZazYpX3Fhnr
         qZZw==
X-Forwarded-Encrypted: i=1; AJvYcCX0lsGV2lE9xXQh/mpEvj2bUN1dWvs2ph7OIUqwwUj67MGrj/Qm+yafdxk7cn28DlCx7PKOjx7mgmNlj8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxnoQdEmhAgo9+dmkmU+QHsWexnxFnaBTBjVc2JgSdtpGrk8Ed
	zWSs4T7OZgqkdDnF4bIauSdjb/myawk36BnV3qRXWazOQa9aCOVSiQtVICaa8YgMPzwBNSBRI5o
	598baz83ICcCO6vRk35vWWyA9Kk/iehmioe+LMcRrRA==
X-Gm-Gg: ASbGncv4lJBc43InhB9P6vyk6e4Fo+trJbEX+lU3kuIQNJLfltSHQNvg7DkRs3753nd
	ItSx7nv99ik+YDSmHHnqUxkb2WmLL4rB3QNRXEsSoYpHrEkV3FNllWmWLjl1D0Aon2182botvS3
	Yomf3maGwo+mGb+Pl2zGZpqM8egKEXarajSWLoAS2BJJ/qjdCBGyvKJrNhK4EcKKvpniNVKKL3t
	34yXFOK5JrRvJgm+2oBkyqH6IWieyg3O8aCDaytgbBkOjo+E4ras8qdHjvkIDRPjU58Qv5BmxVv
	m1Zt/ZxTgDmS0RnzDzsKsfCRkOys
X-Google-Smtp-Source: AGHT+IEL/OjdpCudnpto7EM9lmyvDKegeMK7BC71b7SfH+up9yag/BCWFhn9z12orK4BrZX5VPjYqt/GlifmAA0brpU=
X-Received: by 2002:a05:620a:454d:b0:8b2:294:1cf1 with SMTP id
 af79cd13be357-8b220b1c9b7mr943868385a.29.1762438455191; Thu, 06 Nov 2025
 06:14:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021-fix_etr_issue-v3-1-99a2d066fee2@oss.qualcomm.com> <176235893222.387743.2128022832743502879.b4-ty@arm.com>
In-Reply-To: <176235893222.387743.2128022832743502879.b4-ty@arm.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Thu, 6 Nov 2025 14:14:03 +0000
X-Gm-Features: AWmQ_blBAvwJrBuwMN552m9J7iG9zQVh_LDuoQgBSibOW9xk--Ct5-VQl5IDv-s
Message-ID: <CAJ9a7Vji3fFnc-XPhdTxh00QW+AjqLqJo=zt+SMwovttQRwR8Q@mail.gmail.com>
Subject: Re: [PATCH v3] coresight: ETR: Fix ETR buffer use-after-free issue
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: James Clark <james.clark@linaro.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Linu Cherian <lcherian@marvell.com>, 
	Xiaoqi Zhuang <xiaoqi.zhuang@oss.qualcomm.com>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Is this fixing the correct problem? If we prevent the buffer size from
being changed while the sink is active - which is probably what we
should do anyway as no real good can come from allowing this - then
the problem disappears.

Changing the buffer size while the sink is active should return -EBUSY;

Mike

On Wed, 5 Nov 2025 at 16:13, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
>
> On Tue, 21 Oct 2025 16:45:25 +0800, Xiaoqi Zhuang wrote:
> > When ETR is enabled as CS_MODE_SYSFS, if the buffer size is changed
> > and enabled again, currently sysfs_buf will point to the newly
> > allocated memory(buf_new) and free the old memory(buf_old). But the
> > etr_buf that is being used by the ETR remains pointed to buf_old, not
> > updated to buf_new. In this case, it will result in a memory
> > use-after-free issue.
> >
> > [...]
>
> Applied, thanks!
>
> [1/1] coresight: ETR: Fix ETR buffer use-after-free issue
>       https://git.kernel.org/coresight/c/35501ac3c7d4
>
> Best regards,
> --
> Suzuki K Poulose <suzuki.poulose@arm.com>



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

