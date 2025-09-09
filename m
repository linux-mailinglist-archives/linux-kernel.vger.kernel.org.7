Return-Path: <linux-kernel+bounces-807871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44330B4AA9B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3188C3408E8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D3D2D23A9;
	Tue,  9 Sep 2025 10:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dXVPMuQY"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AF9307ADA
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 10:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757413599; cv=none; b=aUHBh81duZcqMVyJ2T65Vo2DoEc0EH3ojQPn4sl841uB1THfcS5T0MBykxLRn6TaWsewr1QUfe5htRgd/BroRbnyfY6D8S3LjgZJQ4Ke1Lomf4252V3/muN4CyNdL9mz/qdjRX7w8wo5WGuCYC+Vc1VzXokAu2pkbdSmGoiGD4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757413599; c=relaxed/simple;
	bh=K6u0fUFF//SvAFGmtzWkez3KolPH7k/HuAtkFfvBTUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ub5U3+zSlE1w1ibqgWZ4h5BxwaS8lAA7uHNSsIpSeYIMINKm2DMd16OsZSVYIlk/CzW9pM1OmsldgkXLZoQJJSLDquqEGCn66JzhtFo+UsRlYMQUrh+1X+FBzo2TLmX0Ag4Gd2z97RoSaIPYbAcWPFX7nX0pCcPvoImaCXDH9hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dXVPMuQY; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-567fb8be044so604837e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 03:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757413596; x=1758018396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFqaqhtG5wCIiVa2BTrN+ftZjPVISTQRT/cZc7Siw0s=;
        b=dXVPMuQYCzdvVf/1b/qdeViWziTuKKEepwJZawLc2ShG4lwLHR9xOO7+5ChlYMiTxZ
         C2a5w4z/Ow1YnS+Z1DdyZu8adXMIfsU010Ai0aBQ9PUf9lSP9I3pme34WoFWBjKeZQZE
         5A++NlCEjPXm1OQw8LwiJDtyvrjc14nVvWLs91Pmp/J9aFq3vkih6N6Pf6Esg6pL11V9
         xbJJeAc5ErfEZDvxTnYkxtN6ezaUFzanMsIGiLLze//bkJNygBMzDqJ+W8saRqGCG7vV
         g6nm3TqhGHqyuD7JcyAPODloE2/qkYf1X8eVdckXMLrcc8W6p1iUangNYqiRkIpjo2k3
         GKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757413596; x=1758018396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uFqaqhtG5wCIiVa2BTrN+ftZjPVISTQRT/cZc7Siw0s=;
        b=ii2hPjOINg4X/BLLWx89zTgqvy/Tvn6GRtzv81Qiqvuzc5ET7/Q60SCJDF2SgVhLIM
         REsy51IhVZLibN7+7L9JJesGqKfk61EVEoSMI8lwpA62ExGAB5U+UTTGAwdCAHuLzk92
         4x/kDKrvt+HoUT1m4JrZaCieqD6ea8JxD+fWB3LdJsRuIbcCpIiauYa0fRgIJ/UMLCU9
         E8h9bhaHYgLwafPGBXAsXbfEaf7uuuaY5xGAxD49hjW5124whmGIqiknCZQ3ZSP8Bxuf
         cduKxi1Cz40geIn6o8DyymSL2FxcEYFVVGKnw+PzJJT5KM+uT8cw3mPGQzKZE1uQi4lW
         I9cg==
X-Gm-Message-State: AOJu0Yy+RR9BMjs81YMLpOY2LAsLen9dMRSF/FuEbJ0UmNsbpdH3Sh8G
	FcPzgJJ103s/oBEBNx6T5piDHjg9gzbJI9f2MlEkyHm2lfoV2R5xvv5FjYXV27JgpAJcBTODric
	1SJ1nuf5tfP5GUkexWtgns3Y6qZcoLmLmIXDzSNv0GSAthgNYILor
X-Gm-Gg: ASbGnctnDAUq7jdT5uh2v+4/sjfRkq4DpdOegll5e0bCprdiW020jWANu0BrmDZMesW
	oqvDCRElX7gwcSy185v9Vf8j3L1X11zxY8t2pmz8lMbiPyTGnkpyvDR3dpi7zPsvN/4dAoQXihB
	HxpOyxhiAcHZD1TFHtei6gooXL3mO7Ffqw6b/O/EANVRihSqTVGy1HdfbYVXeU7p1IQLBkQzmhm
	BsUk/rkyyxzMG7f7hFJt/dP9Y6UNhwaW0iEI5gg6NoLLVKQzDxQrj995NDaUw==
X-Google-Smtp-Source: AGHT+IEIlgP6WJ+l/2b+hOt1ThB2keF29D4lVkLENQbI3An4Y5kJhCuJdkyEWlD4semvJCVerqpc6HGzOCIXOONPLa4=
X-Received: by 2002:a05:6512:3089:b0:55f:6cd0:296b with SMTP id
 2adb3069b0e04-562636d5bfamr3429517e87.49.1757413595663; Tue, 09 Sep 2025
 03:26:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905085436.95863-1-marco.crivellari@suse.com> <aLsSnKz1WcYSwReG@slm.duckdns.org>
In-Reply-To: <aLsSnKz1WcYSwReG@slm.duckdns.org>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 9 Sep 2025 12:26:24 +0200
X-Gm-Features: Ac12FXwauGyHosDpZYps4rTVqW4xzZiNW4zO0M9zKSVMbGv_zoWndkzkbB081o8
Message-ID: <CAAofZF4-1KypKg_ix642beh-GweMkEiRndrS3mifnUHZG7T0UQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] cgroup: replace wq users and add WQ_PERCPU to
 alloc_workqueue() users
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 6:41=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> On Fri, Sep 05, 2025 at 10:54:34AM +0200, Marco Crivellari wrote:
> ...
> > Marco Crivellari (2):
> >   cgroup: replace use of system_wq with system_percpu_wq
> >   cgroup: WQ_PERCPU added to alloc_workqueue users
>
> Applied to cgroup/for-6.18 with dup para removed from the description of =
the
> second patch.

Thank you!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

marco.crivellari@suse.com

