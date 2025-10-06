Return-Path: <linux-kernel+bounces-842556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 615A0BBD020
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 05:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 21A1A4E206A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 03:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8C81C8621;
	Mon,  6 Oct 2025 03:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RznsyZHz"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A67B661
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 03:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759720910; cv=none; b=K92gWQBikqUg5cciewDe+e3XxM8paKOiEtecJVQJJIfXAU53InQT+6qicVeekJa6aJ1axLewTvk6Kw5Px+lYuScBhzRsOFHHHFOzl7FWpJH2sXDenbwR9NnYJn1swnQ0MR+WCSB8KDVJDnvCx6JZY56++rkK/bOqNm7GMu4wL9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759720910; c=relaxed/simple;
	bh=Fs0DmBhUH9tA1PYMetiifcOi7IhfSdT65e1scj6FNlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ibb30IZgAIuNpIzPU2ojGihhuJfzwOw19b7Eziw8/nIGvwWMG7ps3n4heJbfS0IiMWPcyrhqrAkZTWmE9mb6jKZ722z8BsV31xmEhNx2ZQuzDpnzAHCHtxQb/HR579c7+tjaI+pMP4hqjB/4DQkpptDCEwltSsfRtkNd+z6AGGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RznsyZHz; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3306d3ab2e4so5097668a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 20:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1759720908; x=1760325708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNe1BtFwZCWEPhXLGHatFUWM31AoQgF+OLUDVfKFkjA=;
        b=RznsyZHzQP8mMp2XLdgvQqz2NMbnpeQuCxpV98JZvJD6kEUjNsXOi1BxHR/BM+fgOh
         XZRO0dzdjN4nJddjVAD/DWuQDZvHvX+BpE9jhmJ83aAKBNZOLEURdPUDnBSWC8LF/rKN
         e8XgOnUca1xtbngngI4ccnFSR/TXSLNKVaGxwHnNaLBAp7gw9NSkNuaTMnTehmWmxFrf
         ziClhqHHql5wwoZ+YNq27H++YGe9zAwDa9wQnTe+eeleusd4k0a43k+5ThnGrZpZ56Nf
         /Bw1KN6nHVuKgY81IIebj10tl/E9rkskFtLFyKWu7qdpuYOUmpplyH06IGQ4Cd41HXnd
         jaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759720908; x=1760325708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNe1BtFwZCWEPhXLGHatFUWM31AoQgF+OLUDVfKFkjA=;
        b=QgFg/U06cnwNmKU5g9NxUr2gEpR9R6/jFGJZbbDtVDzNlWKISzxlaTICCYpCaG4A3D
         GxzdG/b5TF16tA38w8uEYfx9J5AqMXS879zP/HkkUVWFZsh977DmjCwiHrsKis8bheHJ
         pFyAJArlmV+iwaFNzOzLA30Xx1B4+1s8Ho3ey9MbvfJrOJ4nePKmSiu3h8XeNSJSXXm6
         XHo4kYHBCGPAEntTF/vumm0WAvotQUzGONvN3rjcqn1nOncafNlEda7mHL6ptp7SQTvh
         KLc1SoyYdueDHSjWdMMNGxdQpgHZiUjX9qt6WLlROZo+VPrVxieAhasP60MgvKMLqDTc
         7kuA==
X-Forwarded-Encrypted: i=1; AJvYcCW71Gofn9xfgpzO0KL4SzCE5UaJFbIiQY1Ap5ZKbO5tayHEBeaL7fLSQC0725tp/qr6GBlX+60LYgOaj7s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3UvArVy4ZD7aP8XCuZMt7ignT7pNG2hZPRpLROvpdPIbQvCrP
	h71Fgpf01q/WEJo6BFPWZiFWVmFiHJzlXC5mp2W7HmKw9Pcnrh8DtknYyyE3pdJjIx6OzinOauk
	SlHoGVts82I/p4BfYDv6koOJqf/v9RJpqkVT3OOFz
X-Gm-Gg: ASbGncv96gkRtRgyQUC3GeAZk0LewRcijnYSpyMUkf7Kfp6NNO8E9mpkM+l9wVm2pAq
	m11BtLhbb2L1D4Ga++85zk1MN0a0mYGCD60SetyVJZaQdL2J8RIdp1q8GfDhOx3+XC4MwUE2oTu
	G71lrcQqKjEQ9zq/637q2zjWnCXh88bBPkrK0yfy1/iaj8axeHgAqyB/aYbMqKRdmRn5uuACqmg
	HafMOuOd3WfdLUxnyseBukfmP0U0UosVnN/BsNcmQ==
X-Google-Smtp-Source: AGHT+IGFq0axzUgjuW/bqeqCCkDDkLDZV1sW0PXrbMNlNKuyMmrGb+MlIyPOuH79npU+uAnuItP+H5DlxaL26jPjukE=
X-Received: by 2002:a17:90b:4f42:b0:32a:34d8:33d3 with SMTP id
 98e67ed59e1d1-339c265ebcbmr14099372a91.0.1759720908573; Sun, 05 Oct 2025
 20:21:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904165919.3362000-1-rrobaina@redhat.com> <CAABTaaB7SxWZUH+VxyOwZWBi6uPERg-qkMosFA=MTst5Rbc6kw@mail.gmail.com>
In-Reply-To: <CAABTaaB7SxWZUH+VxyOwZWBi6uPERg-qkMosFA=MTst5Rbc6kw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 5 Oct 2025 23:21:37 -0400
X-Gm-Features: AS18NWDmHEs_E1xJvOPFbgu_1W3XkerYQHRZHlJgzZHHJrj04sEOcidcx32QCgo
Message-ID: <CAHC9VhSi68-i8om4VYbxRsrK7xpVL-NJy89e01qsa5WTT-hQFw@mail.gmail.com>
Subject: Re: [PATCH v1] audit: merge loops in __audit_inode_child()
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, eparis@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 11:50=E2=80=AFAM Ricardo Robaina <rrobaina@redhat.co=
m> wrote:
>
> Hi Paul,
>
> I=E2=80=99m curious if you have any thoughts on this one.
> Please disregard this email if it=E2=80=99s already in your to-do list. I=
t=E2=80=99s
> not my intention to rush you in any way.

Hi Ricardo,

Your patch was posted right before v6.17-rc5, and with only
approximately a week before the general feature cutoff for the v6.18
merge window, I didn't have a chance to properly review it before the
cutoff.  Rest assured, it is in the review queue, and with a little
bit of luck I should be able to start working through that this week.

As a FYI, the doc below describes some of the basic process for the
audit tree which may be helpful.  If you lose the link, it is linked
off the audit section in MAINTAINERS.

https://github.com/linux-audit/audit-kernel/blob/main/README.md

--=20
paul-moore.com

