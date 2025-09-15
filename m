Return-Path: <linux-kernel+bounces-816907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B578B57A8D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D4561AA00EC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AF4307489;
	Mon, 15 Sep 2025 12:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J9Ek2QUW"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D0F30748B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757938859; cv=none; b=iW/vqgOzE+ek+yoA+Ibo5j8+r43FdBzh944ENDrJuz0eb5OVFiKvgxrH/8xGCzTDYeXmgxAlfjM0pDDdk1EYRX/oQV2NqZEL1rKy3oXKAHYyCGTdkn65Ie8Q/qxiQ4HiUsWgXFpsDs4vR1isqIc7NF3kndLyLzfwgIshowb6T44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757938859; c=relaxed/simple;
	bh=SxvSC75+ai5wusFs+sP+EiB6Yy9GbCpqBh03EztSLnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CYVxH1T4dhA1OJkFEvRrqdPgInEWEq/0XvAunP5RHGAuqKenXuz0tCtLoXaohPyY8+TmNG2mOBZg7XJkaefOv2j5/xEDD9djySrdbhELCrosAXWp8MfSE6cWVOIWuM641+DfO/tPsRRVO8XhXEXa6dCqEtS75sltu62tbGN0sqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=J9Ek2QUW; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-353dece5805so15064501fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 05:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757938855; x=1758543655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxvSC75+ai5wusFs+sP+EiB6Yy9GbCpqBh03EztSLnM=;
        b=J9Ek2QUW6tDBZIHRKFNeWWaaRM6hgO8mMAKEEFw6P4yjmgP0rhP9ERsqisZpSZB2vJ
         4cFYptTHG8jZA4+UkWkyu7uoSiGF0XyQ20qOFH4QX5jhzdtU8lO+Oqc8/bNq3KKDhk9U
         WNT9++r5sHILcRd74E6oK1G7fC5xw2Ozcumli4zpO1pEEDXx3fKl2+0v7XmcsMvd/98O
         CmP5axfCTyiCPdmyALQTavqD18NsYmdxN+84s1Vn2OvhC8N9KBNJL09yFCVy9W/jpzO5
         8bbRgxzkE8nDU8tOqYfpXNzVjpGxAnNqYhGs+dh+GIn6uGY6zi9Cx+IV7ZkRQcYDoS5/
         YjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757938855; x=1758543655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SxvSC75+ai5wusFs+sP+EiB6Yy9GbCpqBh03EztSLnM=;
        b=LGTuKOgPUy51UcdDrgW0KCiKTPjaEvDVt+h7TpxmF8vqzAKYjg88SV44XNqKz+yKD+
         RbM08tMpii4mwubxQENPVv5w3jtFlakjqQnBsmj1awlvc1UxuzBlrNxaJVGW8Kazlxt3
         7PiEf7/7ktOJveqOpD0nRPX7FSaT6QrYBpuTvAVf15xxjQlbJd+aTq+vTlTG5MzJzFP8
         bZ5py1YkRe8BvDHeV1rVauwBqVA0TAy2Vxx+IucOVUnUMs2+NHqSn9h/E6ONpCeDfm55
         UE1mkDkb63W8Ce3S3RSOV5N+Ne6Bz7H0cgaRkWg2xTdypfUvWXGm7qLJlZV0PXcV2377
         YJaQ==
X-Gm-Message-State: AOJu0YwF1ZhjjlC5UW94GC6uyH5hQHnWHvij3Gs/+gehRyLz0BXwAE2d
	bH4Ud/IVi5oqQHWyjZuGljzocmIrDnatuk+wC8a6UXhqjAXiX6Uzq1/F0m6J2cNigUF46zqEI4f
	za+rWGqJafJQW0eF16LAdHdpygkaUzxUV/exshAkdsg==
X-Gm-Gg: ASbGncsCR6QgG96xuE2ZPW0C5PMxU6WYDAzjxeEpjHaIS0BdWI/NxH+PY4humk1Brnv
	SvdGOWCBglW93/c2jMiWULii0/0UHvk2BPuy6SM3erNpVw5ZAbay1ZkHwLKxhj59WC6dmhNLpks
	08ft8mvJspC3gHCmZQ2P7bMCecVZvCjC2YGtfSJfJ6g+TfxuWpkHfAZbjO/arL441mHmWfhPgV2
	rWJ3WygogZH+DxBkgD+SyEav7wvya7L8BmTWXja0eicyStsGj160grQgr9T1g==
X-Google-Smtp-Source: AGHT+IEmnxbeEtgOtDLw2NgOQcwtopUOpi5G2yCRmnyfo2ld0ixRQb3kYGv6XZEeEeUDrjZjp8OP35TG4vLNeTrCZVw=
X-Received: by 2002:a05:651c:4355:10b0:338:53d:3517 with SMTP id
 38308e7fff4ca-35140da7e0bmr36430511fa.33.1757938855373; Mon, 15 Sep 2025
 05:20:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905090214.102375-1-marco.crivellari@suse.com> <20250915-abgearbeitet-servolenkung-d0c60406b94e@brauner>
In-Reply-To: <20250915-abgearbeitet-servolenkung-d0c60406b94e@brauner>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Mon, 15 Sep 2025 14:20:44 +0200
X-Gm-Features: AS18NWAvbZYrgBGn8tKMf_pIKrTNfuKWU5DLdSvRtq1XfhAg-6v3KzP7FlMTOHo
Message-ID: <CAAofZF7XWnN1Ozx8LLFtnnsNs=8WV7KZ4vFahK_KoHsVMredbw@mail.gmail.com>
Subject: Re: [PATCH 0/3] fs: replace wq users and add WQ_PERCPU to
 alloc_workqueue() users
To: Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 1:50=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> What is this based on? This doesn't apply to any v6.17-rc* tag so I
> can't merge it.

Sorry Christian, it is still based on an older version. I will rebase
and repost.

Thanks!
--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

marco.crivellari@suse.com

