Return-Path: <linux-kernel+bounces-886985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D46C36F5D
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B68604FF676
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED79E34F25C;
	Wed,  5 Nov 2025 16:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H45R/jf8"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A8833FE20
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762361764; cv=none; b=RmVWGJ4sBp05rRwOph9hEo7CvLwMr3RvgY83TF9kOYQI/q1CLqnCGVOEzd9NCeEhyu7+ArXzbb7C9EoF107hvxPZwJtUEWD4MTjHKv4Ek6hB/6Q1CDSWLsP49fYGDMebjhgDgH38p+YXVeZK2mVzZiDSRJfy70tZxziQzGEbBhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762361764; c=relaxed/simple;
	bh=kVWi8GxnKucgFki130G61MrbSViUM5WNdG0BJHHZ1qg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IArCaqh4GA33IA1WLy1elWKUJXFn6kyR06f+BZaN4T6DGcjoOzhF5DOLpIGd4WBeEKIm/UTafJHRW86NMe+NHgeZ5HouS6kV/1SqpDG7XbdslQKlgTF0bO9rwZjJtMbutyDOtkg5sSB5CNOaKIfAyyqxTkk5jPQq+xMc/bjP7ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=H45R/jf8; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-594330147efso9671e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 08:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762361760; x=1762966560; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mu3iCcRyO4MEYUoGPnPQxRoQuwG564a8TEJNky+SL5E=;
        b=H45R/jf8Vcf1faTQvglEW8cOHmPugT33sryAzlfGv2Pt805RaXVaVmX+luY/7JXvbC
         pW9n+wxdcsNO7Rt0QV8NUl2A70BvBPO1CAHTWSiwtR3qdm2Kq4OaMmrh0wFDhSFvhzvK
         J2yisg3aXQYGZchKXwWfVhjFRbHFwCkR4nKxMXFD6eaoLKlbmS0u9psEMz/DO4ZWHBsp
         tqT+TYdGJXTiyDnaaQcyA5LYI6QEQqc7iCfgyP8C+N6KnzFfx/l5lIzkEcjidfWqm5Ee
         1usJQpR8HYNuE2c4RGLeuQvX707SY7qLEn4/8V6RJ8rJc60vagRlNi8MhARPYxPY+xdT
         hVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762361760; x=1762966560;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mu3iCcRyO4MEYUoGPnPQxRoQuwG564a8TEJNky+SL5E=;
        b=hhDGXPW9Pu5ipKYEeNVYk6xr874VDzrQ6/wB/oAvhAFTnMpYSPG5llYbMOHJqq6C0C
         ukGt5EK+MrM2RdXCCrdqgQ8zAQApN1cjR0Bqg90fICtodQ8FhN9edpbafz0NeY6jlHA3
         8+XM3G8xj+OJz+Vn0FT11ExvlTMlmzWKXyKpaTlFxX3YXtD2/eUX6yriHHzE7v1ki8Z0
         I0k4jW1/fKH/9GgwOqGmG4wKpOzALjMzogPk4ePRg/NAve4l1FgEamtwwn60Vt08Vo1S
         LkZw170eUxtOdk9nX9Ef1dvp5q508R2uJUwJhDav0rF0Zd/vXlu8y4O25IfpV05tKt5c
         YdqQ==
X-Gm-Message-State: AOJu0Yzq0vqR21I0amQeqoTmAm8zoMGSzMyJEDXQNgvH/GFRwV8adJ/y
	ZR1+gzEHG1HQpQIpSriWg5joEKQU9LO756oIi3xqPNML/aStACxBrwfEYjxRXtFH51wgHuzbBt2
	QlMcz/CrJEwNrU20sLZtyH6SV4+IAz0WxyDtD+uZksg==
X-Gm-Gg: ASbGncsWp0POM7rfulR+gbgFizT1a0OQaVeAFrAMP4OxKPjpOB7/pV0vkW60RDxZNQf
	DT2iwV2vLJXFUHzD+pp3siJfZWHnONa9S3qLbbnDp5QnMewaQ6RNx6LD+vm0cwa8Mh87iuv6YKK
	BZ1G1eP8EV/DULYUsPtrHSI2s3lFyjbfOrpneqYmm4YYGOOqQQfQ4QgpxnE6476/hBKlKF+AV0z
	vVOlHzMLoZPfnOd6Eb0vvYVNST1BDFk51Do1xwzyjhIDLPqkLtaS39qQK/emgRBYPAA7RhBQW0I
	X9ETnmYdD1G1Om/cICwZM4nPYfsJ
X-Google-Smtp-Source: AGHT+IFz+1Gy6h+Xew8BuT3iEzfYRkMwKM5RzviXIBrULzVANbhzC4SaeUAAuRf0icL5+lbsY/ZapaIFTCdyX5G6B/0=
X-Received: by 2002:ac2:4c49:0:b0:592:f7cf:9f6f with SMTP id
 2adb3069b0e04-5943d5642camr1272844e87.14.1762361760364; Wed, 05 Nov 2025
 08:56:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105160819.302988-1-marco.crivellari@suse.com> <20251105162932.GAaQt7bON4FtSmxQ3Z@fat_crate.local>
In-Reply-To: <20251105162932.GAaQt7bON4FtSmxQ3Z@fat_crate.local>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 5 Nov 2025 17:55:49 +0100
X-Gm-Features: AWmQ_bniiZGELB4ofmitO9AqJwgDRZXbsfcGSPurKdMDAfg0lzfQJrcg_6W0nRE
Message-ID: <CAAofZF4fBbFtiKxde2M2ikK4k-LqYVRoavPbNVh-XFiQPmfGvw@mail.gmail.com>
Subject: Re: [PATCH] RAS/CEC: replace use of system_wq with system_percpu_wq
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

Many thanks for all the information. I've already changed the commit
log for the v2.

> > with the change introducing new workqueues and a new alloc_workqueue flag:
> >
> > commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
> > commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
> >
> > Replace system_wq with system_percpu_wq, keeping the old behavior.
>
> What is the new behavior?
>
> Should this driver be converted to it?

The code is using system_wq, this is the per-cpu workqueue. This
change will only
replace system_wq with system_percpu_wq. So the behavior is the same as before.

Thanks!

-- 

Marco Crivellari

L3 Support Engineer, Technology & Product

