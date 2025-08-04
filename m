Return-Path: <linux-kernel+bounces-755604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFD9B1A913
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 20:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55BDE18917E0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 18:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E38F244EA0;
	Mon,  4 Aug 2025 18:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E61M0me9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5429217F33
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 18:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754331520; cv=none; b=WH4SO3zReFr77sZWZJH3YuCRkkG/7O4ga52nYuOAOse1ismiwRUxcfzIwy03JdsGsp7a2lu9JSXrYAtFKr+IvjQpRABaVfpL4Wq1uDArds3bS2w/b8qVMOmNbFpEJ8GUPHh5qr6WYYHiJamJ2k/s2h6XNiplvLefGVSguTC25p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754331520; c=relaxed/simple;
	bh=sJmIS+4VMfjqdG20GuSrtYDj9UHHKpW7QBhkO353ZHU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k9lHoY7lJcLwSb822tUi1Ci9b4YEqkZRyvL1vt7ly8Xiu9K7iZM+GI8m+6pYwd28Bw3ykfCI242rwLhAn+J9rs/8Jxr4d2KPc8oPan9T4ElPAsZEkgZF6VXK+tD9IlRx+F2Z8AxQkfAhcrbDwXk+mud6f4jndTGI0R1rGTzAWYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E61M0me9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754331517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qPFuA3XT5rZs0YkAQkaYeJ3lMViwpDLOl0oehXQ14cg=;
	b=E61M0me9DtxW/czm6XIM2FssAVMmbq1EQJdXYqpkCBuVnAxV1dR/NGhTaQ6WCorzJRL7mx
	V85wogt7NohbF9ZGNQjAAHf9d3y7wrFG67EKeQFEMLAIZe7gfjQNlOjdCtytWXl0W7v/Jt
	tbQo/INVrqqZGv4y+uf1mtkjhY8NSBQ=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-2apXaeYxMsOwKH5sXTUa0w-1; Mon, 04 Aug 2025 14:18:36 -0400
X-MC-Unique: 2apXaeYxMsOwKH5sXTUa0w-1
X-Mimecast-MFC-AGG-ID: 2apXaeYxMsOwKH5sXTUa0w_1754331515
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-87c13b0a7beso415294439f.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 11:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754331515; x=1754936315;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qPFuA3XT5rZs0YkAQkaYeJ3lMViwpDLOl0oehXQ14cg=;
        b=rJzarMl45Qdev4+hJehOZUjKHmqHKtgTYk1shgknWpEYx5XNIy2xKOaeZy2Vo64amP
         2TvI3NARP6jWo50UnCRw3OcVuJr2fW0bboZBOEMxbSS/UX8OXXaU5pabXSWWimDOCtyC
         sCZbH/yLaaiUkapuk0BjQlTlKZQemWwRiDriRA8tk8wM8tWUDh3WNcKS4wl4d2yLzMg/
         vzUfKtb28tCca/uAuXQPmt4ERF3sbXW3qTHPp4xOJzg5gkAlUuWmkRs3vzEi5XUjXmXk
         I4I9KoDUPr4cexuyITUKDBniPdiqRbuuW0ff+lUKxpVwizUu812t13FqDsQH+24Czl3x
         wEmA==
X-Forwarded-Encrypted: i=1; AJvYcCU3I96Nlk5CyJTvcQdu7ShCs1ptz/R6HkO8hqldeA53eokm0UKpgR6ZFFEYcU3U1XPgNAmMPBA7Nm91lkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzckQJGHeiz6yxORx0ADYRhZAf44GoTobmr2o9oVld2h1aFTotB
	+IYDGYTT5ze9KZZPSGEFx5TLjiiVPCKlTjqn0MpIfGiKFW9AKeC21p8tnpnxKD1KgTQbeYhjXJi
	TnzW6rGhLPSkFRu0rTP0X5elvbSoseoHb1ZHQ9cQ++AYYASFHVnzpIcdOWJmFtDJLxA==
