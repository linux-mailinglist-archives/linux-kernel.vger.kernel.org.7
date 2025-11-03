Return-Path: <linux-kernel+bounces-882662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 85804C2B158
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 11:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C91CB4EF1B8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 10:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9392FD7B3;
	Mon,  3 Nov 2025 10:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AmSld5lU"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D622FDC38
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 10:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762165906; cv=none; b=joCGUl3AG9J07VuJpN7ZWF7BJAjICIxwSp/ait2F4vPUiDZBOb8PmCy2h2+YLQThJomuVayl9ZlB/95/vqMoE3kYSqSoGVMTUPqp6GDUjY1jK1gJJa6WIxyOK6p8uARzcIYk3XzUrrbxLGXajcCYRs9vaMxLUpWTibUOz0QgY6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762165906; c=relaxed/simple;
	bh=FoPFhQQS89S0PG9IrFQ4Ih5iU0Zai424+/DcdPiuCSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ixMVh65qTMIG3vDV5Q1Ku2KYPaaxgHs/VWjaPJyu+Q+7MqnOAozcozZehWdnqTSj/sMrMpNYqfr035OTwqoWU+AQp9ivb6xGPIQCreslr5QepWQT+KuQfL9RkX4slg/XPst36nnxhy+dUjl3B71e1PTK+HPLwxq9ye15Ti+RLTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AmSld5lU; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-592f22b1e49so3909603e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 02:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762165902; x=1762770702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FoPFhQQS89S0PG9IrFQ4Ih5iU0Zai424+/DcdPiuCSc=;
        b=AmSld5lUdMJTl9VBoMygzhFc9aPAAhxxQK5xz+vplGMIgUnBdJERC22owsCmwqii8K
         0sEfSi0L/ZC4MgufMWhOlOfjWGN30P1d0txHVSk1BWZeYCcq0Otrq1YmqslyoJXxfEdf
         DmpHpdoTUqfbLYw/vJ5AhsNHgOxHin2i0eH+TkQbZed3j+Qkopqznm6t9FgL8xgY9KrQ
         TH2/Cr+raN7mJB07lMdw3PuF7gqWJWH1AQsdnM7V7c7UzBjhHrI8xaAoqy5COgf45IOt
         bgp4Q4GmW6KmhtE1lHrmTdiwZSRmAbzD7rmnR4QjX01D+mFevq7EKaxN5kbeMUSUEJVM
         6Mjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762165902; x=1762770702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FoPFhQQS89S0PG9IrFQ4Ih5iU0Zai424+/DcdPiuCSc=;
        b=AK7+yqyooZThA74hNuWmFfln5S+iAascv8Wp917beS3oLArB82IEWwny12ShqWQlLe
         3mLkSoRcHChSuSR9IDEA/kuEmGBpEPzPUXf/2uyCdh1ifrLVLK8pY8VC4oyAkvMZw0Xx
         5JwZJICZJxi4qVgy9Yr6ZSpq1Qn2v5bQPs3OxBQsWFgRveBfqi55YhHVtxJI0NXIig8O
         2NV+0mtVYnXhO5cZ7iMjQjIKfkIVLL0rPkyPSJb6QSG1XePmLMAx+wTWiGcJzCY1fGbv
         8MlZj4rYp2uZnrREQamrg7WwCEspNmz2svx074YfCUciQ4+PguZA3B0Rhv/7hNHDrd4Q
         2B4Q==
X-Gm-Message-State: AOJu0YwOSwj9ZAnc+Gy+5CRmP2GkuKuoSX9TPVAjcEBkOx2J7bAX98AM
	qYDaDtHe8qgyVoxXtmU0Vjx1LsdOf+a3SE/LnNnbOXMP870jooHkgsxxLbBisTVx+ujqjj6ZKAV
	4qDx85Fy5SOzOrutG2/43hpk4+rfKkP8oB0S4ANEoFA==
X-Gm-Gg: ASbGncu+aWFHpJqsH06F+CNlWDWHAZ7ze3Z36UQ78gsUQsBp8pC7wKO/yoQqtUBe/QZ
	qeTiOynHMD1HFOwP5WtygfxKwJxYtO82Oa7EeZJCjqPbgmvP11s2kE71GIKmqmkTDlGO2SkcO3o
	v0L58TIgMpo37lu5TGUdRzDwLr2XMcy9JzuoOmqIGLDLoEGrb01S67DwCV778g9XrGcEuIvn4Xp
	zwm5cb4WGxi4YRdBKnMncvQJ7Jvv01zJvIHI7COebozRaJ0eAaddhTPdITPnDBamW7/gzyaoH7k
	n4RbtsJ0Di9Oogwq7f1Uz71nk9b+
X-Google-Smtp-Source: AGHT+IEwAU4SOZwUJVarSaQslcnJLXDLRhKZeIYvNp3qfEofTMUe8ZL6Dwbf77J+nSRDOQjf4bHs+Hk1B3ORqp9w7+c=
X-Received: by 2002:a05:6512:3b9f:b0:594:2f46:3906 with SMTP id
 2adb3069b0e04-5942f463d1amr413899e87.42.1762165902161; Mon, 03 Nov 2025
 02:31:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031100923.85721-1-marco.crivellari@suse.com>
 <20251031100923.85721-2-marco.crivellari@suse.com> <zduzgow2hyvxfzmrhqansber4eeg63av6i533oihvx4ubxdqaz@wu64gw66b4jt>
In-Reply-To: <zduzgow2hyvxfzmrhqansber4eeg63av6i533oihvx4ubxdqaz@wu64gw66b4jt>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Mon, 3 Nov 2025 11:31:31 +0100
X-Gm-Features: AWmQ_bkkbh1PZ_mUlCEwcGKqGMRPmj0_7LacVUfhPhRpCu1buDmddrltRgzVqeM
Message-ID: <CAAofZF6EE=grXh8mowNRDcDkL8RwwrvGhawcjGqcEhn5M4M6zQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/i915: replace use of system_unbound_wq with system_dfl_wq
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Mon, Nov 3, 2025 at 11:19=E2=80=AFAM Krzysztof Karas
<krzysztof.karas@intel.com> wrote:
>
> Hi Marco,
> [...]
> This commit message is very similar to your previous change:
> 128ea9f6ccfb6960293ae4212f4f97165e42222d - did you do that
> intentionally or is this a copy-paste mistake? This is also
> prevalent in other two patches, so I am curious.

Yes it is intentional. Well, the idea was to give a bit of the context
about the rename of the workqueues, sharing more details in the
cover letter (where is present also the commit hash you shared).

Sorry if this created confusion.

> >
> > Adding system_dfl_wq to encourage its use when unbound work should be u=
sed.
> Please remove this sentence, because this has already been done.
>

Sure, that was not intentional (copy and paste mistake).

Thank you!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

