Return-Path: <linux-kernel+bounces-810380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEF8B5197C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09643562494
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A54324B3F;
	Wed, 10 Sep 2025 14:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gh8F1JcA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A6B31A540
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 14:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757514922; cv=none; b=hd2zzAAOWUjzdkcMlyc5aLZ0y1wZxtKgzHvp4mOs0Tu5exYsoMXPb70mAeq1etYfK5yadKCriJU+WqrItS4JwPowdUZCKIM3rPg1fSsHHNwpmOpgTOQhv1XGQFhFANHEGP3IOFYQJCKiAcnHp5+CNW27OfDjJs1swSSRptubDMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757514922; c=relaxed/simple;
	bh=bGrHqAtFIZ9PobogV26gtfRtq5209m7wPRe6KlO+bNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QJzAR2U8pJBVF9X37GrJ/QaQ5zBlj027MKio3CUQnJ3PV1MezUmgKJ6zeHJyS2QY0RC6yDdFj4A9zL0FImCVUENZseISOmi/k4+/dzH5TMzpmNh4HQ0+Tf2T9NORA2T3yf9QKJTnuJT3kSztklCvH06VS3mjhLN/SByr02zdMGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gh8F1JcA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757514919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bGrHqAtFIZ9PobogV26gtfRtq5209m7wPRe6KlO+bNM=;
	b=Gh8F1JcAqjAqHbjtwTGZ3htJtriUmPOnUQhlrRaVo6lHMAaFCbeeXIl8Bc1GCJifSteA+x
	MV3wAQq6UvSlcrtvLqsTWhO7vGujKP/SOnmoDVJcBsjx17HvaddspkOX4q6D/UFJ4Yteij
	biwnAd4uTK5iHmElIYxF+MmOAzntOn4=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-ZG-noC6CMfaN-SWCw63nWQ-1; Wed, 10 Sep 2025 10:35:18 -0400
X-MC-Unique: ZG-noC6CMfaN-SWCw63nWQ-1
X-Mimecast-MFC-AGG-ID: ZG-noC6CMfaN-SWCw63nWQ_1757514917
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-336de88c3caso32780201fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 07:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757514916; x=1758119716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bGrHqAtFIZ9PobogV26gtfRtq5209m7wPRe6KlO+bNM=;
        b=C9z8h/ytJp5m1COMeC+0+7QxODDo3gTc0XGqw+crMMBPzB7ACmW0BSQHNBUMQ6djtU
         rFZ2sZwTFOZ305UAs6RW5j0Ig/ajVR5T/bajxI3xojRTqFLoQBKxDFtE7znU8pX/NdOE
         Il2DpVm66xuZ5hICkr5PYuekaBl6JcB6cjj1AsK/g4CLhk1YUJ9L/63HUk0JSGImoiNl
         ipDl68GZRQXMEtCkLQHJX3S1MZCyNmAvI51lslXR+STzfO3lTJYygtRJLboPEbozSi24
         H9TSVfiBrKJvqni0KcwNZBwEiXvISabnW2Hjjy6wljfI+I3yib3UH/BZpopnuwTD3Gtd
         dNgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoHNwqsMktSBJMJFkA3xP4q5R12dCE9PXADlWyFOxIfOzNT1iBcNAf8csEasoUfVxuauZlKERXYaizSSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YylfbSfCqSE6uItAubT8lE48DynXkKOaWM03jPy4aYJ7Xt04M9d
	66jOqHa1cRtp+HkvPap1Wrmj3Iez122bhNWnP7UtgyNq2RXHJckNoC9mW+RAZCPj+Zsnxnebi5m
	MC+n6Aloa4PbRDFeWtDt+8O1khNQBSUNJvYgnK+JyYtq4fshl3WDut0F6VpZFrDDc6TM2uopJtR
	jQIm9OlWgFMCZlu7oKgkwETVoaiNIcE3BW0xe7o388
X-Gm-Gg: ASbGncvmyDtn7z1sO8i9gUOcB1p5ZWaa5QhLQFUeetifMAzqk1BI0PxU3RlrppcOZaG
	WZBZZbaHlQ632L+0Z/uKVNelEH1Nb/J6bkPc6ZzhnGtxZwpXTQBqt4L0wB5n6z2AojAIms8zFki
	Pl0Rh4q2uhkM8msb3yEeQLhePIQj4ag9iJyMo5e9AI/OKJW0/jgOf608U=
X-Received: by 2002:a05:651c:235a:20b0:337:e190:67e8 with SMTP id 38308e7fff4ca-33b526a8672mr47569561fa.23.1757514916104;
        Wed, 10 Sep 2025 07:35:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFH7eWZjUBsfDd6LKUZyXVK8DJBE+wewqWGxgYKfpGetbusEo4jwvMp0a/3xoieBGqQifIyJ0s5sHvaSXMyDvQ=
X-Received: by 2002:a05:651c:235a:20b0:337:e190:67e8 with SMTP id
 38308e7fff4ca-33b526a8672mr47569461fa.23.1757514915615; Wed, 10 Sep 2025
 07:35:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905160552.496879-1-alessio.attilio.dev@gmail.com> <20250906125451.19206-1-alessio.attilio.dev@gmail.com>
In-Reply-To: <20250906125451.19206-1-alessio.attilio.dev@gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Wed, 10 Sep 2025 10:35:02 -0400
X-Gm-Features: Ac12FXztMIDHN39jtaeHf2pZjdOABVhwIXZKxHpTYrE7F4pxvu61WHLDmeX66QI
Message-ID: <CAK-6q+juz=VMTGkaWJKuQn=-OV4ug3j5q1YvuxK9JuZZ4SkVYw@mail.gmail.com>
Subject: Re: [PATCH] fix: delete del_proc_lock
To: Alessio Attilio <alessio.attilio.dev@gmail.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, teigland@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Sep 6, 2025 at 8:55=E2=80=AFAM Alessio Attilio
<alessio.attilio.dev@gmail.com> wrote:
>
> The del_proc_lock function was originally retained for testing purposes d=
uring development of the Distributed Lock Manager (DLM).
> With testing now complete and the function no longer serving a runtime ro=
le, it is safe to remove.
>
> Reason for Removal: The function is unused in production code and was onl=
y kept temporarily for debugging and validation.
> Its presence is no longer necessary and may cause confusion or clutter.

I don't know why you come to this conclusion, the function is not in
use anymore because your previous patch [0] removes the usage of it.
Then the kernel test robot complained about it and this patch came.
You need to respin the patch [0] (preferably marked as PATCHv2) with
the additional changes to make the kernel test robot happy.

I still wait for a reproducer for this issue to get more details about
what the actual problem is and its still present in upstream DLM.

- Alex

[0] https://lore.kernel.org/gfs2/202509061809.348XSVqi-lkp@intel.com/T/#mb7=
9fb269cac0ef77e047b6edde162c67c6267f45