X-Gm-Gg: ASbGncu/GkfXtS5gPqk4FLmQOB0WaL4TWnjjtWdHJ7AOe+UNiYlgB9KDuRGGNNwGtXZ
	DCt/6fZUFycgHvWW19t7HxccixQMz2mQbgZKOnguJMNzjxCH34IKaBKDCk3/l7JTFpAe/DW5P8N
	/bN9xwrSr5O0TRtHH5gkjQD3068Qez6sCr+dV+8lB3KB1QLEVyva4n7Aj+UqtXgD0BXu2z6GP9x
	diJqlMaVXZA1C3tah4gLtzP0YeF7cHcpdffg9eixIO+jV0KDT4dAXEgseGq5wYQi/CgrDldSuWl
	Jp/YYGv8jWHhqBkwgFXWFbk5DUR0KpSz1h7283Ui/CvbtCZoeIqaJs0yOVEpVFzFuSPb
X-Received: by 2002:a05:6602:2cd5:b0:87c:2f66:70f9 with SMTP id ca18e2360f4ac-8816824b198mr1908989539f.0.1754331515392;
        Mon, 04 Aug 2025 11:18:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRY7UzzPxt1OP5gyqT0uCW4Gog0m9+ZLLEFgonjkQDZIWdxputL/74lAccIGpspoDTOpfy5Q==
X-Received: by 2002:a05:6602:2cd5:b0:87c:2f66:70f9 with SMTP id ca18e2360f4ac-8816824b198mr1908985239f.0.1754331514891;
        Mon, 04 Aug 2025 11:18:34 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([50.145.183.242])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-88187f182a7sm60068839f.6.2025.08.04.11.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 11:18:34 -0700 (PDT)
Message-ID: <0faa958ef9cc4b834a5ecdc92acd89520f522d44.camel@redhat.com>
Subject: Re: [PATCH v2] tools/rtla: Consolidate common parameters into
 shared structure
From: Crystal Wood <crwood@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>, Steven Rostedt
	 <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, John Kacur
	 <jkacur@redhat.com>, Eder Zulian <ezulian@redhat.com>, Dan Carpenter
	 <dan.carpenter@linaro.org>, Jan Stancek <jstancek@redhat.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Date: Mon, 04 Aug 2025 13:18:33 -0500
In-Reply-To: <20250726072455.289445-1-costa.shul@redhat.com>
References: <20250726072455.289445-1-costa.shul@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-07-26 at 10:24 +0300, Costa Shulyupin wrote:
> timerlat_params and osnoise_params structures contain 15 identical
> fields.
>=20
> Introduce a common_params structure and move those fields into it to
> eliminate the code duplication and improve maintainability.
>=20
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

FWIW I have a bigger consolidation patchset in the works, that merges a
lot of the codepaths as well as having everything use osnoise_params
(with some members being tool-specific, indicated by comments).  If you
want, I could rebase that on this and use container_of() to for tool-
specific params... but then that adds complexity with the top and hist-
specific params, most of which are common between timerlat and osnoise
(and not merged by this patch).  So we might want to just keep it simple
with one big struct.

Any thoughts?

> diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/util=
s.h
> index a2a6f89f342d..4c99a3746380 100644
> --- a/tools/tracing/rtla/src/utils.h
> +++ b/tools/tracing/rtla/src/utils.h
> @@ -59,6 +59,32 @@ struct sched_attr {
>  };
>  #endif /* SCHED_ATTR_SIZE_VER0 */
> =20
> +/*
> + * common_params - Parameters shared between timerlat_params and osnoise=
_params
> + */
> +struct common_params {

I'm not sure that util.h makes sense for this... it's pretty core rtla
stuff rather than helper utilities.  I'd just put it in osnoise.h (or a
new common.h if we want to keep the actual-osnoise-tracer stuff
separate, though currently it's a jumble).

Do we have any naming conventions for the actual osnoise tracer as
opposed to the broader osnoise family?  I don't know if it's likely
we'll ever try to put something outside the osnoise family to rtla, but
if we do "common" could be a bit too generic.  Not sure if that's worth
worrying about at this point.  Certainly better than using "osnoise" for
both without clarifying.

-Crystal


