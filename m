Return-Path: <linux-kernel+bounces-735339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7DCB08DF8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8545808FB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C115C2E0909;
	Thu, 17 Jul 2025 13:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="iWfSQRtr"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954712BEC28
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752758280; cv=none; b=dcr6ZtKvq76qLR/yYUJs2c1x4q5XszvjHMsCPjb0mR2XqGMdCL0E5SmFg3PfC6RcbOpmYmunUyv8ziRDRXSnlGBSTusDBwdFw4GR+0DNqCpQ0IP3tIowrG935bxIErVF8KxoVd62u2epbwKt+wMqI2tpy0J/yc5sWACVA//5gB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752758280; c=relaxed/simple;
	bh=ZDviKLcvI9VrAI+wR/RQw9Ygk7b5+KAWd1c6p2r0hE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A98bmwDXBeGSSQQjxaXx7Vo5QycjXh+CVabbkyql0bF8XFQZwMxQ4cBYwcjJsw2t4mcdTbzCCFHOw6DcFYY9xzsYGmRqMhlH5hsH+5r3r5pvV9rcg07XchwIcod7wC+fRzvTNMwE7jokwoAl4V6USFKAXJAWoB0cXcxbRp5hIyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=iWfSQRtr; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45611a517a4so4090315e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 06:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1752758277; x=1753363077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDviKLcvI9VrAI+wR/RQw9Ygk7b5+KAWd1c6p2r0hE0=;
        b=iWfSQRtrFcaACc83FKbGj6jkzS/1AZDDKKIgEZwQ4n9Msae8ZYHbRoHBM9pQ/uQZB7
         /L2xlWb/O+RLCsWnbnSLb4qAIiLcS6nziyihSqSWmQKraUSR1xVm3ZNVfOLd/tiL8bl1
         zEyKN3nNsHktQnpJUOtN/7/XSqOeN1TeQIgbaHbcII3uiYL9CFyLI7e8I9k8AsxJgy70
         gi2jJSiE2ouXIQVyWt3vpfbl7rKQslmVLaGwDICMzHXn/Ov/jop90Xk9rmLftMgTbsmU
         V6sIGCRvRTfov6YlQf61QSYTGev5BbVMN6jyuqKeiZYfpPvh+FoqI9CgoNkS1HH7Xyli
         QCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752758277; x=1753363077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDviKLcvI9VrAI+wR/RQw9Ygk7b5+KAWd1c6p2r0hE0=;
        b=D3BCQz8ob4jRg729EAsIU8Ys9D4yZ9tgSYBG/UYs9xdaHegAD2cmseNAqgEnYc+xKS
         R/IPKyDmoj/OtenBxqissfufE1bcdLl/8VrKriF6l9exBA3iqWvzeazuoS4H5+jz/i2u
         Scsi1h5PsY4eHxePEarEdCcwG6pa5V9b7ETw1A6t5g20vO0TXywyNAfW9KOYKNyViRzi
         1CmqrfYeUBOz2SAyJjitY1KVifp29f5a3rGHVX4ov6XjK0lWm9H9uf6FdaGs0qMEKEOt
         FCQmJJd+fOz5q3nmdbG0QjL9XlZ8NiGJgUVIODaKV/qNZxAHYAkpE3qQ9MZuW4yuQcow
         46gA==
X-Forwarded-Encrypted: i=1; AJvYcCXZUZpHVNhYIy++p80E4cWDN2TOKAf/YAagEqtsDOz3rOK0BIBXfcp6Jv0mYA6jyBQIgfYtyMpWSd5xfEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJqpJPAE7T00HzcF4JHIYPGqZLbAdSuDChjj0/6YVSdgkqy4Su
	44mXE8kUw+XENN3lP1qV7FzBtLaHpsp1227HFODmbEjMGmNhTRbqj91DyN5ryfZYMyuKzu5LaXp
	zyw1elRA9wyCBFXzjUQnt+/ygL5ok2tkaYnPNDucBfA==
X-Gm-Gg: ASbGncsRvLak5BYOg3LOHucorFfAqUb5vYiYv3sN4gyEGSzAYsQg6FLg4zX1MNPih/H
	gplpTIcen26T1ggjQBlgqiWfav0tmx460zpAmHtaFOtAsr2F0t+5UcFNtMReD4+e/f0aLGajPG6
	AA+uXy5qXhaFCzudm2NnrRdd6/gXGIBKy8hEGVlOMh8H+7IjlyB9uyTmxxsUbVC1960W6+hYTMO
	7UesQ==
X-Google-Smtp-Source: AGHT+IHWUpImxyj/M1iYj87ohSochOBEwmwUERfKvdToAyTI2JfgPVjFu+KTHMnlrSfiuDb5dWth2zr65OoSOyIcwLg=
X-Received: by 2002:a05:600d:17:b0:456:15be:d113 with SMTP id
 5b1f17b1804b1-4563451f300mr28829025e9.1.1752758276810; Thu, 17 Jul 2025
 06:17:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520-vmlinux-mmap-v5-0-e8c941acc414@isovalent.com>
 <20250520-vmlinux-mmap-v5-1-e8c941acc414@isovalent.com> <g2gqhkunbu43awrofzqb4cs4sxkxg2i4eud6p4qziwrdh67q4g@mtw3d3aqfgmb>
In-Reply-To: <g2gqhkunbu43awrofzqb4cs4sxkxg2i4eud6p4qziwrdh67q4g@mtw3d3aqfgmb>
From: Lorenz Bauer <lmb@isovalent.com>
Date: Thu, 17 Jul 2025 14:17:46 +0100
X-Gm-Features: Ac12FXzAj1uStiEkTmwdY3kJmq5UyFHyQ5GKtR_wcQY_1cDKPtpY4TzHkBJQvTY
Message-ID: <CAN+4W8hsK6FMBon0-J6mAYk1yVsamYL=cHqFkj3syepxiv16Ug@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/3] btf: allow mmap of vmlinux btf
To: Breno Leitao <leitao@debian.org>
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Breno,

Thanks for reaching out.

On Thu, Jul 17, 2025 at 1:39=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:

> Should __pa_symbol() be used instead of virt_to_phys()?

I'm not really well versed with mm in general. Looking around a bit I
found some explanation in [1]. Your suggested fix does make sense to
me based on that.

Let me run the patch against bpf-ci and see what happens.

1: https://lore.kernel.org/all/90667b2b7f773308318261f96ebefd1a67133c4c.173=
2464395.git.lukas@wunner.de/

Lorenz

