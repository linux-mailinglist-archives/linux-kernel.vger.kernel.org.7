Return-Path: <linux-kernel+bounces-808502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9EFB5009C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05A9E1C631A2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FF634F465;
	Tue,  9 Sep 2025 15:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E68h6YW7"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DB9322DBD
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757430223; cv=none; b=XbfLLCmSGU3GfcXw6/x7l6AxsMMB4C7nxuNC/m7IjdljmSB//oHzhouu6tKXhjUYNS/TepALvtj/U4qnW24T830bcQIbIH5UwVGSRr7d4jcKGLw4AGOMEq8GBO5cv6nMcdOuJYy87eRLWtHvPnIwmYuK1kD31f95I5I7pR20A7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757430223; c=relaxed/simple;
	bh=s2eOuFXnk4JEiosXfEmmNMiAHYoyrWK0QGfId2hIEv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l8YkLH8OqOlNHlmu7oRc+dbRnInrsaE9krODIW8J+Mn5LaD6cvNd+cyEeFA9Gvdh41lPoL+X5eqzM/ePILKHNOGJfthZYqrcWL2DpfJQVtUv3Y3ZqAzzuSpzuJtM8FgMUYRktkPRfhuka/40vdQAqQbYhg6NWRgWVD3ISKKDyvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E68h6YW7; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-56088927dcbso7071501e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 08:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757430219; x=1758035019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2eOuFXnk4JEiosXfEmmNMiAHYoyrWK0QGfId2hIEv0=;
        b=E68h6YW7+KTZBCHDJqe2/6a1rAOw+MsGwXSE1sYM8xX9vNA0ZndSQPZgxgYLDW1YPb
         yi51Y8MxmLHY1W5EGii7BxNhm0Fj9GUPZZfjEyHmodOR0hIhGKYdl7SGWjzWwI1uRWjz
         MAwzwhPjUKR1YmhVZ1wjysWkHy5ngeP5DIuAoqpu5h/KDvI9jBt9mHSmxT2AMXP7z5nh
         KUPIZ5AfcQr/oBlx8cR0n6a7H0fGSnoXejteuU8Xa0LrBWsNbvVx5+kVknna5A6RcgBu
         hLNoYIrrd8gsNNduAXaRTQaR7MK+Aot9tHmUYqP7XNs6Tnogi4Lnx8CZxJEMMkm0Ligy
         txTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757430219; x=1758035019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s2eOuFXnk4JEiosXfEmmNMiAHYoyrWK0QGfId2hIEv0=;
        b=vDbSBjAohyMT0LpEv3yzGTrYWfQojqqFENZWkP0LAe0ODGTagWDCc5StywkRsl4dXK
         ZOD/t9LNmkiQFKVhMfiClXSMr0gpMp+GlH4F66I2S/rKO88v3YV/NTaoWumdN4FDulA6
         Dbpqlo93hYOXTeKG3jHHNWzZwgKUyUegu4LjQgiXBTc3ZFvApf2I+S2xSnWke3z5Woff
         UIDIJBNGClTspB275a4y3bYOE+sNonIU+VUUaw3BW9b6nbl2fmkysKvECIFWuqv+Ai+4
         NOc/+GTvq0L/2Ade757ZF2787X5hzcdUbSXQA4QwA8vCmipq5YVFUXywPfzfhdwKeJAZ
         q6GQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIhQBPZYRqJk5Y9kPPj/2N4+kCm1MIX5JAaOT2GaJnliv/NEuzgIKc80oek8OXxu/Eh1ycqBM0vT6t2Wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YytudixiWnwvkM4VTPGuoQhasWwGoCgxOfuJ/mdtlFUHHOk5Hpe
	fBi2bxu7GKmiZIJlsBn5oCzxZ3lUCColoEi6LgbrCzywxEtcG5N17/ReVrmkkf5OEreeM4kOMfy
	XdaBBtNeKk0wCSjWeP0eZNc3kCL5YHBQwyv3c4cwoZg==
X-Gm-Gg: ASbGncsp4M3lolWTxDP/0Zv8RnwQfAEQs5/KevwfSN+dSaPLbFeWTmyXh2bH4Zvc6gg
	6tVr+fmt9YN+A0p0yJtpL4tB3Ome6z7pUW+3DNvlILvwySIiNKpHPrDjAN1fLSMaTLMkc9Pda89
	VVPS7k7AlZ8kj/u2fTL276GYuGVCy6YDtMxD0pS0Mio+0hvfQS6/vFTJ9BsJZYYP+a8QB74Qlpp
	2Bi7g96/HRjjrwlarX6PRYP1k81wRLI0kSAvwzRzatjpHijkHY=
X-Google-Smtp-Source: AGHT+IFtHjCXW/IC9j6GEwjcF/4gyccj2LPR8G94RV0BH7HbnXztEbz95W8S/ObWmv6rhWZ8btdWEU414oiNIQRprWI=
X-Received: by 2002:a05:651c:b12:b0:336:dd88:69e0 with SMTP id
 38308e7fff4ca-33b57c39f8cmr33976541fa.29.1757430217780; Tue, 09 Sep 2025
 08:03:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905090130.101724-1-marco.crivellari@suse.com>
 <20250905090130.101724-2-marco.crivellari@suse.com> <3e007a66-419d-4933-942e-4e5cdfb06887@suse.com>
In-Reply-To: <3e007a66-419d-4933-942e-4e5cdfb06887@suse.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 9 Sep 2025 17:03:26 +0200
X-Gm-Features: Ac12FXwvtgAzWLuGL3iHfQ_lIqD5ZbleIVuFHOnTDiKTdfJQEhR8WxsPlf8W5bM
Message-ID: <CAAofZF5rA1VKDDNUYrxu=i6i81iLBa0GNOUCrQbUMAjZxrxmiA@mail.gmail.com>
Subject: Re: [PATCH 1/1] module: replace use of system_wq with system_percpu_wq
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 12:37=E2=80=AFPM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:

Hi Petr,

> If I understand the cover letter and its linked discussion correctly,
> the aim is to eventually move users to unbound workqueues unless they
> really need to use per-CPU workqueues.

Yes, correct. This first round is just a 1:1 conversion keeping the
old behavior.
But later yes, the aim is to let per-cpu just who needs to be per-cpu.

> The two work items queued by the dups.c code can run anywhere. I don't
> see a reason why they need to be bound to a specific CPU.

> If it helps, I believe you can already update this code to use the new
> system_dfl_wq.

Cool, I will send the v2 converting directly from system_wq to system_dfl_w=
q.

Thank you!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

marco.crivellari@suse.com

